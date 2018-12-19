Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7B4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FB0217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbeLSLv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:51:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729464AbeLSLvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:51:42 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7DB4B81DFE;
        Wed, 19 Dec 2018 11:51:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-174.ams2.redhat.com [10.36.117.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 773AE662F4;
        Wed, 19 Dec 2018 11:51:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id BBA265E160; Wed, 19 Dec 2018 12:51:29 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 13/14] drm/bochs: drop old fbdev emulation code
Date:   Wed, 19 Dec 2018 12:51:26 +0100
Message-Id: <20181219115127.31359-14-kraxel@redhat.com>
In-Reply-To: <20181219115127.31359-1-kraxel@redhat.com>
References: <20181219115127.31359-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 19 Dec 2018 11:51:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not needed any more, bochs uses the generic emulation now.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs.h       |   9 ---
 drivers/gpu/drm/bochs/bochs_drv.c   |   6 --
 drivers/gpu/drm/bochs/bochs_fbdev.c | 137 ------------------------------------
 3 files changed, 152 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index 4236d5d811..42a587e71e 100644
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
@@ -161,7 +155,4 @@ int bochs_kms_init(struct bochs_device *bochs);
 void bochs_kms_fini(struct bochs_device *bochs);
 
 /* bochs_fbdev.c */
-int bochs_fbdev_init(struct bochs_device *bochs);
-void bochs_fbdev_fini(struct bochs_device *bochs);
-
 extern const struct drm_mode_config_funcs bochs_mode_funcs;
diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index f1f65324bb..ad1290ca7b 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -110,12 +110,9 @@ static int bochs_pm_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
-	struct bochs_device *bochs = drm_dev->dev_private;
 
 	drm_kms_helper_poll_disable(drm_dev);
 
-	drm_fb_helper_set_suspend_unlocked(&bochs->fb.helper, 1);
-
 	return 0;
 }
 
@@ -123,12 +120,9 @@ static int bochs_pm_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
-	struct bochs_device *bochs = drm_dev->dev_private;
 
 	drm_helper_resume_force_mode(drm_dev);
 
-	drm_fb_helper_set_suspend_unlocked(&bochs->fb.helper, 0);
-
 	drm_kms_helper_poll_enable(drm_dev);
 	return 0;
 }
diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
index 92feb817ff..7cac3f5253 100644
--- a/drivers/gpu/drm/bochs/bochs_fbdev.c
+++ b/drivers/gpu/drm/bochs/bochs_fbdev.c
@@ -11,132 +11,6 @@
 
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
-	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
-	if (ret)
-		return ret;
-
-	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
-	if (ret) {
-		DRM_ERROR("failed to pin fbcon\n");
-		ttm_bo_unreserve(&bo->bo);
-		return ret;
-	}
-
-	ret = ttm_bo_kmap(&bo->bo, 0, bo->bo.num_pages,
-			  &bo->kmap);
-	if (ret) {
-		DRM_ERROR("failed to kmap fbcon\n");
-		ttm_bo_unreserve(&bo->bo);
-		return ret;
-	}
-
-	ttm_bo_unreserve(&bo->bo);
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
@@ -153,14 +27,3 @@ const struct drm_mode_config_funcs bochs_mode_funcs = {
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

