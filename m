Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050BAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0E1208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MqSnMNFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0E1208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbeK0UI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:08:59 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35362 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729387AbeK0UI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:08:59 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so18354794edx.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 01:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=73L9x8W64q1JHq3Ag9E6sWigkMxf0CCKQzWAZTI4Q6E=;
        b=MqSnMNFPRTM2YdBb1W0cIiH3QWJ9cyvsqcY8ynbgvX/P4PKFGzAHYj6dONsWavTJdj
         Ssdqjfs1gGh0sW9M7KYjN+epuqvciUMel++xdm2re28Pyv2OPlfXb2vm0NdJXPabKOAG
         io9DVkKWwA2+hvQ3d1cyNlN1+YGQpjPfB+Hrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=73L9x8W64q1JHq3Ag9E6sWigkMxf0CCKQzWAZTI4Q6E=;
        b=Vp+/Tmyk7uVvBZvAD35T2jfHIu5wHY/9otIc3Z8sTN/P36SxwOJyzrgCYMn4r8hZo7
         QQXCE7ZPCfPDLA/tgqRvluG3ygJYPXxC/DR83UICf3/G35QuxC6RTDtosxbyA8nL9eiR
         Y/FNOGkW0HjHuaSehIhDwEFsto+oDc3/xI2UPFm2Pkm9H0JWkEiuhRx4g+gu621egyz+
         u0Yh/5XWfZpzaccBYD0ftZ9G9LgWRGtvTaLkZMlQ5Xx0Cqc6SsdIJ6PfgE5UrVcttqYp
         5c7JslqrIztmhHYM8Ta8LFHX2MuILWbi1iNmG5+JbTme54zsmv0OPvu1JeEZksY801GK
         1q/Q==
X-Gm-Message-State: AA+aEWYI4cBWwzKgeyjk9GOYsvsQ6s1pePyRLL3k+z7HF18O/WA3FshJ
        5Hin68IGmQYHZDuJi5aEeNFu8Q==
X-Google-Smtp-Source: AFSGD/U03vxPNTWCVgUZzWlTn7GnGvg6aZongW6YniBNGC3GNdKhPmvJPCewLYEb4EPYLQIuftl3sw==
X-Received: by 2002:a50:8343:: with SMTP id 61mr26329665edh.154.1543309902422;
        Tue, 27 Nov 2018 01:11:42 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w56sm856930edb.72.2018.11.27.01.11.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 01:11:41 -0800 (PST)
Date:   Tue, 27 Nov 2018 10:11:39 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/vkms: Add PRIME support by converting to
 Noralf's shmem helpers.
Message-ID: <20181127091139.GZ4266@phenom.ffwll.local>
Mail-Followup-To: Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20181126215929.20546-1-eric@anholt.net>
 <20181126215929.20546-2-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126215929.20546-2-eric@anholt.net>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 01:59:29PM -0800, Eric Anholt wrote:
> This cuts out a tremendous amount of boilerplate.  I've used the PRIME
> support now to test V3D rendering on a STB development board with no
> KMS driver.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
> 
> This patch depends on https://patchwork.freedesktop.org/series/27184/

