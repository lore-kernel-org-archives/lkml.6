Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964865AbeCHCfU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:35:20 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5759 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934902AbeCHCfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:35:03 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 22/23] {topost} net: hns3: set the max ring num when alloc netdev
Date: Thu, 8 Mar 2018 11:06:47 +0800
Message-ID: <1520478408-116992-23-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520478408-116992-1-git-send-email-lipeng321@huawei.com>
References: <1520478408-116992-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HNS3 driver should alloc netdev with max support ring num, as
driver support change netdev count by ethtool -L.

Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 27 ++++++++++++-------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index b02f3ff..94f0b92 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -255,6 +255,16 @@ static int hns3_nic_set_real_num_queue(struct net_device *netdev)
 	return 0;
 }
 
+static u16 hns3_get_max_available_channels(struct hnae3_handle *h)
+{
+	u16 free_tqps, max_rss_size, max_tqps;
+
+	h->ae_algo->ops->get_tqps_and_rss_info(h, &free_tqps, &max_rss_size);
+	max_tqps = h->kinfo.num_tc * max_rss_size;
+
+	return min_t(u16, max_tqps, (free_tqps + h->kinfo.num_tqps));
+}
+
 static int hns3_nic_net_up(struct net_device *netdev)
 {
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
@@ -3062,7 +3072,7 @@ static int hns3_client_init(struct hnae3_handle *handle)
 	int ret;
 
 	netdev = alloc_etherdev_mq(sizeof(struct hns3_nic_priv),
-				   handle->kinfo.num_tqps);
+				   hns3_get_max_available_channels(handle));
 	if (!netdev)
 		return -ENOMEM;
 
@@ -3401,17 +3411,6 @@ static int hns3_reset_notify(struct hnae3_handle *handle,
 	return ret;
 }
 
-static u16 hns3_get_max_available_channels(struct net_device *netdev)
-{
-	struct hnae3_handle *h = hns3_get_handle(netdev);
-	u16 free_tqps, max_rss_size, max_tqps;
-
-	h->ae_algo->ops->get_tqps_and_rss_info(h, &free_tqps, &max_rss_size);
-	max_tqps = h->kinfo.num_tc * max_rss_size;
-
-	return min_t(u16, max_tqps, (free_tqps + h->kinfo.num_tqps));
-}
-
 static void hns3_restore_coal(struct hns3_nic_priv *priv,
 			      struct hns3_enet_coalesce *tx,
 			      struct hns3_enet_coalesce *rx)
@@ -3488,12 +3487,12 @@ int hns3_set_channels(struct net_device *netdev,
 	if (ch->rx_count || ch->tx_count)
 		return -EINVAL;
 
-	if (new_tqp_num > hns3_get_max_available_channels(netdev) ||
+	if (new_tqp_num > hns3_get_max_available_channels(h) ||
 	    new_tqp_num < kinfo->num_tc) {
 		dev_err(&netdev->dev,
 			"Change tqps fail, the tqp range is from %d to %d",
 			kinfo->num_tc,
-			hns3_get_max_available_channels(netdev));
+			hns3_get_max_available_channels(h));
 		return -EINVAL;
 	}
 
-- 
2.9.3
