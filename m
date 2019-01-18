Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077BAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FA620657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfARPYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:24:43 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51337 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727942AbfARPYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:24:25 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3AEB720955; Fri, 18 Jan 2019 16:24:23 +0100 (CET)
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 005BC20898;
        Fri, 18 Jan 2019 16:24:03 +0100 (CET)
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
Subject: [PATCH net-next 4/7] net: phy: marvell10g: Add support for 2.5GBASET and 5GBASET
Date:   Fri, 18 Jan 2019 16:23:49 +0100
Message-Id: <20190118152352.26417-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
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
 drivers/net/phy/marvell10g.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index f2a6d6e7041a..f45ddf3bc138 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -255,6 +255,7 @@ static int mv3310_config_init(struct phy_device *phydev)
 
 	/* Check that the PHY interface type is compatible */
 	if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
+	    phydev->interface != PHY_INTERFACE_MODE_2500BASEX &&
 	    phydev->interface != PHY_INTERFACE_MODE_XAUI &&
 	    phydev->interface != PHY_INTERFACE_MODE_RXAUI &&
 	    phydev->interface != PHY_INTERFACE_MODE_10GKR)
@@ -264,8 +265,10 @@ static int mv3310_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	linkmode_and(phydev->advertising, phydev->advertising,
-		     phydev->supported);
+	/* Make sure we advertise all the supported modes, and not just the
+	 * default one specified in the driver's .features.
+	 */
+	linkmode_copy(phydev->advertising, phydev->supported);
 
 	return 0;
 }
@@ -314,8 +317,17 @@ static int mv3310_config_aneg(struct phy_device *phydev)
 	else
 		reg = 0;
 
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+			      phydev->advertising))
+		reg |= MDIO_AN_10GBT_CTRL_ADV2_5G;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+			      phydev->advertising))
+		reg |= MDIO_AN_10GBT_CTRL_ADV5G;
+
 	ret = mv3310_modify(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
-			    MDIO_AN_10GBT_CTRL_ADV10G, reg);
+			    MDIO_AN_10GBT_CTRL_ADV10G |
+			    MDIO_AN_10GBT_CTRL_ADV5G |
+			    MDIO_AN_10GBT_CTRL_ADV2_5G, reg);
 	if (ret < 0)
 		return ret;
 	if (ret > 0)
@@ -344,17 +356,20 @@ static int mv3310_aneg_done(struct phy_device *phydev)
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
-- 
2.19.2

