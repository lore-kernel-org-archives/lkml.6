Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331FCC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F7F2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F7F2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeIZPR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:17:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12707 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727174AbeIZPR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:17:26 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 669AD68A081EB;
        Wed, 26 Sep 2018 17:05:27 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Wed, 26 Sep 2018 17:05:27 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>
CC:     <Ariel.Elior@cavium.com>, <everest-linux-l2@cavium.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: qed: list usage cleanup
Date:   Wed, 26 Sep 2018 16:53:00 +0800
Message-ID: <1537951981-6464-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trival cleanup, list_move_tail will implement the same function that
list_del() + list_add_tail() will do. hence just replace them.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c |  9 ++++-----
 drivers/net/ethernet/qlogic/qed/qed_ooo.c   | 10 ++++------
 drivers/net/ethernet/qlogic/qed/qed_spq.c   |  3 +--
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
index 17f3dfa..f99797a 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
@@ -935,9 +935,8 @@ int qed_iwarp_destroy_qp(struct qed_hwfn *p_hwfn, struct qed_rdma_qp *qp)
 	}
 	spin_lock_bh(&p_hwfn->p_rdma_info->iwarp.iw_lock);
 
-	list_del(&ep->list_entry);
-	list_add_tail(&ep->list_entry,
-		      &p_hwfn->p_rdma_info->iwarp.ep_free_list);
+	list_move_tail(&ep->list_entry,
+		       &p_hwfn->p_rdma_info->iwarp.ep_free_list);
 
 	spin_unlock_bh(&p_hwfn->p_rdma_info->iwarp.iw_lock);
 }
@@ -2270,8 +2269,8 @@ static void qed_iwarp_process_pending_pkts(struct qed_hwfn *p_hwfn)
 		if (rc == -EBUSY)
 			break;
 
-		list_del(&mpa_buf->list_entry);
-		list_add_tail(&mpa_buf->list_entry, &iwarp_info->mpa_buf_list);
+		list_move_tail(&mpa_buf->list_entry,
+			       &iwarp_info->mpa_buf_list);
 
 		if (rc) {	/* different error, don't continue */
 			DP_NOTICE(p_hwfn, "process pkts failed rc=%d\n", rc);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_ooo.c b/drivers/net/ethernet/qlogic/qed/qed_ooo.c
index 6172354..63931df 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ooo.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ooo.c
@@ -211,9 +211,8 @@ void qed_ooo_release_connection_isles(struct qed_hwfn *p_hwfn,
 			if (!p_buffer)
 				break;
 
-			list_del(&p_buffer->list_entry);
-			list_add_tail(&p_buffer->list_entry,
-				      &p_ooo_info->free_buffers_list);
+			list_move_tail(&p_buffer->list_entry,
+				       &p_ooo_info->free_buffers_list);
 		}
 		list_add_tail(&p_isle->list_entry,
 			      &p_ooo_info->free_isles_list);
@@ -247,9 +246,8 @@ void qed_ooo_release_all_isles(struct qed_hwfn *p_hwfn,
 				if (!p_buffer)
 					break;
 
-			list_del(&p_buffer->list_entry);
-				list_add_tail(&p_buffer->list_entry,
-					      &p_ooo_info->free_buffers_list);
+				list_move_tail(&p_buffer->list_entry,
+					       &p_ooo_info->free_buffers_list);
 			}
 			list_add_tail(&p_isle->list_entry,
 				      &p_ooo_info->free_isles_list);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_spq.c b/drivers/net/ethernet/qlogic/qed/qed_spq.c
index 1673fc9..c4a6274 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_spq.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_spq.c
@@ -730,8 +730,7 @@ static int qed_spq_post_list(struct qed_hwfn *p_hwfn,
 	       !list_empty(head)) {
 		struct qed_spq_entry *p_ent =
 			list_first_entry(head, struct qed_spq_entry, list);
-		list_del(&p_ent->list);
-		list_add_tail(&p_ent->list, &p_spq->completion_pending);
+		list_move_tail(&p_ent->list, &p_spq->completion_pending);
 		p_spq->comp_sent_count++;
 
 		rc = qed_spq_hw_post(p_hwfn, p_spq, p_ent);
-- 
1.7.12.4

