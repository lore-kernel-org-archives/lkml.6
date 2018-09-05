Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED4CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5D1205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5D1205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbeIEOTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:19:21 -0400
Received: from mx.socionext.com ([202.248.49.38]:54948 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbeIEOTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:19:20 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 05 Sep 2018 18:49:53 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 9CDBB600AA;
        Wed,  5 Sep 2018 18:49:53 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 5 Sep 2018 18:49:53 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id E24AD1A03A2;
        Wed,  5 Sep 2018 18:49:52 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 2/2] phy: socionext: add PCIe PHY driver support
Date:   Wed,  5 Sep 2018 18:49:45 +0900
Message-Id: <1536140985-6058-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536140985-6058-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1536140985-6058-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for PHY interface built into PCIe controller implemented
in UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/phy/Kconfig                       |   1 +
 drivers/phy/Makefile                      |   1 +
 drivers/phy/socionext/Kconfig             |  12 ++
 drivers/phy/socionext/Makefile            |   6 +
 drivers/phy/socionext/phy-uniphier-pcie.c | 240 ++++++++++++++++++++++++++++++
 5 files changed, 260 insertions(+)
 create mode 100644 drivers/phy/socionext/Kconfig
 create mode 100644 drivers/phy/socionext/Makefile
 create mode 100644 drivers/phy/socionext/phy-uniphier-pcie.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 5c8d452..b752589 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -53,6 +53,7 @@ source "drivers/phy/ralink/Kconfig"
 source "drivers/phy/renesas/Kconfig"
 source "drivers/phy/rockchip/Kconfig"
 source "drivers/phy/samsung/Kconfig"
+source "drivers/phy/socionext/Kconfig"
 source "drivers/phy/st/Kconfig"
 source "drivers/phy/tegra/Kconfig"
 source "drivers/phy/ti/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 84e3bd9..5539cde 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -21,5 +21,6 @@ obj-y					+= broadcom/	\
 					   qualcomm/	\
 					   ralink/	\
 					   samsung/	\
+					   socionext/	\
 					   st/		\
 					   ti/
