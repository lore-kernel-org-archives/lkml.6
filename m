Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933327AbeD1Ac6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 20:32:58 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35266 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933237AbeD1Acv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 20:32:51 -0400
X-Google-Smtp-Source: AB8JxZrMqaA+OzIIoSxbSmffM1y/KZ62QcWXadsfpsgxhzGgrEWlBAo17TmNUUwEoNU8dFKLBBYbaw==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Russell King <rmk@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list), davem@davemloft.net,
        cphealy@gmail.com, nikita.yoush@cogentembedded.com,
        vivien.didelot@savoirfairelinux.com, Nisar.Sayed@microchip.com,
        UNGLinuxDriver@microchip.com
Subject: [RFC net-next 3/5] net: ethtool: Add plumbing to get/set PHY test modes
Date: Fri, 27 Apr 2018 17:32:33 -0700
Message-Id: <20180428003237.1536-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180428003237.1536-1-f.fainelli@gmail.com>
References: <20180428003237.1536-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the core ethtool changes to get/set PHY test modes, no driver
implements that yet, but the internal API is defined and now allows it.
We also provide the required helpers in PHYLIB in order to call the
appropriate functions within the drivers.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/linux/phy.h | 63 ++++++++++++++++++++++++++++++++++++++++--
 net/core/ethtool.c  | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 135 insertions(+), 7 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index deba0c11647f..449afde7ca7c 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -659,6 +659,14 @@ struct phy_driver {
 			    struct ethtool_tunable *tuna,
 			    const void *data);
 	int (*set_loopback)(struct phy_device *dev, bool enable);
+
+	/* Get and Set PHY test modes */
+	int (*get_test_len)(struct phy_device *dev, u32 mode);
+	int (*get_test)(struct phy_device *dev,
+			struct ethtool_phy_test *test, u8 *data);
+	int (*set_test)(struct phy_device *dev,
+			struct ethtool_phy_test *test,
+			const u8 *data);
 };
 #define to_phy_driver(d) container_of(to_mdio_common_driver(d),		\
 				      struct phy_driver, mdiodrv)
