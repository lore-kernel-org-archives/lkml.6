Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BA8C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3FCF218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="TF3X+BuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfAaKkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:40:06 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:36172 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfAaKkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=xBaShssdPGiebaJoCXp+Czm/bOQOJmXRHyFiCqWHplM=;
        b=TF3X+BuXOr1AMW5ulo12iYxYNquABa3DQ4jJvdofMfmOFaHSujoyFtJc+0A3iXiGGOfclBVgjcWDFBDm/TF0V6fw+hYUJSZPiadPysDI++VPbVEZ1fVM9TyrpOcs2tI0KpWpMMoOgxeb2SA3pmDsI2TCIu06CsyS6azup1fvq3dXGxiKCfD0XrlI0GImkTWrguXLZmX8tMStDX1sz39C0DsZV8PIrU5frig5LoQQVADC+6+ZxvzqQSMHvqhqjvjV9p45PSgxU07leM5PFWFYr+ZEZ21Yh8dDffhCA0fM7r3gpOvga15tcd7cuEN1OBS58soANNOW9EmvXdEHU2nTrg==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:52612 helo=[192.168.10.176])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1gp9lK-0002jK-Am; Thu, 31 Jan 2019 11:40:02 +0100
Subject: Re: [PATCH v2 2/6] drm/virtio: use struct to pass params to
 virtio_gpu_object_create()
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
References: <20190130094338.14203-1-kraxel@redhat.com>
 <20190130094338.14203-3-kraxel@redhat.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <46c0feb8-3a0d-eeac-180c-cb0f3147fe11@tronnes.org>
Date:   Thu, 31 Jan 2019 11:40:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190130094338.14203-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 30.01.2019 10.43, skrev Gerd Hoffmann:
> Create virtio_gpu_object_params, use that to pass object parameters to
> virtio_gpu_object_create.  This is just the first step, followup patches
> will add more parameters to the struct.  The plan is to use the struct
> for all object parameters.
> 
> Also drop unused "kernel" parameter for virtio_gpu_alloc_object(), it is
> unused and always false.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h    | 15 ++++++++++-----
>  drivers/gpu/drm/virtio/virtgpu_gem.c    | 17 ++++++++++-------
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c  | 11 ++++++-----
>  drivers/gpu/drm/virtio/virtgpu_object.c | 22 +++++++++-------------
>  4 files changed, 35 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index d577cb76f5..40928980a2 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -50,6 +50,11 @@
>  #define DRIVER_MINOR 1
>  #define DRIVER_PATCHLEVEL 0
>  
> +struct virtio_gpu_object_params {
> +	unsigned long size;
> +	bool pinned;
> +};
> +
>  struct virtio_gpu_object {
>  	struct drm_gem_object gem_base;
>  	uint32_t hw_res_handle;
> @@ -217,16 +222,16 @@ int virtio_gpu_gem_init(struct virtio_gpu_device *vgdev);
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
> @@ -342,7 +347,7 @@ void virtio_gpu_fence_event_process(struct virtio_gpu_device *vdev,
>  
>  /* virtio_gpu_object */
>  int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
> -			     unsigned long size, bool kernel, bool pinned,
> +			     struct virtio_gpu_object_params *params,
>  			     struct virtio_gpu_object **bo_ptr);
>  void virtio_gpu_object_kunmap(struct virtio_gpu_object *bo);
>  int virtio_gpu_object_kmap(struct virtio_gpu_object *bo);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
> index f065863939..b5f2d94ce5 100644
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
> @@ -85,6 +85,7 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
>  	struct virtio_gpu_device *vgdev = dev->dev_private;
>  	struct drm_gem_object *gobj;
>  	struct virtio_gpu_object *obj;
> +	struct virtio_gpu_object_params params = { 0 };
>  	int ret;
>  	uint32_t pitch;
>  	uint32_t format;
> @@ -96,7 +97,9 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
>  	args->size = pitch * args->height;
>  	args->size = ALIGN(args->size, PAGE_SIZE);
>  
> -	ret = virtio_gpu_gem_create(file_priv, dev, args->size, &gobj,
> +	params.pinned = false,

You have a comma here, but assigning to false isn't really necessary
since the struct is zeroed. Same goes for the same assignment further down.

With this fixed in some way:

Acked-by: Noralf Trønnes <noralf@tronnes.org>

> +	params.size = args->size;
> +	ret = virtio_gpu_gem_create(file_priv, dev, &params, &gobj,
>  				    &args->handle);
>  	if (ret)
>  		goto fail;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 14ce8188c0..fa7b958ca2 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -279,12 +279,12 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
>  	struct virtio_gpu_object *qobj;
>  	struct drm_gem_object *obj;
>  	uint32_t handle = 0;
> -	uint32_t size;
>  	struct list_head validate_list;
>  	struct ttm_validate_buffer mainbuf;
>  	struct virtio_gpu_fence *fence = NULL;
>  	struct ww_acquire_ctx ticket;
>  	struct virtio_gpu_resource_create_3d rc_3d;
> +	struct virtio_gpu_object_params params = { 0 };
>  
>  	if (vgdev->has_virgl_3d == false) {
>  		if (rc->depth > 1)
> @@ -302,13 +302,14 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
>  	INIT_LIST_HEAD(&validate_list);
>  	memset(&mainbuf, 0, sizeof(struct ttm_validate_buffer));
>  
> -	size = rc->size;
> +	params.pinned = false,
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
> 
