Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FDDC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66EF2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbfABRGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 12:06:38 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60392 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729909AbfABRGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 12:06:38 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 9D6CA27967A
Message-ID: <4bd8e4cbb72fb4e8a70dfbc9187949dfbd578203.camel@collabora.com>
Subject: Re: [PATCH] drm/virtio: switch to generic fbdev emulation
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Date:   Wed, 02 Jan 2019 14:06:29 -0300
In-Reply-To: <20181213134915.24722-1-kraxel@redhat.com>
References: <20181213134915.24722-1-kraxel@redhat.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-13 at 14:49 +0100, Gerd Hoffmann wrote:

A few words explaining why the generic emulation is OK would be useful.

The commit might be clear for seasoned DRM developers, however
given this driver is a nice target for those learning DRM
(as it can be tested easily), I think having a more verbose
history is useful.

The patch looks good:

Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h     |  14 ---
>  drivers/gpu/drm/virtio/virtgpu_display.c |   1 -
>  drivers/gpu/drm/virtio/virtgpu_drv.c     |   9 +-
>  drivers/gpu/drm/virtio/virtgpu_fb.c      | 191 -------------------------------
>  drivers/gpu/drm/virtio/virtgpu_kms.c     |   8 --
>  5 files changed, 8 insertions(+), 215 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 1deb41d42e..63704915f8 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -137,19 +137,10 @@ struct virtio_gpu_framebuffer {
>  #define to_virtio_gpu_framebuffer(x) \
>  	container_of(x, struct virtio_gpu_framebuffer, base)
>  
> -struct virtio_gpu_fbdev {
> -	struct drm_fb_helper           helper;
> -	struct virtio_gpu_framebuffer  vgfb;
> -	struct virtio_gpu_device       *vgdev;
> -	struct delayed_work            work;
> -};
> -
>  struct virtio_gpu_mman {
>  	struct ttm_bo_device		bdev;
>  };
>  
> -struct virtio_gpu_fbdev;
> -
>  struct virtio_gpu_queue {
>  	struct virtqueue *vq;
>  	spinlock_t qlock;
> @@ -180,8 +171,6 @@ struct virtio_gpu_device {
>  
>  	struct virtio_gpu_mman mman;
>  
> -	/* pointer to fbdev info structure */
> -	struct virtio_gpu_fbdev *vgfbdev;
>  	struct virtio_gpu_output outputs[VIRTIO_GPU_MAX_SCANOUTS];
>  	uint32_t num_scanouts;
>  
> @@ -249,9 +238,6 @@ int virtio_gpu_mode_dumb_mmap(struct drm_file *file_priv,
>  			      uint32_t handle, uint64_t *offset_p);
>  
>  /* virtio_fb */
> -#define VIRTIO_GPUFB_CONN_LIMIT 1
> -int virtio_gpu_fbdev_init(struct virtio_gpu_device *vgdev);
> -void virtio_gpu_fbdev_fini(struct virtio_gpu_device *vgdev);
>  int virtio_gpu_surface_dirty(struct virtio_gpu_framebuffer *qfb,
>  			     struct drm_clip_rect *clips,
>  			     unsigned int num_clips);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index b5580b11a0..e1c223e18d 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -390,6 +390,5 @@ void virtio_gpu_modeset_fini(struct virtio_gpu_device *vgdev)
>  
>  	for (i = 0 ; i < vgdev->num_scanouts; ++i)
>  		kfree(vgdev->outputs[i].edid);
> -	virtio_gpu_fbdev_fini(vgdev);
>  	drm_mode_config_cleanup(vgdev->ddev);
>  }
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index f7f32a885a..7df50920c1 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -42,13 +42,20 @@ module_param_named(modeset, virtio_gpu_modeset, int, 0400);
>  
>  static int virtio_gpu_probe(struct virtio_device *vdev)
>  {
> +	int ret;
> +
>  	if (vgacon_text_force() && virtio_gpu_modeset == -1)
>  		return -EINVAL;
>  
>  	if (virtio_gpu_modeset == 0)
>  		return -EINVAL;
>  
> -	return drm_virtio_init(&driver, vdev);
> +	ret = drm_virtio_init(&driver, vdev);
> +	if (ret)
> +		return ret;
> +
> +	drm_fbdev_generic_setup(vdev->priv, 32);
> +	return 0;
>  }
>  
>  static void virtio_gpu_remove(struct virtio_device *vdev)
> diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
> index fb1cc8b2f1..b07584b1c2 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_fb.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
> @@ -27,8 +27,6 @@
>  #include <drm/drm_fb_helper.h>
>  #include "virtgpu_drv.h"
>  
> -#define VIRTIO_GPU_FBCON_POLL_PERIOD (HZ / 60)
> -
>  static int virtio_gpu_dirty_update(struct virtio_gpu_framebuffer *fb,
>  				   bool store, int x, int y,
>  				   int width, int height)
> @@ -150,192 +148,3 @@ int virtio_gpu_surface_dirty(struct virtio_gpu_framebuffer *vgfb,
>  				      left, top, right - left, bottom - top);
>  	return 0;
>  }
> -
> -static void virtio_gpu_fb_dirty_work(struct work_struct *work)
> -{
> -	struct delayed_work *delayed_work = to_delayed_work(work);
> -	struct virtio_gpu_fbdev *vfbdev =
> -		container_of(delayed_work, struct virtio_gpu_fbdev, work);
> -	struct virtio_gpu_framebuffer *vgfb = &vfbdev->vgfb;
> -
> -	virtio_gpu_dirty_update(&vfbdev->vgfb, false, vgfb->x1, vgfb->y1,
> -				vgfb->x2 - vgfb->x1, vgfb->y2 - vgfb->y1);
> -}
> -
> -static void virtio_gpu_3d_fillrect(struct fb_info *info,
> -				   const struct fb_fillrect *rect)
> -{
> -	struct virtio_gpu_fbdev *vfbdev = info->par;
> -
> -	drm_fb_helper_sys_fillrect(info, rect);
> -	virtio_gpu_dirty_update(&vfbdev->vgfb, true, rect->dx, rect->dy,
> -			     rect->width, rect->height);
> -	schedule_delayed_work(&vfbdev->work, VIRTIO_GPU_FBCON_POLL_PERIOD);
> -}
> -
> -static void virtio_gpu_3d_copyarea(struct fb_info *info,
> -				   const struct fb_copyarea *area)
> -{
> -	struct virtio_gpu_fbdev *vfbdev = info->par;
> -
> -	drm_fb_helper_sys_copyarea(info, area);
> -	virtio_gpu_dirty_update(&vfbdev->vgfb, true, area->dx, area->dy,
> -			   area->width, area->height);
> -	schedule_delayed_work(&vfbdev->work, VIRTIO_GPU_FBCON_POLL_PERIOD);
> -}
> -
> -static void virtio_gpu_3d_imageblit(struct fb_info *info,
> -				    const struct fb_image *image)
> -{
> -	struct virtio_gpu_fbdev *vfbdev = info->par;
> -
> -	drm_fb_helper_sys_imageblit(info, image);
> -	virtio_gpu_dirty_update(&vfbdev->vgfb, true, image->dx, image->dy,
> -			     image->width, image->height);
> -	schedule_delayed_work(&vfbdev->work, VIRTIO_GPU_FBCON_POLL_PERIOD);
> -}
> -
> -static struct fb_ops virtio_gpufb_ops = {
> -	.owner = THIS_MODULE,
> -	DRM_FB_HELPER_DEFAULT_OPS,
> -	.fb_fillrect = virtio_gpu_3d_fillrect,
> -	.fb_copyarea = virtio_gpu_3d_copyarea,
> -	.fb_imageblit = virtio_gpu_3d_imageblit,
> -};
> -
> -static int virtio_gpufb_create(struct drm_fb_helper *helper,
> -			       struct drm_fb_helper_surface_size *sizes)
> -{
> -	struct virtio_gpu_fbdev *vfbdev =
> -		container_of(helper, struct virtio_gpu_fbdev, helper);
> -	struct drm_device *dev = helper->dev;
> -	struct virtio_gpu_device *vgdev = dev->dev_private;
> -	struct fb_info *info;
> -	struct drm_framebuffer *fb;
> -	struct drm_mode_fb_cmd2 mode_cmd = {};
> -	struct virtio_gpu_object *obj;
> -	uint32_t format, size;
> -	int ret;
> -
> -	mode_cmd.width = sizes->surface_width;
> -	mode_cmd.height = sizes->surface_height;
> -	mode_cmd.pitches[0] = mode_cmd.width * 4;
> -	mode_cmd.pixel_format = DRM_FORMAT_HOST_XRGB8888;
> -
> -	format = virtio_gpu_translate_format(mode_cmd.pixel_format);
> -	if (format == 0)
> -		return -EINVAL;
> -
> -	size = mode_cmd.pitches[0] * mode_cmd.height;
> -	obj = virtio_gpu_alloc_object(dev, size, false, true);
> -	if (IS_ERR(obj))
> -		return PTR_ERR(obj);
> -
> -	virtio_gpu_cmd_create_resource(vgdev, obj, format,
> -				       mode_cmd.width, mode_cmd.height);
> -
> -	ret = virtio_gpu_object_kmap(obj);
> -	if (ret) {
> -		DRM_ERROR("failed to kmap fb %d\n", ret);
> -		goto err_obj_vmap;
> -	}
> -
> -	/* attach the object to the resource */
> -	ret = virtio_gpu_object_attach(vgdev, obj, NULL);
> -	if (ret)
> -		goto err_obj_attach;
> -
> -	info = drm_fb_helper_alloc_fbi(helper);
> -	if (IS_ERR(info)) {
> -		ret = PTR_ERR(info);
> -		goto err_fb_alloc;
> -	}
> -
> -	info->par = helper;
> -
> -	ret = virtio_gpu_framebuffer_init(dev, &vfbdev->vgfb,
> -					  &mode_cmd, &obj->gem_base);
> -	if (ret)
> -		goto err_fb_alloc;
> -
> -	fb = &vfbdev->vgfb.base;
> -
> -	vfbdev->helper.fb = fb;
> -
> -	strcpy(info->fix.id, "virtiodrmfb");
> -	info->fbops = &virtio_gpufb_ops;
> -	info->pixmap.flags = FB_PIXMAP_SYSTEM;
> -
> -	info->screen_buffer = obj->vmap;
> -	info->screen_size = obj->gem_base.size;
> -	drm_fb_helper_fill_fix(info, fb->pitches[0], fb->format->depth);
> -	drm_fb_helper_fill_var(info, &vfbdev->helper,
> -			       sizes->fb_width, sizes->fb_height);
> -
> -	info->fix.mmio_start = 0;
> -	info->fix.mmio_len = 0;
> -	return 0;
> -
> -err_fb_alloc:
> -	virtio_gpu_object_detach(vgdev, obj);
> -err_obj_attach:
> -err_obj_vmap:
> -	virtio_gpu_gem_free_object(&obj->gem_base);
> -	return ret;
> -}
> -
> -static int virtio_gpu_fbdev_destroy(struct drm_device *dev,
> -				    struct virtio_gpu_fbdev *vgfbdev)
> -{
> -	struct virtio_gpu_framebuffer *vgfb = &vgfbdev->vgfb;
> -
> -	drm_fb_helper_unregister_fbi(&vgfbdev->helper);
> -
> -	if (vgfb->base.obj[0])
> -		vgfb->base.obj[0] = NULL;
> -	drm_fb_helper_fini(&vgfbdev->helper);
> -	drm_framebuffer_cleanup(&vgfb->base);
> -
> -	return 0;
> -}
> -static const struct drm_fb_helper_funcs virtio_gpu_fb_helper_funcs = {
> -	.fb_probe = virtio_gpufb_create,
> -};
> -
> -int virtio_gpu_fbdev_init(struct virtio_gpu_device *vgdev)
> -{
> -	struct virtio_gpu_fbdev *vgfbdev;
> -	int bpp_sel = 32; /* TODO: parameter from somewhere? */
> -	int ret;
> -
> -	vgfbdev = kzalloc(sizeof(struct virtio_gpu_fbdev), GFP_KERNEL);
> -	if (!vgfbdev)
> -		return -ENOMEM;
> -
> -	vgfbdev->vgdev = vgdev;
> -	vgdev->vgfbdev = vgfbdev;
> -	INIT_DELAYED_WORK(&vgfbdev->work, virtio_gpu_fb_dirty_work);
> -
> -	drm_fb_helper_prepare(vgdev->ddev, &vgfbdev->helper,
> -			      &virtio_gpu_fb_helper_funcs);
> -	ret = drm_fb_helper_init(vgdev->ddev, &vgfbdev->helper,
> -				 VIRTIO_GPUFB_CONN_LIMIT);
> -	if (ret) {
> -		kfree(vgfbdev);
> -		return ret;
> -	}
> -
> -	drm_fb_helper_single_add_all_connectors(&vgfbdev->helper);
> -	drm_fb_helper_initial_config(&vgfbdev->helper, bpp_sel);
> -	return 0;
> -}
> -
> -void virtio_gpu_fbdev_fini(struct virtio_gpu_device *vgdev)
> -{
> -	if (!vgdev->vgfbdev)
> -		return;
> -
> -	virtio_gpu_fbdev_destroy(vgdev->ddev, vgdev->vgfbdev);
> -	kfree(vgdev->vgfbdev);
> -	vgdev->vgfbdev = NULL;
> -}
> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> index 3af6181c05..1072064a0d 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -28,11 +28,6 @@
>  #include <drm/drmP.h>
>  #include "virtgpu_drv.h"
>  
> -static int virtio_gpu_fbdev = 1;
> -
> -MODULE_PARM_DESC(fbdev, "Disable/Enable framebuffer device & console");
> -module_param_named(fbdev, virtio_gpu_fbdev, int, 0400);
> -
>  static void virtio_gpu_config_changed_work_func(struct work_struct *work)
>  {
>  	struct virtio_gpu_device *vgdev =
> @@ -212,9 +207,6 @@ int virtio_gpu_driver_load(struct drm_device *dev, unsigned long flags)
>  	virtio_gpu_cmd_get_display_info(vgdev);
>  	wait_event_timeout(vgdev->resp_wq, !vgdev->display_info_pending,
>  			   5 * HZ);
> -	if (virtio_gpu_fbdev)
> -		virtio_gpu_fbdev_init(vgdev);
> -
>  	return 0;
>  
>  err_modeset:


