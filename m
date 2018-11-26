Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF489C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE2C20868
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 00:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eMW51znd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE2C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbeKZLIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 06:08:24 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55944 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeKZLIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 06:08:23 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ0FXJd037340;
        Sun, 25 Nov 2018 18:15:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543191333;
        bh=l1b+yACLW9JqzrWqtqf61DuKoGa8C8wbmUAZA1SpVnU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eMW51zndS6CSp7EzcG2QL3R8e98u3thORn9utaDO5ksVAgz4SLEx7Xngj+HT67Xur
         RfMOSs5xo8GP2kI+2a8aiGPWr5ckvGzT400Vnr6otj82VKPr02SHodDUzY/nkDume4
         N83Qr8A7ecBl38M2KnrniPMRY73mUIbWh7X3Qne0=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ0FXqX039051
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 25 Nov 2018 18:15:33 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 25
 Nov 2018 18:15:33 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 25 Nov 2018 18:15:33 -0600
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ0FXZc013046;
        Sun, 25 Nov 2018 18:15:33 -0600
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id wAQ0FXU04342;
        Sun, 25 Nov 2018 18:15:33 -0600 (CST)
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Andrew Lunn <andrew@lunn.ch>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH linux-next 02/10] phy: ti: introduce phy-gmii-sel driver
Date:   Sun, 25 Nov 2018 18:15:23 -0600
Message-ID: <20181126001531.12974-3-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
In-Reply-To: <20181126001531.12974-1-grygorii.strashko@ti.com>
References: <20181126001531.12974-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI am335x/am437x/dra7(am5)/dm814x CPSW3G Ethernet Subsystem supports two
10/100/1000 Ethernet ports with selectable G/MII, RMII, and RGMII
interfaces. The interface mode is selected by configuring the MII mode
selection register(s) (GMII_SEL) in the System Control Module chapter
(SCM). GMII_SEL register(s) and bit fields placement in SCM are different
between SoCs while fields meaning is the same.

Historically CPSW external Port's interface mode selection configuration
was introduced using custom API and driver cpsw-phy-sel.c. This leads to
unnecessary driver, DT binding and custom API support effort.

This patch introduces CPSW Port's PHY Interface Mode selection Driver
(phy-gmii-sel) which implements standard Linux PHY interface and used
as a replacement for TI's specific driver cpsw-phy-sel.c and corresponding
custom API.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/phy/ti/Kconfig        |  10 ++
 drivers/phy/ti/Makefile       |   1 +
 drivers/phy/ti/phy-gmii-sel.c | 349 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 360 insertions(+)
 create mode 100644 drivers/phy/ti/phy-gmii-sel.c

diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
index 2050356..f137e01 100644
--- a/drivers/phy/ti/Kconfig
+++ b/drivers/phy/ti/Kconfig
@@ -76,3 +76,13 @@ config TWL4030_USB
 	  family chips (including the TWL5030 and TPS659x0 devices).
 	  This transceiver supports high and full speed devices plus,
 	  in host mode, low speed.
+
+config PHY_TI_GMII_SEL
+	tristate
+	default y if TI_CPSW=y
+	depends on TI_CPSW || COMPILE_TEST
+	select GENERIC_PHY
+	default m
+	help
+	  This driver supports configuring of the TI CPSW Port mode depending on
+	  the Ethernet PHY connected to the CPSW Port.
diff --git a/drivers/phy/ti/Makefile b/drivers/phy/ti/Makefile
index 9f36175..bea8f25 100644
--- a/drivers/phy/ti/Makefile
+++ b/drivers/phy/ti/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_OMAP_USB2)			+= phy-omap-usb2.o
 obj-$(CONFIG_TI_PIPE3)			+= phy-ti-pipe3.o
 obj-$(CONFIG_PHY_TUSB1210)		+= phy-tusb1210.o
 obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
