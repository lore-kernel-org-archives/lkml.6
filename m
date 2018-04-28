Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933308AbeD1Ac5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 20:32:57 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43184 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933223AbeD1Acs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 20:32:48 -0400
X-Google-Smtp-Source: AB8JxZrp8qFjxEhZZDgHvRpkiVSjrGQNuw4YUaQpq9dkxRMnaX8GFQEquRXDhHVNVzynl4UxBJ8Grw==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Russell King <rmk@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list), davem@davemloft.net,
        cphealy@gmail.com, nikita.yoush@cogentembedded.com,
        vivien.didelot@savoirfairelinux.com, Nisar.Sayed@microchip.com,
        UNGLinuxDriver@microchip.com
Subject: [RFC net-next 1/5] net: phy: Pass stringset argument to ethtool operations
Date: Fri, 27 Apr 2018 17:32:31 -0700
Message-Id: <20180428003237.1536-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180428003237.1536-1-f.fainelli@gmail.com>
References: <20180428003237.1536-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for returning a different type of strings other than
ETH_SS_STATS update the PHY drivers, helpers and consumers of these
functions.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c |  4 ++--
 drivers/net/phy/bcm-phy-lib.c    | 12 +++++++++---
 drivers/net/phy/bcm-phy-lib.h    |  4 ++--
 drivers/net/phy/bcm7xxx.c        |  6 ++++--
 drivers/net/phy/broadcom.c       |  6 ++++--
 drivers/net/phy/marvell.c        | 11 +++++++++--
 drivers/net/phy/micrel.c         | 11 +++++++++--
 drivers/net/phy/smsc.c           | 10 ++++++++--
 include/linux/phy.h              | 14 ++++++++------
 include/net/dsa.h                |  4 ++--
 net/core/ethtool.c               |  7 ++++---
 net/dsa/master.c                 |  9 +++++----
 net/dsa/port.c                   |  8 ++++----
 13 files changed, 70 insertions(+), 36 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 9f561fe505cb..8201e8f5c028 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -837,7 +837,7 @@ void b53_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 		if (!phydev)
 			return;
 
-		phy_ethtool_get_strings(phydev, data);
+		phy_ethtool_get_strings(phydev, stringset, data);
 	}
 }
 EXPORT_SYMBOL(b53_get_strings);
@@ -899,7 +899,7 @@ int b53_get_sset_count(struct dsa_switch *ds, int port, int sset)
 		if (!phydev)
 			return 0;
 
-		return phy_ethtool_get_sset_count(phydev);
+		return phy_ethtool_get_sset_count(phydev, sset);
 	}
 
 	return 0;
diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
index 0876aec7328c..e797e0863895 100644
--- a/drivers/net/phy/bcm-phy-lib.c
+++ b/drivers/net/phy/bcm-phy-lib.c
@@ -330,16 +330,22 @@ static const struct bcm_phy_hw_stat bcm_phy_hw_stats[] = {
 	{ "phy_remote_rcv_nok", MII_BRCM_CORE_BASE14, 0, 8 },
 };
 
