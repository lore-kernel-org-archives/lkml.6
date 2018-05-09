Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934878AbeEIMGN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 08:06:13 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:56654 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbeEIMGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 08:06:11 -0400
From: Dan Murphy <dmurphy@ti.com>
To: <andrew@lunn.ch>, <f.fainelli@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] net: phy: DP83TC811: Introduce support for the DP83TC811 phy
Date: Wed, 9 May 2018 07:05:59 -0500
Message-ID: <20180509120559.12725-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the DP83811 phy.

The DP83811 supports both rgmii and sgmii interfaces.
There are 2 part numbers for this the DP83TC811R does not
reliably support the SGMII interface but the DP83TC811S will.

There is not a way to differentiate these parts from the
hardware or register set.  So this is controlled via the DT
to indicate which phy mode is required.  Or the part can be
strapped to a certain interface.

Data sheet can be found here:
http://www.ti.com/product/DP83TC811S-Q1/description
http://www.ti.com/product/DP83TC811R-Q1/description

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/net/phy/Kconfig     |   5 +
 drivers/net/phy/Makefile    |   1 +
 drivers/net/phy/dp83tc811.c | 350 ++++++++++++++++++++++++++++++++++++
 3 files changed, 356 insertions(+)
 create mode 100644 drivers/net/phy/dp83tc811.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index bdfbabb86ee0..810140a9e114 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -285,6 +285,11 @@ config DP83822_PHY
 	---help---
 	  Supports the DP83822 PHY.
 
+config DP83TC811_PHY
+	tristate "Texas Instruments DP83TC822 PHY"
+	---help---
+	  Supports the DP83TC822 PHY.
+
 config DP83848_PHY
 	tristate "Texas Instruments DP83848 PHY"
 	---help---
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 01acbcb2c798..00445b61a9a8 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_CORTINA_PHY)	+= cortina.o
 obj-$(CONFIG_DAVICOM_PHY)	+= davicom.o
 obj-$(CONFIG_DP83640_PHY)	+= dp83640.o
 obj-$(CONFIG_DP83822_PHY)	+= dp83822.o
+obj-$(CONFIG_DP83TC811_PHY)	+= dp83tc811.o
 obj-$(CONFIG_DP83848_PHY)	+= dp83848.o
 obj-$(CONFIG_DP83867_PHY)	+= dp83867.o
 obj-$(CONFIG_FIXED_PHY)		+= fixed_phy.o
