Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AE9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA332081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA332081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438887AbeKWHpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 02:45:36 -0500
Received: from mail.bootlin.com ([62.4.15.54]:39403 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438829AbeKWHpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 02:45:33 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AE63720DB0; Thu, 22 Nov 2018 22:04:24 +0100 (CET)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id E025120DBF;
        Thu, 22 Nov 2018 22:04:23 +0100 (CET)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Evan Wang <xswang@marvell.com>
Subject: [PATCH 2/6] phy: add A3700 COMPHY support
Date:   Thu, 22 Nov 2018 22:04:16 +0100
Message-Id: <20181122210420.14861-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122210420.14861-1-miquel.raynal@bootlin.com>
References: <20181122210420.14861-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver to support COMPHY, a hardware block providing shared
serdes PHYs on Marvell Armada 3700. This driver uses SMC calls and
rely on having an up-to-date firmware.

SATA, PCie and USB3 host mode have been tested successfully with an
ESPRESSObin. SGMII mode cannot be tested with this platform.

Co-Developed-by: Evan Wang <xswang@marvell.com>
Signed-off-by: Evan Wang <xswang@marvell.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/phy/marvell/Kconfig                  |  10 +
 drivers/phy/marvell/Makefile                 |   1 +
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 276 +++++++++++++++++++
 3 files changed, 287 insertions(+)
 create mode 100644 drivers/phy/marvell/phy-mvebu-a3700-comphy.c

diff --git a/drivers/phy/marvell/Kconfig b/drivers/phy/marvell/Kconfig
index 6fb4b56e4c14..f0c39439f06e 100644
--- a/drivers/phy/marvell/Kconfig
+++ b/drivers/phy/marvell/Kconfig
@@ -21,6 +21,16 @@ config PHY_BERLIN_USB
 	help
 	  Enable this to support the USB PHY on Marvell Berlin SoCs.
 
+config PHY_MVEBU_A3700_COMPHY
+	tristate "Marvell A3700 comphy driver"
+	depends on ARCH_MVEBU || COMPILE_TEST
+	depends on OF
+	select GENERIC_PHY
+	help
+	  This driver allows to control the comphy, a hardware block providing
+	  shared serdes PHYs on Marvell Armada 3700. Its serdes lanes can be
+	  used by various controllers: Ethernet, SATA, USB3, PCIe.
+
 config PHY_MVEBU_CP110_COMPHY
 	tristate "Marvell CP110 comphy driver"
 	depends on ARCH_MVEBU || COMPILE_TEST
diff --git a/drivers/phy/marvell/Makefile b/drivers/phy/marvell/Makefile
index 3975b144f8ec..c13a0c8ab6f0 100644
--- a/drivers/phy/marvell/Makefile
+++ b/drivers/phy/marvell/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_ARMADA375_USBCLUSTER_PHY)	+= phy-armada375-usb2.o
 obj-$(CONFIG_PHY_BERLIN_SATA)		+= phy-berlin-sata.o
 obj-$(CONFIG_PHY_BERLIN_USB)		+= phy-berlin-usb.o
+obj-$(CONFIG_PHY_MVEBU_A3700_COMPHY)	+= phy-mvebu-a3700-comphy.o
 obj-$(CONFIG_PHY_MVEBU_CP110_COMPHY)	+= phy-mvebu-cp110-comphy.o
 obj-$(CONFIG_PHY_MVEBU_SATA)		+= phy-mvebu-sata.o
 obj-$(CONFIG_PHY_PXA_28NM_HSIC)		+= phy-pxa-28nm-hsic.o
