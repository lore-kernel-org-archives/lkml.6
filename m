Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AEAC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E91521473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E91521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeJDTYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:24:45 -0400
Received: from hermes.aosc.io ([199.195.250.187]:44080 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbeJDTYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:24:44 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 7410B65E0A;
        Thu,  4 Oct 2018 12:31:34 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v4 08/10] phy: allwinner: add phy driver for USB3 PHY on Allwinner H6 SoC
Date:   Thu,  4 Oct 2018 20:28:53 +0800
Message-Id: <20181004122855.22981-9-icenowy@aosc.io>
In-Reply-To: <20181004122855.22981-1-icenowy@aosc.io>
References: <20181004122855.22981-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 SoC contains a USB3 PHY (with USB2 DP/DM lines also
controlled).

Add a driver for it.

The register operations in this driver is mainly extracted from the BSP
USB3 driver.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
Changes in v4:
- Added support for vbus-supply property.

Changes in v3:
- Dropped USB_SUPPORT dependency.
- Added Chen-Yu's Review tag.

No changes in v2, v1.

 drivers/phy/allwinner/Kconfig           |  12 ++
 drivers/phy/allwinner/Makefile          |   1 +
 drivers/phy/allwinner/phy-sun50i-usb3.c | 239 ++++++++++++++++++++++++
 3 files changed, 252 insertions(+)
 create mode 100644 drivers/phy/allwinner/phy-sun50i-usb3.c

diff --git a/drivers/phy/allwinner/Kconfig b/drivers/phy/allwinner/Kconfig
index cdc1e745ba47..064096e6a4e5 100644
--- a/drivers/phy/allwinner/Kconfig
+++ b/drivers/phy/allwinner/Kconfig
@@ -29,3 +29,15 @@ config PHY_SUN9I_USB
 	  sun9i SoCs.
 
 	  This driver controls each individual USB 2 host PHY.
+
+config PHY_SUN50I_USB3
+	tristate "Allwinner sun50i SoC USB3 PHY driver"
+	depends on ARCH_SUNXI && HAS_IOMEM && OF
+	depends on RESET_CONTROLLER
+	select USB_COMMON
+	select GENERIC_PHY
+	help
+	  Enable this to support the USB3.0-capable transceiver that is
+	  part of some Allwinner sun50i SoCs.
+
+	  This driver controls each individual USB 2+3 host PHY combo.
diff --git a/drivers/phy/allwinner/Makefile b/drivers/phy/allwinner/Makefile
index 8605529c01a1..a8d01e9073c2 100644
--- a/drivers/phy/allwinner/Makefile
+++ b/drivers/phy/allwinner/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
 obj-$(CONFIG_PHY_SUN9I_USB)		+= phy-sun9i-usb.o
