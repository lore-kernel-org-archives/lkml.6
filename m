Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755859AbeCHLKZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:10:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5765 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755770AbeCHLKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:10:16 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [Patch net-next 5/6] net: hns3: set the max ring num when alloc netdev
Date: Thu, 8 Mar 2018 19:41:54 +0800
Message-ID: <1520509315-40895-6-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520509315-40895-1-git-send-email-lipeng321@huawei.com>
References: <1520509315-40895-1-git-send-email-lipeng321@huawei.com>
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
index 601b629..c936945 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -249,6 +249,16 @@ static int hns3_nic_set_real_num_queue(struct net_device *netdev)
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
@@ -3013,7 +3023,7 @@ static int hns3_client_init(struct hnae3_handle *handle)
 	int ret;
 
 	netdev = alloc_etherdev_mq(sizeof(struct hns3_nic_priv),
-				   handle->kinfo.num_tqps);
+				   hns3_get_max_available_channels(handle));
 	if (!netdev)
 		return -ENOMEM;
 
@@ -3336,17 +3346,6 @@ static int hns3_reset_notify(struct hnae3_handle *handle,
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
 static int hns3_modify_tqp_num(struct net_device *netdev, u16 new_tqp_num)
 {
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
@@ -3397,12 +3396,12 @@ int hns3_set_channels(struct net_device *netdev,
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
