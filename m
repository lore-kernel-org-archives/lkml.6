Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbeCICFH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 21:05:07 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38052 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750912AbeCICFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 21:05:02 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 9/9] net: hns3: fix for coal configuation lost when setting the channel
Date: Fri, 9 Mar 2018 10:37:04 +0800
Message-ID: <1520563024-94811-10-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520563024-94811-1-git-send-email-lipeng321@huawei.com>
References: <1520563024-94811-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

This patch fixes the coalesce configuation lost problem when
setting the channel number by restoring all vectors's coalesce
configuation to vector 0's, because all vectors belonging to
the same netdev have the same coalesce configuation for now.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 37 +++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index f466f60..0a8c427 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3413,7 +3413,24 @@ static int hns3_reset_notify(struct hnae3_handle *handle,
 	return ret;
 }
 
-static int hns3_modify_tqp_num(struct net_device *netdev, u16 new_tqp_num)
+static void hns3_restore_coal(struct hns3_nic_priv *priv,
+			      struct hns3_enet_coalesce *tx,
+			      struct hns3_enet_coalesce *rx)
+{
+	u16 vector_num = priv->vector_num;
+	int i;
+
+	for (i = 0; i < vector_num; i++) {
+		memcpy(&priv->tqp_vector[i].tx_group.coal, tx,
+		       sizeof(struct hns3_enet_coalesce));
+		memcpy(&priv->tqp_vector[i].rx_group.coal, rx,
+		       sizeof(struct hns3_enet_coalesce));
+	}
+}
+
+static int hns3_modify_tqp_num(struct net_device *netdev, u16 new_tqp_num,
+			       struct hns3_enet_coalesce *tx,
+			       struct hns3_enet_coalesce *rx)
 {
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	struct hnae3_handle *h = hns3_get_handle(netdev);
@@ -3431,6 +3448,8 @@ static int hns3_modify_tqp_num(struct net_device *netdev, u16 new_tqp_num)
 	if (ret)
 		goto err_alloc_vector;
 
+	hns3_restore_coal(priv, tx, rx);
+
 	ret = hns3_nic_init_vector_data(priv);
 	if (ret)
 		goto err_uninit_vector;
@@ -3461,6 +3480,7 @@ int hns3_set_channels(struct net_device *netdev,
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	struct hnae3_handle *h = hns3_get_handle(netdev);
 	struct hnae3_knic_private_info *kinfo = &h->kinfo;
+	struct hns3_enet_coalesce tx_coal, rx_coal;
 	bool if_running = netif_running(netdev);
 	u32 new_tqp_num = ch->combined_count;
 	u16 org_tqp_num;
@@ -3494,15 +3514,26 @@ int hns3_set_channels(struct net_device *netdev,
 		goto open_netdev;
 	}
 
+	/* Changing the tqp num may also change the vector num,
+	 * ethtool only support setting and querying one coal
+	 * configuation for now, so save the vector 0' coal
+	 * configuation here in order to restore it.
+	 */
+	memcpy(&tx_coal, &priv->tqp_vector[0].tx_group.coal,
+	       sizeof(struct hns3_enet_coalesce));
+	memcpy(&rx_coal, &priv->tqp_vector[0].rx_group.coal,
+	       sizeof(struct hns3_enet_coalesce));
+
 	hns3_nic_dealloc_vector_data(priv);
 
 	hns3_uninit_all_ring(priv);
 	hns3_put_ring_config(priv);
 
 	org_tqp_num = h->kinfo.num_tqps;
-	ret = hns3_modify_tqp_num(netdev, new_tqp_num);
+	ret = hns3_modify_tqp_num(netdev, new_tqp_num, &tx_coal, &rx_coal);
 	if (ret) {
-		ret = hns3_modify_tqp_num(netdev, org_tqp_num);
+		ret = hns3_modify_tqp_num(netdev, org_tqp_num,
+					  &tx_coal, &rx_coal);
 		if (ret) {
 			/* If revert to old tqp failed, fatal error occurred */
 			dev_err(&netdev->dev,
-- 
2.9.3
