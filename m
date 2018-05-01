Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756320AbeEARl3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 13:41:29 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:12617 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756284AbeEARl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 13:41:26 -0400
From: Grygorii Strashko <grygorii.strashko@ti.com>
To: "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>
CC: Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] net: ethernet: ti: cpsw: fix packet leaking in dual_mac mode
Date: Tue, 1 May 2018 12:41:22 -0500
Message-ID: <20180501174122.11323-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dual_mac mode packets arrived on one port should not be forwarded by
switch hw to another port. Only Linux Host can forward packets between
ports. The below test case (reported in [1]) shows that packet arrived on
one port can be leaked to anoter (reproducible with dual port evms):
 - connect port 1 (eth0) to linux Host 0 and run tcpdump or Wireshark
 - connect port 2 (eth1) to linux Host 1 with vlan 1 configured
 - ping <IPx> from Host 1 through vlan 1 interface.
ARP packets will be seen on Host 0.

Issue happens because dual_mac mode is implemnted using two vlans: 1 (Port
1+Port 0) and 2 (Port 2+Port 0), so there are vlan records created for for
each vlan. By default, the ALE will find valid vlan record in its table
when vlan 1 tagged packet arrived on Port 2 and so forwards packet to all
ports which are vlan 1 members (like Port.

To avoid such behaviorr the ALE VLAN ID Ingress Check need to be enabled
for each external CPSW port (ALE_PORTCTLn.VID_INGRESS_CHECK) so ALE will
drop ingress packets if Rx port is not VLAN member.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 5047f4b..46500a2 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1340,6 +1340,8 @@ static inline void cpsw_add_dual_emac_def_ale_entries(
 	cpsw_ale_add_ucast(cpsw->ale, priv->mac_addr,
 			   HOST_PORT_NUM, ALE_VLAN |
 			   ALE_SECURE, slave->port_vlan);
+	cpsw_ale_control_set(cpsw->ale, slave_port,
+			     ALE_PORT_DROP_UNKNOWN_VLAN, 1);
 }
 
 static void soft_reset_slave(struct cpsw_slave *slave)
-- 
2.10.5