diff --git a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
new file mode 100644
index 000000000000..cc815cf55a0c
--- /dev/null
+++ b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Marvell
+ *
+ * Authors:
+ *   Evan Wang <xswang@marvell.com>
+ *   Miquèl Raynal <miquel.raynal@bootlin.com>
+ *
+ * Inspired from phy-mvebu-cp110-comphy.c written by Antoine Tenart.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+
+#define MVEBU_A3700_COMPHY_LANES		3
+#define MVEBU_A3700_COMPHY_PORTS		2
+
+/* COMPHY Fast SMC function identifiers */
+#define COMPHY_SIP_POWER_ON			0x82000001
+#define COMPHY_SIP_POWER_OFF			0x82000002
+#define COMPHY_SIP_PLL_LOCK			0x82000003
+
+#define COMPHY_FW_MODE_SATA			0x1
+#define COMPHY_FW_MODE_SGMII			0x2
+#define COMPHY_FW_MODE_HS_SGMII			0x3
+#define COMPHY_FW_MODE_USB3H			0x4
+#define COMPHY_FW_MODE_USB3D			0x5
+#define COMPHY_FW_MODE_PCIE			0x6
+#define COMPHY_FW_MODE_RXAUI			0x7
+#define COMPHY_FW_MODE_XFI			0x8
+#define COMPHY_FW_MODE_SFI			0x9
+#define COMPHY_FW_MODE_USB3			0xa
+
+#define COMPHY_FW_SPEED_1_25G			0 /* SGMII 1G */
+#define COMPHY_FW_SPEED_2_5G			1
+#define COMPHY_FW_SPEED_3_125G			2 /* SGMII 2.5G */
+#define COMPHY_FW_SPEED_5G			3
+#define COMPHY_FW_SPEED_5_15625G		4 /* XFI 5G */
+#define COMPHY_FW_SPEED_6G			5
+#define COMPHY_FW_SPEED_10_3125G		6 /* XFI 10G */
+#define COMPHY_FW_SPEED_MAX			0x3F
+
+#define COMPHY_FW_MODE(mode)			((mode) << 12)
+#define COMPHY_FW_NET(mode, idx, speed)		(COMPHY_FW_MODE(mode) | \
+						 ((idx) << 8) |	\
+						 ((speed) << 2))
+#define COMPHY_FW_PCIE(mode, idx, speed, width)	(COMPHY_FW_NET(mode, idx, speed) | \
+						 ((width) << 18))
+
+struct mvebu_a3700_comphy_conf {
+	unsigned int lane;
+	enum phy_mode mode;
+	unsigned int port;
+	u32 fw_mode;
+};
+
+#define MVEBU_A3700_COMPHY_CONF(_lane, _mode, _port, _fw_mode)	\
+	{							\
+		.lane = _lane,					\
+		.mode = _mode,					\
+		.port = _port,					\
+		.fw_mode = _fw_mode,				\
+	}
+
+static const struct mvebu_a3700_comphy_conf mvebu_a3700_comphy_modes[] = {
+	/* lane 0 */
+	MVEBU_A3700_COMPHY_CONF(0, PHY_MODE_USB_HOST_SS, 0, COMPHY_FW_MODE_USB3H),
+	MVEBU_A3700_COMPHY_CONF(0, PHY_MODE_SGMII, 1, COMPHY_FW_MODE_SGMII),
+	/* lane 1 */
+	MVEBU_A3700_COMPHY_CONF(1, PHY_MODE_PCIE, 0, COMPHY_FW_MODE_PCIE),
+	MVEBU_A3700_COMPHY_CONF(1, PHY_MODE_SGMII, 0, COMPHY_FW_MODE_SGMII),
+	/* lane 2 */
+	MVEBU_A3700_COMPHY_CONF(2, PHY_MODE_SATA, 0, COMPHY_FW_MODE_SATA),
+	MVEBU_A3700_COMPHY_CONF(2, PHY_MODE_USB_HOST_SS, 0, COMPHY_FW_MODE_USB3H),
+};
+
+struct mvebu_a3700_comphy_lane {
+	struct device *dev;
+	unsigned int id;
+	enum phy_mode mode;
+	int port;
+};
+
+static int mvebu_a3700_comphy_smc(unsigned long function, unsigned long lane,
+				  unsigned long mode)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(function, lane, mode, 0, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
+static int mvebu_a3700_comphy_get_fw_mode(int lane, int port,
+					  enum phy_mode mode)
+{
+	int i, n = ARRAY_SIZE(mvebu_a3700_comphy_modes);
+
+	/* Unused PHY mux value is 0x0 */
+	if (mode == PHY_MODE_INVALID)
+		return -EINVAL;
+
+	for (i = 0; i < n; i++) {
+		if (mvebu_a3700_comphy_modes[i].lane == lane &&
+		    mvebu_a3700_comphy_modes[i].port == port &&
+		    mvebu_a3700_comphy_modes[i].mode == mode)
+			break;
+	}
+
+	if (i == n)
+		return -EINVAL;
+
+	return mvebu_a3700_comphy_modes[i].fw_mode;
+}
+
+static int mvebu_a3700_comphy_set_mode(struct phy *phy, enum phy_mode mode)
+{
+	struct mvebu_a3700_comphy_lane *lane = phy_get_drvdata(phy);
+	int fw_mode;
+
+	fw_mode = mvebu_a3700_comphy_get_fw_mode(lane->id, lane->port, mode);
+	if (fw_mode < 0) {
+		dev_err(lane->dev, "invalid COMPHY mode\n");
+		return fw_mode;
+	}
+
+	/* Just remember the mode, ->power_on() will do the real setup */
+	lane->mode = mode;
+
+	return 0;
+}
+
+static int mvebu_a3700_comphy_power_on(struct phy *phy)
+{
+	struct mvebu_a3700_comphy_lane *lane = phy_get_drvdata(phy);
+	u32 fw_param;
+	int fw_mode;
+
+	fw_mode = mvebu_a3700_comphy_get_fw_mode(lane->id, lane->port,
+						 lane->mode);
+	if (fw_mode < 0) {
+		dev_err(lane->dev, "invalid COMPHY mode\n");
+		return fw_mode;
+	}
+
+	switch (lane->mode) {
+	case PHY_MODE_USB_HOST_SS:
+		dev_dbg(lane->dev, "set lane %d to USB3 host mode\n", lane->id);
+		fw_param = COMPHY_FW_MODE(fw_mode);
+		break;
+	case PHY_MODE_SATA:
+		dev_dbg(lane->dev, "set lane %d to SATA mode\n", lane->id);
+		fw_param = COMPHY_FW_MODE(fw_mode);
+		break;
+	case PHY_MODE_SGMII:
+		dev_dbg(lane->dev, "set lane %d to SGMII mode\n", lane->id);
+		fw_param = COMPHY_FW_NET(fw_mode, lane->port,
+					 COMPHY_FW_SPEED_1_25G);
+		break;
+	case PHY_MODE_PCIE:
+		dev_dbg(lane->dev, "set lane %d to PCIe mode\n", lane->id);
+		fw_param = COMPHY_FW_PCIE(fw_mode, lane->port,
+					  COMPHY_FW_SPEED_5G,
+					  phy->attrs.bus_width);
+		break;
+	default:
+		dev_err(lane->dev, "unsupported PHY mode (%d)\n", lane->mode);
+		return -ENOTSUPP;
+	}
+
+	return mvebu_a3700_comphy_smc(COMPHY_SIP_POWER_ON, lane->id, fw_param);
+}
+
+static int mvebu_a3700_comphy_power_off(struct phy *phy)
+{
+	struct mvebu_a3700_comphy_lane *lane = phy_get_drvdata(phy);
+
+	return mvebu_a3700_comphy_smc(COMPHY_SIP_POWER_OFF, lane->id, 0);
+}
+
+static const struct phy_ops mvebu_a3700_comphy_ops = {
+	.power_on	= mvebu_a3700_comphy_power_on,
+	.power_off	= mvebu_a3700_comphy_power_off,
+	.set_mode	= mvebu_a3700_comphy_set_mode,
+	.owner		= THIS_MODULE,
+};
+
+static struct phy *mvebu_a3700_comphy_xlate(struct device *dev,
+					    struct of_phandle_args *args)
+{
+	struct mvebu_a3700_comphy_lane *lane;
+	struct phy *phy;
+
+	if (WARN_ON(args->args[0] >= MVEBU_A3700_COMPHY_PORTS))
+		return ERR_PTR(-EINVAL);
+
+	phy = of_phy_simple_xlate(dev, args);
+	if (IS_ERR(phy))
+		return phy;
+
+	lane = phy_get_drvdata(phy);
+	if (lane->port >= 0)
+		return ERR_PTR(-EBUSY);
+
+	lane->port = args->args[0];
+
+	return phy;
+}
+
+static int mvebu_a3700_comphy_probe(struct platform_device *pdev)
+{
+	struct phy_provider *provider;
+	struct device_node *child;
+
+	for_each_available_child_of_node(pdev->dev.of_node, child) {
+		struct mvebu_a3700_comphy_lane *lane;
+		struct phy *phy;
+		int ret;
+		u32 lane_id;
+
+		ret = of_property_read_u32(child, "reg", &lane_id);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "missing 'reg' property (%d)\n",
+				ret);
+			continue;
+		}
+
+		if (lane_id >= MVEBU_A3700_COMPHY_LANES) {
+			dev_err(&pdev->dev, "invalid 'reg' property\n");
+			continue;
+		}
+
+		lane = devm_kzalloc(&pdev->dev, sizeof(*lane), GFP_KERNEL);
+		if (!lane)
+			return -ENOMEM;
+
+		phy = devm_phy_create(&pdev->dev, child,
+				      &mvebu_a3700_comphy_ops);
+		if (IS_ERR(phy))
+			return PTR_ERR(phy);
+
+		lane->dev = &pdev->dev;
+		lane->mode = PHY_MODE_INVALID;
+		lane->id = lane_id;
+		lane->port = -1;
+		phy_set_drvdata(phy, lane);
+	}
+
+	provider = devm_of_phy_provider_register(&pdev->dev,
+						 mvebu_a3700_comphy_xlate);
+	return PTR_ERR_OR_ZERO(provider);
+}
+
+static const struct of_device_id mvebu_a3700_comphy_of_match_table[] = {
+	{ .compatible = "marvell,comphy-a3700" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, mvebu_a3700_comphy_of_match_table);
+
+static struct platform_driver mvebu_a3700_comphy_driver = {
+	.probe	= mvebu_a3700_comphy_probe,
+	.driver	= {
+		.name = "mvebu-a3700-comphy",
+		.of_match_table = mvebu_a3700_comphy_of_match_table,
+	},
+};
+module_platform_driver(mvebu_a3700_comphy_driver);
+
+MODULE_AUTHOR("Miquèl Raynal <miquel.raynal@bootlin.com>");
+MODULE_DESCRIPTION("Common PHY driver for A3700");
+MODULE_LICENSE("GPL v2");
-- 
2.19.1

