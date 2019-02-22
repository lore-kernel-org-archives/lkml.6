Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3824BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1294B2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfBVXiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:38:10 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46855 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVXiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:38:08 -0500
X-Originating-IP: 86.201.231.99
Received: from mc-bl-xps13.lan (lfbn-tou-1-149-99.w86-201.abo.wanadoo.fr [86.201.231.99])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id EA7426000F;
        Fri, 22 Feb 2019 23:38:02 +0000 (UTC)
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
Subject: [PATCH net-next v2 3/7] net: phy: marvell10g: Use 2500BASEX when using 2.5GBASET
Date:   Sat, 23 Feb 2019 00:37:40 +0100
Message-Id: <20190222233744.25735-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190222233744.25735-1-maxime.chevallier@bootlin.com>
References: <20190222233744.25735-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Marvell Alaska family of PHYs supports 2.5GBaseT and 5GBaseT modes,
as defined in the 802.3bz specification.

Upon establishing a 2.5GBASET link, the PHY will reconfigure it's MII
interface to 2500BASEX.

At 5G, the PHY will reconfigure it's interface to 5GBASE-R, but this
mode isn't supported by any MAC for now.

This was tested with :
 - The 88X3310, which is on the MacchiatoBin
 - The 88E2010, an Alaska PHY that has no fiber interfaces, and is
   limited to 5G maximum speed.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/marvell10g.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 821ef1b2f8cc..9342d8c2ff7f 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -235,6 +235,7 @@ static int mv3310_config_init(struct phy_device *phydev)
 {
 	/* Check that the PHY interface type is compatible */
 	if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
+	    phydev->interface != PHY_INTERFACE_MODE_2500BASEX &&
 	    phydev->interface != PHY_INTERFACE_MODE_XAUI &&
 	    phydev->interface != PHY_INTERFACE_MODE_RXAUI &&
 	    phydev->interface != PHY_INTERFACE_MODE_10GKR)
@@ -313,18 +314,29 @@ static int mv3310_aneg_done(struct phy_device *phydev)
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
-		if (phydev->speed == SPEED_10000)
+		switch (phydev->speed) {
+		case SPEED_10000:
 			phydev->interface = PHY_INTERFACE_MODE_10GKR;
-		else if (phydev->speed >= SPEED_10 &&
-			 phydev->speed < SPEED_10000)
+			break;
+		case SPEED_2500:
+			phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
+			break;
+		case SPEED_1000:
+		case SPEED_100:
+		case SPEED_10:
 			phydev->interface = PHY_INTERFACE_MODE_SGMII;
+			break;
+		default:
+			break;
+		}
 	}
 }
 
-- 
2.19.2

