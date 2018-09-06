Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548CBC4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C1B2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 22:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lekensteyn.nl header.i=@lekensteyn.nl header.b="eR0QjXEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C1B2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lekensteyn.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeIGCz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 22:55:57 -0400
Received: from lekensteyn.nl ([178.21.112.251]:35275 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbeIGCzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 22:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2015-q1;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=OJ0vrBcWUBttYkCphcfVAggucY4nIcj0n8YXd1H2fEk=;
        b=eR0QjXEceGMiOcgVqU5NJtm0nOVXyxw11avGCYcazuyXQhdhI6CZgJEqAzK+gP+FamSUmMVL/v6pbYR5ipJgToaZgOcc9aMHGL0bzoY8ltQbrGq5JZ/J3hBq6b0xQBRFOHSDs7U7WYhnq3xL93GMOc4bQl+/RHuuQ2eOZ45B3YJduYh6WJm0F4LEShZRQ25cj7yAj6OOuR5Py0JfFV/7fpJIVXvDN/MOMrQni/0DjzYLLX0jsH8fUiM3cIWF4jZgiAQN1qnrmn4k3pi+DsS9/C6W5ShssXidPM8SEjczuzasS1mVxeQ093TeGGKQG+AQBCpbKXU4KbCm3bKhJ8qtKA==;
Received: by lekensteyn.nl with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <peter@lekensteyn.nl>)
        id 1fy2bN-0005Us-28; Fri, 07 Sep 2018 00:18:13 +0200
From:   Peter Wu <peter@lekensteyn.nl>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH v2 2/4] bochs: convert to drm_fb_helper_fbdev_setup/teardown
Date:   Fri,  7 Sep 2018 00:18:08 +0200
Message-Id: <20180906221810.20170-3-peter@lekensteyn.nl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180906221810.20170-1-peter@lekensteyn.nl>
References: <20180906221810.20170-1-peter@lekensteyn.nl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently unloading bochs_drm (after unbinding the vtconsole) results in
a warning about a leaked connector:

    [drm:drm_mode_config_cleanup] *ERROR* connector Virtual-3 leaked!

While investigating a potential fix I noticed that a lot of open-coded
functionality is already implemented elsewhere, so start converting it:
bochs_fbdev_init -> drm_fb_helper_fbdev_setup: trivial (similar impl).
bochs_fbdev_fini -> drm_fb_helper_fbdev_teardown: requires unembedding
"struct drm_framebuffer" from "struct bochs_framebuffer".

Unembedding drm_framebuffer is made easy using drm_gem_fbdev_fb_create
which can replace bochs_fbdev_destroy and custom routines in bochs_mm.c.
For this to work, the GEM object is moved into "drm_framebuffer". After
that, "bochs_framebuffer" is no longer needed and therefore removed.

Remove the unused "size" and "initialized" fields from fb, the latter is
not necessary as drm_fb_helper_fbdev_teardown can be called even if
bochsfb_create fails. This theory was tested by returning early and
late (just before drm_gem_fbdev_fb_create). Both scenarios fail
gracefully although the latter seems to leak the object from
bochsfb_create_object (not a regression).

Guess on the reason for the encoder leak: drm_framebuffer_cleanup was
previously used, but did not destroy much. drm_fb_helper_fbdev_teardown
is now used and calls drm_framebuffer_remove which does a bit more work.

Tested with 'echo 0 > /sys/class/vtconsole/vtcon1/bind; rmmod bochs_drm'
and also with Xorg + fbdev (startx -> xterm). The latter triggered a
warning in ttm_bo_vm_open that existed before, see
https://lkml.kernel.org/r/1464000533-13140-4-git-send-email-mstaudt@suse.de

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
 drivers/gpu/drm/bochs/bochs.h       | 19 ++-----
 drivers/gpu/drm/bochs/bochs_fbdev.c | 79 +++++++----------------------
 drivers/gpu/drm/bochs/bochs_kms.c   |  7 +--
 drivers/gpu/drm/bochs/bochs_mm.c    | 74 ---------------------------
 4 files changed, 22 insertions(+), 157 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index 375bf92cd04f..8514a84fbdbe 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -51,11 +51,6 @@ enum bochs_types {
 	BOCHS_UNKNOWN,
 };
 
