Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D593C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D2920870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbfAKFiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:38:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730099AbfAKFiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:38:01 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 892BD73A6C;
        Fri, 11 Jan 2019 05:38:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-203.ams2.redhat.com [10.36.116.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 923791019632;
        Fri, 11 Jan 2019 05:37:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id A2B2476EE; Fri, 11 Jan 2019 06:37:54 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     andr2000@gmail.com, noralf@tronnes.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 15/16] drm/bochs: drop old fbdev emulation code
Date:   Fri, 11 Jan 2019 06:37:51 +0100
Message-Id: <20190111053752.4004-16-kraxel@redhat.com>
In-Reply-To: <20190111053752.4004-1-kraxel@redhat.com>
References: <20190111053752.4004-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 11 Jan 2019 05:38:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not needed any more, bochs uses the generic emulation now.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs.h       |   9 ---
 drivers/gpu/drm/bochs/bochs_fbdev.c | 129 ------------------------------------
 2 files changed, 138 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index ede22beb85..03711394f1 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -80,12 +80,6 @@ struct bochs_device {
 		struct ttm_bo_device bdev;
 		bool initialized;
 	} ttm;
-
-	/* fbdev */
-	struct {
-		struct drm_framebuffer *fb;
-		struct drm_fb_helper helper;
-	} fb;
 };
 
 struct bochs_bo {
@@ -157,7 +151,4 @@ int bochs_kms_init(struct bochs_device *bochs);
 void bochs_kms_fini(struct bochs_device *bochs);
 
 /* bochs_fbdev.c */
-int bochs_fbdev_init(struct bochs_device *bochs);
-void bochs_fbdev_fini(struct bochs_device *bochs);
-
 extern const struct drm_mode_config_funcs bochs_mode_funcs;
diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
index ccf783b038..7cac3f5253 100644
--- a/drivers/gpu/drm/bochs/bochs_fbdev.c
+++ b/drivers/gpu/drm/bochs/bochs_fbdev.c
@@ -11,124 +11,6 @@
 
 /* ---------------------------------------------------------------------- */
 
-static int bochsfb_mmap(struct fb_info *info,
-			struct vm_area_struct *vma)
-{
-	struct drm_fb_helper *fb_helper = info->par;
-	struct bochs_bo *bo = gem_to_bochs_bo(fb_helper->fb->obj[0]);
-
-	return ttm_fbdev_mmap(vma, &bo->bo);
-}
-
-static struct fb_ops bochsfb_ops = {
-	.owner = THIS_MODULE,
-	DRM_FB_HELPER_DEFAULT_OPS,
-	.fb_fillrect = drm_fb_helper_cfb_fillrect,
-	.fb_copyarea = drm_fb_helper_cfb_copyarea,
-	.fb_imageblit = drm_fb_helper_cfb_imageblit,
-	.fb_mmap = bochsfb_mmap,
-};
-
-static int bochsfb_create_object(struct bochs_device *bochs,
-				 const struct drm_mode_fb_cmd2 *mode_cmd,
-				 struct drm_gem_object **gobj_p)
-{
-	struct drm_device *dev = bochs->dev;
-	struct drm_gem_object *gobj;
-	u32 size;
-	int ret = 0;
-
-	size = mode_cmd->pitches[0] * mode_cmd->height;
-	ret = bochs_gem_create(dev, size, true, &gobj);
-	if (ret)
-		return ret;
-
-	*gobj_p = gobj;
-	return ret;
-}
-
-static int bochsfb_create(struct drm_fb_helper *helper,
-			  struct drm_fb_helper_surface_size *sizes)
-{
-	struct bochs_device *bochs =
-		container_of(helper, struct bochs_device, fb.helper);
-	struct fb_info *info;
-	struct drm_framebuffer *fb;
-	struct drm_mode_fb_cmd2 mode_cmd;
-	struct drm_gem_object *gobj = NULL;
-	struct bochs_bo *bo = NULL;
-	int size, ret;
-
-	if (sizes->surface_bpp != 32)
-		return -EINVAL;
-
-	mode_cmd.width = sizes->surface_width;
-	mode_cmd.height = sizes->surface_height;
-	mode_cmd.pitches[0] = sizes->surface_width * 4;
-	mode_cmd.pixel_format = DRM_FORMAT_HOST_XRGB8888;
-	size = mode_cmd.pitches[0] * mode_cmd.height;
-
-	/* alloc, pin & map bo */
-	ret = bochsfb_create_object(bochs, &mode_cmd, &gobj);
-	if (ret) {
-		DRM_ERROR("failed to create fbcon backing object %d\n", ret);
-		return ret;
-	}
-
-	bo = gem_to_bochs_bo(gobj);
-
-	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
-	if (ret) {
-		DRM_ERROR("failed to pin fbcon\n");
-		return ret;
-	}
-
-	ret = ttm_bo_kmap(&bo->bo, 0, bo->bo.num_pages,
-			  &bo->kmap);
-	if (ret) {
-		DRM_ERROR("failed to kmap fbcon\n");
-		return ret;
-	}
-
-	/* init fb device */
-	info = drm_fb_helper_alloc_fbi(helper);
-	if (IS_ERR(info)) {
-		DRM_ERROR("Failed to allocate fbi: %ld\n", PTR_ERR(info));
-		return PTR_ERR(info);
-	}
-
-	info->par = &bochs->fb.helper;
-
-	fb = drm_gem_fbdev_fb_create(bochs->dev, sizes, 0, gobj, NULL);
-	if (IS_ERR(fb)) {
-		DRM_ERROR("Failed to create framebuffer: %ld\n", PTR_ERR(fb));
-		return PTR_ERR(fb);
-	}
-
-	/* setup helper */
-	bochs->fb.helper.fb = fb;
-
-	strcpy(info->fix.id, "bochsdrmfb");
-
-	info->fbops = &bochsfb_ops;
-
-	drm_fb_helper_fill_fix(info, fb->pitches[0], fb->format->depth);
-	drm_fb_helper_fill_var(info, &bochs->fb.helper, sizes->fb_width,
-			       sizes->fb_height);
-
-	info->screen_base = bo->kmap.virtual;
-	info->screen_size = size;
-
-	drm_vma_offset_remove(&bo->bo.bdev->vma_manager, &bo->bo.vma_node);
-	info->fix.smem_start = 0;
-	info->fix.smem_len = size;
-	return 0;
-}
-
-static const struct drm_fb_helper_funcs bochs_fb_helper_funcs = {
-	.fb_probe = bochsfb_create,
-};
-
 static struct drm_framebuffer *
 bochs_gem_fb_create(struct drm_device *dev, struct drm_file *file,
 		    const struct drm_mode_fb_cmd2 *mode_cmd)
@@ -145,14 +27,3 @@ const struct drm_mode_config_funcs bochs_mode_funcs = {
 	.atomic_check = drm_atomic_helper_check,
 	.atomic_commit = drm_atomic_helper_commit,
 };
-
-int bochs_fbdev_init(struct bochs_device *bochs)
-{
-	return drm_fb_helper_fbdev_setup(bochs->dev, &bochs->fb.helper,
-					 &bochs_fb_helper_funcs, 32, 1);
-}
-
-void bochs_fbdev_fini(struct bochs_device *bochs)
-{
-	drm_fb_helper_fbdev_teardown(bochs->dev);
-}
-- 
2.9.3

