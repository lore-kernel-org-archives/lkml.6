Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752325AbeDSHZK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 03:25:10 -0400
Received: from mx.socionext.com ([202.248.49.38]:32904 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751381AbeDSHZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 03:25:07 -0400
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH net-next v2 1/3] net: ethernet: ave: add multiple clocks and resets support as required property
Date: Thu, 19 Apr 2018 16:24:53 +0900
Message-Id: <1524122695-19597-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524122695-19597-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1524122695-19597-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the link is becoming up for Pro4 SoC, the kernel is stalled
due to some missing clocks and resets.

The AVE block for Pro4 is connected to the GIO bus in the SoC.
Without its clock/reset, the access to the AVE register makes the
system stall.

In the same way, another MAC clock for Giga-bit Connection and
the PHY clock are also required for Pro4 to activate the Giga-bit feature
and to recognize the PHY.

To satisfy these requirements, this patch adds support for multiple clocks
and resets, and adds the clock-names and reset-names to the binding because
we need to distinguish clock/reset for the AVE main block and the others.

Also, make the resets a required property. Currently, "reset is
optional" relies on that the bootloader or firmware has deasserted
the reset before booting the kernel.  Drivers should work without
such expectation.

Fixes: 4c270b55a5af ("net: ethernet: socionext: add AVE ethernet driver")
Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/net/socionext,uniphier-ave4.txt       |  13 ++-
 drivers/net/ethernet/socionext/sni_ave.c           | 108 ++++++++++++++++-----
 2 files changed, 96 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt b/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt
index 96398cc..85e0c49 100644
--- a/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt
+++ b/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt
@@ -17,9 +17,18 @@ Required properties:
  - phy-handle: Should point to the external phy device.
 	See ethernet.txt file in the same directory.
  - clocks: A phandle to the clock for the MAC.
+	For Pro4 SoC, that is "socionext,uniphier-pro4-ave4",
+	another MAC clock, GIO bus clock and PHY clock are also required.
+ - clock-names: Should contain
+	- "ether", "ether-gb", "gio", "ether-phy" for Pro4 SoC
+	- "ether" for others
+ - resets: A phandle to the reset control for the MAC. For Pro4 SoC,
+	GIO bus reset is also required.
+ - reset-names: Should contain
+	- "ether", "gio" for Pro4 SoC
+	- "ether" for others
 
 Optional properties:
- - resets: A phandle to the reset control for the MAC.
  - local-mac-address: See ethernet.txt in the same directory.
 
 Required subnode:
@@ -34,7 +43,9 @@ Example:
 		interrupts = <0 66 4>;
 		phy-mode = "rgmii";
 		phy-handle = <&ethphy>;
+		clock-names = "ether";
 		clocks = <&sys_clk 6>;
+		reset-names = "ether";
 		resets = <&sys_rst 6>;
 		local-mac-address = [00 00 00 00 00 00];
 
diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index 0b3b7a4..52940bd 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -199,6 +199,9 @@
 
 #define IS_DESC_64BIT(p)	((p)->data->is_desc_64bit)
 
