Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753500AbeC1TFv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 15:05:51 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36162 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752894AbeC1TFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 15:05:47 -0400
X-Google-Smtp-Source: AIpwx48eBkRYhXwg3Dh0ZYKQNMvxEb9eBCzf48jXgoimMEHbwJtlBR+ZmzQsEOaJi58x9upoVyO/lA==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list),
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Yan Markman <ymarkman@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Miquel Raynal <miquel.raynal@free-electrons.com>,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH net-next 2/2] sfp/phylink: move module EEPROM ethtool access into netdev core ethtool
Date: Wed, 28 Mar 2018 12:03:39 -0700
Message-Id: <20180328190339.31433-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180328190339.31433-1-f.fainelli@gmail.com>
References: <20180328190339.31433-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Provide a pointer to the SFP bus in struct net_device, so that the
ethtool module EEPROM methods can access the SFP directly, rather
than needing every user to provide a hook for it.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/marvell/mvneta.c | 18 ------------------
 drivers/net/phy/phylink.c             | 28 ----------------------------
 drivers/net/phy/sfp-bus.c             |  6 ++----
 include/linux/netdevice.h             |  3 +++
 include/linux/phylink.h               |  3 ---
 net/core/ethtool.c                    |  7 +++++++
 6 files changed, 12 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index cd09bde55596..25ced96750bf 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -4075,22 +4075,6 @@ static int mvneta_ethtool_set_wol(struct net_device *dev,
 	return ret;
 }
 
