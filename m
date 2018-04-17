Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753358AbeDQV3t (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 17:29:49 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:29976 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753069AbeDQV20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 17:28:26 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <ssantosh@kernel.org>,
        <malat@debian.org>, <w-kwok2@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
Subject: [net-next PATCH v4 12/13] net: netcp: add api to support set rx mode in netcp modules
Date: Tue, 17 Apr 2018 17:30:41 -0400
Message-ID: <1524000642-23944-13-git-send-email-m-karicheri2@ti.com>
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

This patch adds an API to support setting rx mode in
netcp modules.  If a netcp module needs to be notified
when upper layer transitions from one rx mode to
another and react accordingly, such a module will implement
the new API set_rx_mode added in this patch.  Currently
rx modes supported are PROMISCUOUS and NON_PROMISCUOUS
modes.

Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/net/ethernet/ti/netcp.h      |  1 +
 drivers/net/ethernet/ti/netcp_core.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/ti/netcp.h b/drivers/net/ethernet/ti/netcp.h
index 416f732..c4ffdf4 100644
--- a/drivers/net/ethernet/ti/netcp.h
+++ b/drivers/net/ethernet/ti/netcp.h
@@ -214,6 +214,7 @@ struct netcp_module {
 	int	(*add_vid)(void *intf_priv, int vid);
 	int	(*del_vid)(void *intf_priv, int vid);
 	int	(*ioctl)(void *intf_priv, struct ifreq *req, int cmd);
+	int	(*set_rx_mode)(void *intf_priv, bool promisc);
 
 	/* used internally */
 	struct list_head	module_list;
diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index 736f6f7..e40aa3e 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -1509,6 +1509,24 @@ static void netcp_addr_sweep_add(struct netcp_intf *netcp)
 	}
 }
 
+static int netcp_set_promiscuous(struct netcp_intf *netcp, bool promisc)
+{
+	struct netcp_intf_modpriv *priv;
+	struct netcp_module *module;
+	int error;
+
+	for_each_module(netcp, priv) {
+		module = priv->netcp_module;
+		if (!module->set_rx_mode)
+			continue;
+
+		error = module->set_rx_mode(priv->module_priv, promisc);
+		if (error)
+			return error;
+	}
+	return 0;
+}
+
 static void netcp_set_rx_mode(struct net_device *ndev)
 {
 	struct netcp_intf *netcp = netdev_priv(ndev);
@@ -1538,6 +1556,7 @@ static void netcp_set_rx_mode(struct net_device *ndev)
 	/* finally sweep and callout into modules */
 	netcp_addr_sweep_del(netcp);
 	netcp_addr_sweep_add(netcp);
+	netcp_set_promiscuous(netcp, promisc);
 	spin_unlock(&netcp->lock);
 }
 
-- 
1.9.1
