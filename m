Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E40C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F4920877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F4920877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeJDTQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:16:08 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35851 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728038AbeJDTQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:16:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BC5C320A90; Thu,  4 Oct 2018 14:23:01 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 25D4C20DDC;
        Thu,  4 Oct 2018 14:22:34 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next v4 10/11] phy: add driver for Microsemi Ocelot SerDes muxing
Date:   Thu,  4 Oct 2018 14:22:07 +0200
Message-Id: <20181004122208.32272-11-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004122208.32272-1-quentin.schulz@bootlin.com>
References: <20181004122208.32272-1-quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Microsemi Ocelot can mux SerDes lanes (aka macros) to different
switch ports or even make it act as a PCIe interface.

This adds support for the muxing of the SerDes.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/phy/Kconfig                  |   1 +
 drivers/phy/Makefile                 |   1 +
 drivers/phy/mscc/Kconfig             |  11 +
 drivers/phy/mscc/Makefile            |   5 +
 drivers/phy/mscc/phy-ocelot-serdes.c | 295 +++++++++++++++++++++++++++
 5 files changed, 313 insertions(+)
 create mode 100644 drivers/phy/mscc/Kconfig
 create mode 100644 drivers/phy/mscc/Makefile
 create mode 100644 drivers/phy/mscc/phy-ocelot-serdes.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 5c8d452e35e2..c89d3effd99d 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -48,6 +48,7 @@ source "drivers/phy/lantiq/Kconfig"
 source "drivers/phy/marvell/Kconfig"
 source "drivers/phy/mediatek/Kconfig"
 source "drivers/phy/motorola/Kconfig"
