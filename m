Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6218C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77689206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfBWJXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 04:23:24 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4274 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727719AbfBWJXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 04:23:12 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A8FB2C02E4FBC9D63391;
        Sat, 23 Feb 2019 17:23:07 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Sat, 23 Feb 2019 17:23:00 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [Patch net-next 07/12] net: hns3: remove hnae3_get_bit in data path
Date:   Sat, 23 Feb 2019 17:22:14 +0800
Message-ID: <1550913739-13232-8-git-send-email-tanhuazhong@huawei.com>
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

The hnae3_get_bit uses hnae3_get_field, and hnae3_get_field
masks the data, which is unnecessary in data path.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 33 +++++++++++--------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index ce9878b..236b340 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2318,13 +2318,12 @@ static void hns3_rx_checksum(struct hns3_enet_ring *ring, struct sk_buff *skb,
 	}
 
 	/* check if hardware has done checksum */
-	if (!hnae3_get_bit(bd_base_info, HNS3_RXD_L3L4P_B))
+	if (!(bd_base_info & BIT(HNS3_RXD_L3L4P_B)))
 		return;
 
-	if (unlikely(hnae3_get_bit(l234info, HNS3_RXD_L3E_B) ||
-		     hnae3_get_bit(l234info, HNS3_RXD_L4E_B) ||
-		     hnae3_get_bit(l234info, HNS3_RXD_OL3E_B) ||
-		     hnae3_get_bit(l234info, HNS3_RXD_OL4E_B))) {
+	if (unlikely(l234info & (BIT(HNS3_RXD_L3E_B) | BIT(HNS3_RXD_L4E_B) ||
+				 BIT(HNS3_RXD_OL3E_B) ||
+				 BIT(HNS3_RXD_OL4E_B)))) {
 		u64_stats_update_begin(&ring->syncp);
 		ring->stats.l3l4_csum_err++;
 		u64_stats_update_end(&ring->syncp);
@@ -2469,11 +2468,11 @@ static int hns3_add_frag(struct hns3_enet_ring *ring, struct hns3_desc *desc,
 		bd_base_info = le32_to_cpu(desc->rx.bd_base_info);
 	}
 
-	while (!hnae3_get_bit(bd_base_info, HNS3_RXD_FE_B)) {
+	while (!(bd_base_info & BIT(HNS3_RXD_FE_B))) {
 		desc = &ring->desc[ring->next_to_clean];
 		desc_cb = &ring->desc_cb[ring->next_to_clean];
 		bd_base_info = le32_to_cpu(desc->rx.bd_base_info);
-		if (!hnae3_get_bit(bd_base_info, HNS3_RXD_VLD_B))
+		if (!(bd_base_info & BIT(HNS3_RXD_VLD_B)))
 			return -ENXIO;
 
 		if (unlikely(ring->frag_num >= MAX_SKB_FRAGS)) {
@@ -2587,7 +2586,7 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 	bd_base_info = le32_to_cpu(desc->rx.bd_base_info);
 
 	/* Check valid BD */
-	if (unlikely(!hnae3_get_bit(bd_base_info, HNS3_RXD_VLD_B)))
+	if (unlikely(!(bd_base_info & BIT(HNS3_RXD_VLD_B))))
 		return -ENXIO;
 
 	if (!skb)
@@ -2650,7 +2649,7 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 					       vlan_tag);
 	}
 
-	if (unlikely(!hnae3_get_bit(bd_base_info, HNS3_RXD_VLD_B))) {
+	if (unlikely(!(bd_base_info & BIT(HNS3_RXD_VLD_B)))) {
 		u64_stats_update_begin(&ring->syncp);
 		ring->stats.non_vld_descs++;
 		u64_stats_update_end(&ring->syncp);
@@ -2660,23 +2659,19 @@ static int hns3_handle_rx_bd(struct hns3_enet_ring *ring,
 	}
 
 	if (unlikely((!desc->rx.pkt_len) ||
-		     hnae3_get_bit(l234info, HNS3_RXD_TRUNCAT_B))) {
+		     (l234info & (BIT(HNS3_RXD_TRUNCAT_B) |
+				  BIT(HNS3_RXD_L2E_B))))) {
 		u64_stats_update_begin(&ring->syncp);
-		ring->stats.err_pkt_len++;
+		if (l234info & BIT(HNS3_RXD_L2E_B))
+			ring->stats.l2_err++;
+		else
+			ring->stats.err_pkt_len++;
 		u64_stats_update_end(&ring->syncp);
 
 		dev_kfree_skb_any(skb);
 		return -EFAULT;
 	}
 
-	if (unlikely(hnae3_get_bit(l234info, HNS3_RXD_L2E_B))) {
-		u64_stats_update_begin(&ring->syncp);
-		ring->stats.l2_err++;
-		u64_stats_update_end(&ring->syncp);
-
-		dev_kfree_skb_any(skb);
-		return -EFAULT;
-	}
 
 	l2_frame_type = hnae3_get_field(l234info, HNS3_RXD_DMAC_M,
 					HNS3_RXD_DMAC_S);
-- 
2.7.4

