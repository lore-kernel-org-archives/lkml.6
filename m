Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252D3C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFF020861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TmwlEw4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFFF020861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeIETRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:17:05 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33412 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeIETRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:17:05 -0400
Received: by mail-ed1-f67.google.com with SMTP id d8-v6so6329801edv.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 07:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5nYv1V/AS/0Gtx0sLgkUKmnNDcek9LAGYIp/bXyOEOs=;
        b=TmwlEw4r96P+mzNAfPGKdiUuwgg2fwOb+jfJH7yluq730SgDstuhgvQ2Aw8bEY34YD
         Ts+ygfyb7Oubzj4+Yua6G77j0XXS9JB7f7ab3iXatix3sk9P2tFjR7WBg9mOY+kruUSu
         NrhwPlW/t3DD4/KVTktINQ4YfAKSPOwRfNba8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=5nYv1V/AS/0Gtx0sLgkUKmnNDcek9LAGYIp/bXyOEOs=;
        b=rjxCfYmi/+H0tcJvw+RmNL8CMLv9Opp1qBeWCEEe2tG76K5c+SouS0k93DP2YSvTb5
         lU2YGM08r5vp2py7kQsATuVE7IvdJzZoGW7STVudVqw8jIbLLFG5Iz8Shm0xqQyNAoOH
         Dt3xaDeJHycVV7pNnRxo7nRKHRUEkPXPtTkGbWFAWxEoOYTOjEMnROlTPjmRadsOdzl9
         kc1PtTiQXn8wbTn4Wdm5BeYhoC6f1WITKKjGdZKTII+EmMCZlKgDgfWsuBTfhUufXfxi
         8dK72xjSsno6lQeRqTzz8qwippgfMpatCw+h5mggwQrR4URk4ZrEJbX9TEwM7glnJ8n0
         xhlw==
X-Gm-Message-State: APzg51ARKPk8ahDXEki7vL/kIINhz9oYWWY2FF9NMyBfSlZsqmOPGyid
        Xi7Mo38Gj/ybhBinbvmeIWQ9Iw==
X-Google-Smtp-Source: ANB0VdYzLGtJ0OulL31oUOI0PqSTtG+YcdmgJd70ebgETdAdvO/tJrCaJhyJDUkVu5fo4y3hC/SoMQ==
X-Received: by 2002:a50:e718:: with SMTP id a24-v6mr42689656edn.278.1536158791731;
        Wed, 05 Sep 2018 07:46:31 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id r44-v6sm2752213edd.87.2018.09.05.07.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 07:46:30 -0700 (PDT)
Date:   Wed, 5 Sep 2018 16:46:29 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Peter Wu <peter@lekensteyn.nl>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] bochs: convert to drm_fb_helper_fbdev_setup/teardown
Message-ID: <20180905144628.GG4929@phenom.ffwll.local>
Mail-Followup-To: Peter Wu <peter@lekensteyn.nl>,
        Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <20180905144127.5690-1-peter@lekensteyn.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905144127.5690-1-peter@lekensteyn.nl>
X-Operating-System: Linux phenom 4.17.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 04:41:27PM +0200, Peter Wu wrote:
> Currently unloading bochs_drm (after unbinding the vtconsole) results in
> a warning about a leaked connector:
> 
>     [drm:drm_mode_config_cleanup] *ERROR* connector Virtual-3 leaked!
> 
> While investigating a potential fix I noticed that a lot of open-coded
> functionality is already implemented elsewhere, so start converting it:
> bochs_fbdev_init -> drm_fb_helper_fbdev_setup: trivial (similar impl).
> bochs_fbdev_fini -> drm_fb_helper_fbdev_teardown: requires unembedding
> "struct drm_framebuffer" from "struct bochs_framebuffer".
> 
> Unembedding drm_framebuffer is made easy using drm_gem_fbdev_fb_create
> which can replace bochs_fbdev_destroy and custom routines in bochs_mm.c.
> For this to work, the GEM object is moved into "drm_framebuffer". After
> that, "bochs_framebuffer" is no longer needed and therefore removed.
> 
> Remove the unused "size" and "initialized" fields from fb, the latter is
> not necessary as drm_fb_helper_fbdev_teardown can be called even if
> bochsfb_create fails. This theory was tested by returning early and
> late (just before drm_gem_fbdev_fb_create). Both scenarios fail
> gracefully although the latter seems to leak the object from
> bochsfb_create_object (not a regression).
> 
> Guess on the reason for the encoder leak: drm_framebuffer_cleanup was
> previously used, but did not destroy much. drm_fb_helper_fbdev_teardown
> is now used and calls drm_framebuffer_remove which does a bit more work.
> 
> Tested with 'echo 0 > /sys/class/vtconsole/vtcon1/bind; rmmod bochs_drm'
> and also with Xorg + fbdev (startx -> xterm). The latter triggered a
> warning in ttm_bo_vm_open that existed before, see
> https://lkml.kernel.org/r/1464000533-13140-4-git-send-email-mstaudt@suse.de

