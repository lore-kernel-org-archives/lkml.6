Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E749DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B796220652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfARMVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:21:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727578AbfARMU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:20:28 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6851EC05E77A;
        Fri, 18 Jan 2019 12:20:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-38.ams2.redhat.com [10.36.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C43E75D967;
        Fri, 18 Jan 2019 12:20:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 470B76DDF; Fri, 18 Jan 2019 13:20:22 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        spice-devel@lists.freedesktop.org (open list:DRM DRIVER FOR QXL VIRTUAL
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 13/23] drm/qxl: use shadow bo directly
Date:   Fri, 18 Jan 2019 13:20:10 +0100
Message-Id: <20190118122020.27596-14-kraxel@redhat.com>
In-Reply-To: <20190118122020.27596-1-kraxel@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 18 Jan 2019 12:20:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the shadow bo to qxl_io_create_primary() instead of expecting
qxl_io_create_primary to check bo->shadow.  Set is_primary flag on the
shadow bo.  Move the is_primary tracking into qxl_io_create_primary()
and qxl_io_destroy_primary() functions.

That simplifies primary surface tracking and the workflow in
qxl_primary_atomic_update().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

qxl_io_create/destroy_primary: primary_bo tracking [fixup]
---
 drivers/gpu/drm/qxl/qxl_cmd.c     | 10 +++++-----
 drivers/gpu/drm/qxl/qxl_display.c | 33 +++++++++++----------------------
 2 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index 8e64127259..0a2e51af12 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -374,6 +374,8 @@ void qxl_io_flush_surfaces(struct qxl_device *qdev)
 void qxl_io_destroy_primary(struct qxl_device *qdev)
 {
 	wait_for_io_cmd(qdev, 0, QXL_IO_DESTROY_PRIMARY_ASYNC);
+	qdev->primary_bo->is_primary = false;
+	drm_gem_object_put_unlocked(&qdev->primary_bo->gem_base);
 	qdev->primary_bo = NULL;
 }
 
@@ -390,11 +392,7 @@ void qxl_io_create_primary(struct qxl_device *qdev, struct qxl_bo *bo)
 	create->width = bo->surf.width;
 	create->height = bo->surf.height;
 	create->stride = bo->surf.stride;
-	if (bo->shadow) {
-		create->mem = qxl_bo_physical_address(qdev, bo->shadow, 0);
-	} else {
-		create->mem = qxl_bo_physical_address(qdev, bo, 0);
-	}
+	create->mem = qxl_bo_physical_address(qdev, bo, 0);
 
 	DRM_DEBUG_DRIVER("mem = %llx, from %p\n", create->mem, bo->kptr);
 
@@ -403,6 +401,8 @@ void qxl_io_create_primary(struct qxl_device *qdev, struct qxl_bo *bo)
 
 	wait_for_io_cmd(qdev, 0, QXL_IO_CREATE_PRIMARY_ASYNC);
 	qdev->primary_bo = bo;
+	qdev->primary_bo->is_primary = true;
+	drm_gem_object_get(&qdev->primary_bo->gem_base);
 }
 
 void qxl_io_memslot_add(struct qxl_device *qdev, uint8_t id)
diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index d3215eac9b..ff13bc6a4a 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -401,13 +401,15 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
 	struct qxl_device *qdev = fb->dev->dev_private;
 	struct drm_clip_rect norect;
 	struct qxl_bo *qobj;
+	bool is_primary;
 	int inc = 1;
 
 	drm_modeset_lock_all(fb->dev);
 
 	qobj = gem_to_qxl_bo(fb->obj[0]);
 	/* if we aren't primary surface ignore this */
-	if (!qobj->is_primary) {
+	is_primary = qobj->shadow ? qobj->shadow->is_primary : qobj->is_primary;
+	if (!is_primary) {
 		drm_modeset_unlock_all(fb->dev);
 		return 0;
 	}
@@ -526,14 +528,13 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 {
 	struct qxl_device *qdev = plane->dev->dev_private;
 	struct qxl_bo *bo = gem_to_qxl_bo(plane->state->fb->obj[0]);
-	struct qxl_bo *bo_old;
+	struct qxl_bo *bo_old, *primary;
 	struct drm_clip_rect norect = {
 	    .x1 = 0,
 	    .y1 = 0,
 	    .x2 = plane->state->fb->width,
 	    .y2 = plane->state->fb->height
 	};
-	bool same_shadow = false;
 
 	if (old_state->fb) {
 		bo_old = gem_to_qxl_bo(old_state->fb->obj[0]);
@@ -541,26 +542,13 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 		bo_old = NULL;
 	}
 
-	if (bo == bo_old)
-		return;
+	primary = bo->shadow ? bo->shadow : bo;
 
-	if (bo_old && bo_old->shadow && bo->shadow &&
-	    bo_old->shadow == bo->shadow) {
-		same_shadow = true;
-	}
-
-	if (bo_old && bo_old->is_primary) {
-		if (!same_shadow)
+	if (!primary->is_primary) {
+		if (qdev->primary_bo)
 			qxl_io_destroy_primary(qdev);
-		bo_old->is_primary = false;
-	}
-
-	if (!bo->is_primary) {
-		if (!same_shadow) {
-			qxl_io_create_primary(qdev, bo);
-			qxl_primary_apply_cursor(plane);
-		}
-		bo->is_primary = true;
+		qxl_io_create_primary(qdev, primary);
+		qxl_primary_apply_cursor(plane);
 	}
 
 	qxl_draw_dirty_fb(qdev, plane->state->fb, bo, 0, 0, &norect, 1, 1);
@@ -756,6 +744,7 @@ static int qxl_plane_prepare_fb(struct drm_plane *plane,
 			qxl_bo_create(qdev, user_bo->gem_base.size,
 				      true, true, QXL_GEM_DOMAIN_SURFACE, NULL,
 				      &user_bo->shadow);
+			user_bo->shadow->surf = user_bo->surf;
 		}
 	}
 
@@ -784,7 +773,7 @@ static void qxl_plane_cleanup_fb(struct drm_plane *plane,
 	user_bo = gem_to_qxl_bo(obj);
 	qxl_bo_unpin(user_bo);
 
-	if (user_bo->shadow && !user_bo->is_primary) {
+	if (user_bo->shadow && !user_bo->shadow->is_primary) {
 		drm_gem_object_put_unlocked(&user_bo->shadow->gem_base);
 		user_bo->shadow = NULL;
 	}
-- 
2.9.3