diff --git a/drivers/phy/socionext/Kconfig b/drivers/phy/socionext/Kconfig
new file mode 100644
index 0000000..20a1195
--- /dev/null
+++ b/drivers/phy/socionext/Kconfig
@@ -0,0 +1,12 @@
+#
+# PHY drivers for Socionext platforms.
+#
+
+config PHY_UNIPHIER_PCIE
+	tristate "Uniphier PHY driver for PCIe controller"
+	depends on (ARCH_UNIPHIER || COMPILE_TEST) && OF
+	default PCIE_UNIPHIER
+	select GENERIC_PHY
+	help
+	  Enable this to support PHY implemented in PCIe controller
+	  on UniPhier SoCs. This driver supports LD20 and PXs3 SoCs.
diff --git a/drivers/phy/socionext/Makefile b/drivers/phy/socionext/Makefile
new file mode 100644
index 0000000..5484360
--- /dev/null
+++ b/drivers/phy/socionext/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the phy drivers.
+#
+
+obj-$(CONFIG_PHY_UNIPHIER_PCIE)	+= phy-uniphier-pcie.o
diff --git a/drivers/phy/socionext/phy-uniphier-pcie.c b/drivers/phy/socionext/phy-uniphier-pcie.c
new file mode 100644
index 0000000..93ffbd2
--- /dev/null
+++ b/drivers/phy/socionext/phy-uniphier-pcie.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * phy-uniphier-pcie.c - PHY driver for UniPhier PCIe controller
+ * Copyright 2018, Socionext Inc.
+ * Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/iopoll.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/resource.h>
+
+/* PHY */
+#define PCL_PHY_TEST_I		0x2000
+#define PCL_PHY_TEST_O		0x2004
+#define TESTI_DAT_MASK		GENMASK(13, 6)
+#define TESTI_ADR_MASK		GENMASK(5, 1)
+#define TESTI_WR_EN		BIT(0)
+
+#define PCL_PHY_RESET		0x200c
+#define PCL_PHY_RESET_N_MNMODE	BIT(8)	/* =1:manual */
+#define PCL_PHY_RESET_N		BIT(0)	/* =1:deasssert */
+
+/* SG */
+#define SG_USBPCIESEL		0x590
+#define SG_USBPCIESEL_PCIE	BIT(0)
+
+#define PCL_PHY_R00		0
+#define   RX_EQ_ADJ_EN		BIT(3)		/* enable for EQ adjustment */
+#define PCL_PHY_R06		6
+#define   RX_EQ_ADJ		GENMASK(5, 0)	/* EQ adjustment value */
+#define   RX_EQ_ADJ_VAL		0
+#define PCL_PHY_R26		26
+#define   VCO_CTRL		GENMASK(7, 4)	/* Tx VCO adjustment value */
+#define   VCO_CTRL_INIT_VAL	5
+
+struct uniphier_pciephy_priv {
+	void __iomem *base;
+	struct device *dev;
+	struct clk *clk;
+	struct reset_control *rst;
+	const struct uniphier_pciephy_soc_data *data;
+};
+
+struct uniphier_pciephy_soc_data {
+	bool has_syscon;
+};
+
+static void uniphier_pciephy_testio_write(struct uniphier_pciephy_priv *priv,
+					  u32 data)
+{
+	/* need to read TESTO twice after accessing TESTI */
+	writel(data, priv->base + PCL_PHY_TEST_I);
+	readl(priv->base + PCL_PHY_TEST_O);
+	readl(priv->base + PCL_PHY_TEST_O);
+}
+
+static void uniphier_pciephy_set_param(struct uniphier_pciephy_priv *priv,
+				       u32 reg, u32 mask, u32 param)
+{
+	u32 val;
+
+	/* read previous data */
+	val  = FIELD_PREP(TESTI_DAT_MASK, 1);
+	val |= FIELD_PREP(TESTI_ADR_MASK, reg);
+	uniphier_pciephy_testio_write(priv, val);
+	val = readl(priv->base + PCL_PHY_TEST_O);
+
+	/* update value */
+	val &= ~FIELD_PREP(TESTI_DAT_MASK, mask);
+	val  = FIELD_PREP(TESTI_DAT_MASK, mask & param);
+	val |= FIELD_PREP(TESTI_ADR_MASK, reg);
+	uniphier_pciephy_testio_write(priv, val);
+	uniphier_pciephy_testio_write(priv, val | TESTI_WR_EN);
+	uniphier_pciephy_testio_write(priv, val);
+
+	/* read current data as dummy */
+	val  = FIELD_PREP(TESTI_DAT_MASK, 1);
+	val |= FIELD_PREP(TESTI_ADR_MASK, reg);
+	uniphier_pciephy_testio_write(priv, val);
+	readl(priv->base + PCL_PHY_TEST_O);
+}
+
+static void uniphier_pciephy_assert(struct uniphier_pciephy_priv *priv)
+{
+	u32 val;
+
+	val = readl(priv->base + PCL_PHY_RESET);
+	val &= ~PCL_PHY_RESET_N;
+	val |= PCL_PHY_RESET_N_MNMODE;
+	writel(val, priv->base + PCL_PHY_RESET);
+}
+
+static void uniphier_pciephy_deassert(struct uniphier_pciephy_priv *priv)
+{
+	u32 val;
+
+	val = readl(priv->base + PCL_PHY_RESET);
+	val |= PCL_PHY_RESET_N_MNMODE | PCL_PHY_RESET_N;
+	writel(val, priv->base + PCL_PHY_RESET);
+}
+
+static int uniphier_pciephy_init(struct phy *phy)
+{
+	struct uniphier_pciephy_priv *priv = phy_get_drvdata(phy);
+	int ret;
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	ret = reset_control_deassert(priv->rst);
+	if (ret)
+		goto out_clk_disable;
+
+	uniphier_pciephy_set_param(priv, PCL_PHY_R00,
+				   RX_EQ_ADJ_EN, RX_EQ_ADJ_EN);
+	uniphier_pciephy_set_param(priv, PCL_PHY_R06, RX_EQ_ADJ,
+				   FIELD_PREP(RX_EQ_ADJ, RX_EQ_ADJ_VAL));
+	uniphier_pciephy_set_param(priv, PCL_PHY_R26, VCO_CTRL,
+				   FIELD_PREP(VCO_CTRL, VCO_CTRL_INIT_VAL));
+	usleep_range(1, 10);
+
+	uniphier_pciephy_deassert(priv);
+	usleep_range(1, 10);
+
+	return 0;
+
+out_clk_disable:
+	clk_disable_unprepare(priv->clk);
+
+	return ret;
+}
+
+static int uniphier_pciephy_exit(struct phy *phy)
+{
+	struct uniphier_pciephy_priv *priv = phy_get_drvdata(phy);
+
+	uniphier_pciephy_assert(priv);
+	reset_control_assert(priv->rst);
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static const struct phy_ops uniphier_pciephy_ops = {
+	.init  = uniphier_pciephy_init,
+	.exit  = uniphier_pciephy_exit,
+	.owner = THIS_MODULE,
+};
+
+static int uniphier_pciephy_probe(struct platform_device *pdev)
+{
+	struct uniphier_pciephy_priv *priv;
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
+	struct resource *res;
+	struct phy *phy;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->data = of_device_get_match_data(dev);
+	if (WARN_ON(!priv->data))
+		return -EINVAL;
+
+	priv->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	priv->rst = devm_reset_control_get_shared(dev, NULL);
+	if (IS_ERR(priv->rst))
+		return PTR_ERR(priv->rst);
+
+	phy = devm_phy_create(dev, dev->of_node, &uniphier_pciephy_ops);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	regmap = syscon_regmap_lookup_by_phandle(dev->of_node,
+						 "socionext,syscon");
+	if (!IS_ERR(regmap) && priv->data->has_syscon)
+		regmap_update_bits(regmap, SG_USBPCIESEL,
+				   SG_USBPCIESEL_PCIE, SG_USBPCIESEL_PCIE);
+
+	phy_set_drvdata(phy, priv);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct uniphier_pciephy_soc_data uniphier_ld20_data = {
+	.has_syscon = true,
+};
+
+static const struct uniphier_pciephy_soc_data uniphier_pxs3_data = {
+	.has_syscon = false,
+};
+
+static const struct of_device_id uniphier_pciephy_match[] = {
+	{
+		.compatible = "socionext,uniphier-ld20-pcie-phy",
+		.data = &uniphier_ld20_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pxs3-pcie-phy",
+		.data = &uniphier_pxs3_data,
+	},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, uniphier_pciephy_match);
+
+static struct platform_driver uniphier_pciephy_driver = {
+	.probe = uniphier_pciephy_probe,
+	.driver = {
+		.name = "uniphier-pcie-phy",
+		.of_match_table = uniphier_pciephy_match,
+	},
+};
+module_platform_driver(uniphier_pciephy_driver);
+
+MODULE_AUTHOR("Kunihiko Hayashi <hayashi.kunihiko@socionext.com>");
+MODULE_DESCRIPTION("UniPhier PHY driver for PCIe controller");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

