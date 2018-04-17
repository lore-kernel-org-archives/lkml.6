Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753262AbeDQV3D (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 17:29:03 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:41290 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753099AbeDQV21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 17:28:27 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <ssantosh@kernel.org>,
        <malat@debian.org>, <w-kwok2@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
Subject: [net-next PATCH v4 13/13] net: netcp: ethss: k2g: add promiscuous mode support
Date: Tue, 17 Apr 2018 17:30:42 -0400
Message-ID: <1524000642-23944-14-git-send-email-m-karicheri2@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
References: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WingMan Kwok <w-kwok2@ti.com>

This patch adds support for promiscuous mode in k2g's network
driver. When upper layer instructs to transition from
non-promiscuous mode to promiscuous mode or vice versa
K2G network driver needs to configure ALE accordingly
so that in case of non-promiscuous mode, ALE will not flood
all unicast packets to host port, while in promiscuous
mode, it will pass all received unicast packets to
host port.

Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/net/ethernet/ti/netcp_ethss.c | 56 +++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 5bc7921..6a728d3 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -2775,6 +2775,61 @@ static inline int gbe_hwtstamp_set(struct gbe_intf *gbe_intf, struct ifreq *req)
 }
 #endif /* CONFIG_TI_CPTS */
 
+static int gbe_set_rx_mode(void *intf_priv, bool promisc)
+{
+	struct gbe_intf *gbe_intf = intf_priv;
+	struct gbe_priv *gbe_dev = gbe_intf->gbe_dev;
+	struct cpsw_ale *ale = gbe_dev->ale;
+	unsigned long timeout;
+	int i, ret = -ETIMEDOUT;
+
+	/* Disable(1)/Enable(0) Learn for all ports (host is port 0 and
+	 * slaves are port 1 and up
+	 */
+	for (i = 0; i <= gbe_dev->num_slaves; i++) {
+		cpsw_ale_control_set(ale, i,
+				     ALE_PORT_NOLEARN, !!promisc);
+		cpsw_ale_control_set(ale, i,
+				     ALE_PORT_NO_SA_UPDATE, !!promisc);
+	}
+
+	if (!promisc) {
+		/* Don't Flood All Unicast Packets to Host port */
+		cpsw_ale_control_set(ale, 0, ALE_P0_UNI_FLOOD, 0);
+		dev_vdbg(gbe_dev->dev, "promiscuous mode disabled\n");
+		return 0;
+	}
+
+	timeout = jiffies + HZ;
+
+	/* Clear All Untouched entries */
+	cpsw_ale_control_set(ale, 0, ALE_AGEOUT, 1);
+	do {
+		cpu_relax();
+		if (cpsw_ale_control_get(ale, 0, ALE_AGEOUT)) {
+			ret = 0;
+			break;
+		}
+
+	} while (time_after(timeout, jiffies));
+
+	/* Make sure it is not a false timeout */
+	if (ret && !cpsw_ale_control_get(ale, 0, ALE_AGEOUT))
+		return ret;
+
+	cpsw_ale_control_set(ale, 0, ALE_AGEOUT, 1);
+
+	/* Clear all mcast from ALE */
+	cpsw_ale_flush_multicast(ale,
+				 GBE_PORT_MASK(gbe_dev->ale_ports),
+				 -1);
+
+	/* Flood All Unicast Packets to Host port */
+	cpsw_ale_control_set(ale, 0, ALE_P0_UNI_FLOOD, 1);
+	dev_vdbg(gbe_dev->dev, "promiscuous mode enabled\n");
+	return ret;
+}
+
 static int gbe_ioctl(void *intf_priv, struct ifreq *req, int cmd)
 {
 	struct gbe_intf *gbe_intf = intf_priv;
@@ -3529,6 +3584,7 @@ static int gbe_probe(struct netcp_device *netcp_device, struct device *dev,
 		gbe_dev->max_num_slaves = 8;
 	} else if (of_device_is_compatible(node, "ti,netcp-gbe-2")) {
 		gbe_dev->max_num_slaves = 1;
+		gbe_module.set_rx_mode = gbe_set_rx_mode;
 	} else if (of_device_is_compatible(node, "ti,netcp-xgbe")) {
 		gbe_dev->max_num_slaves = 2;
 	} else {
-- 
1.9.1