-static int mvneta_ethtool_get_module_info(struct net_device *dev,
-					  struct ethtool_modinfo *modinfo)
-{
-	struct mvneta_port *pp = netdev_priv(dev);
-
-	return phylink_ethtool_get_module_info(pp->phylink, modinfo);
-}
-
-static int mvneta_ethtool_get_module_eeprom(struct net_device *dev,
-					    struct ethtool_eeprom *ee, u8 *buf)
-{
-	struct mvneta_port *pp = netdev_priv(dev);
-
-	return phylink_ethtool_get_module_eeprom(pp->phylink, ee, buf);
-}
-
 static int mvneta_ethtool_get_eee(struct net_device *dev,
 				  struct ethtool_eee *eee)
 {
@@ -4165,8 +4149,6 @@ static const struct ethtool_ops mvneta_eth_tool_ops = {
 	.set_link_ksettings = mvneta_ethtool_set_link_ksettings,
 	.get_wol        = mvneta_ethtool_get_wol,
 	.set_wol        = mvneta_ethtool_set_wol,
-	.get_module_info = mvneta_ethtool_get_module_info,
-	.get_module_eeprom = mvneta_ethtool_get_module_eeprom,
 	.get_eee	= mvneta_ethtool_get_eee,
 	.set_eee	= mvneta_ethtool_set_eee,
 };
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 9b1e4721ea3a..c582b2d7546c 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1250,34 +1250,6 @@ int phylink_ethtool_set_pauseparam(struct phylink *pl,
 }
 EXPORT_SYMBOL_GPL(phylink_ethtool_set_pauseparam);
 
-int phylink_ethtool_get_module_info(struct phylink *pl,
-				    struct ethtool_modinfo *modinfo)
-{
-	int ret = -EOPNOTSUPP;
-
-	WARN_ON(!lockdep_rtnl_is_held());
-
-	if (pl->sfp_bus)
-		ret = sfp_get_module_info(pl->sfp_bus, modinfo);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(phylink_ethtool_get_module_info);
-
-int phylink_ethtool_get_module_eeprom(struct phylink *pl,
-				      struct ethtool_eeprom *ee, u8 *buf)
-{
-	int ret = -EOPNOTSUPP;
-
-	WARN_ON(!lockdep_rtnl_is_held());
-
-	if (pl->sfp_bus)
-		ret = sfp_get_module_eeprom(pl->sfp_bus, ee, buf);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(phylink_ethtool_get_module_eeprom);
-
 /**
  * phylink_ethtool_get_eee_err() - read the energy efficient ethernet error
  *   counter
diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index 3d4ff5d0d2a6..0381da78d228 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -342,6 +342,7 @@ static int sfp_register_bus(struct sfp_bus *bus)
 	}
 	if (bus->started)
 		bus->socket_ops->start(bus->sfp);
+	bus->netdev->sfp_bus = bus;
 	bus->registered = true;
 	return 0;
 }
@@ -356,6 +357,7 @@ static void sfp_unregister_bus(struct sfp_bus *bus)
 		if (bus->phydev && ops && ops->disconnect_phy)
 			ops->disconnect_phy(bus->upstream);
 	}
+	bus->netdev->sfp_bus = NULL;
 	bus->registered = false;
 }
 
@@ -371,8 +373,6 @@ static void sfp_unregister_bus(struct sfp_bus *bus)
  */
 int sfp_get_module_info(struct sfp_bus *bus, struct ethtool_modinfo *modinfo)
 {
-	if (!bus->registered)
-		return -ENOIOCTLCMD;
 	return bus->socket_ops->module_info(bus->sfp, modinfo);
 }
 EXPORT_SYMBOL_GPL(sfp_get_module_info);
@@ -391,8 +391,6 @@ EXPORT_SYMBOL_GPL(sfp_get_module_info);
 int sfp_get_module_eeprom(struct sfp_bus *bus, struct ethtool_eeprom *ee,
 			  u8 *data)
 {
-	if (!bus->registered)
-		return -ENOIOCTLCMD;
 	return bus->socket_ops->module_eeprom(bus->sfp, ee, data);
 }
 EXPORT_SYMBOL_GPL(sfp_get_module_eeprom);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 2a2d9cf50aa2..53f0cd64676b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -58,6 +58,7 @@ struct device;
 struct phy_device;
 struct dsa_port;
 
+struct sfp_bus;
 /* 802.11 specific */
 struct wireless_dev;
 /* 802.15.4 specific */
@@ -1662,6 +1663,7 @@ enum netdev_priv_flags {
  *	@priomap:	XXX: need comments on this one
  *	@phydev:	Physical device may attach itself
  *			for hardware timestamping
+ *	@sfp_bus:	attached &struct sfp_bus structure.
  *
  *	@qdisc_tx_busylock: lockdep class annotating Qdisc->busylock spinlock
  *	@qdisc_running_key: lockdep class annotating Qdisc->running seqcount
@@ -1945,6 +1947,7 @@ struct net_device {
 	struct netprio_map __rcu *priomap;
 #endif
 	struct phy_device	*phydev;
+	struct sfp_bus		*sfp_bus;
 	struct lock_class_key	*qdisc_tx_busylock;
 	struct lock_class_key	*qdisc_running_key;
 	bool			proto_down;
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index f29a40947de9..67cd518d66d1 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -217,9 +217,6 @@ void phylink_ethtool_get_pauseparam(struct phylink *,
 				    struct ethtool_pauseparam *);
 int phylink_ethtool_set_pauseparam(struct phylink *,
 				   struct ethtool_pauseparam *);
-int phylink_ethtool_get_module_info(struct phylink *, struct ethtool_modinfo *);
-int phylink_ethtool_get_module_eeprom(struct phylink *,
-				      struct ethtool_eeprom *, u8 *);
 int phylink_get_eee_err(struct phylink *);
 int phylink_ethtool_get_eee(struct phylink *, struct ethtool_eee *);
 int phylink_ethtool_set_eee(struct phylink *, struct ethtool_eee *);
diff --git a/net/core/ethtool.c b/net/core/ethtool.c
index bb6e498c6e3d..eb55252ca1fb 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -22,6 +22,7 @@
 #include <linux/bitops.h>
 #include <linux/uaccess.h>
 #include <linux/vmalloc.h>
+#include <linux/sfp.h>
 #include <linux/slab.h>
 #include <linux/rtnetlink.h>
 #include <linux/sched/signal.h>
@@ -2245,6 +2246,9 @@ static int __ethtool_get_module_info(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct phy_device *phydev = dev->phydev;
 
+	if (dev->sfp_bus)
+		return sfp_get_module_info(dev->sfp_bus, modinfo);
+
 	if (phydev && phydev->drv && phydev->drv->module_info)
 		return phydev->drv->module_info(phydev, modinfo);
 
@@ -2279,6 +2283,9 @@ static int __ethtool_get_module_eeprom(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct phy_device *phydev = dev->phydev;
 
+	if (dev->sfp_bus)
+		return sfp_get_module_eeprom(dev->sfp_bus, ee, data);
+
 	if (phydev && phydev->drv && phydev->drv->module_eeprom)
 		return phydev->drv->module_eeprom(phydev, ee, data);
 
-- 
2.14.1
