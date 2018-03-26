Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeCZUOO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 16:14:14 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:21690 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeCZUNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 16:13:02 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <ssantosh@kernel.org>,
        <malat@debian.org>, <w-kwok2@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>
Subject: [net-next PATCH 3/5] net: netcp: ethss enhancements to support 2u cpsw h/w on K2G SoC
Date: Mon, 26 Mar 2018 16:15:10 -0400
Message-ID: <1522095312-23249-4-git-send-email-m-karicheri2@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522095312-23249-1-git-send-email-m-karicheri2@ti.com>
References: <1522095312-23249-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K2G SoC uses 2u cpsw h/w. It uses RGMII instead of SGMII to interface with
Phy. This patch enhances the driver to check RGMII status instead of SGMII
status for link state determination. Also map all of the vlan priorities
to zero as the packet DMA is enabled to receive only flow id 0 which maps
to priority zero.

Additionally, When a phy with rgmii interface requires internal delay, the
same is set in the phy driver. To support such phy devices, add a phy-mode
handling code in the driver using of_get_phy_mode() and pass the obtained
phy mode to of_phy_connect()

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Wingman Kwok <w-kwok2@ti.com>
---
 drivers/net/ethernet/ti/netcp.h       |  3 ++
 drivers/net/ethernet/ti/netcp_ethss.c | 75 ++++++++++++++++++++++++++++++-----
 2 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ti/netcp.h b/drivers/net/ethernet/ti/netcp.h
index 8900a6f..3e3193c 100644
--- a/drivers/net/ethernet/ti/netcp.h
+++ b/drivers/net/ethernet/ti/netcp.h
@@ -33,6 +33,9 @@
 #define SGMII_LINK_MAC_MAC_FORCED	2
 #define SGMII_LINK_MAC_FIBER		3
 #define SGMII_LINK_MAC_PHY_NO_MDIO	4
+#define RGMII_LINK_MAC_PHY		5
+#define RGMII_LINK_MAC_MAC_FORCED	6
+#define RGMII_LINK_MAC_PHY_NO_MDIO	7
 #define XGMII_LINK_MAC_PHY		10
 #define XGMII_LINK_MAC_MAC_FORCED	11
 
diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 56dbc0b..df163ec 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -21,6 +21,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_mdio.h>
+#include <linux/of_net.h>
 #include <linux/of_address.h>
 #include <linux/if_vlan.h>
 #include <linux/ptp_classify.h>
@@ -166,6 +167,9 @@
 #define	GBE_RXHOOK_ORDER			0
 #define GBE_DEFAULT_ALE_AGEOUT			30
 #define SLAVE_LINK_IS_XGMII(s) ((s)->link_interface >= XGMII_LINK_MAC_PHY)
+#define SLAVE_LINK_IS_RGMII(s) \
+	(((s)->link_interface >= RGMII_LINK_MAC_PHY) && \
+	 ((s)->link_interface <= RGMII_LINK_MAC_PHY_NO_MDIO))
 #define NETCP_LINK_STATE_INVALID		-1
 
 #define GBE_SET_REG_OFS(p, rb, rn) p->rb##_ofs.rn = \
