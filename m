Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B1DC282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AF920823
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfBGJuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:50:11 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:47279 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfBGJuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:50:07 -0500
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 9DA14100017;
        Thu,  7 Feb 2019 09:50:02 +0000 (UTC)
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
Subject: [PATCH net-next v2 03/10] net: phy: Move of_set_phy_eee_broken to phy-core.c
Date:   Thu,  7 Feb 2019 10:49:32 +0100
Message-Id: <20190207094939.27369-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since of_set_phy_supported was moved to phy-core.c, we can also move
of_set_phy_eee_broken to the same location, so that we have all OF
functions in the same place.

This patch doesn't intend to introduce any change in behaviour.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy-core.c   | 27 +++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c | 28 ----------------------------
 include/linux/phy.h          |  1 +
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 8e54fe396553..9429b473c791 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -383,6 +383,33 @@ void of_set_phy_supported(struct phy_device *phydev)
 		__set_phy_supported(phydev, max_speed);
 }
 
+void of_set_phy_eee_broken(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	u32 broken = 0;
+
+	if (!IS_ENABLED(CONFIG_OF_MDIO))
+		return;
+
+	if (!node)
+		return;
+
+	if (of_property_read_bool(node, "eee-broken-100tx"))
+		broken |= MDIO_EEE_100TX;
+	if (of_property_read_bool(node, "eee-broken-1000t"))
+		broken |= MDIO_EEE_1000T;
+	if (of_property_read_bool(node, "eee-broken-10gt"))
+		broken |= MDIO_EEE_10GT;
+	if (of_property_read_bool(node, "eee-broken-1000kx"))
+		broken |= MDIO_EEE_1000KX;
+	if (of_property_read_bool(node, "eee-broken-10gkx4"))
+		broken |= MDIO_EEE_10GKX4;
+	if (of_property_read_bool(node, "eee-broken-10gkr"))
+		broken |= MDIO_EEE_10GKR;
+
+	phydev->eee_broken_modes = broken;
+}
+
 /**
  * phy_resolve_aneg_linkmode - resolve the advertisements into phy settings
  * @phydev: The phy_device struct
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index a4ab16992806..a4cbc5a6f09d 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -30,7 +30,6 @@
 #include <linux/mdio.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
-#include <linux/of.h>
 
 MODULE_DESCRIPTION("PHY library");
 MODULE_AUTHOR("Andy Fleming");
@@ -2153,33 +2152,6 @@ bool phy_validate_pause(struct phy_device *phydev,
 }
 EXPORT_SYMBOL(phy_validate_pause);
 
-static void of_set_phy_eee_broken(struct phy_device *phydev)
-{
-	struct device_node *node = phydev->mdio.dev.of_node;
-	u32 broken = 0;
-
-	if (!IS_ENABLED(CONFIG_OF_MDIO))
-		return;
-
-	if (!node)
-		return;
-
-	if (of_property_read_bool(node, "eee-broken-100tx"))
-		broken |= MDIO_EEE_100TX;
-	if (of_property_read_bool(node, "eee-broken-1000t"))
-		broken |= MDIO_EEE_1000T;
-	if (of_property_read_bool(node, "eee-broken-10gt"))
-		broken |= MDIO_EEE_10GT;
-	if (of_property_read_bool(node, "eee-broken-1000kx"))
-		broken |= MDIO_EEE_1000KX;
-	if (of_property_read_bool(node, "eee-broken-10gkx4"))
-		broken |= MDIO_EEE_10GKX4;
-	if (of_property_read_bool(node, "eee-broken-10gkr"))
-		broken |= MDIO_EEE_10GKR;
-
-	phydev->eee_broken_modes = broken;
-}
-
 static bool phy_drv_supports_irq(struct phy_driver *phydrv)
 {
 	return phydrv->config_intr && phydrv->ack_interrupt;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index cfdd3de38410..017118061ecf 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -668,6 +668,7 @@ phy_lookup_setting(int speed, int duplex, const unsigned long *mask,
 size_t phy_speeds(unsigned int *speeds, size_t size,
 		  unsigned long *mask);
 void of_set_phy_supported(struct phy_device *phydev);
+void of_set_phy_eee_broken(struct phy_device *phydev);
 
 static inline bool __phy_is_started(struct phy_device *phydev)
 {
-- 
2.19.2

