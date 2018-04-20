Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754015AbeDTHTh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:19:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753892AbeDTHTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:19:10 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR QXL
        VIRTUAL GPU),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 4/4] qxl: drop dummy functions
Date: Fri, 20 Apr 2018 09:19:04 +0200
Message-Id: <20180420071904.24276-5-kraxel@redhat.com>
In-Reply-To: <20180420071904.24276-1-kraxel@redhat.com>
References: <20180420071904.24276-1-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These days drm core checks function pointers everywhere before calling
them.  So we can drop a bunch of dummy functions now.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 50 ---------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 06ee00b486..af6e52af5f 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -456,13 +456,6 @@ qxl_framebuffer_init(struct drm_device *dev,
 	return 0;
 }
 
-static bool qxl_crtc_mode_fixup(struct drm_crtc *crtc,
-				  const struct drm_display_mode *mode,
-				  struct drm_display_mode *adjusted_mode)
-{
-	return true;
-}
-
 static void qxl_crtc_atomic_enable(struct drm_crtc *crtc,
 				   struct drm_crtc_state *old_state)
 {
@@ -476,7 +469,6 @@ static void qxl_crtc_atomic_disable(struct drm_crtc *crtc,
 }
 
 static const struct drm_crtc_helper_funcs qxl_crtc_helper_funcs = {
-	.mode_fixup = qxl_crtc_mode_fixup,
 	.atomic_flush = qxl_crtc_atomic_flush,
 	.atomic_enable = qxl_crtc_atomic_enable,
 	.atomic_disable = qxl_crtc_atomic_disable,
@@ -620,12 +612,6 @@ static void qxl_primary_atomic_disable(struct drm_plane *plane,
 	}
 }
 
-static int qxl_plane_atomic_check(struct drm_plane *plane,
-				  struct drm_plane_state *state)
-{
-	return 0;
-}
-
 static void qxl_cursor_atomic_update(struct drm_plane *plane,
 				     struct drm_plane_state *old_state)
 {
@@ -831,7 +817,6 @@ static const uint32_t qxl_cursor_plane_formats[] = {
 };
 
 static const struct drm_plane_helper_funcs qxl_cursor_helper_funcs = {
-	.atomic_check = qxl_plane_atomic_check,
 	.atomic_update = qxl_cursor_atomic_update,
 	.atomic_disable = qxl_cursor_atomic_disable,
 	.prepare_fb = qxl_plane_prepare_fb,
@@ -956,28 +941,6 @@ static int qdev_crtc_init(struct drm_device *dev, int crtc_id)
 	return r;
 }
 
-static void qxl_enc_dpms(struct drm_encoder *encoder, int mode)
-{
-	DRM_DEBUG("\n");
-}
-
-static void qxl_enc_prepare(struct drm_encoder *encoder)
-{
-	DRM_DEBUG("\n");
-}
-
-static void qxl_enc_commit(struct drm_encoder *encoder)
-{
-	DRM_DEBUG("\n");
-}
-
-static void qxl_enc_mode_set(struct drm_encoder *encoder,
-				struct drm_display_mode *mode,
-				struct drm_display_mode *adjusted_mode)
-{
-	DRM_DEBUG("\n");
-}
-
 static int qxl_conn_get_modes(struct drm_connector *connector)
 {
 	unsigned pwidth = 1024;
@@ -1023,10 +986,6 @@ static struct drm_encoder *qxl_best_encoder(struct drm_connector *connector)
 
 
 static const struct drm_encoder_helper_funcs qxl_enc_helper_funcs = {
-	.dpms = qxl_enc_dpms,
-	.prepare = qxl_enc_prepare,
-	.mode_set = qxl_enc_mode_set,
-	.commit = qxl_enc_commit,
 };
 
 static const struct drm_connector_helper_funcs qxl_connector_helper_funcs = {
@@ -1059,14 +1018,6 @@ static enum drm_connector_status qxl_conn_detect(
 			 : connector_status_disconnected;
 }
 
-static int qxl_conn_set_property(struct drm_connector *connector,
-				   struct drm_property *property,
-				   uint64_t value)
-{
-	DRM_DEBUG("\n");
-	return 0;
-}
-
 static void qxl_conn_destroy(struct drm_connector *connector)
 {
 	struct qxl_output *qxl_output =
@@ -1081,7 +1032,6 @@ static const struct drm_connector_funcs qxl_connector_funcs = {
 	.dpms = drm_helper_connector_dpms,
 	.detect = qxl_conn_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.set_property = qxl_conn_set_property,
 	.destroy = qxl_conn_destroy,
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
-- 
2.9.3
