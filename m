Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752595AbeCDKiL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 05:38:11 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:40796 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751844AbeCDKiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 05:38:09 -0500
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH] drm/sun4i: move rgb mode_valid from connector to encoder
Date: Sun,  4 Mar 2018 11:37:50 +0100
Message-Id: <1520159870-41286-1-git-send-email-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mode_valid function must be connected to encoder, not connector.
Otherwise it doesn't get called by drm.

Move mode_valid function pointer to encoder helper functions,
changing its prototype according to encoder helper function pointer.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/sun4i/sun4i_rgb.c | 102 +++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index b8da5a5..6539dcc 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -52,11 +52,59 @@ static int sun4i_rgb_get_modes(struct drm_connector *connector)
 	return drm_panel_get_modes(tcon->panel);
 }
 
-static int sun4i_rgb_mode_valid(struct drm_connector *connector,
-				struct drm_display_mode *mode)
+static struct drm_connector_helper_funcs sun4i_rgb_con_helper_funcs = {
+	.get_modes	= sun4i_rgb_get_modes,
+};
+
+static void
+sun4i_rgb_connector_destroy(struct drm_connector *connector)
 {
 	struct sun4i_rgb *rgb = drm_connector_to_sun4i_rgb(connector);
 	struct sun4i_tcon *tcon = rgb->tcon;
+
+	drm_panel_detach(tcon->panel);
+	drm_connector_cleanup(connector);
+}
+
+static const struct drm_connector_funcs sun4i_rgb_con_funcs = {
+	.fill_modes		= drm_helper_probe_single_connector_modes,
+	.destroy		= sun4i_rgb_connector_destroy,
+	.reset			= drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
+};
+
+static void sun4i_rgb_encoder_enable(struct drm_encoder *encoder)
+{
+	struct sun4i_rgb *rgb = drm_encoder_to_sun4i_rgb(encoder);
+	struct sun4i_tcon *tcon = rgb->tcon;
+
+	DRM_DEBUG_DRIVER("Enabling RGB output\n");
+
+	if (!IS_ERR(tcon->panel)) {
+		drm_panel_prepare(tcon->panel);
+		drm_panel_enable(tcon->panel);
+	}
+}
+
+static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
+{
+	struct sun4i_rgb *rgb = drm_encoder_to_sun4i_rgb(encoder);
+	struct sun4i_tcon *tcon = rgb->tcon;
+
+	DRM_DEBUG_DRIVER("Disabling RGB output\n");
+
+	if (!IS_ERR(tcon->panel)) {
+		drm_panel_disable(tcon->panel);
+		drm_panel_unprepare(tcon->panel);
+	}
+}
+
+static enum drm_mode_status sun4i_rgb_encoder_mode_valid(struct drm_encoder *crtc,
+							 const struct drm_display_mode *mode)
+{
+	struct sun4i_rgb *rgb = drm_encoder_to_sun4i_rgb(crtc);
+	struct sun4i_tcon *tcon = rgb->tcon;
 	u32 hsync = mode->hsync_end - mode->hsync_start;
 	u32 vsync = mode->vsync_end - mode->vsync_start;
 	unsigned long rate = mode->clock * 1000;
@@ -106,58 +154,10 @@ static int sun4i_rgb_mode_valid(struct drm_connector *connector,
 	return MODE_OK;
 }
 
-static struct drm_connector_helper_funcs sun4i_rgb_con_helper_funcs = {
-	.get_modes	= sun4i_rgb_get_modes,
-	.mode_valid	= sun4i_rgb_mode_valid,
-};
-
-static void
-sun4i_rgb_connector_destroy(struct drm_connector *connector)
-{
-	struct sun4i_rgb *rgb = drm_connector_to_sun4i_rgb(connector);
-	struct sun4i_tcon *tcon = rgb->tcon;
-
-	drm_panel_detach(tcon->panel);
-	drm_connector_cleanup(connector);
-}
-
-static const struct drm_connector_funcs sun4i_rgb_con_funcs = {
-	.fill_modes		= drm_helper_probe_single_connector_modes,
-	.destroy		= sun4i_rgb_connector_destroy,
-	.reset			= drm_atomic_helper_connector_reset,
-	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
-	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
-};
-
-static void sun4i_rgb_encoder_enable(struct drm_encoder *encoder)
-{
-	struct sun4i_rgb *rgb = drm_encoder_to_sun4i_rgb(encoder);
-	struct sun4i_tcon *tcon = rgb->tcon;
-
-	DRM_DEBUG_DRIVER("Enabling RGB output\n");
-
-	if (!IS_ERR(tcon->panel)) {
-		drm_panel_prepare(tcon->panel);
-		drm_panel_enable(tcon->panel);
-	}
-}
-
-static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
-{
-	struct sun4i_rgb *rgb = drm_encoder_to_sun4i_rgb(encoder);
-	struct sun4i_tcon *tcon = rgb->tcon;
-
-	DRM_DEBUG_DRIVER("Disabling RGB output\n");
-
-	if (!IS_ERR(tcon->panel)) {
-		drm_panel_disable(tcon->panel);
-		drm_panel_unprepare(tcon->panel);
-	}
-}
-
 static struct drm_encoder_helper_funcs sun4i_rgb_enc_helper_funcs = {
 	.disable	= sun4i_rgb_encoder_disable,
 	.enable		= sun4i_rgb_encoder_enable,
+	.mode_valid	= sun4i_rgb_encoder_mode_valid,
 };
 
 static void sun4i_rgb_enc_destroy(struct drm_encoder *encoder)
-- 
2.7.4
