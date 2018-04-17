Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753614AbeDQVcO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 17:32:14 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:23129 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752427AbeDQV2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 17:28:23 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <ssantosh@kernel.org>,
        <malat@debian.org>, <w-kwok2@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
Subject: [net-next PATCH v4 04/13] net: netcp: ethss: make sgmii configuration conditional
Date: Tue, 17 Apr 2018 17:30:33 -0400
Message-ID: <1524000642-23944-5-git-send-email-m-karicheri2@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
References: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a preparatory patch to add support for 2u cpsw hardware found on
K2G SoC, make sgmii configuration conditional. This is required
since 2u uses RGMII interface instead of SGMII and to allow for driver
re-use.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/net/ethernet/ti/netcp_ethss.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 1b79fe5..e1e67ff 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -74,6 +74,8 @@
 
 #define IS_SS_ID_VER_14(d) \
 	(GBE_IDENT((d)->ss_version) == GBE_SS_VERSION_14)
+#define IS_SS_ID_2U(d) \
+	(GBE_IDENT((d)->ss_version) == GBE_SS_ID_2U)
 
 #define GBENU_SS_REG_INDEX		0
 #define GBENU_SM_REG_INDEX		1
@@ -2239,7 +2241,8 @@ static void gbe_slave_stop(struct gbe_intf *intf)
 	struct gbe_priv *gbe_dev = intf->gbe_dev;
 	struct gbe_slave *slave = intf->slave;
 
-	gbe_sgmii_rtreset(gbe_dev, slave, true);
+	if (!IS_SS_ID_2U(gbe_dev))
+		gbe_sgmii_rtreset(gbe_dev, slave, true);
 	gbe_port_reset(slave);
 	/* Disable forwarding */
 	cpsw_ale_control_set(gbe_dev->ale, slave->port_num,
@@ -2274,9 +2277,11 @@ static int gbe_slave_open(struct gbe_intf *gbe_intf)
 
 	void (*hndlr)(struct net_device *) = gbe_adjust_link;
 
-	gbe_sgmii_config(priv, slave);
+	if (!IS_SS_ID_2U(priv))
+		gbe_sgmii_config(priv, slave);
 	gbe_port_reset(slave);
-	gbe_sgmii_rtreset(priv, slave, false);
+	if (!IS_SS_ID_2U(priv))
+		gbe_sgmii_rtreset(priv, slave, false);
 	gbe_port_config(priv, slave, priv->rx_packet_max);
 	gbe_set_slave_mac(slave, gbe_intf);
 	/* enable forwarding */
@@ -3042,7 +3047,8 @@ static void init_secondary_ports(struct gbe_priv *gbe_dev,
 			continue;
 		}
 
-		gbe_sgmii_config(gbe_dev, slave);
+		if (!IS_SS_ID_2U(gbe_dev))
+			gbe_sgmii_config(gbe_dev, slave);
 		gbe_port_reset(slave);
 		gbe_port_config(gbe_dev, slave, gbe_dev->rx_packet_max);
 		list_add_tail(&slave->slave_list, &gbe_dev->secondary_slaves);
@@ -3399,7 +3405,9 @@ static int set_gbenu_ethss_priv(struct gbe_priv *gbe_dev,
 	}
 	gbe_dev->switch_regs = regs;
 
-	gbe_dev->sgmii_port_regs = gbe_dev->ss_regs + GBENU_SGMII_MODULE_OFFSET;
+	if (!IS_SS_ID_2U(gbe_dev))
+		gbe_dev->sgmii_port_regs =
+		       gbe_dev->ss_regs + GBENU_SGMII_MODULE_OFFSET;
 
 	/* Although sgmii modules are mem mapped to one contiguous
 	 * region on GBENU devices, setting sgmii_port34_regs allows
-- 
1.9.1
