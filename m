Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA2EECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72742082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 03:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72742082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbeJ2Lwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 07:52:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:16143 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729240AbeJ2Lw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 07:52:28 -0400
X-UUID: 0d7c1fb8822843c29bdef20a9e0cda4a-20181029
X-UUID: 0d7c1fb8822843c29bdef20a9e0cda4a-20181029
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 637982904; Mon, 29 Oct 2018 11:05:14 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 29 Oct 2018 11:05:13 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 29 Oct 2018 11:05:13 +0800
From:   Biao Huang <biao.huang@mediatek.com>
To:     <davem@davemloft.net>, <robh+dt@kernel.org>
CC:     <honghui.zhang@mediatek.com>, <yt.shen@mediatek.com>,
        <liguo.zhang@mediatek.com>, <mark.rutland@arm.com>,
        <sean.wang@mediatek.com>, <nelson.chang@mediatek.com>,
        <matthias.bgg@gmail.com>, <biao.huang@mediatek.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <joabreu@synopsys.com>,
        <andrew@lunn.ch>
Subject: [PATCH 1/2] net:stmmac: dwmac-mediatek: add support for mt2712
Date:   Mon, 29 Oct 2018 11:04:53 +0800
Message-ID: <1540782294-27721-2-git-send-email-biao.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1540782294-27721-1-git-send-email-biao.huang@mediatek.com>
References: <1540782294-27721-1-git-send-email-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Ethernet support for MediaTek SoCs from the mt2712 family

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |    8 +
 drivers/net/ethernet/stmicro/stmmac/Makefile       |    1 +
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |  364 ++++++++++++++++++++
 3 files changed, 373 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index edf2036..76d779e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -75,6 +75,14 @@ config DWMAC_LPC18XX
 	---help---
 	  Support for NXP LPC18xx/43xx DWMAC Ethernet.
 
+config DWMAC_MEDIATEK
+	tristate "MediaTek MT27xx GMAC support"
+	depends on OF
+	help
+	  Support for MediaTek GMAC Ethernet controller.
+
+	  This selects the MT2712 SoC support for the stmmac driver.
+
 config DWMAC_MESON
 	tristate "Amlogic Meson dwmac support"
 	default ARCH_MESON
diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index 99967a8..bf09701 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_STMMAC_PLATFORM)	+= stmmac-platform.o
 obj-$(CONFIG_DWMAC_ANARION)	+= dwmac-anarion.o
 obj-$(CONFIG_DWMAC_IPQ806X)	+= dwmac-ipq806x.o
 obj-$(CONFIG_DWMAC_LPC18XX)	+= dwmac-lpc18xx.o
+obj-$(CONFIG_DWMAC_MEDIATEK)	+= dwmac-mediatek.o
 obj-$(CONFIG_DWMAC_MESON)	+= dwmac-meson.o dwmac-meson8b.o
 obj-$(CONFIG_DWMAC_OXNAS)	+= dwmac-oxnas.o
 obj-$(CONFIG_DWMAC_ROCKCHIP)	+= dwmac-rk.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
