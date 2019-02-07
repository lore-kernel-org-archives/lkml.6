Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0D8C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B5520823
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfBGJuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:50:07 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:59999 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfBGJuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:50:05 -0500
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id E9A4E100004;
        Thu,  7 Feb 2019 09:49:59 +0000 (UTC)
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
Subject: [PATCH net-next v2 02/10] net: phy: Mask-out non-compatible modes when setting the max-speed
Date:   Thu,  7 Feb 2019 10:49:31 +0100
Message-Id: <20190207094939.27369-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting a PHY's max speed using either the max-speed DT property
or ethtool, we should mask-out all non-compatible modes according to the
settings table, instead of just the 10/100BASET modes.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Suggested-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy-core.c   | 45 ++++++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c | 53 ------------------------------------
 include/linux/phy.h          |  1 +
 3 files changed, 46 insertions(+), 53 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 7d6aad287f84..8e54fe396553 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -4,6 +4,7 @@
  */
 #include <linux/export.h>
 #include <linux/phy.h>
+#include <linux/of.h>
 
 const char *phy_speed_to_str(int speed)
 {
@@ -338,6 +339,50 @@ size_t phy_speeds(unsigned int *speeds, size_t size,
 	return count;
 }
 
+static int __set_phy_supported(struct phy_device *phydev, u32 max_speed)
+{
+	const struct phy_setting *p;
+	int i;
+
+	for (i = 0, p = settings; i < ARRAY_SIZE(settings); i++, p++) {
+		if (p->speed > max_speed)
+			linkmode_clear_bit(p->bit, phydev->supported);
+		else
+			break;
+	}
+
+	return 0;
+}
+
+int phy_set_max_speed(struct phy_device *phydev, u32 max_speed)
+{
+	int err;
+
+	err = __set_phy_supported(phydev, max_speed);
+	if (err)
+		return err;
+
+	linkmode_copy(phydev->advertising, phydev->supported);
+
+	return 0;
+}
+EXPORT_SYMBOL(phy_set_max_speed);
+
+void of_set_phy_supported(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	u32 max_speed;
+
+	if (!IS_ENABLED(CONFIG_OF_MDIO))
+		return;
+
+	if (!node)
+		return;
+
+	if (!of_property_read_u32(node, "max-speed", &max_speed))
+		__set_phy_supported(phydev, max_speed);
+}
+
 /**
  * phy_resolve_aneg_linkmode - resolve the advertisements into phy settings
  * @phydev: The phy_device struct
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 18a10565efd4..a4ab16992806 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2023,44 +2023,6 @@ int genphy_loopback(struct phy_device *phydev, bool enable)
 }
 EXPORT_SYMBOL(genphy_loopback);
 
-static int __set_phy_supported(struct phy_device *phydev, u32 max_speed)
-{
-	switch (max_speed) {
-	case SPEED_10:
-		linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
-				   phydev->supported);
-		linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
-				   phydev->supported);
-		/* fall through */
-	case SPEED_100:
-		linkmode_clear_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
-				   phydev->supported);
-		linkmode_clear_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
-				   phydev->supported);
-		break;
-	case SPEED_1000:
-		break;
-	default:
-		return -ENOTSUPP;
-	}
-
-	return 0;
-}
-
-int phy_set_max_speed(struct phy_device *phydev, u32 max_speed)
-{
-	int err;
-
-	err = __set_phy_supported(phydev, max_speed);
-	if (err)
-		return err;
-
-	linkmode_copy(phydev->advertising, phydev->supported);
-
-	return 0;
-}
-EXPORT_SYMBOL(phy_set_max_speed);
-
 /**
  * phy_remove_link_mode - Remove a supported link mode
  * @phydev: phy_device structure to remove link mode from
@@ -2191,21 +2153,6 @@ bool phy_validate_pause(struct phy_device *phydev,
 }
 EXPORT_SYMBOL(phy_validate_pause);
 
-static void of_set_phy_supported(struct phy_device *phydev)
-{
-	struct device_node *node = phydev->mdio.dev.of_node;
-	u32 max_speed;
-
-	if (!IS_ENABLED(CONFIG_OF_MDIO))
-		return;
-
-	if (!node)
-		return;
-
-	if (!of_property_read_u32(node, "max-speed", &max_speed))
-		__set_phy_supported(phydev, max_speed);
-}
-
 static void of_set_phy_eee_broken(struct phy_device *phydev)
 {
 	struct device_node *node = phydev->mdio.dev.of_node;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 237dd035858a..cfdd3de38410 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -667,6 +667,7 @@ phy_lookup_setting(int speed, int duplex, const unsigned long *mask,
 		   bool exact);
 size_t phy_speeds(unsigned int *speeds, size_t size,
 		  unsigned long *mask);
+void of_set_phy_supported(struct phy_device *phydev);
 
 static inline bool __phy_is_started(struct phy_device *phydev)
 {
-- 
2.19.2

