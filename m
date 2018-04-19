Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeDSIeV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 04:34:21 -0400
Received: from imail.nibe.se ([193.218.206.193]:13646 "EHLO imail.nibe.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750913AbeDSIeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 04:34:15 -0400
X-IronPort-AV: E=Sophos;i="5.48,468,1517871600";
   d="scan'208";a="18987717"
From: =?UTF-8?q?M=C3=A5ns=20Andersson?= <mans.andersson@nibe.se>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Mans Andersson <mans.andersson@nibe.se>
Subject: [PATCH] net: phy: TLK10X initial driver submission
Date: Thu, 19 Apr 2018 10:28:16 +0200
Message-ID: <20180419082816.109338-1-mans.andersson@nibe.se>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-C2ProcessedOrg: 0e72f327-13a8-401d-baac-ca43efdc4f0c
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mans Andersson <mans.andersson@nibe.se>

Add suport for the TI TLK105 and TLK106 10/100Mbit ethernet phys.

In addition the TLK10X needs to be removed from DP83848 driver as the
power back off support is added here for this device.

Datasheet:
http://www.ti.com/lit/gpn/tlk106
---
 .../devicetree/bindings/net/ti,tlk10x.txt          |  27 +++
 drivers/net/phy/Kconfig                            |   5 +
 drivers/net/phy/Makefile                           |   1 +
 drivers/net/phy/dp83848.c                          |   3 -
 drivers/net/phy/tlk10x.c                           | 209 +++++++++++++++++++++
 5 files changed, 242 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/ti,tlk10x.txt
 create mode 100644 drivers/net/phy/tlk10x.c

diff --git a/Documentation/devicetree/bindings/net/ti,tlk10x.txt b/Documentation/devicetree/bindings/net/ti,tlk10x.txt
new file mode 100644
index 0000000..371d0d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ti,tlk10x.txt
@@ -0,0 +1,27 @@
+* Texas Instruments - TLK105 / TLK106 ethernet PHYs
+
+Required properties:
+	- reg - The ID number for the phy, usually a small integer
+
+Optional properties:
+	- ti,power-back-off - Power Back Off Level
+		Please refer to data sheet chapter 8.6 and TI Application
+		Note SLLA3228
+		0 - Normal Operation
+		1 - Level 1 (up to 140m cable between TLK link partners)
+		2 - Level 2 (up to 100m cable between TLK link partners)
+		3 - Level 3 (up to 80m cable between TLK link partners)
+
+Default child nodes are standard Ethernet PHY device
+nodes as described in Documentation/devicetree/bindings/net/phy.txt
+
+Example:
+
+	ethernet-phy@0 {
+		reg = <0>;
+		ti,power-back-off = <2>;
+	};
+
+Datasheets and documentation can be found at:
+http://www.ti.com/lit/gpn/tlk106
+http://www.ti.com/lit/an/slla328/slla328.pdf
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index bdfbabb..c980240 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -295,6 +295,11 @@ config DP83867_PHY
 	---help---
 	  Currently supports the DP83867 PHY.
 
+config TLK10X_PHY
+	tristate "Texas Instruments TLK10x PHY"
+	---help---
+	  Supports the TLK105 and TLK106 PHYs.
+
 config FIXED_PHY
 	tristate "MDIO Bus/PHY emulation with fixed speed/link PHYs"
 	depends on PHYLIB
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 01acbcb..37e4e02 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -79,5 +79,6 @@ obj-$(CONFIG_ROCKCHIP_PHY)	+= rockchip.o
 obj-$(CONFIG_SMSC_PHY)		+= smsc.o
 obj-$(CONFIG_STE10XP)		+= ste10Xp.o
 obj-$(CONFIG_TERANETICS_PHY)	+= teranetics.o
+obj-$(CONFIG_TLK10X_PHY)	+= tlk10x.o
 obj-$(CONFIG_VITESSE_PHY)	+= vitesse.o
 obj-$(CONFIG_XILINX_GMII2RGMII) += xilinx_gmii2rgmii.o
diff --git a/drivers/net/phy/dp83848.c b/drivers/net/phy/dp83848.c
index cd09c3a..435f401 100644
--- a/drivers/net/phy/dp83848.c
+++ b/drivers/net/phy/dp83848.c
@@ -19,7 +19,6 @@
 #define TI_DP83848C_PHY_ID		0x20005ca0
 #define TI_DP83620_PHY_ID		0x20005ce0
 #define NS_DP83848C_PHY_ID		0x20005c90
-#define TLK10X_PHY_ID			0x2000a210
 
 /* Registers */
 #define DP83848_MICR			0x11 /* MII Interrupt Control Register */
@@ -78,7 +77,6 @@ static struct mdio_device_id __maybe_unused dp83848_tbl[] = {
 	{ TI_DP83848C_PHY_ID, 0xfffffff0 },
 	{ NS_DP83848C_PHY_ID, 0xfffffff0 },
 	{ TI_DP83620_PHY_ID, 0xfffffff0 },
-	{ TLK10X_PHY_ID, 0xfffffff0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(mdio, dp83848_tbl);
@@ -105,7 +103,6 @@ static struct phy_driver dp83848_driver[] = {
 	DP83848_PHY_DRIVER(TI_DP83848C_PHY_ID, "TI DP83848C 10/100 Mbps PHY"),
 	DP83848_PHY_DRIVER(NS_DP83848C_PHY_ID, "NS DP83848C 10/100 Mbps PHY"),
 	DP83848_PHY_DRIVER(TI_DP83620_PHY_ID, "TI DP83620 10/100 Mbps PHY"),
-	DP83848_PHY_DRIVER(TLK10X_PHY_ID, "TI TLK10X 10/100 Mbps PHY"),
 };
 module_phy_driver(dp83848_driver);
 
diff --git a/drivers/net/phy/tlk10x.c b/drivers/net/phy/tlk10x.c
new file mode 100644
index 0000000..1efc81e
--- /dev/null
+++ b/drivers/net/phy/tlk10x.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * Driver for the Texas Instruments TLK105 / TLK106
+ *
+ * Copyright (C) 2018 NIBE Industrier AB - http://www.nibe.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/phy.h>
+#include <linux/of.h>
+
+#define TLK10X_PHY_ID			0x2000a210
+
+/* Registers */
+#define TLK10X_MICR			0x11 /* MII Interrupt Control Reg */
+#define TLK10X_MISR			0x12 /* MII Interrupt Status Reg */
+#define TLK10X_REGCR			0x0d /* Register Control Register */
+#define TLK10X_ADDAR			0x0e /* Data Register */
+#define TLK10X_PWRBOCR			0xae /* Power Backoff Register */
+
+/* MICR Register Fields */
+#define TLK10X_MICR_INT_OE		BIT(0) /* Interrupt Output Enable */
+#define TLK10X_MICR_INTEN		BIT(1) /* Interrupt Enable */
+
+/* MISR Register Fields */
+#define TLK10X_MISR_RHF_INT_EN		BIT(0) /* Receive Error Counter */
+#define TLK10X_MISR_FHF_INT_EN		BIT(1) /* False Carrier Counter */
+#define TLK10X_MISR_ANC_INT_EN		BIT(2) /* Auto-negotiation complete */
+#define TLK10X_MISR_DUP_INT_EN		BIT(3) /* Duplex Status */
+#define TLK10X_MISR_SPD_INT_EN		BIT(4) /* Speed status */
+#define TLK10X_MISR_LINK_INT_EN		BIT(5) /* Link status */
+#define TLK10X_MISR_ED_INT_EN		BIT(6) /* Energy detect */
+#define TLK10X_MISR_LQM_INT_EN		BIT(7) /* Link Quality Monitor */
+
+/* PWRBOCR Register Fields */
+#define TLK10X_PWRBOCR_MASK		0xe0 /* Power Backoff Mask */
+
+#define TLK10X_INT_EN_MASK		\
+	(TLK10X_MISR_ANC_INT_EN |	\
+	 TLK10X_MISR_DUP_INT_EN |	\
+	 TLK10X_MISR_SPD_INT_EN |	\
+	 TLK10X_MISR_LINK_INT_EN)
+
+struct tlk10x_private {
+	int pwrbo_level;
+};
+
+static int tlk10x_read(struct phy_device *phydev, int reg)
+{
+	if (reg & ~0x1f) {
+		/* Extended register */
+		phy_write(phydev, TLK10X_REGCR, 0x001F);
+		phy_write(phydev, TLK10X_ADDAR, reg);
+		phy_write(phydev, TLK10X_REGCR, 0x401F);
+		reg = TLK10X_ADDAR;
+	}
+
+	return phy_read(phydev, reg);
+}
+
+static int tlk10x_write(struct phy_device *phydev, int reg, int val)
+{
+	if (reg & ~0x1f) {
+		/* Extended register */
+		phy_write(phydev, TLK10X_REGCR, 0x001F);
+		phy_write(phydev, TLK10X_ADDAR, reg);
+		phy_write(phydev, TLK10X_REGCR, 0x401F);
+		reg = TLK10X_ADDAR;
+	}
+
+	return phy_write(phydev, reg, val);
+}
+
+#ifdef CONFIG_OF_MDIO
+static int tlk10x_of_init(struct phy_device *phydev)
+{
+	struct tlk10x_private *tlk10x = phydev->priv;
+	struct device *dev = &phydev->mdio.dev;
+	struct device_node *of_node = dev->of_node;
+	int ret;
+
+	if (!of_node)
+		return 0;
+
+	ret = of_property_read_u32(of_node, "ti,power-back-off",
+				   &tlk10x->pwrbo_level);
+	if (ret) {
+		dev_err(dev, "missing ti,power-back-off property");
+		tlk10x->pwrbo_level = 0;
+	}
+
+	return 0;
+}
+#else
+static int tlk10x_of_init(struct phy_device *phydev)
+{
+	return 0;
+}
+#endif /* CONFIG_OF_MDIO */
+
+static int tlk10x_config_init(struct phy_device *phydev)
+{
+	int ret, reg;
+	struct tlk10x_private *tlk10x;
+
+	ret = genphy_config_init(phydev);
+	if (ret < 0)
+		return ret;
+
+	if (!phydev->priv) {
+		tlk10x = devm_kzalloc(&phydev->mdio.dev, sizeof(*tlk10x),
+				      GFP_KERNEL);
+		if (!tlk10x)
+			return -ENOMEM;
+
+		phydev->priv = tlk10x;
+		ret = tlk10x_of_init(phydev);
+		if (ret)
+			return ret;
+	} else {
+		tlk10x = (struct tlk10x_private *)phydev->priv;
+	}
+
+	// Power back off
+	if (tlk10x->pwrbo_level < 0 || tlk10x->pwrbo_level > 3)
+		tlk10x->pwrbo_level = 0;
+	reg = tlk10x_read(phydev, TLK10X_PWRBOCR);
+	reg = ((reg & ~TLK10X_PWRBOCR_MASK)
+		| (tlk10x->pwrbo_level << 6));
+	ret = tlk10x_write(phydev, TLK10X_PWRBOCR, reg);
+	if (ret < 0) {
+		dev_err(&phydev->mdio.dev,
+			"unable to set power back-off (err=%d)\n", ret);
+		return ret;
+	}
+	dev_info(&phydev->mdio.dev, "power back-off set to level %d\n",
+		 tlk10x->pwrbo_level);
+
+	return 0;
+}
+
+static int tlk10x_ack_interrupt(struct phy_device *phydev)
+{
+	int err = tlk10x_read(phydev, TLK10X_MISR);
+
+	return err < 0 ? err : 0;
+}
+
+static int tlk10x_config_intr(struct phy_device *phydev)
+{
+	int control, ret;
+
+	control = tlk10x_read(phydev, TLK10X_MICR);
+	if (control < 0)
+		return control;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		control |= TLK10X_MICR_INT_OE;
+		control |= TLK10X_MICR_INTEN;
+
+		ret = tlk10x_write(phydev, TLK10X_MISR, TLK10X_INT_EN_MASK);
+		if (ret < 0)
+			return ret;
+	} else {
+		control &= ~TLK10X_MICR_INTEN;
+	}
+
+	return tlk10x_write(phydev, TLK10X_MICR, control);
+}
+
+static struct phy_driver tlk10x_driver[] = {
+	{
+		.phy_id		= TLK10X_PHY_ID,
+		.phy_id_mask	= 0xfffffff0,
+		.name		= "TI TLK10X 10/100 Mbps PHY",
+		.features	= PHY_BASIC_FEATURES,
+		.flags		= PHY_HAS_INTERRUPT,
+
+		.config_init	= tlk10x_config_init,
+		.soft_reset	= genphy_soft_reset,
+
+		/* IRQ related */
+		.ack_interrupt	= tlk10x_ack_interrupt,
+		.config_intr	= tlk10x_config_intr,
+
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+	},
+};
+module_phy_driver(tlk10x_driver);
+
+static struct mdio_device_id __maybe_unused tlk10x_tbl[] = {
+	{ TLK10X_PHY_ID, 0xfffffff0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(mdio, tlk10x_tbl);
+
+MODULE_DESCRIPTION("Texas Instruments TLK105 / TLK106 PHY driver");
+MODULE_AUTHOR("Mans Andersson <mans.andersson@nibe.se>");
+MODULE_LICENSE("GPL");
-- 
2.9.3