Nice stuff. Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch> on both.
> 
>  drivers/gpu/drm/Kconfig           |   1 +
>  drivers/gpu/drm/vkms/vkms_crc.c   |  28 ++--
>  drivers/gpu/drm/vkms/vkms_drv.c   |  16 +--
>  drivers/gpu/drm/vkms/vkms_drv.h   |  22 ----
>  drivers/gpu/drm/vkms/vkms_gem.c   | 212 ++----------------------------
>  drivers/gpu/drm/vkms/vkms_plane.c |  17 ++-
>  6 files changed, 42 insertions(+), 254 deletions(-)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 0dedbc040c77..3bdd95f99feb 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -253,6 +253,7 @@ config DRM_VKMS
>  	tristate "Virtual KMS (EXPERIMENTAL)"
>  	depends on DRM
>  	select DRM_KMS_HELPER
> +	select DRM_GEM_SHMEM_HELPER
>  	default n
>  	help
>  	  Virtual Kernel Mode-Setting (VKMS) is used for testing or for
> diff --git a/drivers/gpu/drm/vkms/vkms_crc.c b/drivers/gpu/drm/vkms/vkms_crc.c
> index 9d9e8146db90..72d6422fb1a5 100644
> --- a/drivers/gpu/drm/vkms/vkms_crc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crc.c
> @@ -4,6 +4,7 @@
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_gem_shmem_helper.h>
>  
>  /**
>   * compute_crc - Compute CRC value on output frame
> @@ -91,21 +92,19 @@ static void compose_cursor(struct vkms_crc_data *cursor_crc,
>  			   struct vkms_crc_data *primary_crc, void *vaddr_out)
>  {
>  	struct drm_gem_object *cursor_obj;
> -	struct vkms_gem_object *cursor_vkms_obj;
> +	void *vaddr;
>  
>  	cursor_obj = drm_gem_fb_get_obj(&cursor_crc->fb, 0);
> -	cursor_vkms_obj = drm_gem_to_vkms_gem(cursor_obj);
> +	vaddr = drm_gem_shmem_vmap(cursor_obj);
>  
> -	mutex_lock(&cursor_vkms_obj->pages_lock);
> -	if (!cursor_vkms_obj->vaddr) {
> +	if (IS_ERR(vaddr)) {
>  		DRM_WARN("cursor plane vaddr is NULL");
> -		goto out;
> +		return;
>  	}
>  
> -	blend(vaddr_out, cursor_vkms_obj->vaddr, primary_crc, cursor_crc);
> +	blend(vaddr_out, vaddr, primary_crc, cursor_crc);
>  
> -out:
> -	mutex_unlock(&cursor_vkms_obj->pages_lock);
> +	drm_gem_shmem_vunmap(cursor_obj, vaddr);
>  }
>  
>  static uint32_t _vkms_get_crc(struct vkms_crc_data *primary_crc,
> @@ -113,8 +112,8 @@ static uint32_t _vkms_get_crc(struct vkms_crc_data *primary_crc,
>  {
>  	struct drm_framebuffer *fb = &primary_crc->fb;
>  	struct drm_gem_object *gem_obj = drm_gem_fb_get_obj(fb, 0);
> -	struct vkms_gem_object *vkms_obj = drm_gem_to_vkms_gem(gem_obj);
> -	void *vaddr_out = kzalloc(vkms_obj->gem.size, GFP_KERNEL);
> +	void *vaddr;
> +	void *vaddr_out = kzalloc(gem_obj->size, GFP_KERNEL);
>  	u32 crc = 0;
>  
>  	if (!vaddr_out) {
> @@ -122,21 +121,20 @@ static uint32_t _vkms_get_crc(struct vkms_crc_data *primary_crc,
>  		return 0;
>  	}
>  
> -	mutex_lock(&vkms_obj->pages_lock);
> -	if (WARN_ON(!vkms_obj->vaddr)) {
> -		mutex_unlock(&vkms_obj->pages_lock);
> +	vaddr = drm_gem_shmem_vmap(gem_obj);
> +	if (WARN_ON(IS_ERR(vaddr))) {
>  		kfree(vaddr_out);
>  		return crc;
>  	}
>  
> -	memcpy(vaddr_out, vkms_obj->vaddr, vkms_obj->gem.size);
> -	mutex_unlock(&vkms_obj->pages_lock);
> +	memcpy(vaddr_out, vaddr, gem_obj->size);
>  
>  	if (cursor_crc)
>  		compose_cursor(cursor_crc, primary_crc, vaddr_out);
>  
>  	crc = compute_crc(vaddr_out, primary_crc);
>  
> +	drm_gem_shmem_vunmap(gem_obj, vaddr);
>  	kfree(vaddr_out);
>  
>  	return crc;
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 83087877565c..fa26e2675028 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -19,6 +19,7 @@
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_gem_shmem_helper.h>
>  #include <drm/drm_fb_helper.h>
>  #include "vkms_drv.h"
>  
> @@ -46,12 +47,6 @@ static const struct file_operations vkms_driver_fops = {
>  	.release	= drm_release,
>  };
>  
> -static const struct vm_operations_struct vkms_gem_vm_ops = {
> -	.fault = vkms_gem_fault,
> -	.open = drm_gem_vm_open,
> -	.close = drm_gem_vm_close,
> -};
> -
>  static void vkms_release(struct drm_device *dev)
>  {
>  	struct vkms_device *vkms = container_of(dev, struct vkms_device, drm);
> @@ -64,12 +59,13 @@ static void vkms_release(struct drm_device *dev)
>  }
>  
>  static struct drm_driver vkms_driver = {
> -	.driver_features	= DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_GEM,
> +	.driver_features	= (DRIVER_MODESET |
> +				   DRIVER_ATOMIC |
> +				   DRIVER_GEM |
> +				   DRIVER_PRIME),
>  	.release		= vkms_release,
>  	.fops			= &vkms_driver_fops,
> -	.dumb_create		= vkms_dumb_create,
> -	.gem_vm_ops		= &vkms_gem_vm_ops,
> -	.gem_free_object_unlocked = vkms_gem_free_object,
> +	DRM_GEM_SHMEM_DRIVER_OPS,
>  	.get_vblank_timestamp	= vkms_get_vblank_timestamp,
>  
>  	.name			= DRIVER_NAME,
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index e4469cd3d254..3faf49f43feb 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -80,23 +80,12 @@ struct vkms_device {
>  	struct vkms_output output;
>  };
>  
> -struct vkms_gem_object {
> -	struct drm_gem_object gem;
> -	struct mutex pages_lock; /* Page lock used in page fault handler */
> -	struct page **pages;
> -	unsigned int vmap_count;
> -	void *vaddr;
> -};
> -
>  #define drm_crtc_to_vkms_output(target) \
>  	container_of(target, struct vkms_output, crtc)
>  
>  #define drm_device_to_vkms_device(target) \
>  	container_of(target, struct vkms_device, drm)
>  
> -#define drm_gem_to_vkms_gem(target)\
> -	container_of(target, struct vkms_gem_object, gem)
> -
>  #define to_vkms_crtc_state(target)\
>  	container_of(target, struct vkms_crtc_state, base)
>  
> @@ -122,17 +111,6 @@ struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
>  				       u32 *handle,
>  				       u64 size);
>  
> -vm_fault_t vkms_gem_fault(struct vm_fault *vmf);
> -
> -int vkms_dumb_create(struct drm_file *file, struct drm_device *dev,
> -		     struct drm_mode_create_dumb *args);
> -
> -void vkms_gem_free_object(struct drm_gem_object *obj);
> -
> -int vkms_gem_vmap(struct drm_gem_object *obj);
> -
> -void vkms_gem_vunmap(struct drm_gem_object *obj);
> -
>  /* CRC Support */
>  int vkms_set_crc_source(struct drm_crtc *crtc, const char *src_name);
>  int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
> diff --git a/drivers/gpu/drm/vkms/vkms_gem.c b/drivers/gpu/drm/vkms/vkms_gem.c
> index 80311daed47a..11f52aa4e732 100644
> --- a/drivers/gpu/drm/vkms/vkms_gem.c
> +++ b/drivers/gpu/drm/vkms/vkms_gem.c
> @@ -7,222 +7,34 @@
>   */
>  
>  #include <linux/shmem_fs.h>
> +#include <drm/drm_gem_shmem_helper.h>
>  
>  #include "vkms_drv.h"
>  
> -static struct vkms_gem_object *__vkms_gem_create(struct drm_device *dev,
> -						 u64 size)
> -{
> -	struct vkms_gem_object *obj;
> -	int ret;
> -
> -	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
> -	if (!obj)
> -		return ERR_PTR(-ENOMEM);
> -
> -	size = roundup(size, PAGE_SIZE);
> -	ret = drm_gem_object_init(dev, &obj->gem, size);
> -	if (ret) {
> -		kfree(obj);
> -		return ERR_PTR(ret);
> -	}
> -
> -	mutex_init(&obj->pages_lock);
> -
> -	return obj;
> -}
> -
> -void vkms_gem_free_object(struct drm_gem_object *obj)
> -{
> -	struct vkms_gem_object *gem = container_of(obj, struct vkms_gem_object,
> -						   gem);
> -
> -	WARN_ON(gem->pages);
> -	WARN_ON(gem->vaddr);
> -
> -	mutex_destroy(&gem->pages_lock);
> -	drm_gem_object_release(obj);
> -	kfree(gem);
> -}
> -
> -vm_fault_t vkms_gem_fault(struct vm_fault *vmf)
> -{
> -	struct vm_area_struct *vma = vmf->vma;
> -	struct vkms_gem_object *obj = vma->vm_private_data;
> -	unsigned long vaddr = vmf->address;
> -	pgoff_t page_offset;
> -	loff_t num_pages;
> -	vm_fault_t ret = VM_FAULT_SIGBUS;
> -
> -	page_offset = (vaddr - vma->vm_start) >> PAGE_SHIFT;
> -	num_pages = DIV_ROUND_UP(obj->gem.size, PAGE_SIZE);
> -
> -	if (page_offset > num_pages)
> -		return VM_FAULT_SIGBUS;
> -
> -	mutex_lock(&obj->pages_lock);
> -	if (obj->pages) {
> -		get_page(obj->pages[page_offset]);
> -		vmf->page = obj->pages[page_offset];
> -		ret = 0;
> -	}
> -	mutex_unlock(&obj->pages_lock);
> -	if (ret) {
> -		struct page *page;
> -		struct address_space *mapping;
> -
> -		mapping = file_inode(obj->gem.filp)->i_mapping;
> -		page = shmem_read_mapping_page(mapping, page_offset);
> -
> -		if (!IS_ERR(page)) {
> -			vmf->page = page;
> -			ret = 0;
> -		} else {
> -			switch (PTR_ERR(page)) {
> -			case -ENOSPC:
> -			case -ENOMEM:
> -				ret = VM_FAULT_OOM;
> -				break;
> -			case -EBUSY:
> -				ret = VM_FAULT_RETRY;
> -				break;
> -			case -EFAULT:
> -			case -EINVAL:
> -				ret = VM_FAULT_SIGBUS;
> -				break;
> -			default:
> -				WARN_ON(PTR_ERR(page));
> -				ret = VM_FAULT_SIGBUS;
> -				break;
> -			}
> -		}
> -	}
> -	return ret;
> -}
> -
>  struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
>  				       struct drm_file *file,
>  				       u32 *handle,
>  				       u64 size)
>  {
> -	struct vkms_gem_object *obj;
> +	struct drm_gem_shmem_object *obj;
>  	int ret;
>  
>  	if (!file || !dev || !handle)
>  		return ERR_PTR(-EINVAL);
>  
> -	obj = __vkms_gem_create(dev, size);
> +	obj = drm_gem_shmem_create(dev, size);
>  	if (IS_ERR(obj))
>  		return ERR_CAST(obj);
>  
> -	ret = drm_gem_handle_create(file, &obj->gem, handle);
> -	drm_gem_object_put_unlocked(&obj->gem);
> -	if (ret) {
> -		drm_gem_object_release(&obj->gem);
> -		kfree(obj);
> +	/*
> +	 * Allocate an id of idr table where the obj is registered
> +	 * and handle has the id what user can see.
> +	 */
> +	ret = drm_gem_handle_create(file, &obj->base, handle);
> +	/* drop reference from allocate - handle holds it now. */
> +	drm_gem_object_put_unlocked(&obj->base);
> +	if (ret)
>  		return ERR_PTR(ret);
> -	}
> -
> -	return &obj->gem;
> -}
> -
> -int vkms_dumb_create(struct drm_file *file, struct drm_device *dev,
> -		     struct drm_mode_create_dumb *args)
> -{
> -	struct drm_gem_object *gem_obj;
> -	u64 pitch, size;
> -
> -	if (!args || !dev || !file)
> -		return -EINVAL;
> -
> -	pitch = args->width * DIV_ROUND_UP(args->bpp, 8);
> -	size = pitch * args->height;
> -
> -	if (!size)
> -		return -EINVAL;
> -
> -	gem_obj = vkms_gem_create(dev, file, &args->handle, size);
> -	if (IS_ERR(gem_obj))
> -		return PTR_ERR(gem_obj);
> -
> -	args->size = gem_obj->size;
> -	args->pitch = pitch;
> -
> -	DRM_DEBUG_DRIVER("Created object of size %lld\n", size);
> -
> -	return 0;
> -}
> -
> -static struct page **_get_pages(struct vkms_gem_object *vkms_obj)
> -{
> -	struct drm_gem_object *gem_obj = &vkms_obj->gem;
> -
> -	if (!vkms_obj->pages) {
> -		struct page **pages = drm_gem_get_pages(gem_obj);
> -
> -		if (IS_ERR(pages))
> -			return pages;
> -
> -		if (cmpxchg(&vkms_obj->pages, NULL, pages))
> -			drm_gem_put_pages(gem_obj, pages, false, true);
> -	}
> -
> -	return vkms_obj->pages;
> -}
> -
> -void vkms_gem_vunmap(struct drm_gem_object *obj)
> -{
> -	struct vkms_gem_object *vkms_obj = drm_gem_to_vkms_gem(obj);
> -
> -	mutex_lock(&vkms_obj->pages_lock);
> -	if (vkms_obj->vmap_count < 1) {
> -		WARN_ON(vkms_obj->vaddr);
> -		WARN_ON(vkms_obj->pages);
> -		mutex_unlock(&vkms_obj->pages_lock);
> -		return;
> -	}
> -
> -	vkms_obj->vmap_count--;
> -
> -	if (vkms_obj->vmap_count == 0) {
> -		vunmap(vkms_obj->vaddr);
> -		vkms_obj->vaddr = NULL;
> -		drm_gem_put_pages(obj, vkms_obj->pages, false, true);
> -		vkms_obj->pages = NULL;
> -	}
> -
> -	mutex_unlock(&vkms_obj->pages_lock);
> -}
> -
> -int vkms_gem_vmap(struct drm_gem_object *obj)
> -{
> -	struct vkms_gem_object *vkms_obj = drm_gem_to_vkms_gem(obj);
> -	int ret = 0;
> -
> -	mutex_lock(&vkms_obj->pages_lock);
> -
> -	if (!vkms_obj->vaddr) {
> -		unsigned int n_pages = obj->size >> PAGE_SHIFT;
> -		struct page **pages = _get_pages(vkms_obj);
> -
> -		if (IS_ERR(pages)) {
> -			ret = PTR_ERR(pages);
> -			goto out;
> -		}
> -
> -		vkms_obj->vaddr = vmap(pages, n_pages, VM_MAP, PAGE_KERNEL);
> -		if (!vkms_obj->vaddr)
> -			goto err_vmap;
> -	}
> -
> -	vkms_obj->vmap_count++;
> -	goto out;
>  
> -err_vmap:
> -	ret = -ENOMEM;
> -	drm_gem_put_pages(obj, vkms_obj->pages, false, true);
> -	vkms_obj->pages = NULL;
> -out:
> -	mutex_unlock(&vkms_obj->pages_lock);
> -	return ret;
> +	return &obj->base;
>  }
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index 7041007396ae..29e6e870d7ac 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -11,6 +11,7 @@
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_gem_shmem_helper.h>
>  
>  static struct drm_plane_state *
>  vkms_plane_duplicate_state(struct drm_plane *plane)
> @@ -138,17 +139,17 @@ static int vkms_prepare_fb(struct drm_plane *plane,
>  			   struct drm_plane_state *state)
>  {
>  	struct drm_gem_object *gem_obj;
> -	struct vkms_gem_object *vkms_obj;
> -	int ret;
> +	void *map;
>  
>  	if (!state->fb)
>  		return 0;
>  
>  	gem_obj = drm_gem_fb_get_obj(state->fb, 0);
> -	vkms_obj = drm_gem_to_vkms_gem(gem_obj);
> -	ret = vkms_gem_vmap(gem_obj);
> -	if (ret)
> -		DRM_ERROR("vmap failed: %d\n", ret);
> +	map = drm_gem_shmem_vmap(gem_obj);
> +	if (IS_ERR(map)) {
> +		DRM_ERROR("vmap failed: %ld\n", PTR_ERR(map));
> +		return PTR_ERR(map);
> +	}
>  
>  	return drm_gem_fb_prepare_fb(plane, state);
>  }
> @@ -157,12 +158,14 @@ static void vkms_cleanup_fb(struct drm_plane *plane,
>  			    struct drm_plane_state *old_state)
>  {
>  	struct drm_gem_object *gem_obj;
> +	struct drm_gem_shmem_object *shmem_obj;
>  
>  	if (!old_state->fb)
>  		return;
>  
>  	gem_obj = drm_gem_fb_get_obj(old_state->fb, 0);
> -	vkms_gem_vunmap(gem_obj);
> +	shmem_obj = to_drm_gem_shmem_obj(gem_obj);
> +	drm_gem_shmem_vunmap(gem_obj, shmem_obj->vaddr);
>  }
>  
>  static const struct drm_plane_helper_funcs vkms_primary_helper_funcs = {
> -- 
> 2.20.0.rc1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
