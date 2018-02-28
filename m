Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934725AbeB1RzB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:55:01 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:39826 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934189AbeB1Ryp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:54:45 -0500
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
Subject: [PATCH 2/2] drm/sun4i: add lvds mode_valid function
Date: Wed, 28 Feb 2018 18:53:52 +0100
Message-Id: <1519840432-61489-2-git-send-email-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519840432-61489-1-git-send-email-giulio.benetti@micronovasrl.com>
References: <1519840432-61489-1-git-send-email-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mode_valid function is missing for lvds.

Add it based on rgb model, also setting up dclk_min_div and dclk_max_div

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/sun4i/sun4i_lvds.c | 55 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.c b/drivers/gpu/drm/sun4i/sun4i_lvds.c
index be3f14d..75223ee 100644
--- a/drivers/gpu/drm/sun4i/sun4i_lvds.c
+++ b/drivers/gpu/drm/sun4i/sun4i_lvds.c
@@ -46,8 +46,63 @@ static int sun4i_lvds_get_modes(struct drm_connector *connector)
 	return drm_panel_get_modes(tcon->panel);
 }
 
+static int sun4i_lvds_mode_valid(struct drm_connector *connector,
+				struct drm_display_mode *mode)
+{
+	struct sun4i_lvds *lvds = drm_connector_to_sun4i_lvds(connector);
+	struct sun4i_tcon *tcon = lvds->tcon;
+	u32 hsync = mode->hsync_end - mode->hsync_start;
+	u32 vsync = mode->vsync_end - mode->vsync_start;
+	unsigned long rate = mode->clock * 1000;
+	long rounded_rate;
+
+	DRM_DEBUG_DRIVER("Validating modes...\n");
+
+	if (hsync < 1)
+		return MODE_HSYNC_NARROW;
+
+	if (hsync > 0x3ff)
+		return MODE_HSYNC_WIDE;
+
+	if ((mode->hdisplay < 1) || (mode->htotal < 1))
+		return MODE_H_ILLEGAL;
+
+	if ((mode->hdisplay > 0x7ff) || (mode->htotal > 0xfff))
+		return MODE_BAD_HVALUE;
+
+	DRM_DEBUG_DRIVER("Horizontal parameters OK\n");
+
+	if (vsync < 1)
+		return MODE_VSYNC_NARROW;
+
+	if (vsync > 0x3ff)
+		return MODE_VSYNC_WIDE;
+
+	if ((mode->vdisplay < 1) || (mode->vtotal < 1))
+		return MODE_V_ILLEGAL;
+
+	if ((mode->vdisplay > 0x7ff) || (mode->vtotal > 0xfff))
+		return MODE_BAD_VVALUE;
+
+	DRM_DEBUG_DRIVER("Vertical parameters OK\n");
+
+	tcon->dclk_min_div = 7;
+	tcon->dclk_max_div = 18;
+	rounded_rate = clk_round_rate(tcon->dclk, rate);
+	if (rounded_rate < rate)
+		return MODE_CLOCK_LOW;
+
+	if (rounded_rate > rate)
+		return MODE_CLOCK_HIGH;
+
+	DRM_DEBUG_DRIVER("Clock rate OK\n");
+
+	return MODE_OK;
+}
+
 static struct drm_connector_helper_funcs sun4i_lvds_con_helper_funcs = {
 	.get_modes	= sun4i_lvds_get_modes,
+	.mode_valid	= sun4i_lvds_mode_valid,
 };
 
 static void
-- 
2.7.4
