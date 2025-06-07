# FROM cgr.dev/chainguard/python

# WORKDIR /app
# COPY requirements.txt .
# COPY app.py .
# COPY templates templates/
# COPY static static/

# RUN pip install --no-cache-dir -r requirements.txt

# EXPOSE 5000

# CMD ["flask", "run", "--host=0.0.0.0"]

FROM cgr.dev/chainguard/python:latest-dev AS dev
WORKDIR /app
RUN python -m venv venv
ENV PATH="/app/venv/bin:$PATH"
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

FROM cgr.dev/chainguard/python:latest
WORKDIR /app
ENV REDIS_HOST=192.168.86.224
COPY --from=dev /app/venv /app/venv
COPY app.py .
COPY templates templates/
COPY static static/
ENV PATH="/app/venv/bin:$PATH"
ENTRYPOINT ["flask", "run", "--host=0.0.0.0"]