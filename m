Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeBBHAw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 02:00:52 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46328 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeBBHAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 02:00:47 -0500
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] blk-mq: make blk_mq_rq_update_aborted_gstate a external interface
Date: Fri,  2 Feb 2018 14:54:49 +0800
Message-Id: <1517554492-7680-4-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517554492-7680-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1517554492-7680-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8792 signatures=668660
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=774
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020079
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change, just make blk_mq_rq_update_aborted_gstate a
external interface.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c         | 3 ++-
 include/linux/blk-mq.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 01f271d..a027ca2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -581,7 +581,7 @@ static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
 		*srcu_idx = srcu_read_lock(hctx->srcu);
 }
 
-static void blk_mq_rq_update_aborted_gstate(struct request *rq, u64 gstate)
+void blk_mq_rq_update_aborted_gstate(struct request *rq, u64 gstate)
 {
 	unsigned long flags;
 
@@ -597,6 +597,7 @@ static void blk_mq_rq_update_aborted_gstate(struct request *rq, u64 gstate)
 	u64_stats_update_end(&rq->aborted_gstate_sync);
 	local_irq_restore(flags);
 }
+EXPORT_SYMBOL(blk_mq_rq_update_aborted_gstate);
 
 static u64 blk_mq_rq_aborted_gstate(struct request *rq)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8efcf49..ad54024 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -257,6 +257,7 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 void blk_mq_complete_request(struct request *rq);
+void blk_mq_rq_update_aborted_gstate(struct request *rq, u64 gstate);
 
 bool blk_mq_queue_stopped(struct request_queue *q);
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx);
-- 
2.7.4