-struct bochs_framebuffer {
-	struct drm_framebuffer base;
-	struct drm_gem_object *obj;
-};
-
 struct bochs_device {
 	/* hw */
 	void __iomem   *mmio;
@@ -88,15 +83,11 @@ struct bochs_device {
 
 	/* fbdev */
 	struct {
-		struct bochs_framebuffer gfb;
+		struct drm_framebuffer *fb;
 		struct drm_fb_helper helper;
-		int size;
-		bool initialized;
 	} fb;
 };
 
-#define to_bochs_framebuffer(x) container_of(x, struct bochs_framebuffer, base)
-
 struct bochs_bo {
 	struct ttm_buffer_object bo;
 	struct ttm_placement placement;
@@ -148,15 +139,9 @@ int bochs_dumb_create(struct drm_file *file, struct drm_device *dev,
 int bochs_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
 			   uint32_t handle, uint64_t *offset);
 
-int bochs_framebuffer_init(struct drm_device *dev,
-			   struct bochs_framebuffer *gfb,
-			   const struct drm_mode_fb_cmd2 *mode_cmd,
-			   struct drm_gem_object *obj);
 int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag, u64 *gpu_addr);
 int bochs_bo_unpin(struct bochs_bo *bo);
 
-extern const struct drm_mode_config_funcs bochs_mode_funcs;
-
 /* bochs_kms.c */
 int bochs_kms_init(struct bochs_device *bochs);
 void bochs_kms_fini(struct bochs_device *bochs);
@@ -164,3 +149,5 @@ void bochs_kms_fini(struct bochs_device *bochs);
 /* bochs_fbdev.c */
 int bochs_fbdev_init(struct bochs_device *bochs);
 void bochs_fbdev_fini(struct bochs_device *bochs);
+
+extern const struct drm_mode_config_funcs bochs_mode_funcs;
diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
index 14eb8d0d5a00..8f4d6c052f7b 100644
--- a/drivers/gpu/drm/bochs/bochs_fbdev.c
+++ b/drivers/gpu/drm/bochs/bochs_fbdev.c
@@ -6,6 +6,7 @@
  */
 
 #include "bochs.h"
+#include <drm/drm_gem_framebuffer_helper.h>
 
 /* ---------------------------------------------------------------------- */
 
@@ -13,9 +14,7 @@ static int bochsfb_mmap(struct fb_info *info,
 			struct vm_area_struct *vma)
 {
 	struct drm_fb_helper *fb_helper = info->par;
-	struct bochs_device *bochs =
-		container_of(fb_helper, struct bochs_device, fb.helper);
-	struct bochs_bo *bo = gem_to_bochs_bo(bochs->fb.gfb.obj);
+	struct bochs_bo *bo = gem_to_bochs_bo(fb_helper->fb->obj[0]);
 
 	return ttm_fbdev_mmap(vma, &bo->bo);
 }
@@ -101,19 +100,20 @@ static int bochsfb_create(struct drm_fb_helper *helper,
 
 	/* init fb device */
 	info = drm_fb_helper_alloc_fbi(helper);
-	if (IS_ERR(info))
+	if (IS_ERR(info)) {
+		DRM_ERROR("Failed to allocate fbi: %ld\n", PTR_ERR(info));
 		return PTR_ERR(info);
+	}
 
 	info->par = &bochs->fb.helper;
 
-	ret = bochs_framebuffer_init(bochs->dev, &bochs->fb.gfb, &mode_cmd, gobj);
-	if (ret)
-		return ret;
-
-	bochs->fb.size = size;
+	fb = drm_gem_fbdev_fb_create(bochs->dev, sizes, 0, gobj, NULL);
+	if (IS_ERR(fb)) {
+		DRM_ERROR("Failed to create framebuffer: %ld\n", PTR_ERR(fb));
+		return PTR_ERR(fb);
+	}
 
 	/* setup helper */
-	fb = &bochs->fb.gfb.base;
 	bochs->fb.helper.fb = fb;
 
 	strcpy(info->fix.id, "bochsdrmfb");
@@ -130,27 +130,6 @@ static int bochsfb_create(struct drm_fb_helper *helper,
 	drm_vma_offset_remove(&bo->bo.bdev->vma_manager, &bo->bo.vma_node);
 	info->fix.smem_start = 0;
 	info->fix.smem_len = size;
-
-	bochs->fb.initialized = true;
-	return 0;
-}
-
-static int bochs_fbdev_destroy(struct bochs_device *bochs)
-{
-	struct bochs_framebuffer *gfb = &bochs->fb.gfb;
-
-	DRM_DEBUG_DRIVER("\n");
-
-	drm_fb_helper_unregister_fbi(&bochs->fb.helper);
-
-	if (gfb->obj) {
-		drm_gem_object_unreference_unlocked(gfb->obj);
-		gfb->obj = NULL;
-	}
-
-	drm_framebuffer_unregister_private(&gfb->base);
-	drm_framebuffer_cleanup(&gfb->base);
-
 	return 0;
 }
 
@@ -158,41 +137,17 @@ static const struct drm_fb_helper_funcs bochs_fb_helper_funcs = {
 	.fb_probe = bochsfb_create,
 };
 
+const struct drm_mode_config_funcs bochs_mode_funcs = {
+	.fb_create = drm_gem_fb_create,
+};
+
 int bochs_fbdev_init(struct bochs_device *bochs)
 {
-	int ret;
-
-	drm_fb_helper_prepare(bochs->dev, &bochs->fb.helper,
-			      &bochs_fb_helper_funcs);
-
-	ret = drm_fb_helper_init(bochs->dev, &bochs->fb.helper, 1);
-	if (ret)
-		return ret;
-
-	ret = drm_fb_helper_single_add_all_connectors(&bochs->fb.helper);
-	if (ret)
-		goto fini;
-
-	drm_helper_disable_unused_functions(bochs->dev);
-
-	ret = drm_fb_helper_initial_config(&bochs->fb.helper, 32);
-	if (ret)
-		goto fini;
-
-	return 0;
-
-fini:
-	drm_fb_helper_fini(&bochs->fb.helper);
-	return ret;
+	return drm_fb_helper_fbdev_setup(bochs->dev, &bochs->fb.helper,
+					 &bochs_fb_helper_funcs, 32, 1);
 }
 
 void bochs_fbdev_fini(struct bochs_device *bochs)
 {
-	if (bochs->fb.initialized)
-		bochs_fbdev_destroy(bochs);
-
-	if (bochs->fb.helper.fbdev)
-		drm_fb_helper_fini(&bochs->fb.helper);
-
-	bochs->fb.initialized = false;
+	drm_fb_helper_fbdev_teardown(bochs->dev);
 }
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index ca5a9afdd5cf..ea9a43d31bf1 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -35,14 +35,12 @@ static int bochs_crtc_mode_set_base(struct drm_crtc *crtc, int x, int y,
 {
 	struct bochs_device *bochs =
 		container_of(crtc, struct bochs_device, crtc);
-	struct bochs_framebuffer *bochs_fb;
 	struct bochs_bo *bo;
 	u64 gpu_addr = 0;
 	int ret;
 
 	if (old_fb) {
-		bochs_fb = to_bochs_framebuffer(old_fb);
-		bo = gem_to_bochs_bo(bochs_fb->obj);
+		bo = gem_to_bochs_bo(old_fb->obj[0]);
 		ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
 		if (ret) {
 			DRM_ERROR("failed to reserve old_fb bo\n");
@@ -55,8 +53,7 @@ static int bochs_crtc_mode_set_base(struct drm_crtc *crtc, int x, int y,
 	if (WARN_ON(crtc->primary->fb == NULL))
 		return -EINVAL;
 
-	bochs_fb = to_bochs_framebuffer(crtc->primary->fb);
-	bo = gem_to_bochs_bo(bochs_fb->obj);
+	bo = gem_to_bochs_bo(crtc->primary->fb->obj[0]);
 	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
index c9c7097030ca..a61c1ecb2bdc 100644
--- a/drivers/gpu/drm/bochs/bochs_mm.c
+++ b/drivers/gpu/drm/bochs/bochs_mm.c
@@ -457,77 +457,3 @@ int bochs_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
 	drm_gem_object_unreference_unlocked(obj);
 	return 0;
 }
-
-/* ---------------------------------------------------------------------- */
-
-static void bochs_user_framebuffer_destroy(struct drm_framebuffer *fb)
-{
-	struct bochs_framebuffer *bochs_fb = to_bochs_framebuffer(fb);
-
-	drm_gem_object_unreference_unlocked(bochs_fb->obj);
-	drm_framebuffer_cleanup(fb);
-	kfree(fb);
-}
-
-static const struct drm_framebuffer_funcs bochs_fb_funcs = {
-	.destroy = bochs_user_framebuffer_destroy,
-};
-
-int bochs_framebuffer_init(struct drm_device *dev,
-			   struct bochs_framebuffer *gfb,
-			   const struct drm_mode_fb_cmd2 *mode_cmd,
-			   struct drm_gem_object *obj)
-{
-	int ret;
-
-	drm_helper_mode_fill_fb_struct(dev, &gfb->base, mode_cmd);
-	gfb->obj = obj;
-	ret = drm_framebuffer_init(dev, &gfb->base, &bochs_fb_funcs);
-	if (ret) {
-		DRM_ERROR("drm_framebuffer_init failed: %d\n", ret);
-		return ret;
-	}
-	return 0;
-}
-
-static struct drm_framebuffer *
-bochs_user_framebuffer_create(struct drm_device *dev,
-			      struct drm_file *filp,
-			      const struct drm_mode_fb_cmd2 *mode_cmd)
-{
-	struct drm_gem_object *obj;
-	struct bochs_framebuffer *bochs_fb;
-	int ret;
-
-	DRM_DEBUG_DRIVER("%dx%d, format %c%c%c%c\n",
-	       mode_cmd->width, mode_cmd->height,
-	       (mode_cmd->pixel_format)       & 0xff,
-	       (mode_cmd->pixel_format >> 8)  & 0xff,
-	       (mode_cmd->pixel_format >> 16) & 0xff,
-	       (mode_cmd->pixel_format >> 24) & 0xff);
-
-	if (mode_cmd->pixel_format != DRM_FORMAT_XRGB8888)
-		return ERR_PTR(-ENOENT);
-
-	obj = drm_gem_object_lookup(filp, mode_cmd->handles[0]);
-	if (obj == NULL)
-		return ERR_PTR(-ENOENT);
-
-	bochs_fb = kzalloc(sizeof(*bochs_fb), GFP_KERNEL);
-	if (!bochs_fb) {
-		drm_gem_object_unreference_unlocked(obj);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	ret = bochs_framebuffer_init(dev, bochs_fb, mode_cmd, obj);
-	if (ret) {
-		drm_gem_object_unreference_unlocked(obj);
-		kfree(bochs_fb);
-		return ERR_PTR(ret);
-	}
-	return &bochs_fb->base;
-}
-
-const struct drm_mode_config_funcs bochs_mode_funcs = {
-	.fb_create = bochs_user_framebuffer_create,
-};
-- 
2.18.0

