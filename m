Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbeDENfi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:35:38 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39623 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeDENfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:35:37 -0400
X-Google-Smtp-Source: AIpwx4/r0UNTE28r95rmsENkPheWInwjew0zoTio3VCd2NUFWG7/Vk6YPmbNE2tLTOZya6QKXhBsMg==
From: Esben Haabendal <esben.haabendal@gmail.com>
To: netdev@vger.kernel.org
Cc: Esben Haabendal <eha@deif.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: phy: marvell: Enable interrupt function on LED2 pin
Date: Thu,  5 Apr 2018 15:35:04 +0200
Message-Id: <20180405133504.12257-1-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

The LED2[2]/INTn pin on Marvell 88E1318S as well as 88E1510/12/14/18 needs
to be configured to be usable as interrupt not only when WOL is enabled,
but whenever we rely on interrupts from the PHY.

Signed-off-by: Esben Haabendal <eha@deif.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/net/phy/marvell.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 0e0978d8a0eb..f03a510f1247 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -457,6 +457,21 @@ static int marvell_of_reg_init(struct phy_device *phydev)
 }
 #endif /* CONFIG_OF_MDIO */
 
+static int m88e1318_config_intr(struct phy_device *phydev)
+{
+	int err;
+
+	err = marvell_config_intr(phydev);
+	if (err)
+		return err;
+
+	/* Setup LED[2] as interrupt pin (active low) */
+	return phy_modify(phydev, MII_88E1318S_PHY_LED_TCR,
+			  MII_88E1318S_PHY_LED_TCR_FORCE_INT,
+			  MII_88E1318S_PHY_LED_TCR_INTn_ENABLE |
+			  MII_88E1318S_PHY_LED_TCR_INT_ACTIVE_LOW);
+}
+
 static int m88e1121_config_aneg_rgmii_delays(struct phy_device *phydev)
 {
 	int mscr;
@@ -2090,7 +2105,7 @@ static struct phy_driver marvell_drivers[] = {
 		.config_aneg = &m88e1318_config_aneg,
 		.read_status = &marvell_read_status,
 		.ack_interrupt = &marvell_ack_interrupt,
-		.config_intr = &marvell_config_intr,
+		.config_intr = &m88e1318_config_intr,
 		.did_interrupt = &m88e1121_did_interrupt,
 		.get_wol = &m88e1318_get_wol,
 		.set_wol = &m88e1318_set_wol,
@@ -2189,7 +2204,7 @@ static struct phy_driver marvell_drivers[] = {
 		.config_aneg = &m88e1510_config_aneg,
 		.read_status = &marvell_read_status,
 		.ack_interrupt = &marvell_ack_interrupt,
-		.config_intr = &marvell_config_intr,
+		.config_intr = &m88e1318_config_intr,
 		.did_interrupt = &m88e1121_did_interrupt,
 		.get_wol = &m88e1318_get_wol,
 		.set_wol = &m88e1318_set_wol,
-- 
2.16.3
