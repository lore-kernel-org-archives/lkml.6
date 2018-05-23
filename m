Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753534AbeEWAE5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 20:04:57 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44650 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753319AbeEWAEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 20:04:55 -0400
X-Google-Smtp-Source: AB8JxZqmBdrCucdglqR/KftpL2mXxgDY03XNb6MMe5Zo5OFCztmkeEt10u4kpuoz1q4p4UDV5R3xyw==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: arunp@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM
        ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: phy: broadcom: Fix bcm_write_exp()
Date: Tue, 22 May 2018 17:04:49 -0700
Message-Id: <20180523000450.9384-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On newer PHYs, we need to select the expansion register to write with
setting bits [11:8] to 0xf. This was done correctly by bcm7xxx.c prior
to being migrated to generic code under bcm-phy-lib.c which
unfortunately used the older implementation from the BCM54xx days.

Fix this by creating an inline stub: bcm_write_exp_sel() which adds the
correct value (MII_BCM54XX_EXP_SEL_ER) and update both the Cygnus PHY
and BCM7xxx PHY drivers which require setting these bits.

broadcom.c is unchanged because some PHYs even use a different selector
method, so let them specify it directly (e.g: SerDes secondary selector).

Fixes: a1cba5613edf ("net: phy: Add Broadcom phy library for common interfaces")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
David, please also queue this one up for -stable, thanks!

 drivers/net/phy/bcm-cygnus.c  | 6 +++---
 drivers/net/phy/bcm-phy-lib.h | 7 +++++++
 drivers/net/phy/bcm7xxx.c     | 4 ++--
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/bcm-cygnus.c b/drivers/net/phy/bcm-cygnus.c
index 6838129839ca..e757b09f1889 100644
--- a/drivers/net/phy/bcm-cygnus.c
+++ b/drivers/net/phy/bcm-cygnus.c
@@ -61,17 +61,17 @@ static int bcm_cygnus_afe_config(struct phy_device *phydev)
 		return rc;
 
 	/* make rcal=100, since rdb default is 000 */
-	rc = bcm_phy_write_exp(phydev, MII_BRCM_CORE_EXPB1, 0x10);
+	rc = bcm_phy_write_exp_sel(phydev, MII_BRCM_CORE_EXPB1, 0x10);
 	if (rc < 0)
 		return rc;
 
 	/* CORE_EXPB0, Reset R_CAL/RC_CAL Engine */
-	rc = bcm_phy_write_exp(phydev, MII_BRCM_CORE_EXPB0, 0x10);
+	rc = bcm_phy_write_exp_sel(phydev, MII_BRCM_CORE_EXPB0, 0x10);
 	if (rc < 0)
 		return rc;
 
 	/* CORE_EXPB0, Disable Reset R_CAL/RC_CAL Engine */
-	rc = bcm_phy_write_exp(phydev, MII_BRCM_CORE_EXPB0, 0x00);
+	rc = bcm_phy_write_exp_sel(phydev, MII_BRCM_CORE_EXPB0, 0x00);
 
 	return 0;
 }
diff --git a/drivers/net/phy/bcm-phy-lib.h b/drivers/net/phy/bcm-phy-lib.h
index 7c73808cbbde..81cceaa412fe 100644
--- a/drivers/net/phy/bcm-phy-lib.h
+++ b/drivers/net/phy/bcm-phy-lib.h
@@ -14,11 +14,18 @@
 #ifndef _LINUX_BCM_PHY_LIB_H
 #define _LINUX_BCM_PHY_LIB_H
 
+#include <linux/brcmphy.h>
 #include <linux/phy.h>
 
 int bcm_phy_write_exp(struct phy_device *phydev, u16 reg, u16 val);
 int bcm_phy_read_exp(struct phy_device *phydev, u16 reg);
 
+static inline int bcm_phy_write_exp_sel(struct phy_device *phydev,
+					u16 reg, u16 val)
+{
+	return bcm_phy_write_exp(phydev, reg | MII_BCM54XX_EXP_SEL_ER, val);
+}
+
 int bcm54xx_auxctl_write(struct phy_device *phydev, u16 regnum, u16 val);
 int bcm54xx_auxctl_read(struct phy_device *phydev, u16 regnum);
 
diff --git a/drivers/net/phy/bcm7xxx.c b/drivers/net/phy/bcm7xxx.c
index 29b1c88b55cc..01d2ff2f6241 100644
--- a/drivers/net/phy/bcm7xxx.c
+++ b/drivers/net/phy/bcm7xxx.c
@@ -65,10 +65,10 @@ struct bcm7xxx_phy_priv {
 static void r_rc_cal_reset(struct phy_device *phydev)
 {
 	/* Reset R_CAL/RC_CAL Engine */
-	bcm_phy_write_exp(phydev, 0x00b0, 0x0010);
+	bcm_phy_write_exp_sel(phydev, 0x00b0, 0x0010);
 
 	/* Disable Reset R_AL/RC_CAL Engine */
-	bcm_phy_write_exp(phydev, 0x00b0, 0x0000);
+	bcm_phy_write_exp_sel(phydev, 0x00b0, 0x0000);
 }
 
 static int bcm7xxx_28nm_b0_afe_config_init(struct phy_device *phydev)
-- 
2.14.1
