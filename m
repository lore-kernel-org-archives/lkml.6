Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbeDELoa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 07:44:30 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39407 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeDELo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 07:44:27 -0400
X-Google-Smtp-Source: AIpwx4/uotmBoPtn0DYf51vq9wHtpDKybp3cf8SrWJulECwu7hVL4kOT+kx2OTnDo71PZgIzNP6pfw==
From: esben.haabendal@gmail.com
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org (open list:ETHERNET PHY LIBRARY),
        linux-kernel@vger.kernel.org (open list)
Cc: Esben Haabendal <eha@deif.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 1/2] net: phy: Helper function for reading strapped configuration values
Date: Thu,  5 Apr 2018 13:44:23 +0200
Message-Id: <20180405114424.8519-1-esben.haabendal@gmail.com>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <eha@deif.com>

Add a function for use in PHY driver probe functions, reading current
autoneg, speed and duplex configuration from BMCR register.

Useful for PHY that supports hardware strapped configuration, enabling
Linux to respect that configuration (i.e. strapped non-autoneg
configuration).

Signed-off-by: Esben Haabendal <eha@deif.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/net/phy/phy_device.c | 41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/phy.h          |  1 +
 2 files changed, 42 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 74664a6c0cdc..cc52ff2a2344 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1673,6 +1673,47 @@ int genphy_config_init(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(genphy_config_init);
 
+/**
+ * genphy_read_config - read configuration from PHY
+ * @phydev: target phy_device struct
+ *
+ * Description: Reads MII_BMCR and sets phydev autoneg, speed and duplex
+ * accordingly.  For use in driver probe functions, to respect strapped
+ * configuration settings.
+ */
+int genphy_read_config(struct phy_device *phydev)
+{
+	int bmcr;
+
+	bmcr = phy_read(phydev, MII_BMCR);
+	if (bmcr < 0)
+		return bmcr;
+
+	if (BMCR_ANENABLE & bmcr) {
+		phydev->autoneg = AUTONEG_ENABLE;
+
+		phydev->speed = 0;
+		phydev->duplex = -1;
+	} else {
+		phydev->autoneg = AUTONEG_DISABLE;
+
+		if (bmcr & BMCR_FULLDPLX)
+			phydev->duplex = DUPLEX_FULL;
+		else
+			phydev->duplex = DUPLEX_HALF;
+
+		if (bmcr & BMCR_SPEED1000)
+			phydev->speed = SPEED_1000;
+		else if (bmcr & BMCR_SPEED100)
+			phydev->speed = SPEED_100;
+		else
+			phydev->speed = SPEED_10;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(genphy_read_config);
+
 /* This is used for the phy device which doesn't support the MMD extended
  * register access, but it does have side effect when we are trying to access
  * the MMD register via indirect method.
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 7c4c2379e010..5a8821c8105d 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -970,6 +970,7 @@ void phy_attached_info(struct phy_device *phydev);
 
 /* Clause 22 PHY */
 int genphy_config_init(struct phy_device *phydev);
+int genphy_read_config(struct phy_device *phydev);
 int genphy_setup_forced(struct phy_device *phydev);
 int genphy_restart_aneg(struct phy_device *phydev);
 int genphy_config_aneg(struct phy_device *phydev);
-- 
2.16.3
