Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A695C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9160F206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lekensteyn.nl header.i=@lekensteyn.nl header.b="P5heOzBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9160F206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lekensteyn.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbeIJSQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:16:18 -0400
Received: from lekensteyn.nl ([178.21.112.251]:58669 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728422AbeIJSQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2015-q1;
        h=Message-Id:Date:Subject:Cc:To:From; bh=CwxeUv7ON8n6a7QXelZTRr9oGgyzTCl+5IWeSOOpco4=;
        b=P5heOzBkWDkgW+W7AGP+fjggj+j4wwWDzO4gQuZ5gV0XTvZ1g9B3k7bsKIWFjMQ9NwTRRZXV2tY6qNpgFZ6AAZYACy5zFl3VmlVxGekmpTwf7l5bt2vYeLvwLEfzZv6K16vxZww0sSbglcTbIdxplacBTzXbWcAPCFkOxoFwaG9SXU9CrCqETq7F1LkSflC4yZZ8XxnJrSG4uQCvlBs285vvmkGbXuD2F7OxTPImnMsBd6ghMPocWbXBrgkrUKqTPG/ZW0QzTfow4GtP2fSWHevxQDUiGCap/9wqsuuAOUmcBAiNNB/TUEf3e+8WdC8bSlqLEEZMV8F1jDB7MfP5fQ==;
Received: by lekensteyn.nl with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <peter@lekensteyn.nl>)
        id 1fzM8d-0002Wk-8r; Mon, 10 Sep 2018 15:22:01 +0200
From:   Peter Wu <peter@lekensteyn.nl>
To:     Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] qxl: refactor to use drm_fb_helper_fbdev_setup
Date:   Mon, 10 Sep 2018 15:21:56 +0200
Message-Id: <20180910132156.23201-1-peter@lekensteyn.nl>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lots of code can be removed by relying on fb-helper:
- "struct drm_framebuffer" moves to fb_helper.fb.
- "struct drm_gem_object" moves to fb_helper.obj[0].
- "struct qxl_device" can be inferred as drm_fb_helper is embedded.
- qxl_user_framebuffer_create -> drm_gem_fb_create.
- qxl_user_framebuffer_destroy -> drm_gem_fb_destroy.
- qxl_fbdev_destroy -> drm_fb_helper_fbdev_teardown + vfree(shadow).

Remove unused code:
- qxl_fbdev_qobj_is_fb, qxl_fbdev_set_suspend.
- Unused fields of qxl_fbdev: delayed_ops, delayed_ops_lock, size.

Misc notes:
- The dirty callback is preserved as it is necessary to trigger update
  commands in the hw (the screen stays black otherwise).
- No idea when .create_handle in drm_framebuffer_funcs is used, but use
  the same drm_gem_fb_create_handle to match drm_gem_fb_funcs.
- I don't know why qxl_fb_find_or_create_single used to check for an
  existing framebuffer and removed that check to match other drivers.
- Use of drm_fb_helper_fbdev_teardown also requires "info->fbdefio" to
  be dynamically allocated. Replace the existing defio config by
  drm_fb_helper_defio_init to accomodate this.

Testing results: startx with fbdev, modesetting and qxl all seems to
work. Tested also with CONFIG_DRM_FBDEV_EMULATION=n, fbdev obviously
fails but others are fine. QEMU -spice and QEMU -spice with vdagent and
multiple (resized) displays (via remote-viewer) also works.
unbind vtconsole and rmmod has *not* regressed (i.e. it still trips on a
use-after-free in qxl_check_idle via qxl_ttm_fini).

Ideally setup/teardown is replaced by drm_fbdev_generic_setup as that
would result in further code reduction, improve error handling (like not
leaking shadow memory), but unfortunately QXL has no implementation for
qxl_gem_prime_vmap.

Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
rmmod/unbind PCI driver is still broken for both the
CONFIG_DRM_FBDEV_EMULATION=y/n cases, but hopefully this cleanup makes it easier
to prepare further fixes (if it is worth it).
---
 drivers/gpu/drm/qxl/qxl_display.c | 101 +++------------
 drivers/gpu/drm/qxl/qxl_draw.c    |   6 +-
 drivers/gpu/drm/qxl/qxl_drv.h     |  32 +----
 drivers/gpu/drm/qxl/qxl_fb.c      | 197 +++++-------------------------
 4 files changed, 60 insertions(+), 276 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 01704a7f07cb..87d16a0ce01e 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -28,6 +28,7 @@
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_atomic.h>
+#include <drm/drm_gem_framebuffer_helper.h>
 
 #include "qxl_drv.h"
 #include "qxl_object.h"
