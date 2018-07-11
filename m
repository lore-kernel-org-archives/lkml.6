Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A62C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 04:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E39A208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 04:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E39A208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbeGKEdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 00:33:32 -0400
Received: from mx.socionext.com ([202.248.49.38]:16916 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbeGKEdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 00:33:31 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 11 Jul 2018 13:31:09 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 9D34B18023A;
        Wed, 11 Jul 2018 13:31:09 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 11 Jul 2018 13:31:09 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 1BF391A01BB;
        Wed, 11 Jul 2018 13:31:09 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 2/2] regulator: uniphier: add regulator driver for UniPhier SoC
Date:   Wed, 11 Jul 2018 13:30:52 +0900
Message-Id: <1531283452-9705-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531283452-9705-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1531283452-9705-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial commit to add support for regulators implemented in UniPhier SoCs.
This supports USB VBUS only.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/regulator/Kconfig              |   8 ++
 drivers/regulator/Makefile             |   1 +
 drivers/regulator/uniphier-regulator.c | 213 +++++++++++++++++++++++++++++++++
 3 files changed, 222 insertions(+)
 create mode 100644 drivers/regulator/uniphier-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 097f617..7f7ad0d 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -932,6 +932,14 @@ config REGULATOR_TWL4030
 	  This driver supports the voltage regulators provided by
 	  this family of companion chips.
 
+config REGULATOR_UNIPHIER
+	tristate "UniPhier regulator driver"
+	depends on ARCH_UNIPHIER || COMPILE_TEST
+	depends on OF && MFD_SYSCON
+	default ARCH_UNIPHIER
+	help
+	  Support for regulators implemented on Socionext UniPhier SoCs.
+
 config REGULATOR_VCTRL
 	tristate "Voltage controlled regulators"
 	depends on OF
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 590674f..c0dd281 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -116,6 +116,7 @@ obj-$(CONFIG_REGULATOR_TPS65912) += tps65912-regulator.o
 obj-$(CONFIG_REGULATOR_TPS80031) += tps80031-regulator.o
 obj-$(CONFIG_REGULATOR_TPS65132) += tps65132-regulator.o
 obj-$(CONFIG_REGULATOR_TWL4030) += twl-regulator.o twl6030-regulator.o
+obj-$(CONFIG_REGULATOR_UNIPHIER) += uniphier-regulator.o
 obj-$(CONFIG_REGULATOR_VCTRL) += vctrl-regulator.o
 obj-$(CONFIG_REGULATOR_VEXPRESS) += vexpress-regulator.o
 obj-$(CONFIG_REGULATOR_WM831X) += wm831x-dcdc.o
