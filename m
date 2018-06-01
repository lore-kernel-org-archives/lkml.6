Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbeFAM62 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 08:58:28 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41885 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbeFAM6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 08:58:21 -0400
X-Google-Smtp-Source: ADUXVKLSUbnZ/EIa3S9LdarfdFb/oEiHNPyUI2LpEHh52PRxGru8jFlJplPMb8hM78yeUW+8aSBiPFwKy26SkBRLzRI=
MIME-Version: 1.0
In-Reply-To: <20180531161708.5894-3-michel@daenzer.net>
References: <20180531161708.5894-1-michel@daenzer.net> <20180531161708.5894-3-michel@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 1 Jun 2018 08:58:19 -0400
Message-ID: <CADnq5_O5-m_=xqszq41eOAVaLTytHUHmtDaSc1MeEorZML6T5g@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Add documentation for PRIME related code
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w51CwwPD003677

On Thu, May 31, 2018 at 12:17 PM, Michel Dänzer <michel@daenzer.net> wrote:
> From: Michel Dänzer <michel.daenzer@amd.com>
>
> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  Documentation/gpu/amdgpu.rst              |  14 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c | 119 ++++++++++++++++++++++
>  2 files changed, 133 insertions(+)
>
> diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
> index 41a14e4aa4ac..f557866f6788 100644
> --- a/Documentation/gpu/amdgpu.rst
> +++ b/Documentation/gpu/amdgpu.rst
> @@ -4,3 +4,17 @@
>
>  The drm/amdgpu driver supports all AMD Radeon GPUs based on the Graphics Core
>  Next (GCN) architecture.
> +
> +Core Driver Infrastructure
> +==========================
> +
> +This section covers core driver infrastructure.
> +
> +PRIME Buffer Sharing
> +--------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> +   :doc: PRIME Buffer Sharing
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> +   :internal:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> index 4683626b065f..d1f05489595b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> @@ -23,6 +23,14 @@
>   *
>   * Authors: Alex Deucher
>   */
> +
> +/**
> + * DOC: PRIME Buffer Sharing
> + *
> + * The following callback implementations are used for :ref:`sharing GEM buffer
> + * objects between different devices via PRIME <prime_buffer_sharing>`.
> + */
> +
>  #include <drm/drmP.h>
>
>  #include "amdgpu.h"
> @@ -32,6 +40,14 @@
>
>  static const struct dma_buf_ops amdgpu_dmabuf_ops;
>
> +/**
> + * amdgpu_gem_prime_get_sg_table - &drm_driver.gem_prime_get_sg_table
> + * implementation
> + * @obj: GEM buffer object
> + *
> + * Returns:
> + * A scatter/gather table for the pinned pages of the buffer object's memory.
> + */
>  struct sg_table *amdgpu_gem_prime_get_sg_table(struct drm_gem_object *obj)
>  {
>         struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
> @@ -40,6 +56,15 @@ struct sg_table *amdgpu_gem_prime_get_sg_table(struct drm_gem_object *obj)
>         return drm_prime_pages_to_sg(bo->tbo.ttm->pages, npages);
>  }
>
> +/**
> + * amdgpu_gem_prime_vmap - &dma_buf_ops.vmap implementation
> + * @obj: GEM buffer object
> + *
> + * Sets up an in-kernel virtual mapping of the buffer object's memory.
> + *
> + * Returns:
> + * The virtual address of the mapping or an error pointer.
> + */
>  void *amdgpu_gem_prime_vmap(struct drm_gem_object *obj)
>  {
>         struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
> @@ -53,6 +78,13 @@ void *amdgpu_gem_prime_vmap(struct drm_gem_object *obj)
>         return bo->dma_buf_vmap.virtual;
>  }
>
> +/**
> + * amdgpu_gem_prime_vunmap - &dma_buf_ops.vunmap implementation
> + * @obj: GEM buffer object
> + * @vaddr: virtual address (unused)
> + *
> + * Tears down the in-kernel virtual mapping of the buffer object's memory.
> + */
>  void amdgpu_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
>  {
>         struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
> @@ -60,6 +92,17 @@ void amdgpu_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
>         ttm_bo_kunmap(&bo->dma_buf_vmap);
>  }
>
> +/**
> + * amdgpu_gem_prime_mmap - &drm_driver.gem_prime_mmap implementation
> + * @obj: GEM buffer object
> + * @vma: virtual memory area
> + *
> + * Sets up a userspace mapping of the buffer object's memory in the given
> + * virtual memory area.
> + *
> + * Returns:
> + * 0 on success or negative error code.
> + */
>  int amdgpu_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
>  {
>         struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
> @@ -94,6 +137,19 @@ int amdgpu_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma
>         return ret;
>  }
>
> +/**
> + * amdgpu_gem_prime_import_sg_table - &drm_driver.gem_prime_import_sg_table
> + * implementation
> + * @dev: DRM device
> + * @attach: DMA-buf attachment
> + * @sg: Scatter/gather table
> + *
> + * Import shared DMA buffer memory exported by another device.
> + *
> + * Returns:
> + * A new GEM buffer object of the given DRM device, representing the memory
> + * described by the given DMA-buf attachment and scatter/gather table.
> + */
>  struct drm_gem_object *
>  amdgpu_gem_prime_import_sg_table(struct drm_device *dev,
>                                  struct dma_buf_attachment *attach,
> @@ -132,6 +188,19 @@ amdgpu_gem_prime_import_sg_table(struct drm_device *dev,
>         return ERR_PTR(ret);
>  }
>
> +/**
> + * amdgpu_gem_map_attach - &dma_buf_ops.attach implementation
> + * @dma_buf: shared DMA buffer
> + * @target_dev: target device
> + * @attach: DMA-buf attachment
> + *
> + * Makes sure that the shared DMA buffer can be accessed by the target device.
> + * For now, simply pins it to the GTT domain, where it should be accessible by
> + * all DMA devices.
> + *
> + * Returns:
> + * 0 on success or negative error code.
> + */
>  static int amdgpu_gem_map_attach(struct dma_buf *dma_buf,
>                                  struct device *target_dev,
>                                  struct dma_buf_attachment *attach)
> @@ -181,6 +250,14 @@ static int amdgpu_gem_map_attach(struct dma_buf *dma_buf,
>         return r;
>  }
>
> +/**
> + * amdgpu_gem_map_detach - &dma_buf_ops.detach implementation
> + * @dma_buf: shared DMA buffer
> + * @attach: DMA-buf attachment
> + *
> + * This is called when a shared DMA buffer no longer needs to be accessible by
> + * the other device. For now, simply unpins the buffer from GTT.
> + */
>  static void amdgpu_gem_map_detach(struct dma_buf *dma_buf,
>                                   struct dma_buf_attachment *attach)
>  {
> @@ -202,6 +279,13 @@ static void amdgpu_gem_map_detach(struct dma_buf *dma_buf,
>         drm_gem_map_detach(dma_buf, attach);
>  }
>
> +/**
> + * amdgpu_gem_prime_res_obj - &drm_driver.gem_prime_res_obj implementation
> + * @obj: GEM buffer object
> + *
> + * Returns:
> + * The buffer object's reservation object.
> + */
>  struct reservation_object *amdgpu_gem_prime_res_obj(struct drm_gem_object *obj)
>  {
>         struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
> @@ -209,6 +293,18 @@ struct reservation_object *amdgpu_gem_prime_res_obj(struct drm_gem_object *obj)
>         return bo->tbo.resv;
>  }
>
> +/**
> + * amdgpu_gem_begin_cpu_access - &dma_buf_ops.begin_cpu_access implementation
> + * @dma_buf: shared DMA buffer
> + * @direction: direction of DMA transfer
> + *
> + * This is called before CPU access to the shared DMA buffer's memory. If it's
> + * a read access, the buffer is moved to the GTT domain if possible, for optimal
> + * CPU read performance.
> + *
> + * Returns:
> + * 0 on success or negative error code.
> + */
>  static int amdgpu_gem_begin_cpu_access(struct dma_buf *dma_buf,
>                                        enum dma_data_direction direction)
>  {
> @@ -253,6 +349,18 @@ static const struct dma_buf_ops amdgpu_dmabuf_ops = {
>         .vunmap = drm_gem_dmabuf_vunmap,
>  };
>
> +/**
> + * amdgpu_gem_prime_export - &drm_driver.gem_prime_export implementation
> + * @dev: DRM device
> + * @gobj: GEM buffer object
> + * @flags: flags like DRM_CLOEXEC and DRM_RDWR
> + *
> + * The main work is done by the &drm_gem_prime_export helper, which in turn
> + * uses &amdgpu_gem_prime_res_obj.
> + *
> + * Returns:
> + * Shared DMA buffer representing the GEM buffer object from the given device.
> + */
>  struct dma_buf *amdgpu_gem_prime_export(struct drm_device *dev,
>                                         struct drm_gem_object *gobj,
>                                         int flags)
> @@ -273,6 +381,17 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_device *dev,
>         return buf;
>  }
>
> +/**
> + * amdgpu_gem_prime_import - &drm_driver.gem_prime_import implementation
> + * @dev: DRM device
> + * @dma_buf: Shared DMA buffer
> + *
> + * The main work is done by the &drm_gem_prime_import helper, which in turn
> + * uses &amdgpu_gem_prime_import_sg_table.
> + *
> + * Returns:
> + * GEM buffer object representing the shared DMA buffer for the given device.
> + */
>  struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
>                                             struct dma_buf *dma_buf)
>  {
> --
> 2.17.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
