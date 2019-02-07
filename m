Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520DAC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C1F20823
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfBGJus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:50:48 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:54839 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfBGJuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:50:19 -0500
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 197DD10001F;
        Thu,  7 Feb 2019 09:50:14 +0000 (UTC)
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
Subject: [PATCH net-next v2 07/10] net: phy: marvell10g: Add support for 2.5GBASET
Date:   Thu,  7 Feb 2019 10:49:36 +0100
Message-Id: <20190207094939.27369-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Marvell Alaska family of PHYs supports 2.5GBaseT and 5GBaseT modes,
as defined in the 802.3bz specification.

When the link partner requests a 2.5GBASET link, the PHY will
reconfigure it's MII interface to 2500BASEX.

At 5G, the PHY will reconfigure it's interface to 5GBASE-R, but this
mode isn't supported by any MAC for now.

This was tested with :
 - The 88X3310, which is on the MacchiatoBin
 - The 88E2010, an Alaska PHY that has no fiber interfaces, and is
   limited to 5G maximum speed.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V1 -> V2: Use a #define for the 88X3310 PHY ID, since it's reused in
	  various places in the code. Rebased on Heiner Kallweit's patch
	  introducing the phy_modify_mmd accessor.

 drivers/net/phy/marvell10g.c | 30 ++++++++++++++++++++++--------
 include/linux/marvell_phy.h  |  1 +
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 07df87b81369..581b4b6e31e9 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -238,6 +238,7 @@ static int mv3310_config_init(struct phy_device *phydev)
 
 	/* Check that the PHY interface type is compatible */
 	if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
+	    phydev->interface != PHY_INTERFACE_MODE_2500BASEX &&
 	    phydev->interface != PHY_INTERFACE_MODE_XAUI &&
 	    phydev->interface != PHY_INTERFACE_MODE_RXAUI &&
 	    phydev->interface != PHY_INTERFACE_MODE_10GKR)
@@ -307,8 +308,18 @@ static int mv3310_config_aneg(struct phy_device *phydev)
 	else
 		reg = 0;
 
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+			      phydev->advertising))
+		reg |= MDIO_AN_10GBT_CTRL_ADV2_5G;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+			      phydev->advertising))
+		reg |= MDIO_AN_10GBT_CTRL_ADV5G;
+
 	ret = phy_modify_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
-			     MDIO_AN_10GBT_CTRL_ADV10G, reg);
+			     MDIO_AN_10GBT_CTRL_ADV10G |
+			     MDIO_AN_10GBT_CTRL_ADV5G |
+			     MDIO_AN_10GBT_CTRL_ADV2_5G, reg);
+
 	if (ret < 0)
 		return ret;
 	if (ret > 0)
@@ -337,17 +348,20 @@ static int mv3310_aneg_done(struct phy_device *phydev)
 static void mv3310_update_interface(struct phy_device *phydev)
 {
 	if ((phydev->interface == PHY_INTERFACE_MODE_SGMII ||
+	     phydev->interface == PHY_INTERFACE_MODE_2500BASEX ||
 	     phydev->interface == PHY_INTERFACE_MODE_10GKR) && phydev->link) {
 		/* The PHY automatically switches its serdes interface (and
-		 * active PHYXS instance) between Cisco SGMII and 10GBase-KR
-		 * modes according to the speed.  Florian suggests setting
-		 * phydev->interface to communicate this to the MAC. Only do
-		 * this if we are already in either SGMII or 10GBase-KR mode.
+		 * active PHYXS instance) between Cisco SGMII, 10GBase-KR and
+		 * 2500BaseX modes according to the speed.  Florian suggests
+		 * setting phydev->interface to communicate this to the MAC.
+		 * Only do this if we are already in one of the above modes.
 		 */
 		if (phydev->speed == SPEED_10000)
 			phydev->interface = PHY_INTERFACE_MODE_10GKR;
+		else if (phydev->speed == SPEED_2500)
+			phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
 		else if (phydev->speed >= SPEED_10 &&
-			 phydev->speed < SPEED_10000)
+			 phydev->speed < SPEED_2500)
 			phydev->interface = PHY_INTERFACE_MODE_SGMII;
 	}
 }
@@ -450,7 +464,7 @@ static int mv3310_read_status(struct phy_device *phydev)
 
 static struct phy_driver mv3310_drivers[] = {
 	{
-		.phy_id		= 0x002b09aa,
+		.phy_id		= MARVELL_PHY_ID_88X3310,
 		.phy_id_mask	= MARVELL_PHY_ID_MASK,
 		.name		= "mv88x3310",
 		.features	= PHY_10GBIT_FEATURES,
@@ -468,7 +482,7 @@ static struct phy_driver mv3310_drivers[] = {
 module_phy_driver(mv3310_drivers);
 
 static struct mdio_device_id __maybe_unused mv3310_tbl[] = {
-	{ 0x002b09aa, MARVELL_PHY_ID_MASK },
+	{ MARVELL_PHY_ID_88X3310, MARVELL_PHY_ID_MASK },
 	{ },
 };
 MODULE_DEVICE_TABLE(mdio, mv3310_tbl);
diff --git a/include/linux/marvell_phy.h b/include/linux/marvell_phy.h
index 1eb6f244588d..5851d68d828a 100644
--- a/include/linux/marvell_phy.h
+++ b/include/linux/marvell_phy.h
@@ -20,6 +20,7 @@
 #define MARVELL_PHY_ID_88E1540		0x01410eb0
 #define MARVELL_PHY_ID_88E1545		0x01410ea0
 #define MARVELL_PHY_ID_88E3016		0x01410e60
+#define MARVELL_PHY_ID_88X3310		0x002b09aa
 
 /* The MV88e6390 Ethernet switch contains embedded PHYs. These PHYs do
  * not have a model ID. So the switch driver traps reads to the ID2
-- 
2.19.2