diff --git a/drivers/regulator/uniphier-regulator.c b/drivers/regulator/uniphier-regulator.c
new file mode 100644
index 0000000..abf22ac
--- /dev/null
+++ b/drivers/regulator/uniphier-regulator.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Regulator controller driver for UniPhier SoC
+// Copyright 2018 Socionext Inc.
+// Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/reset.h>
+
+#define MAX_CLKS	2
+#define MAX_RSTS	2
+
+struct uniphier_regulator_soc_data {
+	int nclks;
+	const char * const *clock_names;
+	int nrsts;
+	const char * const *reset_names;
+	const struct regulator_desc *desc;
+	const struct regmap_config *regconf;
+};
+
+struct uniphier_regulator_priv {
+	struct clk_bulk_data clk[MAX_CLKS];
+	struct reset_control *rst[MAX_RSTS];
+	const struct uniphier_regulator_soc_data *data;
+};
+
+static struct regulator_ops uniphier_regulator_ops = {
+	.enable     = regulator_enable_regmap,
+	.disable    = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+};
+
+static int uniphier_regulator_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct uniphier_regulator_priv *priv;
+	struct regulator_config config = { };
+	struct regulator_dev *rdev;
+	struct regmap *regmap;
+	struct resource *res;
+	void __iomem *base;
+	const char *name;
+	int i, ret, nr;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->data = of_device_get_match_data(dev);
+	if (WARN_ON(!priv->data))
+		return -EINVAL;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	for (i = 0; i < priv->data->nclks; i++)
+		priv->clk[i].id = priv->data->clock_names[i];
+	ret = devm_clk_bulk_get(dev, priv->data->nclks, priv->clk);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < priv->data->nrsts; i++) {
+		name = priv->data->reset_names[i];
+		priv->rst[i] = devm_reset_control_get_shared(dev, name);
+		if (IS_ERR(priv->rst[i]))
+			return PTR_ERR(priv->rst[i]);
+	}
+
+	ret = clk_bulk_prepare_enable(priv->data->nclks, priv->clk);
+	if (ret)
+		return ret;
+
+	for (nr = 0; nr < priv->data->nrsts; nr++) {
+		ret = reset_control_deassert(priv->rst[nr]);
+		if (ret)
+			goto out_rst_assert;
+	}
+
+	regmap = devm_regmap_init_mmio(dev, base, priv->data->regconf);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	config.dev = dev;
+	config.driver_data = priv;
+	config.of_node = dev->of_node;
+	config.regmap = regmap;
+	config.init_data = of_get_regulator_init_data(dev, dev->of_node,
+						      priv->data->desc);
+	rdev = devm_regulator_register(dev, priv->data->desc, &config);
+	if (IS_ERR(rdev)) {
+		ret = PTR_ERR(rdev);
+		goto out_rst_assert;
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+
+out_rst_assert:
+	while (nr--)
+		reset_control_assert(priv->rst[nr]);
+
+	clk_bulk_disable_unprepare(priv->data->nclks, priv->clk);
+
+	return ret;
+}
+
+static int uniphier_regulator_remove(struct platform_device *pdev)
+{
+	struct uniphier_regulator_priv *priv = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < priv->data->nrsts; i++)
+		reset_control_assert(priv->rst[i]);
+
+	clk_bulk_disable_unprepare(priv->data->nclks, priv->clk);
+
+	return 0;
+}
+
+/* USB3 controller data */
+#define USB3VBUS_OFFSET		0x0
+#define USB3VBUS_REG		BIT(4)
+#define USB3VBUS_REG_EN		BIT(3)
+static const struct regulator_desc uniphier_usb3_regulator_desc = {
+	.name = "vbus",
+	.of_match = of_match_ptr("vbus"),
+	.ops = &uniphier_regulator_ops,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+	.enable_reg  = USB3VBUS_OFFSET,
+	.enable_mask = USB3VBUS_REG_EN | USB3VBUS_REG,
+	.enable_val  = USB3VBUS_REG_EN | USB3VBUS_REG,
+	.disable_val = USB3VBUS_REG_EN,
+};
+
+static const struct regmap_config uniphier_usb3_regulator_regconf = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = 1,
+};
+
+static const char * const uniphier_pro4_clock_reset_names[] = {
+	"gio", "link",
+};
+
+static const struct uniphier_regulator_soc_data uniphier_pro4_usb3_data = {
+	.nclks = ARRAY_SIZE(uniphier_pro4_clock_reset_names),
+	.clock_names = uniphier_pro4_clock_reset_names,
+	.nrsts = ARRAY_SIZE(uniphier_pro4_clock_reset_names),
+	.reset_names = uniphier_pro4_clock_reset_names,
+	.desc = &uniphier_usb3_regulator_desc,
+	.regconf = &uniphier_usb3_regulator_regconf,
+};
+
+static const char * const uniphier_pxs2_clock_reset_names[] = {
+	"link",
+};
+
+static const struct uniphier_regulator_soc_data uniphier_pxs2_usb3_data = {
+	.nclks = ARRAY_SIZE(uniphier_pxs2_clock_reset_names),
+	.clock_names = uniphier_pxs2_clock_reset_names,
+	.nrsts = ARRAY_SIZE(uniphier_pxs2_clock_reset_names),
+	.reset_names = uniphier_pxs2_clock_reset_names,
+	.desc = &uniphier_usb3_regulator_desc,
+	.regconf = &uniphier_usb3_regulator_regconf,
+};
+
+static const struct of_device_id uniphier_regulator_match[] = {
+	/* USB VBUS */
+	{
+		.compatible = "socionext,uniphier-pro4-usb3-regulator",
+		.data = &uniphier_pro4_usb3_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pxs2-usb3-regulator",
+		.data = &uniphier_pxs2_usb3_data,
+	},
+	{
+		.compatible = "socionext,uniphier-ld20-usb3-regulator",
+		.data = &uniphier_pxs2_usb3_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pxs3-usb3-regulator",
+		.data = &uniphier_pxs2_usb3_data,
+	},
+	{ /* Sentinel */ },
+};
+
+static struct platform_driver uniphier_regulator_driver = {
+	.probe = uniphier_regulator_probe,
+	.remove = uniphier_regulator_remove,
+	.driver = {
+		.name  = "uniphier-regulator",
+		.of_match_table = uniphier_regulator_match,
+	},
+};
+module_platform_driver(uniphier_regulator_driver);
+
+MODULE_AUTHOR("Kunihiko Hayashi <hayashi.kunihiko@socionext.com>");
+MODULE_DESCRIPTION("UniPhier Regulator Controller Driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