-int bcm_phy_get_sset_count(struct phy_device *phydev)
+int bcm_phy_get_sset_count(struct phy_device *phydev, int sset)
 {
-	return ARRAY_SIZE(bcm_phy_hw_stats);
+	if (sset == ETH_SS_PHY_STATS)
+		return ARRAY_SIZE(bcm_phy_hw_stats);
+
+	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL_GPL(bcm_phy_get_sset_count);
 
-void bcm_phy_get_strings(struct phy_device *phydev, u8 *data)
+void bcm_phy_get_strings(struct phy_device *phydev, u32 stringset, u8 *data)
 {
 	unsigned int i;
 
+	if (stringset != ETH_SS_PHY_STATS)
+		return;
+
 	for (i = 0; i < ARRAY_SIZE(bcm_phy_hw_stats); i++)
 		strlcpy(data + i * ETH_GSTRING_LEN,
 			bcm_phy_hw_stats[i].string, ETH_GSTRING_LEN);
diff --git a/drivers/net/phy/bcm-phy-lib.h b/drivers/net/phy/bcm-phy-lib.h
index 7c73808cbbde..bebcfe106283 100644
--- a/drivers/net/phy/bcm-phy-lib.h
+++ b/drivers/net/phy/bcm-phy-lib.h
@@ -42,8 +42,8 @@ int bcm_phy_downshift_get(struct phy_device *phydev, u8 *count);
 
 int bcm_phy_downshift_set(struct phy_device *phydev, u8 count);
 
-int bcm_phy_get_sset_count(struct phy_device *phydev);
-void bcm_phy_get_strings(struct phy_device *phydev, u8 *data);
+int bcm_phy_get_sset_count(struct phy_device *phydev, int sset);
+void bcm_phy_get_strings(struct phy_device *phydev, u32 stringset, u8 *data);
 void bcm_phy_get_stats(struct phy_device *phydev, u64 *shadow,
 		       struct ethtool_stats *stats, u64 *data);
 
diff --git a/drivers/net/phy/bcm7xxx.c b/drivers/net/phy/bcm7xxx.c
index 29b1c88b55cc..1835af147eea 100644
--- a/drivers/net/phy/bcm7xxx.c
+++ b/drivers/net/phy/bcm7xxx.c
@@ -587,6 +587,9 @@ static void bcm7xxx_28nm_get_phy_stats(struct phy_device *phydev,
 static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 {
 	struct bcm7xxx_phy_priv *priv;
+	int count;
+
+	count = bcm_phy_get_sset_count(phydev, ETH_SS_PHY_STATS);
 
 	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -594,8 +597,7 @@ static int bcm7xxx_28nm_probe(struct phy_device *phydev)
 
 	phydev->priv = priv;
 
-	priv->stats = devm_kcalloc(&phydev->mdio.dev,
-				   bcm_phy_get_sset_count(phydev), sizeof(u64),
+	priv->stats = devm_kcalloc(&phydev->mdio.dev, count, sizeof(u64),
 				   GFP_KERNEL);
 	if (!priv->stats)
 		return -ENOMEM;
diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 3bb6b66dc7bf..dd909799baf0 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -547,6 +547,9 @@ struct bcm53xx_phy_priv {
 static int bcm53xx_phy_probe(struct phy_device *phydev)
 {
 	struct bcm53xx_phy_priv *priv;
+	int count;
+
+	count = bcm_phy_get_sset_count(phydev, ETH_SS_PHY_STATS);
 
 	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -554,8 +557,7 @@ static int bcm53xx_phy_probe(struct phy_device *phydev)
 
 	phydev->priv = priv;
 
-	priv->stats = devm_kcalloc(&phydev->mdio.dev,
-				   bcm_phy_get_sset_count(phydev), sizeof(u64),
+	priv->stats = devm_kcalloc(&phydev->mdio.dev, count, sizeof(u64),
 				   GFP_KERNEL);
 	if (!priv->stats)
 		return -ENOMEM;
diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index b8f57e9b9379..cf962182297b 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -1464,18 +1464,25 @@ static int m88e1318_set_wol(struct phy_device *phydev,
 	return phy_restore_page(phydev, oldpage, err);
 }
 
-static int marvell_get_sset_count(struct phy_device *phydev)
+static int marvell_get_sset_count(struct phy_device *phydev, int sset)
 {
+	if (sset != ETH_SS_PHY_STATS)
+		return -EOPNOTSUPP;
+
 	if (phydev->supported & SUPPORTED_FIBRE)
 		return ARRAY_SIZE(marvell_hw_stats);
 	else
 		return ARRAY_SIZE(marvell_hw_stats) - NB_FIBER_STATS;
 }
 
-static void marvell_get_strings(struct phy_device *phydev, u8 *data)
+static void marvell_get_strings(struct phy_device *phydev, u32 stringset,
+				u8 *data)
 {
 	int i;
 
+	if (stringset != ETH_SS_PHY_STATS)
+		return;
+
 	for (i = 0; i < ARRAY_SIZE(marvell_hw_stats); i++) {
 		strlcpy(data + i * ETH_GSTRING_LEN,
 			marvell_hw_stats[i].string, ETH_GSTRING_LEN);
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index de31c5170a5b..54f3e400a454 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -635,15 +635,22 @@ static int ksz8873mll_config_aneg(struct phy_device *phydev)
 	return 0;
 }
 
-static int kszphy_get_sset_count(struct phy_device *phydev)
+static int kszphy_get_sset_count(struct phy_device *phydev, int sset)
 {
+	if (sset != ETH_SS_PHY_STATS)
+		return -EOPNOTSUPP;
+
 	return ARRAY_SIZE(kszphy_hw_stats);
 }
 
-static void kszphy_get_strings(struct phy_device *phydev, u8 *data)
+static void kszphy_get_strings(struct phy_device *phydev, u32 stringset,
+			       u8 *data)
 {
 	int i;
 
+	if (stringset != ETH_SS_PHY_STATS)
+		return;
+
 	for (i = 0; i < ARRAY_SIZE(kszphy_hw_stats); i++) {
 		strlcpy(data + i * ETH_GSTRING_LEN,
 			kszphy_hw_stats[i].string, ETH_GSTRING_LEN);
diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index c328208388da..c1a4d4d0879d 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -153,15 +153,21 @@ static int lan87xx_read_status(struct phy_device *phydev)
 	return err;
 }
 
-static int smsc_get_sset_count(struct phy_device *phydev)
+static int smsc_get_sset_count(struct phy_device *phydev, int sset)
 {
+	if (sset != ETH_SS_PHY_STATS)
+		return -EOPNOTSUPP;
+
 	return ARRAY_SIZE(smsc_hw_stats);
 }
 
-static void smsc_get_strings(struct phy_device *phydev, u8 *data)
+static void smsc_get_strings(struct phy_device *phydev, u32 stringset, u8 *data)
 {
 	int i;
 
+	if (stringset != ETH_SS_PHY_STATS)
+		return;
+
 	for (i = 0; i < ARRAY_SIZE(smsc_hw_stats); i++) {
 		strncpy(data + i * ETH_GSTRING_LEN,
 		       smsc_hw_stats[i].string, ETH_GSTRING_LEN);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 073235e70442..deba0c11647f 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -647,8 +647,8 @@ struct phy_driver {
 			     struct ethtool_eeprom *ee, u8 *data);
 
 	/* Get statistics from the phy using ethtool */
-	int (*get_sset_count)(struct phy_device *dev);
-	void (*get_strings)(struct phy_device *dev, u8 *data);
+	int (*get_sset_count)(struct phy_device *dev, int sset);
+	void (*get_strings)(struct phy_device *dev, u32 stringset, u8 *data);
 	void (*get_stats)(struct phy_device *dev,
 			  struct ethtool_stats *stats, u64 *data);
 
@@ -1069,19 +1069,21 @@ void mdio_bus_exit(void);
 #endif
 
 /* Inline function for use within net/core/ethtool.c (built-in) */
-static inline int phy_ethtool_get_strings(struct phy_device *phydev, u8 *data)
+static inline int phy_ethtool_get_strings(struct phy_device *phydev,
+					  u32 stringset, u8 *data)
 {
 	if (!phydev->drv)
 		return -EIO;
 
 	mutex_lock(&phydev->lock);
-	phydev->drv->get_strings(phydev, data);
+	phydev->drv->get_strings(phydev, stringset, data);
 	mutex_unlock(&phydev->lock);
 
 	return 0;
 }
 
-static inline int phy_ethtool_get_sset_count(struct phy_device *phydev)
+static inline int phy_ethtool_get_sset_count(struct phy_device *phydev,
+					     int sset)
 {
 	int ret;
 
@@ -1092,7 +1094,7 @@ static inline int phy_ethtool_get_sset_count(struct phy_device *phydev)
 	    phydev->drv->get_strings &&
 	    phydev->drv->get_stats) {
 		mutex_lock(&phydev->lock);
-		ret = phydev->drv->get_sset_count(phydev);
+		ret = phydev->drv->get_sset_count(phydev, sset);
 		mutex_unlock(&phydev->lock);
 
 		return ret;
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 462e9741b210..528388cda0a0 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -592,8 +592,8 @@ static inline int call_dsa_notifiers(unsigned long val, struct net_device *dev,
 #define BRCM_TAG_GET_QUEUE(v)		((v) & 0xff)
 
 
-int dsa_port_get_phy_strings(struct dsa_port *dp, uint8_t *data);
+int dsa_port_get_phy_strings(struct dsa_port *dp, u32 stringset, uint8_t *data);
 int dsa_port_get_ethtool_phy_stats(struct dsa_port *dp, uint64_t *data);
-int dsa_port_get_phy_sset_count(struct dsa_port *dp);
+int dsa_port_get_phy_sset_count(struct dsa_port *dp, int sset);
 
 #endif
diff --git a/net/core/ethtool.c b/net/core/ethtool.c
index b849fdae7e87..0b9e2a44e1d1 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -229,7 +229,7 @@ static int __ethtool_get_sset_count(struct net_device *dev, int sset)
 
 	if (sset == ETH_SS_PHY_STATS && dev->phydev &&
 	    !ops->get_ethtool_phy_stats)
-		return phy_ethtool_get_sset_count(dev->phydev);
+		return phy_ethtool_get_sset_count(dev->phydev, sset);
 
 	if (ops->get_sset_count && ops->get_strings)
 		return ops->get_sset_count(dev, sset);
@@ -254,7 +254,7 @@ static void __ethtool_get_strings(struct net_device *dev,
 		memcpy(data, phy_tunable_strings, sizeof(phy_tunable_strings));
 	else if (stringset == ETH_SS_PHY_STATS && dev->phydev &&
 		 !ops->get_ethtool_phy_stats)
-		phy_ethtool_get_strings(dev->phydev, data);
+		phy_ethtool_get_strings(dev->phydev, stringset, data);
 	else
 		/* ops->get_strings is valid because checked earlier */
 		ops->get_strings(dev, stringset, data);
@@ -1977,7 +1977,8 @@ static int ethtool_get_phy_stats(struct net_device *dev, void __user *useraddr)
 		return -EOPNOTSUPP;
 
 	if (dev->phydev && !ops->get_ethtool_phy_stats)
-		n_stats = phy_ethtool_get_sset_count(dev->phydev);
+		n_stats = phy_ethtool_get_sset_count(dev->phydev,
+						     ETH_SS_PHY_STATS);
 	else
 		n_stats = ops->get_sset_count(dev, ETH_SS_PHY_STATS);
 	if (n_stats < 0)
diff --git a/net/dsa/master.c b/net/dsa/master.c
index c90ee3227dea..4dbbaad2c8aa 100644
--- a/net/dsa/master.c
+++ b/net/dsa/master.c
@@ -42,7 +42,8 @@ static void dsa_master_get_ethtool_phy_stats(struct net_device *dev,
 	int count = 0;
 
 	if (dev->phydev && !ops->get_ethtool_phy_stats) {
-		count = phy_ethtool_get_sset_count(dev->phydev);
+		count = phy_ethtool_get_sset_count(dev->phydev,
+						   ETH_SS_PHY_STATS);
 		if (count >= 0)
 			phy_ethtool_get_stats(dev->phydev, stats, data);
 	} else if (ops->get_sset_count && ops->get_ethtool_phy_stats) {
@@ -66,7 +67,7 @@ static int dsa_master_get_sset_count(struct net_device *dev, int sset)
 
 	if (sset == ETH_SS_PHY_STATS && dev->phydev &&
 	    !ops->get_ethtool_phy_stats)
-		count = phy_ethtool_get_sset_count(dev->phydev);
+		count = phy_ethtool_get_sset_count(dev->phydev, sset);
 	else if (ops->get_sset_count)
 		count = ops->get_sset_count(dev, sset);
 
@@ -98,11 +99,11 @@ static void dsa_master_get_strings(struct net_device *dev, uint32_t stringset,
 
 	if (stringset == ETH_SS_PHY_STATS && dev->phydev &&
 	    !ops->get_ethtool_phy_stats) {
-		mcount = phy_ethtool_get_sset_count(dev->phydev);
+		mcount = phy_ethtool_get_sset_count(dev->phydev, stringset);
 		if (mcount < 0)
 			mcount = 0;
 		else
-			phy_ethtool_get_strings(dev->phydev, data);
+			phy_ethtool_get_strings(dev->phydev, stringset, data);
 	} else if (ops->get_sset_count && ops->get_strings) {
 		mcount = ops->get_sset_count(dev, stringset);
 		if (mcount < 0)
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 2413beb995be..4e836da4cdd3 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -384,7 +384,7 @@ void dsa_port_link_unregister_of(struct dsa_port *dp)
 		dsa_port_setup_phy_of(dp, false);
 }
 
-int dsa_port_get_phy_strings(struct dsa_port *dp, uint8_t *data)
+int dsa_port_get_phy_strings(struct dsa_port *dp, u32 stringset, uint8_t *data)
 {
 	struct phy_device *phydev;
 	int ret = -EOPNOTSUPP;
@@ -396,7 +396,7 @@ int dsa_port_get_phy_strings(struct dsa_port *dp, uint8_t *data)
 	if (IS_ERR_OR_NULL(phydev))
 		return ret;
 
-	ret = phy_ethtool_get_strings(phydev, data);
+	ret = phy_ethtool_get_strings(phydev, stringset, data);
 	put_device(&phydev->mdio.dev);
 
 	return ret;
@@ -422,7 +422,7 @@ int dsa_port_get_ethtool_phy_stats(struct dsa_port *dp, uint64_t *data)
 }
 EXPORT_SYMBOL_GPL(dsa_port_get_ethtool_phy_stats);
 
-int dsa_port_get_phy_sset_count(struct dsa_port *dp)
+int dsa_port_get_phy_sset_count(struct dsa_port *dp, int sset)
 {
 	struct phy_device *phydev;
 	int ret = -EOPNOTSUPP;
@@ -434,7 +434,7 @@ int dsa_port_get_phy_sset_count(struct dsa_port *dp)
 	if (IS_ERR_OR_NULL(phydev))
 		return ret;
 
-	ret = phy_ethtool_get_sset_count(phydev);
+	ret = phy_ethtool_get_sset_count(phydev, sset);
 	put_device(&phydev->mdio.dev);
 
 	return ret;
-- 
2.14.1
