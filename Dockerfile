# Sử dụng image Python chính thức
FROM python:3.9-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    libjpeg-dev \
    zlib1g-dev \
    libxml2-dev \
    libxslt1-dev \
    && rm -rf /var/lib/apt/lists/*
# Đặt thư mục làm việc trong container
WORKDIR /app

# Copy file requirements vào container
COPY requirements.txt .
COPY requirements/ ./requirements/

ENV DJANGO_SETTINGS_MODULE=config.settings

# Cài đặt các thư viện cần thiết
RUN pip install -r requirements.txt

# Copy toàn bộ code vào container
COPY . .

# Mở cổng (nếu là Django)
EXPOSE 8000

# Lệnh chạy khi container khởi động
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
