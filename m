Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753151AbeDQV21 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 17:28:27 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:54222 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbeDQV2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 17:28:20 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <ssantosh@kernel.org>,
        <malat@debian.org>, <w-kwok2@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
Subject: [net-next PATCH v4 09/13] net: netcp: ethss: use of_get_phy_mode() to support different RGMII modes
Date: Tue, 17 Apr 2018 17:30:38 -0400
Message-ID: <1524000642-23944-10-git-send-email-m-karicheri2@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
References: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phy used for K2G allows for internal delays to be added optionally
to the clock circuitry based on board desing. To add this support,
enhance the driver to use of_get_phy_mode() to read the phy-mode from
the phy device and pass the same to phy through of_phy_connect().

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/net/ethernet/ti/netcp_ethss.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index d982dcb..5bc7921 100644
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
@@ -707,6 +708,7 @@ struct gbe_slave {
 	u32				link_interface;
 	u32				mac_control;
 	u8				phy_port_t;
+	struct device_node		*node;
 	struct device_node		*phy_node;
 	struct ts_ctl                   ts_ctl;
 	struct list_head		slave_list;
@@ -2322,6 +2324,21 @@ static int gbe_slave_open(struct gbe_intf *gbe_intf)
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
+
+		if (!phy_interface_mode_is_rgmii(phy_mode)) {
+			dev_err(priv->dev,
+				"Unsupported phy mode %d\n", phy_mode);
+			return -EINVAL;
+		}
+		slave->phy_port_t = PORT_MII;
 	} else if (slave->link_interface == XGMII_LINK_MAC_PHY) {
 		has_phy = true;
 		phy_mode = PHY_INTERFACE_MODE_NA;
@@ -2947,6 +2964,7 @@ static int init_slave(struct gbe_priv *gbe_dev, struct gbe_slave *slave,
 		slave->link_interface = SGMII_LINK_MAC_PHY;
 	}
 
+	slave->node = node;
 	slave->open = false;
 	if ((slave->link_interface == SGMII_LINK_MAC_PHY) ||
 	    (slave->link_interface == RGMII_LINK_MAC_PHY) ||
-- 
1.9.1
