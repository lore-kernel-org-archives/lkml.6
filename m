Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23BBC169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3FD208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3FD208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeJPTrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:47:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48117 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727007AbeJPTq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:46:59 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A95BF91D17319;
        Tue, 16 Oct 2018 19:56:47 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Tue, 16 Oct 2018 19:56:42 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>
CC:     <huangdaode@hisilicon.com>, <xuwei5@hisilicon.com>,
        <liguozhu@hisilicon.com>, <Yisen.Zhuang@huawei.com>,
        <john.garry@huawei.com>, <linuxarm@huawei.com>,
        <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <lipeng321@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 3/5] net: hns3: add handling for big TX fragment
Date:   Tue, 16 Oct 2018 19:58:50 +0800
Message-ID: <1539691132-158455-4-git-send-email-linyunsheng@huawei.com>
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

From: Fuyun Liang <liangfuyun1@huawei.com>

This patch unifies big tx fragment handling for tso and non-tso
case.

Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 45 +++++++++++++++++--------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 288d527..3fb8e48 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -985,10 +985,13 @@ static int hns3_fill_desc(struct hns3_enet_ring *ring, void *priv,
 	u32 ol_type_vlan_len_msec = 0;
 	u16 bdtp_fe_sc_vld_ra_ri = 0;
 	struct skb_frag_struct *frag;
+	unsigned int frag_buf_num;
 	u32 type_cs_vlan_tso = 0;
 	struct sk_buff *skb;
 	u16 inner_vtag = 0;
 	u16 out_vtag = 0;
+	unsigned int k;
+	int sizeoflast;
 	u32 paylen = 0;
 	dma_addr_t dma;
 	u16 mss = 0;
@@ -996,16 +999,6 @@ static int hns3_fill_desc(struct hns3_enet_ring *ring, void *priv,
 	u8 il4_proto;
 	int ret;
 
-	/* The txbd's baseinfo of DESC_TYPE_PAGE & DESC_TYPE_SKB */
-	desc_cb->priv = priv;
-	desc_cb->length = size;
-	desc_cb->type = type;
-
-	/* now, fill the descriptor */
-	desc->tx.send_size = cpu_to_le16((u16)size);
-	hns3_set_txbd_baseinfo(&bdtp_fe_sc_vld_ra_ri, frag_end);
-	desc->tx.bdtp_fe_sc_vld_ra_ri = cpu_to_le16(bdtp_fe_sc_vld_ra_ri);
-
 	if (type == DESC_TYPE_SKB) {
 		skb = (struct sk_buff *)priv;
 		paylen = skb->len;
@@ -1058,11 +1051,35 @@ static int hns3_fill_desc(struct hns3_enet_ring *ring, void *priv,
 		return -ENOMEM;
 	}
 
-	desc_cb->dma = dma;
-	desc->addr = cpu_to_le64(dma);
+	frag_buf_num = (size + HNS3_MAX_BD_SIZE - 1) / HNS3_MAX_BD_SIZE;
+	sizeoflast = size % HNS3_MAX_BD_SIZE;
+	sizeoflast = sizeoflast ? sizeoflast : HNS3_MAX_BD_SIZE;
+
+	/* When frag size is bigger than hardware limit, split this frag */
+	for (k = 0; k < frag_buf_num; k++) {
+		/* The txbd's baseinfo of DESC_TYPE_PAGE & DESC_TYPE_SKB */
+		desc_cb->priv = priv;
+		desc_cb->length = (k == frag_buf_num - 1) ?
+					sizeoflast : HNS3_MAX_BD_SIZE;
+		desc_cb->dma = dma + HNS3_MAX_BD_SIZE * k;
+		desc_cb->type = (type == DESC_TYPE_SKB && !k) ?
+					DESC_TYPE_SKB : DESC_TYPE_PAGE;
+
+		/* now, fill the descriptor */
+		desc->addr = cpu_to_le64(dma + HNS3_MAX_BD_SIZE * k);
+		desc->tx.send_size = cpu_to_le16((u16)desc_cb->length);
+		hns3_set_txbd_baseinfo(&bdtp_fe_sc_vld_ra_ri,
+				       frag_end && (k == frag_buf_num - 1) ?
+						1 : 0);
+		desc->tx.bdtp_fe_sc_vld_ra_ri =
+				cpu_to_le16(bdtp_fe_sc_vld_ra_ri);
+
+		/* move ring pointer to next.*/
+		ring_ptr_move_fw(ring, next_to_use);
 
-	/* move ring pointer to next.*/
-	ring_ptr_move_fw(ring, next_to_use);
+		desc_cb = &ring->desc_cb[ring->next_to_use];
+		desc = &ring->desc[ring->next_to_use];
+	}
 
 	return 0;
 }
-- 
1.9.1

