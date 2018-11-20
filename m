Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0CDC18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE41206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE41206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbeKUAKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:10:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15123 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728619AbeKUAKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:10:44 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D001187F79420;
        Tue, 20 Nov 2018 21:41:22 +0800 (CST)
Received: from localhost.localdomain (10.175.34.53) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Tue, 20 Nov 2018 21:41:17 +0800
From:   Xue Chaojing <xuechaojing@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <xuechaojing@huawei.com>,
        <netdev@vger.kernel.org>, <wulike1@huawei.com>,
        <chiqijun@huawei.com>, <fy.wang@huawei.com>, <tony.qu@huawei.com>,
        <luoshaokai@huawei.com>
Subject: [PATCH 2/4] net-next/hinic:add rx checksum offload for HiNIC
Date:   Tue, 20 Nov 2018 05:47:32 +0000
Message-ID: <20181120054734.17360-2-xuechaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120054734.17360-1-xuechaojing@huawei.com>
References: <20181120054734.17360-1-xuechaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.34.53]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to improve performance, this patch adds rx checksum offload
for the HiNIC driver. Performance test(Iperf) shows more than 80%
improvement in TCP streams.

Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>
---
 .../net/ethernet/huawei/hinic/hinic_hw_dev.h  |  2 ++
 .../net/ethernet/huawei/hinic/hinic_hw_wqe.h  |  4 +++
 .../net/ethernet/huawei/hinic/hinic_main.c    |  7 ++++-
 .../net/ethernet/huawei/hinic/hinic_port.c    | 28 +++++++++++++++++++
 .../net/ethernet/huawei/hinic/hinic_port.h    | 10 +++++++
 drivers/net/ethernet/huawei/hinic/hinic_rx.c  | 24 ++++++++++++++++
 drivers/net/ethernet/huawei/hinic/hinic_rx.h  |  4 +++
 7 files changed, 78 insertions(+), 1 deletion(-)

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
index fdf2bdb6b0d0..c675077f9774 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
@@ -806,7 +806,8 @@ static const struct net_device_ops hinic_netdev_ops = {
 static void netdev_features_init(struct net_device *netdev)
 {
 	netdev->hw_features = NETIF_F_SG | NETIF_F_HIGHDMA | NETIF_F_IP_CSUM |
-			      NETIF_F_IPV6_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+			      NETIF_F_IPV6_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
+			      NETIF_F_RXCSUM;
 
 	netdev->vlan_features = netdev->hw_features;
 
@@ -869,12 +870,16 @@ static int set_features(struct hinic_dev *nic_dev,
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
index 4c0f7eda1166..93e8f207f6da 100644
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
@@ -328,6 +350,8 @@ static int rxq_recv(struct hinic_rxq *rxq, int budget)
 
 		rx_unmap_skb(rxq, hinic_sge_to_dma(&sge));
 
+		rx_csum(rxq, ci, skb);
+
 		prefetch(skb->data);
 
 		pkt_len = sge.len;
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_rx.h b/drivers/net/ethernet/huawei/hinic/hinic_rx.h
index 27c9af4b1c12..ab3fabab91b2 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_rx.h
+++ b/drivers/net/ethernet/huawei/hinic/hinic_rx.h
@@ -23,6 +23,10 @@
 
 #include "hinic_hw_qp.h"
 
+#define HINIC_RX_CSUM_OFFLOAD_EN	0xFFF
+#define HINIC_RX_CSUM_HW_CHECK_NONE	BIT(7)
+#define HINIC_RX_CSUM_IPSU_OTHER_ERR	BIT(8)
+
 struct hinic_rxq_stats {
 	u64                     pkts;
 	u64                     bytes;
-- 
2.17.1

