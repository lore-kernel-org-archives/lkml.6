Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC11C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64C32084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64C32084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeLLNV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:21:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbeLLNVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:21:15 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 66D794E92D;
        Wed, 12 Dec 2018 13:21:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-174.ams2.redhat.com [10.36.117.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C14E55D70A;
        Wed, 12 Dec 2018 13:21:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B1B645E194; Wed, 12 Dec 2018 14:21:11 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     spice-devel@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 14/18] drm/qxl: cover all crtcs in shadow bo.
Date:   Wed, 12 Dec 2018 14:21:05 +0100
Message-Id: <20181212132109.8126-15-kraxel@redhat.com>
In-Reply-To: <20181212132109.8126-1-kraxel@redhat.com>
References: <20181212132109.8126-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 12 Dec 2018 13:21:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qxl device supports only a single active framebuffer ("primary
surface" in spice terminology).  In multihead configurations are handled
by defining rectangles within the primary surface for each head/crtc.

Userspace which uses the qxl ioctl interface (xorg qxl driver) is aware
of this limitation and will setup framebuffers and crtcs accordingly.

Userspace which uses dumb framebuffers (xorg modesetting driver,
wayland) is not aware of this limitation and tries to use two
framebuffers (one for each crtc) instead.

The qxl kms driver already has the dumb bo separated from the primary
surface, by using a (shared) shadow bo as primary surface.  This is
needed to support pageflips without having to re-create the primary
surface.  The qxl driver will blit from the dumb bo to the shadow bo
instead.

So we can extend the shadow logic:  Maintain a global shadow bo (aka
primary surface), make it big enough that dumb bo's for all crtcs fit in
side-by-side.  Adjust the pageflip blits to place the heads next to each
other in the shadow.

With this patch in place multihead qxl works with wayland.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h     |   5 +-
 drivers/gpu/drm/qxl/qxl_display.c | 120 +++++++++++++++++++++++++++++---------
 drivers/gpu/drm/qxl/qxl_draw.c    |   9 ++-
 3 files changed, 105 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 150b1a4f66..43c6df9cf9 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -230,6 +230,8 @@ struct qxl_device {
 	struct qxl_ram_header *ram_header;
 
 	struct qxl_bo *primary_bo;
+	struct qxl_bo *dumb_shadow_bo;
+	struct qxl_head *dumb_heads;
 
 	struct qxl_memslot main_slot;
 	struct qxl_memslot surfaces_slot;
@@ -437,7 +439,8 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 		       struct qxl_bo *bo,
 		       unsigned int flags, unsigned int color,
 		       struct drm_clip_rect *clips,
-		       unsigned int num_clips, int inc);
+		       unsigned int num_clips, int inc,
+		       uint32_t dumb_shadow_offset);
 
 void qxl_draw_fill(struct qxl_draw_fill *qxl_draw_fill_rec);
 
diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 204ae46c62..fc88826b69 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -323,6 +323,8 @@ static void qxl_crtc_update_monitors_config(struct drm_crtc *crtc,
 		head.y = crtc->y;
 		if (qdev->monitors_config->count < i + 1)
 			qdev->monitors_config->count = i + 1;
+		if (qdev->primary_bo == qdev->dumb_shadow_bo)
+			head.x += qdev->dumb_heads[i].x;
 	} else if (i > 0) {
 		head.width = 0;
 		head.height = 0;
@@ -426,7 +428,7 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
 	}
 
 	qxl_draw_dirty_fb(qdev, fb, qobj, flags, color,
-			  clips, num_clips, inc);
+			  clips, num_clips, inc, 0);
 
 	drm_modeset_unlock_all(fb->dev);
 
@@ -535,6 +537,7 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 	    .x2 = plane->state->fb->width,
 	    .y2 = plane->state->fb->height
 	};
+	uint32_t dumb_shadow_offset = 0;
 
 	if (old_state->fb) {
 		bo_old = gem_to_qxl_bo(old_state->fb->obj[0]);
@@ -551,7 +554,12 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 		qxl_primary_apply_cursor(plane);
 	}
 