@@ -1090,9 +1098,11 @@ static inline int phy_ethtool_get_sset_count(struct phy_device *phydev,
 	if (!phydev->drv)
 		return -EIO;
 
-	if (phydev->drv->get_sset_count &&
-	    phydev->drv->get_strings &&
-	    phydev->drv->get_stats) {
+	if (!phydev->drv->get_sset_count || !phydev->drv->get_strings)
+		return -EOPNOTSUPP;
+
+	if (phydev->drv->get_stats || phydev->drv->get_test_len ||
+	    phydev->drv->get_test || phydev->drv->set_test) {
 		mutex_lock(&phydev->lock);
 		ret = phydev->drv->get_sset_count(phydev, sset);
 		mutex_unlock(&phydev->lock);
@@ -1116,6 +1126,53 @@ static inline int phy_ethtool_get_stats(struct phy_device *phydev,
 	return 0;
 }
 
+static inline int phy_ethtool_get_test_len(struct phy_device *phydev,
+					   u32 mode)
+{
+	int ret;
+
+	if (!phydev->drv)
+		return -EIO;
+
+	mutex_lock(&phydev->lock);
+	ret = phydev->drv->get_test_len(phydev, mode);
+	mutex_unlock(&phydev->lock);
+
+	return ret;
+}
+
+static inline int phy_ethtool_get_test(struct phy_device *phydev,
+				       struct ethtool_phy_test *test,
+				       u8 *data)
+{
+	int ret;
+
+	if (!phydev->drv)
+		return -EIO;
+
+	mutex_lock(&phydev->lock);
+	ret = phydev->drv->get_test(phydev, test, data);
+	mutex_unlock(&phydev->lock);
+
+	return ret;
+}
+
+static inline int phy_ethtool_set_test(struct phy_device *phydev,
+				       struct ethtool_phy_test *test,
+				       const u8 *data)
+{
+	int ret;
+
+	if (!phydev->drv)
+		return -EIO;
+
+	mutex_lock(&phydev->lock);
+	ret = phydev->drv->set_test(phydev, test, data);
+	mutex_unlock(&phydev->lock);
+
+	return ret;
+}
+
 extern struct bus_type mdio_bus_type;
 
 struct mdio_board_info {
diff --git a/net/core/ethtool.c b/net/core/ethtool.c
index 0b9e2a44e1d1..52d2c9bc49b4 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -227,8 +227,9 @@ static int __ethtool_get_sset_count(struct net_device *dev, int sset)
 	if (sset == ETH_SS_PHY_TUNABLES)
 		return ARRAY_SIZE(phy_tunable_strings);
 
-	if (sset == ETH_SS_PHY_STATS && dev->phydev &&
-	    !ops->get_ethtool_phy_stats)
+	if ((sset == ETH_SS_PHY_STATS && dev->phydev &&
+	    !ops->get_ethtool_phy_stats) ||
+	    (sset == ETH_SS_PHY_TESTS && dev->phydev))
 		return phy_ethtool_get_sset_count(dev->phydev, sset);
 
 	if (ops->get_sset_count && ops->get_strings)
@@ -252,8 +253,9 @@ static void __ethtool_get_strings(struct net_device *dev,
 		memcpy(data, tunable_strings, sizeof(tunable_strings));
 	else if (stringset == ETH_SS_PHY_TUNABLES)
 		memcpy(data, phy_tunable_strings, sizeof(phy_tunable_strings));
-	else if (stringset == ETH_SS_PHY_STATS && dev->phydev &&
-		 !ops->get_ethtool_phy_stats)
+	else if ((stringset == ETH_SS_PHY_STATS && dev->phydev &&
+		 !ops->get_ethtool_phy_stats) ||
+		 (stringset == ETH_SS_PHY_TESTS && dev->phydev))
 		phy_ethtool_get_strings(dev->phydev, stringset, data);
 	else
 		/* ops->get_strings is valid because checked earlier */
@@ -2016,6 +2018,68 @@ static int ethtool_get_phy_stats(struct net_device *dev, void __user *useraddr)
 	return ret;
 }
 
+static int ethtool_get_phy_test(struct net_device *dev, void __user *useraddr)
+{
+	struct phy_device *phydev = dev->phydev;
+	struct ethtool_phy_test test;
+	int ret, test_len;
+	void *data;
+
+	if (!phydev)
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&test, useraddr, sizeof(test)))
+		return -EFAULT;
+
+	test_len = phy_ethtool_get_test_len(phydev, test.mode);
+	if (test_len < 0)
+		return test_len;
+
+	test.len = test_len;
+	data = kmalloc(test_len, GFP_USER);
+	if (test_len && !data)
+		return -ENOMEM;
+
+	ret = phy_ethtool_get_test(phydev, &test, data);
+	if (ret < 0)
+		goto out;
+
+	ret = -EFAULT;
+	if (copy_to_user(useraddr, &test, sizeof(test)))
+		goto out;
+	useraddr += sizeof(test);
+	if (test_len && copy_to_user(useraddr, data, test_len))
+		goto out;
+	ret = 0;
+out:
+	kfree(data);
+	return ret;
+}
+
+static int ethtool_set_phy_test(struct net_device *dev, void __user *useraddr)
+{
+	struct phy_device *phydev = dev->phydev;
+	struct ethtool_phy_test test;
+	void *data;
+	int ret;
+
+	if (!phydev)
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&test, useraddr, sizeof(test)))
+		return -EFAULT;
+
+	useraddr += sizeof(test);
+	data = memdup_user(useraddr, test.len);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	ret = phy_ethtool_set_test(phydev, &test, data);
+
+	kfree(data);
+	return ret;
+}
+
 static int ethtool_get_perm_addr(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_perm_addr epaddr;
@@ -2637,6 +2701,7 @@ int dev_ethtool(struct net *net, struct ifreq *ifr)
 	case ETHTOOL_PHY_GTUNABLE:
 	case ETHTOOL_GLINKSETTINGS:
 	case ETHTOOL_GFECPARAM:
+	case ETHTOOL_GPHYTEST:
 		break;
 	default:
 		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
@@ -2852,6 +2917,12 @@ int dev_ethtool(struct net *net, struct ifreq *ifr)
 	case ETHTOOL_SFECPARAM:
 		rc = ethtool_set_fecparam(dev, useraddr);
 		break;
+	case ETHTOOL_GPHYTEST:
+		rc = ethtool_get_phy_test(dev, useraddr);
+		break;
+	case ETHTOOL_SPHYTEST:
+		rc = ethtool_set_phy_test(dev, useraddr);
+		break;
 	default:
 		rc = -EOPNOTSUPP;
 	}
-- 
2.14.1
