Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968182AbeEYSpQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 14:45:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7745 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S968088AbeEYSpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 14:45:09 -0400
From: Salil Mehta <salil.mehta@huawei.com>
To: <davem@davemloft.net>
CC: <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Fuyun Liang <liangfuyun1@huawei.com>
Subject: [PATCH net-next 09/12] net: hns3: Clear TX/RX rings when stopping port & un-initializing client
Date: Fri, 25 May 2018 19:43:04 +0100
Message-ID: <20180525184307.36288-10-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180525184307.36288-1-salil.mehta@huawei.com>
References: <20180525184307.36288-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuyun Liang <liangfuyun1@huawei.com>

When we down the port, some packets are left in TX/RX buffer. When we
up the port again, these old packets are forwarded to protocol stack
or are sent to internet. It will make some problem. TX/RX buffer should
be cleared when stopping port. This patch adds some function to ensure
the buffer is clean when port is started. We should clear the rings
when clients are being un-initialized as well.

Fixes: 76ad4f0ee747 ("net: hns3: Add support of HNS3 Ethernet Driver for hip08 SoC")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    | 115 +++++++++++++++++++--
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h    |   1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |   4 +
 3 files changed, 110 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 4c13c52..0529012 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -25,6 +25,9 @@
 #include "hnae3.h"
 #include "hns3_enet.h"
 
+static void hns3_clear_all_ring(struct hnae3_handle *h);
+static void hns3_force_clear_all_rx_ring(struct hnae3_handle *h);
+
 static const char hns3_driver_name[] = "hns3";
 const char hns3_driver_version[] = VERMAGIC_STRING;
 static const char hns3_driver_string[] =
@@ -273,6 +276,10 @@ static int hns3_nic_net_up(struct net_device *netdev)
 	int i, j;
 	int ret;
 
+	ret = hns3_nic_reset_all_ring(h);
+	if (ret)
+		return ret;
+
 	/* get irq resource for all vectors */
 	ret = hns3_nic_init_irq(priv);
 	if (ret) {
@@ -333,17 +340,19 @@ static void hns3_nic_net_down(struct net_device *netdev)
 	if (test_and_set_bit(HNS3_NIC_STATE_DOWN, &priv->state))
 		return;
 
+	/* disable vectors */
+	for (i = 0; i < priv->vector_num; i++)
+		hns3_vector_disable(&priv->tqp_vector[i]);
+
 	/* stop ae_dev */
 	ops = priv->ae_handle->ae_algo->ops;
 	if (ops->stop)
 		ops->stop(priv->ae_handle);
 
-	/* disable vectors */
-	for (i = 0; i < priv->vector_num; i++)
-		hns3_vector_disable(&priv->tqp_vector[i]);
-
 	/* free irq resources */
 	hns3_nic_uninit_irq(priv);
+
+	hns3_clear_all_ring(priv->ae_handle);
 }
 
 static int hns3_nic_net_stop(struct net_device *netdev)
@@ -2939,8 +2948,6 @@ int hns3_init_all_ring(struct hns3_nic_priv *priv)
 			goto out_when_alloc_ring_memory;
 		}
 
-		hns3_init_ring_hw(priv->ring_data[i].ring);
-
 		u64_stats_init(&priv->ring_data[i].ring->syncp);
 	}
 
@@ -3102,6 +3109,8 @@ static void hns3_client_uninit(struct hnae3_handle *handle, bool reset)
 	if (netdev->reg_state != NETREG_UNINITIALIZED)
 		unregister_netdev(netdev);
 
+	hns3_force_clear_all_rx_ring(handle);
+
 	ret = hns3_nic_uninit_vector_data(priv);
 	if (ret)
 		netdev_err(netdev, "uninit vector error\n");
@@ -3218,12 +3227,46 @@ static void hns3_recover_hw_addr(struct net_device *ndev)
 static void hns3_clear_tx_ring(struct hns3_enet_ring *ring)
 {
 	while (ring->next_to_clean != ring->next_to_use) {
+		ring->desc[ring->next_to_clean].tx.bdtp_fe_sc_vld_ra_ri = 0;
 		hns3_free_buffer_detach(ring, ring->next_to_clean);
 		ring_ptr_move_fw(ring, next_to_clean);
 	}
 }
 
