Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752668AbeESScs (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 14:32:48 -0400
Received: from mailout3.siol.net ([213.250.19.130]:34729 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752641AbeESScn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 14:32:43 -0400
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 06/15] drm/sun4i: tcon: Add support for tcon-top
Date: Sat, 19 May 2018 20:31:18 +0200
Message-Id: <20180519183127.2718-7-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180519183127.2718-1-jernej.skrabec@siol.net>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If SoC has TCON TOP unit, it has to be configured from TCON, since it
has all information needed. Additionally, if it is TCON TV, it must also
enable bus gate inside TCON TOP unit.

Add support for such TCONs.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 28 ++++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  8 ++++++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 08747fc3ee71..e0c562ce1c22 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -688,6 +688,16 @@ static int sun4i_tcon_init_clocks(struct device *dev,
 		dev_err(dev, "Couldn't get the TCON bus clock\n");
 		return PTR_ERR(tcon->clk);
 	}
+
+	if (tcon->quirks->needs_tcon_top && tcon->quirks->has_channel_1) {
+		tcon->top_clk = devm_clk_get(dev, "tcon-top");
+		if (IS_ERR(tcon->top_clk)) {
+			dev_err(dev, "Couldn't get the TCON TOP bus clock\n");
+			return PTR_ERR(tcon->top_clk);
+		}
+		clk_prepare_enable(tcon->top_clk);
+	}
+
 	clk_prepare_enable(tcon->clk);
 
 	if (tcon->quirks->has_channel_0) {
@@ -712,6 +722,7 @@ static int sun4i_tcon_init_clocks(struct device *dev,
 static void sun4i_tcon_free_clocks(struct sun4i_tcon *tcon)
 {
 	clk_disable_unprepare(tcon->clk);
+	clk_disable_unprepare(tcon->top_clk);
 }
 
 static int sun4i_tcon_init_irq(struct device *dev,
@@ -980,6 +991,23 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
 	tcon->id = engine->id;
 	tcon->quirks = of_device_get_match_data(dev);
 
+	if (tcon->quirks->needs_tcon_top) {
+		struct device_node *np;
+
+		np = of_parse_phandle(dev->of_node, "allwinner,tcon-top", 0);
+		if (np) {
+			struct platform_device *pdev;
+
+			pdev = of_find_device_by_node(np);
+			if (pdev)
+				tcon->tcon_top = platform_get_drvdata(pdev);
+			of_node_put(np);
+
+			if (!tcon->tcon_top)
+				return -EPROBE_DEFER;
+		}
+	}
+
 	tcon->lcd_rst = devm_reset_control_get(dev, "lcd");
 	if (IS_ERR(tcon->lcd_rst)) {
 		dev_err(dev, "Couldn't get our reset line\n");
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index f6a071cd5a6f..26be0d317a38 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -20,6 +20,8 @@
 #include <linux/list.h>
 #include <linux/reset.h>
 
+#include "sun8i_tcon_top.h"
+
 #define SUN4I_TCON_GCTL_REG			0x0
 #define SUN4I_TCON_GCTL_TCON_ENABLE			BIT(31)
 #define SUN4I_TCON_GCTL_IOMAP_MASK			BIT(0)
@@ -224,6 +226,7 @@ struct sun4i_tcon_quirks {
 	bool	needs_de_be_mux; /* sun6i needs mux to select backend */
 	bool    needs_edp_reset; /* a80 edp reset needed for tcon0 access */
 	bool	supports_lvds;   /* Does the TCON support an LVDS output? */
+	bool	needs_tcon_top;  /* TCON TOP holds additional muxing configuration */
 
 	/* callback to handle tcon muxing options */
 	int	(*set_mux)(struct sun4i_tcon *, const struct drm_encoder *);
@@ -249,6 +252,9 @@ struct sun4i_tcon {
 	u8				dclk_max_div;
 	u8				dclk_min_div;
 
+	/* TCON TOP clock */
+	struct clk			*top_clk;
+
 	/* Reset control */
 	struct reset_control		*lcd_rst;
 	struct reset_control		*lvds_rst;
@@ -263,6 +269,8 @@ struct sun4i_tcon {
 
 	int				id;
 
+	struct sun8i_tcon_top		*tcon_top;
+
 	/* TCON list management */
 	struct list_head		list;
 };
-- 
2.17.0
