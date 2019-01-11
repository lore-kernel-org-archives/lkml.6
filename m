Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6B2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF1920675
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbfAKFi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 00:38:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60060 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730278AbfAKFiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 00:38:04 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E99E2DA9AE;
        Fri, 11 Jan 2019 05:38:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-203.ams2.redhat.com [10.36.116.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2584F5D6AA;
        Fri, 11 Jan 2019 05:37:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5B0F99AD7; Fri, 11 Jan 2019 06:37:53 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc:     andr2000@gmail.com, noralf@tronnes.org,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 05/16] drm/bochs: atomic: switch planes to atomic, wire up helpers.
Date:   Fri, 11 Jan 2019 06:37:41 +0100
Message-Id: <20190111053752.4004-6-kraxel@redhat.com>
In-Reply-To: <20190111053752.4004-1-kraxel@redhat.com>
References: <20190111053752.4004-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 11 Jan 2019 05:38:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conversion to atomic modesetting, step three.
Wire up atomic helpers.  Switch planes to atomic.

We are late to the party, the transitional helpers are gone,
so this can't be splitted into smaller steps any more.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs_fbdev.c |  3 ++
 drivers/gpu/drm/bochs/bochs_kms.c   | 82 +++++++++++++++++++++++++++++++++++--
 2 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
index dd3c7df267..d9f3d42999 100644
--- a/drivers/gpu/drm/bochs/bochs_fbdev.c
+++ b/drivers/gpu/drm/bochs/bochs_fbdev.c
@@ -6,6 +6,7 @@
  */
 
 #include "bochs.h"
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 
 /* ---------------------------------------------------------------------- */
@@ -149,6 +150,8 @@ bochs_gem_fb_create(struct drm_device *dev, struct drm_file *file,
 
 const struct drm_mode_config_funcs bochs_mode_funcs = {
 	.fb_create = bochs_gem_fb_create,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
 };
 
 int bochs_fbdev_init(struct bochs_device *bochs)
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 56fd7be933..c6993c2d59 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -6,7 +6,9 @@
  */
 
 #include "bochs.h"
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_plane_helper.h>
+#include <drm/drm_atomic_uapi.h>
 
 static int defx = 1024;
 static int defy = 768;
@@ -113,7 +115,7 @@ static int bochs_crtc_page_flip(struct drm_crtc *crtc,
 	struct drm_framebuffer *old_fb = crtc->primary->fb;
 	unsigned long irqflags;
 
-	crtc->primary->fb = fb;
+	drm_atomic_set_fb_for_plane(crtc->primary->state, fb);
 	bochs_crtc_mode_set_base(crtc, 0, 0, old_fb);
 	if (event) {
 		spin_lock_irqsave(&bochs->dev->event_lock, irqflags);
@@ -151,6 +153,9 @@ static const struct drm_crtc_funcs bochs_crtc_funcs = {
 	.set_config = drm_crtc_helper_set_config,
 	.destroy = drm_crtc_cleanup,
 	.page_flip = bochs_crtc_page_flip,
+	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
 };
 
 static const struct drm_crtc_helper_funcs bochs_helper_funcs = {
@@ -169,6 +174,71 @@ static const uint32_t bochs_formats[] = {
 	DRM_FORMAT_BGRX8888,
 };
 
+static void bochs_plane_atomic_update(struct drm_plane *plane,
+				      struct drm_plane_state *old_state)
+{
+	struct bochs_device *bochs = plane->dev->dev_private;
+	struct bochs_bo *bo;
+
+	if (!plane->state->fb)
+		return;
+	bo = gem_to_bochs_bo(plane->state->fb->obj[0]);
+	bochs_hw_setbase(bochs,
+			 plane->state->crtc_x,
+			 plane->state->crtc_y,
+			 bo->bo.offset);
+	bochs_hw_setformat(bochs, plane->state->fb->format);
+}
+
+static int bochs_plane_prepare_fb(struct drm_plane *plane,
+				struct drm_plane_state *new_state)
+{
+	struct bochs_bo *bo;
+	int ret;
+
+	if (!new_state->fb)
+		return 0;
+	bo = gem_to_bochs_bo(new_state->fb->obj[0]);
+
+	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
+	if (ret)
+		return ret;
+	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM, NULL);
+	ttm_bo_unreserve(&bo->bo);
+	return ret;
+}
+
+static void bochs_plane_cleanup_fb(struct drm_plane *plane,
+				   struct drm_plane_state *old_state)
+{
+	struct bochs_bo *bo;
+	int ret;
+
+	if (!old_state->fb)
+		return;
+	bo = gem_to_bochs_bo(old_state->fb->obj[0]);
+	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
+	if (ret)
+		return;
+	bochs_bo_unpin(bo);
+	ttm_bo_unreserve(&bo->bo);
+}
+
+static const struct drm_plane_helper_funcs bochs_plane_helper_funcs = {
+	.atomic_update = bochs_plane_atomic_update,
+	.prepare_fb = bochs_plane_prepare_fb,
+	.cleanup_fb = bochs_plane_cleanup_fb,
+};
+
+static const struct drm_plane_funcs bochs_plane_funcs = {
+       .update_plane   = drm_atomic_helper_update_plane,
+       .disable_plane  = drm_atomic_helper_disable_plane,
+       .destroy        = drm_primary_helper_destroy,
+       .reset          = drm_atomic_helper_plane_reset,
+       .atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
+       .atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
+};
+
 static struct drm_plane *bochs_primary_plane(struct drm_device *dev)
 {
 	struct drm_plane *primary;
@@ -181,16 +251,17 @@ static struct drm_plane *bochs_primary_plane(struct drm_device *dev)
 	}
 
 	ret = drm_universal_plane_init(dev, primary, 0,
-				       &drm_primary_helper_funcs,
+				       &bochs_plane_funcs,
 				       bochs_formats,
 				       ARRAY_SIZE(bochs_formats),
 				       NULL,
 				       DRM_PLANE_TYPE_PRIMARY, NULL);
 	if (ret) {
 		kfree(primary);
-		primary = NULL;
+		return NULL;
 	}
 
+	drm_plane_helper_add(primary, &bochs_plane_helper_funcs);
 	return primary;
 }
 
@@ -275,6 +346,9 @@ static const struct drm_connector_funcs bochs_connector_connector_funcs = {
 	.dpms = drm_helper_connector_dpms,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static void bochs_connector_init(struct drm_device *dev)
@@ -318,6 +392,8 @@ int bochs_kms_init(struct bochs_device *bochs)
 	drm_connector_attach_encoder(&bochs->connector,
 					  &bochs->encoder);
 
+	drm_mode_config_reset(bochs->dev);
+
 	return 0;
 }
 
-- 
2.9.3

