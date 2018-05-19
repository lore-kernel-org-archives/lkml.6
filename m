Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752797AbeESSeX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 14:34:23 -0400
Received: from mailout7.siol.net ([213.250.19.134]:34810 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752674AbeESScz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 14:32:55 -0400
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 11/15] drm/sun4i: DW HDMI PHY: Add support for second PLL
Date: Sat, 19 May 2018 20:31:23 +0200
Message-Id: <20180519183127.2718-12-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180519183127.2718-1-jernej.skrabec@siol.net>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some DW HDMI PHYs like those found in A64 and R40 SoCs, can select
between two clock parents.

Add code which reads second PLL from DT.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h  |  2 ++
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 22 ++++++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
index 79154f0f674a..801a17222762 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -147,6 +147,7 @@ struct sun8i_hdmi_phy;
 
 struct sun8i_hdmi_phy_variant {
 	bool has_phy_clk;
+	bool has_second_pll;
 	void (*phy_init)(struct sun8i_hdmi_phy *phy);
 	void (*phy_disable)(struct dw_hdmi *hdmi,
 			    struct sun8i_hdmi_phy *phy);
@@ -160,6 +161,7 @@ struct sun8i_hdmi_phy {
 	struct clk			*clk_mod;
 	struct clk			*clk_phy;
 	struct clk			*clk_pll0;
+	struct clk			*clk_pll1;
 	unsigned int			rcal;
 	struct regmap			*regs;
 	struct reset_control		*rst_phy;
diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index 5a52fc489a9d..deba47ed69d8 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -472,10 +472,19 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, struct device_node *node)
 			goto err_put_clk_mod;
 		}
 
+		if (phy->variant->has_second_pll) {
+			phy->clk_pll1 = of_clk_get_by_name(node, "pll-1");
+			if (IS_ERR(phy->clk_pll1)) {
+				dev_err(dev, "Could not get pll-1 clock\n");
+				ret = PTR_ERR(phy->clk_pll1);
+				goto err_put_clk_pll0;
+			}
+		}
+
 		ret = sun8i_phy_clk_create(phy, dev);
 		if (ret) {
 			dev_err(dev, "Couldn't create the PHY clock\n");
-			goto err_put_clk_pll0;
+			goto err_put_clk_pll1;
 		}
 	}
 
@@ -483,7 +492,7 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, struct device_node *node)
 	if (IS_ERR(phy->rst_phy)) {
 		dev_err(dev, "Could not get phy reset control\n");
 		ret = PTR_ERR(phy->rst_phy);
-		goto err_put_clk_pll0;
+		goto err_put_clk_pll1;
 	}
 
 	ret = reset_control_deassert(phy->rst_phy);
@@ -514,9 +523,10 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, struct device_node *node)
 	reset_control_assert(phy->rst_phy);
 err_put_rst_phy:
 	reset_control_put(phy->rst_phy);
+err_put_clk_pll1:
+	clk_put(phy->clk_pll1);
 err_put_clk_pll0:
-	if (phy->variant->has_phy_clk)
-		clk_put(phy->clk_pll0);
+	clk_put(phy->clk_pll0);
 err_put_clk_mod:
 	clk_put(phy->clk_mod);
 err_put_clk_bus:
@@ -536,8 +546,8 @@ void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi *hdmi)
 
 	reset_control_put(phy->rst_phy);
 
-	if (phy->variant->has_phy_clk)
-		clk_put(phy->clk_pll0);
+	clk_put(phy->clk_pll0);
+	clk_put(phy->clk_pll1);
 	clk_put(phy->clk_mod);
 	clk_put(phy->clk_bus);
 }
-- 
2.17.0