-	qxl_draw_dirty_fb(qdev, plane->state->fb, bo, 0, 0, &norect, 1, 1);
+	if (bo->is_dumb)
+		dumb_shadow_offset =
+			qdev->dumb_heads[plane->state->crtc->index].x;
+
+	qxl_draw_dirty_fb(qdev, plane->state->fb, bo, 0, 0, &norect, 1, 1,
+			  dumb_shadow_offset);
 }
 
 static void qxl_primary_atomic_disable(struct drm_plane *plane,
@@ -707,12 +715,68 @@ static void qxl_cursor_atomic_disable(struct drm_plane *plane,
 	qxl_release_fence_buffer_objects(release);
 }
 
+static void qxl_update_dumb_head(struct qxl_device *qdev,
+				 int index, struct qxl_bo *bo)
+{
+	uint32_t width, height;
+
+	if (index >= qdev->monitors_config->max_allowed)
+		return;
+
+	if (bo && bo->is_dumb) {
+		width = bo->surf.width;
+		height = bo->surf.height;
+	} else {
+		width = 0;
+		height = 0;
+	}
+
+	if (qdev->dumb_heads[index].width == width &&
+	    qdev->dumb_heads[index].height == height)
+		return;
+
+	DRM_DEBUG("#%d: %dx%d -> %dx%d\n", index,
+		  qdev->dumb_heads[index].width,
+		  qdev->dumb_heads[index].height,
+		  width, height);
+	qdev->dumb_heads[index].width = width;
+	qdev->dumb_heads[index].height = height;
+}
+
+static void qxl_calc_dumb_shadow(struct qxl_device *qdev,
+				 struct qxl_surface *surf)
+{
+	struct qxl_head *head;
+	int i;
+
+	memset(surf, 0, sizeof(*surf));
+	for (i = 0; i < qdev->monitors_config->max_allowed; i++) {
+		head = qdev->dumb_heads + i;
+		head->x = surf->width;
+		surf->width += head->width;
+		if (surf->height < head->height)
+			surf->height = head->height;
+	}
+	if (surf->width < 64)
+		surf->width = 64;
+	if (surf->height < 64)
+		surf->height = 64;
+	surf->format = SPICE_SURFACE_FMT_32_xRGB;
+	surf->stride = surf->width * 4;
+
+	if (!qdev->dumb_shadow_bo ||
+	    qdev->dumb_shadow_bo->surf.width != surf->width ||
+	    qdev->dumb_shadow_bo->surf.height != surf->height)
+		DRM_DEBUG("%dx%d\n", surf->width, surf->height);
+}
+
 static int qxl_plane_prepare_fb(struct drm_plane *plane,
 				struct drm_plane_state *new_state)
 {
 	struct qxl_device *qdev = plane->dev->dev_private;
 	struct drm_gem_object *obj;
-	struct qxl_bo *user_bo, *old_bo = NULL;
+	struct qxl_bo *user_bo;
+	struct qxl_surface surf;
 	int ret;
 
 	if (!new_state->fb)
@@ -722,29 +786,31 @@ static int qxl_plane_prepare_fb(struct drm_plane *plane,
 	user_bo = gem_to_qxl_bo(obj);
 
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY &&
-	    user_bo->is_dumb && !user_bo->shadow) {
-		if (plane->state->fb) {
-			obj = plane->state->fb->obj[0];
-			old_bo = gem_to_qxl_bo(obj);
-		}
-		if (old_bo && old_bo->shadow &&
-		    user_bo->gem_base.size == old_bo->gem_base.size &&
-		    plane->state->crtc     == new_state->crtc &&
-		    plane->state->crtc_w   == new_state->crtc_w &&
-		    plane->state->crtc_h   == new_state->crtc_h &&
-		    plane->state->src_x    == new_state->src_x &&
-		    plane->state->src_y    == new_state->src_y &&
-		    plane->state->src_w    == new_state->src_w &&
-		    plane->state->src_h    == new_state->src_h &&
-		    plane->state->rotation == new_state->rotation &&
-		    plane->state->zpos     == new_state->zpos) {
-			drm_gem_object_get(&old_bo->shadow->gem_base);
-			user_bo->shadow = old_bo->shadow;
-		} else {
-			qxl_bo_create(qdev, user_bo->gem_base.size,
+	    user_bo->is_dumb) {
+		qxl_update_dumb_head(qdev, new_state->crtc->index,
+				     user_bo);
+		qxl_calc_dumb_shadow(qdev, &surf);
+		if (!qdev->dumb_shadow_bo ||
+		    qdev->dumb_shadow_bo->surf.width  != surf.width ||
+		    qdev->dumb_shadow_bo->surf.height != surf.height) {
+			if (qdev->dumb_shadow_bo) {
+				drm_gem_object_put_unlocked
+					(&qdev->dumb_shadow_bo->gem_base);
+				qdev->dumb_shadow_bo = NULL;
+			}
+			qxl_bo_create(qdev, surf.height * surf.stride,
 				      true, true, QXL_GEM_DOMAIN_SURFACE, NULL,
-				      &user_bo->shadow);
-			user_bo->shadow->surf = user_bo->surf;
+				      &qdev->dumb_shadow_bo);
+			qdev->dumb_shadow_bo->surf = surf;
+		}
+		if (user_bo->shadow != qdev->dumb_shadow_bo) {
+			if (user_bo->shadow) {
+				drm_gem_object_put_unlocked
+					(&user_bo->shadow->gem_base);
+				user_bo->shadow = NULL;
+			}
+			drm_gem_object_get(&qdev->dumb_shadow_bo->gem_base);
+			user_bo->shadow = qdev->dumb_shadow_bo;
 		}
 	}
 
@@ -773,7 +839,7 @@ static void qxl_plane_cleanup_fb(struct drm_plane *plane,
 	user_bo = gem_to_qxl_bo(obj);
 	qxl_bo_unpin(user_bo);
 
-	if (user_bo->shadow && !user_bo->shadow->is_primary) {
+	if (old_state->fb != plane->state->fb && user_bo->shadow) {
 		drm_gem_object_put_unlocked(&user_bo->shadow->gem_base);
 		user_bo->shadow = NULL;
 	}
@@ -1107,6 +1173,8 @@ int qxl_create_monitors_object(struct qxl_device *qdev)
 
 	memset(qdev->monitors_config, 0, monitors_config_size);
 	qdev->monitors_config->max_allowed = max_allowed;
+
+	qdev->dumb_heads = kcalloc(max_allowed, sizeof(qdev->dumb_heads[0]), GFP_KERNEL);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/qxl/qxl_draw.c b/drivers/gpu/drm/qxl/qxl_draw.c
index c408bb83c7..5313ad21c1 100644
--- a/drivers/gpu/drm/qxl/qxl_draw.c
+++ b/drivers/gpu/drm/qxl/qxl_draw.c
@@ -267,7 +267,8 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 		       struct qxl_bo *bo,
 		       unsigned int flags, unsigned int color,
 		       struct drm_clip_rect *clips,
-		       unsigned int num_clips, int inc)
+		       unsigned int num_clips, int inc,
+		       uint32_t dumb_shadow_offset)
 {
 	/*
 	 * TODO: if flags & DRM_MODE_FB_DIRTY_ANNOTATE_FILL then we should
@@ -295,6 +296,9 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 	if (ret)
 		return;
 
+	clips->x1 += dumb_shadow_offset;
+	clips->x2 += dumb_shadow_offset;
+
 	left = clips->x1;
 	right = clips->x2;
 	top = clips->y1;
@@ -342,7 +346,8 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 		goto out_release_backoff;
 
 	ret = qxl_image_init(qdev, release, dimage, surface_base,
-			     left, top, width, height, depth, stride);
+			     left - dumb_shadow_offset,
+			     top, width, height, depth, stride);
 	qxl_bo_kunmap(bo);
 	if (ret)
 		goto out_release_backoff;
-- 
2.9.3

