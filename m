Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000A7C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23CC20852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23CC20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=phrozen.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbeGYGvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 02:51:14 -0400
Received: from nbd.name ([46.4.11.11]:49888 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbeGYGvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 02:51:14 -0400
From:   John Crispin <john@phrozen.org>
To:     Alban Bedel <albeu@free.fr>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH 2/3] phy: qcom-ipq4019-usb: add driver for QCOM/IPQ4019
Date:   Wed, 25 Jul 2018 07:40:58 +0200
Message-Id: <20180725054059.19506-2-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180725054059.19506-1-john@phrozen.org>
References: <20180725054059.19506-1-john@phrozen.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver to setup the USB phy on Qualcom Dakota SoCs.
The driver sets up HS and SS phys. In case of HS some magic values need to
be written to magic offsets. These were taken from the SDK driver.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/phy/qualcomm/Kconfig                |   7 +
 drivers/phy/qualcomm/Makefile               |   1 +
 drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c | 193 ++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c

diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index 632a0e73ee10..41894904d708 100644
--- a/drivers/phy/qualcomm/Kconfig
+++ b/drivers/phy/qualcomm/Kconfig
@@ -17,6 +17,13 @@ config PHY_QCOM_APQ8064_SATA
 	depends on OF
 	select GENERIC_PHY
 
+config PHY_QCOM_IPQ4019_USB
+	tristate "Qualcomm IPQ4019 USB PHY module"
+	depends on OF && ARCH_QCOM
+	select GENERIC_PHY
+	help
+	  Support for the USB PHY on QCOM IPQ4019/Dakota chipsets.
+
 config PHY_QCOM_IPQ806X_SATA
 	tristate "Qualcomm IPQ806x SATA SerDes/PHY driver"
 	depends on ARCH_QCOM
diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
index deb831f453ae..463383483cd4 100644
--- a/drivers/phy/qualcomm/Makefile
+++ b/drivers/phy/qualcomm/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PHY_ATH79_USB)		+= phy-ath79-usb.o
 obj-$(CONFIG_PHY_QCOM_APQ8064_SATA)	+= phy-qcom-apq8064-sata.o
+obj-$(CONFIG_PHY_QCOM_IPQ4019_USB) 	+= phy-qcom-ipq4019-usb.o
 obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)	+= phy-qcom-ipq806x-sata.o
 obj-$(CONFIG_PHY_QCOM_QMP)		+= phy-qcom-qmp.o
 obj-$(CONFIG_PHY_QCOM_QUSB2)		+= phy-qcom-qusb2.o
