Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755319AbeEaNYE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 09:24:04 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36532 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755234AbeEaNXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 09:23:38 -0400
X-Google-Smtp-Source: ADUXVKJM6pOM2iUJpxXhChnM3VtO9YaMluuZW6FMvUhBp+zKosAHGoblFltZauy0jfPZeIuk5iLrcQ==
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, broonie@kernel.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        filippo.muzzini@outlook.it, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 3/3] block, bfq: remove the removal of 'next' rq in bfq_requests_merged
Date: Thu, 31 May 2018 15:23:13 +0200
Message-Id: <20180531132313.2986-4-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180531132313.2986-1-paolo.valente@linaro.org>
References: <20180531132313.2986-1-paolo.valente@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filippo Muzzini <filippo.muzzini@outlook.it>

Since bfq_finish_request() is always called on the request 'next',
after bfq_requests_merged() is finished, and bfq_finish_request()
removes 'next' from its bfq_queue if needed, it isn't necessary to do
such a removal in advance in bfq_merged_requests().

This commit removes such a useless 'next' removal.

Signed-off-by: Filippo Muzzini <filippo.muzzini@outlook.it>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index df2a9633cf4a..f71a5846b629 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1897,8 +1897,6 @@ static void bfq_request_merged(struct request_queue *q, struct request *req,
  * exploits this hook to address the following issue: if 'next' has a
  * fifo_time lower that rq, then the fifo_time of rq must be set to
  * the value of 'next', to not forget the greater age of 'next'.
- * Moreover 'next' may be in a bfq_queue, in this case it must be
- * removed.
  *
  * NOTE: in this function we assume that rq is in a bfq_queue, basing
  * on that rq is picked from the hash table q->elevator->hash, which,
@@ -1932,11 +1930,6 @@ static void bfq_requests_merged(struct request_queue *q, struct request *rq,
 	if (bfqq->next_rq == next)
 		bfqq->next_rq = rq;
 
-	if (!RB_EMPTY_NODE(&next->rb_node)) {
-		bfq_remove_request(q, next);
-		bfqg_stats_update_io_remove(bfqq_group(bfqq), next->cmd_flags);
-	}
-
 	bfqg_stats_update_io_merged(bfqq_group(bfqq), next->cmd_flags);
 }
 
-- 
2.16.1
