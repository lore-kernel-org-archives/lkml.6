Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934454AbeB1UAI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 15:00:08 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39039 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934139AbeB1T7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:59:01 -0500
X-Google-Smtp-Source: AG47ELs1BdL769Th2v4Hx6Dy30My6+M8Y1qh53XMis5J9ay8Wf1YTl4yguqZIyLDw+LojppQ8QJTBg==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Russell King <rmk@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list), moritz.fischer@ettus.com
Subject: [PATCH net-next v2 3/5] net: phy: teranetics: Utilize generic functions
Date: Wed, 28 Feb 2018 11:58:47 -0800
Message-Id: <20180228195849.17770-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180228195849.17770-1-f.fainelli@gmail.com>
References: <20180228195849.17770-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update teranetics_aneg_done() to use genphy_c45_aneg_done() instead of
duplicating that code, and switch to gen10g_* functions where
appropriate instead of maintaining identical copies doing nothing.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/teranetics.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/net/phy/teranetics.c b/drivers/net/phy/teranetics.c
index fb2cef764e9a..44b99cb580c8 100644
--- a/drivers/net/phy/teranetics.c
+++ b/drivers/net/phy/teranetics.c
@@ -34,19 +34,6 @@ MODULE_LICENSE("GPL v2");
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
 	int reg;
@@ -54,19 +41,12 @@ static int teranetics_aneg_done(struct phy_device *phydev)
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
@@ -102,10 +82,10 @@ static struct phy_driver teranetics_driver[] = {
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