You can probably get rid of this one if you're refactoring even more. The
generic fb_probe implementation (already merged) plus gem-shmem support
for it (still in flight) from Noralf should be able to pull that off. That
gives you the fb_mmap implementation, but with 100% generic code instead
of a driver specific hack like Max did.
> 
> Signed-off-by: Peter Wu <peter@lekensteyn.nl>

lgtm. Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I'll leave merging to Gerd.
-Daniel

> ---
>  drivers/gpu/drm/bochs/bochs.h       | 19 ++-----
>  drivers/gpu/drm/bochs/bochs_fbdev.c | 79 +++++++----------------------
>  drivers/gpu/drm/bochs/bochs_kms.c   |  7 +--
>  drivers/gpu/drm/bochs/bochs_mm.c    | 74 ---------------------------
>  4 files changed, 22 insertions(+), 157 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
> index 375bf92cd04f..8514a84fbdbe 100644
> --- a/drivers/gpu/drm/bochs/bochs.h
> +++ b/drivers/gpu/drm/bochs/bochs.h
> @@ -51,11 +51,6 @@ enum bochs_types {
>  	BOCHS_UNKNOWN,
>  };
>  
> -struct bochs_framebuffer {
> -	struct drm_framebuffer base;
> -	struct drm_gem_object *obj;
> -};
> -
>  struct bochs_device {
>  	/* hw */
>  	void __iomem   *mmio;
> @@ -88,15 +83,11 @@ struct bochs_device {
>  
>  	/* fbdev */
>  	struct {
> -		struct bochs_framebuffer gfb;
> +		struct drm_framebuffer *fb;
>  		struct drm_fb_helper helper;
> -		int size;
> -		bool initialized;
>  	} fb;
>  };
>  
> -#define to_bochs_framebuffer(x) container_of(x, struct bochs_framebuffer, base)
> -
>  struct bochs_bo {
>  	struct ttm_buffer_object bo;
>  	struct ttm_placement placement;
> @@ -148,15 +139,9 @@ int bochs_dumb_create(struct drm_file *file, struct drm_device *dev,
>  int bochs_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
>  			   uint32_t handle, uint64_t *offset);
>  
> -int bochs_framebuffer_init(struct drm_device *dev,
> -			   struct bochs_framebuffer *gfb,
> -			   const struct drm_mode_fb_cmd2 *mode_cmd,
> -			   struct drm_gem_object *obj);
>  int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag, u64 *gpu_addr);
>  int bochs_bo_unpin(struct bochs_bo *bo);
>  
> -extern const struct drm_mode_config_funcs bochs_mode_funcs;
> -
>  /* bochs_kms.c */
>  int bochs_kms_init(struct bochs_device *bochs);
>  void bochs_kms_fini(struct bochs_device *bochs);
> @@ -164,3 +149,5 @@ void bochs_kms_fini(struct bochs_device *bochs);
>  /* bochs_fbdev.c */
>  int bochs_fbdev_init(struct bochs_device *bochs);
>  void bochs_fbdev_fini(struct bochs_device *bochs);
> +
> +extern const struct drm_mode_config_funcs bochs_mode_funcs;
> diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
> index 14eb8d0d5a00..8f4d6c052f7b 100644
> --- a/drivers/gpu/drm/bochs/bochs_fbdev.c
> +++ b/drivers/gpu/drm/bochs/bochs_fbdev.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include "bochs.h"
> +#include <drm/drm_gem_framebuffer_helper.h>
>  
>  /* ---------------------------------------------------------------------- */
>  
> @@ -13,9 +14,7 @@ static int bochsfb_mmap(struct fb_info *info,
>  			struct vm_area_struct *vma)
>  {
>  	struct drm_fb_helper *fb_helper = info->par;
> -	struct bochs_device *bochs =
> -		container_of(fb_helper, struct bochs_device, fb.helper);
> -	struct bochs_bo *bo = gem_to_bochs_bo(bochs->fb.gfb.obj);
> +	struct bochs_bo *bo = gem_to_bochs_bo(fb_helper->fb->obj[0]);
>  
>  	return ttm_fbdev_mmap(vma, &bo->bo);
>  }
> @@ -101,19 +100,20 @@ static int bochsfb_create(struct drm_fb_helper *helper,
>  
>  	/* init fb device */
>  	info = drm_fb_helper_alloc_fbi(helper);
> -	if (IS_ERR(info))
> +	if (IS_ERR(info)) {
> +		DRM_ERROR("Failed to allocate fbi: %ld\n", PTR_ERR(info));
>  		return PTR_ERR(info);
> +	}
>  
>  	info->par = &bochs->fb.helper;
>  
> -	ret = bochs_framebuffer_init(bochs->dev, &bochs->fb.gfb, &mode_cmd, gobj);
> -	if (ret)
> -		return ret;
> -
> -	bochs->fb.size = size;
> +	fb = drm_gem_fbdev_fb_create(bochs->dev, sizes, 0, gobj, NULL);
> +	if (IS_ERR(fb)) {
> +		DRM_ERROR("Failed to create framebuffer: %ld\n", PTR_ERR(fb));
> +		return PTR_ERR(fb);
> +	}
>  
>  	/* setup helper */
> -	fb = &bochs->fb.gfb.base;
>  	bochs->fb.helper.fb = fb;
>  
>  	strcpy(info->fix.id, "bochsdrmfb");
> @@ -130,27 +130,6 @@ static int bochsfb_create(struct drm_fb_helper *helper,
>  	drm_vma_offset_remove(&bo->bo.bdev->vma_manager, &bo->bo.vma_node);
>  	info->fix.smem_start = 0;
>  	info->fix.smem_len = size;
> -
> -	bochs->fb.initialized = true;
> -	return 0;
> -}
> -
> -static int bochs_fbdev_destroy(struct bochs_device *bochs)
> -{
> -	struct bochs_framebuffer *gfb = &bochs->fb.gfb;
> -
> -	DRM_DEBUG_DRIVER("\n");
> -
> -	drm_fb_helper_unregister_fbi(&bochs->fb.helper);
> -
> -	if (gfb->obj) {
> -		drm_gem_object_unreference_unlocked(gfb->obj);
> -		gfb->obj = NULL;
> -	}
> -
> -	drm_framebuffer_unregister_private(&gfb->base);
> -	drm_framebuffer_cleanup(&gfb->base);
> -
>  	return 0;
>  }
>  
> @@ -158,41 +137,17 @@ static const struct drm_fb_helper_funcs bochs_fb_helper_funcs = {
>  	.fb_probe = bochsfb_create,
>  };
>  
> +const struct drm_mode_config_funcs bochs_mode_funcs = {
> +	.fb_create = drm_gem_fb_create,
> +};
> +
>  int bochs_fbdev_init(struct bochs_device *bochs)
>  {
> -	int ret;
> -
> -	drm_fb_helper_prepare(bochs->dev, &bochs->fb.helper,
> -			      &bochs_fb_helper_funcs);
> -
> -	ret = drm_fb_helper_init(bochs->dev, &bochs->fb.helper, 1);
> -	if (ret)
> -		return ret;
> -
> -	ret = drm_fb_helper_single_add_all_connectors(&bochs->fb.helper);
> -	if (ret)
> -		goto fini;
> -
> -	drm_helper_disable_unused_functions(bochs->dev);
> -
> -	ret = drm_fb_helper_initial_config(&bochs->fb.helper, 32);
> -	if (ret)
> -		goto fini;
> -
> -	return 0;
> -
> -fini:
> -	drm_fb_helper_fini(&bochs->fb.helper);
> -	return ret;
> +	return drm_fb_helper_fbdev_setup(bochs->dev, &bochs->fb.helper,
> +					 &bochs_fb_helper_funcs, 32, 1);
>  }
>  
>  void bochs_fbdev_fini(struct bochs_device *bochs)
>  {
> -	if (bochs->fb.initialized)
> -		bochs_fbdev_destroy(bochs);
> -
> -	if (bochs->fb.helper.fbdev)
> -		drm_fb_helper_fini(&bochs->fb.helper);
> -
> -	bochs->fb.initialized = false;
> +	drm_fb_helper_fbdev_teardown(bochs->dev);
>  }
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
> index 233980a78591..c7e575511d2f 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -35,14 +35,12 @@ static int bochs_crtc_mode_set_base(struct drm_crtc *crtc, int x, int y,
>  {
>  	struct bochs_device *bochs =
>  		container_of(crtc, struct bochs_device, crtc);
> -	struct bochs_framebuffer *bochs_fb;
>  	struct bochs_bo *bo;
>  	u64 gpu_addr = 0;
>  	int ret;
>  
>  	if (old_fb) {
> -		bochs_fb = to_bochs_framebuffer(old_fb);
> -		bo = gem_to_bochs_bo(bochs_fb->obj);
> +		bo = gem_to_bochs_bo(old_fb->obj[0]);
>  		ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
>  		if (ret) {
>  			DRM_ERROR("failed to reserve old_fb bo\n");
> @@ -55,8 +53,7 @@ static int bochs_crtc_mode_set_base(struct drm_crtc *crtc, int x, int y,
>  	if (WARN_ON(crtc->primary->fb == NULL))
>  		return -EINVAL;
>  
> -	bochs_fb = to_bochs_framebuffer(crtc->primary->fb);
> -	bo = gem_to_bochs_bo(bochs_fb->obj);
> +	bo = gem_to_bochs_bo(crtc->primary->fb->obj[0]);
>  	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
> index 39cd08416773..cdbc3ca3ec51 100644
> --- a/drivers/gpu/drm/bochs/bochs_mm.c
> +++ b/drivers/gpu/drm/bochs/bochs_mm.c
> @@ -457,77 +457,3 @@ int bochs_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
>  	drm_gem_object_unreference_unlocked(obj);
>  	return 0;
>  }
> -
> -/* ---------------------------------------------------------------------- */
> -
> -static void bochs_user_framebuffer_destroy(struct drm_framebuffer *fb)
> -{
> -	struct bochs_framebuffer *bochs_fb = to_bochs_framebuffer(fb);
> -
> -	drm_gem_object_unreference_unlocked(bochs_fb->obj);
> -	drm_framebuffer_cleanup(fb);
> -	kfree(fb);
> -}
> -
> -static const struct drm_framebuffer_funcs bochs_fb_funcs = {
> -	.destroy = bochs_user_framebuffer_destroy,
> -};
> -
> -int bochs_framebuffer_init(struct drm_device *dev,
> -			   struct bochs_framebuffer *gfb,
> -			   const struct drm_mode_fb_cmd2 *mode_cmd,
> -			   struct drm_gem_object *obj)
> -{
> -	int ret;
> -
> -	drm_helper_mode_fill_fb_struct(dev, &gfb->base, mode_cmd);
> -	gfb->obj = obj;
> -	ret = drm_framebuffer_init(dev, &gfb->base, &bochs_fb_funcs);
> -	if (ret) {
> -		DRM_ERROR("drm_framebuffer_init failed: %d\n", ret);
> -		return ret;
> -	}
> -	return 0;
> -}
> -
> -static struct drm_framebuffer *
> -bochs_user_framebuffer_create(struct drm_device *dev,
> -			      struct drm_file *filp,
> -			      const struct drm_mode_fb_cmd2 *mode_cmd)
> -{
> -	struct drm_gem_object *obj;
> -	struct bochs_framebuffer *bochs_fb;
> -	int ret;
> -
> -	DRM_DEBUG_DRIVER("%dx%d, format %c%c%c%c\n",
> -	       mode_cmd->width, mode_cmd->height,
> -	       (mode_cmd->pixel_format)       & 0xff,
> -	       (mode_cmd->pixel_format >> 8)  & 0xff,
> -	       (mode_cmd->pixel_format >> 16) & 0xff,
> -	       (mode_cmd->pixel_format >> 24) & 0xff);
> -
> -	if (mode_cmd->pixel_format != DRM_FORMAT_XRGB8888)
> -		return ERR_PTR(-ENOENT);
> -
> -	obj = drm_gem_object_lookup(filp, mode_cmd->handles[0]);
> -	if (obj == NULL)
> -		return ERR_PTR(-ENOENT);
> -
> -	bochs_fb = kzalloc(sizeof(*bochs_fb), GFP_KERNEL);
> -	if (!bochs_fb) {
> -		drm_gem_object_unreference_unlocked(obj);
> -		return ERR_PTR(-ENOMEM);
> -	}
> -
> -	ret = bochs_framebuffer_init(dev, bochs_fb, mode_cmd, obj);
> -	if (ret) {
> -		drm_gem_object_unreference_unlocked(obj);
> -		kfree(bochs_fb);
> -		return ERR_PTR(ret);
> -	}
> -	return &bochs_fb->base;
> -}
> -
> -const struct drm_mode_config_funcs bochs_mode_funcs = {
> -	.fb_create = bochs_user_framebuffer_create,
> -};
> -- 
> 2.18.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
