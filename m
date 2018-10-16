Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE30C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C65E20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C65E20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeJPTq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:46:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48111 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727002AbeJPTq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:46:58 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9BF7333747B90;
        Tue, 16 Oct 2018 19:56:47 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Tue, 16 Oct 2018 19:56:41 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>
CC:     <huangdaode@hisilicon.com>, <xuwei5@hisilicon.com>,
        <liguozhu@hisilicon.com>, <Yisen.Zhuang@huawei.com>,
        <john.garry@huawei.com>, <linuxarm@huawei.com>,
        <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 2/5] net: hns3: move DMA map into hns3_fill_desc
Date:   Tue, 16 Oct 2018 19:58:49 +0800
Message-ID: <1539691132-158455-3-git-send-email-linyunsheng@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539691132-158455-1-git-send-email-linyunsheng@huawei.com>
References: <1539691132-158455-1-git-send-email-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

To solve the L3 checksum error problem which happens when driver
does not clear L3 checksum, DMA map should be done after calling
skb_cow_head.

This patch moves DMA map into hns3_fill_desc to ensure that DMA
map is done after calling skb_cow_head.

Fixes: 76ad4f0ee747 ("net: hns3: Add support of HNS3 Ethernet Driver for hip08 SoC")
Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 47 ++++++++++++-------------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h |  3 +-
 2 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 953568a..288d527 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -977,18 +977,20 @@ static int hns3_fill_desc_vtags(struct sk_buff *skb,
 }
 
 static int hns3_fill_desc(struct hns3_enet_ring *ring, void *priv,
-			  int size, dma_addr_t dma, int frag_end,
-			  enum hns_desc_type type)
+			  int size, int frag_end, enum hns_desc_type type)
 {
 	struct hns3_desc_cb *desc_cb = &ring->desc_cb[ring->next_to_use];
 	struct hns3_desc *desc = &ring->desc[ring->next_to_use];
+	struct device *dev = ring_to_dev(ring);
 	u32 ol_type_vlan_len_msec = 0;
 	u16 bdtp_fe_sc_vld_ra_ri = 0;
+	struct skb_frag_struct *frag;
 	u32 type_cs_vlan_tso = 0;
 	struct sk_buff *skb;
 	u16 inner_vtag = 0;
 	u16 out_vtag = 0;
 	u32 paylen = 0;
+	dma_addr_t dma;
 	u16 mss = 0;
 	u8 ol4_proto;
 	u8 il4_proto;
@@ -997,11 +999,9 @@ static int hns3_fill_desc(struct hns3_enet_ring *ring, void *priv,
 	/* The txbd's baseinfo of DESC_TYPE_PAGE & DESC_TYPE_SKB */
 	desc_cb->priv = priv;
 	desc_cb->length = size;
-	desc_cb->dma = dma;
 	desc_cb->type = type;
 
 	/* now, fill the descriptor */
-	desc->addr = cpu_to_le64(dma);
 	desc->tx.send_size = cpu_to_le16((u16)size);
 	hns3_set_txbd_baseinfo(&bdtp_fe_sc_vld_ra_ri, frag_end);
 	desc->tx.bdtp_fe_sc_vld_ra_ri = cpu_to_le16(bdtp_fe_sc_vld_ra_ri);
@@ -1046,8 +1046,21 @@ static int hns3_fill_desc(struct hns3_enet_ring *ring, void *priv,
 		desc->tx.mss = cpu_to_le16(mss);
 		desc->tx.vlan_tag = cpu_to_le16(inner_vtag);
 		desc->tx.outer_vlan_tag = cpu_to_le16(out_vtag);
+
+		dma = dma_map_single(dev, skb->data, size, DMA_TO_DEVICE);
+	} else {
+		frag = (struct skb_frag_struct *)priv;
+		dma = skb_frag_dma_map(dev, frag, 0, size, DMA_TO_DEVICE);
+	}
+
+	if (dma_mapping_error(ring->dev, dma)) {
+		ring->stats.sw_err_cnt++;
+		return -ENOMEM;
 	}
 
+	desc_cb->dma = dma;
+	desc->addr = cpu_to_le64(dma);
+
 	/* move ring pointer to next.*/
 	ring_ptr_move_fw(ring, next_to_use);
 
@@ -1137,12 +1150,10 @@ netdev_tx_t hns3_nic_net_xmit(struct sk_buff *skb, struct net_device *netdev)
 	struct hns3_nic_ring_data *ring_data =
 		&tx_ring_data(priv, skb->queue_mapping);
 	struct hns3_enet_ring *ring = ring_data->ring;
-	struct device *dev = priv->dev;
 	struct netdev_queue *dev_queue;
 	struct skb_frag_struct *frag;
 	int next_to_use_head;
 	int next_to_use_frag;
-	dma_addr_t dma;
 	int buf_num;
 	int seg_num;
 	int size;
@@ -1177,15 +1188,8 @@ netdev_tx_t hns3_nic_net_xmit(struct sk_buff *skb, struct net_device *netdev)
 
 	next_to_use_head = ring->next_to_use;
 
-	dma = dma_map_single(dev, skb->data, size, DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, dma)) {
-		netdev_err(netdev, "TX head DMA map failed\n");
-		ring->stats.sw_err_cnt++;
-		goto out_err_tx_ok;
-	}
-
-	ret = priv->ops.fill_desc(ring, skb, size, dma, seg_num == 1 ? 1 : 0,
-			   DESC_TYPE_SKB);
+	ret = priv->ops.fill_desc(ring, skb, size, seg_num == 1 ? 1 : 0,
+				  DESC_TYPE_SKB);
 	if (ret)
 		goto head_dma_map_err;
 
@@ -1194,15 +1198,10 @@ netdev_tx_t hns3_nic_net_xmit(struct sk_buff *skb, struct net_device *netdev)
 	for (i = 1; i < seg_num; i++) {
 		frag = &skb_shinfo(skb)->frags[i - 1];
 		size = skb_frag_size(frag);
-		dma = skb_frag_dma_map(dev, frag, 0, size, DMA_TO_DEVICE);
-		if (dma_mapping_error(dev, dma)) {
-			netdev_err(netdev, "TX frag(%d) DMA map failed\n", i);
-			ring->stats.sw_err_cnt++;
-			goto frag_dma_map_err;
-		}
-		ret = priv->ops.fill_desc(ring, skb_frag_page(frag), size, dma,
-				    seg_num - 1 == i ? 1 : 0,
-				    DESC_TYPE_PAGE);
+
+		ret = priv->ops.fill_desc(ring, frag, size,
+					  seg_num - 1 == i ? 1 : 0,
+					  DESC_TYPE_PAGE);
 
 		if (ret)
 			goto frag_dma_map_err;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index f25b281..71cfca1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -419,8 +419,7 @@ struct hns3_nic_ring_data {
 
 struct hns3_nic_ops {
 	int (*fill_desc)(struct hns3_enet_ring *ring, void *priv,
-			 int size, dma_addr_t dma, int frag_end,
-			 enum hns_desc_type type);
+			 int size, int frag_end, enum hns_desc_type type);
 	int (*maybe_stop_tx)(struct sk_buff **out_skb,
 			     int *bnum, struct hns3_enet_ring *ring);
 	void (*get_rxd_bnum)(u32 bnum_flag, int *out_bnum);
-- 
1.9.1

