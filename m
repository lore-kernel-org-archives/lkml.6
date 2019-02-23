Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9CCC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A299E206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfBWJXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 04:23:20 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4272 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727717AbfBWJXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 04:23:12 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9F15BA79752C3310DA4F;
        Sat, 23 Feb 2019 17:23:07 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Sat, 23 Feb 2019 17:22:58 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [Patch net-next 02/12] net: hns3: avoid mult + div op in critical data path
Date:   Sat, 23 Feb 2019 17:22:09 +0800
Message-ID: <1550913739-13232-3-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550913739-13232-1-git-send-email-tanhuazhong@huawei.com>
References: <1550913739-13232-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>

This patch uses shift offset to avoid doing mult and div operation.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 15 ++++++++-------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h |  3 +++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index d75977c..14c3aa7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -658,7 +658,7 @@ static int hns3_set_tso(struct sk_buff *skb, u32 *paylen,
 
 	/* normal or tunnel packet*/
 	l4_offset = l4.hdr - skb->data;
-	hdr_len = (l4.tcp->doff * 4) + l4_offset;
+	hdr_len = (l4.tcp->doff << 2) + l4_offset;
 
 	/* remove payload length from inner pseudo checksum when tso*/
 	l4_paylen = skb->len - l4_offset;
@@ -1100,8 +1100,8 @@ static int hns3_fill_desc(struct hns3_enet_ring *ring, void *priv,
 
 	desc_cb->length = size;
 
-	frag_buf_num = (size + HNS3_MAX_BD_SIZE - 1) / HNS3_MAX_BD_SIZE;
-	sizeoflast = size % HNS3_MAX_BD_SIZE;
+	frag_buf_num = (size + HNS3_MAX_BD_SIZE - 1) >> HNS3_MAX_BD_SIZE_OFFSET;
+	sizeoflast = size & HNS3_TX_LAST_SIZE_M;
 	sizeoflast = sizeoflast ? sizeoflast : HNS3_MAX_BD_SIZE;
 
 	/* When frag size is bigger than hardware limit, split this frag */
@@ -1145,14 +1145,14 @@ static int hns3_nic_maybe_stop_tso(struct sk_buff **out_skb, int *bnum,
 	int i;
 
 	size = skb_headlen(skb);
-	buf_num = (size + HNS3_MAX_BD_SIZE - 1) / HNS3_MAX_BD_SIZE;
+	buf_num = (size + HNS3_MAX_BD_SIZE - 1) >> HNS3_MAX_BD_SIZE_OFFSET;
 
 	frag_num = skb_shinfo(skb)->nr_frags;
 	for (i = 0; i < frag_num; i++) {
 		frag = &skb_shinfo(skb)->frags[i];
 		size = skb_frag_size(frag);
-		bdnum_for_frag =
-			(size + HNS3_MAX_BD_SIZE - 1) / HNS3_MAX_BD_SIZE;
+		bdnum_for_frag = (size + HNS3_MAX_BD_SIZE - 1) >>
+				 HNS3_MAX_BD_SIZE_OFFSET;
 		if (bdnum_for_frag > HNS3_MAX_BD_PER_FRAG)
 			return -ENOMEM;
 
@@ -1160,7 +1160,8 @@ static int hns3_nic_maybe_stop_tso(struct sk_buff **out_skb, int *bnum,
 	}
 
 	if (unlikely(buf_num > HNS3_MAX_BD_PER_FRAG)) {
-		buf_num = (skb->len + HNS3_MAX_BD_SIZE - 1) / HNS3_MAX_BD_SIZE;
+		buf_num = (skb->len + HNS3_MAX_BD_SIZE - 1) >>
+			  HNS3_MAX_BD_SIZE_OFFSET;
 		if (ring_space(ring) < buf_num)
 			return -EBUSY;
 		/* manual split the send packet */
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 71ff8f4..5c41465 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -184,6 +184,8 @@ enum hns3_nic_state {
 #define HNS3_TXD_MSS_S				0
 #define HNS3_TXD_MSS_M				(0x3fff << HNS3_TXD_MSS_S)
 
+#define HNS3_TX_LAST_SIZE_M                    0xffff
+
 #define HNS3_VECTOR_TX_IRQ			BIT_ULL(0)
 #define HNS3_VECTOR_RX_IRQ			BIT_ULL(1)
 
@@ -191,6 +193,7 @@ enum hns3_nic_state {
 #define HNS3_VECTOR_INITED			1
 
 #define HNS3_MAX_BD_SIZE			65535
+#define HNS3_MAX_BD_SIZE_OFFSET		16
 #define HNS3_MAX_BD_PER_FRAG			8
 #define HNS3_MAX_BD_PER_PKT			MAX_SKB_FRAGS
 
-- 
2.7.4

