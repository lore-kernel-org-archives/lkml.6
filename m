Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C29C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9235A20811
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9235A20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbeKMUMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:12:03 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:54100 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732205AbeKMUMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:12:02 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 15299268A1EF5;
        Tue, 13 Nov 2018 18:14:36 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.86.21) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Tue, 13 Nov 2018 18:14:27 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH net-next 4/5] net: hns3: Add skb chain when num of RX buf exceeds MAX_SKB_FRAGS
Date:   Tue, 13 Nov 2018 10:13:06 +0000
Message-ID: <20181113101307.6020-5-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181113101307.6020-1-salil.mehta@huawei.com>
References: <20181113101307.6020-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.86.21]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Li <lipeng321@huawei.com>

MAX_SKB_FRAGS in protocol stack is defined as:

MAX_SKB_FRAGS is 17 when PAGE_SIZE is 4K. If HW enable GRO, it may
merge small packets and the rx buffer may be more than
MAX_SKB_FRAGS. So driver will add skb chain when RX buffer num.
more than MAX_SKB_FRAGS.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 37 ++++++++++++++++++-
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  2 +
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 860067898471..7776089b6bc2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2361,6 +2361,9 @@ static void hns3_rx_checksum(struct hns3_enet_ring *ring, struct sk_buff *skb,
 
 static void hns3_rx_skb(struct hns3_enet_ring *ring, struct sk_buff *skb)
 {
+	if (skb_has_frag_list(skb))
+		napi_gro_flush(&ring->tqp_vector->napi, false);
+
 	napi_gro_receive(&ring->tqp_vector->napi, skb);
 }
 
@@ -2417,6 +2420,8 @@ static int hns3_alloc_skb(struct hns3_enet_ring *ring, int length,
 	prefetchw(skb->data);
 
 	ring->pending_buf = 1;
+	ring->frag_num = 0;
+	ring->tail_skb = NULL;
 	if (length <= HNS3_RX_HEAD_SIZE) {
 		memcpy(__skb_put(skb, length), va, ALIGN(length, sizeof(long)));
 
@@ -2435,7 +2440,7 @@ static int hns3_alloc_skb(struct hns3_enet_ring *ring, int length,
 
 	ring->pull_len = eth_get_headlen(va, HNS3_RX_HEAD_SIZE);
 	__skb_put(skb, ring->pull_len);
-	hns3_nic_reuse_page(skb, 0, ring, ring->pull_len,
+	hns3_nic_reuse_page(skb, ring->frag_num++, ring, ring->pull_len,
 			    desc_cb);
 	ring_ptr_move_fw(ring, next_to_clean);
 
@@ -2446,6 +2451,8 @@ static int hns3_add_frag(struct hns3_enet_ring *ring, struct hns3_desc *desc,
 			 struct sk_buff **out_skb, bool pending)
 {
 	struct sk_buff *skb = *out_skb;
+	struct sk_buff *head_skb = *out_skb;
+	struct sk_buff *new_skb;
 	struct hns3_desc_cb *desc_cb;
 	struct hns3_desc *pre_desc;
 	u32 bd_base_info;
@@ -2470,7 +2477,33 @@ static int hns3_add_frag(struct hns3_enet_ring *ring, struct hns3_desc *desc,
 		if (!hnae3_get_bit(bd_base_info, HNS3_RXD_VLD_B))
 			return -ENXIO;
 
-		hns3_nic_reuse_page(skb, ring->pending_buf, ring, 0, desc_cb);
+		if (unlikely(ring->frag_num >= MAX_SKB_FRAGS)) {
+			new_skb = napi_alloc_skb(&ring->tqp_vector->napi,
+						 HNS3_RX_HEAD_SIZE);
+			if (unlikely(!new_skb)) {
+				netdev_err(ring->tqp->handle->kinfo.netdev,
+					   "alloc rx skb frag fail\n");
+				return -ENXIO;
+			}
+			ring->frag_num = 0;
+
+			if (ring->tail_skb) {
+				ring->tail_skb->next = new_skb;
+				ring->tail_skb = new_skb;
+			} else {
+				skb_shinfo(skb)->frag_list = new_skb;
+				ring->tail_skb = new_skb;
+			}
+		}
+
+		if (ring->tail_skb) {
+			head_skb->truesize += hnae3_buf_size(ring);
+			head_skb->data_len += le16_to_cpu(desc->rx.size);
+			head_skb->len += le16_to_cpu(desc->rx.size);
+			skb = ring->tail_skb;
+		}
+
+		hns3_nic_reuse_page(skb, ring->frag_num++, ring, 0, desc_cb);
 		ring_ptr_move_fw(ring, next_to_clean);
 		ring->pending_buf++;
 	}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index d8c0998127be..8e56b7e44978 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -402,6 +402,7 @@ struct hns3_enet_ring {
 	int next_to_clean;
 
 	int pull_len; /* head length for current packet */
+	u32 frag_num;
 	unsigned char *va; /* first buffer address for current packet */
 
 	u32 flag;          /* ring attribute */
@@ -412,6 +413,7 @@ struct hns3_enet_ring {
 
 	int pending_buf;
 	struct sk_buff *skb;
+	struct sk_buff *tail_skb;
 };
 
 struct hns_queue;
-- 
2.17.1


