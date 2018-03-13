Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933030AbeCMLht (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:37:49 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:56506 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932503AbeCMLhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:37:48 -0400
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
Subject: [PATCH v2] drm/sun4i: move rgb mode_valid from connector to encoder
Date: Tue, 13 Mar 2018 12:36:57 +0100
Message-Id: <1520941017-81177-1-git-send-email-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mode_valid function must be connected to encoder.
Otherwise it could get not be called by drm in the case there's a
bridge connected to encoder instead of a panel.

Move mode_valid function pointer to encoder helper functions,
changing its prototype according to encoder helper function pointer.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/sun4i/sun4i_rgb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index b8da5a5..f2fa1f2 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -52,10 +52,10 @@ static int sun4i_rgb_get_modes(struct drm_connector *connector)
 	return drm_panel_get_modes(tcon->panel);
 }
 
-static int sun4i_rgb_mode_valid(struct drm_connector *connector,
-				struct drm_display_mode *mode)
+static enum drm_mode_status sun4i_rgb_mode_valid(struct drm_encoder *crtc,
+						 const struct drm_display_mode *mode)
 {
-	struct sun4i_rgb *rgb = drm_connector_to_sun4i_rgb(connector);
+	struct sun4i_rgb *rgb = drm_encoder_to_sun4i_rgb(crtc);
 	struct sun4i_tcon *tcon = rgb->tcon;
 	u32 hsync = mode->hsync_end - mode->hsync_start;
 	u32 vsync = mode->vsync_end - mode->vsync_start;
@@ -108,7 +108,6 @@ static int sun4i_rgb_mode_valid(struct drm_connector *connector,
 
 static struct drm_connector_helper_funcs sun4i_rgb_con_helper_funcs = {
 	.get_modes	= sun4i_rgb_get_modes,
-	.mode_valid	= sun4i_rgb_mode_valid,
 };
 
 static void
@@ -158,6 +157,7 @@ static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
 static struct drm_encoder_helper_funcs sun4i_rgb_enc_helper_funcs = {
 	.disable	= sun4i_rgb_encoder_disable,
 	.enable		= sun4i_rgb_encoder_enable,
+	.mode_valid	= sun4i_rgb_mode_valid,
 };
 
 static void sun4i_rgb_enc_destroy(struct drm_encoder *encoder)
-- 
2.7.4
