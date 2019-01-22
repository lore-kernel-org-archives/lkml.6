Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F7CC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8BA217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfAVXkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:40:31 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:60086 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727065AbfAVXkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:40:12 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1FF80EE8FE9F53748186;
        Wed, 23 Jan 2019 07:40:08 +0800 (CST)
Received: from SZA150611058.china.huawei.com (10.45.143.16) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Wed, 23 Jan 2019 07:39:58 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>, <eric.dumazet@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huangdaode@hisilicon.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linuxarm@huawei.com>,
        Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH V2 net-next 03/12] net: hns3: refactor the statistics updating for netdev
Date:   Wed, 23 Jan 2019 07:39:29 +0800
Message-ID: <20190122233938.7188-4-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.20.1.windows.1
In-Reply-To: <20190122233938.7188-1-tanhuazhong@huawei.com>
References: <20190122233938.7188-1-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.45.143.16]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

In origin codes, there are some statistics item are got from mac, which
also include the packets statistics of VF. It is unreasonable. This
patch fixes it by counting them in the rx/tx processing flow.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 27 ++++++++++++++-----
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 25 -----------------
 2 files changed, 20 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 2ec3759961f1..1f15864fb8db 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1399,7 +1399,12 @@ static void hns3_nic_get_stats64(struct net_device *netdev,
 	int queue_num = priv->ae_handle->kinfo.num_tqps;
 	struct hnae3_handle *handle = priv->ae_handle;
 	struct hns3_enet_ring *ring;
+	u64 rx_length_errors = 0;
+	u64 rx_crc_errors = 0;
+	u64 rx_multicast = 0;
 	unsigned int start;
+	u64 tx_errors = 0;
+	u64 rx_errors = 0;
 	unsigned int idx;
 	u64 tx_bytes = 0;
 	u64 rx_bytes = 0;
@@ -1422,6 +1427,8 @@ static void hns3_nic_get_stats64(struct net_device *netdev,
 			tx_pkts += ring->stats.tx_pkts;
 			tx_drop += ring->stats.tx_busy;
 			tx_drop += ring->stats.sw_err_cnt;
+			tx_errors += ring->stats.tx_busy;
+			tx_errors += ring->stats.sw_err_cnt;
 		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
 
 		/* fetch the rx stats */
@@ -1433,6 +1440,12 @@ static void hns3_nic_get_stats64(struct net_device *netdev,
 			rx_drop += ring->stats.non_vld_descs;
 			rx_drop += ring->stats.err_pkt_len;
 			rx_drop += ring->stats.l2_err;
+			rx_errors += ring->stats.non_vld_descs;
+			rx_errors += ring->stats.l2_err;
+			rx_crc_errors += ring->stats.l2_err;
+			rx_crc_errors += ring->stats.l3l4_csum_err;
+			rx_multicast += ring->stats.rx_multicast;
+			rx_length_errors += ring->stats.err_pkt_len;
 		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
 	}
 
@@ -1441,15 +1454,15 @@ static void hns3_nic_get_stats64(struct net_device *netdev,
 	stats->rx_bytes = rx_bytes;
 	stats->rx_packets = rx_pkts;
 
-	stats->rx_errors = netdev->stats.rx_errors;
-	stats->multicast = netdev->stats.multicast;
-	stats->rx_length_errors = netdev->stats.rx_length_errors;
-	stats->rx_crc_errors = netdev->stats.rx_crc_errors;
+	stats->rx_errors = rx_errors;
+	stats->multicast = rx_multicast;
+	stats->rx_length_errors = rx_length_errors;
+	stats->rx_crc_errors = rx_crc_errors;
 	stats->rx_missed_errors = netdev->stats.rx_missed_errors;
 
-	stats->tx_errors = netdev->stats.tx_errors;
-	stats->rx_dropped = rx_drop + netdev->stats.rx_dropped;
-	stats->tx_dropped = tx_drop + netdev->stats.tx_dropped;
+	stats->tx_errors = tx_errors;
+	stats->rx_dropped = rx_drop;
+	stats->tx_dropped = tx_drop;
 	stats->collisions = netdev->stats.collisions;
 	stats->rx_over_errors = netdev->stats.rx_over_errors;
 	stats->rx_frame_errors = netdev->stats.rx_frame_errors;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 35fb0c54b986..bf0931c6764f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -461,26 +461,6 @@ static u8 *hclge_comm_get_strings(u32 stringset,
 	return (u8 *)buff;
 }
 
-static void hclge_update_netstat(struct hclge_hw_stats *hw_stats,
-				 struct net_device_stats *net_stats)
-{
-	net_stats->tx_dropped = 0;
-	net_stats->rx_errors = hw_stats->mac_stats.mac_rx_oversize_pkt_num;
-	net_stats->rx_errors += hw_stats->mac_stats.mac_rx_undersize_pkt_num;
-	net_stats->rx_errors += hw_stats->mac_stats.mac_rx_fcs_err_pkt_num;
-
-	net_stats->multicast = hw_stats->mac_stats.mac_tx_multi_pkt_num;
-	net_stats->multicast += hw_stats->mac_stats.mac_rx_multi_pkt_num;
-
-	net_stats->rx_crc_errors = hw_stats->mac_stats.mac_rx_fcs_err_pkt_num;
-	net_stats->rx_length_errors =
-		hw_stats->mac_stats.mac_rx_undersize_pkt_num;
-	net_stats->rx_length_errors +=
-		hw_stats->mac_stats.mac_rx_oversize_pkt_num;
-	net_stats->rx_over_errors =
-		hw_stats->mac_stats.mac_rx_oversize_pkt_num;
-}
-
 static void hclge_update_stats_for_all(struct hclge_dev *hdev)
 {
 	struct hnae3_handle *handle;
@@ -500,8 +480,6 @@ static void hclge_update_stats_for_all(struct hclge_dev *hdev)
 	if (status)
 		dev_err(&hdev->pdev->dev,
 			"Update MAC stats fail, status = %d.\n", status);
-
-	hclge_update_netstat(&hdev->hw_stats, &handle->kinfo.netdev->stats);
 }
 
 static void hclge_update_stats(struct hnae3_handle *handle,
@@ -509,7 +487,6 @@ static void hclge_update_stats(struct hnae3_handle *handle,
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
-	struct hclge_hw_stats *hw_stats = &hdev->hw_stats;
 	int status;
 
 	if (test_and_set_bit(HCLGE_STATE_STATISTICS_UPDATING, &hdev->state))
@@ -527,8 +504,6 @@ static void hclge_update_stats(struct hnae3_handle *handle,
 			"Update TQPS stats fail, status = %d.\n",
 			status);
 
-	hclge_update_netstat(hw_stats, net_stats);
-
 	clear_bit(HCLGE_STATE_STATISTICS_UPDATING, &hdev->state);
 }
 
-- 
2.20.1


