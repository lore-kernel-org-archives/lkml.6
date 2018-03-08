Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964991AbeCHChJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:37:09 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5748 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934880AbeCHCfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:35:02 -0500
From: Peng Li <lipeng321@huawei.com>
To: <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>
Subject: [PATCH net-next 17/23] {topost} net: hns3: refactor the coalesce related struct
Date: Thu, 8 Mar 2018 11:06:42 +0800
Message-ID: <1520478408-116992-18-git-send-email-lipeng321@huawei.com>
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

From: Yunsheng Lin <linyunsheng@huawei.com>

This patch refoctors the coalesce related struct by introducing
the hns3_enet_coalesce struct, in order to fix the coalesce
configuation lost problem when changing the channel number.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 46 +++++++++++-----------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    | 10 +++--
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 26 +++++++-----
 3 files changed, 46 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 453f509..a0ba25f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -168,8 +168,8 @@ void hns3_set_vector_coalesce_rl(struct hns3_enet_tqp_vector *tqp_vector,
 	 * GL and RL(Rate Limiter) are 2 ways to acheive interrupt coalescing
 	 */
 
-	if (rl_reg > 0 && !tqp_vector->tx_group.gl_adapt_enable &&
-	    !tqp_vector->rx_group.gl_adapt_enable)
+	if (rl_reg > 0 && !tqp_vector->tx_group.coal.gl_adapt_enable &&
+	    !tqp_vector->rx_group.coal.gl_adapt_enable)
 		/* According to the hardware, the range of rl_reg is
 		 * 0-59 and the unit is 4.
 		 */
@@ -205,17 +205,17 @@ static void hns3_vector_gl_rl_init(struct hns3_enet_tqp_vector *tqp_vector,
 	 */
 
 	/* Default: enable interrupt coalescing self-adaptive and GL */
-	tqp_vector->tx_group.gl_adapt_enable = 1;
-	tqp_vector->rx_group.gl_adapt_enable = 1;
+	tqp_vector->tx_group.coal.gl_adapt_enable = 1;
+	tqp_vector->rx_group.coal.gl_adapt_enable = 1;
 
-	tqp_vector->tx_group.int_gl = HNS3_INT_GL_50K;
-	tqp_vector->rx_group.int_gl = HNS3_INT_GL_50K;
+	tqp_vector->tx_group.coal.int_gl = HNS3_INT_GL_50K;
+	tqp_vector->rx_group.coal.int_gl = HNS3_INT_GL_50K;
 
 	/* Default: disable RL */
 	h->kinfo.int_rl_setting = 0;
 
-	tqp_vector->rx_group.flow_level = HNS3_FLOW_LOW;
-	tqp_vector->tx_group.flow_level = HNS3_FLOW_LOW;
+	tqp_vector->rx_group.coal.flow_level = HNS3_FLOW_LOW;
+	tqp_vector->tx_group.coal.flow_level = HNS3_FLOW_LOW;
 }
 
 static void hns3_vector_gl_rl_init_hw(struct hns3_enet_tqp_vector *tqp_vector,
@@ -224,9 +224,9 @@ static void hns3_vector_gl_rl_init_hw(struct hns3_enet_tqp_vector *tqp_vector,
 	struct hnae3_handle *h = priv->ae_handle;
 
 	hns3_set_vector_coalesce_tx_gl(tqp_vector,
-				       tqp_vector->tx_group.int_gl);
+				       tqp_vector->tx_group.coal.int_gl);
 	hns3_set_vector_coalesce_rx_gl(tqp_vector,
-				       tqp_vector->rx_group.int_gl);
+				       tqp_vector->rx_group.coal.int_gl);
 	hns3_set_vector_coalesce_rl(tqp_vector, h->kinfo.int_rl_setting);
 }
 
@@ -2381,12 +2381,12 @@ static bool hns3_get_new_int_gl(struct hns3_enet_ring_group *ring_group)
 	u16 new_int_gl;
 	int usecs;
 
-	if (!ring_group->int_gl)
+	if (!ring_group->coal.int_gl)
 		return false;
 
 	if (ring_group->total_packets == 0) {
-		ring_group->int_gl = HNS3_INT_GL_50K;
-		ring_group->flow_level = HNS3_FLOW_LOW;
+		ring_group->coal.int_gl = HNS3_INT_GL_50K;
+		ring_group->coal.flow_level = HNS3_FLOW_LOW;
 		return true;
 	}
 
@@ -2396,10 +2396,10 @@ static bool hns3_get_new_int_gl(struct hns3_enet_ring_group *ring_group)
 	 * 20-1249MB/s high      (18000 ints/s)
 	 * > 40000pps  ultra     (8000 ints/s)
 	 */
-	new_flow_level = ring_group->flow_level;
-	new_int_gl = ring_group->int_gl;
+	new_flow_level = ring_group->coal.flow_level;
+	new_int_gl = ring_group->coal.int_gl;
 	tqp_vector = ring_group->ring->tqp_vector;
-	usecs = (ring_group->int_gl << 1);
+	usecs = (ring_group->coal.int_gl << 1);
 	bytes_per_usecs = ring_group->total_bytes / usecs;
 	/* 1000000 microseconds */
 	packets_per_secs = ring_group->total_packets * 1000000 / usecs;
@@ -2446,9 +2446,9 @@ static bool hns3_get_new_int_gl(struct hns3_enet_ring_group *ring_group)
 
 	ring_group->total_bytes = 0;
 	ring_group->total_packets = 0;
