Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754148AbeDZIFo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 04:05:44 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:16171 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752419AbeDZIF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 04:05:29 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>
CC: Yixun Lan <yixun.lan@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] net: stmmac: dwmac-meson: extend phy mode setting
Date: Thu, 26 Apr 2018 16:05:08 +0000
Message-ID: <20180426160508.29380-3-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180426160508.29380-1-yixun.lan@amlogic.com>
References: <20180426160508.29380-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.250]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  In the Meson-AXG SoC, the phy mode setting of PRG_ETH0 in the glue layer
is extended from bit[0] to bit[2:0].
  There is no problem if we configure it to the RGMII 1000M PHY mode,
since the register setting is coincidentally compatible with previous one,
but for the RMII 100M PHY mode, the configuration need to be changed to
value - b100.
  This patch was verified with a RTL8201F 100M ethernet PHY.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 95 ++++++++++++++++---
 1 file changed, 84 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index 7cb794094a70..e3688b6dd87c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/of_net.h>
 #include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
@@ -29,6 +30,10 @@
 
 #define PRG_ETH0_RGMII_MODE		BIT(0)
 
+#define PRG_ETH0_EXT_PHY_MODE_MASK	GENMASK(2, 0)
+#define PRG_ETH0_EXT_RGMII_MODE		1
+#define PRG_ETH0_EXT_RMII_MODE		4
+
 /* mux to choose between fclk_div2 (bit unset) and mpll2 (bit set) */
 #define PRG_ETH0_CLK_M250_SEL_SHIFT	4
 #define PRG_ETH0_CLK_M250_SEL_MASK	GENMASK(4, 4)
@@ -46,10 +51,16 @@
 #define PRG_ETH0_TX_AND_PHY_REF_CLK	BIT(12)
 
 #define MUX_CLK_NUM_PARENTS		2
+struct meson8b_dwmac_data {
+	bool ext_phy_mode;
+};
 
 struct meson8b_dwmac {
 	struct device		*dev;
 	void __iomem		*regs;
+
+	const struct meson8b_dwmac_data *data;
+
 	phy_interface_t		phy_mode;
 	struct clk		*rgmii_tx_clk;
 	u32			tx_delay_ns;
@@ -171,6 +182,46 @@ static int meson8b_init_rgmii_tx_clk(struct meson8b_dwmac *dwmac)
 	return 0;
 }
 
+static int meson8b_init_set_mode(struct meson8b_dwmac *dwmac)
+{
+	bool ext_phy_mode = dwmac->data->ext_phy_mode;
+
+	switch (dwmac->phy_mode) {
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		/* enable RGMII mode */
+		if (ext_phy_mode)
+			meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
+						PRG_ETH0_EXT_PHY_MODE_MASK,
+						PRG_ETH0_EXT_RGMII_MODE);
+		else
+			meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
+						PRG_ETH0_RGMII_MODE,
+						PRG_ETH0_RGMII_MODE);
+
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		/* disable RGMII mode -> enables RMII mode */
+		if (ext_phy_mode)
+			meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
+						PRG_ETH0_EXT_PHY_MODE_MASK,
+						PRG_ETH0_EXT_RMII_MODE);
+		else
+			meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
+						PRG_ETH0_RGMII_MODE, 0);
+
+		break;
+	default:
+		dev_err(dwmac->dev, "fail to set phy-mode %s\n",
+			phy_modes(dwmac->phy_mode));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int meson8b_init_prg_eth(struct meson8b_dwmac *dwmac)
 {
 	int ret;
@@ -188,10 +239,6 @@ static int meson8b_init_prg_eth(struct meson8b_dwmac *dwmac)
 
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
-		/* enable RGMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0, PRG_ETH0_RGMII_MODE,
-					PRG_ETH0_RGMII_MODE);
-
 		/* only relevant for RMII mode -> disable in RGMII mode */
 		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
 					PRG_ETH0_INVERTED_RMII_CLK, 0);
@@ -224,10 +271,6 @@ static int meson8b_init_prg_eth(struct meson8b_dwmac *dwmac)
 		break;
 
 	case PHY_INTERFACE_MODE_RMII:
-		/* disable RGMII mode -> enables RMII mode */
-		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0, PRG_ETH0_RGMII_MODE,
-					0);
-
 		/* invert internal clk_rmii_i to generate 25/2.5 tx_rx_clk */
 		meson8b_dwmac_mask_bits(dwmac, PRG_ETH0,
 					PRG_ETH0_INVERTED_RMII_CLK,
@@ -274,6 +317,11 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 		goto err_remove_config_dt;
 	}
 
+	dwmac->data = (const struct meson8b_dwmac_data *)
+		of_device_get_match_data(&pdev->dev);
+	if (!dwmac->data)
+		return -EINVAL;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	dwmac->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(dwmac->regs)) {
@@ -298,6 +346,10 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_remove_config_dt;
 
+	ret = meson8b_init_set_mode(dwmac);
+	if (ret)
+		goto err_remove_config_dt;
+
 	ret = meson8b_init_prg_eth(dwmac);
 	if (ret)
 		goto err_remove_config_dt;
@@ -316,10 +368,31 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct meson8b_dwmac_data meson8b_dwmac_data = {
+	.ext_phy_mode = false,
+};
+
+static const struct meson8b_dwmac_data meson_axg_dwmac_data = {
+	.ext_phy_mode = true,
+};
+
 static const struct of_device_id meson8b_dwmac_match[] = {
-	{ .compatible = "amlogic,meson8b-dwmac" },
-	{ .compatible = "amlogic,meson8m2-dwmac" },
-	{ .compatible = "amlogic,meson-gxbb-dwmac" },
+	{
+		.compatible = "amlogic,meson8b-dwmac",
+		.data = &meson8b_dwmac_data,
+	},
+	{
+		.compatible = "amlogic,meson8m2-dwmac",
+		.data = &meson8b_dwmac_data,
+	},
+	{
+		.compatible = "amlogic,meson-gxbb-dwmac",
+		.data = &meson8b_dwmac_data,
+	},
+	{
+		.compatible = "amlogic,meson-axg-dwmac",
+		.data = &meson_axg_dwmac_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, meson8b_dwmac_match);
-- 
2.17.0