@@ -549,6 +553,7 @@ struct gbe_ss_regs {
 struct gbe_ss_regs_ofs {
 	u16	id_ver;
 	u16	control;
+	u16	rgmii_status; /* 2U */
 };
 
 struct gbe_switch_regs {
@@ -591,6 +596,7 @@ struct gbe_port_regs {
 struct gbe_port_regs_ofs {
 	u16	port_vlan;
 	u16	tx_pri_map;
+	u16     rx_pri_map;
 	u16	sa_lo;
 	u16	sa_hi;
 	u16	ts_ctl;
@@ -695,6 +701,7 @@ struct gbe_slave {
 	u32				link_interface;
 	u32				mac_control;
 	u8				phy_port_t;
+	struct device_node		*node;
 	struct device_node		*phy_node;
 	struct ts_ctl                   ts_ctl;
 	struct list_head		slave_list;
@@ -2091,8 +2098,9 @@ static void netcp_ethss_link_state_action(struct gbe_priv *gbe_dev,
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
@@ -2101,8 +2109,9 @@ static void netcp_ethss_link_state_action(struct gbe_priv *gbe_dev,
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
 
@@ -2115,23 +2124,39 @@ static bool gbe_phy_link_status(struct gbe_slave *slave)
 	 return !slave->phy || slave->phy->link;
 }
 
+#define RGMII_REG_STATUS_LINK	BIT(0)
+
+static void netcp_2u_rgmii_get_port_link(struct gbe_priv *gbe_dev, bool *status)
+{
+	u32 val = 0;
+
+	val = readl(GBE_REG_ADDR(gbe_dev, ss_regs, rgmii_status));
+	*status = false;
+	if ((val & RGMII_REG_STATUS_LINK) != 0)
+		*status = true;
+}
+
 static void netcp_ethss_update_link_state(struct gbe_priv *gbe_dev,
 					  struct gbe_slave *slave,
 					  struct net_device *ndev)
 {
-	int sp = slave->slave_num;
-	int phy_link_state, sgmii_link_state = 1, link_state;
+	bool sw_link_state = true, phy_link_state;
+	int sp = slave->slave_num, link_state;
 
 	if (!slave->open)
 		return;
 
 	if (!SLAVE_LINK_IS_XGMII(slave)) {
-		sgmii_link_state =
+		if (SLAVE_LINK_IS_RGMII(slave))
+			netcp_2u_rgmii_get_port_link(gbe_dev,
+						     &sw_link_state);
+		else
+			sw_link_state =
 			netcp_sgmii_get_port_link(SGMII_BASE(gbe_dev, sp), sp);
 	}
 
 	phy_link_state = gbe_phy_link_status(slave);
-	link_state = phy_link_state & sgmii_link_state;
+	link_state = phy_link_state & sw_link_state;
 
 	if (atomic_xchg(&slave->link_state, link_state) != link_state)
 		netcp_ethss_link_state_action(gbe_dev, ndev, slave,
@@ -2271,11 +2296,19 @@ static int gbe_slave_open(struct gbe_intf *gbe_intf)
 
 	void (*hndlr)(struct net_device *) = gbe_adjust_link;
 
-	gbe_sgmii_config(priv, slave);
+	if ((priv->ss_version == GBE_SS_VERSION_14) || IS_SS_ID_NU(priv))
+		gbe_sgmii_config(priv, slave);
 	gbe_port_reset(slave);
 	gbe_sgmii_rtreset(priv, slave, false);
 	gbe_port_config(priv, slave, priv->rx_packet_max);
 	gbe_set_slave_mac(slave, gbe_intf);
+	/* For NU & 2U switch, map the vlan priorities to zero
+	 * as we only configure to use priority 0
+	 */
+	if (IS_SS_ID_MU(priv))
+		writel(HOST_TX_PRI_MAP_DEFAULT,
+		       GBE_REG_ADDR(slave, port_regs, rx_pri_map));
+
 	/* enable forwarding */
 	cpsw_ale_control_set(priv->ale, slave->port_num,
 			     ALE_PORT_STATE, ALE_PORT_STATE_FORWARD);
@@ -2286,6 +2319,15 @@ static int gbe_slave_open(struct gbe_intf *gbe_intf)
 		has_phy = true;
 		phy_mode = PHY_INTERFACE_MODE_SGMII;
 		slave->phy_port_t = PORT_MII;
+	} else if (slave->link_interface == RGMII_LINK_MAC_PHY) {
+		has_phy = true;
+		phy_mode = of_get_phy_mode(slave->node);
+		/* if phy-mode is not present, default to
+		 * PHY_INTERFACE_MODE_RGMII
+		 */
+		if (phy_mode < 0)
+			phy_mode = PHY_INTERFACE_MODE_RGMII;
+		slave->phy_port_t = PORT_MII;
 	} else if (slave->link_interface == XGMII_LINK_MAC_PHY) {
 		has_phy = true;
 		phy_mode = PHY_INTERFACE_MODE_NA;
@@ -2911,8 +2953,10 @@ static int init_slave(struct gbe_priv *gbe_dev, struct gbe_slave *slave,
 		slave->link_interface = SGMII_LINK_MAC_PHY;
 	}
 
+	slave->node = node;
 	slave->open = false;
 	if ((slave->link_interface == SGMII_LINK_MAC_PHY) ||
+	    (slave->link_interface == RGMII_LINK_MAC_PHY) ||
 	    (slave->link_interface == XGMII_LINK_MAC_PHY))
 		slave->phy_node = of_parse_phandle(node, "phy-handle", 0);
 	slave->port_num = gbe_get_slave_port(gbe_dev, slave->slave_num);
@@ -2976,6 +3020,7 @@ static int init_slave(struct gbe_priv *gbe_dev, struct gbe_slave *slave,
 		/* Initialize  slave port register offsets */
 		GBENU_SET_REG_OFS(slave, port_regs, port_vlan);
 		GBENU_SET_REG_OFS(slave, port_regs, tx_pri_map);
+		GBENU_SET_REG_OFS(slave, port_regs, rx_pri_map);
 		GBENU_SET_REG_OFS(slave, port_regs, sa_lo);
 		GBENU_SET_REG_OFS(slave, port_regs, sa_hi);
 		GBENU_SET_REG_OFS(slave, port_regs, ts_ctl);
@@ -3039,7 +3084,9 @@ static void init_secondary_ports(struct gbe_priv *gbe_dev,
 			continue;
 		}
 
-		gbe_sgmii_config(gbe_dev, slave);
+		if ((gbe_dev->ss_version == GBE_SS_VERSION_14) ||
+		    IS_SS_ID_NU(gbe_dev))
+			gbe_sgmii_config(gbe_dev, slave);
 		gbe_port_reset(slave);
 		gbe_port_config(gbe_dev, slave, gbe_dev->rx_packet_max);
 		list_add_tail(&slave->slave_list, &gbe_dev->secondary_slaves);
@@ -3073,6 +3120,9 @@ static void init_secondary_ports(struct gbe_priv *gbe_dev,
 	if (slave->link_interface == SGMII_LINK_MAC_PHY) {
 		phy_mode = PHY_INTERFACE_MODE_SGMII;
 		slave->phy_port_t = PORT_MII;
+	} else if (slave->link_interface == RGMII_LINK_MAC_PHY) {
+		phy_mode = PHY_INTERFACE_MODE_RGMII;
+		slave->phy_port_t = PORT_MII;
 	} else {
 		phy_mode = PHY_INTERFACE_MODE_NA;
 		slave->phy_port_t = PORT_FIBRE;
@@ -3080,6 +3130,7 @@ static void init_secondary_ports(struct gbe_priv *gbe_dev,
 
 	for_each_sec_slave(slave, gbe_dev) {
 		if ((slave->link_interface != SGMII_LINK_MAC_PHY) &&
+		    (slave->link_interface != RGMII_LINK_MAC_PHY) &&
 		    (slave->link_interface != XGMII_LINK_MAC_PHY))
 			continue;
 		slave->phy =
@@ -3355,7 +3406,7 @@ static int set_gbenu_ethss_priv(struct gbe_priv *gbe_dev,
 	gbe_dev->num_stats_mods = gbe_dev->max_num_ports;
 	gbe_dev->et_stats = gbenu_et_stats;
 
-	if (IS_SS_ID_NU(gbe_dev))
+	if (IS_SS_ID_MU(gbe_dev))
 		gbe_dev->num_et_stats = GBENU_ET_STATS_HOST_SIZE +
 			(gbe_dev->max_num_slaves * GBENU_ET_STATS_PORT_SIZE);
 	else
@@ -3419,6 +3470,8 @@ static int set_gbenu_ethss_priv(struct gbe_priv *gbe_dev,
 
 	/* Subsystem registers */
 	GBENU_SET_REG_OFS(gbe_dev, ss_regs, id_ver);
+	/* ok to set for MU, but used by 2U only */
+	GBENU_SET_REG_OFS(gbe_dev, ss_regs, rgmii_status);
 
 	/* Switch module registers */
 	GBENU_SET_REG_OFS(gbe_dev, switch_regs, id_ver);
-- 
1.9.1
