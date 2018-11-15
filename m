Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440DFC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C382145D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C382145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388461AbeKPAUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:20:53 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56489 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732953AbeKPAUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:20:52 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7] helo=dude.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gNIO0-00089x-8Y; Thu, 15 Nov 2018 15:12:48 +0100
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: [PATCH 2/2] phy: add driver for Freescale i.MX8MQ USB3 PHY
Date:   Thu, 15 Nov 2018 15:12:47 +0100
Message-Id: <20181115141247.15221-2-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115141247.15221-1-l.stach@pengutronix.de>
References: <20181115141247.15221-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Jun <jun.li@nxp.com>

This is a cleaned up port of the downstream i.MX8MQ USB3 PHY driver.

Signed-off-by: Li Jun <jun.li@nxp.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/phy/Kconfig                        |   1 +
 drivers/phy/Makefile                       |   1 +
 drivers/phy/freescale/Kconfig              |   5 +
 drivers/phy/freescale/Makefile             |   1 +
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 127 +++++++++++++++++++++
 5 files changed, 135 insertions(+)
 create mode 100644 drivers/phy/freescale/Kconfig
 create mode 100644 drivers/phy/freescale/Makefile
 create mode 100644 drivers/phy/freescale/phy-fsl-imx8mq-usb.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 60f949e2a684..eaf0778a18d4 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -44,6 +44,7 @@ source "drivers/phy/allwinner/Kconfig"
 source "drivers/phy/amlogic/Kconfig"
 source "drivers/phy/broadcom/Kconfig"
 source "drivers/phy/cadence/Kconfig"
+source "drivers/phy/freescale/Kconfig"
 source "drivers/phy/hisilicon/Kconfig"
 source "drivers/phy/lantiq/Kconfig"
 source "drivers/phy/marvell/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 0301e25d07c1..84acb3761457 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
 obj-y					+= broadcom/	\
 					   cadence/	\
+					   freescale/	\
 					   hisilicon/	\
 					   marvell/	\
 					   motorola/	\
diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfig
new file mode 100644
index 000000000000..ea1ac1651fbf
--- /dev/null
+++ b/drivers/phy/freescale/Kconfig
@@ -0,0 +1,5 @@
+config PHY_FSL_IMX8MQ_USB
+	tristate "Freescale i.MX8M USB3 PHY"
+	depends on OF
+	select GENERIC_PHY
+	default SOC_IMX8MQ
diff --git a/drivers/phy/freescale/Makefile b/drivers/phy/freescale/Makefile
new file mode 100644
index 000000000000..dc2b3f1f2f80
--- /dev/null
+++ b/drivers/phy/freescale/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_PHY_FSL_IMX8MQ_USB)	+= phy-fsl-imx8mq-usb.o
diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
new file mode 100644
index 000000000000..d6ea5ce8afa5
--- /dev/null
+++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2017 NXP. */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+
+#define PHY_CTRL0			0x0
+#define PHY_CTRL0_REF_SSP_EN		BIT(2)
+
+#define PHY_CTRL1			0x4
+#define PHY_CTRL1_RESET			BIT(0)
+#define PHY_CTRL1_COMMONONN		BIT(1)
+#define PHY_CTRL1_ATERESET		BIT(3)
+#define PHY_CTRL1_VDATSRCENB0		BIT(19)
+#define PHY_CTRL1_VDATDETENB0		BIT(20)
+
+#define PHY_CTRL2			0x8
+#define PHY_CTRL2_TXENABLEN0		BIT(8)
+
+struct imx8mq_usb_phy {
+	struct phy *phy;
+	struct clk *clk;
+	void __iomem *base;
+};
+
+static int imx8mq_usb_phy_init(struct phy *phy)
+{
+	struct imx8mq_usb_phy *imx_phy = phy_get_drvdata(phy);
+	u32 value;
+
+	value = readl(imx_phy->base + PHY_CTRL1);
+	value &= ~(PHY_CTRL1_VDATSRCENB0 | PHY_CTRL1_VDATDETENB0 |
+		   PHY_CTRL1_COMMONONN);
+	value |= PHY_CTRL1_RESET | PHY_CTRL1_ATERESET;
+	writel(value, imx_phy->base + PHY_CTRL1);
+
+	value = readl(imx_phy->base + PHY_CTRL0);
+	value |= PHY_CTRL0_REF_SSP_EN;
+	writel(value, imx_phy->base + PHY_CTRL0);
+
+	value = readl(imx_phy->base + PHY_CTRL2);
+	value |= PHY_CTRL2_TXENABLEN0;
+	writel(value, imx_phy->base + PHY_CTRL2);
+
+	value = readl(imx_phy->base + PHY_CTRL1);
+	value &= ~(PHY_CTRL1_RESET | PHY_CTRL1_ATERESET);
+	writel(value, imx_phy->base + PHY_CTRL1);
+
+	return 0;
+}
+
+static int imx8mq_phy_power_on(struct phy *phy)
+{
+	struct imx8mq_usb_phy *imx_phy = phy_get_drvdata(phy);
+
+	return clk_prepare_enable(imx_phy->clk);
+}
+
+static int imx8mq_phy_power_off(struct phy *phy)
+{
+	struct imx8mq_usb_phy *imx_phy = phy_get_drvdata(phy);
+
+	clk_disable_unprepare(imx_phy->clk);
+
+	return 0;
+}
+
+static struct phy_ops imx8mq_usb_phy_ops = {
+	.init		= imx8mq_usb_phy_init,
+	.power_on	= imx8mq_phy_power_on,
+	.power_off	= imx8mq_phy_power_off,
+	.owner		= THIS_MODULE,
+};
+
+static int imx8mq_usb_phy_probe(struct platform_device *pdev)
+{
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	struct imx8mq_usb_phy *imx_phy;
+	struct resource *res;
+
+	imx_phy = devm_kzalloc(dev, sizeof(*imx_phy), GFP_KERNEL);
+	if (!imx_phy)
+		return -ENOMEM;
+
+	imx_phy->clk = devm_clk_get(dev, "phy");
+	if (IS_ERR(imx_phy->clk)) {
+		dev_err(dev, "failed to get imx8mq usb phy clock\n");
+		return PTR_ERR(imx_phy->clk);
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	imx_phy->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(imx_phy->base))
+		return PTR_ERR(imx_phy->base);
+
+	imx_phy->phy = devm_phy_create(dev, NULL, &imx8mq_usb_phy_ops);
+	if (IS_ERR(imx_phy->phy))
+		return PTR_ERR(imx_phy->phy);
+
+	phy_set_drvdata(imx_phy->phy, imx_phy);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id imx8mq_usb_phy_of_match[] = {
+	{.compatible = "fsl,imx8mq-usb-phy",},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, imx8mq_usb_phy_of_match);
+
+static struct platform_driver imx8mq_usb_phy_driver = {
+	.probe	= imx8mq_usb_phy_probe,
+	.driver = {
+		.name	= "imx8mq-usb-phy",
+		.of_match_table	= imx8mq_usb_phy_of_match,
+	}
+};
+module_platform_driver(imx8mq_usb_phy_driver);
+
+MODULE_DESCRIPTION("FSL IMX8MQ USB PHY driver");
+MODULE_LICENSE("GPL");
-- 
2.19.1