+obj-$(CONFIG_PHY_SUN50I_USB3)		+= phy-sun50i-usb3.o
diff --git a/drivers/phy/allwinner/phy-sun50i-usb3.c b/drivers/phy/allwinner/phy-sun50i-usb3.c
new file mode 100644
index 000000000000..70c299c01c3e
--- /dev/null
+++ b/drivers/phy/allwinner/phy-sun50i-usb3.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Allwinner sun50i(H6) USB 3.0 phy driver
+ *
+ * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
+ *
+ * Based on phy-sun9i-usb.c, which is:
+ *
+ * Copyright (C) 2014-2015 Chen-Yu Tsai <wens@csie.org>
+ *
+ * Based on code from Allwinner BSP, which is:
+ *
+ * Copyright (c) 2010-2015 Allwinner Technology Co., Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/usb/of.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+
+/* Interface Status and Control Registers */
+#define SUNXI_ISCR			0x00
+#define SUNXI_PIPE_CLOCK_CONTROL	0x14
+#define SUNXI_PHY_TUNE_LOW		0x18
+#define SUNXI_PHY_TUNE_HIGH		0x1c
+#define SUNXI_PHY_EXTERNAL_CONTROL	0x20
+
+/* USB2.0 Interface Status and Control Register */
+#define SUNXI_ISCR_FORCE_VBUS		(3 << 12)
+
+/* PIPE Clock Control Register */
+#define SUNXI_PCC_PIPE_CLK_OPEN		(1 << 6)
+
+/* PHY External Control Register */
+#define SUNXI_PEC_EXTERN_VBUS		(3 << 1)
+#define SUNXI_PEC_SSC_EN		(1 << 24)
+#define SUNXI_PEC_REF_SSP_EN		(1 << 26)
+
+/* PHY Tune High Register */
+#define SUNXI_TX_DEEMPH_3P5DB(n)	((n) << 19)
+#define SUNXI_TX_DEEMPH_3P5DB_MASK	GENMASK(24, 19)
+#define SUNXI_TX_DEEMPH_6DB(n)		((n) << 13)
+#define SUNXI_TX_DEEMPH_6GB_MASK	GENMASK(18, 13)
+#define SUNXI_TX_SWING_FULL(n)		((n) << 6)
+#define SUNXI_TX_SWING_FULL_MASK	GENMASK(12, 6)
+#define SUNXI_LOS_BIAS(n)		((n) << 3)
+#define SUNXI_LOS_BIAS_MASK		GENMASK(5, 3)
+#define SUNXI_TXVBOOSTLVL(n)		((n) << 0)
+#define SUNXI_TXVBOOSTLVL_MASK		GENMASK(0, 2)
+
+struct sun50i_usb3_phy {
+	struct phy *phy;
+	void __iomem *regs;
+	struct reset_control *reset;
+	struct clk *clk;
+	bool regulator_on;
+	struct regulator *vbus;
+};
+
+static void sun50i_usb3_phy_open(struct sun50i_usb3_phy *phy)
+{
+	u32 val;
+
+	val = readl(phy->regs + SUNXI_PHY_EXTERNAL_CONTROL);
+	val |= SUNXI_PEC_EXTERN_VBUS;
+	val |= SUNXI_PEC_SSC_EN | SUNXI_PEC_REF_SSP_EN;
+	writel(val, phy->regs + SUNXI_PHY_EXTERNAL_CONTROL);
+
+	val = readl(phy->regs + SUNXI_PIPE_CLOCK_CONTROL);
+	val |= SUNXI_PCC_PIPE_CLK_OPEN;
+	writel(val, phy->regs + SUNXI_PIPE_CLOCK_CONTROL);
+
+	val = readl(phy->regs + SUNXI_ISCR);
+	val |= SUNXI_ISCR_FORCE_VBUS;
+	writel(val, phy->regs + SUNXI_ISCR);
+
+	/*
+	 * All the magic numbers written to the PHY_TUNE_{LOW_HIGH}
+	 * registers are directly taken from the BSP USB3 driver from
+	 * Allwiner.
+	 */
+	writel(0x0047fc87, phy->regs + SUNXI_PHY_TUNE_LOW);
+
+	val = readl(phy->regs + SUNXI_PHY_TUNE_HIGH);
+	val &= ~(SUNXI_TXVBOOSTLVL_MASK | SUNXI_LOS_BIAS_MASK |
+		 SUNXI_TX_SWING_FULL_MASK | SUNXI_TX_DEEMPH_6GB_MASK |
+		 SUNXI_TX_DEEMPH_3P5DB_MASK);
+	val |= SUNXI_TXVBOOSTLVL(0x7);
+	val |= SUNXI_LOS_BIAS(0x7);
+	val |= SUNXI_TX_SWING_FULL(0x55);
+	val |= SUNXI_TX_DEEMPH_6DB(0x20);
+	val |= SUNXI_TX_DEEMPH_3P5DB(0x15);
+	writel(val, phy->regs + SUNXI_PHY_TUNE_HIGH);
+}
+
+static int sun50i_usb3_phy_init(struct phy *_phy)
+{
+	struct sun50i_usb3_phy *phy = phy_get_drvdata(_phy);
+	int ret;
+
+	ret = clk_prepare_enable(phy->clk);
+	if (ret)
+		goto err_clk;
+
+	ret = reset_control_deassert(phy->reset);
+	if (ret)
+		goto err_reset;
+
+	sun50i_usb3_phy_open(phy);
+	return 0;
+
+err_reset:
+	clk_disable_unprepare(phy->clk);
+
+err_clk:
+	return ret;
+}
+
+static int sun50i_usb3_phy_exit(struct phy *_phy)
+{
+	struct sun50i_usb3_phy *phy = phy_get_drvdata(_phy);
+
+	reset_control_assert(phy->reset);
+	clk_disable_unprepare(phy->clk);
+
+	return 0;
+}
+
+static int sun50i_usb3_phy_power_on(struct phy *_phy)
+{
+	struct sun50i_usb3_phy *phy = phy_get_drvdata(_phy);
+	int ret;
+
+	if (!phy->vbus || phy->regulator_on)
+		return 0;
+
+	ret = regulator_enable(phy->vbus);
+	if (ret)
+		return ret;
+
+	phy->regulator_on = true;
+
+	return 0;
+}
+
+static int sun50i_usb3_phy_power_off(struct phy *_phy)
+{
+	struct sun50i_usb3_phy *phy = phy_get_drvdata(_phy);
+
+	if (!phy->vbus || !phy->regulator_on)
+		return 0;
+
+	regulator_disable(phy->vbus);
+	phy->regulator_on = false;
+
+	return 0;
+}
+
+static const struct phy_ops sun50i_usb3_phy_ops = {
+	.init		= sun50i_usb3_phy_init,
+	.exit		= sun50i_usb3_phy_exit,
+	.power_on	= sun50i_usb3_phy_power_on,
+	.power_off	= sun50i_usb3_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static int sun50i_usb3_phy_probe(struct platform_device *pdev)
+{
+	struct sun50i_usb3_phy *phy;
+	struct device *dev = &pdev->dev;
+	struct phy_provider *phy_provider;
+	struct resource *res;
+
+	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	phy->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(phy->clk)) {
+		dev_err(dev, "failed to get phy clock\n");
+		return PTR_ERR(phy->clk);
+	}
+
+	phy->reset = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(phy->reset)) {
+		dev_err(dev, "failed to get reset control\n");
+		return PTR_ERR(phy->reset);
+	}
+
+	phy->vbus = devm_regulator_get_optional(dev, "vbus");
+	if (IS_ERR(phy->vbus)) {
+		if (PTR_ERR(phy->vbus) == -EPROBE_DEFER) {
+			dev_err(dev, "Couldn't get vbus regulator... Deferring probe\n");
+			return -EPROBE_DEFER;
+		}
+
+		phy->vbus = NULL;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	phy->regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(phy->regs))
+		return PTR_ERR(phy->regs);
+
+	phy->phy = devm_phy_create(dev, NULL, &sun50i_usb3_phy_ops);
+	if (IS_ERR(phy->phy)) {
+		dev_err(dev, "failed to create PHY\n");
+		return PTR_ERR(phy->phy);
+	}
+
+	phy_set_drvdata(phy->phy, phy);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id sun50i_usb3_phy_of_match[] = {
+	{ .compatible = "allwinner,sun50i-h6-usb3-phy" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sun50i_usb3_phy_of_match);
+
+static struct platform_driver sun50i_usb3_phy_driver = {
+	.probe	= sun50i_usb3_phy_probe,
+	.driver = {
+		.of_match_table	= sun50i_usb3_phy_of_match,
+		.name  = "sun50i-usb3-phy",
+	}
+};
+module_platform_driver(sun50i_usb3_phy_driver);
+
+MODULE_DESCRIPTION("Allwinner sun50i USB 3.0 phy driver");
+MODULE_AUTHOR("Icenowy Zheng <icenowy@aosc.io>");
+MODULE_LICENSE("GPL");
-- 
2.18.0