diff --git a/drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c b/drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c
new file mode 100644
index 000000000000..89ab02161589
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 John Crispin <john@phrozen.org>
+ *
+ * Based on code from
+ * Allwinner Technology Co., Ltd. <www.allwinnertech.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_platform.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+/*
+ * Magic registers copied from the SDK driver code
+ */
+#define PHY_CTRL0_ADDR	0x000
+#define PHY_CTRL1_ADDR	0x004
+#define PHY_CTRL2_ADDR	0x008
+#define PHY_CTRL3_ADDR	0x00C
+#define PHY_CTRL4_ADDR	0x010
+#define PHY_MISC_ADDR	0x024
+#define PHY_IPG_ADDR	0x030
+
+#define PHY_CTRL0_VAL	0xA4600015
+#define PHY_CTRL1_VAL	0x09500000
+#define PHY_CTRL2_VAL	0x00058180
+#define PHY_CTRL3_VAL	0x6DB6DCD6
+#define PHY_CTRL4_VAL	0x836DB6DB
+#define PHY_MISC_VAL	0x3803FB0C
+#define PHY_IPG_VAL	0x47323232
+
+struct ipq4019_usb_phy {
+	struct device		*dev;
+	struct phy		*phy;
+	void __iomem		*base;
+	struct reset_control	*por_rst;
+	struct reset_control	*srif_rst;
+};
+
+static int ipq4019_ss_phy_power_off(struct phy *_phy)
+{
+	struct ipq4019_usb_phy *phy = phy_get_drvdata(_phy);
+
+	reset_control_assert(phy->por_rst);
+	msleep(20);
+
+	return 0;
+}
+
+static int ipq4019_ss_phy_power_on(struct phy *_phy)
+{
+	struct ipq4019_usb_phy *phy = phy_get_drvdata(_phy);
+
+	ipq4019_ss_phy_power_off(_phy);
+
+	reset_control_deassert(phy->por_rst);
+
+	return 0;
+}
+
+static struct phy_ops ipq4019_usb_ss_phy_ops = {
+	.power_on	= ipq4019_ss_phy_power_on,
+	.power_off	= ipq4019_ss_phy_power_off,
+};
+
+static int ipq4019_hs_phy_power_off(struct phy *_phy)
+{
+	struct ipq4019_usb_phy *phy = phy_get_drvdata(_phy);
+
+	reset_control_assert(phy->por_rst);
+	msleep(20);
+
+	reset_control_assert(phy->srif_rst);
+	msleep(20);
+
+	return 0;
+}
+
+static int ipq4019_hs_phy_power_on(struct phy *_phy)
+{
+	struct ipq4019_usb_phy *phy = phy_get_drvdata(_phy);
+
+	ipq4019_hs_phy_power_off(_phy);
+
+	reset_control_deassert(phy->srif_rst);
+	msleep(20);
+
+	writel(PHY_CTRL0_VAL, phy->base + PHY_CTRL0_ADDR);
+	writel(PHY_CTRL1_VAL, phy->base + PHY_CTRL1_ADDR);
+	writel(PHY_CTRL2_VAL, phy->base + PHY_CTRL2_ADDR);
+	writel(PHY_CTRL3_VAL, phy->base + PHY_CTRL3_ADDR);
+	writel(PHY_CTRL4_VAL, phy->base + PHY_CTRL4_ADDR);
+	writel(PHY_MISC_VAL, phy->base + PHY_MISC_ADDR);
+	writel(PHY_IPG_VAL, phy->base + PHY_IPG_ADDR);
+	msleep(20);
+
+	reset_control_deassert(phy->por_rst);
+
+	return 0;
+}
+
+static struct phy_ops ipq4019_usb_hs_phy_ops = {
+	.power_on	= ipq4019_hs_phy_power_on,
+	.power_off	= ipq4019_hs_phy_power_off,
+};
+
+static const struct of_device_id ipq4019_usb_phy_of_match[] = {
+	{
+		.compatible = "qcom,usb-hs-ipq4019-phy",
+		.data = &ipq4019_usb_hs_phy_ops
+	}, {
+		.compatible = "qcom,usb-ss-ipq4019-phy",
+		.data = &ipq4019_usb_ss_phy_ops
+	}, {
+	},
+};
+MODULE_DEVICE_TABLE(of, ipq4019_usb_phy_of_match);
+
+static int ipq4019_usb_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct phy_provider *phy_provider;
+	struct ipq4019_usb_phy *phy;
+	const struct of_device_id *match;
+
+	match = of_match_device(ipq4019_usb_phy_of_match, &pdev->dev);
+	if (!match)
+		return -ENODEV;
+
+	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	phy->dev = &pdev->dev;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	phy->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(phy->base)) {
+		dev_err(dev, "failed to remap register memory\n");
+		return PTR_ERR(phy->base);
+	}
+
+	phy->por_rst = devm_reset_control_get(phy->dev, "por_rst");
+	if (IS_ERR(phy->por_rst)) {
+		if (PTR_ERR(phy->por_rst) != -EPROBE_DEFER)
+			dev_err(dev, "POR reset is missing\n");
+		return PTR_ERR(phy->por_rst);
+	}
+
+	phy->srif_rst = devm_reset_control_get_optional(phy->dev, "srif_rst");
+	if (IS_ERR(phy->srif_rst))
+		return PTR_ERR(phy->srif_rst);
+
+	phy->phy = devm_phy_create(dev, NULL, match->data);
+	if (IS_ERR(phy->phy)) {
+		dev_err(dev, "failed to create PHY\n");
+		return PTR_ERR(phy->phy);
+	}
+	phy_set_drvdata(phy->phy, phy);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static struct platform_driver ipq4019_usb_phy_driver = {
+	.probe	= ipq4019_usb_phy_probe,
+	.driver = {
+		.of_match_table	= ipq4019_usb_phy_of_match,
+		.name  = "ipq4019-usb-phy",
+	}
+};
+module_platform_driver(ipq4019_usb_phy_driver);
+
+MODULE_DESCRIPTION("QCOM/IPQ4019 USB phy driver");
+MODULE_AUTHOR("John Crispin <john@phrozen.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

