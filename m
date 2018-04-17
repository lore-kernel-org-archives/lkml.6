Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbeDQV2a (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 17:28:30 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:54227 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753084AbeDQV21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 17:28:27 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <ssantosh@kernel.org>,
        <malat@debian.org>, <w-kwok2@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
Subject: [net-next PATCH v4 03/13] net: netcp: ethss: use macro for checking ss_version consistently
Date: Tue, 17 Apr 2018 17:30:32 -0400
Message-ID: <1524000642-23944-4-git-send-email-m-karicheri2@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
References: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver currently uses macro for NU and XBE hardwrae, while other
places for older hardware such as that on K2H/K SoC (version 1.4
of the cpsw hardware, it explicitly check for the ss_version
inline. Add a new macro for version 1.4 and use it to customize
code in the driver. While at it also fix similar issue with
checking XBE version by re-using existing macro IS_SS_ID_XGBE().

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/net/ethernet/ti/netcp_ethss.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 56dbc0b..1b79fe5 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -42,7 +42,7 @@
 
 /* 1G Ethernet SS defines */
 #define GBE_MODULE_NAME			"netcp-gbe"
-#define GBE_SS_VERSION_14		0x4ed21104
+#define GBE_SS_VERSION_14		0x4ed2
 
 #define GBE_SS_REG_INDEX		0
 #define GBE_SGMII34_REG_INDEX		1
@@ -72,6 +72,9 @@
 #define IS_SS_ID_NU(d) \
 	(GBE_IDENT((d)->ss_version) == GBE_SS_ID_NU)
 
+#define IS_SS_ID_VER_14(d) \
+	(GBE_IDENT((d)->ss_version) == GBE_SS_VERSION_14)
+
 #define GBENU_SS_REG_INDEX		0
 #define GBENU_SM_REG_INDEX		1
 #define GBENU_SGMII_MODULE_OFFSET	0x100
@@ -86,7 +89,7 @@
 
 /* 10G Ethernet SS defines */
 #define XGBE_MODULE_NAME		"netcp-xgbe"
-#define XGBE_SS_VERSION_10		0x4ee42100
+#define XGBE_SS_VERSION_10		0x4ee4
 
 #define XGBE_SS_REG_INDEX		0
 #define XGBE_SM_REG_INDEX		1
@@ -1915,7 +1918,7 @@ static void keystone_get_ethtool_stats(struct net_device *ndev,
 
 	gbe_dev = gbe_intf->gbe_dev;
 	spin_lock_bh(&gbe_dev->hw_stats_lock);
-	if (gbe_dev->ss_version == GBE_SS_VERSION_14)
+	if (IS_SS_ID_VER_14(gbe_dev))
 		gbe_update_stats_ver14(gbe_dev, data);
 	else
 		gbe_update_stats(gbe_dev, data);
@@ -2205,7 +2208,7 @@ static void gbe_port_config(struct gbe_priv *gbe_dev, struct gbe_slave *slave,
 		max_rx_len = NETCP_MAX_FRAME_SIZE;
 
 	/* Enable correct MII mode at SS level */
-	if ((gbe_dev->ss_version == XGBE_SS_VERSION_10) &&
+	if (IS_SS_ID_XGBE(gbe_dev) &&
 	    (slave->link_interface >= XGMII_LINK_MAC_PHY)) {
 		xgmii_mode = readl(GBE_REG_ADDR(gbe_dev, ss_regs, control));
 		xgmii_mode |= (1 << slave->slave_num);
@@ -2293,7 +2296,7 @@ static int gbe_slave_open(struct gbe_intf *gbe_intf)
 	}
 
 	if (has_phy) {
-		if (priv->ss_version == XGBE_SS_VERSION_10)
+		if (IS_SS_ID_XGBE(priv))
 			hndlr = xgbe_adjust_link;
 
 		slave->phy = of_phy_connect(gbe_intf->ndev,
@@ -2764,7 +2767,7 @@ static void netcp_ethss_timer(struct timer_list *t)
 	/* A timer runs as a BH, no need to block them */
 	spin_lock(&gbe_dev->hw_stats_lock);
 
-	if (gbe_dev->ss_version == GBE_SS_VERSION_14)
+	if (IS_SS_ID_VER_14(gbe_dev))
 		gbe_update_stats_ver14(gbe_dev, NULL);
 	else
 		gbe_update_stats(gbe_dev, NULL);
@@ -2807,7 +2810,7 @@ static int gbe_open(void *intf_priv, struct net_device *ndev)
 		GBE_RTL_VERSION(reg), GBE_IDENT(reg));
 
 	/* For 10G and on NetCP 1.5, use directed to port */
-	if ((gbe_dev->ss_version == XGBE_SS_VERSION_10) || IS_SS_ID_MU(gbe_dev))
+	if (IS_SS_ID_XGBE(gbe_dev) || IS_SS_ID_MU(gbe_dev))
 		gbe_intf->tx_pipe.flags = SWITCH_TO_PORT_IN_TAGINFO;
 
 	if (gbe_dev->enable_ale)
@@ -2924,7 +2927,7 @@ static int init_slave(struct gbe_priv *gbe_dev, struct gbe_slave *slave,
 
 	/* Emac regs memmap are contiguous but port regs are not */
 	port_reg_num = slave->slave_num;
-	if (gbe_dev->ss_version == GBE_SS_VERSION_14) {
+	if (IS_SS_ID_VER_14(gbe_dev)) {
 		if (slave->slave_num > 1) {
 			port_reg_ofs = GBE13_SLAVE_PORT2_OFFSET;
 			port_reg_num -= 2;
@@ -2939,7 +2942,7 @@ static int init_slave(struct gbe_priv *gbe_dev, struct gbe_slave *slave,
 		emac_reg_ofs = GBENU_EMAC_OFFSET;
 		port_reg_blk_sz = 0x1000;
 		emac_reg_blk_sz = 0x1000;
-	} else if (gbe_dev->ss_version == XGBE_SS_VERSION_10) {
+	} else if (IS_SS_ID_XGBE(gbe_dev)) {
 		port_reg_ofs = XGBE10_SLAVE_PORT_OFFSET;
 		emac_reg_ofs = XGBE10_EMAC_OFFSET;
 		port_reg_blk_sz = 0x30;
@@ -2955,7 +2958,7 @@ static int init_slave(struct gbe_priv *gbe_dev, struct gbe_slave *slave,
 	slave->emac_regs = gbe_dev->switch_regs + emac_reg_ofs +
 				(emac_reg_blk_sz * slave->slave_num);
 
-	if (gbe_dev->ss_version == GBE_SS_VERSION_14) {
+	if (IS_SS_ID_VER_14(gbe_dev)) {
 		/* Initialize  slave port register offsets */
 		GBE_SET_REG_OFS(slave, port_regs, port_vlan);
 		GBE_SET_REG_OFS(slave, port_regs, tx_pri_map);
@@ -2989,7 +2992,7 @@ static int init_slave(struct gbe_priv *gbe_dev, struct gbe_slave *slave,
 		GBENU_SET_REG_OFS(slave, emac_regs, mac_control);
 		GBENU_SET_REG_OFS(slave, emac_regs, soft_reset);
 
-	} else if (gbe_dev->ss_version == XGBE_SS_VERSION_10) {
+	} else if (IS_SS_ID_XGBE(gbe_dev)) {
 		/* Initialize  slave port register offsets */
 		XGBE_SET_REG_OFS(slave, port_regs, port_vlan);
 		XGBE_SET_REG_OFS(slave, port_regs, tx_pri_map);
@@ -3508,7 +3511,7 @@ static int gbe_probe(struct netcp_device *netcp_device, struct device *dev,
 
 		dev_dbg(dev, "ss_version: 0x%08x\n", gbe_dev->ss_version);
 
-		if (gbe_dev->ss_version == GBE_SS_VERSION_14)
+		if (IS_SS_ID_VER_14(gbe_dev))
 			ret = set_gbe_ethss14_priv(gbe_dev, node);
 		else if (IS_SS_ID_MU(gbe_dev))
 			ret = set_gbenu_ethss_priv(gbe_dev, node);
@@ -3606,7 +3609,7 @@ static int gbe_probe(struct netcp_device *netcp_device, struct device *dev,
 
 	spin_lock_bh(&gbe_dev->hw_stats_lock);
 	for (i = 0; i < gbe_dev->num_stats_mods; i++) {
-		if (gbe_dev->ss_version == GBE_SS_VERSION_14)
+		if (IS_SS_ID_VER_14(gbe_dev))
 			gbe_reset_mod_stats_ver14(gbe_dev, i);
 		else
 			gbe_reset_mod_stats(gbe_dev, i);
-- 
1.9.1
