Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754060AbeC1Wob (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 18:44:31 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45472 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753365AbeC1WoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 18:44:23 -0400
X-Google-Smtp-Source: AIpwx4+Ac8Hk1TlofY1ppBgDJ0MLXFZCks35OGvWSm5XNouD8TEXAkuE9Defip/r0zKSJ0CBXRKvVA==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org (open list),
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Yan Markman <ymarkman@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Miquel Raynal <miquel.raynal@free-electrons.com>,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH net-next v2 1/2] net: phy: phylink: Provide PHY interface to mac_link_{up,down}
Date: Wed, 28 Mar 2018 15:44:15 -0700
Message-Id: <20180328224416.6981-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180328224416.6981-1-f.fainelli@gmail.com>
References: <20180328224416.6981-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for having DSA transition entirely to PHYLINK, we need to pass a
PHY interface type to the mac_link_{up,down} callbacks because we may have to
make decisions on that (e.g: turn on/off RGMII interfaces etc.). We do not pass
an entire phylink_link_state because not all parameters (pause, duplex etc.) are
defined when the link is down, only link and interface are.

Update mvneta accordingly since it currently implements phylink_mac_ops.

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/marvell/mvneta.c |  4 +++-
 drivers/net/phy/phylink.c             |  4 +++-
 include/linux/phylink.h               | 14 +++++++++++---
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index eaa4bb80f1c9..cd09bde55596 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3396,7 +3396,8 @@ static void mvneta_set_eee(struct mvneta_port *pp, bool enable)
 	mvreg_write(pp, MVNETA_LPI_CTRL_1, lpi_ctl1);
 }
 
-static void mvneta_mac_link_down(struct net_device *ndev, unsigned int mode)
+static void mvneta_mac_link_down(struct net_device *ndev, unsigned int mode,
+				 phy_interface_t interface)
 {
 	struct mvneta_port *pp = netdev_priv(ndev);
 	u32 val;
@@ -3415,6 +3416,7 @@ static void mvneta_mac_link_down(struct net_device *ndev, unsigned int mode)
 }
 
 static void mvneta_mac_link_up(struct net_device *ndev, unsigned int mode,
+			       phy_interface_t interface,
 			       struct phy_device *phy)
 {
 	struct mvneta_port *pp = netdev_priv(ndev);
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 51a011a349fe..9b1e4721ea3a 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -470,10 +470,12 @@ static void phylink_resolve(struct work_struct *w)
 	if (link_state.link != netif_carrier_ok(ndev)) {
 		if (!link_state.link) {
 			netif_carrier_off(ndev);
-			pl->ops->mac_link_down(ndev, pl->link_an_mode);
+			pl->ops->mac_link_down(ndev, pl->link_an_mode,
+					       pl->phy_state.interface);
 			netdev_info(ndev, "Link is Down\n");
 		} else {
 			pl->ops->mac_link_up(ndev, pl->link_an_mode,
+					     pl->phy_state.interface,
 					     pl->phydev);
 
 			netif_carrier_on(ndev);
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index bd137c273d38..e95cc12030fa 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -73,8 +73,10 @@ struct phylink_mac_ops {
 	void (*mac_config)(struct net_device *ndev, unsigned int mode,
 			   const struct phylink_link_state *state);
 	void (*mac_an_restart)(struct net_device *ndev);
-	void (*mac_link_down)(struct net_device *ndev, unsigned int mode);
+	void (*mac_link_down)(struct net_device *ndev, unsigned int mode,
+			      phy_interface_t interface);
 	void (*mac_link_up)(struct net_device *ndev, unsigned int mode,
+			    phy_interface_t interface,
 			    struct phy_device *phy);
 };
 
@@ -161,25 +163,31 @@ void mac_an_restart(struct net_device *ndev);
  * mac_link_down() - take the link down
  * @ndev: a pointer to a &struct net_device for the MAC.
  * @mode: link autonegotiation mode
+ * @interface: link &typedef phy_interface_t mode
  *
  * If @mode is not an in-band negotiation mode (as defined by
  * phylink_autoneg_inband()), force the link down and disable any
- * Energy Efficient Ethernet MAC configuration.
+ * Energy Efficient Ethernet MAC configuration. Interface type
+ * selection must be done in mac_config().
  */
-void mac_link_down(struct net_device *ndev, unsigned int mode);
+void mac_link_down(struct net_device *ndev, unsigned int mode,
+		   phy_interface_t interface);
 
 /**
  * mac_link_up() - allow the link to come up
  * @ndev: a pointer to a &struct net_device for the MAC.
  * @mode: link autonegotiation mode
+ * @interface: link &typedef phy_interface_t mode
  * @phy: any attached phy
  *
  * If @mode is not an in-band negotiation mode (as defined by
  * phylink_autoneg_inband()), allow the link to come up. If @phy
  * is non-%NULL, configure Energy Efficient Ethernet by calling
  * phy_init_eee() and perform appropriate MAC configuration for EEE.
+ * Interface type selection must be done in mac_config().
  */
 void mac_link_up(struct net_device *ndev, unsigned int mode,
+		 phy_interface_t interface,
 		 struct phy_device *phy);
 #endif
 
-- 
2.14.1