new file mode 100644
index 0000000..9ccf3a5
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -0,0 +1,364 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2018 MediaTek Inc.
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_net.h>
+#include <linux/regmap.h>
+#include <linux/stmmac.h>
+
+#include "stmmac.h"
+#include "stmmac_platform.h"
+
+/* Peri Configuration register */
+#define PERI_ETH_PHY_INTF_SEL	0x418
+#define PHY_INTF_MII_GMII	0
+#define PHY_INTF_RGMII		1
+#define PHY_INTF_RMII		4
+#define RMII_CLK_SRC_RXC	BIT(4)
+#define RMII_CLK_SRC_INTERNAL	BIT(5)
+
+#define PERI_ETH_PHY_DLY	0x428
+#define PHY_DLY_GTXC_INV	BIT(6)
+#define PHY_DLY_GTXC_ENABLE	BIT(5)
+#define PHY_DLY_GTXC_STAGES	GENMASK(4, 0)
+#define PHY_DLY_TXC_INV		BIT(20)
+#define PHY_DLY_TXC_ENABLE	BIT(19)
+#define PHY_DLY_TXC_STAGES	GENMASK(18, 14)
+#define PHY_DLY_TXC_SHIFT	14
+#define PHY_DLY_RXC_INV		BIT(13)
+#define PHY_DLY_RXC_ENABLE	BIT(12)
+#define PHY_DLY_RXC_STAGES	GENMASK(11, 7)
+#define PHY_DLY_RXC_SHIFT	7
+
+#define PERI_ETH_DLY_FINE	0x800
+#define ETH_RMII_DLY_TX_INV	BIT(2)
+#define ETH_FINE_DLY_GTXC	BIT(1)
+#define ETH_FINE_DLY_RXC	BIT(0)
+
+enum dwmac_clks_map {
+	DWMAC_CLK_AXI_DRAM,
+	DWMAC_CLK_APB_REG,
+	DWMAC_CLK_MAC_EXT,
+	DWMAC_CLK_MAC_PARENT,
+	DWMAC_CLK_PTP_REF,
+	DWMAC_CLK_PTP_PARENT,
+	DWMAC_CLK_PTP_TOP,
+	DWMAC_CLK_MAX
+};
+
+struct mac_delay_struct {
+	u32 tx_delay;
+	u32 rx_delay;
+	u32 tx_inv;
+	u32 rx_inv;
+};
+
+struct mediatek_dwmac_plat_data {
+	struct device *dev;
+	struct regmap *peri_regmap;
+	struct clk *clks[DWMAC_CLK_MAX];
+	struct device_node *np;
+	int phy_mode;
+	struct mac_delay_struct mac_delay;
+	const struct mediatek_dwmac_variant *variant;
+	int fine_tune;
+	int rmii_rxc;
+};
+
+struct mediatek_dwmac_variant {
+	int (*dwmac_config_dt)(struct mediatek_dwmac_plat_data *plat);
+	int (*dwmac_enable_clks)(struct mediatek_dwmac_plat_data *plat);
+	void (*dwmac_disable_clks)(struct mediatek_dwmac_plat_data *plat);
+};
+
+static const char * const mediatek_dwmac_clks_name[] = {
+	"axi", "apb", "mac_ext", "mac_parent", "ptp_ref", "ptp_parent", "ptp_top"
+};
+
+static int mt2712_set_interface(struct mediatek_dwmac_plat_data *plat)
+{
+	int rmii_rxc = plat->rmii_rxc ? RMII_CLK_SRC_RXC : 0;
+	u32 intf_val = 0;
+
+	/* select phy interface in top control domain */
+	switch (plat->phy_mode) {
+	case PHY_INTERFACE_MODE_MII:
+		intf_val |= PHY_INTF_MII_GMII;
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		intf_val |= PHY_INTF_RMII;
+		intf_val |= rmii_rxc;
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		intf_val |= PHY_INTF_RGMII;
+		break;
+	default:
+		pr_err("phy interface not support\n");
+		return -EINVAL;
+	}
+
+	regmap_write(plat->peri_regmap, PERI_ETH_PHY_INTF_SEL, intf_val);
+
+	return 0;
+}
+
+static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
+{
+	struct mac_delay_struct *mac_delay = &plat->mac_delay;
+	u32 delay_val = 0;
+	u32 fine_val = 0;
+
+	switch (plat->phy_mode) {
+	case PHY_INTERFACE_MODE_MII:
+		delay_val |= mac_delay->tx_delay ? PHY_DLY_TXC_ENABLE : 0;
+		delay_val |= (mac_delay->tx_delay << PHY_DLY_TXC_SHIFT) &
+			     PHY_DLY_TXC_STAGES;
+		delay_val |= mac_delay->tx_inv ? PHY_DLY_TXC_INV : 0;
+		delay_val |= mac_delay->rx_delay ? PHY_DLY_RXC_ENABLE : 0;
+		delay_val |= (mac_delay->rx_delay << PHY_DLY_RXC_SHIFT) &
+			     PHY_DLY_RXC_STAGES;
+		delay_val |= mac_delay->rx_inv ? PHY_DLY_RXC_INV : 0;
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		if (plat->rmii_rxc) {
+			delay_val |= mac_delay->rx_delay ?
+				     PHY_DLY_RXC_ENABLE : 0;
+			delay_val |= (mac_delay->rx_delay <<
+				      PHY_DLY_RXC_SHIFT) & PHY_DLY_RXC_STAGES;
+			delay_val |= mac_delay->rx_inv ? PHY_DLY_RXC_INV : 0;
+			fine_val |= mac_delay->tx_inv ?
+				     ETH_RMII_DLY_TX_INV : 0;
+		} else {
+			delay_val |= mac_delay->tx_delay ?
+				     PHY_DLY_TXC_ENABLE : 0;
+			delay_val |= (mac_delay->tx_delay <<
+				     PHY_DLY_TXC_SHIFT) & PHY_DLY_TXC_STAGES;
+			delay_val |= mac_delay->tx_inv ? PHY_DLY_TXC_INV : 0;
+			fine_val |= mac_delay->rx_inv ?
+				     ETH_RMII_DLY_TX_INV : 0;
+		}
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+		fine_val = plat->fine_tune ?
+			    (ETH_FINE_DLY_GTXC | ETH_FINE_DLY_RXC) : 0;
+		delay_val |= mac_delay->tx_delay ? PHY_DLY_GTXC_ENABLE : 0;
+		delay_val |= mac_delay->tx_delay & PHY_DLY_GTXC_STAGES;
+		delay_val |= mac_delay->tx_inv ? PHY_DLY_GTXC_INV : 0;
+		delay_val |= mac_delay->rx_delay ? PHY_DLY_RXC_ENABLE : 0;
+		delay_val |= (mac_delay->rx_delay << PHY_DLY_RXC_SHIFT) &
+			     PHY_DLY_RXC_STAGES;
+		delay_val |= mac_delay->rx_inv ? PHY_DLY_RXC_INV : 0;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		fine_val = plat->fine_tune ? ETH_FINE_DLY_RXC : 0;
+		delay_val |= mac_delay->rx_delay ? PHY_DLY_RXC_ENABLE : 0;
+		delay_val |= (mac_delay->rx_delay << PHY_DLY_RXC_SHIFT) &
+			     PHY_DLY_RXC_STAGES;
+		delay_val |= mac_delay->rx_inv ? PHY_DLY_RXC_INV : 0;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		fine_val = plat->fine_tune ? ETH_FINE_DLY_GTXC : 0;
+		delay_val |= mac_delay->tx_delay ? PHY_DLY_GTXC_ENABLE : 0;
+		delay_val |= mac_delay->tx_delay & PHY_DLY_GTXC_STAGES;
+		delay_val |= mac_delay->tx_inv ? PHY_DLY_GTXC_INV : 0;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		break;
+	default:
+		pr_err("phy interface not support\n");
+		return -EINVAL;
+	}
+	regmap_write(plat->peri_regmap, PERI_ETH_PHY_DLY, delay_val);
+	regmap_write(plat->peri_regmap, PERI_ETH_DLY_FINE, fine_val);
+
+	return 0;
+}
+
+static int mt2712_get_clks(struct mediatek_dwmac_plat_data *plat)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(plat->clks); i++) {
+		plat->clks[i] = devm_clk_get(plat->dev,
+					     mediatek_dwmac_clks_name[i]);
+		if (IS_ERR(plat->clks[i]))
+			return PTR_ERR(plat->clks[i]);
+	}
+
+	return 0;
+}
+
+static int mt2712_enable_clks(struct mediatek_dwmac_plat_data *plat)
+{
+	int clk, ret;
+
+	for (clk = 0; clk < DWMAC_CLK_MAX ; clk++) {
+		ret = clk_prepare_enable(plat->clks[clk]);
+		if (ret)
+			goto err_disable_clks;
+	}
+
+	ret = clk_set_parent(plat->clks[DWMAC_CLK_MAC_EXT], plat->clks[DWMAC_CLK_MAC_PARENT]);
+	if (ret)
+		goto err_disable_clks;
+
+	ret = clk_set_parent(plat->clks[DWMAC_CLK_PTP_REF], plat->clks[DWMAC_CLK_PTP_PARENT]);
+	if (ret)
+		goto err_disable_clks;
+
+	return 0;
+
+err_disable_clks:
+	while (--clk >= 0)
+		clk_disable_unprepare(plat->clks[clk]);
+
+	return ret;
+}
+
+static void mt2712_disable_clks(struct mediatek_dwmac_plat_data *plat)
+{
+	int clk;
+
+	for (clk = DWMAC_CLK_MAX - 1; clk >= 0; clk--)
+		clk_disable_unprepare(plat->clks[clk]);
+}
+
+static int mt2712_config_dt(struct mediatek_dwmac_plat_data *plat)
+{
+	u32 mac_timings[4];
+
+	plat->peri_regmap = syscon_regmap_lookup_by_compatible("mediatek,mt2712-pericfg");
+	if (IS_ERR(plat->peri_regmap)) {
+		dev_err(plat->dev, "Failed to get pericfg syscon\n");
+		return PTR_ERR(plat->peri_regmap);
+	}
+
+	if (!of_property_read_u32_array(plat->np, "mac-delay", mac_timings,
+					ARRAY_SIZE(mac_timings))) {
+		plat->mac_delay.tx_delay = mac_timings[0];
+		plat->mac_delay.rx_delay = mac_timings[1];
+		plat->mac_delay.tx_inv = mac_timings[2];
+		plat->mac_delay.rx_inv = mac_timings[3];
+	}
+
+	plat->fine_tune = of_property_read_bool(plat->np, "fine-tune");
+
+	plat->rmii_rxc = of_property_read_bool(plat->np, "rmii-rxc");
+
+	mt2712_set_interface(plat);
+
+	mt2712_set_delay(plat);
+
+	return mt2712_get_clks(plat);
+}
+
+static const struct mediatek_dwmac_variant mt2712_gmac_variant = {
+		.dwmac_config_dt = mt2712_config_dt,
+		.dwmac_enable_clks = mt2712_enable_clks,
+		.dwmac_disable_clks = mt2712_disable_clks,
+};
+
+static int mediatek_dwmac_config_dt(struct mediatek_dwmac_plat_data *plat)
+{
+	const struct mediatek_dwmac_variant *variant = plat->variant;
+
+	/* Set the DMA mask, 4GB mode enabled */
+	dma_set_mask_and_coherent(plat->dev, DMA_BIT_MASK(33));
+
+	return variant->dwmac_config_dt(plat);
+}
+
+static int mediatek_dwmac_init(struct platform_device *pdev, void *priv)
+{
+	struct mediatek_dwmac_plat_data *plat = priv;
+	const struct mediatek_dwmac_variant *variant = plat->variant;
+
+	return variant->dwmac_enable_clks(plat);
+}
+
+static void mediatek_dwmac_exit(struct platform_device *pdev, void *priv)
+{
+	struct mediatek_dwmac_plat_data *plat = priv;
+	const struct mediatek_dwmac_variant *variant = plat->variant;
+
+	variant->dwmac_disable_clks(plat);
+}
+
+static int mediatek_dwmac_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct plat_stmmacenet_data *plat_dat;
+	struct stmmac_resources stmmac_res;
+	struct mediatek_dwmac_plat_data *priv_plat;
+
+	priv_plat = devm_kzalloc(&pdev->dev, sizeof(*priv_plat), GFP_KERNEL);
+	if (!priv_plat)
+		return -ENOMEM;
+
+	priv_plat->variant = of_device_get_match_data(&pdev->dev);
+	if (!priv_plat->variant) {
+		dev_err(&pdev->dev, "Missing dwmac-mediatek variant\n");
+		return -EINVAL;
+	}
+
+	priv_plat->dev = &pdev->dev;
+	priv_plat->np = pdev->dev.of_node;
+	priv_plat->phy_mode = of_get_phy_mode(priv_plat->np);
+
+	ret = mediatek_dwmac_config_dt(priv_plat);
+	if (ret)
+		return ret;
+
+	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
+	if (ret)
+		return ret;
+
+	plat_dat = stmmac_probe_config_dt(pdev, &stmmac_res.mac);
+	if (IS_ERR(plat_dat))
+		return PTR_ERR(plat_dat);
+
+	plat_dat->interface = priv_plat->phy_mode;
+	/* clk_csr_i = 250-300MHz & MDC = clk_csr_i/124 */
+	plat_dat->clk_csr = 5;
+	plat_dat->has_gmac4 = 1;
+	plat_dat->has_gmac = 0;
+	plat_dat->pmt = 0;
+	plat_dat->maxmtu = 1500;
+	plat_dat->bsp_priv = priv_plat;
+	plat_dat->init = mediatek_dwmac_init;
+	plat_dat->exit = mediatek_dwmac_exit;
+	mediatek_dwmac_init(pdev, priv_plat);
+
+	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
+	if (ret) {
+		stmmac_remove_config_dt(pdev, plat_dat);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id mediatek_dwmac_match[] = {
+	{ .compatible = "mediatek,mt2712-gmac",
+	  .data = &mt2712_gmac_variant },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, mediatek_dwmac_match);
+
+static struct platform_driver mediatek_dwmac_driver = {
+	.probe  = mediatek_dwmac_probe,
+	.remove = stmmac_pltfr_remove,
+	.driver = {
+		.name           = "dwmac-mediatek",
+		.pm		= &stmmac_pltfr_pm_ops,
+		.of_match_table = mediatek_dwmac_match,
+	},
+};
+module_platform_driver(mediatek_dwmac_driver);
-- 
1.7.9.5

