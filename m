Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7511BC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6BE2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6BE2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeJPTq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:46:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48116 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726781AbeJPTq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:46:58 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A4F3674E3C83A;
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
Subject: [PATCH net-next 4/5] net: hns3: rename hns_nic_dma_unmap
Date:   Tue, 16 Oct 2018 19:58:51 +0800
Message-ID: <1539691132-158455-5-git-send-email-linyunsheng@huawei.com>
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

To keep symmetrical, this patch renames hns_nic_dma_unmap to
hns3_clear_desc.

Signed-off-by: Fuyun Liang <liangfuyun1@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 3fb8e48..74e592d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1134,7 +1134,7 @@ static int hns3_nic_maybe_stop_tx(struct sk_buff **out_skb, int *bnum,
 	return 0;
 }
 
-static void hns_nic_dma_unmap(struct hns3_enet_ring *ring, int next_to_use_orig)
+static void hns3_clear_desc(struct hns3_enet_ring *ring, int next_to_use_orig)
 {
 	struct device *dev = ring_to_dev(ring);
 	unsigned int i;
@@ -1208,7 +1208,7 @@ netdev_tx_t hns3_nic_net_xmit(struct sk_buff *skb, struct net_device *netdev)
 	ret = priv->ops.fill_desc(ring, skb, size, seg_num == 1 ? 1 : 0,
 				  DESC_TYPE_SKB);
 	if (ret)
-		goto head_dma_map_err;
+		goto head_fill_err;
 
 	next_to_use_frag = ring->next_to_use;
 	/* Fill the fragments */
@@ -1221,7 +1221,7 @@ netdev_tx_t hns3_nic_net_xmit(struct sk_buff *skb, struct net_device *netdev)
 					  DESC_TYPE_PAGE);
 
 		if (ret)
-			goto frag_dma_map_err;
+			goto frag_fill_err;
 	}
 
 	/* Complete translate all packets */
@@ -1234,11 +1234,11 @@ netdev_tx_t hns3_nic_net_xmit(struct sk_buff *skb, struct net_device *netdev)
 
 	return NETDEV_TX_OK;
 
-frag_dma_map_err:
-	hns_nic_dma_unmap(ring, next_to_use_frag);
+frag_fill_err:
+	hns3_clear_desc(ring, next_to_use_frag);
 
-head_dma_map_err:
-	hns_nic_dma_unmap(ring, next_to_use_head);
+head_fill_err:
+	hns3_clear_desc(ring, next_to_use_head);
 
 out_err_tx_ok:
 	dev_kfree_skb_any(skb);
-- 
1.9.1

