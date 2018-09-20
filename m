Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE698C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B81D20880
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B81D20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbeITPrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:47:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38081 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbeITPrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:47:48 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C7150262791DC;
        Thu, 20 Sep 2018 18:05:04 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Thu, 20 Sep 2018 18:05:04 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <swise@chelsio.com>, <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] RDMA/cxgb4: remove redundant null pointer check before kfree_skb
Date:   Thu, 20 Sep 2018 17:52:42 +0800
Message-ID: <1537437162-42846-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree_skb has taken the null pointer into account. hence it is safe
to remove the redundant null pointer check before kfree_skb.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/infiniband/hw/cxgb4/cm.c | 3 +--
 drivers/infiniband/hw/cxgb4/qp.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index 0f83cbe..615413b 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -403,8 +403,7 @@ void _c4iw_free_ep(struct kref *kref)
 				 ep->com.local_addr.ss_family);
 		dst_release(ep->dst);
 		cxgb4_l2t_release(ep->l2t);
-		if (ep->mpa_skb)
-			kfree_skb(ep->mpa_skb);
+		kfree_skb(ep->mpa_skb);
 	}
 	if (!skb_queue_empty(&ep->com.ep_skb_list))
 		skb_queue_purge(&ep->com.ep_skb_list);
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index 347fe18..e78dd9a 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -2813,8 +2813,7 @@ struct ib_srq *c4iw_create_srq(struct ib_pd *pd, struct ib_srq_init_attr *attrs,
 	free_srq_queue(srq, ucontext ? &ucontext->uctx : &rhp->rdev.uctx,
 		       srq->wr_waitp);
 err_free_skb:
-	if (srq->destroy_skb)
-		kfree_skb(srq->destroy_skb);
+	kfree_skb(srq->destroy_skb);
 err_free_srq_idx:
 	c4iw_free_srq_idx(&rhp->rdev, srq->idx);
 err_free_wr_wait:
-- 
1.7.12.4

