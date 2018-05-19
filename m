Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbeESSeB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 14:34:01 -0400
Received: from mailout11.siol.net ([213.250.19.138]:34825 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752670AbeESSc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 14:32:58 -0400
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH 12/15] drm/sun4i: Add support for second clock parent to DW HDMI PHY clk driver
Date: Sat, 19 May 2018 20:31:24 +0200
Message-Id: <20180519183127.2718-13-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180519183127.2718-1-jernej.skrabec@siol.net>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expand HDMI PHY clock driver to support second clock parent.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h      |  6 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c     | 29 ++++++-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c | 90 ++++++++++++++++------
 3 files changed, 98 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
index 801a17222762..aadbe0a10b0c 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
@@ -98,7 +98,8 @@
 #define SUN8I_HDMI_PHY_PLL_CFG1_LDO2_EN		BIT(29)
 #define SUN8I_HDMI_PHY_PLL_CFG1_LDO1_EN		BIT(28)
 #define SUN8I_HDMI_PHY_PLL_CFG1_HV_IS_33	BIT(27)
-#define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL	BIT(26)
+#define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK	BIT(26)
+#define SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_SHIFT	26
 #define SUN8I_HDMI_PHY_PLL_CFG1_PLLEN		BIT(25)
 #define SUN8I_HDMI_PHY_PLL_CFG1_LDO_VSET(x)	((x) << 22)
 #define SUN8I_HDMI_PHY_PLL_CFG1_UNKNOWN(x)	((x) << 20)
@@ -190,6 +191,7 @@ void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi *hdmi);
 void sun8i_hdmi_phy_init(struct sun8i_hdmi_phy *phy);
 const struct dw_hdmi_phy_ops *sun8i_hdmi_phy_get_ops(void);
 
-int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev);
+int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev,
+			 bool second_parent);
 
 #endif /* _SUN8I_DW_HDMI_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index deba47ed69d8..7a911f0a3ae3 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -183,7 +183,13 @@ static int sun8i_hdmi_phy_config_h3(struct dw_hdmi *hdmi,
 	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_ANA_CFG1_REG,
 			   SUN8I_HDMI_PHY_ANA_CFG1_TXEN_MASK, 0);
 
-	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG, pll_cfg1_init);
+	/*
+	 * NOTE: We have to be careful not to overwrite PHY parent
+	 * clock selection bit and clock divider.
+	 */
+	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
+			   ~SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK,
+			   pll_cfg1_init);
 	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG2_REG,
 			   (u32)~SUN8I_HDMI_PHY_PLL_CFG2_PREDIV_MSK,
 			   pll_cfg2_init);
@@ -352,6 +358,10 @@ static void sun8i_hdmi_phy_init_h3(struct sun8i_hdmi_phy *phy)
 			   SUN8I_HDMI_PHY_ANA_CFG3_SCLEN |
 			   SUN8I_HDMI_PHY_ANA_CFG3_SDAEN);
 
+	/* reset PLL clock configuration */
+	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG, 0);
+	regmap_write(phy->regs, SUN8I_HDMI_PHY_PLL_CFG2_REG, 0);
+
 	/* set HW control of CEC pins */
 	regmap_write(phy->regs, SUN8I_HDMI_PHY_CEC_REG, 0);
 
@@ -481,18 +491,28 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, struct device_node *node)
 			}
 		}
 
-		ret = sun8i_phy_clk_create(phy, dev);
+		ret = sun8i_phy_clk_create(phy, dev,
+					   phy->variant->has_second_pll);
 		if (ret) {
 			dev_err(dev, "Couldn't create the PHY clock\n");
 			goto err_put_clk_pll1;
 		}
+
+		/*
+		 * Even though HDMI PHY clock doesn't have enable/disable
+		 * handlers, we have to enable it. Otherwise it could happen
+		 * that parent PLL is not enabled by clock framework in a
+		 * highly unlikely event when parent PLL is used solely for
+		 * HDMI PHY clock.
+		 */
+		clk_prepare_enable(phy->clk_phy);
 	}
 
 	phy->rst_phy = of_reset_control_get_shared(node, "phy");
 	if (IS_ERR(phy->rst_phy)) {
 		dev_err(dev, "Could not get phy reset control\n");
 		ret = PTR_ERR(phy->rst_phy);
-		goto err_put_clk_pll1;
+		goto err_disable_clk_phy;
 	}
 
 	ret = reset_control_deassert(phy->rst_phy);
@@ -523,6 +543,8 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, struct device_node *node)
 	reset_control_assert(phy->rst_phy);
 err_put_rst_phy:
 	reset_control_put(phy->rst_phy);
