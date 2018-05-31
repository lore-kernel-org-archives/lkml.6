Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755303AbeEaNXn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 09:23:43 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41183 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755267AbeEaNXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 09:23:35 -0400
X-Google-Smtp-Source: ADUXVKKt9vSUdjxIUxRUjKOY+CdEuma4mxTUhmphvHUetvePeSn7vIeOca0pACBp1dnGEjJYyNLOcw==
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        filippo.muzzini@outlook.it, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 2/3] block, bfq: remove wrong check in bfq_requests_merged
Date: Thu, 31 May 2018 15:23:12 +0200
Message-Id: <20180531132313.2986-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180531132313.2986-1-paolo.valente@linaro.org>
References: <20180531132313.2986-1-paolo.valente@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The request rq passed to the function bfq_requests_merged is always in
a bfq_queue, so the check !RB_EMPTY_NODE(&rq->rb_node) at the
beginning of bfq_requests_merged always succeeds, and the control
flow systematically skips to the end of the function.  This implies
that the body of the function is never executed, i.e., the
repositioning of rq is never performed.

On the opposite end, a control is missing in the body of the function:
'next' must be removed only if it is inside a bfq_queue.

This commit removes the wrong check on rq, and adds the missing check
on 'next'. In addition, this commit adds comments on
bfq_requests_merged.

Signed-off-by: Filippo Muzzini <filippo.muzzini@outlook.it>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 1f0951d36424..df2a9633cf4a 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1891,14 +1891,27 @@ static void bfq_request_merged(struct request_queue *q, struct request *req,
 	}
 }
 
+/*
+ * This function is called to notify the scheduler that the requests
+ * rq and 'next' have been merged, with 'next' going away.  BFQ
+ * exploits this hook to address the following issue: if 'next' has a
+ * fifo_time lower that rq, then the fifo_time of rq must be set to
+ * the value of 'next', to not forget the greater age of 'next'.
+ * Moreover 'next' may be in a bfq_queue, in this case it must be
+ * removed.
+ *
+ * NOTE: in this function we assume that rq is in a bfq_queue, basing
+ * on that rq is picked from the hash table q->elevator->hash, which,
+ * in its turn, is filled only with I/O requests present in
+ * bfq_queues, while BFQ is in use for the request queue q. In fact,
+ * the function that fills this hash table (elv_rqhash_add) is called
+ * only by bfq_insert_request.
+ */
 static void bfq_requests_merged(struct request_queue *q, struct request *rq,
 				struct request *next)
 {
 	struct bfq_queue *bfqq = RQ_BFQQ(rq), *next_bfqq = RQ_BFQQ(next);
 
-	if (!RB_EMPTY_NODE(&rq->rb_node))
-		goto end;
-
 	/*
 	 * If next and rq belong to the same bfq_queue and next is older
 	 * than rq, then reposition rq in the fifo (by substituting next
@@ -1919,10 +1932,11 @@ static void bfq_requests_merged(struct request_queue *q, struct request *rq,
 	if (bfqq->next_rq == next)
 		bfqq->next_rq = rq;
 
-	bfq_remove_request(q, next);
-	bfqg_stats_update_io_remove(bfqq_group(bfqq), next->cmd_flags);
+	if (!RB_EMPTY_NODE(&next->rb_node)) {
+		bfq_remove_request(q, next);
+		bfqg_stats_update_io_remove(bfqq_group(bfqq), next->cmd_flags);
+	}
 
-end:
 	bfqg_stats_update_io_merged(bfqq_group(bfqq), next->cmd_flags);
 }
 
-- 
2.16.1
