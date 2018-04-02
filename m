Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752883AbeDBOh6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 10:37:58 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:53682 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752222AbeDBOfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 10:35:46 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <ssantosh@kernel.org>,
        <malat@debian.org>, <w-kwok2@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>
Subject: [net-next PATCH v3 07/11] net: netcp: ethss: map vlan priorities to zero flow
Date: Mon, 2 Apr 2018 10:37:57 -0400
Message-ID: <1522679881-25643-8-git-send-email-m-karicheri2@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522679881-25643-1-git-send-email-m-karicheri2@ti.com>
References: <1522679881-25643-1-git-send-email-m-karicheri2@ti.com>
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
index ab6c918..33d70d4 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -600,6 +600,7 @@ struct gbe_port_regs {
 struct gbe_port_regs_ofs {
 	u16	port_vlan;
 	u16	tx_pri_map;
+	u16     rx_pri_map;
 	u16	sa_lo;
 	u16	sa_hi;
 	u16	ts_ctl;
@@ -2300,6 +2301,13 @@ static int gbe_slave_open(struct gbe_intf *gbe_intf)
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
@@ -3001,6 +3009,7 @@ static int init_slave(struct gbe_priv *gbe_dev, struct gbe_slave *slave,
 		/* Initialize  slave port register offsets */
 		GBENU_SET_REG_OFS(slave, port_regs, port_vlan);
 		GBENU_SET_REG_OFS(slave, port_regs, tx_pri_map);
+		GBENU_SET_REG_OFS(slave, port_regs, rx_pri_map);
 		GBENU_SET_REG_OFS(slave, port_regs, sa_lo);
 		GBENU_SET_REG_OFS(slave, port_regs, sa_hi);
 		GBENU_SET_REG_OFS(slave, port_regs, ts_ctl);
-- 
1.9.1
