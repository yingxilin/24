FROM nvcr.io/nvidia/pytorch:24.08-py3

# System deps
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git wget zip unzip && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# Copy repo
COPY . /workspace

# Pin compatible PyTorch stack (already provided by base image, ensure matching pip packages)
RUN pip install --no-cache-dir \
    torch==2.8.0 torchvision==0.23.0 torchaudio==2.8.0

# Core Python deps (avoid heavy compiles)
RUN pip install --no-cache-dir \
    numpy==1.26.4 pillow==10.4.0 matplotlib==3.9.2 pyyaml tqdm \
    tables==3.10.2 pyarrow==20.0.0 torchmetrics==1.7.1 \
    opencv-python albumentations pandas==2.2.2 timm==1.0.7 \
    transformers==4.51.3 open_clip_torch==2.32.0 faiss-cpu==1.10.0

# Third-party research repos
RUN pip install --no-cache-dir \
    git+https://github.com/facebookresearch/segment-anything.git \
    git+https://github.com/IDEA-Research/GroundingDINO.git \
    https://github.com/BohemianVRA/FGVC/releases/download/v1.5.4-dev/fgvc-1.5.4.dev0-py3-none-any.whl

# Default workdir for running segmentation
WORKDIR /workspace/FungiTastic/baselines/segmentation

# Helpful default command
CMD ["bash"]

