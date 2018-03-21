Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751680AbeCUHSZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:18:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6660 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751319AbeCUHSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:18:15 -0400
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 03/11] net: hns3: fix for vlan table lost problem when resetting
Date: Wed, 21 Mar 2018 15:49:22 +0800
Message-ID: <1521618570-129694-4-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521618570-129694-1-git-send-email-lipeng321@huawei.com>
References: <1521618570-129694-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

The vlan table in hardware is clear after PF/Core/IMP/Global
reset, which will cause vlan tagged packets not being received
problem.

This patch fixes it by restoring the vlan table after reset.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 26 +++++++++++++++++++++++++
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h |  3 +++
 2 files changed, 29 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 94f0b92..f700ec1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1404,11 +1404,15 @@ static int hns3_vlan_rx_add_vid(struct net_device *netdev,
 				__be16 proto, u16 vid)
 {
 	struct hnae3_handle *h = hns3_get_handle(netdev);
+	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	int ret = -EIO;
 
 	if (h->ae_algo->ops->set_vlan_filter)
 		ret = h->ae_algo->ops->set_vlan_filter(h, proto, vid, false);
 
+	if (!ret)
+		set_bit(vid, priv->active_vlans);
+
 	return ret;
 }
 
@@ -1416,14 +1420,32 @@ static int hns3_vlan_rx_kill_vid(struct net_device *netdev,
 				 __be16 proto, u16 vid)
 {
 	struct hnae3_handle *h = hns3_get_handle(netdev);
+	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	int ret = -EIO;
 
 	if (h->ae_algo->ops->set_vlan_filter)
 		ret = h->ae_algo->ops->set_vlan_filter(h, proto, vid, true);
 
+	if (!ret)
+		clear_bit(vid, priv->active_vlans);
+
 	return ret;
 }
 
+static void hns3_restore_vlan(struct net_device *netdev)
+{
+	struct hns3_nic_priv *priv = netdev_priv(netdev);
+	u16 vid;
+	int ret;
+
+	for_each_set_bit(vid, priv->active_vlans, VLAN_N_VID) {
+		ret = hns3_vlan_rx_add_vid(netdev, htons(ETH_P_8021Q), vid);
+		if (ret)
+			netdev_warn(netdev, "Restore vlan: %d filter, ret:%d\n",
+				    vid, ret);
+	}
+}
+
 static int hns3_ndo_set_vf_vlan(struct net_device *netdev, int vf, u16 vlan,
 				u8 qos, __be16 vlan_proto)
 {
@@ -3341,6 +3363,10 @@ static int hns3_reset_notify_init_enet(struct hnae3_handle *handle)
 	hns3_nic_set_rx_mode(netdev);
 	hns3_recover_hw_addr(netdev);
 
+	/* Hardware table is only clear when pf resets */
+	if (!(handle->flags & HNAE3_SUPPORT_VF))
+		hns3_restore_vlan(netdev);
+
 	/* Carrier off reporting is important to ethtool even BEFORE open */
 	netif_carrier_off(netdev);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index a5f4550..c313780 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -10,6 +10,8 @@
 #ifndef __HNS3_ENET_H
 #define __HNS3_ENET_H
 
+#include <linux/if_vlan.h>
+
 #include "hnae3.h"
 
 extern const char hns3_driver_version[];
@@ -539,6 +541,7 @@ struct hns3_nic_priv {
 	struct notifier_block notifier_block;
 	/* Vxlan/Geneve information */
 	struct hns3_udp_tunnel udp_tnl[HNS3_UDP_TNL_MAX];
+	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
 };
 
 union l3_hdr_info {
-- 
2.9.3
