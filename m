Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934205AbeEWTBF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 15:01:05 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:42398 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934071AbeEWTBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 15:01:01 -0400
X-Google-Smtp-Source: AB8JxZpK+NYIpRrxPIGqUxk6pM/e3vdMVAnz8nU2VhB0p04wSc2WwhcmRVEk0mWUdL6jSyNMUUNlhw==
Subject: Re: [PATCH] dma-buf: simplified calling conventions for dma_buf_fd()
To: Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Gustavo Padovan <gustavo@padovan.org>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
References: <20180522080925.18158-1-jens.wiklander@linaro.org>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <c7d2370d-2705-9005-0642-6be85964d7f9@redhat.com>
Date: Wed, 23 May 2018 12:00:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180522080925.18158-1-jens.wiklander@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/2018 01:09 AM, Jens Wiklander wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Make dma_buf_fd() drop the file reference on failure, folding
> dma_buf_put() into it.
> 
> Users of dma_buf_fd() (drm, videobuf2, ion and tee) are updated to take
> the new calling convention into account.
> 

For the Ion portion,

Acked-by: Laura Abbott <labbott@redhat.com>

> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> [jw: rebased and updated commit message]
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
> 
> I received this patch as a response to what has become
> bb765d1c331f ("tee: shm: fix use-after-free via temporarily dropped reference")
> 
>   drivers/dma-buf/dma-buf.c                     | 16 +++++----
>   drivers/gpu/drm/drm_prime.c                   | 15 +++-----
>   drivers/gpu/drm/i915/gvt/dmabuf.c             |  4 +--
>   drivers/gpu/drm/ttm/ttm_object.c              |  3 +-
>   .../media/common/videobuf2/videobuf2-core.c   | 14 ++++----
>   drivers/staging/android/ion/ion.c             |  7 +---
>   drivers/tee/tee_core.c                        | 35 ++++++-------------
>   drivers/tee/tee_shm.c                         |  8 +----
>   8 files changed, 36 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index d78d5fc173dc..78981928758e 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -471,17 +471,21 @@ EXPORT_SYMBOL_GPL(dma_buf_export);
>    */
>   int dma_buf_fd(struct dma_buf *dmabuf, int flags)
>   {
> +	struct file *file;
>   	int fd;
>   
> -	if (!dmabuf || !dmabuf->file)
> +	if (!dmabuf)
>   		return -EINVAL;
>   
> -	fd = get_unused_fd_flags(flags);
> -	if (fd < 0)
> -		return fd;
> -
> -	fd_install(fd, dmabuf->file);
> +	file = dmabuf->file;
> +	if (!file)
> +		return -EINVAL;
>   
> +	fd = get_unused_fd_flags(flags);
> +	if (fd >= 0)
> +		fd_install(fd, file);
> +	else
> +		fput(file);
>   	return fd;
>   }
>   EXPORT_SYMBOL_GPL(dma_buf_fd);
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 7856a9b3f8a8..06d1b7d3751a 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -662,8 +662,10 @@ int drm_gem_prime_handle_to_fd(struct drm_device *dev,
>   	ret = drm_prime_add_buf_handle(&file_priv->prime,
>   				       dmabuf, handle);
>   	mutex_unlock(&dev->object_name_lock);
> -	if (ret)
> -		goto fail_put_dmabuf;
> +	if (unlikely(ret)) {
> +		dma_buf_put(dmabuf);
> +		goto out;
> +	}
>   
>   out_have_handle:
>   	ret = dma_buf_fd(dmabuf, flags);
> @@ -673,17 +675,10 @@ int drm_gem_prime_handle_to_fd(struct drm_device *dev,
>   	 * and that is invariant as long as a userspace gem handle exists.
>   	 * Closing the handle will clean out the cache anyway, so we don't leak.
>   	 */
> -	if (ret < 0) {
> -		goto fail_put_dmabuf;
> -	} else {
> +	if (ret >= 0) {
>   		*prime_fd = ret;
>   		ret = 0;
>   	}
> -
> -	goto out;
> -
> -fail_put_dmabuf:
> -	dma_buf_put(dmabuf);
>   out:
>   	drm_gem_object_put_unlocked(obj);
>   out_unlock:
> diff --git a/drivers/gpu/drm/i915/gvt/dmabuf.c b/drivers/gpu/drm/i915/gvt/dmabuf.c
> index 6f4f8e941fc2..1783c724d96c 100644
> --- a/drivers/gpu/drm/i915/gvt/dmabuf.c
> +++ b/drivers/gpu/drm/i915/gvt/dmabuf.c
> @@ -479,7 +479,7 @@ int intel_vgpu_get_dmabuf(struct intel_vgpu *vgpu, unsigned int dmabuf_id)
>   	ret = dma_buf_fd(dmabuf, DRM_CLOEXEC | DRM_RDWR);
>   	if (ret < 0) {
>   		gvt_vgpu_err("create dma-buf fd failed ret:%d\n", ret);
> -		goto out_free_dmabuf;
> +		goto out_free_gem;
>   	}
>   	dmabuf_fd = ret;
>   
> @@ -502,8 +502,6 @@ int intel_vgpu_get_dmabuf(struct intel_vgpu *vgpu, unsigned int dmabuf_id)
>   
>   	return dmabuf_fd;
>   
> -out_free_dmabuf:
> -	dma_buf_put(dmabuf);
>   out_free_gem:
>   	i915_gem_object_put(obj);
>   out:
> diff --git a/drivers/gpu/drm/ttm/ttm_object.c b/drivers/gpu/drm/ttm/ttm_object.c
> index 1aa2baa83959..30d29d17653f 100644
> --- a/drivers/gpu/drm/ttm/ttm_object.c
> +++ b/drivers/gpu/drm/ttm/ttm_object.c
> @@ -730,8 +730,7 @@ int ttm_prime_handle_to_fd(struct ttm_object_file *tfile,
>   	if (ret >= 0) {
>   		*prime_fd = ret;
>   		ret = 0;
> -	} else
> -		dma_buf_put(dma_buf);
> +	}
>   
>   out_unref:
>   	if (base)
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index d3f7bb33a54d..3baf689241cc 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -1881,15 +1881,13 @@ int vb2_core_expbuf(struct vb2_queue *q, int *fd, unsigned int type,
>   	if (ret < 0) {
>   		dprintk(3, "buffer %d, plane %d failed to export (%d)\n",
>   			index, plane, ret);
> -		dma_buf_put(dbuf);
> -		return ret;
> +	} else {
> +		dprintk(3, "buffer %d, plane %d exported as %d descriptor\n",
> +			index, plane, ret);
> +		*fd = ret;
> +		ret = 0;
>   	}
> -
> -	dprintk(3, "buffer %d, plane %d exported as %d descriptor\n",
> -		index, plane, ret);
> -	*fd = ret;
> -
> -	return 0;
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(vb2_core_expbuf);
>   
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index e74db7902549..c9fcb2a2f518 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -381,7 +381,6 @@ int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
>   	struct ion_buffer *buffer = NULL;
>   	struct ion_heap *heap;
>   	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> -	int fd;
>   	struct dma_buf *dmabuf;
>   
>   	pr_debug("%s: len %zu heap_id_mask %u flags %x\n", __func__,
> @@ -425,11 +424,7 @@ int ion_alloc(size_t len, unsigned int heap_id_mask, unsigned int flags)
>   		return PTR_ERR(dmabuf);
>   	}
>   
> -	fd = dma_buf_fd(dmabuf, O_CLOEXEC);
> -	if (fd < 0)
> -		dma_buf_put(dmabuf);
> -
> -	return fd;
> +	return dma_buf_fd(dmabuf, O_CLOEXEC);
>   }
>   
>   int ion_query_heaps(struct ion_heap_query *query)
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index dd46b758852a..1cb54f6f3c6a 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -125,7 +125,6 @@ static int tee_ioctl_version(struct tee_context *ctx,
>   static int tee_ioctl_shm_alloc(struct tee_context *ctx,
>   			       struct tee_ioctl_shm_alloc_data __user *udata)
>   {
> -	long ret;
>   	struct tee_ioctl_shm_alloc_data data;
>   	struct tee_shm *shm;
>   
> @@ -144,25 +143,18 @@ static int tee_ioctl_shm_alloc(struct tee_context *ctx,
>   	data.flags = shm->flags;
>   	data.size = shm->size;
>   
> -	if (copy_to_user(udata, &data, sizeof(data)))
> -		ret = -EFAULT;
> -	else
> -		ret = tee_shm_get_fd(shm);
> +	if (unlikely(copy_to_user(udata, &data, sizeof(data)))) {
> +		tee_shm_put(shm);
> +		return -EFAULT;
> +	}
>   
> -	/*
> -	 * When user space closes the file descriptor the shared memory
> -	 * should be freed or if tee_shm_get_fd() failed then it will
> -	 * be freed immediately.
> -	 */
> -	tee_shm_put(shm);
> -	return ret;
> +	return tee_shm_get_fd(shm);
>   }
>   
>   static int
>   tee_ioctl_shm_register(struct tee_context *ctx,
>   		       struct tee_ioctl_shm_register_data __user *udata)
>   {
> -	long ret;
>   	struct tee_ioctl_shm_register_data data;
>   	struct tee_shm *shm;
>   
> @@ -182,17 +174,12 @@ tee_ioctl_shm_register(struct tee_context *ctx,
>   	data.flags = shm->flags;
>   	data.length = shm->size;
>   
> -	if (copy_to_user(udata, &data, sizeof(data)))
> -		ret = -EFAULT;
> -	else
> -		ret = tee_shm_get_fd(shm);
> -	/*
> -	 * When user space closes the file descriptor the shared memory
> -	 * should be freed or if tee_shm_get_fd() failed then it will
> -	 * be freed immediately.
> -	 */
> -	tee_shm_put(shm);
> -	return ret;
> +	if (unlikely(copy_to_user(udata, &data, sizeof(data)))) {
> +		tee_shm_put(shm);
> +		return -EFAULT;
> +	}
> +
> +	return tee_shm_get_fd(shm);
>   }
>   
>   static int params_from_user(struct tee_context *ctx, struct tee_param *params,
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 07d3be6f0780..53b35b5e5776 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -355,16 +355,10 @@ EXPORT_SYMBOL_GPL(tee_shm_register);
>    */
>   int tee_shm_get_fd(struct tee_shm *shm)
>   {
> -	int fd;
> -
>   	if (!(shm->flags & TEE_SHM_DMA_BUF))
>   		return -EINVAL;
>   
> -	get_dma_buf(shm->dmabuf);
> -	fd = dma_buf_fd(shm->dmabuf, O_CLOEXEC);
> -	if (fd < 0)
> -		dma_buf_put(shm->dmabuf);
> -	return fd;
> +	return dma_buf_fd(shm->dmabuf, O_CLOEXEC);
>   }
>   
>   /**
> 
