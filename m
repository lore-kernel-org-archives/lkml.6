Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752728AbeESSdF (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 14:33:05 -0400
Received: from mailout8.siol.net ([213.250.19.135]:34794 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752519AbeESScx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 14:32:53 -0400
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 10/15] drm/sun4i: Add support for R40 TV TCONs
Date: Sat, 19 May 2018 20:31:22 +0200
Message-Id: <20180519183127.2718-11-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180519183127.2718-1-jernej.skrabec@siol.net>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R40 display pipeline has a lot of possible configurations. HDMI can be
connected to 2 different TCONs (out of 4) and mixers can be connected to
any TCON. All this must be configured in TCON TOP.

Along with definition of TCON capabilities also add mux callback, which
can configure this complex pipeline.

For now, only TCON TV is supported.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 39 ++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index e0c562ce1c22..81b9551e4f78 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1274,6 +1274,31 @@ static int sun6i_tcon_set_mux(struct sun4i_tcon *tcon,
 	return 0;
 }
 
+static int sun8i_r40_tcon_tv_set_mux(struct sun4i_tcon *tcon,
+				     const struct drm_encoder *encoder,
+				     int index)
+{
+	if (encoder->encoder_type == DRM_MODE_ENCODER_TMDS)
+		sun8i_tcon_top_set_hdmi_src(tcon->tcon_top, index);
+
+	sun8i_tcon_top_de_config(tcon->tcon_top, tcon->id,
+				 tcon_type_tv, index);
+
+	return 0;
+}
+
+static int sun8i_r40_tcon_tv_set_mux_0(struct sun4i_tcon *tcon,
+				       const struct drm_encoder *encoder)
+{
+	return sun8i_r40_tcon_tv_set_mux(tcon, encoder, 0);
+}
+
+static int sun8i_r40_tcon_tv_set_mux_1(struct sun4i_tcon *tcon,
+				       const struct drm_encoder *encoder)
+{
+	return sun8i_r40_tcon_tv_set_mux(tcon, encoder, 1);
+}
+
 static const struct sun4i_tcon_quirks sun4i_a10_quirks = {
 	.has_channel_0		= true,
 	.has_channel_1		= true,
@@ -1321,6 +1346,18 @@ static const struct sun4i_tcon_quirks sun8i_a83t_tv_quirks = {
 	.has_channel_1		= true,
 };
 
+static const struct sun4i_tcon_quirks sun8i_r40_tv_0_quirks = {
+	.has_channel_1		= true,
+	.needs_tcon_top		= true,
+	.set_mux		= sun8i_r40_tcon_tv_set_mux_0,
+};
+
+static const struct sun4i_tcon_quirks sun8i_r40_tv_1_quirks = {
+	.has_channel_1		= true,
+	.needs_tcon_top		= true,
+	.set_mux		= sun8i_r40_tcon_tv_set_mux_1,
+};
+
 static const struct sun4i_tcon_quirks sun8i_v3s_quirks = {
 	.has_channel_0		= true,
 };
@@ -1345,6 +1382,8 @@ const struct of_device_id sun4i_tcon_of_table[] = {
 	{ .compatible = "allwinner,sun8i-a33-tcon", .data = &sun8i_a33_quirks },
 	{ .compatible = "allwinner,sun8i-a83t-tcon-lcd", .data = &sun8i_a83t_lcd_quirks },
 	{ .compatible = "allwinner,sun8i-a83t-tcon-tv", .data = &sun8i_a83t_tv_quirks },
+	{ .compatible = "allwinner,sun8i-r40-tcon-tv-0", .data = &sun8i_r40_tv_0_quirks },
+	{ .compatible = "allwinner,sun8i-r40-tcon-tv-1", .data = &sun8i_r40_tv_1_quirks },
 	{ .compatible = "allwinner,sun8i-v3s-tcon", .data = &sun8i_v3s_quirks },
 	{ .compatible = "allwinner,sun9i-a80-tcon-lcd", .data = &sun9i_a80_tcon_lcd_quirks },
 	{ .compatible = "allwinner,sun9i-a80-tcon-tv", .data = &sun9i_a80_tcon_tv_quirks },
-- 
2.17.0