+source "drivers/phy/mscc/Kconfig"
 source "drivers/phy/qualcomm/Kconfig"
 source "drivers/phy/ralink/Kconfig"
 source "drivers/phy/renesas/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 84e3bd9c5665..ce8339ff0022 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -18,6 +18,7 @@ obj-y					+= broadcom/	\
 					   hisilicon/	\
 					   marvell/	\
 					   motorola/	\
+					   mscc/	\
 					   qualcomm/	\
 					   ralink/	\
 					   samsung/	\
diff --git a/drivers/phy/mscc/Kconfig b/drivers/phy/mscc/Kconfig
new file mode 100644
index 000000000000..2e2a466efd66
--- /dev/null
+++ b/drivers/phy/mscc/Kconfig
@@ -0,0 +1,11 @@
+#
+# Phy drivers for Microsemi devices
+#
+
+config PHY_OCELOT_SERDES
+	tristate "SerDes PHY driver for Microsemi Ocelot"
+	select GENERIC_PHY
+	depends on OF
+	depends on MFD_SYSCON
+	help
+	  Enable this for supporting SerDes muxing with Microsemi Ocelot.
diff --git a/drivers/phy/mscc/Makefile b/drivers/phy/mscc/Makefile
new file mode 100644
index 000000000000..e14749170fc9
--- /dev/null
+++ b/drivers/phy/mscc/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for the Microsemi phy drivers.
+#
+
+obj-$(CONFIG_PHY_OCELOT_SERDES) := phy-ocelot-serdes.o
diff --git a/drivers/phy/mscc/phy-ocelot-serdes.c b/drivers/phy/mscc/phy-ocelot-serdes.c
new file mode 100644
index 000000000000..8936abd22f0f
--- /dev/null
+++ b/drivers/phy/mscc/phy-ocelot-serdes.c
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * SerDes PHY driver for Microsemi Ocelot
+ *
+ * Copyright (c) 2018 Microsemi
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <soc/mscc/ocelot_hsio.h>
+#include <dt-bindings/phy/phy-ocelot-serdes.h>
+
+struct serdes_ctrl {
+	struct regmap		*regs;
+	struct device		*dev;
+	struct phy		*phys[SERDES_MAX];
+};
+
+struct serdes_macro {
+	u8			idx;
+	/* Not used when in QSGMII or PCIe mode */
+	int			port;
+	struct serdes_ctrl	*ctrl;
+};
+
+#define MCB_S1G_CFG_TIMEOUT     50
+
+static int __serdes_write_mcb_s1g(struct regmap *regmap, u8 macro, u32 op)
+{
+	unsigned int regval;
+
+	regmap_write(regmap, HSIO_MCB_S1G_ADDR_CFG, op |
+		     HSIO_MCB_S1G_ADDR_CFG_SERDES1G_ADDR(BIT(macro)));
+
+	return regmap_read_poll_timeout(regmap, HSIO_MCB_S1G_ADDR_CFG, regval,
+					(regval & op) != op, 100,
+					MCB_S1G_CFG_TIMEOUT * 1000);
+}
+
+static int serdes_commit_mcb_s1g(struct regmap *regmap, u8 macro)
+{
+	return __serdes_write_mcb_s1g(regmap, macro,
+		HSIO_MCB_S1G_ADDR_CFG_SERDES1G_WR_ONE_SHOT);
+}
+
+static int serdes_update_mcb_s1g(struct regmap *regmap, u8 macro)
+{
+	return __serdes_write_mcb_s1g(regmap, macro,
+		HSIO_MCB_S1G_ADDR_CFG_SERDES1G_RD_ONE_SHOT);
+}
+
+static int serdes_init_s1g(struct regmap *regmap, u8 serdes)
+{
+	int ret;
+
+	ret = serdes_update_mcb_s1g(regmap, serdes);
+	if (ret)
+		return ret;
+
+	regmap_update_bits(regmap, HSIO_S1G_COMMON_CFG,
+			   HSIO_S1G_COMMON_CFG_SYS_RST |
+			   HSIO_S1G_COMMON_CFG_ENA_LANE |
+			   HSIO_S1G_COMMON_CFG_ENA_ELOOP |
+			   HSIO_S1G_COMMON_CFG_ENA_FLOOP,
+			   HSIO_S1G_COMMON_CFG_ENA_LANE);
+
+	regmap_update_bits(regmap, HSIO_S1G_PLL_CFG,
+			   HSIO_S1G_PLL_CFG_PLL_FSM_ENA |
+			   HSIO_S1G_PLL_CFG_PLL_FSM_CTRL_DATA_M,
+			   HSIO_S1G_PLL_CFG_PLL_FSM_CTRL_DATA(200) |
+			   HSIO_S1G_PLL_CFG_PLL_FSM_ENA);
+
+	regmap_update_bits(regmap, HSIO_S1G_MISC_CFG,
+			   HSIO_S1G_MISC_CFG_DES_100FX_CPMD_ENA |
+			   HSIO_S1G_MISC_CFG_LANE_RST,
+			   HSIO_S1G_MISC_CFG_LANE_RST);
+
+	ret = serdes_commit_mcb_s1g(regmap, serdes);
+	if (ret)
+		return ret;
+
+	regmap_update_bits(regmap, HSIO_S1G_COMMON_CFG,
+			   HSIO_S1G_COMMON_CFG_SYS_RST,
+			   HSIO_S1G_COMMON_CFG_SYS_RST);
+
+	regmap_update_bits(regmap, HSIO_S1G_MISC_CFG,
+			   HSIO_S1G_MISC_CFG_LANE_RST, 0);
+
+	ret = serdes_commit_mcb_s1g(regmap, serdes);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+struct serdes_mux {
+	u8			idx;
+	u8			port;
+	enum phy_mode		mode;
+	u32			mask;
+	u32			mux;
+};
+
+#define SERDES_MUX(_idx, _port, _mode, _mask, _mux) {		\
+	.idx = _idx,						\
+	.port = _port,						\
+	.mode = _mode,						\
+	.mask = _mask,						\
+	.mux = _mux,						\
+}
+
+#define SERDES_MUX_SGMII(i, p, m, c) SERDES_MUX(i, p, PHY_MODE_SGMII, m, c)
+#define SERDES_MUX_QSGMII(i, p, m, c) SERDES_MUX(i, p, PHY_MODE_QSGMII, m, c)
+
+static const struct serdes_mux ocelot_serdes_muxes[] = {
+	SERDES_MUX_SGMII(SERDES1G(0), 0, 0, 0),
+	SERDES_MUX_SGMII(SERDES1G(1), 1, HSIO_HW_CFG_DEV1G_5_MODE, 0),
+	SERDES_MUX_SGMII(SERDES1G(1), 5, HSIO_HW_CFG_QSGMII_ENA |
+			 HSIO_HW_CFG_DEV1G_5_MODE, HSIO_HW_CFG_DEV1G_5_MODE),
+	SERDES_MUX_SGMII(SERDES1G(2), 2, HSIO_HW_CFG_DEV1G_4_MODE, 0),
+	SERDES_MUX_SGMII(SERDES1G(2), 4, HSIO_HW_CFG_QSGMII_ENA |
+			 HSIO_HW_CFG_DEV1G_4_MODE, HSIO_HW_CFG_DEV1G_4_MODE),
+	SERDES_MUX_SGMII(SERDES1G(3), 3, HSIO_HW_CFG_DEV1G_6_MODE, 0),
+	SERDES_MUX_SGMII(SERDES1G(3), 6, HSIO_HW_CFG_QSGMII_ENA |
+			 HSIO_HW_CFG_DEV1G_6_MODE, HSIO_HW_CFG_DEV1G_6_MODE),
+	SERDES_MUX_SGMII(SERDES1G(4), 4, HSIO_HW_CFG_QSGMII_ENA |
+			 HSIO_HW_CFG_DEV1G_4_MODE | HSIO_HW_CFG_DEV1G_9_MODE,
+			 0),
+	SERDES_MUX_SGMII(SERDES1G(4), 9, HSIO_HW_CFG_DEV1G_4_MODE |
+			 HSIO_HW_CFG_DEV1G_9_MODE, HSIO_HW_CFG_DEV1G_4_MODE |
+			 HSIO_HW_CFG_DEV1G_9_MODE),
+	SERDES_MUX_SGMII(SERDES1G(5), 5, HSIO_HW_CFG_QSGMII_ENA |
+			 HSIO_HW_CFG_DEV1G_5_MODE | HSIO_HW_CFG_DEV2G5_10_MODE,
+			 0),
+	SERDES_MUX_SGMII(SERDES1G(5), 10, HSIO_HW_CFG_PCIE_ENA |
+			 HSIO_HW_CFG_DEV1G_5_MODE | HSIO_HW_CFG_DEV2G5_10_MODE,
+			 HSIO_HW_CFG_DEV1G_5_MODE | HSIO_HW_CFG_DEV2G5_10_MODE),
+	SERDES_MUX_QSGMII(SERDES6G(0), 4, HSIO_HW_CFG_QSGMII_ENA,
+			  HSIO_HW_CFG_QSGMII_ENA),
+	SERDES_MUX_QSGMII(SERDES6G(0), 5, HSIO_HW_CFG_QSGMII_ENA,
+			  HSIO_HW_CFG_QSGMII_ENA),
+	SERDES_MUX_QSGMII(SERDES6G(0), 6, HSIO_HW_CFG_QSGMII_ENA,
+			  HSIO_HW_CFG_QSGMII_ENA),
+	SERDES_MUX_SGMII(SERDES6G(0), 7, HSIO_HW_CFG_QSGMII_ENA, 0),
+	SERDES_MUX_QSGMII(SERDES6G(0), 7, HSIO_HW_CFG_QSGMII_ENA,
+			  HSIO_HW_CFG_QSGMII_ENA),
+	SERDES_MUX_SGMII(SERDES6G(1), 8, 0, 0),
+	SERDES_MUX_SGMII(SERDES6G(2), 10, HSIO_HW_CFG_PCIE_ENA |
+			 HSIO_HW_CFG_DEV2G5_10_MODE, 0),
+	SERDES_MUX(SERDES6G(2), 10, PHY_MODE_PCIE, HSIO_HW_CFG_PCIE_ENA,
+		   HSIO_HW_CFG_PCIE_ENA),
+};
+
+static int serdes_set_mode(struct phy *phy, enum phy_mode mode)
+{
+	struct serdes_macro *macro = phy_get_drvdata(phy);
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(ocelot_serdes_muxes); i++) {
+		if (macro->idx != ocelot_serdes_muxes[i].idx ||
+		    mode != ocelot_serdes_muxes[i].mode)
+			continue;
+
+		if (mode != PHY_MODE_QSGMII &&
+		    macro->port != ocelot_serdes_muxes[i].port)
+			continue;
+
+		ret = regmap_update_bits(macro->ctrl->regs, HSIO_HW_CFG,
+					 ocelot_serdes_muxes[i].mask,
+					 ocelot_serdes_muxes[i].mux);
+		if (ret)
+			return ret;
+
+		if (macro->idx <= SERDES1G_MAX)
+			return serdes_init_s1g(macro->ctrl->regs, macro->idx);
+
+		/* SERDES6G and PCIe not supported yet */
+		return -EOPNOTSUPP;
+	}
+
+	return -EINVAL;
+}
+
+static const struct phy_ops serdes_ops = {
+	.set_mode	= serdes_set_mode,
+	.owner		= THIS_MODULE,
+};
+
+static struct phy *serdes_simple_xlate(struct device *dev,
+				       struct of_phandle_args *args)
+{
+	struct serdes_ctrl *ctrl = dev_get_drvdata(dev);
+	unsigned int port, idx, i;
+
+	if (args->args_count != 2)
+		return ERR_PTR(-EINVAL);
+
+	port = args->args[0];
+	idx = args->args[1];
+
+	for (i = 0; i <= SERDES_MAX; i++) {
+		struct serdes_macro *macro = phy_get_drvdata(ctrl->phys[i]);
+
+		if (idx != macro->idx)
+			continue;
+
+		/* SERDES6G(0) is the only SerDes capable of QSGMII */
+		if (idx != SERDES6G(0) && macro->port >= 0)
+			return ERR_PTR(-EBUSY);
+
+		macro->port = port;
+		return ctrl->phys[i];
+	}
+
+	return ERR_PTR(-ENODEV);
+}
+
+static int serdes_phy_create(struct serdes_ctrl *ctrl, u8 idx, struct phy **phy)
+{
+	struct serdes_macro *macro;
+
+	*phy = devm_phy_create(ctrl->dev, NULL, &serdes_ops);
+	if (IS_ERR(*phy))
+		return PTR_ERR(*phy);
+
+	macro = devm_kzalloc(ctrl->dev, sizeof(*macro), GFP_KERNEL);
+	if (!macro)
+		return -ENOMEM;
+
+	macro->idx = idx;
+	macro->ctrl = ctrl;
+	macro->port = -1;
+
+	phy_set_drvdata(*phy, macro);
+
+	return 0;
+}
+
+static int serdes_probe(struct platform_device *pdev)
+{
+	struct phy_provider *provider;
+	struct serdes_ctrl *ctrl;
+	unsigned int i;
+	int ret;
+
+	ctrl = devm_kzalloc(&pdev->dev, sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
+	ctrl->dev = &pdev->dev;
+	ctrl->regs = syscon_node_to_regmap(pdev->dev.parent->of_node);
+	if (!ctrl->regs)
+		return -ENODEV;
+
+	for (i = 0; i <= SERDES_MAX; i++) {
+		ret = serdes_phy_create(ctrl, i, &ctrl->phys[i]);
+		if (ret)
+			return ret;
+	}
+
+	dev_set_drvdata(&pdev->dev, ctrl);
+
+	provider = devm_of_phy_provider_register(ctrl->dev,
+						 serdes_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(provider);
+}
+
+static const struct of_device_id serdes_ids[] = {
+	{ .compatible = "mscc,vsc7514-serdes", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, serdes_ids);
+
+static struct platform_driver mscc_ocelot_serdes = {
+	.probe		= serdes_probe,
+	.driver		= {
+		.name	= "mscc,ocelot-serdes",
+		.of_match_table = of_match_ptr(serdes_ids),
+	},
+};
+
+module_platform_driver(mscc_ocelot_serdes);
+
+MODULE_AUTHOR("Quentin Schulz <quentin.schulz@bootlin.com>");
+MODULE_DESCRIPTION("SerDes driver for Microsemi Ocelot");
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.17.1

