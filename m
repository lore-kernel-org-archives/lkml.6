Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934416AbeB1T7m (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 14:59:42 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38021 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934282AbeB1T7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:59:03 -0500
X-Google-Smtp-Source: AG47ELtFn/1gRD8KLsTjbNp504xOvwTO6MDAgzBpKZ+7WlKbQf0+BHJBAsca7nzVLcZTbRJKukkoTQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Russell King <rmk@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list), moritz.fischer@ettus.com
Subject: [PATCH net-next v2 4/5] net: phy: cortina: Utilize generic functions
Date: Wed, 28 Feb 2018 11:58:48 -0800
Message-Id: <20180228195849.17770-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180228195849.17770-1-f.fainelli@gmail.com>
References: <20180228195849.17770-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cortina_soft_reset() does the same thing as gen10g_soft_reset(), and
cortina_config_aneg() is actually doing what gen10g_config_init() does
for 10G capable PHYs.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/cortina.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/cortina.c b/drivers/net/phy/cortina.c
index 9442db221834..8022cd317f62 100644
--- a/drivers/net/phy/cortina.c
+++ b/drivers/net/phy/cortina.c
@@ -30,14 +30,6 @@ static int cortina_read_reg(struct phy_device *phydev, u16 regnum)
 			    MII_ADDR_C45 | regnum);
 }
 
-static int cortina_config_aneg(struct phy_device *phydev)
-{
-	phydev->supported = SUPPORTED_10000baseT_Full;
-	phydev->advertising = SUPPORTED_10000baseT_Full;
-
-	return 0;
-}
-
 static int cortina_read_status(struct phy_device *phydev)
 {
 	int gpio_int_status, ret = 0;
@@ -61,11 +53,6 @@ static int cortina_read_status(struct phy_device *phydev)
 	return ret;
 }
 
-static int cortina_soft_reset(struct phy_device *phydev)
-{
-	return 0;
-}
-
 static int cortina_probe(struct phy_device *phydev)
 {
 	u32 phy_id = 0;
@@ -101,9 +88,10 @@ static struct phy_driver cortina_driver[] = {
 	.phy_id		= PHY_ID_CS4340,
 	.phy_id_mask	= 0xffffffff,
 	.name		= "Cortina CS4340",
-	.config_aneg	= cortina_config_aneg,
+	.config_init	= gen10g_config_init,
+	.config_aneg	= gen10g_config_aneg,
 	.read_status	= cortina_read_status,
-	.soft_reset	= cortina_soft_reset,
+	.soft_reset	= gen10g_no_soft_reset,
 	.probe		= cortina_probe,
 },
 };
-- 
2.14.1
