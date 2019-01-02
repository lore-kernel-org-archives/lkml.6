Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1752FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA84B218FC
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbfABRMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 12:12:47 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60436 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbfABRMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 12:12:46 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 82F6C27967A
Message-ID: <a54bedcebb589584a238e52c342dffe0cb80b41a.camel@collabora.com>
Subject: Re: [PATCH 05/10] drm/virtio: use struct to pass params to
 virtio_gpu_object_create()
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Date:   Wed, 02 Jan 2019 14:12:37 -0300
In-Reply-To: <20181219122708.4586-6-kraxel@redhat.com>
References: <20181219122708.4586-1-kraxel@redhat.com>
         <20181219122708.4586-6-kraxel@redhat.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-19 at 13:27 +0100, Gerd Hoffmann wrote:
> Create virtio_gpu_object_params, use that to pass object parameters to
> virtio_gpu_object_create.  Also drop unused "kernel" parameter (unused,
> always false).
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h    | 15 ++++++++++-----
>  drivers/gpu/drm/virtio/virtgpu_gem.c    | 18 +++++++++++-------
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c  | 12 +++++++-----
>  drivers/gpu/drm/virtio/virtgpu_object.c | 22 +++++++++-------------
>  4 files changed, 37 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index bfb31fc3d0..8cff8a3f7c 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -53,6 +53,11 @@
>  /* virtgpu_drm_bus.c */
>  int drm_virtio_init(struct drm_driver *driver, struct virtio_device *vdev);
>  
> +struct virtio_gpu_object_params {
> +	unsigned long size;
> +	bool pinned;
> +};
> +
>  struct virtio_gpu_object {
>  	struct drm_gem_object gem_base;
>  	uint32_t hw_res_handle;
> @@ -220,16 +225,16 @@ int virtio_gpu_gem_init(struct virtio_gpu_device *vgdev);
>  void virtio_gpu_gem_fini(struct virtio_gpu_device *vgdev);
>  int virtio_gpu_gem_create(struct drm_file *file,
>  			  struct drm_device *dev,
> -			  uint64_t size,
> +			  struct virtio_gpu_object_params *params,
>  			  struct drm_gem_object **obj_p,
>  			  uint32_t *handle_p);
>  int virtio_gpu_gem_object_open(struct drm_gem_object *obj,
>  			       struct drm_file *file);
>  void virtio_gpu_gem_object_close(struct drm_gem_object *obj,
>  				 struct drm_file *file);
> -struct virtio_gpu_object *virtio_gpu_alloc_object(struct drm_device *dev,
> -						  size_t size, bool kernel,
> -						  bool pinned);
> +struct virtio_gpu_object*
> +virtio_gpu_alloc_object(struct drm_device *dev,
> +			struct virtio_gpu_object_params *params);
>  int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
>  				struct drm_device *dev,
>  				struct drm_mode_create_dumb *args);
> @@ -345,7 +350,7 @@ void virtio_gpu_fence_event_process(struct virtio_gpu_device *vdev,
>  
>  /* virtio_gpu_object */
>  int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
> -			     unsigned long size, bool kernel, bool pinned,
> +			     struct virtio_gpu_object_params *params,
>  			     struct virtio_gpu_object **bo_ptr);
>  void virtio_gpu_object_kunmap(struct virtio_gpu_object *bo);
>  int virtio_gpu_object_kmap(struct virtio_gpu_object *bo);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
> index f065863939..384cd80bf3 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> @@ -34,15 +34,15 @@ void virtio_gpu_gem_free_object(struct drm_gem_object *gem_obj)
>  		virtio_gpu_object_unref(&obj);
>  }
>  
> -struct virtio_gpu_object *virtio_gpu_alloc_object(struct drm_device *dev,
> -						  size_t size, bool kernel,
> -						  bool pinned)
> +struct virtio_gpu_object*
> +virtio_gpu_alloc_object(struct drm_device *dev,
> +			struct virtio_gpu_object_params *params)
>  {
>  	struct virtio_gpu_device *vgdev = dev->dev_private;
>  	struct virtio_gpu_object *obj;
>  	int ret;
>  
> -	ret = virtio_gpu_object_create(vgdev, size, kernel, pinned, &obj);
> +	ret = virtio_gpu_object_create(vgdev, params, &obj);
>  	if (ret)
>  		return ERR_PTR(ret);
>  
> @@ -51,7 +51,7 @@ struct virtio_gpu_object *virtio_gpu_alloc_object(struct drm_device *dev,
>  
>  int virtio_gpu_gem_create(struct drm_file *file,
>  			  struct drm_device *dev,
> -			  uint64_t size,
> +			  struct virtio_gpu_object_params *params,
>  			  struct drm_gem_object **obj_p,
>  			  uint32_t *handle_p)
>  {
> @@ -59,7 +59,7 @@ int virtio_gpu_gem_create(struct drm_file *file,
>  	int ret;
>  	u32 handle;
>  
> -	obj = virtio_gpu_alloc_object(dev, size, false, false);
> +	obj = virtio_gpu_alloc_object(dev, params);
>  	if (IS_ERR(obj))
>  		return PTR_ERR(obj);
>  
> @@ -85,6 +85,9 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
>  	struct virtio_gpu_device *vgdev = dev->dev_private;
>  	struct drm_gem_object *gobj;
>  	struct virtio_gpu_object *obj;
> +	struct virtio_gpu_object_params params = {
> +		.pinned = false,
> +	};

Nit: I think it's more readable to set all the fields
of the params struct in the same place...

>  	int ret;
>  	uint32_t pitch;
>  	uint32_t format;
> @@ -96,7 +99,8 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
>  	args->size = pitch * args->height;
>  	args->size = ALIGN(args->size, PAGE_SIZE);
>  
> -	ret = virtio_gpu_gem_create(file_priv, dev, args->size, &gobj,

... i.e. here.

> +	params.size = args->size;
> +	ret = virtio_gpu_gem_create(file_priv, dev, &params, &gobj,
>  				    &args->handle);
>  	if (ret)
>  		goto fail;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 14ce8188c0..65b4a54f10 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -279,12 +279,14 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
>  	struct virtio_gpu_object *qobj;
>  	struct drm_gem_object *obj;
>  	uint32_t handle = 0;
> -	uint32_t size;
>  	struct list_head validate_list;
>  	struct ttm_validate_buffer mainbuf;
>  	struct virtio_gpu_fence *fence = NULL;
>  	struct ww_acquire_ctx ticket;
>  	struct virtio_gpu_resource_create_3d rc_3d;
> +	struct virtio_gpu_object_params params = {
> +		.pinned = false,
> +	};
>  
>  	if (vgdev->has_virgl_3d == false) {
>  		if (rc->depth > 1)
> @@ -302,13 +304,13 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
>  	INIT_LIST_HEAD(&validate_list);
>  	memset(&mainbuf, 0, sizeof(struct ttm_validate_buffer));
>  
> -	size = rc->size;
> +	params.size = rc->size;
>  
>  	/* allocate a single page size object */
> -	if (size == 0)
> -		size = PAGE_SIZE;
> +	if (params.size == 0)
> +		params.size = PAGE_SIZE;
>  
> -	qobj = virtio_gpu_alloc_object(dev, size, false, false);
> +	qobj = virtio_gpu_alloc_object(dev, &params);
>  	if (IS_ERR(qobj))
>  		return PTR_ERR(qobj);
>  	obj = &qobj->gem_base;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index f39a183d59..62367e3f80 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -79,21 +79,16 @@ static void virtio_gpu_init_ttm_placement(struct virtio_gpu_object *vgbo,
>  }
>  
>  int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
> -			     unsigned long size, bool kernel, bool pinned,
> +			     struct virtio_gpu_object_params *params,
>  			     struct virtio_gpu_object **bo_ptr)
>  {
>  	struct virtio_gpu_object *bo;
> -	enum ttm_bo_type type;
>  	size_t acc_size;
>  	int ret;
>  
> -	if (kernel)
> -		type = ttm_bo_type_kernel;
> -	else
> -		type = ttm_bo_type_device;
>  	*bo_ptr = NULL;
>  
> -	acc_size = ttm_bo_dma_acc_size(&vgdev->mman.bdev, size,
> +	acc_size = ttm_bo_dma_acc_size(&vgdev->mman.bdev, params->size,
>  				       sizeof(struct virtio_gpu_object));
>  
>  	bo = kzalloc(sizeof(struct virtio_gpu_object), GFP_KERNEL);
> @@ -104,19 +99,20 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>  		kfree(bo);
>  		return ret;
>  	}
> -	size = roundup(size, PAGE_SIZE);
> -	ret = drm_gem_object_init(vgdev->ddev, &bo->gem_base, size);
> +	params->size = roundup(params->size, PAGE_SIZE);
> +	ret = drm_gem_object_init(vgdev->ddev, &bo->gem_base, params->size);
>  	if (ret != 0) {
>  		virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
>  		kfree(bo);
>  		return ret;
>  	}
>  	bo->dumb = false;
> -	virtio_gpu_init_ttm_placement(bo, pinned);
> +	virtio_gpu_init_ttm_placement(bo, params->pinned);
>  
> -	ret = ttm_bo_init(&vgdev->mman.bdev, &bo->tbo, size, type,
> -			  &bo->placement, 0, !kernel, acc_size,
> -			  NULL, NULL, &virtio_gpu_ttm_bo_destroy);
> +	ret = ttm_bo_init(&vgdev->mman.bdev, &bo->tbo, params->size,
> +			  ttm_bo_type_device, &bo->placement, 0,
> +			  true, acc_size, NULL, NULL,
> +			  &virtio_gpu_ttm_bo_destroy);
>  	/* ttm_bo_init failure will call the destroy */
>  	if (ret != 0)
>  		return ret;


