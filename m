Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeDSHZZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 03:25:25 -0400
Received: from mx.socionext.com ([202.248.49.38]:32904 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752273AbeDSHZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 03:25:11 -0400
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
Subject: [PATCH net-next v2 3/3] net: ethernet: ave: add support for phy-mode setting of system controller
Date: Thu, 19 Apr 2018 16:24:55 +0900
Message-Id: <1524122695-19597-4-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524122695-19597-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1524122695-19597-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for specifying system controller that configures
phy-mode setting.

According to the DT property "phy-mode", it's necessary to configure the
controller, which is used to choose the settings of the MAC suitable,
for example, mdio pin connections, internal clocks, and so on.

Supported phy-modes are SoC-dependent. The driver allows phy-mode to set
"internal" if the SoC has a built-in PHY, and {"mii", "rmii", "rgmii"}
if the SoC supports each mode. So we have to check whether the phy-mode
is valid or not.

This adds the following features for each SoC:
- check whether the SoC supports the specified phy-mode
- configure the controller accroding to phy-mode

The DT property accepts one argument to distinguish them for multiple MAC
instances.

ethernet@65000000 {
	...
	socionext,syscon-phy-mode = <&soc_glue 0>;
};

ethernet@65200000 {
	...
	socionext,syscon-phy-mode = <&soc_glue 1>;
};

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---
 drivers/net/ethernet/socionext/Kconfig   |   2 +
 drivers/net/ethernet/socionext/sni_ave.c | 150 ++++++++++++++++++++++++++++---
 2 files changed, 140 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/socionext/Kconfig b/drivers/net/ethernet/socionext/Kconfig
index 6bcfe27..b80048c 100644
--- a/drivers/net/ethernet/socionext/Kconfig
+++ b/drivers/net/ethernet/socionext/Kconfig
@@ -14,6 +14,8 @@ if NET_VENDOR_SOCIONEXT
 config SNI_AVE
 	tristate "Socionext AVE ethernet support"
 	depends on (ARCH_UNIPHIER || COMPILE_TEST) && OF
+	depends on HAS_IOMEM
+	select MFD_SYSCON
 	select PHYLIB
 	---help---
 	  Driver for gigabit ethernet MACs, called AVE, in the
diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index 52940bd..f7eccee 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -11,6 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/mfd/syscon.h>
 #include <linux/mii.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -18,6 +19,7 @@
 #include <linux/of_mdio.h>
 #include <linux/of_platform.h>
 #include <linux/phy.h>
+#include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/types.h>
 #include <linux/u64_stats_sync.h>
@@ -197,6 +199,11 @@
 #define AVE_INTM_COUNT		20
 #define AVE_FORCE_TXINTCNT	1
 
+/* SG */
+#define SG_ETPINMODE		0x540
+#define SG_ETPINMODE_EXTPHY	BIT(1)	/* for LD11 */
+#define SG_ETPINMODE_RMII(ins)	BIT(ins)
+
 #define IS_DESC_64BIT(p)	((p)->data->is_desc_64bit)
 
 #define AVE_MAX_CLKS		4
@@ -228,12 +235,6 @@ struct ave_desc_info {
 	struct ave_desc *desc;	/* skb info related descriptor */
 };
 
-struct ave_soc_data {
-	bool	is_desc_64bit;
-	const char	*clock_names[AVE_MAX_CLKS];
-	const char	*reset_names[AVE_MAX_RSTS];
-};
-
 struct ave_stats {
 	struct	u64_stats_sync	syncp;
 	u64	packets;
@@ -257,6 +258,9 @@ struct ave_private {
 	phy_interface_t		phy_mode;
 	struct phy_device	*phydev;
 	struct mii_bus		*mdio;
+	struct regmap		*regmap;
+	unsigned int		pinmode_mask;
+	unsigned int		pinmode_val;
 
 	/* stats */
 	struct ave_stats	stats_rx;
@@ -279,6 +283,14 @@ struct ave_private {
 	const struct ave_soc_data *data;
 };
 
+struct ave_soc_data {
+	bool	is_desc_64bit;
+	const char	*clock_names[AVE_MAX_CLKS];
+	const char	*reset_names[AVE_MAX_RSTS];
+	int	(*get_pinmode)(struct ave_private *priv,
+			       phy_interface_t phy_mode, u32 arg);
+};
+
 static u32 ave_desc_read(struct net_device *ndev, enum desc_id id, int entry,
 			 int offset)
 {
@@ -1179,6 +1191,11 @@ static int ave_init(struct net_device *ndev)
 		}
 	}
 
+	ret = regmap_update_bits(priv->regmap, SG_ETPINMODE,
+				 priv->pinmode_mask, priv->pinmode_val);
+	if (ret)
+		return ret;
+
 	ave_global_reset(ndev);
 
 	mdio_np = of_get_child_by_name(np, "mdio");
@@ -1537,6 +1554,7 @@ static int ave_probe(struct platform_device *pdev)
 	const struct ave_soc_data *data;
 	struct device *dev = &pdev->dev;
 	char buf[ETHTOOL_FWVERS_LEN];
+	struct of_phandle_args args;
 	phy_interface_t phy_mode;
 	struct ave_private *priv;
 	struct net_device *ndev;
@@ -1559,12 +1577,6 @@ static int ave_probe(struct platform_device *pdev)
 		dev_err(dev, "phy-mode not found\n");
 		return -EINVAL;
 	}
-	if ((!phy_interface_mode_is_rgmii(phy_mode)) &&
-	    phy_mode != PHY_INTERFACE_MODE_RMII &&
-	    phy_mode != PHY_INTERFACE_MODE_MII) {
-		dev_err(dev, "phy-mode is invalid\n");
-		return -EINVAL;
-	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -1656,6 +1668,26 @@ static int ave_probe(struct platform_device *pdev)
 		priv->nrsts++;
 	}
 
+	ret = of_parse_phandle_with_fixed_args(np,
+					       "socionext,syscon-phy-mode",
+					       1, 0, &args);
+	if (ret) {
+		netdev_err(ndev, "can't get syscon-phy-mode property\n");
+		goto out_free_netdev;
+	}
+	priv->regmap = syscon_node_to_regmap(args.np);
+	of_node_put(args.np);
+	if (IS_ERR(priv->regmap)) {
+		netdev_err(ndev, "can't map syscon-phy-mode\n");
+		ret = PTR_ERR(priv->regmap);
+		goto out_free_netdev;
+	}
+	ret = priv->data->get_pinmode(priv, phy_mode, args.args[0]);
+	if (ret) {
+		netdev_err(ndev, "invalid phy-mode setting\n");
+		goto out_free_netdev;
+	}
+
 	priv->mdio = devm_mdiobus_alloc(dev);
 	if (!priv->mdio) {
 		ret = -ENOMEM;
@@ -1715,6 +1747,95 @@ static int ave_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int ave_pro4_get_pinmode(struct ave_private *priv,
+				phy_interface_t phy_mode, u32 arg)
+{
+	if (arg > 0)
+		return -EINVAL;
+
+	priv->pinmode_mask = SG_ETPINMODE_RMII(0);
+
+	switch (phy_mode) {
+	case PHY_INTERFACE_MODE_RMII:
+		priv->pinmode_val = SG_ETPINMODE_RMII(0);
+		break;
+	case PHY_INTERFACE_MODE_MII:
+	case PHY_INTERFACE_MODE_RGMII:
+		priv->pinmode_val = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ave_ld11_get_pinmode(struct ave_private *priv,
+				phy_interface_t phy_mode, u32 arg)
+{
+	if (arg > 0)
+		return -EINVAL;
+
+	priv->pinmode_mask = SG_ETPINMODE_EXTPHY | SG_ETPINMODE_RMII(0);
+
+	switch (phy_mode) {
+	case PHY_INTERFACE_MODE_INTERNAL:
+		priv->pinmode_val = 0;
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		priv->pinmode_val = SG_ETPINMODE_EXTPHY | SG_ETPINMODE_RMII(0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ave_ld20_get_pinmode(struct ave_private *priv,
+				phy_interface_t phy_mode, u32 arg)
+{
+	if (arg > 0)
+		return -EINVAL;
+
+	priv->pinmode_mask = SG_ETPINMODE_RMII(0);
+
+	switch (phy_mode) {
+	case PHY_INTERFACE_MODE_RMII:
+		priv->pinmode_val = SG_ETPINMODE_RMII(0);
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+		priv->pinmode_val = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ave_pxs3_get_pinmode(struct ave_private *priv,
+				phy_interface_t phy_mode, u32 arg)
+{
+	if (arg > 1)
+		return -EINVAL;
+
+	priv->pinmode_mask = SG_ETPINMODE_RMII(arg);
+
+	switch (phy_mode) {
+	case PHY_INTERFACE_MODE_RMII:
+		priv->pinmode_val = SG_ETPINMODE_RMII(arg);
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+		priv->pinmode_val = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct ave_soc_data ave_pro4_data = {
 	.is_desc_64bit = false,
 	.clock_names = {
@@ -1723,6 +1844,7 @@ static const struct ave_soc_data ave_pro4_data = {
 	.reset_names = {
 		"gio", "ether",
 	},
+	.get_pinmode = ave_pro4_get_pinmode,
 };
 
 static const struct ave_soc_data ave_pxs2_data = {
@@ -1733,6 +1855,7 @@ static const struct ave_soc_data ave_pxs2_data = {
 	.reset_names = {
 		"ether",
 	},
+	.get_pinmode = ave_pro4_get_pinmode,
 };
 
 static const struct ave_soc_data ave_ld11_data = {
@@ -1743,6 +1866,7 @@ static const struct ave_soc_data ave_ld11_data = {
 	.reset_names = {
 		"ether",
 	},
+	.get_pinmode = ave_ld11_get_pinmode,
 };
 
 static const struct ave_soc_data ave_ld20_data = {
@@ -1753,6 +1877,7 @@ static const struct ave_soc_data ave_ld20_data = {
 	.reset_names = {
 		"ether",
 	},
+	.get_pinmode = ave_ld20_get_pinmode,
 };
 
 static const struct ave_soc_data ave_pxs3_data = {
@@ -1763,6 +1888,7 @@ static const struct ave_soc_data ave_pxs3_data = {
 	.reset_names = {
 		"ether",
 	},
+	.get_pinmode = ave_pxs3_get_pinmode,
 };
 
 static const struct of_device_id of_ave_match[] = {
-- 
2.7.4
