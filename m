Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbeDQV23 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 17:28:29 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:23127 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbeDQV2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 17:28:21 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <ssantosh@kernel.org>,
        <malat@debian.org>, <w-kwok2@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
Subject: [net-next PATCH v4 05/13] net: netcp: ethss: add support for handling rgmii link interface
Date: Tue, 17 Apr 2018 17:30:34 -0400
Message-ID: <1524000642-23944-6-git-send-email-m-karicheri2@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
References: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2u cpsw hardware on K2G uses rgmii link to interface with Phy. So add
support for this interface in the code so that driver can be re-used
for 2u hardware.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/net/ethernet/ti/netcp.h       |  2 ++
 drivers/net/ethernet/ti/netcp_ethss.c | 15 +++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/netcp.h b/drivers/net/ethernet/ti/netcp.h
index 8900a6f..416f732 100644
--- a/drivers/net/ethernet/ti/netcp.h
+++ b/drivers/net/ethernet/ti/netcp.h
@@ -33,6 +33,8 @@
 #define SGMII_LINK_MAC_MAC_FORCED	2
 #define SGMII_LINK_MAC_FIBER		3
 #define SGMII_LINK_MAC_PHY_NO_MDIO	4
+#define RGMII_LINK_MAC_PHY		5
+#define RGMII_LINK_MAC_PHY_NO_MDIO	7
 #define XGMII_LINK_MAC_PHY		10
 #define XGMII_LINK_MAC_MAC_FORCED	11
 
diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index e1e67ff..68b10b5 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -2096,8 +2096,9 @@ static void netcp_ethss_link_state_action(struct gbe_priv *gbe_dev,
 				     ALE_PORT_STATE_FORWARD);
 
 		if (ndev && slave->open &&
-		    slave->link_interface != SGMII_LINK_MAC_PHY &&
-		    slave->link_interface != XGMII_LINK_MAC_PHY)
+		    ((slave->link_interface != SGMII_LINK_MAC_PHY) &&
+		    (slave->link_interface != RGMII_LINK_MAC_PHY) &&
+		    (slave->link_interface != XGMII_LINK_MAC_PHY)))
 			netif_carrier_on(ndev);
 	} else {
 		writel(mac_control, GBE_REG_ADDR(slave, emac_regs,
@@ -2106,8 +2107,9 @@ static void netcp_ethss_link_state_action(struct gbe_priv *gbe_dev,
 				     ALE_PORT_STATE,
 				     ALE_PORT_STATE_DISABLE);
 		if (ndev &&
-		    slave->link_interface != SGMII_LINK_MAC_PHY &&
-		    slave->link_interface != XGMII_LINK_MAC_PHY)
+		    ((slave->link_interface != SGMII_LINK_MAC_PHY) &&
+		    (slave->link_interface != RGMII_LINK_MAC_PHY) &&
+		    (slave->link_interface != XGMII_LINK_MAC_PHY)))
 			netif_carrier_off(ndev);
 	}
 
@@ -2921,6 +2923,7 @@ static int init_slave(struct gbe_priv *gbe_dev, struct gbe_slave *slave,
 
 	slave->open = false;
 	if ((slave->link_interface == SGMII_LINK_MAC_PHY) ||
+	    (slave->link_interface == RGMII_LINK_MAC_PHY) ||
 	    (slave->link_interface == XGMII_LINK_MAC_PHY))
 		slave->phy_node = of_parse_phandle(node, "phy-handle", 0);
 	slave->port_num = gbe_get_slave_port(gbe_dev, slave->slave_num);
@@ -3082,6 +3085,9 @@ static void init_secondary_ports(struct gbe_priv *gbe_dev,
 	if (slave->link_interface == SGMII_LINK_MAC_PHY) {
 		phy_mode = PHY_INTERFACE_MODE_SGMII;
 		slave->phy_port_t = PORT_MII;
+	} else if (slave->link_interface == RGMII_LINK_MAC_PHY) {
+		phy_mode = PHY_INTERFACE_MODE_RGMII;
+		slave->phy_port_t = PORT_MII;
 	} else {
 		phy_mode = PHY_INTERFACE_MODE_NA;
 		slave->phy_port_t = PORT_FIBRE;
@@ -3089,6 +3095,7 @@ static void init_secondary_ports(struct gbe_priv *gbe_dev,
 
 	for_each_sec_slave(slave, gbe_dev) {
 		if ((slave->link_interface != SGMII_LINK_MAC_PHY) &&
+		    (slave->link_interface != RGMII_LINK_MAC_PHY) &&
 		    (slave->link_interface != XGMII_LINK_MAC_PHY))
 			continue;
 		slave->phy =
-- 
1.9.1
