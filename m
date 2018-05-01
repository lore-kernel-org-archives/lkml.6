Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756713AbeEAS62 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:58:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7645 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756247AbeEAS6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:58:20 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil.lnk@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Xi Wang <wangxi11@huawei.com>
Subject: [PATCH net-next 9/9] net: hns3: Remove packet statistics in the range of 8192~12287
Date: Tue, 1 May 2018 19:56:05 +0100
Message-ID: <20180501185605.9584-10-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180501185605.9584-1-salil.mehta@huawei.com>
References: <20180501185605.9584-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

Because the current statistics for size 8192~12287 are only valid for GE,
the ranges of 8192~9216 and 9217~12287 are valid only for LGE/CGE, and are
always 0 for GE interfaces. it is easy to cause confusion when viewing the
packet statistics using the command ethtool -S.

This patch removes the 8192~12287 range of packet statistics and uses the
8192~9216 and 9217~12287 ranges for statistics. This change depends on the
firmware upgrade.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c |  4 ----
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h | 12 ++++++------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 77d9e4c0..dd5d65c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -304,8 +304,6 @@ static const struct hclge_comm_stats_str g_mac_stats_string[] = {
 		HCLGE_MAC_STATS_FIELD_OFF(mac_tx_2048_4095_oct_pkt_num)},
 	{"mac_tx_4096_8191_oct_pkt_num",
 		HCLGE_MAC_STATS_FIELD_OFF(mac_tx_4096_8191_oct_pkt_num)},
-	{"mac_tx_8192_12287_oct_pkt_num",
-		HCLGE_MAC_STATS_FIELD_OFF(mac_tx_8192_12287_oct_pkt_num)},
 	{"mac_tx_8192_9216_oct_pkt_num",
 		HCLGE_MAC_STATS_FIELD_OFF(mac_tx_8192_9216_oct_pkt_num)},
 	{"mac_tx_9217_12287_oct_pkt_num",
@@ -356,8 +354,6 @@ static const struct hclge_comm_stats_str g_mac_stats_string[] = {
 		HCLGE_MAC_STATS_FIELD_OFF(mac_rx_2048_4095_oct_pkt_num)},
 	{"mac_rx_4096_8191_oct_pkt_num",
 		HCLGE_MAC_STATS_FIELD_OFF(mac_rx_4096_8191_oct_pkt_num)},
-	{"mac_rx_8192_12287_oct_pkt_num",
-		HCLGE_MAC_STATS_FIELD_OFF(mac_rx_8192_12287_oct_pkt_num)},
 	{"mac_rx_8192_9216_oct_pkt_num",
 		HCLGE_MAC_STATS_FIELD_OFF(mac_rx_8192_9216_oct_pkt_num)},
 	{"mac_rx_9217_12287_oct_pkt_num",
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 6432f754..b7ee91d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -408,9 +408,9 @@ struct hclge_mac_stats {
 	u64 mac_tx_1519_2047_oct_pkt_num;
 	u64 mac_tx_2048_4095_oct_pkt_num;
 	u64 mac_tx_4096_8191_oct_pkt_num;
-	u64 mac_tx_8192_12287_oct_pkt_num; /* valid for GE MAC only */
-	u64 mac_tx_8192_9216_oct_pkt_num; /* valid for LGE & CGE MAC only */
-	u64 mac_tx_9217_12287_oct_pkt_num; /* valid for LGE & CGE MAC */
+	u64 rsv0;
+	u64 mac_tx_8192_9216_oct_pkt_num;
+	u64 mac_tx_9217_12287_oct_pkt_num;
 	u64 mac_tx_12288_16383_oct_pkt_num;
 	u64 mac_tx_1519_max_good_oct_pkt_num;
 	u64 mac_tx_1519_max_bad_oct_pkt_num;
@@ -435,9 +435,9 @@ struct hclge_mac_stats {
 	u64 mac_rx_1519_2047_oct_pkt_num;
 	u64 mac_rx_2048_4095_oct_pkt_num;
 	u64 mac_rx_4096_8191_oct_pkt_num;
-	u64 mac_rx_8192_12287_oct_pkt_num;/* valid for GE MAC only */
-	u64 mac_rx_8192_9216_oct_pkt_num; /* valid for LGE & CGE MAC only */
-	u64 mac_rx_9217_12287_oct_pkt_num; /* valid for LGE & CGE MAC only */
+	u64 rsv1;
+	u64 mac_rx_8192_9216_oct_pkt_num;
+	u64 mac_rx_9217_12287_oct_pkt_num;
 	u64 mac_rx_12288_16383_oct_pkt_num;
 	u64 mac_rx_1519_max_good_oct_pkt_num;
 	u64 mac_rx_1519_max_bad_oct_pkt_num;
-- 
2.7.4
