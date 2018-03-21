Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeCUHUu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:20:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6666 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751545AbeCUHST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:18:19 -0400
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 07/11] net: hns3: change the time interval of int_gl calculating
Date: Wed, 21 Mar 2018 15:49:26 +0800
Message-ID: <1521618570-129694-8-git-send-email-lipeng321@huawei.com>
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

From: Fuyun Liang <liangfuyun1@huawei.com>

Since we change the update rate of int_gl from every interrupt to every
one hundred interrupts, the old way to get time interval by int_gl value
is not accurate. This patch calculates the time interval using the jiffies
value.

Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 46 ++++++++++++++++---------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h |  1 +
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index e7cf7b4..0b4a676 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2406,15 +2406,15 @@ int hns3_clean_rx_ring(
 
 static bool hns3_get_new_int_gl(struct hns3_enet_ring_group *ring_group)
 {
-#define HNS3_RX_ULTRA_PACKET_RATE 40000
+	struct hns3_enet_tqp_vector *tqp_vector =
+					ring_group->ring->tqp_vector;
 	enum hns3_flow_level_range new_flow_level;
-	struct hns3_enet_tqp_vector *tqp_vector;
-	int packets_per_secs;
-	int bytes_per_usecs;
+	int packets_per_msecs;
+	int bytes_per_msecs;
+	u32 time_passed_ms;
 	u16 new_int_gl;
-	int usecs;
 
-	if (!ring_group->coal.int_gl)
+	if (!ring_group->coal.int_gl || !tqp_vector->last_jiffies)
 		return false;
 
 	if (ring_group->total_packets == 0) {
@@ -2431,33 +2431,44 @@ static bool hns3_get_new_int_gl(struct hns3_enet_ring_group *ring_group)
 	 */
 	new_flow_level = ring_group->coal.flow_level;
 	new_int_gl = ring_group->coal.int_gl;
-	tqp_vector = ring_group->ring->tqp_vector;
-	usecs = (ring_group->coal.int_gl << 1);
-	bytes_per_usecs = ring_group->total_bytes / usecs;
-	/* 1000000 microseconds */
-	packets_per_secs = ring_group->total_packets * 1000000 / usecs;
+	time_passed_ms =
+		jiffies_to_msecs(jiffies - tqp_vector->last_jiffies);
+
+	if (!time_passed_ms)
+		return false;
+
+	do_div(ring_group->total_packets, time_passed_ms);
+	packets_per_msecs = ring_group->total_packets;
+
+	do_div(ring_group->total_bytes, time_passed_ms);
+	bytes_per_msecs = ring_group->total_bytes;
+
+#define HNS3_RX_LOW_BYTE_RATE 10000
+#define HNS3_RX_MID_BYTE_RATE 20000
 
 	switch (new_flow_level) {
 	case HNS3_FLOW_LOW:
-		if (bytes_per_usecs > 10)
+		if (bytes_per_msecs > HNS3_RX_LOW_BYTE_RATE)
 			new_flow_level = HNS3_FLOW_MID;
 		break;
 	case HNS3_FLOW_MID:
-		if (bytes_per_usecs > 20)
+		if (bytes_per_msecs > HNS3_RX_MID_BYTE_RATE)
 			new_flow_level = HNS3_FLOW_HIGH;
-		else if (bytes_per_usecs <= 10)
+		else if (bytes_per_msecs <= HNS3_RX_LOW_BYTE_RATE)
 			new_flow_level = HNS3_FLOW_LOW;
 		break;
 	case HNS3_FLOW_HIGH:
 	case HNS3_FLOW_ULTRA:
 	default:
-		if (bytes_per_usecs <= 20)
+		if (bytes_per_msecs <= HNS3_RX_MID_BYTE_RATE)
 			new_flow_level = HNS3_FLOW_MID;
 		break;
 	}
 
-	if ((packets_per_secs > HNS3_RX_ULTRA_PACKET_RATE) &&
-	    (&tqp_vector->rx_group == ring_group))
+#define HNS3_RX_ULTRA_PACKET_RATE 40
+
+	if (packets_per_msecs > HNS3_RX_ULTRA_PACKET_RATE &&
+	    &tqp_vector->rx_group == ring_group)
 		new_flow_level = HNS3_FLOW_ULTRA;
 
 	switch (new_flow_level) {
@@ -2512,6 +2523,7 @@ static void hns3_update_new_int_gl(struct hns3_enet_tqp_vector *tqp_vector)
 						       tx_group->coal.int_gl);
 	}
 
+	tqp_vector->last_jiffies = jiffies;
 	tqp_vector->int_adapt_down = HNS3_INT_ADAPT_DOWN_START;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 2fe870b..39daa01 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -499,6 +499,7 @@ struct hns3_enet_tqp_vector {
 
 	/* when 0 should adjust interrupt coalesce parameter */
 	u8 int_adapt_down;
+	unsigned long last_jiffies;
 } ____cacheline_internodealigned_in_smp;
 
 enum hns3_udp_tnl_type {
-- 
2.9.3
