Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71AAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A5C2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 13:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A5C2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388322AbeKOX0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 18:26:13 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15106 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728931AbeKOX0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 18:26:13 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 37BBC5C0E4FF8;
        Thu, 15 Nov 2018 21:18:19 +0800 (CST)
Received: from localhost.localdomain (10.175.34.53) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Thu, 15 Nov 2018 21:18:11 +0800
From:   Xue Chaojing <xuechaojing@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <xuechaojing@huawei.com>,
        <netdev@vger.kernel.org>, <wulike1@huawei.com>,
        <chiqijun@huawei.com>, <fy.wang@huawei.com>, <tony.qu@huawei.com>,
        <luoshaokai@huawei.com>
Subject: [PATCH 1/1] net-next/hinic:fix three problems in HiNIC Driver
Date:   Thu, 15 Nov 2018 05:23:27 +0000
Message-ID: <20181115052327.2859-1-xuechaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.34.53]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes these problems:
1. In order to improve performance, this patch add rx checksum offload
for the HiNIC driver. Performance test(Iperf) shows more than 95%
improvement in TCP streams.
2. In add_mac_addr(), if the MAC address is a muliticast address, it
will not be set, which causes the network card fail to receive the
multicast packet. This patch fixes this bug.
3. In rx_alloc_pkts(), there is a loop call of tasklet, which causes
100% cpu utilization, even no packets are being received. This patch
fixes this bug.

Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>
---
 .../net/ethernet/huawei/hinic/hinic_hw_dev.h  |  2 +
 .../net/ethernet/huawei/hinic/hinic_hw_wq.c   | 43 +++++++++++++------
 .../net/ethernet/huawei/hinic/hinic_hw_wq.h   |  3 +-
 .../net/ethernet/huawei/hinic/hinic_hw_wqe.h  |  4 ++
 .../net/ethernet/huawei/hinic/hinic_main.c    | 14 ++++--
 .../net/ethernet/huawei/hinic/hinic_port.c    | 28 ++++++++++++
 .../net/ethernet/huawei/hinic/hinic_port.h    | 10 +++++
 drivers/net/ethernet/huawei/hinic/hinic_rx.c  | 26 ++++++++++-
 drivers/net/ethernet/huawei/hinic/hinic_rx.h  |  5 +++
 9 files changed, 116 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.h b/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.h
index 097b5502603f..d1a7d2522d82 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.h
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.h
@@ -50,6 +50,8 @@ enum hinic_port_cmd {
 
 	HINIC_PORT_CMD_GET_LINK_STATE   = 24,
 
+	HINIC_PORT_CMD_SET_RX_CSUM	= 26,
+
 	HINIC_PORT_CMD_SET_PORT_STATE   = 41,
 
 	HINIC_PORT_CMD_FWCTXT_INIT      = 69,
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_wq.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_wq.c
index f92f1bf3901a..34859502c932 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_wq.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_wq.c
@@ -74,12 +74,6 @@
 			((void *)((cmdq_pages)->shadow_page_vaddr) \
 				+ (wq)->block_idx * CMDQ_BLOCK_SIZE)
 
-#define WQE_PAGE_OFF(wq, idx)   (((idx) & ((wq)->num_wqebbs_per_page - 1)) * \
-					(wq)->wqebb_size)
-
-#define WQE_PAGE_NUM(wq, idx)   (((idx) / ((wq)->num_wqebbs_per_page)) \
-					& ((wq)->num_q_pages - 1))
-
 #define WQ_PAGE_ADDR(wq, idx)           \
 			((wq)->shadow_block_vaddr[WQE_PAGE_NUM(wq, idx)])
 
@@ -93,6 +87,17 @@
 		(((unsigned long)(wqe) - (unsigned long)(wq)->shadow_wqe) \
 			/ (wq)->max_wqe_size)
 
