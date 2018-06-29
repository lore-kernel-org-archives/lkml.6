Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D291C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE2E27079
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE2E27079
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965765AbeF2Ikh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:40:37 -0400
Received: from mx.socionext.com ([202.248.49.38]:43010 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965371AbeF2IjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:39:05 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 29 Jun 2018 17:39:02 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id C0F841800FC;
        Fri, 29 Jun 2018 17:39:02 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 29 Jun 2018 17:39:02 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 4C2F01A120E;
        Fri, 29 Jun 2018 17:39:02 +0900 (JST)
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
Subject: [PATCH 4/4] phy: socionext: add USB2 PHY driver for UniPhier SoC
Date:   Fri, 29 Jun 2018 17:39:01 +0900
Message-Id: <1530261541-23104-5-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530261541-23104-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1530261541-23104-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for PHY interface built into USB2 controller implemented on
UniPhier SoCs. This driver supports HS-PHY for Pro4 and LD11.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/phy/socionext/Kconfig             |  13 ++
 drivers/phy/socionext/Makefile            |   1 +
 drivers/phy/socionext/phy-uniphier-usb2.c | 218 ++++++++++++++++++++++++++++++
 3 files changed, 232 insertions(+)
 create mode 100644 drivers/phy/socionext/phy-uniphier-usb2.c

diff --git a/drivers/phy/socionext/Kconfig b/drivers/phy/socionext/Kconfig
index 4a172fc..497ca38 100644
--- a/drivers/phy/socionext/Kconfig
+++ b/drivers/phy/socionext/Kconfig
@@ -2,6 +2,19 @@
 # PHY drivers for Socionext platforms.
 #
 
+config PHY_UNIPHIER_USB2
+	tristate "UniPhier USB2 PHY driver"
+	depends on ARCH_UNIPHIER || COMPILE_TEST
+	depends on OF && HAS_IOMEM
+	select GENERIC_PHY
+	select MFD_SYSCON
+	help
+	  Enable this to support USB PHY implemented on USB2 controller
+	  on UniPhier SoCs. This driver provides interface to interact
+	  with USB 2.0 PHY that is part of the UniPhier SoC.
+	  In case of Pro4, it is necessary to specify this USB2 PHY instead
+	  of USB3 HS-PHY.
+
 config PHY_UNIPHIER_USB3
 	tristate "UniPhier USB3 PHY driver"
 	depends on ARCH_UNIPHIER || COMPILE_TEST
diff --git a/drivers/phy/socionext/Makefile b/drivers/phy/socionext/Makefile
index dfa5cec..6b4763e 100644
--- a/drivers/phy/socionext/Makefile
+++ b/drivers/phy/socionext/Makefile
@@ -3,4 +3,5 @@
 # Makefile for the phy drivers.
 #
 
+obj-$(CONFIG_PHY_UNIPHIER_USB2)	+= phy-uniphier-usb2.o
 obj-$(CONFIG_PHY_UNIPHIER_USB3)	+= phy-uniphier-usb3hs.o phy-uniphier-usb3ss.o
diff --git a/drivers/phy/socionext/phy-uniphier-usb2.c b/drivers/phy/socionext/phy-uniphier-usb2.c
new file mode 100644
index 0000000..bab9e38
--- /dev/null
+++ b/drivers/phy/socionext/phy-uniphier-usb2.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * phy-uniphier-usb2.c - PHY driver for UniPhier USB2 controller
+ * Copyright 2015-2018 Socionext Inc.
+ * Author:
+ *	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+ */
+
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define PHY_PARAMS	2
+
+struct uniphier_u2phy_soc_data {
+	struct {
+		u32 addr;
+		u32 val;
+	} param[PHY_PARAMS];
+};
+
+struct uniphier_u2phy_priv {
+	struct regmap *regmap;
+	struct phy *phy;
+	const struct uniphier_u2phy_soc_data *data;
+	struct uniphier_u2phy_priv *next;
+};
+
+static int uniphier_u2phy_init(struct phy *phy)
+{
+	struct uniphier_u2phy_priv *priv = phy_get_drvdata(phy);
+	int i;
+
+	if (!priv->data)
+		return 0;
+
+	for (i = 0; i < PHY_PARAMS; i++)
+		regmap_write(priv->regmap,
+			     priv->data->param[i].addr,
+			     priv->data->param[i].val);
+
+	return 0;
+}
+
+static struct phy *uniphier_u2phy_xlate(struct device *dev,
+					struct of_phandle_args *args)
+{
+	struct uniphier_u2phy_priv *priv = dev_get_drvdata(dev);
+
+	while (priv && args->np != priv->phy->dev.of_node)
+		priv = priv->next;
+
+	if (!priv) {
+		dev_err(dev, "Failed to find appropriate phy\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	return priv->phy;
+}
+
+static const struct phy_ops uniphier_u2phy_ops = {
+	.init  = uniphier_u2phy_init,
+	.owner = THIS_MODULE,
+};
+
+static int uniphier_u2phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *parent, *child;
+	struct uniphier_u2phy_priv *priv = NULL, *next = NULL;
+	struct phy_provider *phy_provider;
+	struct regmap *regmap;
+	struct phy *phy;
+	const struct uniphier_u2phy_soc_data *data;
+	int ret, data_idx, ndatas;
+
+	data = of_device_get_match_data(dev);
+	if (WARN_ON(!data))
+		return -EINVAL;
+
+	/* get number of data */
+	for (ndatas = 0; data[ndatas].param[0].addr; ndatas++)
+		;
+
+	parent = of_get_parent(dev->of_node);
+	regmap = syscon_node_to_regmap(parent);
+	of_node_put(parent);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to get regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	for_each_child_of_node(dev->of_node, child) {
+		priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+		if (!priv) {
+			ret = -ENOMEM;
+			goto out_put_child;
+		}
+		priv->regmap = regmap;
+
+		phy = devm_phy_create(dev, child, &uniphier_u2phy_ops);
+		if (IS_ERR(phy)) {
+			dev_err(dev, "Failed to create phy\n");
+			ret = PTR_ERR(phy);
+			goto out_put_child;
+		}
+		priv->phy = phy;
+
+		ret = of_property_read_u32(child, "reg", &data_idx);
+		if (ret) {
+			dev_err(dev, "Failed to get reg property\n");
+			goto out_put_child;
+		}
+
+		if (data_idx < ndatas)
+			priv->data = &data[data_idx];
+		else
+			dev_warn(dev, "No phy configuration: %s\n",
+				 child->full_name);
+
+		phy_set_drvdata(phy, priv);
+		priv->next = next;
+		next = priv;
+	}
+
+	dev_set_drvdata(dev, priv);
+	phy_provider = devm_of_phy_provider_register(dev,
+						     uniphier_u2phy_xlate);
+	if (IS_ERR(phy_provider))
+		return PTR_ERR(phy_provider);
+
+	return 0;
+
+out_put_child:
+	of_node_put(child);
+
+	return ret;
+}
+
+static const struct uniphier_u2phy_soc_data uniphier_pro4_data[] = {
+	{
+		.param = {
+			{ 0x500, 0x05142400 },
+			{ 0x50c, 0x00010010 },
+		},
+	},
+	{
+		.param = {
+			{ 0x508, 0x05142400 },
+			{ 0x50c, 0x00010010 },
+		},
+	},
+	{
+		.param = {
+			{ 0x510, 0x05142400 },
+			{ 0x51c, 0x00010010 },
+		},
+	},
+	{
+		.param = {
+			{ 0x518, 0x05142400 },
+			{ 0x51c, 0x00010010 },
+		},
+	},
+	{ /* sentinel */ }
+};
+
+static const struct uniphier_u2phy_soc_data uniphier_ld11_data[] = {
+	{
+		.param = {
+			{ 0x500, 0x82280000 },
+			{ 0x504, 0x00000106 },
+		},
+	},
+	{
+		.param = {
+			{ 0x508, 0x82280000 },
+			{ 0x50c, 0x00000106 },
+		},
+	},
+	{
+		.param = {
+			{ 0x510, 0x82280000 },
+			{ 0x514, 0x00000106 },
+		},
+	},
+	{ /* sentinel */ }
+};
+
+static const struct of_device_id uniphier_u2phy_match[] = {
+	{
+		.compatible = "socionext,uniphier-pro4-usb2-phy",
+		.data = &uniphier_pro4_data,
+	},
+	{
+		.compatible = "socionext,uniphier-ld11-usb2-phy",
+		.data = &uniphier_ld11_data,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, uniphier_u2phy_match);
+
+static struct platform_driver uniphier_u2phy_driver = {
+	.probe = uniphier_u2phy_probe,
+	.driver = {
+		.name = "uniphier-usb2-phy",
+		.of_match_table = uniphier_u2phy_match,
+	},
+};
+module_platform_driver(uniphier_u2phy_driver);
+
+MODULE_AUTHOR("Kunihiko Hayashi <hayashi.kunihiko@socionext.com>");
+MODULE_DESCRIPTION("UniPhier PHY driver for USB2 controller");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

