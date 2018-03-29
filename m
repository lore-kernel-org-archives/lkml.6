Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751325AbeC2F7X convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 01:59:23 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:41876 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751182AbeC2F7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 01:59:20 -0400
From: Yan Markman <ymarkman@marvell.com>
To: Florian Fainelli <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Miquel Raynal <miquel.raynal@free-electrons.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Yelena Krivosheev <yelena@marvell.com>
Subject: RE: [EXT] [PATCH net-next v2 1/2] net: phy: phylink: Provide PHY
 interface to mac_link_{up,down}
Thread-Topic: [EXT] [PATCH net-next v2 1/2] net: phy: phylink: Provide PHY
 interface to mac_link_{up,down}
Thread-Index: AQHTxuZTe3I/uM/sTEyeUn5wn3S4MaPmuDiw
Date: Thu, 29 Mar 2018 05:59:02 +0000
Message-ID: <843035ef7cfb45a7a02be516b8fcdd49@IL-EXCH01.marvell.com>
References: <20180328224416.6981-1-f.fainelli@gmail.com>
 <20180328224416.6981-2-f.fainelli@gmail.com>
In-Reply-To: <20180328224416.6981-2-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.5.102.207]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-29_03:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803290067
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian
Please keep CC 		Yelena Krivosheev <yelena@marvell.com>
for changes with 	drivers/net/ethernet/marvell/mvneta.c
Thanks
Yan Markman
Tel. 05-44732819


-----Original Message-----
From: Florian Fainelli [mailto:f.fainelli@gmail.com] 
Sent: Thursday, March 29, 2018 1:44 AM
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>; Thomas Petazzoni <thomas.petazzoni@free-electrons.com>; Andrew Lunn <andrew@lunn.ch>; David S. Miller <davem@davemloft.net>; Russell King <rmk+kernel@armlinux.org.uk>; open list <linux-kernel@vger.kernel.org>; Antoine Tenart <antoine.tenart@bootlin.com>; Yan Markman <ymarkman@marvell.com>; Stefan Chulski <stefanc@marvell.com>; Maxime Chevallier <maxime.chevallier@bootlin.com>; Miquel Raynal <miquel.raynal@free-electrons.com>; Marcin Wojtas <mw@semihalf.com>
Subject: [EXT] [PATCH net-next v2 1/2] net: phy: phylink: Provide PHY interface to mac_link_{up,down}

External Email

----------------------------------------------------------------------
In preparation for having DSA transition entirely to PHYLINK, we need to pass a PHY interface type to the mac_link_{up,down} callbacks because we may have to make decisions on that (e.g: turn on/off RGMII interfaces etc.). We do not pass an entire phylink_link_state because not all parameters (pause, duplex etc.) are defined when the link is down, only link and interface are.

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
 	mvreg_write(pp, MVNETA_LPI_CTRL_1, lpi_ctl1);  }
 
-static void mvneta_mac_link_down(struct net_device *ndev, unsigned int mode)
+static void mvneta_mac_link_down(struct net_device *ndev, unsigned int mode,
+				 phy_interface_t interface)
 {
 	struct mvneta_port *pp = netdev_priv(ndev);
 	u32 val;
@@ -3415,6 +3416,7 @@ static void mvneta_mac_link_down(struct net_device *ndev, unsigned int mode)  }
 
 static void mvneta_mac_link_up(struct net_device *ndev, unsigned int mode,
+			       phy_interface_t interface,
 			       struct phy_device *phy)
 {
 	struct mvneta_port *pp = netdev_priv(ndev); diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c index 51a011a349fe..9b1e4721ea3a 100644
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
diff --git a/include/linux/phylink.h b/include/linux/phylink.h index bd137c273d38..e95cc12030fa 100644
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
