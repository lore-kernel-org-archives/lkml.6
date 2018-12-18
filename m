Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E104EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA26C217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeLRLC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:02:57 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38231 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbeLRLCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:02:09 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F2DC128B437EB;
        Tue, 18 Dec 2018 19:02:03 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Tue, 18 Dec 2018 19:01:56 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 01/12] net: hns3: fix error handling int the hns3_get_vector_ring_chain
Date:   Tue, 18 Dec 2018 19:37:48 +0800
Message-ID: <1545133079-79605-2-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545133079-79605-1-git-send-email-lipeng321@huawei.com>
References: <1545133079-79605-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

When hns3_get_vector_ring_chain() failed in the
hns3_nic_init_vector_data(), it should do the error handling instead
of return directly.

Also, cur_chain should be freed instead of chain and head->next should
be set to NULL in error handling of hns3_get_vector_ring_chain.

This patch fixes them.

Fixes: 73b907a083b8 ("net: hns3: bugfix for buffer not free problem during resetting")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 69142a3..2081e2e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2993,9 +2993,10 @@ static int hns3_get_vector_ring_chain(struct hns3_enet_tqp_vector *tqp_vector,
 	cur_chain = head->next;
 	while (cur_chain) {
 		chain = cur_chain->next;
-		devm_kfree(&pdev->dev, chain);
+		devm_kfree(&pdev->dev, cur_chain);
 		cur_chain = chain;
 	}
+	head->next = NULL;
 
 	return -ENOMEM;
 }
@@ -3086,7 +3087,7 @@ static int hns3_nic_init_vector_data(struct hns3_nic_priv *priv)
 		ret = hns3_get_vector_ring_chain(tqp_vector,
 						 &vector_ring_chain);
 		if (ret)
-			return ret;
+			goto map_ring_fail;
 
 		ret = h->ae_algo->ops->map_ring_to_vector(h,
 			tqp_vector->vector_irq, &vector_ring_chain);
-- 
1.9.1

