Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5CBC10F07
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26B8206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfBWJXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 04:23:17 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4273 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727704AbfBWJXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 04:23:12 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A432451D57CB43019698;
        Sat, 23 Feb 2019 17:23:07 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Sat, 23 Feb 2019 17:22:59 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
        Huazhong tan <tanhuazhong@huawei.com>
Subject: [Patch net-next 03/12] net: hns3: limit some variable scope in critical data path
Date:   Sat, 23 Feb 2019 17:22:10 +0800
Message-ID: <1550913739-13232-4-git-send-email-tanhuazhong@huawei.com>
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

This patch limits some variables' scope as much as possible in
hns3_fill_desc.

Also, only set l3_type and l4_type when necessary.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Huazhong tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 35 +++++++++++--------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 14c3aa7..a84060fd 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1029,26 +1029,21 @@ static int hns3_fill_desc(struct hns3_enet_ring *ring, void *priv,
 	struct hns3_desc_cb *desc_cb = &ring->desc_cb[ring->next_to_use];
 	struct hns3_desc *desc = &ring->desc[ring->next_to_use];
 	struct device *dev = ring_to_dev(ring);
-	u32 ol_type_vlan_len_msec = 0;
 	u16 bdtp_fe_sc_vld_ra_ri = 0;
 	struct skb_frag_struct *frag;
 	unsigned int frag_buf_num;
-	u32 type_cs_vlan_tso = 0;
-	struct sk_buff *skb;
-	u16 inner_vtag = 0;
-	u16 out_vtag = 0;
-	unsigned int k;
-	int sizeoflast;
-	u32 paylen = 0;
+	int k, sizeoflast;
 	dma_addr_t dma;
-	u16 mss = 0;
-	u8 ol4_proto;
-	u8 il4_proto;
-	int ret;
 
 	if (type == DESC_TYPE_SKB) {
-		skb = (struct sk_buff *)priv;
-		paylen = skb->len;
+		struct sk_buff *skb = (struct sk_buff *)priv;
+		u32 ol_type_vlan_len_msec = 0;
+		u32 type_cs_vlan_tso = 0;
+		u32 paylen = skb->len;
+		u16 inner_vtag = 0;
+		u16 out_vtag = 0;
+		u16 mss = 0;
+		int ret;
 
 		ret = hns3_fill_desc_vtags(skb, ring, &type_cs_vlan_tso,
 					   &ol_type_vlan_len_msec,
@@ -1057,6 +1052,8 @@ static int hns3_fill_desc(struct hns3_enet_ring *ring, void *priv,
 			return ret;
 
 		if (skb->ip_summed == CHECKSUM_PARTIAL) {
+			u8 ol4_proto, il4_proto;
+
 			skb_reset_mac_len(skb);
 
 			ret = hns3_get_l4_protocol(skb, &ol4_proto, &il4_proto);
@@ -2353,11 +2350,6 @@ static void hns3_rx_checksum(struct hns3_enet_ring *ring, struct sk_buff *skb,
 		return;
 	}
 
-	l3_type = hnae3_get_field(l234info, HNS3_RXD_L3ID_M,
-				  HNS3_RXD_L3ID_S);
-	l4_type = hnae3_get_field(l234info, HNS3_RXD_L4ID_M,
-				  HNS3_RXD_L4ID_S);
-
 	ol4_type = hnae3_get_field(l234info, HNS3_RXD_OL4ID_M,
 				   HNS3_RXD_OL4ID_S);
 	switch (ol4_type) {
@@ -2366,6 +2358,11 @@ static void hns3_rx_checksum(struct hns3_enet_ring *ring, struct sk_buff *skb,
 		skb->csum_level = 1;
 		/* fall through */
 	case HNS3_OL4_TYPE_NO_TUN:
+		l3_type = hnae3_get_field(l234info, HNS3_RXD_L3ID_M,
+					  HNS3_RXD_L3ID_S);
+		l4_type = hnae3_get_field(l234info, HNS3_RXD_L4ID_M,
+					  HNS3_RXD_L4ID_S);
+
 		/* Can checksum ipv4 or ipv6 + UDP/TCP/SCTP packets */
 		if ((l3_type == HNS3_L3_TYPE_IPV4 ||
 		     l3_type == HNS3_L3_TYPE_IPV6) &&
-- 
2.7.4

