Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752420AbeCMRzc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:55:32 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:43286 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751860AbeCMRz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:55:29 -0400
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
Subject: [PATCH v2] drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE
Date: Tue, 13 Mar 2018 18:54:37 +0100
Message-Id: <1520963677-124239-1-git-send-email-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle both positive and negative dclk polarity,
according to bus_flags, taking care of this:

On A20 and similar SoCs, the only way to achieve Positive Edge
(Rising Edge), is setting dclk clock phase to 2/3(240°).
By default TCON works in Negative Edge(Falling Edge), this is why phase
is set to 0 in that case.
Unfortunately there's no way to logically invert dclk through IO_POL
register.
The only acceptable way to work, triple checked with scope,
is using clock phase set to 0° for Negative Edge and set to 240° for
Positive Edge.
On A33 and similar SoCs there would be a 90° phase option, but it divides
also dclk by 2.
This patch is a way to avoid quirks all around TCON and DOTCLOCK drivers
for using A33 90° phase divided by 2 and consequently increase code
complexity.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 8ee87c2..3f1455d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -17,6 +17,7 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_of.h>
+#include <drm/drm_panel.h>
 
 #include <uapi/drm/drm_mode.h>
 
@@ -345,6 +346,9 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
 static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 				     const struct drm_display_mode *mode)
 {
+	struct drm_panel *panel = tcon->panel;
+	struct drm_connector *connector = panel->connector;
+	struct drm_display_info display_info = connector->display_info;
 	unsigned int bp, hsync, vsync;
 	u8 clk_delay;
 	u32 val = 0;
@@ -400,6 +404,27 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
 		val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
 
+	/*
+	 * On A20 and similar SoCs, the only way to achieve Positive Edge
+	 * (Rising Edge), is setting dclk clock phase to 2/3(240°).
+	 * By default TCON works in Negative Edge(Falling Edge),
+	 * this is why phase is set to 0 in that case.
+	 * Unfortunately there's no way to logically invert dclk through
+	 * IO_POL register.
+	 * The only acceptable way to work, triple checked with scope,
+	 * is using clock phase set to 0° for Negative Edge and set to 240°
+	 * for Positive Edge.
+	 * On A33 and similar SoCs there would be a 90° phase option,
+	 * but it divides also dclk by 2.
+	 * Following code is a way to avoid quirks all around TCON
+	 * and DOTCLOCK drivers.
+	 */
+	if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_POSEDGE)
+		clk_set_phase(tcon->dclk, 240);
+
+	if (display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_NEGEDGE)
+		clk_set_phase(tcon->dclk, 0);
+
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
 			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE | SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
 			   val);
-- 
2.7.4