+static inline int WQE_PAGE_OFF(struct hinic_wq *wq, u16 idx)
+{
+	return (((idx) & ((wq)->num_wqebbs_per_page - 1))
+		<< (wq)->wqebb_size_shift);
+}
+
+static inline int WQE_PAGE_NUM(struct hinic_wq *wq, u16 idx)
+{
+	return (((idx) >> ((wq)->wqebbs_per_page_shift))
+		& ((wq)->num_q_pages - 1));
+}
 /**
  * queue_alloc_page - allocate page for Queue
  * @hwif: HW interface for allocating DMA
@@ -513,6 +518,7 @@ int hinic_wq_allocate(struct hinic_wqs *wqs, struct hinic_wq *wq,
 	struct hinic_hwif *hwif = wqs->hwif;
 	struct pci_dev *pdev = hwif->pdev;
 	u16 num_wqebbs_per_page;
+	u16 wqebb_size_shift;
 	int err;
 
 	if (wqebb_size == 0) {
@@ -530,7 +536,9 @@ int hinic_wq_allocate(struct hinic_wqs *wqs, struct hinic_wq *wq,
 		return -EINVAL;
 	}
 
-	num_wqebbs_per_page = ALIGN(wq_page_size, wqebb_size) / wqebb_size;
+	wqebb_size_shift = ilog2(wqebb_size);
+	num_wqebbs_per_page = ALIGN(wq_page_size, wqebb_size)
+				>> wqebb_size_shift;
 
 	if (num_wqebbs_per_page & (num_wqebbs_per_page - 1)) {
 		dev_err(&pdev->dev, "num wqebbs per page must be power of 2\n");
@@ -550,7 +558,8 @@ int hinic_wq_allocate(struct hinic_wqs *wqs, struct hinic_wq *wq,
 	wq->q_depth = q_depth;
 	wq->max_wqe_size = max_wqe_size;
 	wq->num_wqebbs_per_page = num_wqebbs_per_page;
-
+	wq->wqebbs_per_page_shift = ilog2(num_wqebbs_per_page);
+	wq->wqebb_size_shift = wqebb_size_shift;
 	wq->block_vaddr = WQ_BASE_VADDR(wqs, wq);
 	wq->shadow_block_vaddr = WQ_BASE_ADDR(wqs, wq);
 	wq->block_paddr = WQ_BASE_PADDR(wqs, wq);
@@ -604,7 +613,9 @@ int hinic_wqs_cmdq_alloc(struct hinic_cmdq_pages *cmdq_pages,
 			 u16 q_depth, u16 max_wqe_size)
 {
 	struct pci_dev *pdev = hwif->pdev;
+	u16 num_wqebbs_per_page_shift;
 	u16 num_wqebbs_per_page;
+	u16 wqebb_size_shift;
 	int i, j, err = -ENOMEM;
 
 	if (wqebb_size == 0) {
@@ -622,7 +633,9 @@ int hinic_wqs_cmdq_alloc(struct hinic_cmdq_pages *cmdq_pages,
 		return -EINVAL;
 	}
 
-	num_wqebbs_per_page = ALIGN(wq_page_size, wqebb_size) / wqebb_size;
+	wqebb_size_shift = ilog2(wqebb_size);
+	num_wqebbs_per_page = ALIGN(wq_page_size, wqebb_size)
+				>> wqebb_size_shift;
 
 	if (num_wqebbs_per_page & (num_wqebbs_per_page - 1)) {
 		dev_err(&pdev->dev, "num wqebbs per page must be power of 2\n");
@@ -636,6 +649,7 @@ int hinic_wqs_cmdq_alloc(struct hinic_cmdq_pages *cmdq_pages,
 		dev_err(&pdev->dev, "Failed to allocate CMDQ page\n");
 		return err;
 	}
+	num_wqebbs_per_page_shift = ilog2(num_wqebbs_per_page);
 
 	for (i = 0; i < cmdq_blocks; i++) {
 		wq[i].hwif = hwif;
@@ -647,7 +661,8 @@ int hinic_wqs_cmdq_alloc(struct hinic_cmdq_pages *cmdq_pages,
 		wq[i].q_depth = q_depth;
 		wq[i].max_wqe_size = max_wqe_size;
 		wq[i].num_wqebbs_per_page = num_wqebbs_per_page;
-
+		wq[i].wqebbs_per_page_shift = num_wqebbs_per_page_shift;
+		wq[i].wqebb_size_shift = wqebb_size_shift;
 		wq[i].block_vaddr = CMDQ_BASE_VADDR(cmdq_pages, &wq[i]);
 		wq[i].shadow_block_vaddr = CMDQ_BASE_ADDR(cmdq_pages, &wq[i]);
 		wq[i].block_paddr = CMDQ_BASE_PADDR(cmdq_pages, &wq[i]);
@@ -741,7 +756,7 @@ struct hinic_hw_wqe *hinic_get_wqe(struct hinic_wq *wq, unsigned int wqe_size,
 
 	*prod_idx = MASKED_WQE_IDX(wq, atomic_read(&wq->prod_idx));
 
-	num_wqebbs = ALIGN(wqe_size, wq->wqebb_size) / wq->wqebb_size;
+	num_wqebbs = ALIGN(wqe_size, wq->wqebb_size) >> wq->wqebb_size_shift;
 
 	if (atomic_sub_return(num_wqebbs, &wq->delta) <= 0) {
 		atomic_add(num_wqebbs, &wq->delta);
@@ -795,7 +810,8 @@ void hinic_return_wqe(struct hinic_wq *wq, unsigned int wqe_size)
  **/
 void hinic_put_wqe(struct hinic_wq *wq, unsigned int wqe_size)
 {
-	int num_wqebbs = ALIGN(wqe_size, wq->wqebb_size) / wq->wqebb_size;
+	int num_wqebbs = ALIGN(wqe_size, wq->wqebb_size)
+			>> wq->wqebb_size_shift;
 
 	atomic_add(num_wqebbs, &wq->cons_idx);
 
@@ -813,7 +829,8 @@ void hinic_put_wqe(struct hinic_wq *wq, unsigned int wqe_size)
 struct hinic_hw_wqe *hinic_read_wqe(struct hinic_wq *wq, unsigned int wqe_size,
 				    u16 *cons_idx)
 {
-	int num_wqebbs = ALIGN(wqe_size, wq->wqebb_size) / wq->wqebb_size;
+	int num_wqebbs = ALIGN(wqe_size, wq->wqebb_size)
+			>> wq->wqebb_size_shift;
 	u16 curr_cons_idx, end_cons_idx;
 	int curr_pg, end_pg;
 
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_wq.h b/drivers/net/ethernet/huawei/hinic/hinic_hw_wq.h
index 9b66545ba563..0a936cd6709b 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_wq.h
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_wq.h
@@ -39,7 +39,8 @@ struct hinic_wq {
 	u16             q_depth;
 	u16             max_wqe_size;
 	u16             num_wqebbs_per_page;
-
+	u16		wqebbs_per_page_shift;
+	u16		wqebb_size_shift;
 	/* The addresses are 64 bit in the HW */
 	u64             block_paddr;
 	void            **shadow_block_vaddr;
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_wqe.h b/drivers/net/ethernet/huawei/hinic/hinic_hw_wqe.h
index 9754d6ed5f4a..138941527872 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_wqe.h
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_wqe.h
@@ -170,6 +170,10 @@
 
 #define HINIC_RQ_CQE_STATUS_RXDONE_MASK         0x1
 
+#define HINIC_RQ_CQE_STATUS_CSUM_ERR_SHIFT	0
+
+#define HINIC_RQ_CQE_STATUS_CSUM_ERR_MASK	0xFFFFU
+
 #define HINIC_RQ_CQE_STATUS_GET(val, member)    \
 		(((val) >> HINIC_RQ_CQE_STATUS_##member##_SHIFT) & \
 		 HINIC_RQ_CQE_STATUS_##member##_MASK)
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c b/drivers/net/ethernet/huawei/hinic/hinic_main.c
index fdf2bdb6b0d0..6d48dc62a44b 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
@@ -600,9 +600,6 @@ static int add_mac_addr(struct net_device *netdev, const u8 *addr)
 	u16 vid = 0;
 	int err;
 
-	if (!is_valid_ether_addr(addr))
-		return -EADDRNOTAVAIL;
-
 	netif_info(nic_dev, drv, netdev, "set mac addr = %02x %02x %02x %02x %02x %02x\n",
 		   addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
 
@@ -726,6 +723,7 @@ static void set_rx_mode(struct work_struct *work)
 {
 	struct hinic_rx_mode_work *rx_mode_work = work_to_rx_mode_work(work);
 	struct hinic_dev *nic_dev = rx_mode_work_to_nic_dev(rx_mode_work);
+	struct netdev_hw_addr *ha;
 
 	netif_info(nic_dev, drv, nic_dev->netdev, "set rx mode work\n");
 
@@ -733,6 +731,9 @@ static void set_rx_mode(struct work_struct *work)
 
 	__dev_uc_sync(nic_dev->netdev, add_mac_addr, remove_mac_addr);
 	__dev_mc_sync(nic_dev->netdev, add_mac_addr, remove_mac_addr);
+
+	netdev_for_each_mc_addr(ha, nic_dev->netdev)
+		add_mac_addr(nic_dev->netdev, ha->addr);
 }
 
 static void hinic_set_rx_mode(struct net_device *netdev)
@@ -806,7 +807,8 @@ static const struct net_device_ops hinic_netdev_ops = {
 static void netdev_features_init(struct net_device *netdev)
 {
 	netdev->hw_features = NETIF_F_SG | NETIF_F_HIGHDMA | NETIF_F_IP_CSUM |
-			      NETIF_F_IPV6_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			      NETIF_F_IPV6_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			      NETIF_F_RXCSUM;
 
 	netdev->vlan_features = netdev->hw_features;
 
@@ -869,12 +871,16 @@ static int set_features(struct hinic_dev *nic_dev,
 			netdev_features_t features, bool force_change)
 {
 	netdev_features_t changed = force_change ? ~0 : pre_features ^ features;
+	u32 csum_en = HINIC_RX_CSUM_OFFLOAD_EN;
 	int err = 0;
 
 	if (changed & NETIF_F_TSO)
 		err = hinic_port_set_tso(nic_dev, (features & NETIF_F_TSO) ?
 					 HINIC_TSO_ENABLE : HINIC_TSO_DISABLE);
 
+	if (changed & NETIF_F_RXCSUM)
+		err = hinic_set_rx_csum_offload(nic_dev, csum_en);
+
 	return err;
 }
 
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_port.c b/drivers/net/ethernet/huawei/hinic/hinic_port.c
index 7575a7d3bd9f..e9f76e904610 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_port.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_port.c
@@ -409,3 +409,31 @@ int hinic_port_set_tso(struct hinic_dev *nic_dev, enum hinic_tso_state state)
 
 	return 0;
 }
+
+int hinic_set_rx_csum_offload(struct hinic_dev *nic_dev, u32 en)
+{
+	struct hinic_checksum_offload rx_csum_cfg = {0};
+	struct hinic_hwdev *hwdev = nic_dev->hwdev;
+	struct hinic_hwif *hwif = hwdev->hwif;
+	struct pci_dev *pdev = hwif->pdev;
+	u16 out_size;
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	rx_csum_cfg.func_id = HINIC_HWIF_FUNC_IDX(hwif);
+	rx_csum_cfg.rx_csum_offload = en;
+
+	err = hinic_port_msg_cmd(hwdev, HINIC_PORT_CMD_SET_RX_CSUM,
+				 &rx_csum_cfg, sizeof(rx_csum_cfg),
+				 &rx_csum_cfg, &out_size);
+	if (err || !out_size || rx_csum_cfg.status) {
+		dev_err(&pdev->dev,
+			"Failed to set rx csum offload, ret = %d\n",
+			rx_csum_cfg.status);
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_port.h b/drivers/net/ethernet/huawei/hinic/hinic_port.h
index f6e3220fe28f..02d896eed455 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_port.h
+++ b/drivers/net/ethernet/huawei/hinic/hinic_port.h
@@ -183,6 +183,15 @@ struct hinic_tso_config {
 	u8	resv2[3];
 };
 
+struct hinic_checksum_offload {
+	u8	status;
+	u8	version;
+	u8	rsvd0[6];
+
+	u16	func_id;
+	u16	rsvd1;
+	u32	rx_csum_offload;
+};
 int hinic_port_add_mac(struct hinic_dev *nic_dev, const u8 *addr,
 		       u16 vlan_id);
 
@@ -213,4 +222,5 @@ int hinic_port_get_cap(struct hinic_dev *nic_dev,
 
 int hinic_port_set_tso(struct hinic_dev *nic_dev, enum hinic_tso_state state);
 
+int hinic_set_rx_csum_offload(struct hinic_dev *nic_dev, u32 en);
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_rx.c b/drivers/net/ethernet/huawei/hinic/hinic_rx.c
index 4c0f7eda1166..f86f2e693224 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_rx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_rx.c
@@ -89,6 +89,28 @@ static void rxq_stats_init(struct hinic_rxq *rxq)
 	hinic_rxq_clean_stats(rxq);
 }
 
+static void rx_csum(struct hinic_rxq *rxq, u16 cons_idx,
+		    struct sk_buff *skb)
+{
+	struct net_device *netdev = rxq->netdev;
+	struct hinic_rq_cqe *cqe;
+	struct hinic_rq *rq;
+	u32 csum_err;
+	u32 status;
+
+	rq = rxq->rq;
+	cqe = rq->cqe[cons_idx];
+	status = be32_to_cpu(cqe->status);
+	csum_err = HINIC_RQ_CQE_STATUS_GET(status, CSUM_ERR);
+
+	if (!(netdev->features & NETIF_F_RXCSUM))
+		return;
+
+	if (!csum_err)
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+	else
+		skb->ip_summed = CHECKSUM_NONE;
+}
 /**
  * rx_alloc_skb - allocate skb and map it to dma address
  * @rxq: rx queue
@@ -207,9 +229,9 @@ static int rx_alloc_pkts(struct hinic_rxq *rxq)
 		wmb();  /* write all the wqes before update PI */
 
 		hinic_rq_update(rxq->rq, prod_idx);
+		tasklet_schedule(&rxq->rx_task);
 	}
 
-	tasklet_schedule(&rxq->rx_task);
 	return i;
 }
 
@@ -328,6 +350,8 @@ static int rxq_recv(struct hinic_rxq *rxq, int budget)
 
 		rx_unmap_skb(rxq, hinic_sge_to_dma(&sge));
 
+		rx_csum(rxq, ci, skb);
+
 		prefetch(skb->data);
 
 		pkt_len = sge.len;
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_rx.h b/drivers/net/ethernet/huawei/hinic/hinic_rx.h
index 27c9af4b1c12..7ab57d6ff83f 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_rx.h
+++ b/drivers/net/ethernet/huawei/hinic/hinic_rx.h
@@ -23,6 +23,11 @@
 
 #include "hinic_hw_qp.h"
 
+#define BIT(nr)			(1UL << (nr))
+#define HINIC_RX_CSUM_OFFLOAD_EN	0xFFF
+#define HINIC_RX_CSUM_HW_CHECK_NONE	BIT(7)
+#define HINIC_RX_CSUM_IPSU_OTHER_ERR	BIT(8)
+
 struct hinic_rxq_stats {
 	u64                     pkts;
 	u64                     bytes;
-- 
2.17.1

