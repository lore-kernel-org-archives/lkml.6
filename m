Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4847FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E3020877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:22:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E3020877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbeIYP3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:29:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12699 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727767AbeIYP3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:29:02 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2F78FE247D698;
        Tue, 25 Sep 2018 17:22:22 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.202.226.54) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.399.0; Tue, 25 Sep 2018 17:22:16 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net] net: hns: fix for unmapping problem when SMMU is on
Date:   Tue, 25 Sep 2018 10:21:55 +0100
Message-ID: <20180925092155.11024-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.54]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

If SMMU is on, there is more likely that skb_shinfo(skb)->frags[i]
can not send by a single BD. when this happen, the
hns_nic_net_xmit_hw function map the whole data in a frags using
skb_frag_dma_map, but unmap each BD' data individually when tx is
done, which causes problem when SMMU is on.

This patch fixes this problem by ummapping the whole data in a
frags when tx is done.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Reviewed-by: Yisen Zhuang <yisen.zhuang@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hnae.c     |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 30 +++++++++++++++++----------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hnae.c b/drivers/net/ethernet/hisilicon/hns/hnae.c
index a051e58..79d03f8 100644
--- a/drivers/net/ethernet/hisilicon/hns/hnae.c
+++ b/drivers/net/ethernet/hisilicon/hns/hnae.c
@@ -84,7 +84,7 @@ static void hnae_unmap_buffer(struct hnae_ring *ring, struct hnae_desc_cb *cb)
 	if (cb->type == DESC_TYPE_SKB)
 		dma_unmap_single(ring_to_dev(ring), cb->dma, cb->length,
 				 ring_to_dma_dir(ring));
-	else
+	else if (cb->length)
 		dma_unmap_page(ring_to_dev(ring), cb->dma, cb->length,
 			       ring_to_dma_dir(ring));
 }
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index f56855e..5ce23d4 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -40,9 +40,9 @@
 #define SKB_TMP_LEN(SKB) \
 	(((SKB)->transport_header - (SKB)->mac_header) + tcp_hdrlen(SKB))
 
-static void fill_v2_desc(struct hnae_ring *ring, void *priv,
-			 int size, dma_addr_t dma, int frag_end,
-			 int buf_num, enum hns_desc_type type, int mtu)
+static void fill_v2_desc_hw(struct hnae_ring *ring, void *priv, int size,
+			    int send_sz, dma_addr_t dma, int frag_end,
+			    int buf_num, enum hns_desc_type type, int mtu)
 {
 	struct hnae_desc *desc = &ring->desc[ring->next_to_use];
 	struct hnae_desc_cb *desc_cb = &ring->desc_cb[ring->next_to_use];
@@ -64,7 +64,7 @@ static void fill_v2_desc(struct hnae_ring *ring, void *priv,
 	desc_cb->type = type;
 
 	desc->addr = cpu_to_le64(dma);
-	desc->tx.send_size = cpu_to_le16((u16)size);
+	desc->tx.send_size = cpu_to_le16((u16)send_sz);
 
 	/* config bd buffer end */
 	hnae_set_bit(rrcfv, HNSV2_TXD_VLD_B, 1);
@@ -133,6 +133,14 @@ static void fill_v2_desc(struct hnae_ring *ring, void *priv,
 	ring_ptr_move_fw(ring, next_to_use);
 }
 
+static void fill_v2_desc(struct hnae_ring *ring, void *priv,
+			 int size, dma_addr_t dma, int frag_end,
+			 int buf_num, enum hns_desc_type type, int mtu)
+{
+	fill_v2_desc_hw(ring, priv, size, size, dma, frag_end,
+			buf_num, type, mtu);
+}
+
 static const struct acpi_device_id hns_enet_acpi_match[] = {
 	{ "HISI00C1", 0 },
 	{ "HISI00C2", 0 },
@@ -289,15 +297,15 @@ static void fill_tso_desc(struct hnae_ring *ring, void *priv,
 
 	/* when the frag size is bigger than hardware, split this frag */
 	for (k = 0; k < frag_buf_num; k++)
-		fill_v2_desc(ring, priv,
-			     (k == frag_buf_num - 1) ?
+		fill_v2_desc_hw(ring, priv, k == 0 ? size : 0,
+				(k == frag_buf_num - 1) ?
 					sizeoflast : BD_MAX_SEND_SIZE,
-			     dma + BD_MAX_SEND_SIZE * k,
-			     frag_end && (k == frag_buf_num - 1) ? 1 : 0,
-			     buf_num,
-			     (type == DESC_TYPE_SKB && !k) ?
+				dma + BD_MAX_SEND_SIZE * k,
+				frag_end && (k == frag_buf_num - 1) ? 1 : 0,
+				buf_num,
+				(type == DESC_TYPE_SKB && !k) ?
 					DESC_TYPE_SKB : DESC_TYPE_PAGE,
-			     mtu);
+				mtu);
 }
 
 netdev_tx_t hns_nic_net_xmit_hw(struct net_device *ndev,
-- 
2.7.4