+obj-$(CONFIG_PHY_TI_GMII_SEL)		+= phy-gmii-sel.o
diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
new file mode 100644
index 0000000..04ebf53
--- /dev/null
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Texas Instruments CPSW Port's PHY Interface Mode selection Driver
+ *
+ * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * Based on cpsw-phy-sel.c driver created by Mugunthan V N <mugunthanvnm@ti.com>
+ */
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_net.h>
+#include <linux/phy.h>
+#include <linux/phy/phy.h>
+#include <linux/regmap.h>
+
+/* AM33xx SoC specific definitions for the CONTROL port */
+#define AM33XX_GMII_SEL_MODE_MII	0
+#define AM33XX_GMII_SEL_MODE_RMII	1
+#define AM33XX_GMII_SEL_MODE_RGMII	2
+
+enum {
+	PHY_GMII_SEL_PORT_MODE,
+	PHY_GMII_SEL_RGMII_ID_MODE,
+	PHY_GMII_SEL_RMII_IO_CLK_EN,
+	PHY_GMII_SEL_LAST,
+};
+
+struct phy_gmii_sel_phy_priv {
+	struct phy_gmii_sel_priv *priv;
+	u32		id;
+	struct phy	*if_phy;
+	int		rmii_clock_external;
+	int		phy_if_mode;
+	struct regmap_field *fields[PHY_GMII_SEL_LAST];
+};
+
+struct phy_gmii_sel_soc_data {
+	u32 num_ports;
+	u32 features;
+	const struct reg_field (*regfields)[PHY_GMII_SEL_LAST];
+};
+
+struct phy_gmii_sel_priv {
+	struct device *dev;
+	const struct phy_gmii_sel_soc_data *soc_data;
+	struct regmap *regmap;
+	struct phy_provider *phy_provider;
+	struct phy_gmii_sel_phy_priv *if_phys;
+};
+
+static int phy_gmii_sel_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	struct phy_gmii_sel_phy_priv *if_phy = phy_get_drvdata(phy);
+	const struct phy_gmii_sel_soc_data *soc_data = if_phy->priv->soc_data;
+	struct device *dev = if_phy->priv->dev;
+	struct regmap_field *regfield;
+	int ret, rgmii_id = 0;
+	u32 gmii_sel_mode = 0;
+
+	if (mode != PHY_MODE_ETHERNET)
+		return -EINVAL;
+
+	switch (submode) {
+	case PHY_INTERFACE_MODE_RMII:
+		gmii_sel_mode = AM33XX_GMII_SEL_MODE_RMII;
+		break;
+
+	case PHY_INTERFACE_MODE_RGMII:
+		gmii_sel_mode = AM33XX_GMII_SEL_MODE_RGMII;
+		break;
+
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		gmii_sel_mode = AM33XX_GMII_SEL_MODE_RGMII;
+		rgmii_id = 1;
+		break;
+
+	case PHY_INTERFACE_MODE_MII:
+		mode = AM33XX_GMII_SEL_MODE_MII;
+		break;
+
+	default:
+		dev_warn(dev,
+			 "port%u: unsupported mode: \"%s\". Defaulting to MII.\n",
+			 if_phy->id, phy_modes(rgmii_id));
+		return -EINVAL;
+	};
+
+	if_phy->phy_if_mode = submode;
+
+	dev_dbg(dev, "%s id:%u mode:%u rgmii_id:%d rmii_clk_ext:%d\n",
+		__func__, if_phy->id, mode, rgmii_id,
+		if_phy->rmii_clock_external);
+
+	regfield = if_phy->fields[PHY_GMII_SEL_PORT_MODE];
+	ret = regmap_field_write(regfield, gmii_sel_mode);
+	if (ret) {
+		dev_err(dev, "port%u: set mode fail %d", if_phy->id, ret);
+		return ret;
+	}
+
+	if (soc_data->features & BIT(PHY_GMII_SEL_RGMII_ID_MODE) &&
+	    if_phy->fields[PHY_GMII_SEL_RGMII_ID_MODE]) {
+		regfield = if_phy->fields[PHY_GMII_SEL_RGMII_ID_MODE];
+		ret = regmap_field_write(regfield, rgmii_id);
+		if (ret)
+			return ret;
+	}
+
+	if (soc_data->features & BIT(PHY_GMII_SEL_RMII_IO_CLK_EN) &&
+	    if_phy->fields[PHY_GMII_SEL_RMII_IO_CLK_EN]) {
+		regfield = if_phy->fields[PHY_GMII_SEL_RMII_IO_CLK_EN];
+		ret = regmap_field_write(regfield,
+					 if_phy->rmii_clock_external);
+	}
+
+	return 0;
+}
+
+static const
+struct reg_field phy_gmii_sel_fields_am33xx[][PHY_GMII_SEL_LAST] = {
+	{
+		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x650, 0, 1),
+		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD(0x650, 4, 4),
+		[PHY_GMII_SEL_RMII_IO_CLK_EN] = REG_FIELD(0x650, 6, 6),
+	},
+	{
+		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x650, 2, 3),
+		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD(0x650, 5, 5),
+		[PHY_GMII_SEL_RMII_IO_CLK_EN] = REG_FIELD(0x650, 7, 7),
+	},
+};
+
+static const
+struct phy_gmii_sel_soc_data phy_gmii_sel_soc_am33xx = {
+	.num_ports = 2,
+	.features = BIT(PHY_GMII_SEL_RGMII_ID_MODE) |
+		    BIT(PHY_GMII_SEL_RMII_IO_CLK_EN),
+	.regfields = phy_gmii_sel_fields_am33xx,
+};
+
+static const
+struct reg_field phy_gmii_sel_fields_dra7[][PHY_GMII_SEL_LAST] = {
+	{
+		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x554, 0, 1),
+		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD((~0), 0, 0),
+		[PHY_GMII_SEL_RMII_IO_CLK_EN] = REG_FIELD((~0), 0, 0),
+	},
+	{
+		[PHY_GMII_SEL_PORT_MODE] = REG_FIELD(0x554, 4, 5),
+		[PHY_GMII_SEL_RGMII_ID_MODE] = REG_FIELD((~0), 0, 0),
+		[PHY_GMII_SEL_RMII_IO_CLK_EN] = REG_FIELD((~0), 0, 0),
+	},
+};
+
+static const
+struct phy_gmii_sel_soc_data phy_gmii_sel_soc_dra7 = {
+	.num_ports = 2,
+	.regfields = phy_gmii_sel_fields_dra7,
+};
+
+static const
+struct phy_gmii_sel_soc_data phy_gmii_sel_soc_dm814 = {
+	.num_ports = 2,
+	.features = BIT(PHY_GMII_SEL_RGMII_ID_MODE),
+	.regfields = phy_gmii_sel_fields_am33xx,
+};
+
+static const struct of_device_id phy_gmii_sel_id_table[] = {
+	{
+		.compatible	= "ti,am3352-phy-gmii-sel",
+		.data		= &phy_gmii_sel_soc_am33xx,
+	},
+	{
+		.compatible	= "ti,dra7xx-phy-gmii-sel",
+		.data		= &phy_gmii_sel_soc_dra7,
+	},
+	{
+		.compatible	= "ti,am43xx-phy-gmii-sel",
+		.data		= &phy_gmii_sel_soc_am33xx,
+	},
+	{
+		.compatible	= "ti,dm814-phy-gmii-sel",
+		.data		= &phy_gmii_sel_soc_dm814,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, phy_gmii_sel_id_table);
+
+static const struct phy_ops phy_gmii_sel_ops = {
+	.set_mode	= phy_gmii_sel_mode,
+	.owner		= THIS_MODULE,
+};
+
+static struct phy *phy_gmii_sel_of_xlate(struct device *dev,
+					 struct of_phandle_args *args)
+{
+	struct phy_gmii_sel_priv *priv = dev_get_drvdata(dev);
+	int phy_id = args->args[0];
+
+	if (args->args_count < 1)
+		return ERR_PTR(-EINVAL);
+	if (priv->soc_data->features & BIT(PHY_GMII_SEL_RMII_IO_CLK_EN) &&
+	    args->args_count < 2)
+		return ERR_PTR(-EINVAL);
+	if (!priv || !priv->if_phys)
+		return ERR_PTR(-ENODEV);
+	if (phy_id > priv->soc_data->num_ports)
+		return ERR_PTR(-EINVAL);
+	if (phy_id != priv->if_phys[phy_id - 1].id)
+		return ERR_PTR(-EINVAL);
+
+	phy_id--;
+	if (priv->soc_data->features & BIT(PHY_GMII_SEL_RMII_IO_CLK_EN))
+		priv->if_phys[phy_id].rmii_clock_external = args->args[1];
+	dev_dbg(dev, "%s id:%u ext:%d\n", __func__,
+		priv->if_phys[phy_id].id, args->args[1]);
+
+	return priv->if_phys[phy_id].if_phy;
+}
+
+static int phy_gmii_sel_init_ports(struct phy_gmii_sel_priv *priv)
+{
+	const struct phy_gmii_sel_soc_data *soc_data = priv->soc_data;
+	struct device *dev = priv->dev;
+	struct phy_gmii_sel_phy_priv *if_phys;
+	int i, num_ports, ret;
+
+	num_ports = priv->soc_data->num_ports;
+
+	if_phys = devm_kcalloc(priv->dev, num_ports,
+			       sizeof(*if_phys), GFP_KERNEL);
+	if (!if_phys)
+		return -ENOMEM;
+	dev_dbg(dev, "%s %d\n", __func__, num_ports);
+
+	for (i = 0; i < num_ports; i++) {
+		const struct reg_field *field;
+		struct regmap_field *regfield;
+
+		if_phys[i].id = i + 1;
+		if_phys[i].priv = priv;
+
+		field = &soc_data->regfields[i][PHY_GMII_SEL_PORT_MODE];
+		dev_dbg(dev, "%s field %x %d %d\n", __func__,
+			field->reg, field->msb, field->lsb);
+
+		regfield = devm_regmap_field_alloc(dev, priv->regmap, *field);
+		if (IS_ERR(regfield))
+			return PTR_ERR(regfield);
+		if_phys[i].fields[PHY_GMII_SEL_PORT_MODE] = regfield;
+
+		field = &soc_data->regfields[i][PHY_GMII_SEL_RGMII_ID_MODE];
+		if (field->reg != (~0)) {
+			regfield = devm_regmap_field_alloc(dev,
+							   priv->regmap,
+							   *field);
+			if (IS_ERR(regfield))
+				return PTR_ERR(regfield);
+			if_phys[i].fields[PHY_GMII_SEL_RGMII_ID_MODE] =
+				regfield;
+		}
+
+		field = &soc_data->regfields[i][PHY_GMII_SEL_RMII_IO_CLK_EN];
+		if (field->reg != (~0)) {
+			regfield = devm_regmap_field_alloc(dev,
+							   priv->regmap,
+							   *field);
+			if (IS_ERR(regfield))
+				return PTR_ERR(regfield);
+			if_phys[i].fields[PHY_GMII_SEL_RMII_IO_CLK_EN] =
+				regfield;
+		}
+
+		if_phys[i].if_phy = devm_phy_create(dev,
+						    priv->dev->of_node,
+						    &phy_gmii_sel_ops);
+		if (IS_ERR(if_phys[i].if_phy)) {
+			ret = PTR_ERR(if_phys[i].if_phy);
+			dev_err(dev, "Failed to create phy%d %d\n", i, ret);
+			return ret;
+		}
+		phy_set_drvdata(if_phys[i].if_phy, &if_phys[i]);
+	}
+
+	priv->if_phys = if_phys;
+	return 0;
+}
+
+static int phy_gmii_sel_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	const struct of_device_id *of_id;
+	struct phy_gmii_sel_priv *priv;
+	int ret;
+
+	of_id = of_match_node(phy_gmii_sel_id_table, pdev->dev.of_node);
+	if (!of_id)
+		return -EINVAL;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+	priv->soc_data = of_id->data;
+
+	priv->regmap = syscon_node_to_regmap(node->parent);
+	if (IS_ERR(priv->regmap)) {
+		ret = PTR_ERR(priv->regmap);
+		dev_err(dev, "Failed to get syscon %d\n", ret);
+		return ret;
+	}
+
+	ret = phy_gmii_sel_init_ports(priv);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(&pdev->dev, priv);
+
+	priv->phy_provider =
+		devm_of_phy_provider_register(dev,
+					      phy_gmii_sel_of_xlate);
+	if (IS_ERR(priv->phy_provider)) {
+		ret = PTR_ERR(priv->phy_provider);
+		dev_err(dev, "Failed to create phy provider %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct platform_driver phy_gmii_sel_driver = {
+	.probe		= phy_gmii_sel_probe,
+	.driver		= {
+		.name	= "phy-gmii-sel",
+		.of_match_table = phy_gmii_sel_id_table,
+	},
+};
+module_platform_driver(phy_gmii_sel_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Grygorii Strashko <grygorii.strashko@ti.com>");
+MODULE_DESCRIPTION("TI CPSW Port's PHY Interface Mode selection Driver");
-- 
2.10.5