-static void hns3_clear_rx_ring(struct hns3_enet_ring *ring)
+static int hns3_clear_rx_ring(struct hns3_enet_ring *ring)
+{
+	struct hns3_desc_cb res_cbs;
+	int ret;
+
+	while (ring->next_to_use != ring->next_to_clean) {
+		/* When a buffer is not reused, it's memory has been
+		 * freed in hns3_handle_rx_bd or will be freed by
+		 * stack, so we need to replace the buffer here.
+		 */
+		if (!ring->desc_cb[ring->next_to_use].reuse_flag) {
+			ret = hns3_reserve_buffer_map(ring, &res_cbs);
+			if (ret) {
+				u64_stats_update_begin(&ring->syncp);
+				ring->stats.sw_err_cnt++;
+				u64_stats_update_end(&ring->syncp);
+				/* if alloc new buffer fail, exit directly
+				 * and reclear in up flow.
+				 */
+				netdev_warn(ring->tqp->handle->kinfo.netdev,
+					    "reserve buffer map failed, ret = %d\n",
+					    ret);
+				return ret;
+			}
+			hns3_replace_buffer(ring, ring->next_to_use,
+					    &res_cbs);
+		}
+		ring_ptr_move_fw(ring, next_to_use);
+	}
+
+	return 0;
+}
+
+static void hns3_force_clear_rx_ring(struct hns3_enet_ring *ring)
 {
 	while (ring->next_to_use != ring->next_to_clean) {
 		/* When a buffer is not reused, it's memory has been
@@ -3240,6 +3283,19 @@ static void hns3_clear_rx_ring(struct hns3_enet_ring *ring)
 	}
 }
 
+static void hns3_force_clear_all_rx_ring(struct hnae3_handle *h)
+{
+	struct net_device *ndev = h->kinfo.netdev;
+	struct hns3_nic_priv *priv = netdev_priv(ndev);
+	struct hns3_enet_ring *ring;
+	u32 i;
+
+	for (i = 0; i < h->kinfo.num_tqps; i++) {
+		ring = priv->ring_data[i + h->kinfo.num_tqps].ring;
+		hns3_force_clear_rx_ring(ring);
+	}
+}
+
 static void hns3_clear_all_ring(struct hnae3_handle *h)
 {
 	struct net_device *ndev = h->kinfo.netdev;
@@ -3257,10 +3313,51 @@ static void hns3_clear_all_ring(struct hnae3_handle *h)
 		netdev_tx_reset_queue(dev_queue);
 
 		ring = priv->ring_data[i + h->kinfo.num_tqps].ring;
+		/* Continue to clear other rings even if clearing some
+		 * rings failed.
+		 */
 		hns3_clear_rx_ring(ring);
 	}
 }
 
+int hns3_nic_reset_all_ring(struct hnae3_handle *h)
+{
+	struct net_device *ndev = h->kinfo.netdev;
+	struct hns3_nic_priv *priv = netdev_priv(ndev);
+	struct hns3_enet_ring *rx_ring;
+	int i, j;
+	int ret;
+
+	for (i = 0; i < h->kinfo.num_tqps; i++) {
+		h->ae_algo->ops->reset_queue(h, i);
+		hns3_init_ring_hw(priv->ring_data[i].ring);
+
+		/* We need to clear tx ring here because self test will
+		 * use the ring and will not run down before up
+		 */
+		hns3_clear_tx_ring(priv->ring_data[i].ring);
+		priv->ring_data[i].ring->next_to_clean = 0;
+		priv->ring_data[i].ring->next_to_use = 0;
+
+		rx_ring = priv->ring_data[i + h->kinfo.num_tqps].ring;
+		hns3_init_ring_hw(rx_ring);
+		ret = hns3_clear_rx_ring(rx_ring);
+		if (ret)
+			return ret;
+
+		/* We can not know the hardware head and tail when this
+		 * function is called in reset flow, so we reuse all desc.
+		 */
+		for (j = 0; j < rx_ring->desc_num; j++)
+			hns3_reuse_buffer(rx_ring, j);
+
+		rx_ring->next_to_clean = 0;
+		rx_ring->next_to_use = 0;
+	}
+
+	return 0;
+}
+
 static int hns3_reset_notify_down_enet(struct hnae3_handle *handle)
 {
 	struct hnae3_knic_private_info *kinfo = &handle->kinfo;
@@ -3330,7 +3427,7 @@ static int hns3_reset_notify_uninit_enet(struct hnae3_handle *handle)
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 	int ret;
 
-	hns3_clear_all_ring(handle);
+	hns3_force_clear_all_rx_ring(handle);
 
 	ret = hns3_nic_uninit_vector_data(priv);
 	if (ret) {
@@ -3466,8 +3563,6 @@ int hns3_set_channels(struct net_device *netdev,
 	if (if_running)
 		hns3_nic_net_stop(netdev);
 
-	hns3_clear_all_ring(h);
-
 	ret = hns3_nic_uninit_vector_data(priv);
 	if (ret) {
 		dev_err(&netdev->dev,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 38e91ca..3b083d5a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -625,6 +625,7 @@ int hns3_set_channels(struct net_device *netdev,
 bool hns3_clean_tx_ring(struct hns3_enet_ring *ring, int budget);
 int hns3_init_all_ring(struct hns3_nic_priv *priv);
 int hns3_uninit_all_ring(struct hns3_nic_priv *priv);
+int hns3_nic_reset_all_ring(struct hnae3_handle *h);
 netdev_tx_t hns3_nic_net_xmit(struct sk_buff *skb, struct net_device *netdev);
 int hns3_clean_rx_ring(
 		struct hns3_enet_ring *ring, int budget,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index c16bb6c..8f8cc24 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -108,6 +108,10 @@ static int hns3_lp_up(struct net_device *ndev, enum hnae3_loop loop_mode)
 	if (!h->ae_algo->ops->start)
 		return -EOPNOTSUPP;
 
+	ret = hns3_nic_reset_all_ring(h);
+	if (ret)
+		return ret;
+
 	ret = h->ae_algo->ops->start(h);
 	if (ret) {
 		netdev_err(ndev,
-- 
2.7.4
