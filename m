Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752749AbeERJrY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:47:24 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46446 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752699AbeERJrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:47:21 -0400
X-Google-Smtp-Source: AB8JxZqsNht2eaaBC9LEgCjwHkHt+15hFLj/r8iipZ1wdcjogO6tKp2XJZ8Fory15ZjbYBL7POjIww==
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc: Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 12/26] drm/sun4i: Add support for multiple DW HDMI PHY clock parents
Date: Fri, 18 May 2018 15:15:22 +0530
Message-Id: <20180518094536.17201-13-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180518094536.17201-1-jagan@amarulasolutions.com>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

Some SoCs with DW HDMI have multiple possible clock parents, like A64
and R40.

Expand HDMI PHY clock driver to support second clock parent.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- new patch

 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h      |  9 ++-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c     | 33 ++++++++---
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c | 89 ++++++++++++++++++++++--------
 3 files changed, 96 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
index 79154f0f674a..303189d6602c 100644
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
@@ -146,7 +147,7 @@
 struct sun8i_hdmi_phy;
 
 struct sun8i_hdmi_phy_variant {
-	bool has_phy_clk;
+	int  phy_clk_num;
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
@@ -188,6 +190,7 @@ void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi *hdmi);
 void sun8i_hdmi_phy_init(struct sun8i_hdmi_phy *phy);
 const struct dw_hdmi_phy_ops *sun8i_hdmi_phy_get_ops(void);
 
-int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev);
+int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev,
+			 int clk_num);
 
 #endif /* _SUN8I_DW_HDMI_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index 5a52fc489a9d..0eadf087fc46 100644
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
+			   (u32)~SUN8I_HDMI_PHY_PLL_CFG1_CKIN_SEL_MSK,
+			   pll_cfg1_init);
 	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_PLL_CFG2_REG,
 			   (u32)~SUN8I_HDMI_PHY_PLL_CFG2_PREDIV_MSK,
 			   pll_cfg2_init);
@@ -232,7 +238,7 @@ static int sun8i_hdmi_phy_config(struct dw_hdmi *hdmi, void *data,
 	regmap_update_bits(phy->regs, SUN8I_HDMI_PHY_DBG_CTRL_REG,
 			   SUN8I_HDMI_PHY_DBG_CTRL_POL_MASK, val);
 
-	if (phy->variant->has_phy_clk)
+	if (phy->variant->phy_clk_num)
 		clk_set_rate(phy->clk_phy, mode->crtc_clock * 1000);
 
 	return phy->variant->phy_config(hdmi, phy, mode->crtc_clock * 1000);
@@ -393,7 +399,7 @@ static const struct sun8i_hdmi_phy_variant sun8i_a83t_hdmi_phy = {
 };
 
 static const struct sun8i_hdmi_phy_variant sun8i_h3_hdmi_phy = {
-	.has_phy_clk = true,
+	.phy_clk_num = 1,
 	.phy_init = &sun8i_hdmi_phy_init_h3,
 	.phy_disable = &sun8i_hdmi_phy_disable_h3,
 	.phy_config = &sun8i_hdmi_phy_config_h3,
@@ -464,7 +470,7 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, struct device_node *node)
 		goto err_put_clk_bus;
 	}
 
-	if (phy->variant->has_phy_clk) {
+	if (phy->variant->phy_clk_num) {
 		phy->clk_pll0 = of_clk_get_by_name(node, "pll-0");
 		if (IS_ERR(phy->clk_pll0)) {
 			dev_err(dev, "Could not get pll-0 clock\n");
@@ -472,7 +478,16 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, struct device_node *node)
 			goto err_put_clk_mod;
 		}
 
-		ret = sun8i_phy_clk_create(phy, dev);
+		if (phy->variant->phy_clk_num) {
+			phy->clk_pll1 = of_clk_get_by_name(node, "pll-1");
+			if (IS_ERR(phy->clk_pll1)) {
+				dev_err(dev, "Could not get pll-1 clock\n");
+				ret = PTR_ERR(phy->clk_pll1);
+				goto err_put_clk_mod;
+			}
+		}
+
+		ret = sun8i_phy_clk_create(phy, dev, phy->variant->phy_clk_num);
 		if (ret) {
 			dev_err(dev, "Couldn't create the PHY clock\n");
 			goto err_put_clk_pll0;
@@ -515,8 +530,8 @@ int sun8i_hdmi_phy_probe(struct sun8i_dw_hdmi *hdmi, struct device_node *node)
 err_put_rst_phy:
 	reset_control_put(phy->rst_phy);
 err_put_clk_pll0:
-	if (phy->variant->has_phy_clk)
-		clk_put(phy->clk_pll0);
+	clk_put(phy->clk_pll0);
+	clk_put(phy->clk_pll1);
 err_put_clk_mod:
 	clk_put(phy->clk_mod);
 err_put_clk_bus:
@@ -536,8 +551,8 @@ void sun8i_hdmi_phy_remove(struct sun8i_dw_hdmi *hdmi)
 
 	reset_control_put(phy->rst_phy);
 
-	if (phy->variant->has_phy_clk)
-		clk_put(phy->clk_pll0);
+	clk_put(phy->clk_pll0);
+	clk_put(phy->clk_pll1);
 	clk_put(phy->clk_mod);
 	clk_put(phy->clk_bus);
 }
diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
index faea449812f8..85b12fc96dbc 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy_clk.c
@@ -22,29 +22,36 @@ static int sun8i_phy_clk_determine_rate(struct clk_hw *hw,
 {
 	unsigned long rate = req->rate;
 	unsigned long best_rate = 0;
-	struct clk_hw *parent;
+	struct clk_hw *best_parent = NULL;
+	struct clk_hw *parent = NULL;
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
-
-		if (rounded == ideal) {
-			best_rate = rounded;
-			best_div = i;
-			break;
-		}
+	for (p = 0; p < clk_hw_get_num_parents(hw); p++) {
+		parent = clk_hw_get_parent_by_index(hw, p);
+		if (!parent)
+			continue;
 
-		if (!best_rate ||
-		    abs(rate - rounded / i) <
-		    abs(rate - best_rate / best_div)) {
-			best_rate = rounded;
-			best_div = i;
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
 	}
 
@@ -95,22 +102,58 @@ static int sun8i_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
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
+			 int clk_num)
 {
 	struct clk_init_data init;
 	struct sun8i_phy_clk *priv;
-	const char *parents[1];
+	const char *parents[2];
 
 	parents[0] = __clk_get_name(phy->clk_pll0);
 	if (!parents[0])
 		return -ENODEV;
 
+	if (clk_num == 2) {
+		parents[1] = __clk_get_name(phy->clk_pll1);
+		if (!parents[1])
+			return -ENODEV;
+	}
+
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -118,7 +161,7 @@ int sun8i_phy_clk_create(struct sun8i_hdmi_phy *phy, struct device *dev)
 	init.name = "hdmi-phy-clk";
 	init.ops = &sun8i_phy_clk_ops;
 	init.parent_names = parents;
-	init.num_parents = 1;
+	init.num_parents = clk_num;
 	init.flags = CLK_SET_RATE_PARENT;
 
 	priv->phy = phy;
-- 
2.14.3