-	ring_group->flow_level = new_flow_level;
-	if (new_int_gl != ring_group->int_gl) {
-		ring_group->int_gl = new_int_gl;
+	ring_group->coal.flow_level = new_flow_level;
+	if (new_int_gl != ring_group->coal.int_gl) {
+		ring_group->coal.int_gl = new_int_gl;
 		return true;
 	}
 	return false;
@@ -2460,18 +2460,18 @@ static void hns3_update_new_int_gl(struct hns3_enet_tqp_vector *tqp_vector)
 	struct hns3_enet_ring_group *tx_group = &tqp_vector->tx_group;
 	bool rx_update, tx_update;
 
-	if (rx_group->gl_adapt_enable) {
+	if (rx_group->coal.gl_adapt_enable) {
 		rx_update = hns3_get_new_int_gl(rx_group);
 		if (rx_update)
 			hns3_set_vector_coalesce_rx_gl(tqp_vector,
-						       rx_group->int_gl);
+						       rx_group->coal.int_gl);
 	}
 
-	if (tx_group->gl_adapt_enable) {
+	if (tx_group->coal.gl_adapt_enable) {
 		tx_update = hns3_get_new_int_gl(&tqp_vector->tx_group);
 		if (tx_update)
 			hns3_set_vector_coalesce_tx_gl(tqp_vector,
-						       tx_group->int_gl);
+						       tx_group->coal.int_gl);
 	}
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 213f501..a5f4550 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -460,15 +460,19 @@ enum hns3_link_mode_bits {
 #define HNS3_INT_RL_MAX			0x00EC
 #define HNS3_INT_RL_ENABLE_MASK		0x40
 
+struct hns3_enet_coalesce {
+	u16 int_gl;
+	u8 gl_adapt_enable;
+	enum hns3_flow_level_range flow_level;
+};
+
 struct hns3_enet_ring_group {
 	/* array of pointers to rings */
 	struct hns3_enet_ring *ring;
 	u64 total_bytes;	/* total bytes processed this group */
 	u64 total_packets;	/* total packets processed this group */
 	u16 count;
-	enum hns3_flow_level_range flow_level;
-	u16 int_gl;
-	u8 gl_adapt_enable;
+	struct hns3_enet_coalesce coal;
 };
 
 struct hns3_enet_tqp_vector {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index b034c7f..26274bc 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -905,11 +905,13 @@ static int hns3_get_coalesce_per_queue(struct net_device *netdev, u32 queue,
 	tx_vector = priv->ring_data[queue].ring->tqp_vector;
 	rx_vector = priv->ring_data[queue_num + queue].ring->tqp_vector;
 
-	cmd->use_adaptive_tx_coalesce = tx_vector->tx_group.gl_adapt_enable;
-	cmd->use_adaptive_rx_coalesce = rx_vector->rx_group.gl_adapt_enable;
+	cmd->use_adaptive_tx_coalesce =
+			tx_vector->tx_group.coal.gl_adapt_enable;
+	cmd->use_adaptive_rx_coalesce =
+			rx_vector->rx_group.coal.gl_adapt_enable;
 
-	cmd->tx_coalesce_usecs = tx_vector->tx_group.int_gl;
-	cmd->rx_coalesce_usecs = rx_vector->rx_group.int_gl;
+	cmd->tx_coalesce_usecs = tx_vector->tx_group.coal.int_gl;
+	cmd->rx_coalesce_usecs = rx_vector->rx_group.coal.int_gl;
 
 	cmd->tx_coalesce_usecs_high = h->kinfo.int_rl_setting;
 	cmd->rx_coalesce_usecs_high = h->kinfo.int_rl_setting;
@@ -1029,14 +1031,18 @@ static void hns3_set_coalesce_per_queue(struct net_device *netdev,
 	tx_vector = priv->ring_data[queue].ring->tqp_vector;
 	rx_vector = priv->ring_data[queue_num + queue].ring->tqp_vector;
 
-	tx_vector->tx_group.gl_adapt_enable = cmd->use_adaptive_tx_coalesce;
-	rx_vector->rx_group.gl_adapt_enable = cmd->use_adaptive_rx_coalesce;
+	tx_vector->tx_group.coal.gl_adapt_enable =
+				cmd->use_adaptive_tx_coalesce;
+	rx_vector->rx_group.coal.gl_adapt_enable =
+				cmd->use_adaptive_rx_coalesce;
 
-	tx_vector->tx_group.int_gl = cmd->tx_coalesce_usecs;
-	rx_vector->rx_group.int_gl = cmd->rx_coalesce_usecs;
+	tx_vector->tx_group.coal.int_gl = cmd->tx_coalesce_usecs;
+	rx_vector->rx_group.coal.int_gl = cmd->rx_coalesce_usecs;
 
-	hns3_set_vector_coalesce_tx_gl(tx_vector, tx_vector->tx_group.int_gl);
-	hns3_set_vector_coalesce_rx_gl(rx_vector, rx_vector->rx_group.int_gl);
+	hns3_set_vector_coalesce_tx_gl(tx_vector,
+				       tx_vector->tx_group.coal.int_gl);
+	hns3_set_vector_coalesce_rx_gl(rx_vector,
+				       rx_vector->rx_group.coal.int_gl);
 
 	hns3_set_vector_coalesce_rl(tx_vector, h->kinfo.int_rl_setting);
 	hns3_set_vector_coalesce_rl(rx_vector, h->kinfo.int_rl_setting);
-- 
2.9.3
