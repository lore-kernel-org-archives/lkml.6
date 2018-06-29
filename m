Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF1CC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EF127C0F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EF127C0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965823AbeF2IlD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:41:03 -0400
Received: from mx.socionext.com ([202.248.49.38]:43016 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965322AbeF2IjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:39:04 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 29 Jun 2018 17:39:02 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 74BB61800FC;
        Fri, 29 Jun 2018 17:39:02 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 29 Jun 2018 17:39:02 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id C20DC1A120B;
        Fri, 29 Jun 2018 17:39:01 +0900 (JST)
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
Subject: [PATCH 2/4] phy: socionext: add USB3 PHY driver for UniPhier SoC
Date:   Fri, 29 Jun 2018 17:38:59 +0900
Message-Id: <1530261541-23104-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530261541-23104-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1530261541-23104-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for PHY interface built into USB3 controller
implemented in UniPhier SoCs.
This driver supports High-Speed PHY and Super-Speed PHY.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Motoya Tanigawa <tanigawa.motoya@socionext.com>
Signed-off-by: Masami Hiramatsu <masami.hiramatsu@linaro.org>
---
 drivers/phy/Kconfig                         |   1 +
 drivers/phy/Makefile                        |   1 +
 drivers/phy/socionext/Kconfig               |  12 +
 drivers/phy/socionext/Makefile              |   6 +
 drivers/phy/socionext/phy-uniphier-usb3hs.c | 422 ++++++++++++++++++++++++++++
 drivers/phy/socionext/phy-uniphier-usb3ss.c | 369 ++++++++++++++++++++++++
 6 files changed, 811 insertions(+)
 create mode 100644 drivers/phy/socionext/Kconfig
 create mode 100644 drivers/phy/socionext/Makefile
 create mode 100644 drivers/phy/socionext/phy-uniphier-usb3hs.c
 create mode 100644 drivers/phy/socionext/phy-uniphier-usb3ss.c

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
index 0000000..4a172fc
--- /dev/null
+++ b/drivers/phy/socionext/Kconfig
@@ -0,0 +1,12 @@
+#
+# PHY drivers for Socionext platforms.
+#
+
+config PHY_UNIPHIER_USB3
+	tristate "UniPhier USB3 PHY driver"
+	depends on ARCH_UNIPHIER || COMPILE_TEST
+	depends on OF && HAS_IOMEM
+	select GENERIC_PHY
+	help
+	  Enable this to support USB PHY implemented in USB3 controller
+	  on UniPhier SoCs. This controller supports USB3.0 and lower speed.
diff --git a/drivers/phy/socionext/Makefile b/drivers/phy/socionext/Makefile
new file mode 100644
index 0000000..dfa5cec
--- /dev/null
+++ b/drivers/phy/socionext/Makefile
@@ -0,0 +1,6 @@
+# SPDX-identifier: GPL-2.0
+#
+# Makefile for the phy drivers.
+#
+
+obj-$(CONFIG_PHY_UNIPHIER_USB3)	+= phy-uniphier-usb3hs.o phy-uniphier-usb3ss.o
diff --git a/drivers/phy/socionext/phy-uniphier-usb3hs.c b/drivers/phy/socionext/phy-uniphier-usb3hs.c
new file mode 100644
index 0000000..cea8983
--- /dev/null
+++ b/drivers/phy/socionext/phy-uniphier-usb3hs.c
@@ -0,0 +1,422 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * phy-uniphier-usb3hs.c - HS-PHY driver for Socionext UniPhier USB3 controller
+ * Copyright 2015-2018 Socionext Inc.
+ * Author:
+ *	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+ * Contributors:
+ *      Motoya Tanigawa <tanigawa.motoya@socionext.com>
+ *      Masami Hiramatsu <masami.hiramatsu@linaro.org>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+
+#define HSPHY_CFG0		0x0
+#define HSPHY_CFG0_HS_I_MASK	GENMASK(31, 28)
+#define HSPHY_CFG0_HSDISC_MASK	GENMASK(27, 26)
+#define HSPHY_CFG0_SWING_MASK	GENMASK(17, 16)
+#define HSPHY_CFG0_SEL_T_MASK	GENMASK(15, 12)
+#define HSPHY_CFG0_RTERM_MASK	GENMASK(7, 6)
+#define HSPHY_CFG0_TRIMMASK	(HSPHY_CFG0_HS_I_MASK \
+				 | HSPHY_CFG0_SEL_T_MASK \
+				 | HSPHY_CFG0_RTERM_MASK)
+
+#define HSPHY_CFG1		0x4
+#define HSPHY_CFG1_DAT_EN	BIT(29)
+#define HSPHY_CFG1_ADR_EN	BIT(28)
+#define HSPHY_CFG1_ADR_MASK	GENMASK(27, 16)
+#define HSPHY_CFG1_DAT_MASK	GENMASK(23, 16)
+
+#define MAX_CLKS	3
+#define MAX_RSTS	2
+#define MAX_PHY_PARAMS	1
+
+struct uniphier_u3hsphy_param {
+	u32 addr;
+	u32 mask;
+	u32 val;
+};
+
+struct uniphier_u3hsphy_trim_param {
+	unsigned int rterm;
+	unsigned int sel_t;
+	unsigned int hs_i;
+};
+
+#define trim_param_is_valid(p)	((p)->rterm || (p)->sel_t || (p)->hs_i)
+
+struct uniphier_u3hsphy_priv {
+	struct device *dev;
+	void __iomem *base;
+	int nclks;
+	struct clk *clk[MAX_CLKS], *clk_phy, *clk_phy_ext;
+	int nrsts;
+	struct reset_control *rst[MAX_RSTS], *rst_phy;
+	const struct uniphier_u3hsphy_soc_data *data;
+};
+
+struct uniphier_u3hsphy_soc_data {
+	const char *clock_names[MAX_CLKS];
+	const char *reset_names[MAX_RSTS];
+	int nparams;
+	const struct uniphier_u3hsphy_param param[MAX_PHY_PARAMS];
+	u32 config0;
+	u32 config1;
+	void (*trim_func)(struct uniphier_u3hsphy_priv *priv, u32 *pconfig,
+			  struct uniphier_u3hsphy_trim_param *pt);
+};
+
+static void uniphier_u3hsphy_trim_ld20(struct uniphier_u3hsphy_priv *priv,
+				       u32 *pconfig,
+				       struct uniphier_u3hsphy_trim_param *pt)
+{
+	*pconfig &= ~HSPHY_CFG0_RTERM_MASK;
+	*pconfig |= FIELD_PREP(HSPHY_CFG0_RTERM_MASK, pt->rterm);
+
+	*pconfig &= ~HSPHY_CFG0_SEL_T_MASK;
+	*pconfig |= FIELD_PREP(HSPHY_CFG0_SEL_T_MASK, pt->sel_t);
+
+	*pconfig &= ~HSPHY_CFG0_HS_I_MASK;
+	*pconfig |= FIELD_PREP(HSPHY_CFG0_HS_I_MASK,  pt->hs_i);
+}
+
+static int uniphier_u3hsphy_get_nvparam(struct uniphier_u3hsphy_priv *priv,
+					const char *name, unsigned int *val)
+{
+	struct nvmem_cell *cell;
+	u8 *buf;
+
+	cell = devm_nvmem_cell_get(priv->dev, name);
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	buf = nvmem_cell_read(cell, NULL);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	*val = *buf;
+
+	kfree(buf);
+
+	return 0;
+}
+
+static int uniphier_u3hsphy_get_nvparams(struct uniphier_u3hsphy_priv *priv,
+					 struct uniphier_u3hsphy_trim_param *pt)
+{
+	int ret;
+
+	ret = uniphier_u3hsphy_get_nvparam(priv, "rterm", &pt->rterm);
+	if (ret)
+		return ret;
+
+	ret = uniphier_u3hsphy_get_nvparam(priv, "sel_t", &pt->sel_t);
+	if (ret)
+		return ret;
+
+	ret = uniphier_u3hsphy_get_nvparam(priv, "hs_i", &pt->hs_i);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int uniphier_u3hsphy_update_config(struct uniphier_u3hsphy_priv *priv,
+					  u32 *pconfig)
+{
+	struct uniphier_u3hsphy_trim_param trim;
+	int ret, trimmed = 0;
+
+	if (priv->data->trim_func) {
+		ret = uniphier_u3hsphy_get_nvparams(priv, &trim);
+		if (ret == -EPROBE_DEFER)
+			return ret;
+
+		/*
+		 * call trim_func only when trimming parameters that aren't
+		 * all-zero can be acquired. All-zero parameters mean nothing
+		 * has been written to nvmem.
+		 */
+		if (!ret && trim_param_is_valid(&trim)) {
+			priv->data->trim_func(priv, pconfig, &trim);
+			trimmed = 1;
+		} else {
+			dev_dbg(priv->dev, "can't get parameter from nvmem\n");
+		}
+	}
+
+	/* use default parameters without trimming values */
+	if (!trimmed) {
+		*pconfig &= ~HSPHY_CFG0_HSDISC_MASK;
+		*pconfig |= FIELD_PREP(HSPHY_CFG0_HSDISC_MASK, 3);
+	}
+
+	return 0;
+}
+
+static void uniphier_u3hsphy_set_param(struct uniphier_u3hsphy_priv *priv,
+				       const struct uniphier_u3hsphy_param *p)
+{
+	u32 val;
+
+	val = readl(priv->base + HSPHY_CFG1);
+	val &= ~HSPHY_CFG1_ADR_MASK;
+	val |= FIELD_PREP(HSPHY_CFG1_ADR_MASK, p->addr) | HSPHY_CFG1_ADR_EN;
+	writel(val, priv->base + HSPHY_CFG1);
+
+	val = readl(priv->base + HSPHY_CFG1);
+	val &= ~HSPHY_CFG1_ADR_EN;
+	writel(val, priv->base + HSPHY_CFG1);
+
+	val = readl(priv->base + HSPHY_CFG1);
+	val &= ~FIELD_PREP(HSPHY_CFG1_DAT_MASK, p->mask);
+	val |=  FIELD_PREP(HSPHY_CFG1_DAT_MASK, p->val) | HSPHY_CFG1_DAT_EN;
+	writel(val, priv->base + HSPHY_CFG1);
+
+	val = readl(priv->base + HSPHY_CFG1);
+	val &= ~HSPHY_CFG1_DAT_EN;
+	writel(val, priv->base + HSPHY_CFG1);
+}
+
+static int uniphier_u3hsphy_init(struct phy *phy)
+{
+	struct uniphier_u3hsphy_priv *priv = phy_get_drvdata(phy);
+	u32 config0, config1;
+	int i, ret;
+
+	ret = clk_prepare_enable(priv->clk_phy_ext);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(priv->clk_phy);
+	if (ret)
+		goto out_clk_ext_disable;
+
+	ret = reset_control_deassert(priv->rst_phy);
+	if (ret)
+		goto out_clk_disable;
+
+	if (!priv->data->config0 && !priv->data->config1)
+		return 0;
+
+	config0 = priv->data->config0;
+	config1 = priv->data->config1;
+
+	ret = uniphier_u3hsphy_update_config(priv, &config0);
+	if (ret)
+		goto out_rst_assert;
+
+	writel(config0, priv->base + HSPHY_CFG0);
+	writel(config1, priv->base + HSPHY_CFG1);
+
+	for (i = 0; i < priv->data->nparams; i++)
+		uniphier_u3hsphy_set_param(priv, &priv->data->param[i]);
+
+	return 0;
+
+out_rst_assert:
+	reset_control_assert(priv->rst_phy);
+out_clk_disable:
+	clk_disable_unprepare(priv->clk_phy);
+out_clk_ext_disable:
+	clk_disable_unprepare(priv->clk_phy_ext);
+
+	return ret;
+}
+
+static int uniphier_u3hsphy_exit(struct phy *phy)
+{
+	struct uniphier_u3hsphy_priv *priv = phy_get_drvdata(phy);
+
+	reset_control_assert(priv->rst_phy);
+	clk_disable_unprepare(priv->clk_phy);
+	clk_disable_unprepare(priv->clk_phy_ext);
+
+	return 0;
+}
+
+static const struct phy_ops uniphier_u3hsphy_ops = {
+	.init           = uniphier_u3hsphy_init,
+	.exit           = uniphier_u3hsphy_exit,
+	.owner          = THIS_MODULE,
+};
+
+static int uniphier_u3hsphy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct uniphier_u3hsphy_priv *priv;
+	struct phy_provider *phy_provider;
+	struct resource *res;
+	struct phy *phy;
+	struct clk *clk;
+	struct reset_control *rst;
+	const char *name;
+	int i, ret, nc, nr;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->data = of_device_get_match_data(dev);
+	if (WARN_ON(!priv->data ||
+		    priv->data->nparams > MAX_PHY_PARAMS))
+		return -EINVAL;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	for (i = 0; i < MAX_CLKS; i++) {
+		name = priv->data->clock_names[i];
+		if (!name)
+			break;
+		clk = devm_clk_get(dev, name);
+		/* "phy-ext" is optional */
+		if (!strcmp(name, "phy-ext")) {
+			if (PTR_ERR(clk) == -ENOENT)
+				clk = NULL;
+			priv->clk_phy_ext = clk;
+		} else if (!strcmp(name, "phy")) {
+			priv->clk_phy = clk;
+		} else {
+			priv->clk[priv->nclks++] = clk;
+		}
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
+	}
+
+	for (i = 0; i < MAX_RSTS; i++) {
+		name = priv->data->reset_names[i];
+		if (!name)
+			break;
+		rst = devm_reset_control_get_shared(dev, name);
+		if (IS_ERR(rst))
+			return PTR_ERR(rst);
+
+		if (!strcmp(name, "phy"))
+			priv->rst_phy = rst;
+		else
+			priv->rst[priv->nrsts++] = rst;
+	}
+
+	phy = devm_phy_create(dev, dev->of_node, &uniphier_u3hsphy_ops);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	for (nc = 0; nc < priv->nclks; nc++) {
+		ret = clk_prepare_enable(priv->clk[nc]);
+		if (ret)
+			goto out_clk_disable;
+	}
+
+	for (nr = 0; nr < priv->nrsts; nr++) {
+		ret = reset_control_deassert(priv->rst[nr]);
+		if (ret)
+			goto out_rst_assert;
+	}
+
+	platform_set_drvdata(pdev, priv);
+	phy_set_drvdata(phy, priv);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider)) {
+		ret = PTR_ERR(phy_provider);
+		goto out_rst_assert;
+	}
+
+	return 0;
+
+out_rst_assert:
+	while (nr--)
+		reset_control_assert(priv->rst[nr]);
+out_clk_disable:
+	while (nc--)
+		clk_disable_unprepare(priv->clk[nc]);
+
+	return ret;
+}
+
+static int uniphier_u3hsphy_remove(struct platform_device *pdev)
+{
+	struct uniphier_u3hsphy_priv *priv = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < priv->nrsts; i++)
+		reset_control_assert(priv->rst[i]);
+	for (i = 0; i < priv->nclks; i++)
+		clk_disable_unprepare(priv->clk[i]);
+
+	return 0;
+}
+
+static const struct uniphier_u3hsphy_soc_data uniphier_pxs2_data = {
+	.clock_names = { "link", "phy", },
+	.reset_names = { "link", "phy", },
+	.nparams = 0,
+};
+
+static const struct uniphier_u3hsphy_soc_data uniphier_ld20_data = {
+	.clock_names = { "link", "phy", },
+	.reset_names = { "link", "phy", },
+	.nparams = 1,
+	.param = {
+		{ 10, 0x60, 0x60 },
+	},
+	.trim_func = uniphier_u3hsphy_trim_ld20,
+	.config0 = 0x92316680,
+	.config1 = 0x00000106,
+};
+
+static const struct uniphier_u3hsphy_soc_data uniphier_pxs3_data = {
+	.clock_names = { "link", "phy", "phy-ext", },
+	.reset_names = { "link", "phy", },
+	.nparams = 0,
+	.trim_func = uniphier_u3hsphy_trim_ld20,
+	.config0 = 0x92316680,
+	.config1 = 0x00000106,
+};
+
+static const struct of_device_id uniphier_u3hsphy_match[] = {
+	{
+		.compatible = "socionext,uniphier-pxs2-usb3-hsphy",
+		.data = &uniphier_pxs2_data,
+	},
+	{
+		.compatible = "socionext,uniphier-ld20-usb3-hsphy",
+		.data = &uniphier_ld20_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pxs3-usb3-hsphy",
+		.data = &uniphier_pxs3_data,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, uniphier_u3hsphy_match);
+
+static struct platform_driver uniphier_u3hsphy_driver = {
+	.probe = uniphier_u3hsphy_probe,
+	.remove = uniphier_u3hsphy_remove,
+	.driver	= {
+		.name = "uniphier-usb3-hsphy",
+		.of_match_table	= uniphier_u3hsphy_match,
+	},
+};
+
+module_platform_driver(uniphier_u3hsphy_driver);
+
+MODULE_AUTHOR("Kunihiko Hayashi <hayashi.kunihiko@socionext.com>");
+MODULE_DESCRIPTION("UniPhier HS-PHY driver for USB3 controller");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/phy/socionext/phy-uniphier-usb3ss.c b/drivers/phy/socionext/phy-uniphier-usb3ss.c
new file mode 100644
index 0000000..6c2fc36
--- /dev/null
+++ b/drivers/phy/socionext/phy-uniphier-usb3ss.c
@@ -0,0 +1,369 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * phy-uniphier-usb3ss.c - SS-PHY driver for Socionext UniPhier USB3 controller
+ * Copyright 2015-2018 Socionext Inc.
+ * Author:
+ *	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+ * Contributors:
+ *      Motoya Tanigawa <tanigawa.motoya@socionext.com>
+ *      Masami Hiramatsu <masami.hiramatsu@linaro.org>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+#define SSPHY_TESTI		0x0
+#define SSPHY_TESTO		0x4
+#define TESTI_DAT_MASK		GENMASK(13, 6)
+#define TESTI_ADR_MASK		GENMASK(5, 1)
+#define TESTI_WR_EN		BIT(0)
+
+#define MAX_CLKS	3
+#define MAX_RSTS	2
+#define MAX_PHY_PARAMS	7
+
+struct uniphier_u3ssphy_param {
+	u32 addr;
+	u32 mask;
+	u32 val;
+};
+
+struct uniphier_u3ssphy_priv {
+	struct device *dev;
+	void __iomem *base;
+	int nclks;
+	struct clk *clk[MAX_CLKS], *clk_phy, *clk_phy_ext;
+	int nrsts;
+	struct reset_control *rst[MAX_RSTS], *rst_phy;
+	const struct uniphier_u3ssphy_soc_data *data;
+};
+
+struct uniphier_u3ssphy_soc_data {
+	const char *clock_names[MAX_CLKS];
+	const char *reset_names[MAX_RSTS];
+	int nparams;
+	const struct uniphier_u3ssphy_param param[MAX_PHY_PARAMS];
+	bool is_legacy;
+};
+
+static void uniphier_u3ssphy_testio_write(struct uniphier_u3ssphy_priv *priv,
+					  u32 data)
+{
+	/* need to read TESTO twice after accessing TESTI */
+	writel(data, priv->base + SSPHY_TESTI);
+	readl(priv->base + SSPHY_TESTI);
+	readl(priv->base + SSPHY_TESTI);
+}
+
+static void uniphier_u3ssphy_set_param(struct uniphier_u3ssphy_priv *priv,
+				       const struct uniphier_u3ssphy_param *p)
+{
+	u32 val, val_prev;
+
+	/* read previous data */
+	val  = FIELD_PREP(TESTI_DAT_MASK, 1);
+	val |= FIELD_PREP(TESTI_ADR_MASK, p->addr);
+	uniphier_u3ssphy_testio_write(priv, val);
+	val_prev = readl(priv->base + SSPHY_TESTO);
+
+	/* update value */
+	val  = FIELD_PREP(TESTI_DAT_MASK,
+			  (val_prev & ~p->mask) | (p->val & p->mask));
+	val |= FIELD_PREP(TESTI_ADR_MASK, p->addr);
+	uniphier_u3ssphy_testio_write(priv, val);
+	uniphier_u3ssphy_testio_write(priv, val | TESTI_WR_EN);
+	uniphier_u3ssphy_testio_write(priv, val);
+
+	/* read current data as dummy */
+	val  = FIELD_PREP(TESTI_DAT_MASK, 1);
+	val |= FIELD_PREP(TESTI_ADR_MASK, p->addr);
+	uniphier_u3ssphy_testio_write(priv, val);
+	readl(priv->base + SSPHY_TESTO);
+}
+
+static void
+uniphier_u3ssphy_legacy_testio_write(struct uniphier_u3ssphy_priv *priv,
+				     u32 data)
+{
+	int i;
+
+	/* need to read TESTO 10 times after accessing TESTI */
+	writel(data, priv->base + SSPHY_TESTI);
+	for (i = 0; i < 10; i++)
+		readl(priv->base + SSPHY_TESTO);
+}
+
+static void
+uniphier_u3ssphy_legacy_set_param(struct uniphier_u3ssphy_priv *priv,
+				  const struct uniphier_u3ssphy_param *p)
+{
+	u32 val;
+
+	val  = FIELD_PREP(TESTI_DAT_MASK, p->val & p->mask);
+	val |= FIELD_PREP(TESTI_ADR_MASK, p->addr);
+	uniphier_u3ssphy_legacy_testio_write(priv, val);
+	uniphier_u3ssphy_legacy_testio_write(priv, val | TESTI_WR_EN);
+	uniphier_u3ssphy_legacy_testio_write(priv, val);
+}
+
+static int uniphier_u3ssphy_init(struct phy *phy)
+{
+	struct uniphier_u3ssphy_priv *priv = phy_get_drvdata(phy);
+	int i, ret;
+
+	ret = clk_prepare_enable(priv->clk_phy_ext);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(priv->clk_phy);
+	if (ret)
+		goto out_clk_ext_disable;
+
+	ret = reset_control_deassert(priv->rst_phy);
+	if (ret)
+		goto out_clk_disable;
+
+	for (i = 0; i < priv->data->nparams; i++)
+		if (priv->data->is_legacy)
+			uniphier_u3ssphy_legacy_set_param(priv,
+							&priv->data->param[i]);
+		else
+			uniphier_u3ssphy_set_param(priv,
+						   &priv->data->param[i]);
+
+	return 0;
+
+out_clk_disable:
+	clk_disable_unprepare(priv->clk_phy);
+out_clk_ext_disable:
+	clk_disable_unprepare(priv->clk_phy_ext);
+
+	return ret;
+}
+
+static int uniphier_u3ssphy_exit(struct phy *phy)
+{
+	struct uniphier_u3ssphy_priv *priv = phy_get_drvdata(phy);
+
+	reset_control_assert(priv->rst_phy);
+	clk_disable_unprepare(priv->clk_phy);
+	clk_disable_unprepare(priv->clk_phy_ext);
+
+	return 0;
+}
+
+static const struct phy_ops uniphier_u3ssphy_ops = {
+	.init           = uniphier_u3ssphy_init,
+	.exit           = uniphier_u3ssphy_exit,
+	.owner          = THIS_MODULE,
+};
+
+static int uniphier_u3ssphy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct uniphier_u3ssphy_priv *priv;
+	struct phy_provider *phy_provider;
+	struct resource *res;
+	struct phy *phy;
+	struct clk *clk;
+	struct reset_control *rst;
+	const char *name;
+	int i, ret, nc, nr;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->data = of_device_get_match_data(dev);
+	if (WARN_ON(!priv->data ||
+		    priv->data->nparams > MAX_PHY_PARAMS))
+		return -EINVAL;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	for (i = 0; i < MAX_CLKS; i++) {
+		name = priv->data->clock_names[i];
+		if (!name)
+			break;
+		clk = devm_clk_get(dev, name);
+		/* "phy-ext" is optional */
+		if (!strcmp(name, "phy-ext")) {
+			if (PTR_ERR(clk) == -ENOENT)
+				clk = NULL;
+			priv->clk_phy_ext = clk;
+		} else if (!strcmp(name, "phy")) {
+			priv->clk_phy = clk;
+		} else {
+			priv->clk[priv->nclks++] = clk;
+		}
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
+	}
+
+	for (i = 0; i < MAX_RSTS; i++) {
+		name = priv->data->reset_names[i];
+		if (!name)
+			break;
+		rst = devm_reset_control_get_shared(dev, name);
+		if (IS_ERR(rst))
+			return PTR_ERR(rst);
+
+		if (!strcmp(name, "phy"))
+			priv->rst_phy = rst;
+		else
+			priv->rst[priv->nrsts++] = rst;
+	}
+
+	phy = devm_phy_create(dev, dev->of_node, &uniphier_u3ssphy_ops);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	for (nc = 0; nc < priv->nclks; nc++) {
+		ret = clk_prepare_enable(priv->clk[nc]);
+		if (ret)
+			goto out_clk_disable;
+	}
+
+	for (nr = 0; nr < priv->nrsts; nr++) {
+		ret = reset_control_deassert(priv->rst[nr]);
+		if (ret)
+			goto out_rst_assert;
+	}
+
+	platform_set_drvdata(pdev, priv);
+	phy_set_drvdata(phy, priv);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider)) {
+		ret = PTR_ERR(phy_provider);
+		goto out_rst_assert;
+	}
+
+	return 0;
+
+out_rst_assert:
+	while (nr--)
+		reset_control_assert(priv->rst[nr]);
+out_clk_disable:
+	while (nc--)
+		clk_disable_unprepare(priv->clk[nc]);
+
+	return ret;
+}
+
+static int uniphier_u3ssphy_remove(struct platform_device *pdev)
+{
+	struct uniphier_u3ssphy_priv *priv = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < priv->nrsts; i++)
+		reset_control_assert(priv->rst[i]);
+	for (i = 0; i < priv->nclks; i++)
+		clk_disable_unprepare(priv->clk[i]);
+
+	return 0;
+}
+
+static const struct uniphier_u3ssphy_soc_data uniphier_pro4_data = {
+	.clock_names = { "gio", "link", },
+	.reset_names = { "gio", "link", },
+	.nparams = 7,
+	.param = {
+		{  0, 0x0f, 0x04 },
+		{  3, 0x0f, 0x08 },
+		{  5, 0x0f, 0x08 },
+		{  6, 0x0f, 0x07 },
+		{  7, 0x0f, 0x02 },
+		{ 28, 0x0f, 0x0a },
+		{ 30, 0x0f, 0x09 },
+	},
+	.is_legacy = true,
+};
+
+static const struct uniphier_u3ssphy_soc_data uniphier_pxs2_data = {
+	.clock_names = { "link", "phy", },
+	.reset_names = { "link", "phy", },
+	.nparams = 7,
+	.param = {
+		{  7, 0x0f, 0x0a },
+		{  8, 0x0f, 0x03 },
+		{  9, 0x0f, 0x05 },
+		{ 11, 0x0f, 0x09 },
+		{ 13, 0x60, 0x40 },
+		{ 27, 0x07, 0x07 },
+		{ 28, 0x03, 0x01 },
+	},
+	.is_legacy = false,
+};
+
+static const struct uniphier_u3ssphy_soc_data uniphier_ld20_data = {
+	.clock_names = { "link", "phy", },
+	.reset_names = { "link", "phy", },
+	.nparams = 3,
+	.param = {
+		{  7, 0x0f, 0x06 },
+		{ 13, 0xff, 0xcc },
+		{ 26, 0xf0, 0x50 },
+	},
+	.is_legacy = false,
+};
+
+static const struct uniphier_u3ssphy_soc_data uniphier_pxs3_data = {
+	.clock_names = { "link", "phy", "phy-ext", },
+	.reset_names = { "link", "phy", },
+	.nparams = 3,
+	.param = {
+		{  7, 0x0f, 0x06 },
+		{ 13, 0xff, 0xcc },
+		{ 26, 0xf0, 0x50 },
+	},
+	.is_legacy = false,
+};
+
+static const struct of_device_id uniphier_u3ssphy_match[] = {
+	{
+		.compatible = "socionext,uniphier-pro4-usb3-ssphy",
+		.data = &uniphier_pro4_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pxs2-usb3-ssphy",
+		.data = &uniphier_pxs2_data,
+	},
+	{
+		.compatible = "socionext,uniphier-ld20-usb3-ssphy",
+		.data = &uniphier_ld20_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pxs3-usb3-ssphy",
+		.data = &uniphier_pxs3_data,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, uniphier_u3ssphy_match);
+
+static struct platform_driver uniphier_u3ssphy_driver = {
+	.probe = uniphier_u3ssphy_probe,
+	.remove = uniphier_u3ssphy_remove,
+	.driver	= {
+		.name = "uniphier-usb3-ssphy",
+		.of_match_table	= uniphier_u3ssphy_match,
+	},
+};
+
+module_platform_driver(uniphier_u3ssphy_driver);
+
+MODULE_AUTHOR("Kunihiko Hayashi <hayashi.kunihiko@socionext.com>");
+MODULE_DESCRIPTION("UniPhier SS-PHY driver for USB3 controller");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

