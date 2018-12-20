Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EB4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 03:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0F721741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 03:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbeLTDQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 22:16:48 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16612 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729880AbeLTDQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 22:16:32 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 31B0E4505C0D2;
        Thu, 20 Dec 2018 11:16:28 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Thu, 20 Dec 2018 11:16:16 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 8/9] net: hns3: fix the descriptor index when get rss type
Date:   Thu, 20 Dec 2018 11:52:05 +0800
Message-ID: <1545277926-66432-9-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545277926-66432-1-git-send-email-lipeng321@huawei.com>
References: <1545277926-66432-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver gets rss information from the last descriptor of the packet.
When driver handle the rss type, ring->next_to_clean indicates the
first descriptor of next packet.

This patch fix the descriptor index with "ring->next_to_clean - 1".

Fixes: 232fc64b6e62 ("net: hns3: Add HW RSS hash information to RX skb")
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 624b8a7..d3b9aaf 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2550,9 +2550,16 @@ static void hns3_set_gro_param(struct sk_buff *skb, u32 l234info,
 static void hns3_set_rx_skb_rss_type(struct hns3_enet_ring *ring,
 				     struct sk_buff *skb)
 {
-	struct hns3_desc *desc = &ring->desc[ring->next_to_clean];
 	struct hnae3_handle *handle = ring->tqp->handle;
 	enum pkt_hash_types rss_type;
+	struct hns3_desc *desc;
+	int last_bd;
+
+	/* When driver handle the rss type, ring->next_to_clean indicates the
+	 * first descriptor of next packet, need -1 here.
+	 */
+	last_bd = (ring->next_to_clean - 1 + ring->desc_num) % ring->desc_num;
+	desc = &ring->desc[last_bd];
 
 	if (le32_to_cpu(desc->rx.rss_hash))
 		rss_type = handle->kinfo.rss_type;
-- 
1.9.1

