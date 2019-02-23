Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA49C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63915206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfBWJXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 04:23:22 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4268 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727689AbfBWJXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 04:23:13 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8F6F9A8321C0E37AD083;
        Sat, 23 Feb 2019 17:23:07 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Sat, 23 Feb 2019 17:22:59 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [Patch net-next 05/12] net: hns3: add unlikely for error handling in data path
Date:   Sat, 23 Feb 2019 17:22:12 +0800
Message-ID: <1550913739-13232-6-git-send-email-tanhuazhong@huawei.com>
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

This patch adds unlikely hint for error handling in critical data
path.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 33ac732..50bfdba 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -619,7 +619,7 @@ static int hns3_set_tso(struct sk_buff *skb, u32 *paylen,
 		return 0;
 
 	ret = skb_cow_head(skb, 0);
-	if (ret)
+	if (unlikely(ret))
 		return ret;
 
 	l3.hdr = skb_network_header(skb);
@@ -1012,7 +1012,7 @@ static int hns3_fill_desc_vtags(struct sk_buff *skb,
 		int rc;
 
 		rc = skb_cow_head(skb, 0);
-		if (rc < 0)
+		if (unlikely(rc < 0))
 			return rc;
 		vhdr = (struct vlan_ethhdr *)skb->data;
 		vhdr->h_vlan_TCI |= cpu_to_be16((skb->priority & 0x7)
@@ -1057,7 +1057,7 @@ static int hns3_fill_desc(struct hns3_enet_ring *ring, void *priv,
 			skb_reset_mac_len(skb);
 
 			ret = hns3_get_l4_protocol(skb, &ol4_proto, &il4_proto);
-			if (ret)
+			if (unlikely(ret))
 				return ret;
 			hns3_set_l2l3l4_len(skb, ol4_proto, il4_proto,
 					    &type_cs_vlan_tso,
@@ -1065,12 +1065,12 @@ static int hns3_fill_desc(struct hns3_enet_ring *ring, void *priv,
 			ret = hns3_set_l3l4_type_csum(skb, ol4_proto, il4_proto,
 						      &type_cs_vlan_tso,
 						      &ol_type_vlan_len_msec);
-			if (ret)
+			if (unlikely(ret))
 				return ret;
 
 			ret = hns3_set_tso(skb, &paylen, &mss,
 					   &type_cs_vlan_tso);
-			if (ret)
+			if (unlikely(ret))
 				return ret;
 		}
 
@@ -1090,7 +1090,7 @@ static int hns3_fill_desc(struct hns3_enet_ring *ring, void *priv,
 		dma = skb_frag_dma_map(dev, frag, 0, size, DMA_TO_DEVICE);
 	}
 
-	if (dma_mapping_error(ring->dev, dma)) {
+	if (unlikely(dma_mapping_error(ring->dev, dma))) {
 		ring->stats.sw_err_cnt++;
 		return -ENOMEM;
 	}
@@ -1150,7 +1150,7 @@ static int hns3_nic_maybe_stop_tso(struct sk_buff **out_skb, int *bnum,
 		size = skb_frag_size(frag);
 		bdnum_for_frag = (size + HNS3_MAX_BD_SIZE - 1) >>
 				 HNS3_MAX_BD_SIZE_OFFSET;
-		if (bdnum_for_frag > HNS3_MAX_BD_PER_FRAG)
+		if (unlikely(bdnum_for_frag > HNS3_MAX_BD_PER_FRAG))
 			return -ENOMEM;
 
 		buf_num += bdnum_for_frag;
@@ -1281,7 +1281,7 @@ netdev_tx_t hns3_nic_net_xmit(struct sk_buff *skb, struct net_device *netdev)
 
 	ret = hns3_fill_desc(ring, skb, size, seg_num == 1 ? 1 : 0,
 			     DESC_TYPE_SKB);
-	if (ret)
+	if (unlikely(ret))
 		goto head_fill_err;
 
 	next_to_use_frag = ring->next_to_use;
@@ -1294,7 +1294,7 @@ netdev_tx_t hns3_nic_net_xmit(struct sk_buff *skb, struct net_device *netdev)
 				     seg_num - 1 == i ? 1 : 0,
 				     DESC_TYPE_PAGE);
 
-		if (ret)
+		if (unlikely(ret))
 			goto frag_fill_err;
 	}
 
-- 
2.7.4