+#define AVE_MAX_CLKS		4
+#define AVE_MAX_RSTS		2
+
 enum desc_id {
 	AVE_DESCID_RX,
 	AVE_DESCID_TX,
@@ -227,6 +230,8 @@ struct ave_desc_info {
 
 struct ave_soc_data {
 	bool	is_desc_64bit;
+	const char	*clock_names[AVE_MAX_CLKS];
+	const char	*reset_names[AVE_MAX_RSTS];
 };
 
 struct ave_stats {
@@ -245,8 +250,10 @@ struct ave_private {
 	int			phy_id;
 	unsigned int		desc_size;
 	u32			msg_enable;
-	struct clk		*clk;
-	struct reset_control	*rst;
+	int			nclks;
+	struct clk		*clk[AVE_MAX_CLKS];
+	int			nrsts;
+	struct reset_control	*rst[AVE_MAX_RSTS];
 	phy_interface_t		phy_mode;
 	struct phy_device	*phydev;
 	struct mii_bus		*mdio;
@@ -1153,18 +1160,23 @@ static int ave_init(struct net_device *ndev)
 	struct device_node *np = dev->of_node;
 	struct device_node *mdio_np;
 	struct phy_device *phydev;
-	int ret;
+	int nc, nr, ret;
 
 	/* enable clk because of hw access until ndo_open */
-	ret = clk_prepare_enable(priv->clk);
-	if (ret) {
-		dev_err(dev, "can't enable clock\n");
-		return ret;
+	for (nc = 0; nc < priv->nclks; nc++) {
+		ret = clk_prepare_enable(priv->clk[nc]);
+		if (ret) {
+			dev_err(dev, "can't enable clock\n");
+			goto out_clk_disable;
+		}
 	}
-	ret = reset_control_deassert(priv->rst);
-	if (ret) {
-		dev_err(dev, "can't deassert reset\n");
-		goto out_clk_disable;
+
+	for (nr = 0; nr < priv->nrsts; nr++) {
+		ret = reset_control_deassert(priv->rst[nr]);
+		if (ret) {
+			dev_err(dev, "can't deassert reset\n");
+			goto out_reset_assert;
+		}
 	}
 
 	ave_global_reset(ndev);
@@ -1207,9 +1219,11 @@ static int ave_init(struct net_device *ndev)
 out_mdio_unregister:
 	mdiobus_unregister(priv->mdio);
 out_reset_assert:
-	reset_control_assert(priv->rst);
+	while (--nr >= 0)
+		reset_control_assert(priv->rst[nr]);
 out_clk_disable:
-	clk_disable_unprepare(priv->clk);
+	while (--nc >= 0)
+		clk_disable_unprepare(priv->clk[nc]);
 
 	return ret;
 }
@@ -1217,13 +1231,16 @@ static int ave_init(struct net_device *ndev)
 static void ave_uninit(struct net_device *ndev)
 {
 	struct ave_private *priv = netdev_priv(ndev);
+	int i;
 
 	phy_disconnect(priv->phydev);
 	mdiobus_unregister(priv->mdio);
 
 	/* disable clk because of hw access after ndo_stop */
-	reset_control_assert(priv->rst);
-	clk_disable_unprepare(priv->clk);
+	for (i = 0; i < priv->nrsts; i++)
+		reset_control_assert(priv->rst[i]);
+	for (i = 0; i < priv->nclks; i++)
+		clk_disable_unprepare(priv->clk[i]);
 }
 
 static int ave_open(struct net_device *ndev)
@@ -1527,8 +1544,9 @@ static int ave_probe(struct platform_device *pdev)
 	struct resource	*res;
 	const void *mac_addr;
 	void __iomem *base;
+	const char *name;
+	int i, irq, ret;
 	u64 dma_mask;
-	int irq, ret;
 	u32 ave_id;
 
 	data = of_device_get_match_data(dev);
@@ -1614,16 +1632,28 @@ static int ave_probe(struct platform_device *pdev)
 	u64_stats_init(&priv->stats_tx.syncp);
 	u64_stats_init(&priv->stats_rx.syncp);
 
-	priv->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(priv->clk)) {
-		ret = PTR_ERR(priv->clk);
-		goto out_free_netdev;
+	for (i = 0; i < AVE_MAX_CLKS; i++) {
+		name = priv->data->clock_names[i];
+		if (!name)
+			break;
+		priv->clk[i] = devm_clk_get(dev, name);
+		if (IS_ERR(priv->clk[i])) {
+			ret = PTR_ERR(priv->clk[i]);
+			goto out_free_netdev;
+		}
+		priv->nclks++;
 	}
 
-	priv->rst = devm_reset_control_get_optional_shared(dev, NULL);
-	if (IS_ERR(priv->rst)) {
-		ret = PTR_ERR(priv->rst);
-		goto out_free_netdev;
+	for (i = 0; i < AVE_MAX_RSTS; i++) {
+		name = priv->data->reset_names[i];
+		if (!name)
+			break;
+		priv->rst[i] = devm_reset_control_get_shared(dev, name);
+		if (IS_ERR(priv->rst[i])) {
+			ret = PTR_ERR(priv->rst[i]);
+			goto out_free_netdev;
+		}
+		priv->nrsts++;
 	}
 
 	priv->mdio = devm_mdiobus_alloc(dev);
@@ -1687,22 +1717,52 @@ static int ave_remove(struct platform_device *pdev)
 
 static const struct ave_soc_data ave_pro4_data = {
 	.is_desc_64bit = false,
+	.clock_names = {
+		"gio", "ether", "ether-gb", "ether-phy",
+	},
+	.reset_names = {
+		"gio", "ether",
+	},
 };
 
 static const struct ave_soc_data ave_pxs2_data = {
 	.is_desc_64bit = false,
+	.clock_names = {
+		"ether",
+	},
+	.reset_names = {
+		"ether",
+	},
 };
 
 static const struct ave_soc_data ave_ld11_data = {
 	.is_desc_64bit = false,
+	.clock_names = {
+		"ether",
+	},
+	.reset_names = {
+		"ether",
+	},
 };
 
 static const struct ave_soc_data ave_ld20_data = {
 	.is_desc_64bit = true,
+	.clock_names = {
+		"ether",
+	},
+	.reset_names = {
+		"ether",
+	},
 };
 
 static const struct ave_soc_data ave_pxs3_data = {
 	.is_desc_64bit = false,
+	.clock_names = {
+		"ether",
+	},
+	.reset_names = {
+		"ether",
+	},
 };
 
 static const struct of_device_id of_ave_match[] = {
-- 
2.7.4
