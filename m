Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753437AbeDQVcr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 17:32:47 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:23126 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752327AbeDQV2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 17:28:21 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <ssantosh@kernel.org>,
        <malat@debian.org>, <w-kwok2@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
Subject: [net-next PATCH v4 07/13] net: netcp: ethss: map vlan priorities to zero flow
Date: Tue, 17 Apr 2018 17:30:36 -0400
Message-ID: <1524000642-23944-8-git-send-email-m-karicheri2@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
References: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver currently support only vlan priority zero. So map the
vlan priorities to zero flow in hardware.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/net/ethernet/ti/netcp_ethss.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 83acb72..91935e5 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -602,6 +602,7 @@ struct gbe_port_regs {
 struct gbe_port_regs_ofs {
 	u16	port_vlan;
 	u16	tx_pri_map;
+	u16     rx_pri_map;
 	u16	sa_lo;
 	u16	sa_hi;
 	u16	ts_ctl;
@@ -2304,6 +2305,13 @@ static int gbe_slave_open(struct gbe_intf *gbe_intf)
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
@@ -3005,6 +3013,7 @@ static int init_slave(struct gbe_priv *gbe_dev, struct gbe_slave *slave,
 		/* Initialize  slave port register offsets */
 		GBENU_SET_REG_OFS(slave, port_regs, port_vlan);
 		GBENU_SET_REG_OFS(slave, port_regs, tx_pri_map);
+		GBENU_SET_REG_OFS(slave, port_regs, rx_pri_map);
 		GBENU_SET_REG_OFS(slave, port_regs, sa_lo);
 		GBENU_SET_REG_OFS(slave, port_regs, sa_hi);
 		GBENU_SET_REG_OFS(slave, port_regs, ts_ctl);
-- 
1.9.1
