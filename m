Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751672AbeDEUlC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:41:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40292 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751846AbeDEUk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:40:58 -0400
X-Google-Smtp-Source: AIpwx4+KlbSbd/Gz3fG5i9pgWNNa/SSm+f7ptGdSsVWMYVVnG+L4Rd1bn6W6azudqg7l2wt9kOdPpQ==
From: Esben Haabendal <esben.haabendal@gmail.com>
To: netdev@vger.kernel.org
Cc: Esben Haabendal <eha@deif.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] net: phy: marvell: Enable interrupt function on LED2 pin
Date: Thu,  5 Apr 2018 22:40:29 +0200
Message-Id: <20180405204029.665-1-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180405133504.12257-1-esben.haabendal@gmail.com>
References: <20180405133504.12257-1-esben.haabendal@gmail.com>
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
 drivers/net/phy/marvell.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 0e0978d8a0eb..a6ad0255c512 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -828,6 +828,22 @@ static int m88e1121_config_init(struct phy_device *phydev)
 	return marvell_config_init(phydev);
 }
 
+static int m88e1318_config_init(struct phy_device *phydev)
+{
+	if (phy_interrupt_is_valid(phydev)) {
+		int err = phy_modify_paged(
+			phydev, MII_MARVELL_LED_PAGE,
+			MII_88E1318S_PHY_LED_TCR,
+			MII_88E1318S_PHY_LED_TCR_FORCE_INT,
+			MII_88E1318S_PHY_LED_TCR_INTn_ENABLE |
+			MII_88E1318S_PHY_LED_TCR_INT_ACTIVE_LOW);
+		if (err < 0)
+			return err;
+	}
+
+	return m88e1121_config_init(phydev);
+}
+
 static int m88e1510_config_init(struct phy_device *phydev)
 {
 	int err;
@@ -870,7 +886,7 @@ static int m88e1510_config_init(struct phy_device *phydev)
 		phydev->advertising &= ~pause;
 	}
 
-	return m88e1121_config_init(phydev);
+	return m88e1318_config_init(phydev);
 }
 
 static int m88e1118_config_aneg(struct phy_device *phydev)
@@ -2086,7 +2102,7 @@ static struct phy_driver marvell_drivers[] = {
 		.features = PHY_GBIT_FEATURES,
 		.flags = PHY_HAS_INTERRUPT,
 		.probe = marvell_probe,
-		.config_init = &m88e1121_config_init,
+		.config_init = &m88e1318_config_init,
 		.config_aneg = &m88e1318_config_aneg,
 		.read_status = &marvell_read_status,
 		.ack_interrupt = &marvell_ack_interrupt,
-- 
2.16.3