diff --git a/drivers/net/phy/dp83tc811.c b/drivers/net/phy/dp83tc811.c
new file mode 100644
index 000000000000..01cb0e246449
--- /dev/null
+++ b/drivers/net/phy/dp83tc811.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the Texas Instruments DP83TC811 PHY
+ *
+ * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ */
+
+#include <linux/ethtool.h>
+#include <linux/etherdevice.h>
+#include <linux/kernel.h>
+#include <linux/mii.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/phy.h>
+#include <linux/netdevice.h>
+
+#define DP83TC811_PHY_ID	0x2000a253
+#define DP83811_DEVADDR		0x1f
+
+#define MII_DP83811_SGMII_CTRL	0x09
+#define MII_DP83811_INT_STAT1	0x12
+#define MII_DP83811_INT_STAT2	0x13
+#define MII_DP83811_RESET_CTRL	0x1f
+
+#define DP83811_HW_RESET	BIT(15)
+#define DP83811_SW_RESET	BIT(14)
+
+/* INT_STAT1 bits */
+#define DP83811_RX_ERR_HF_INT_EN	BIT(0)
+#define DP83811_MS_TRAINING_INT_EN	BIT(1)
+#define DP83811_ANEG_COMPLETE_INT_EN	BIT(2)
+#define DP83811_ESD_EVENT_INT_EN	BIT(3)
+#define DP83811_WOL_INT_EN		BIT(4)
+#define DP83811_LINK_STAT_INT_EN	BIT(5)
+#define DP83811_ENERGY_DET_INT_EN	BIT(6)
+#define DP83811_LINK_QUAL_INT_EN	BIT(7)
+
+/* INT_STAT2 bits */
+#define DP83811_JABBER_DET_INT_EN	BIT(0)
+#define DP83811_POLARITY_INT_EN		BIT(1)
+#define DP83811_SLEEP_MODE_INT_EN	BIT(2)
+#define DP83811_OVERTEMP_INT_EN		BIT(3)
+#define DP83811_OVERVOLTAGE_INT_EN	BIT(6)
+#define DP83811_UNDERVOLTAGE_INT_EN	BIT(7)
+
+#define MII_DP83811_RXSOP1	0x04a5
+#define MII_DP83811_RXSOP2	0x04a6
+#define MII_DP83811_RXSOP3	0x04a7
+
+/* WoL Registers */
+#define MII_DP83811_WOL_CFG	0x04a0
+#define MII_DP83811_WOL_STAT	0x04a1
+#define MII_DP83811_WOL_DA1	0x04a2
+#define MII_DP83811_WOL_DA2	0x04a3
+#define MII_DP83811_WOL_DA3	0x04a4
+
+/* WoL bits */
+#define DP83811_WOL_MAGIC_EN	BIT(0)
+#define DP83811_WOL_SECURE_ON	BIT(5)
+#define DP83811_WOL_EN		BIT(7)
+#define DP83811_WOL_INDICATION_SEL BIT(8)
+#define DP83811_WOL_CLR_INDICATION BIT(11)
+
+/* SGMII CTRL bits */
+#define DP83811_TDR_AUTO		BIT(8)
+#define DP83811_SGMII_EN		BIT(12)
+#define DP83811_SGMII_AUTO_NEG_EN	BIT(13)
+#define DP83811_SGMII_TX_ERR_DIS	BIT(14)
+#define DP83811_SGMII_SOFT_RESET	BIT(15)
+
+static int dp83811_ack_interrupt(struct phy_device *phydev)
+{
+	int err;
+
+	err = phy_read(phydev, MII_DP83811_INT_STAT1);
+	if (err < 0)
+		return err;
+
+	err = phy_read(phydev, MII_DP83811_INT_STAT2);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int dp83811_set_wol(struct phy_device *phydev,
+			   struct ethtool_wolinfo *wol)
+{
+	struct net_device *ndev = phydev->attached_dev;
+	u16 value;
+	const u8 *mac;
+
+	if (wol->wolopts & (WAKE_MAGIC | WAKE_MAGICSECURE)) {
+		mac = (const u8 *)ndev->dev_addr;
+
+		if (!is_valid_ether_addr(mac))
+			return -EINVAL;
+
+		/* MAC addresses start with byte 5, but stored in mac[0].
+		 * 811 PHYs store bytes 4|5, 2|3, 0|1
+		 */
+		phy_write_mmd(phydev, DP83811_DEVADDR, MII_DP83811_WOL_DA1,
+			      (mac[1] << 8) | mac[0]);
+		phy_write_mmd(phydev, DP83811_DEVADDR, MII_DP83811_WOL_DA2,
+			      (mac[3] << 8) | mac[2]);
+		phy_write_mmd(phydev, DP83811_DEVADDR, MII_DP83811_WOL_DA3,
+			      (mac[5] << 8) | mac[4]);
+
+		value = phy_read_mmd(phydev, DP83811_DEVADDR,
+				     MII_DP83811_WOL_CFG);
+		if (wol->wolopts & WAKE_MAGIC)
+			value |= DP83811_WOL_MAGIC_EN;
+		else
+			value &= ~DP83811_WOL_MAGIC_EN;
+
+		if (wol->wolopts & WAKE_MAGICSECURE) {
+			phy_write_mmd(phydev, DP83811_DEVADDR,
+				      MII_DP83811_RXSOP1,
+				      (wol->sopass[1] << 8) | wol->sopass[0]);
+			phy_write_mmd(phydev, DP83811_DEVADDR,
+				      MII_DP83811_RXSOP2,
+				      (wol->sopass[3] << 8) | wol->sopass[2]);
+			phy_write_mmd(phydev, DP83811_DEVADDR,
+				      MII_DP83811_RXSOP3,
+				      (wol->sopass[5] << 8) | wol->sopass[4]);
+			value |= DP83811_WOL_SECURE_ON;
+		} else {
+			value &= ~DP83811_WOL_SECURE_ON;
+		}
+
+		value |= (DP83811_WOL_EN | DP83811_WOL_INDICATION_SEL |
+			  DP83811_WOL_CLR_INDICATION);
+		phy_write_mmd(phydev, DP83811_DEVADDR, MII_DP83811_WOL_CFG,
+			      value);
+	} else {
+		value = phy_read_mmd(phydev, DP83811_DEVADDR,
+				     MII_DP83811_WOL_CFG);
+		value &= ~DP83811_WOL_EN;
+		phy_write_mmd(phydev, DP83811_DEVADDR, MII_DP83811_WOL_CFG,
+			      value);
+	}
+
+	return 0;
+}
+
+static void dp83811_get_wol(struct phy_device *phydev,
+			    struct ethtool_wolinfo *wol)
+{
+	int value;
+	u16 sopass_val;
+
+	wol->supported = (WAKE_MAGIC | WAKE_MAGICSECURE);
+	wol->wolopts = 0;
+
+	value = phy_read_mmd(phydev, DP83811_DEVADDR, MII_DP83811_WOL_CFG);
+
+	if (value & DP83811_WOL_MAGIC_EN)
+		wol->wolopts |= WAKE_MAGIC;
+
+	if (value & DP83811_WOL_SECURE_ON) {
+		sopass_val = phy_read_mmd(phydev, DP83811_DEVADDR,
+					  MII_DP83811_RXSOP1);
+		wol->sopass[0] = (sopass_val & 0xff);
+		wol->sopass[1] = (sopass_val >> 8);
+
+		sopass_val = phy_read_mmd(phydev, DP83811_DEVADDR,
+					  MII_DP83811_RXSOP2);
+		wol->sopass[2] = (sopass_val & 0xff);
+		wol->sopass[3] = (sopass_val >> 8);
+
+		sopass_val = phy_read_mmd(phydev, DP83811_DEVADDR,
+					  MII_DP83811_RXSOP3);
+		wol->sopass[4] = (sopass_val & 0xff);
+		wol->sopass[5] = (sopass_val >> 8);
+
+		wol->wolopts |= WAKE_MAGICSECURE;
+	}
+
+	/* WoL is not enabled so set wolopts to 0 */
+	if (!(value & DP83811_WOL_EN))
+		wol->wolopts = 0;
+}
+
+static int dp83811_config_intr(struct phy_device *phydev)
+{
+	int misr_status;
+	int err;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		misr_status = phy_read(phydev, MII_DP83811_INT_STAT1);
+		if (misr_status < 0)
+			return misr_status;
+
+		misr_status |= (DP83811_RX_ERR_HF_INT_EN |
+				DP83811_MS_TRAINING_INT_EN |
+				DP83811_ANEG_COMPLETE_INT_EN |
+				DP83811_ESD_EVENT_INT_EN |
+				DP83811_WOL_INT_EN |
+				DP83811_LINK_STAT_INT_EN |
+				DP83811_ENERGY_DET_INT_EN |
+				DP83811_LINK_QUAL_INT_EN);
+
+		err = phy_write(phydev, MII_DP83811_INT_STAT1, misr_status);
+		if (err < 0)
+			return err;
+
+		misr_status = phy_read(phydev, MII_DP83811_INT_STAT2);
+		if (misr_status < 0)
+			return misr_status;
+
+		misr_status |= (DP83811_JABBER_DET_INT_EN |
+				DP83811_POLARITY_INT_EN |
+				DP83811_SLEEP_MODE_INT_EN |
+				DP83811_OVERTEMP_INT_EN |
+				DP83811_OVERVOLTAGE_INT_EN |
+				DP83811_UNDERVOLTAGE_INT_EN);
+
+		err = phy_write(phydev, MII_DP83811_INT_STAT2, misr_status);
+
+	} else {
+		err = phy_write(phydev, MII_DP83811_INT_STAT1, 0);
+		if (err < 0)
+			return err;
+
+		err = phy_write(phydev, MII_DP83811_INT_STAT1, 0);
+	}
+
+	return err;
+}
+
+static int dp83811_config_aneg(struct phy_device *phydev)
+{
+	int err;
+	int value;
+
+	value = phy_read(phydev, MII_DP83811_SGMII_CTRL);
+	if (phydev->autoneg == AUTONEG_ENABLE) {
+		err = phy_write(phydev, MII_DP83811_SGMII_CTRL,
+				(DP83811_SGMII_AUTO_NEG_EN | value));
+		if (err < 0)
+			return err;
+	} else {
+		err = phy_write(phydev, MII_DP83811_SGMII_CTRL,
+				(~DP83811_SGMII_AUTO_NEG_EN & value));
+		if (err < 0)
+			return err;
+	}
+
+	return genphy_config_aneg(phydev);
+}
+
+static int dp83811_config_init(struct phy_device *phydev)
+{
+	int err;
+	int value;
+
+	err = genphy_config_init(phydev);
+	if (err < 0)
+		return err;
+
+	if (phydev->interface == PHY_INTERFACE_MODE_SGMII) {
+		value = phy_read(phydev, MII_DP83811_SGMII_CTRL);
+		if (!(value & DP83811_SGMII_EN)) {
+			err = phy_write(phydev, MII_DP83811_SGMII_CTRL,
+					(DP83811_SGMII_EN | value));
+			if (err < 0)
+				return err;
+		} else {
+			err = phy_write(phydev, MII_DP83811_SGMII_CTRL,
+				(~DP83811_SGMII_EN & value));
+			if (err < 0)
+				return err;
+		}
+	}
+
+	value = DP83811_WOL_MAGIC_EN | DP83811_WOL_SECURE_ON | DP83811_WOL_EN;
+
+	return phy_write_mmd(phydev, DP83811_DEVADDR, MII_DP83811_WOL_CFG,
+	      value);
+}
+
+static int dp83811_phy_reset(struct phy_device *phydev)
+{
+	int err;
+
+	err = phy_write(phydev, MII_DP83811_RESET_CTRL, DP83811_HW_RESET);
+	if (err < 0)
+		return err;
+
+	dp83811_config_init(phydev);
+
+	return 0;
+}
+
+static int dp83811_suspend(struct phy_device *phydev)
+{
+	int value;
+
+	value = phy_read_mmd(phydev, DP83811_DEVADDR, MII_DP83811_WOL_CFG);
+
+	if (!(value & DP83811_WOL_EN))
+		genphy_suspend(phydev);
+
+	return 0;
+}
+
+static int dp83811_resume(struct phy_device *phydev)
+{
+	int value;
+
+	genphy_resume(phydev);
+
+	value = phy_read_mmd(phydev, DP83811_DEVADDR, MII_DP83811_WOL_CFG);
+
+	phy_write_mmd(phydev, DP83811_DEVADDR, MII_DP83811_WOL_CFG, value |
+		      DP83811_WOL_CLR_INDICATION);
+
+	return 0;
+}
+
+static struct phy_driver dp83811_driver[] = {
+	{
+		.phy_id = DP83TC811_PHY_ID,
+		.phy_id_mask = 0xfffffff0,
+		.name = "TI DP83TC811",
+		.features = PHY_BASIC_FEATURES,
+		.flags = PHY_HAS_INTERRUPT,
+		.config_init = genphy_config_init,
+		.config_aneg = dp83811_config_aneg,
+		.soft_reset = dp83811_phy_reset,
+		.get_wol = dp83811_get_wol,
+		.set_wol = dp83811_set_wol,
+		.ack_interrupt = dp83811_ack_interrupt,
+		.config_intr = dp83811_config_intr,
+		.suspend = dp83811_suspend,
+		.resume = dp83811_resume,
+	 },
+};
+module_phy_driver(dp83811_driver);
+
+static struct mdio_device_id __maybe_unused dp83811_tbl[] = {
+	{ DP83TC811_PHY_ID, 0xfffffff0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(mdio, dp83811_tbl);
+
+MODULE_DESCRIPTION("Texas Instruments DP83TC811 PHY driver");
+MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com");
+MODULE_LICENSE("GPL");
-- 
2.17.0.582.gccdcbd54c
