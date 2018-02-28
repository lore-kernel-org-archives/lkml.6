Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934876AbeB1QPs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 11:15:48 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:36158 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934499AbeB1QPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 11:15:44 -0500
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
Subject: [PATCH] drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE
Date: Wed, 28 Feb 2018 17:14:52 +0100
Message-Id: <1519834492-30559-1-git-send-email-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle both positive and negative dclk polarity,
according to bus_flags.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index aaf911a..534e5ee 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -17,6 +17,7 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_of.h>
+#include <drm/drm_panel.h>
 
 #include <uapi/drm/drm_mode.h>
 
@@ -340,6 +341,9 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
 static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 				     const struct drm_display_mode *mode)
 {
+	struct drm_panel *panel = tcon->panel;
+	struct drm_connector *connector = panel->connector;
+	struct drm_display_info display_info = connector->display_info;
 	unsigned int bp, hsync, vsync;
 	u8 clk_delay;
 	u32 val = 0;
@@ -395,8 +399,15 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
 		val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
 
+	if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE)
+		clk_set_phase(tcon->dclk, 240);
+
+	if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_NEGEDGE)
+		clk_set_phase(tcon->dclk, 0);
+
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
-			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE | SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
+			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE |
+			   SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
 			   val);
 
 	/* Map output pins to channel 0 */
-- 
2.7.4
