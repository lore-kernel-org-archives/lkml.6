Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BD2C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D214F21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfBGJvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:51:00 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:57399 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfBGJuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:50:14 -0500
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 92561100020;
        Thu,  7 Feb 2019 09:50:08 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next v2 05/10] net: phy: Extract genphy_c45_pma_read_abilities from marvell10g
Date:   Thu,  7 Feb 2019 10:49:34 +0100
Message-Id: <20190207094939.27369-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marvell 10G PHY driver has a generic way of initializing the supported
link modes by reading the PHY's C45 PMA abilities. This can be made
generic, since these registers are part of the 802.3 specifications.

This commit extracts the config_init link_mode initialization code from
marvell10g and uses it to introduce the genphy_c45_pma_read_abilities
function.

Only PMA modes are read, it's still up to the caller to set the Pause
parameters.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V1 -> V2: The Pause parameters setting stays in marvell10g. Make use of
	  linkmode_mod_bit. Renamed the function from
	  genphy_c45_read_abilities to genphy_c45_pma_read_abilities, as
	  advised by Andrew.

 drivers/net/phy/marvell10g.c | 78 ++++--------------------------------
 drivers/net/phy/phy-c45.c    | 74 ++++++++++++++++++++++++++++++++++
 include/linux/phy.h          |  1 +
 3 files changed, 83 insertions(+), 70 deletions(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 296a537cdfcb..07df87b81369 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -234,8 +234,7 @@ static int mv3310_resume(struct phy_device *phydev)
 
 static int mv3310_config_init(struct phy_device *phydev)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
-	int val;
+	int ret, val;
 
 	/* Check that the PHY interface type is compatible */
 	if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
@@ -244,8 +243,8 @@ static int mv3310_config_init(struct phy_device *phydev)
 	    phydev->interface != PHY_INTERFACE_MODE_10GKR)
 		return -ENODEV;
 
-	__set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
-	__set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, supported);
+	__set_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydev->supported);
+	__set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, phydev->supported);
 
 	if (phydev->c45_ids.devices_in_package & MDIO_DEVS_AN) {
 		val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_STAT1);
@@ -253,74 +252,13 @@ static int mv3310_config_init(struct phy_device *phydev)
 			return val;
 
 		if (val & MDIO_AN_STAT1_ABLE)
-			__set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, supported);
+			__set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				  phydev->supported);
 	}
 
-	val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_STAT2);
-	if (val < 0)
-		return val;
-
-	/* Ethtool does not support the WAN mode bits */
-	if (val & (MDIO_PMA_STAT2_10GBSR | MDIO_PMA_STAT2_10GBLR |
-		   MDIO_PMA_STAT2_10GBER | MDIO_PMA_STAT2_10GBLX4 |
-		   MDIO_PMA_STAT2_10GBSW | MDIO_PMA_STAT2_10GBLW |
-		   MDIO_PMA_STAT2_10GBEW))
-		__set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, supported);
-	if (val & MDIO_PMA_STAT2_10GBSR)
-		__set_bit(ETHTOOL_LINK_MODE_10000baseSR_Full_BIT, supported);
-	if (val & MDIO_PMA_STAT2_10GBLR)
-		__set_bit(ETHTOOL_LINK_MODE_10000baseLR_Full_BIT, supported);
-	if (val & MDIO_PMA_STAT2_10GBER)
-		__set_bit(ETHTOOL_LINK_MODE_10000baseER_Full_BIT, supported);
-
-	if (val & MDIO_PMA_STAT2_EXTABLE) {
-		val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_EXTABLE);
-		if (val < 0)
-			return val;
-
-		if (val & (MDIO_PMA_EXTABLE_10GBT | MDIO_PMA_EXTABLE_1000BT |
-			   MDIO_PMA_EXTABLE_100BTX | MDIO_PMA_EXTABLE_10BT))
-			__set_bit(ETHTOOL_LINK_MODE_TP_BIT, supported);
-		if (val & MDIO_PMA_EXTABLE_10GBLRM)
-			__set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, supported);
-		if (val & (MDIO_PMA_EXTABLE_10GBKX4 | MDIO_PMA_EXTABLE_10GBKR |
-			   MDIO_PMA_EXTABLE_1000BKX))
-			__set_bit(ETHTOOL_LINK_MODE_Backplane_BIT, supported);
-		if (val & MDIO_PMA_EXTABLE_10GBLRM)
-			__set_bit(ETHTOOL_LINK_MODE_10000baseLRM_Full_BIT,
-				  supported);
-		if (val & MDIO_PMA_EXTABLE_10GBT)
-			__set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
-				  supported);
-		if (val & MDIO_PMA_EXTABLE_10GBKX4)
-			__set_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
-				  supported);
-		if (val & MDIO_PMA_EXTABLE_10GBKR)
-			__set_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
-				  supported);
-		if (val & MDIO_PMA_EXTABLE_1000BT)
-			__set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
-				  supported);
-		if (val & MDIO_PMA_EXTABLE_1000BKX)
-			__set_bit(ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
-				  supported);
-		if (val & MDIO_PMA_EXTABLE_100BTX) {
-			__set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
-				  supported);
-			__set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
-				  supported);
-		}
-		if (val & MDIO_PMA_EXTABLE_10BT) {
-			__set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
-				  supported);
-			__set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
-				  supported);
-		}
-	}
-
-	linkmode_copy(phydev->supported, supported);
-	linkmode_and(phydev->advertising, phydev->advertising,
-		     phydev->supported);
+	ret = genphy_c45_pma_read_abilities(phydev);
+	if (ret)
+		return ret;
 
 	return 0;
 }
diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index c92d0fb7ec4f..32e72b170ea9 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -256,6 +256,80 @@ int genphy_c45_read_mdix(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(genphy_c45_read_mdix);
 
+/**
+ * genphy_c45_pma_read_abilities - read supported link modes from PMA
+ * @phydev: target phy_device struct
+ *
+ * Read the supported link modes from the PMA Status 2 (1.8) register. If bit
+ * 1.8.9 is set, the list of supported modes is build using the values in the
+ * PMA Extended Abilities (1.11) register, indicating 1000BASET an 10G related
+ * modes. If bit 1.11.14 is set, then the list is also extended with the modes
+ * in the 2.5G/5G PMA Extended register (1.21), indicating if 2.5GBASET and
+ * 5GBASET are supported.
+ */
+int genphy_c45_pma_read_abilities(struct phy_device *phydev)
+{
+	int val;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_STAT2);
+	if (val < 0)
+		return val;
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseSR_Full_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_STAT2_10GBSR);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseLR_Full_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_STAT2_10GBLR);
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseER_Full_BIT,
+			 phydev->supported,
+			 val & MDIO_PMA_STAT2_10GBER);
+
+	if (val & MDIO_PMA_STAT2_EXTABLE) {
+		val = phy_read_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_EXTABLE);
+		if (val < 0)
+			return val;
+
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseLRM_Full_BIT,
+				 phydev->supported,
+				 val & MDIO_PMA_EXTABLE_10GBLRM);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+				 phydev->supported,
+				 val & MDIO_PMA_EXTABLE_10GBT);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
+				 phydev->supported,
+				 val & MDIO_PMA_EXTABLE_10GBKX4);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
+				 phydev->supported,
+				 val & MDIO_PMA_EXTABLE_10GBKR);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+				 phydev->supported,
+				 val & MDIO_PMA_EXTABLE_1000BT);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
+				 phydev->supported,
+				 val & MDIO_PMA_EXTABLE_1000BKX);
+
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+				 phydev->supported,
+				 val & MDIO_PMA_EXTABLE_100BTX);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
+				 phydev->supported,
+				 val & MDIO_PMA_EXTABLE_100BTX);
+
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
+				 phydev->supported,
+				 val & MDIO_PMA_EXTABLE_10BT);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
+				 phydev->supported,
+				 val & MDIO_PMA_EXTABLE_10BT);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(genphy_c45_pma_read_abilities);
+
 /* The gen10g_* functions are the old Clause 45 stub */
 
 int gen10g_config_aneg(struct phy_device *phydev)
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 017118061ecf..863d0e00db89 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1102,6 +1102,7 @@ int genphy_c45_read_pma(struct phy_device *phydev);
 int genphy_c45_pma_setup_forced(struct phy_device *phydev);
 int genphy_c45_an_disable_aneg(struct phy_device *phydev);
 int genphy_c45_read_mdix(struct phy_device *phydev);
+int genphy_c45_pma_read_abilities(struct phy_device *phydev);
 
 /* The gen10g_* functions are the old Clause 45 stub */
 int gen10g_config_aneg(struct phy_device *phydev);
-- 
2.19.2