+err_disable_clk_phy:
+	clk_disable_unprepare(phy->clk_phy);
 err_put_clk_pll1:
 	clk_put(phy->clk_pll1);
 err_put_clk_pll0:
@@ -541,6 +563,7 @@ void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi *hdmi)
 
 	clk_disable_unprepare(phy->clk_mod);
 	clk_disable_unprepare(phy->clk_bus);
+	clk_disable_unprepare(phy->clk_phy);
 
 	reset_control_assert(phy->rst_phy);
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
index faea449812f8..a4d31fe3abff 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
@@ -22,35 +22,45 @@ static int sun8i_phy_clk_determine_rate(struct clk_hw *hw,
 {
 	unsigned long rate = req->rate;
 	unsigned long best_rate = 0;
+	struct clk_hw *best_parent = NULL;
 	struct clk_hw *parent;
 	int best_div = 1;
-	int i;
+	int i, p;
 
-	parent = clk_hw_get_parent(hw);
-
-	for (i = 1; i <= 16; i++) {
-		unsigned long ideal = rate * i;
-		unsigned long rounded;
-
-		rounded = clk_hw_round_rate(parent, ideal);
+	for (p = 0; p < clk_hw_get_num_parents(hw); p++) {
+		parent = clk_hw_get_parent_by_index(hw, p);
+		if (!parent)
+			continue;
 
-		if (rounded == ideal) {
-			best_rate = rounded;
-			best_div = i;
-			break;
+		for (i = 1; i <= 16; i++) {
+			unsigned long ideal = rate * i;
+			unsigned long rounded;
+
+			rounded = clk_hw_round_rate(parent, ideal);
+
+			if (rounded == ideal) {
+				best_rate = rounded;
+				best_div = i;
+				best_parent = parent;
+				break;
+			}
+
+			if (!best_rate ||
+			    abs(rate - rounded / i) <
+			    abs(rate - best_rate / best_div)) {
+				best_rate = rounded;
+				best_div = i;
+				best_parent = parent;
+			}
 		}
 
-		if (!best_rate ||
-		    abs(rate - rounded / i) <
-		    abs(rate - best_rate / best_div)) {
-			best_rate = rounded;
-			best_div = i;
-		}
+		if (best_rate / best_div == rate)
+			break;
 	}
 
 	req->rate = best_rate / best_div;
 	req->best_parent_rate = best_rate;
-	req->best_parent_hw = parent;
+	req->best_parent_hw = best_parent;
 
 	return 0;
 }
@@ -95,22 +105,58 @@ static int sun8i_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+static u8 sun8i_phy_clk_get_parent(struct clk_hw *hw)
+{
+	struct sun8i_phy_clk *priv = hw_to_phy_clk(hw);
+	u32 reg;
+
+	regmap_read(priv->phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG, &reg);
+	reg = (reg & SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK) >>
+	      SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_SHIFT;
+
+	return reg;
+}
+
+static int sun8i_phy_clk_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct sun8i_phy_clk *priv = hw_to_phy_clk(hw);
+
+	if (index > 1)
+		return -EINVAL;
+
+	regmap_update_bits(priv->phy->regs, SUN8I_HDMI_PHY_PLL_CFG1_REG,
+			   SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK,
+			   index << SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_SHIFT);
+
+	return 0;
+}
+
 static const struct clk_ops sun8i_phy_clk_ops = {
 	.determine_rate	= sun8i_phy_clk_determine_rate,
 	.recalc_rate	= sun8i_phy_clk_recalc_rate,
 	.set_rate	= sun8i_phy_clk_set_rate,
+
+	.get_parent	= sun8i_phy_clk_get_parent,
+	.set_parent	= sun8i_phy_clk_set_parent,
 };
 
-int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev)
+int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev,
+			 bool second_parent)
 {
 	struct clk_init_data init;
 	struct sun8i_phy_clk *priv;
-	const char *parents[1];
+	const char *parents[2];
 
 	parents[0] = __clk_get_name(phy->clk_pll0);
 	if (!parents[0])
 		return -ENODEV;
 
+	if (second_parent) {
+		parents[1] = __clk_get_name(phy->clk_pll1);
+		if (!parents[1])
+			return -ENODEV;
+	}
+
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -118,7 +164,7 @@ int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev)
 	init.name = "hdmi-phy-clk";
 	init.ops = &sun8i_phy_clk_ops;
 	init.parent_names = parents;
-	init.num_parents = 1;
+	init.num_parents = second_parent ? 2 : 1;
 	init.flags = CLK_SET_RATE_PARENT;
 
 	priv->phy = phy;
-- 
2.17.0