@@ -388,17 +389,6 @@ static const struct drm_crtc_funcs qxl_crtc_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
 };
 
-void qxl_user_framebuffer_destroy(struct drm_framebuffer *fb)
-{
-	struct qxl_framebuffer *qxl_fb = to_qxl_framebuffer(fb);
-	struct qxl_bo *bo = gem_to_qxl_bo(qxl_fb->obj);
-
-	WARN_ON(bo->shadow);
-	drm_gem_object_put_unlocked(qxl_fb->obj);
-	drm_framebuffer_cleanup(fb);
-	kfree(qxl_fb);
-}
-
 static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
 					 struct drm_file *file_priv,
 					 unsigned flags, unsigned color,
@@ -406,15 +396,14 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
 					 unsigned num_clips)
 {
 	/* TODO: vmwgfx where this was cribbed from had locking. Why? */
-	struct qxl_framebuffer *qxl_fb = to_qxl_framebuffer(fb);
-	struct qxl_device *qdev = qxl_fb->base.dev->dev_private;
+	struct qxl_device *qdev = fb->dev->dev_private;
 	struct drm_clip_rect norect;
 	struct qxl_bo *qobj;
 	int inc = 1;
 
 	drm_modeset_lock_all(fb->dev);
 
-	qobj = gem_to_qxl_bo(qxl_fb->obj);
+	qobj = gem_to_qxl_bo(fb->obj[0]);
 	/* if we aren't primary surface ignore this */
 	if (!qobj->is_primary) {
 		drm_modeset_unlock_all(fb->dev);
@@ -432,7 +421,7 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
 		inc = 2; /* skip source rects */
 	}
 
-	qxl_draw_dirty_fb(qdev, qxl_fb, qobj, flags, color,
+	qxl_draw_dirty_fb(qdev, fb, qobj, flags, color,
 			  clips, num_clips, inc);
 
 	drm_modeset_unlock_all(fb->dev);
@@ -441,31 +430,11 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
 }
 
 static const struct drm_framebuffer_funcs qxl_fb_funcs = {
-	.destroy = qxl_user_framebuffer_destroy,
+	.destroy = drm_gem_fb_destroy,
 	.dirty = qxl_framebuffer_surface_dirty,
-/*	TODO?
- *	.create_handle = qxl_user_framebuffer_create_handle, */
+	.create_handle = drm_gem_fb_create_handle,
 };
 
-int
-qxl_framebuffer_init(struct drm_device *dev,
-		     struct qxl_framebuffer *qfb,
-		     const struct drm_mode_fb_cmd2 *mode_cmd,
-		     struct drm_gem_object *obj,
-		     const struct drm_framebuffer_funcs *funcs)
-{
-	int ret;
-
-	qfb->obj = obj;
-	drm_helper_mode_fill_fb_struct(dev, &qfb->base, mode_cmd);
-	ret = drm_framebuffer_init(dev, &qfb->base, funcs);
-	if (ret) {
-		qfb->obj = NULL;
-		return ret;
-	}
-	return 0;
-}
-
 static void qxl_crtc_atomic_enable(struct drm_crtc *crtc,
 				   struct drm_crtc_state *old_state)
 {
@@ -488,14 +457,12 @@ static int qxl_primary_atomic_check(struct drm_plane *plane,
 				    struct drm_plane_state *state)
 {
 	struct qxl_device *qdev = plane->dev->dev_private;
-	struct qxl_framebuffer *qfb;
 	struct qxl_bo *bo;
 
 	if (!state->crtc || !state->fb)
 		return 0;
 
-	qfb = to_qxl_framebuffer(state->fb);
-	bo = gem_to_qxl_bo(qfb->obj);
+	bo = gem_to_qxl_bo(state->fb->obj[0]);
 
 	if (bo->surf.stride * bo->surf.height > qdev->vram_size) {
 		DRM_ERROR("Mode doesn't fit in vram size (vgamem)");
@@ -556,23 +523,19 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 				      struct drm_plane_state *old_state)
 {
 	struct qxl_device *qdev = plane->dev->dev_private;
-	struct qxl_framebuffer *qfb =
-		to_qxl_framebuffer(plane->state->fb);
-	struct qxl_framebuffer *qfb_old;
-	struct qxl_bo *bo = gem_to_qxl_bo(qfb->obj);
+	struct qxl_bo *bo = gem_to_qxl_bo(plane->state->fb->obj[0]);
 	struct qxl_bo *bo_old;
 	struct drm_clip_rect norect = {
 	    .x1 = 0,
 	    .y1 = 0,
-	    .x2 = qfb->base.width,
-	    .y2 = qfb->base.height
+	    .x2 = plane->state->fb->width,
+	    .y2 = plane->state->fb->height
 	};
 	int ret;
 	bool same_shadow = false;
 
 	if (old_state->fb) {
-		qfb_old = to_qxl_framebuffer(old_state->fb);
-		bo_old = gem_to_qxl_bo(qfb_old->obj);
+		bo_old = gem_to_qxl_bo(old_state->fb->obj[0]);
 	} else {
 		bo_old = NULL;
 	}
@@ -602,7 +565,7 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 		bo->is_primary = true;
 	}
 
-	qxl_draw_dirty_fb(qdev, qfb, bo, 0, 0, &norect, 1, 1);
+	qxl_draw_dirty_fb(qdev, plane->state->fb, bo, 0, 0, &norect, 1, 1);
 }
 
 static void qxl_primary_atomic_disable(struct drm_plane *plane,
@@ -611,9 +574,7 @@ static void qxl_primary_atomic_disable(struct drm_plane *plane,
 	struct qxl_device *qdev = plane->dev->dev_private;
 
 	if (old_state->fb) {
-		struct qxl_framebuffer *qfb =
-			to_qxl_framebuffer(old_state->fb);
-		struct qxl_bo *bo = gem_to_qxl_bo(qfb->obj);
+		struct qxl_bo *bo = gem_to_qxl_bo(old_state->fb->obj[0]);
 
 		if (bo->is_primary) {
 			qxl_io_destroy_primary(qdev);
@@ -645,7 +606,7 @@ static void qxl_cursor_atomic_update(struct drm_plane *plane,
 		return;
 
 	if (fb != old_state->fb) {
-		obj = to_qxl_framebuffer(fb)->obj;
+		obj = fb->obj[0];
 		user_bo = gem_to_qxl_bo(obj);
 
 		/* pinning is done in the prepare/cleanup framevbuffer */
@@ -765,13 +726,13 @@ static int qxl_plane_prepare_fb(struct drm_plane *plane,
 	if (!new_state->fb)
 		return 0;
 
-	obj = to_qxl_framebuffer(new_state->fb)->obj;
+	obj = new_state->fb->obj[0];
 	user_bo = gem_to_qxl_bo(obj);
 
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY &&
 	    user_bo->is_dumb && !user_bo->shadow) {
 		if (plane->state->fb) {
-			obj = to_qxl_framebuffer(plane->state->fb)->obj;
+			obj = plane->state->fb->obj[0];
 			old_bo = gem_to_qxl_bo(obj);
 		}
 		if (old_bo && old_bo->shadow &&
@@ -815,7 +776,7 @@ static void qxl_plane_cleanup_fb(struct drm_plane *plane,
 		return;
 	}
 
-	obj = to_qxl_framebuffer(old_state->fb)->obj;
+	obj = old_state->fb->obj[0];
 	user_bo = gem_to_qxl_bo(obj);
 	qxl_bo_unpin(user_bo);
 
@@ -1115,26 +1076,8 @@ qxl_user_framebuffer_create(struct drm_device *dev,
 			    struct drm_file *file_priv,
 			    const struct drm_mode_fb_cmd2 *mode_cmd)
 {
-	struct drm_gem_object *obj;
-	struct qxl_framebuffer *qxl_fb;
-	int ret;
-
-	obj = drm_gem_object_lookup(file_priv, mode_cmd->handles[0]);
-	if (!obj)
-		return NULL;
-
-	qxl_fb = kzalloc(sizeof(*qxl_fb), GFP_KERNEL);
-	if (qxl_fb == NULL)
-		return NULL;
-
-	ret = qxl_framebuffer_init(dev, qxl_fb, mode_cmd, obj, &qxl_fb_funcs);
-	if (ret) {
-		kfree(qxl_fb);
-		drm_gem_object_put_unlocked(obj);
-		return NULL;
-	}
-
-	return &qxl_fb->base;
+	return drm_gem_fb_create_with_funcs(dev, file_priv, mode_cmd,
+					    &qxl_fb_funcs);
 }
 
 static const struct drm_mode_config_funcs qxl_mode_funcs = {
@@ -1221,7 +1164,6 @@ int qxl_modeset_init(struct qxl_device *qdev)
 	}
 
 	qxl_display_read_client_monitors_config(qdev);
-	qdev->mode_info.mode_config_initialized = true;
 
 	drm_mode_config_reset(&qdev->ddev);
 
@@ -1237,8 +1179,5 @@ void qxl_modeset_fini(struct qxl_device *qdev)
 	qxl_fbdev_fini(qdev);
 
 	qxl_destroy_monitors_object(qdev);
-	if (qdev->mode_info.mode_config_initialized) {
-		drm_mode_config_cleanup(&qdev->ddev);
-		qdev->mode_info.mode_config_initialized = false;
-	}
+	drm_mode_config_cleanup(&qdev->ddev);
 }
diff --git a/drivers/gpu/drm/qxl/qxl_draw.c b/drivers/gpu/drm/qxl/qxl_draw.c
index 4d8681e84e68..cc5b32e749ce 100644
--- a/drivers/gpu/drm/qxl/qxl_draw.c
+++ b/drivers/gpu/drm/qxl/qxl_draw.c
@@ -262,7 +262,7 @@ void qxl_draw_opaque_fb(const struct qxl_fb_image *qxl_fb_image,
  * by treating them differently in the server.
  */
 void qxl_draw_dirty_fb(struct qxl_device *qdev,
-		       struct qxl_framebuffer *qxl_fb,
+		       struct drm_framebuffer *fb,
 		       struct qxl_bo *bo,
 		       unsigned flags, unsigned color,
 		       struct drm_clip_rect *clips,
@@ -281,9 +281,9 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 	struct qxl_drawable *drawable;
 	struct qxl_rect drawable_rect;
 	struct qxl_rect *rects;
-	int stride = qxl_fb->base.pitches[0];
+	int stride = fb->pitches[0];
 	/* depth is not actually interesting, we don't mask with it */
-	int depth = qxl_fb->base.format->cpp[0] * 8;
+	int depth = fb->format->cpp[0] * 8;
 	uint8_t *surface_base;
 	struct qxl_release *release;
 	struct qxl_bo *clips_bo;
diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 01220d386b0a..8ff70a7281a7 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -38,6 +38,7 @@
 
 #include <drm/drm_crtc.h>
 #include <drm/drm_encoder.h>
+#include <drm/drm_fb_helper.h>
 #include <drm/drm_gem.h>
 #include <drm/drmP.h>
 #include <drm/ttm/ttm_bo_api.h>
@@ -121,15 +122,9 @@ struct qxl_output {
 	struct drm_encoder enc;
 };
 
-struct qxl_framebuffer {
-	struct drm_framebuffer base;
-	struct drm_gem_object *obj;
-};
-
 #define to_qxl_crtc(x) container_of(x, struct qxl_crtc, base)
 #define drm_connector_to_qxl_output(x) container_of(x, struct qxl_output, base)
 #define drm_encoder_to_qxl_output(x) container_of(x, struct qxl_output, enc)
-#define to_qxl_framebuffer(x) container_of(x, struct qxl_framebuffer, base)
 
 struct qxl_mman {
 	struct ttm_bo_global_ref        bo_global_ref;
@@ -138,13 +133,6 @@ struct qxl_mman {
 	struct ttm_bo_device		bdev;
 };
 
-struct qxl_mode_info {
-	bool mode_config_initialized;
-
-	/* pointer to fbdev info structure */
-	struct qxl_fbdev *qfbdev;
-};
-
 
 struct qxl_memslot {
 	uint8_t		generation;
@@ -232,10 +220,9 @@ struct qxl_device {
 	void *ram;
 	struct qxl_mman		mman;
 	struct qxl_gem		gem;
-	struct qxl_mode_info mode_info;
 
-	struct fb_info			*fbdev_info;
-	struct qxl_framebuffer	*fbdev_qfb;
+	struct drm_fb_helper	fb_helper;
+
 	void *ram_physical;
 
 	struct qxl_ring *release_ring;
@@ -349,19 +336,8 @@ qxl_bo_physical_address(struct qxl_device *qdev, struct qxl_bo *bo,
 
 int qxl_fbdev_init(struct qxl_device *qdev);
 void qxl_fbdev_fini(struct qxl_device *qdev);
-int qxl_get_handle_for_primary_fb(struct qxl_device *qdev,
-				  struct drm_file *file_priv,
-				  uint32_t *handle);
-void qxl_fbdev_set_suspend(struct qxl_device *qdev, int state);
 
 /* qxl_display.c */
-void qxl_user_framebuffer_destroy(struct drm_framebuffer *fb);
-int
-qxl_framebuffer_init(struct drm_device *dev,
-		     struct qxl_framebuffer *rfb,
-		     const struct drm_mode_fb_cmd2 *mode_cmd,
-		     struct drm_gem_object *obj,
-		     const struct drm_framebuffer_funcs *funcs);
 void qxl_display_read_client_monitors_config(struct qxl_device *qdev);
 int qxl_create_monitors_object(struct qxl_device *qdev);
 int qxl_destroy_monitors_object(struct qxl_device *qdev);
@@ -471,7 +447,7 @@ void qxl_draw_opaque_fb(const struct qxl_fb_image *qxl_fb_image,
 			int stride /* filled in if 0 */);
 
 void qxl_draw_dirty_fb(struct qxl_device *qdev,
-		       struct qxl_framebuffer *qxl_fb,
+		       struct drm_framebuffer *fb,
 		       struct qxl_bo *bo,
 		       unsigned flags, unsigned color,
 		       struct drm_clip_rect *clips,
diff --git a/drivers/gpu/drm/qxl/qxl_fb.c b/drivers/gpu/drm/qxl/qxl_fb.c
index ca465c0d49fa..2294b7f14fdf 100644
--- a/drivers/gpu/drm/qxl/qxl_fb.c
+++ b/drivers/gpu/drm/qxl/qxl_fb.c
@@ -30,24 +30,12 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
 
 #include "qxl_drv.h"
 
 #include "qxl_object.h"
 
-#define QXL_DIRTY_DELAY (HZ / 30)
-
-struct qxl_fbdev {
-	struct drm_fb_helper helper;
-	struct qxl_framebuffer	qfb;
-	struct qxl_device	*qdev;
-
-	spinlock_t delayed_ops_lock;
-	struct list_head delayed_ops;
-	void *shadow;
-	int size;
-};
-
 static void qxl_fb_image_init(struct qxl_fb_image *qxl_fb_image,
 			      struct qxl_device *qdev, struct fb_info *info,
 			      const struct fb_image *image)
@@ -73,13 +61,6 @@ static void qxl_fb_image_init(struct qxl_fb_image *qxl_fb_image,
 	}
 }
 
-#ifdef CONFIG_DRM_FBDEV_EMULATION
-static struct fb_deferred_io qxl_defio = {
-	.delay		= QXL_DIRTY_DELAY,
-	.deferred_io	= drm_fb_helper_deferred_io,
-};
-#endif
-
 static struct fb_ops qxlfb_ops = {
 	.owner = THIS_MODULE,
 	DRM_FB_HELPER_DEFAULT_OPS,
@@ -98,26 +79,10 @@ static void qxlfb_destroy_pinned_object(struct drm_gem_object *gobj)
 	drm_gem_object_put_unlocked(gobj);
 }
 
-int qxl_get_handle_for_primary_fb(struct qxl_device *qdev,
-				  struct drm_file *file_priv,
-				  uint32_t *handle)
-{
-	int r;
-	struct drm_gem_object *gobj = qdev->fbdev_qfb->obj;
-
-	BUG_ON(!gobj);
-	/* drm_get_handle_create adds a reference - good */
-	r = drm_gem_handle_create(file_priv, gobj, handle);
-	if (r)
-		return r;
-	return 0;
-}
-
-static int qxlfb_create_pinned_object(struct qxl_fbdev *qfbdev,
+static int qxlfb_create_pinned_object(struct qxl_device *qdev,
 				      const struct drm_mode_fb_cmd2 *mode_cmd,
 				      struct drm_gem_object **gobj_p)
 {
-	struct qxl_device *qdev = qfbdev->qdev;
 	struct drm_gem_object *gobj = NULL;
 	struct qxl_bo *qbo = NULL;
 	int ret;
@@ -174,13 +139,12 @@ static int qxlfb_framebuffer_dirty(struct drm_framebuffer *fb,
 				   unsigned num_clips)
 {
 	struct qxl_device *qdev = fb->dev->dev_private;
-	struct fb_info *info = qdev->fbdev_info;
-	struct qxl_fbdev *qfbdev = info->par;
+	struct fb_info *info = qdev->fb_helper.fbdev;
 	struct qxl_fb_image qxl_fb_image;
 	struct fb_image *image = &qxl_fb_image.fb_image;
 
 	/* TODO: hard coding 32 bpp */
-	int stride = qfbdev->qfb.base.pitches[0];
+	int stride = fb->pitches[0];
 
 	/*
 	 * we are using a shadow draw buffer, at qdev->surface0_shadow
@@ -199,7 +163,7 @@ static int qxlfb_framebuffer_dirty(struct drm_framebuffer *fb,
 	image->cmap.green = NULL;
 	image->cmap.blue = NULL;
 	image->cmap.transp = NULL;
-	image->data = qfbdev->shadow + (clips->x1 * 4) + (stride * clips->y1);
+	image->data = info->screen_base + (clips->x1 * 4) + (stride * clips->y1);
 
 	qxl_fb_image_init(&qxl_fb_image, qdev, info, NULL);
 	qxl_draw_opaque_fb(&qxl_fb_image, stride);
@@ -208,21 +172,22 @@ static int qxlfb_framebuffer_dirty(struct drm_framebuffer *fb,
 }
 
 static const struct drm_framebuffer_funcs qxlfb_fb_funcs = {
-	.destroy = qxl_user_framebuffer_destroy,
+	.destroy = drm_gem_fb_destroy,
+	.create_handle = drm_gem_fb_create_handle,
 	.dirty = qxlfb_framebuffer_dirty,
 };
 
-static int qxlfb_create(struct qxl_fbdev *qfbdev,
+static int qxlfb_create(struct drm_fb_helper *helper,
 			struct drm_fb_helper_surface_size *sizes)
 {
-	struct qxl_device *qdev = qfbdev->qdev;
+	struct qxl_device *qdev =
+		container_of(helper, struct qxl_device, fb_helper);
 	struct fb_info *info;
 	struct drm_framebuffer *fb = NULL;
 	struct drm_mode_fb_cmd2 mode_cmd;
 	struct drm_gem_object *gobj = NULL;
 	struct qxl_bo *qbo = NULL;
 	int ret;
-	int size;
 	int bpp = sizes->surface_bpp;
 	int depth = sizes->surface_depth;
 	void *shadow;
@@ -233,7 +198,7 @@ static int qxlfb_create(struct qxl_fbdev *qfbdev,
 	mode_cmd.pitches[0] = ALIGN(mode_cmd.width * ((bpp + 1) / 8), 64);
 	mode_cmd.pixel_format = drm_mode_legacy_fb_format(bpp, depth);
 
-	ret = qxlfb_create_pinned_object(qfbdev, &mode_cmd, &gobj);
+	ret = qxlfb_create_pinned_object(qdev, &mode_cmd, &gobj);
 	if (ret < 0)
 		return ret;
 
@@ -247,25 +212,26 @@ static int qxlfb_create(struct qxl_fbdev *qfbdev,
 	DRM_DEBUG_DRIVER("surface0 at gpu offset %lld, mmap_offset %lld (virt %p, shadow %p)\n",
 			 qxl_bo_gpu_offset(qbo), qxl_bo_mmap_offset(qbo),
 			 qbo->kptr, shadow);
-	size = mode_cmd.pitches[0] * mode_cmd.height;
 
-	info = drm_fb_helper_alloc_fbi(&qfbdev->helper);
+	info = drm_fb_helper_alloc_fbi(helper);
 	if (IS_ERR(info)) {
 		ret = PTR_ERR(info);
 		goto out_unref;
 	}
 
-	info->par = qfbdev;
-
-	qxl_framebuffer_init(&qdev->ddev, &qfbdev->qfb, &mode_cmd, gobj,
-			     &qxlfb_fb_funcs);
+	info->par = helper;
 
-	fb = &qfbdev->qfb.base;
+	fb = drm_gem_fbdev_fb_create(&qdev->ddev, sizes, 64, gobj,
+				     &qxlfb_fb_funcs);
+	if (IS_ERR(fb)) {
+		DRM_ERROR("Failed to create framebuffer: %ld\n", PTR_ERR(fb));
+		ret = PTR_ERR(fb);
+		goto out_unref;
+	}
 
 	/* setup helper with fb data */
-	qfbdev->helper.fb = fb;
+	qdev->fb_helper.fb = fb;
 
-	qfbdev->shadow = shadow;
 	strcpy(info->fix.id, "qxldrmfb");
 
 	drm_fb_helper_fill_fix(info, fb->pitches[0], fb->format->depth);
@@ -278,10 +244,10 @@ static int qxlfb_create(struct qxl_fbdev *qfbdev,
 	 */
 	info->fix.smem_start = qdev->vram_base; /* TODO - correct? */
 	info->fix.smem_len = gobj->size;
-	info->screen_base = qfbdev->shadow;
+	info->screen_base = shadow;
 	info->screen_size = gobj->size;
 
-	drm_fb_helper_fill_var(info, &qfbdev->helper, sizes->fb_width,
+	drm_fb_helper_fill_var(info, &qdev->fb_helper, sizes->fb_width,
 			       sizes->fb_height);
 
 	/* setup aperture base/size for vesafb takeover */
@@ -296,13 +262,9 @@ static int qxlfb_create(struct qxl_fbdev *qfbdev,
 		goto out_unref;
 	}
 
-#ifdef CONFIG_DRM_FBDEV_EMULATION
-	info->fbdefio = &qxl_defio;
-	fb_deferred_io_init(info);
-#endif
+	/* XXX error handling. */
+	drm_fb_helper_defio_init(helper);
 
-	qdev->fbdev_info = info;
-	qdev->fbdev_qfb = &qfbdev->qfb;
 	DRM_INFO("fb mappable at 0x%lX, size %lu\n",  info->fix.smem_start, (unsigned long)info->screen_size);
 	DRM_INFO("fb: depth %d, pitch %d, width %d, height %d\n",
 		 fb->format->depth, fb->pitches[0], fb->width, fb->height);
@@ -313,119 +275,26 @@ static int qxlfb_create(struct qxl_fbdev *qfbdev,
 		qxl_bo_kunmap(qbo);
 		qxl_bo_unpin(qbo);
 	}
-	if (fb && ret) {
-		drm_gem_object_put_unlocked(gobj);
-		drm_framebuffer_cleanup(fb);
-		kfree(fb);
-	}
 	drm_gem_object_put_unlocked(gobj);
 	return ret;
 }
 
-static int qxl_fb_find_or_create_single(
-		struct drm_fb_helper *helper,
-		struct drm_fb_helper_surface_size *sizes)
-{
-	struct qxl_fbdev *qfbdev =
-		container_of(helper, struct qxl_fbdev, helper);
-	int new_fb = 0;
-	int ret;
-
-	if (!helper->fb) {
-		ret = qxlfb_create(qfbdev, sizes);
-		if (ret)
-			return ret;
-		new_fb = 1;
-	}
-	return new_fb;
-}
-
-static int qxl_fbdev_destroy(struct drm_device *dev, struct qxl_fbdev *qfbdev)
-{
-	struct qxl_framebuffer *qfb = &qfbdev->qfb;
-
-	drm_fb_helper_unregister_fbi(&qfbdev->helper);
-
-	if (qfb->obj) {
-		qxlfb_destroy_pinned_object(qfb->obj);
-		qfb->obj = NULL;
-	}
-	drm_fb_helper_fini(&qfbdev->helper);
-	vfree(qfbdev->shadow);
-	drm_framebuffer_cleanup(&qfb->base);
-
-	return 0;
-}
-
 static const struct drm_fb_helper_funcs qxl_fb_helper_funcs = {
-	.fb_probe = qxl_fb_find_or_create_single,
+	.fb_probe = qxlfb_create,
 };
 
 int qxl_fbdev_init(struct qxl_device *qdev)
 {
-	int ret = 0;
-
-#ifdef CONFIG_DRM_FBDEV_EMULATION
-	struct qxl_fbdev *qfbdev;
-	int bpp_sel = 32; /* TODO: parameter from somewhere? */
-
-	qfbdev = kzalloc(sizeof(struct qxl_fbdev), GFP_KERNEL);
-	if (!qfbdev)
-		return -ENOMEM;
-
-	qfbdev->qdev = qdev;
-	qdev->mode_info.qfbdev = qfbdev;
-	spin_lock_init(&qfbdev->delayed_ops_lock);
-	INIT_LIST_HEAD(&qfbdev->delayed_ops);
-
-	drm_fb_helper_prepare(&qdev->ddev, &qfbdev->helper,
-			      &qxl_fb_helper_funcs);
-
-	ret = drm_fb_helper_init(&qdev->ddev, &qfbdev->helper,
-				 QXLFB_CONN_LIMIT);
-	if (ret)
-		goto free;
-
-	ret = drm_fb_helper_single_add_all_connectors(&qfbdev->helper);
-	if (ret)
-		goto fini;
-
-	ret = drm_fb_helper_initial_config(&qfbdev->helper, bpp_sel);
-	if (ret)
-		goto fini;
-
-	return 0;
-
-fini:
-	drm_fb_helper_fini(&qfbdev->helper);
-free:
-	kfree(qfbdev);
-#endif
-
-	return ret;
+	return drm_fb_helper_fbdev_setup(&qdev->ddev, &qdev->fb_helper,
+					 &qxl_fb_helper_funcs, 32,
+					 QXLFB_CONN_LIMIT);
 }
 
 void qxl_fbdev_fini(struct qxl_device *qdev)
 {
-	if (!qdev->mode_info.qfbdev)
-		return;
+	struct fb_info *fbi = qdev->fb_helper.fbdev;
+	void *shadow = fbi ? fbi->screen_buffer : NULL;
 
-	qxl_fbdev_destroy(&qdev->ddev, qdev->mode_info.qfbdev);
-	kfree(qdev->mode_info.qfbdev);
-	qdev->mode_info.qfbdev = NULL;
-}
-
-void qxl_fbdev_set_suspend(struct qxl_device *qdev, int state)
-{
-	if (!qdev->mode_info.qfbdev)
-		return;
-
-	drm_fb_helper_set_suspend(&qdev->mode_info.qfbdev->helper, state);
-}
-
-bool qxl_fbdev_qobj_is_fb(struct qxl_device *qdev, struct qxl_bo *qobj)
-{
-	if (qobj == gem_to_qxl_bo(qdev->mode_info.qfbdev->qfb.obj))
-		return true;
-	return false;
+	drm_fb_helper_fbdev_teardown(&qdev->ddev);
+	vfree(shadow);
 }
-- 
2.18.0

