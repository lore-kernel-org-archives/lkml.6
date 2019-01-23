Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C45C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE7A21855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfAWP7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:59:25 -0500
Received: from mail.bootlin.com ([62.4.15.54]:42272 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbfAWP7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:59:18 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 28361209EF; Wed, 23 Jan 2019 16:59:15 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3559120A15;
        Wed, 23 Jan 2019 16:58:57 +0100 (CET)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, sd@queasysnail.net, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        quentin.schulz@bootlin.com, allan.nielsen@microchip.com
Subject: [PATCH net-next 05/10] net: phy: introduce a phy_driver macsec helper
Date:   Wed, 23 Jan 2019 16:56:33 +0100
Message-Id: <20190123155638.13852-6-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123155638.13852-1-antoine.tenart@bootlin.com>
References: <20190123155638.13852-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a phy_driver MACsec helper to allow PHYs to
implement a MACsec offloading solution. The phy_driver MACsec helper is
called through a wrapper, phy_macsec, to perform this call while holding
the phydev lock.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/phy/phy.c | 17 +++++++++++++++++
 include/linux/phy.h   |  9 +++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 631ed33fe9d9..6b37bb845ce9 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1095,6 +1095,23 @@ int phy_get_eee_err(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_get_eee_err);
 
+int phy_macsec(struct phy_device *phydev, struct netdev_macsec *macsec)
+{
+	int ret = -EOPNOTSUPP;
+
+	if (!phydev->drv)
+		return -EIO;
+
+	mutex_lock(&phydev->lock);
+
+	if (phydev->drv->macsec)
+		ret = phydev->drv->macsec(phydev, macsec);
+
+	mutex_unlock(&phydev->lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_macsec);
+
 /**
  * phy_ethtool_get_eee - get EEE supported and status
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 1f3873a2ff29..21839f352e7c 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -27,6 +27,10 @@
 #include <linux/workqueue.h>
 #include <linux/mod_devicetable.h>
 
+#ifdef CONFIG_MACSEC
+#include <net/macsec.h>
+#endif
+
 #include <linux/atomic.h>
 
 #define PHY_DEFAULT_FEATURES	(SUPPORTED_Autoneg | \
@@ -630,6 +634,10 @@ struct phy_driver {
 			    struct ethtool_tunable *tuna,
 			    const void *data);
 	int (*set_loopback)(struct phy_device *dev, bool enable);
+
+#ifdef CONFIG_MACSEC
+	int (*macsec)(struct phy_device *dev, struct netdev_macsec *macsec);
+#endif
 };
 #define to_phy_driver(d) container_of(to_mdio_common_driver(d),		\
 				      struct phy_driver, mdiodrv)
@@ -1072,6 +1080,7 @@ int phy_unregister_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask);
 
 int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable);
 int phy_get_eee_err(struct phy_device *phydev);
+int phy_macsec(struct phy_device *phydev, struct netdev_macsec *macsec);
 int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_eee *data);
 int phy_ethtool_get_eee(struct phy_device *phydev, struct ethtool_eee *data);
 int phy_ethtool_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol);
-- 
2.20.1

