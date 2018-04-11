Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753602AbeDKOUv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:20:51 -0400
Received: from hermes.aosc.io ([199.195.250.187]:48351 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752909AbeDKOUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:20:49 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 2/5] net: stmmac: dwmac-sun8i: Use regmap_field for syscon register access
Date: Wed, 11 Apr 2018 22:16:38 +0800
Message-Id: <20180411141641.14675-3-icenowy@aosc.io>
In-Reply-To: <20180411141641.14675-1-icenowy@aosc.io>
References: <20180411141641.14675-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

In several SoCs the EMAC register is in the range of another device,
either the SRAM controller (e.g. A64) or the clock controlling unit
(e.g. R40). In this situation we're going to let the device to export a
regmap which contains only the EMAC register, for the dwmac-sun8i driver
to manipulation this register.

This patch converts the use of regmap to regmap_field for mapping and
accessing the EMAC register, so we can have the register address based
on the regmap class, and not in the actual register manipulation code.

This patch only converts regmap_read() and regmap_write() calls to
regmap_field_read() and regmap_field_write() calls. There are some
places where it might make sense to switch to regmap_field_update_bits(),
but this is not done here to keep the patch simple.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
[Icenowy: decide reg_field based on regmap type, change commit message]
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 41 ++++++++++++++++-------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index a3fa65b1ca8e..1037f6c78bca 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -61,9 +61,10 @@ struct emac_variant {
  * @regulator:	reference to the optional regulator
  * @rst_ephy:	reference to the optional EPHY reset for the internal PHY
  * @variant:	reference to the current board variant
- * @regmap:	regmap for using the syscon
+ * @regmap_field: regmap field for the gmac register
  * @internal_phy_powered: Does the internal PHY is enabled
  * @mux_handle:	Internal pointer used by mdio-mux lib
+ * @emac_reg_field: reg_field for the regmap's gmac register
  */
 struct sunxi_priv_data {
 	struct clk *tx_clk;
@@ -71,9 +72,17 @@ struct sunxi_priv_data {
 	struct regulator *regulator;
 	struct reset_control *rst_ephy;
 	const struct emac_variant *variant;
-	struct regmap *regmap;
+	struct regmap_field *regmap_field;
 	bool internal_phy_powered;
 	void *mux_handle;
+	const struct reg_field *emac_reg_field;
+};
+
+/* EMAC clock register @ 0x30 in the "system control" address range */
+const struct reg_field old_syscon_reg_field = {
+	.reg = 0x30,
+	.lsb = 0,
+	.msb = 31,
 };
 
 static const struct emac_variant emac_variant_h3 = {
@@ -216,7 +225,6 @@ static const struct emac_variant emac_variant_a64 = {
 #define SYSCON_ETCS_MII		0x0
 #define SYSCON_ETCS_EXT_GMII	0x1
 #define SYSCON_ETCS_INT_GMII	0x2
-#define SYSCON_EMAC_REG		0x30
 
 /* sun8i_dwmac_dma_reset() - reset the EMAC
  * Called from stmmac via stmmac_dma_ops->reset
@@ -745,7 +753,7 @@ static int mdio_mux_syscon_switch_fn(int current_child, int desired_child,
 	bool need_power_ephy = false;
 
 	if (current_child ^ desired_child) {
-		regmap_read(gmac->regmap, SYSCON_EMAC_REG, &reg);
+		regmap_field_read(gmac->regmap_field, &reg);
 		switch (desired_child) {
 		case DWMAC_SUN8I_MDIO_MUX_INTERNAL_ID:
 			dev_info(priv->device, "Switch mux to internal PHY");
@@ -763,7 +771,7 @@ static int mdio_mux_syscon_switch_fn(int current_child, int desired_child,
 				desired_child);
 			return -EINVAL;
 		}
-		regmap_write(gmac->regmap, SYSCON_EMAC_REG, val);
+		regmap_field_write(gmac->regmap_field, val);
 		if (need_power_ephy) {
 			ret = sun8i_dwmac_power_internal_phy(priv);
 			if (ret)
@@ -801,7 +809,7 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv *priv)
 	int ret;
 	u32 reg, val;
 
-	regmap_read(gmac->regmap, SYSCON_EMAC_REG, &val);
+	regmap_field_read(gmac->regmap_field, &val);
 	reg = gmac->variant->default_syscon_value;
 	if (reg != val)
 		dev_warn(priv->device,
@@ -883,7 +891,7 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv *priv)
 		return -EINVAL;
 	}
 
-	regmap_write(gmac->regmap, SYSCON_EMAC_REG, reg);
+	regmap_field_write(gmac->regmap_field, reg);
 
 	return 0;
 }
@@ -892,7 +900,7 @@ static void sun8i_dwmac_unset_syscon(struct sunxi_priv_data *gmac)
 {
 	u32 reg = gmac->variant->default_syscon_value;
 
-	regmap_write(gmac->regmap, SYSCON_EMAC_REG, reg);
+	regmap_field_write(gmac->regmap_field, reg);
 }
 
 static void sun8i_dwmac_exit(struct platform_device *pdev, void *priv)
@@ -980,6 +988,7 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 	int ret;
 	struct stmmac_priv *priv;
 	struct net_device *ndev;
+	struct regmap *regmap;
 
 	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
 	if (ret)
@@ -1014,13 +1023,21 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 		gmac->regulator = NULL;
 	}
 
-	gmac->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
-						       "syscon");
-	if (IS_ERR(gmac->regmap)) {
-		ret = PTR_ERR(gmac->regmap);
+	regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "syscon");
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
 		dev_err(&pdev->dev, "Unable to map syscon: %d\n", ret);
 		return ret;
 	}
+	gmac->emac_reg_field = old_syscon_reg_field;
+
+	gmac->regmap_field = devm_regmap_field_alloc(dev, regmap,
+						     *gmac->emac_reg_field);
+	if (IS_ERR(gmac->regmap_field)) {
+		ret = PTR_ERR(gmac->regmap_field);
+		dev_err(dev, "Unable to map syscon register: %d\n", ret);
+		return ret;
+	}
 
 	plat_dat->interface = of_get_phy_mode(dev->of_node);
 
-- 
2.15.1
