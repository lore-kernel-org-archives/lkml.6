Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163707AbeCBAJX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 19:09:23 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45948 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163667AbeCBAJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 19:09:16 -0500
X-Google-Smtp-Source: AG47ELti5E9MVuMYHIednfjFvhZtOvgs3laOp/hI6hOb9t1NOwKS3dlgrgQ9pmOl8j3a5KANRPkohw==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Russell King <rmk@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list), moritz.fischer@ettus.com
Subject: [PATCH net-next v3 3/5] net: phy: teranetics: Utilize generic functions
Date: Thu,  1 Mar 2018 16:08:57 -0800
Message-Id: <20180302000859.17309-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180302000859.17309-1-f.fainelli@gmail.com>
References: <20180302000859.17309-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update teranetics_aneg_done() to use genphy_c45_aneg_done() instead of
duplicating that code, and switch to gen10g_* functions where
appropriate instead of maintaining identical copies doing nothing.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/teranetics.c | 32 +++++---------------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/net/phy/teranetics.c b/drivers/net/phy/teranetics.c
index fb2cef764e9a..22f3bdd8206c 100644
--- a/drivers/net/phy/teranetics.c
+++ b/drivers/net/phy/teranetics.c
@@ -34,39 +34,17 @@ MODULE_LICENSE("GPL v2");
 				MDIO_PHYXS_LNSTAT_SYNC3 | \
 				MDIO_PHYXS_LNSTAT_ALIGN)
 
-static int teranetics_config_init(struct phy_device *phydev)
-{
-	phydev->supported = SUPPORTED_10000baseT_Full;
-	phydev->advertising = SUPPORTED_10000baseT_Full;
-
-	return 0;
-}
-
-static int teranetics_soft_reset(struct phy_device *phydev)
-{
-	return 0;
-}
-
 static int teranetics_aneg_done(struct phy_device *phydev)
 {
-	int reg;
-
 	/* auto negotiation state can only be checked when using copper
 	 * port, if using fiber port, just lie it's done.
 	 */
-	if (!phy_read_mmd(phydev, MDIO_MMD_VEND1, 93)) {
-		reg = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_STAT1);
-		return (reg < 0) ? reg : (reg & BMSR_ANEGCOMPLETE);
-	}
+	if (!phy_read_mmd(phydev, MDIO_MMD_VEND1, 93))
+		return genphy_c45_aneg_done(phydev);
 
 	return 1;
 }
 
-static int teranetics_config_aneg(struct phy_device *phydev)
-{
-	return 0;
-}
-
 static int teranetics_read_status(struct phy_device *phydev)
 {
 	int reg;
@@ -102,10 +80,10 @@ static struct phy_driver teranetics_driver[] = {
 	.phy_id		= PHY_ID_TN2020,
 	.phy_id_mask	= 0xffffffff,
 	.name		= "Teranetics TN2020",
-	.soft_reset	= teranetics_soft_reset,
+	.soft_reset	= gen10g_no_soft_reset,
 	.aneg_done	= teranetics_aneg_done,
-	.config_init    = teranetics_config_init,
-	.config_aneg    = teranetics_config_aneg,
+	.config_init    = gen10g_config_init,
+	.config_aneg    = gen10g_config_aneg,
 	.read_status	= teranetics_read_status,
 	.match_phy_device = teranetics_match_phy_device,
 },
-- 
2.14.1
