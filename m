Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176E1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D988E21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfBGJuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:50:04 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:54241 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGJuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:50:01 -0500
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id DD84510001C;
        Thu,  7 Feb 2019 09:49:56 +0000 (UTC)
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
Subject: [PATCH net-next v2 01/10] net: phy: Update PHY linkmodes after config_init
Date:   Thu,  7 Feb 2019 10:49:30 +0100
Message-Id: <20190207094939.27369-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to be able to update a PHY's supported list in the config_init
callback, so move the Pause parameters settings from phydrv->features
after calling config_init to make sure these  parameters aren't
overwritten.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 89 +++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 31 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 891e0178b97f..18a10565efd4 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1059,6 +1059,59 @@ static int phy_poll_reset(struct phy_device *phydev)
 	return 0;
 }
 
+/**
+ * phy_update_linkmodes - Update and sanitize linkmodes and pause parameters
+ * @phydev: The PHY device whose parameters we want to update.
+ *
+ * Description: The list of supported and advertised linkmodes is not
+ * straightforward to maintain, since PHYs and MACs are subject to quirks and
+ * erratas. This function re-builds the list of the supported pause parameters
+ * by taking into account the parameters expressed in the driver's features
+ * list.
+ */
+static void phy_update_linkmodes(struct phy_device *phydev)
+{
+	struct device_driver *drv = phydev->mdio.dev.driver;
+	struct phy_driver *phydrv = to_phy_driver(drv);
+
+	mutex_lock(&phydev->lock);
+
+	/* The Pause Frame bits indicate that the PHY can support passing
+	 * pause frames. During autonegotiation, the PHYs will determine if
+	 * they should allow pause frames to pass.  The MAC driver should then
+	 * use that result to determine whether to enable flow control via
+	 * pause frames.
+	 *
+	 * Normally, PHY drivers should not set the Pause bits, and instead
+	 * allow phylib to do that.  However, there may be some situations
+	 * (e.g. hardware erratum) where the driver wants to set only one
+	 * of these bits.
+	 */
+	if (test_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydrv->features) ||
+	    test_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, phydrv->features)) {
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT,
+				   phydev->supported);
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+				   phydev->supported);
+		if (test_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydrv->features))
+			linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT,
+					 phydev->supported);
+		if (test_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+			     phydrv->features))
+			linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+					 phydev->supported);
+	} else {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT,
+				 phydev->supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+				 phydev->supported);
+	}
+
+	linkmode_copy(phydev->advertising, phydev->supported);
+
+	mutex_unlock(&phydev->lock);
+}
+
 int phy_init_hw(struct phy_device *phydev)
 {
 	int ret = 0;
@@ -1082,6 +1135,11 @@ int phy_init_hw(struct phy_device *phydev)
 	if (phydev->drv->config_init)
 		ret = phydev->drv->config_init(phydev);
 
+	/* Update and sanitize the supported and advertised linkmodes, since
+	 * they might have been changed in config_init
+	 */
+	phy_update_linkmodes(phydev);
+
 	return ret;
 }
 EXPORT_SYMBOL(phy_init_hw);
@@ -2221,37 +2279,6 @@ static int phy_probe(struct device *dev)
 	 */
 	of_set_phy_eee_broken(phydev);
 
-	/* The Pause Frame bits indicate that the PHY can support passing
-	 * pause frames. During autonegotiation, the PHYs will determine if
-	 * they should allow pause frames to pass.  The MAC driver should then
-	 * use that result to determine whether to enable flow control via
-	 * pause frames.
-	 *
-	 * Normally, PHY drivers should not set the Pause bits, and instead
-	 * allow phylib to do that.  However, there may be some situations
-	 * (e.g. hardware erratum) where the driver wants to set only one
-	 * of these bits.
-	 */
-	if (test_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydrv->features) ||
-	    test_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, phydrv->features)) {
-		linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT,
-				   phydev->supported);
-		linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
-				   phydev->supported);
-		if (test_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydrv->features))
-			linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT,
-					 phydev->supported);
-		if (test_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
-			     phydrv->features))
-			linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
-					 phydev->supported);
-	} else {
-		linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT,
-				 phydev->supported);
-		linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
-				 phydev->supported);
-	}
-
 	/* Set the state to READY by default */
 	phydev->state = PHY_READY;
 
-- 
2.19.2

