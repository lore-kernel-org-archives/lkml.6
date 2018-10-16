Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1013C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D6720869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D6720869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbeJPTq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:46:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48107 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727003AbeJPTq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:46:58 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 96E2E2D34DC7C;
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
Subject: [PATCH net-next 1/5] net: hns3: remove hns3_fill_desc_tso
Date:   Tue, 16 Oct 2018 19:58:48 +0800
Message-ID: <1539691132-158455-2-git-send-email-linyunsheng@huawei.com>
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

This patch removes hns3_fill_desc_tso in preparation for
fixing some desc filling bug, because for tso or non-tso
case, we will use the unified hns3_fill_desc.

Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 44 +++----------------------
 1 file changed, 5 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index ce93fcc..953568a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1054,35 +1054,6 @@ static int hns3_fill_desc(struct hns3_enet_ring *ring, void *priv,
 	return 0;
 }
 
-static int hns3_fill_desc_tso(struct hns3_enet_ring *ring, void *priv,
-			      int size, dma_addr_t dma, int frag_end,
-			      enum hns_desc_type type)
-{
-	unsigned int frag_buf_num;
-	unsigned int k;
-	int sizeoflast;
-	int ret;
-
-	frag_buf_num = (size + HNS3_MAX_BD_SIZE - 1) / HNS3_MAX_BD_SIZE;
-	sizeoflast = size % HNS3_MAX_BD_SIZE;
-	sizeoflast = sizeoflast ? sizeoflast : HNS3_MAX_BD_SIZE;
-
-	/* When the frag size is bigger than hardware, split this frag */
-	for (k = 0; k < frag_buf_num; k++) {
-		ret = hns3_fill_desc(ring, priv,
-				     (k == frag_buf_num - 1) ?
-				sizeoflast : HNS3_MAX_BD_SIZE,
-				dma + HNS3_MAX_BD_SIZE * k,
-				frag_end && (k == frag_buf_num - 1) ? 1 : 0,
-				(type == DESC_TYPE_SKB && !k) ?
-					DESC_TYPE_SKB : DESC_TYPE_PAGE);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 static int hns3_nic_maybe_stop_tso(struct sk_buff **out_skb, int *bnum,
 				   struct hns3_enet_ring *ring)
 {
@@ -1313,13 +1284,10 @@ static int hns3_nic_set_features(struct net_device *netdev,
 	int ret;
 
 	if (changed & (NETIF_F_TSO | NETIF_F_TSO6)) {
-		if (features & (NETIF_F_TSO | NETIF_F_TSO6)) {
-			priv->ops.fill_desc = hns3_fill_desc_tso;
+		if (features & (NETIF_F_TSO | NETIF_F_TSO6))
 			priv->ops.maybe_stop_tx = hns3_nic_maybe_stop_tso;
-		} else {
-			priv->ops.fill_desc = hns3_fill_desc;
+		else
 			priv->ops.maybe_stop_tx = hns3_nic_maybe_stop_tx;
-		}
 	}
 
 	if ((changed & NETIF_F_HW_VLAN_CTAG_FILTER) &&
@@ -3247,14 +3215,12 @@ static void hns3_nic_set_priv_ops(struct net_device *netdev)
 {
 	struct hns3_nic_priv *priv = netdev_priv(netdev);
 
+	priv->ops.fill_desc = hns3_fill_desc;
 	if ((netdev->features & NETIF_F_TSO) ||
-	    (netdev->features & NETIF_F_TSO6)) {
-		priv->ops.fill_desc = hns3_fill_desc_tso;
+	    (netdev->features & NETIF_F_TSO6))
 		priv->ops.maybe_stop_tx = hns3_nic_maybe_stop_tso;
-	} else {
-		priv->ops.fill_desc = hns3_fill_desc;
+	else
 		priv->ops.maybe_stop_tx = hns3_nic_maybe_stop_tx;
-	}
 }
 
 static int hns3_client_init(struct hnae3_handle *handle)
-- 
1.9.1

