Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2265C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A545120850
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfBWJXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 04:23:23 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4269 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbfBWJXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 04:23:12 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 862EAE3AC2C53D7F5430;
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
Subject: [Patch net-next 04/12] net: hns3: remove some ops in struct hns3_nic_ops
Date:   Sat, 23 Feb 2019 17:22:11 +0800
Message-ID: <1550913739-13232-5-git-send-email-tanhuazhong@huawei.com>
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

The fill_desc ops has only one implementation, and
get_rxd_bnum has not been used, so this patch removes
them.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 11 +++++------
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h |  3 ---
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index a84060fd..33ac732 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1279,8 +1279,8 @@ netdev_tx_t hns3_nic_net_xmit(struct sk_buff *skb, struct net_device *netdev)
 
 	next_to_use_head = ring->next_to_use;
 
-	ret = priv->ops.fill_desc(ring, skb, size, seg_num == 1 ? 1 : 0,
-				  DESC_TYPE_SKB);
+	ret = hns3_fill_desc(ring, skb, size, seg_num == 1 ? 1 : 0,
+			     DESC_TYPE_SKB);
 	if (ret)
 		goto head_fill_err;
 
@@ -1290,9 +1290,9 @@ netdev_tx_t hns3_nic_net_xmit(struct sk_buff *skb, struct net_device *netdev)
 		frag = &skb_shinfo(skb)->frags[i - 1];
 		size = skb_frag_size(frag);
 
-		ret = priv->ops.fill_desc(ring, frag, size,
-					  seg_num - 1 == i ? 1 : 0,
-					  DESC_TYPE_PAGE);
+		ret = hns3_fill_desc(ring, frag, size,
+				     seg_num - 1 == i ? 1 : 0,
+				     DESC_TYPE_PAGE);
 
 		if (ret)
 			goto frag_fill_err;
@@ -3579,7 +3579,6 @@ static void hns3_nic_set_priv_ops(struct net_device *netdev)
 {
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 
-	priv->ops.fill_desc = hns3_fill_desc;
 	if ((netdev->features & NETIF_F_TSO) ||
 	    (netdev->features & NETIF_F_TSO6))
 		priv->ops.maybe_stop_tx = hns3_nic_maybe_stop_tso;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index 5c41465..3a1e487 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -444,11 +444,8 @@ struct hns3_nic_ring_data {
 };
 
 struct hns3_nic_ops {
-	int (*fill_desc)(struct hns3_enet_ring *ring, void *priv,
-			 int size, int frag_end, enum hns_desc_type type);
 	int (*maybe_stop_tx)(struct sk_buff **out_skb,
 			     int *bnum, struct hns3_enet_ring *ring);
-	void (*get_rxd_bnum)(u32 bnum_flag, int *out_bnum);
 };
 
 enum hns3_flow_level_range {
-- 
2.7.4

