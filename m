Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+SiIUsMZ0sKkj25m+Lp01Q8rWt7yO0dqyYj4ELYAJfqzQ8HFmMhTv2hlKz+c1tuNvnIMqY
ARC-Seal: i=1; a=rsa-sha256; t=1523980889; cv=none;
        d=google.com; s=arc-20160816;
        b=XldZ1oKsIuld5jNFundqo4zGaIDf4UbiMyGSQz1MIgVMuhkT9JtC/ubxyr/GFwNmk2
         EWHWNEYZq0WlpF9G9XloX9686nDQpXSDCgEq80lNF0cK+z5Fz0JkNrFv5tPf/s+EmvYF
         jpxgbAvkYl+9pZtcd4TSwOMn0ilemgx7BbAx++b78U1TKAYyhILIP2g6wViM1eD78YHv
         gVYPxkXTfPPMzOJ9rOxKOrQsElfpYGNmWVwcGOVp5nUNVF94Beax1WBGu25esPNpac4G
         BPjfxsZXNuBAKtwX10MTQVXgnyyDls4xOpiuKm8On6WWZ3WgALduocElYsGWjySfHrk7
         N+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uEE5SrSo9W2yAsFiT+qNw/r4Iv5UKKcylOUSga4ejhw=;
        b=xlWmzp+xc3PoEzkzgET3BlJpZNeAkzXEKnOFEn6qrQmktGTX7cBKV0/1GHYP2mnZlJ
         DjBk5iZnRw150l2o4LW9s+qnWRKv9OPzYolkgP7Y/2gJO0Qc9hPnrVci6X6zfx1sIQA+
         d1E5Feo66Pza3tXvkXzK/6vazN3S3F++SYMa23I3urCPZiXvabGvKaTELrjNRa71fDOj
         uQhEvZajb/UFqRZUXtli6S1gOsnLzvvuS4RdnQREI48/su7SmYe+gc6m+hmaiCrGecZF
         boGGCNNO6p54Mk1TpjEvtp/cOZmBYS+s2+5OJZBkWrtIZLGeGFGAKiikoeqaWZEpQpHA
         04lA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Omar Sandoval <osandov@fb.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.16 41/68] blk-mq: order getting budget and driver tag
Date: Tue, 17 Apr 2018 17:57:54 +0200
Message-Id: <20180417155750.999593927@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009784816995673?=
X-GMAIL-MSGID: =?utf-8?q?1598009784816995673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

commit 0bca799b92807ee9be0890690f5dde7d8c6a8e25 upstream.

This patch orders getting budget and driver tag by making sure to acquire
driver tag after budget is got, this way can help to avoid the following
race:

1) before dispatch request from scheduler queue, get one budget first, then
dequeue a request, call it request A.

2) in another IO path for dispatching request B which is from hctx->dispatch,
driver tag is got, then try to get budget in blk_mq_dispatch_rq_list(),
unfortunately the budget is held by request A.

3) meantime blk_mq_dispatch_rq_list() is called for dispatching request
A, and try to get driver tag first, unfortunately no driver tag is
available because the driver tag is held by request B

4) both two IO pathes can't move on, and IO stall is caused.

This issue can be observed when running dbench on USB storage.

This patch fixes this issue by always getting budget before getting
driver tag.

Cc: stable@vger.kernel.org
Fixes: de1482974080ec9e ("blk-mq: introduce .get_budget and .put_budget in blk_mq_ops")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Omar Sandoval <osandov@fb.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-mq.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1188,7 +1188,12 @@ bool blk_mq_dispatch_rq_list(struct requ
 		struct blk_mq_queue_data bd;
 
 		rq = list_first_entry(list, struct request, queuelist);
-		if (!blk_mq_get_driver_tag(rq, &hctx, false)) {
+
+		hctx = blk_mq_map_queue(rq->q, rq->mq_ctx->cpu);
+		if (!got_budget && !blk_mq_get_dispatch_budget(hctx))
+			break;
+
+		if (!blk_mq_get_driver_tag(rq, NULL, false)) {
 			/*
 			 * The initial allocation attempt failed, so we need to
 			 * rerun the hardware queue when a tag is freed. The
@@ -1197,8 +1202,7 @@ bool blk_mq_dispatch_rq_list(struct requ
 			 * we'll re-run it below.
 			 */
 			if (!blk_mq_mark_tag_wait(&hctx, rq)) {
-				if (got_budget)
-					blk_mq_put_dispatch_budget(hctx);
+				blk_mq_put_dispatch_budget(hctx);
 				/*
 				 * For non-shared tags, the RESTART check
 				 * will suffice.
@@ -1209,11 +1213,6 @@ bool blk_mq_dispatch_rq_list(struct requ
 			}
 		}
 
-		if (!got_budget && !blk_mq_get_dispatch_budget(hctx)) {
-			blk_mq_put_driver_tag(rq);
-			break;
-		}
-
 		list_del_init(&rq->queuelist);
 
 		bd.rq = rq;
@@ -1812,11 +1811,11 @@ static blk_status_t __blk_mq_try_issue_d
 	if (q->elevator && !bypass_insert)
 		goto insert;
 
-	if (!blk_mq_get_driver_tag(rq, NULL, false))
+	if (!blk_mq_get_dispatch_budget(hctx))
 		goto insert;
 
-	if (!blk_mq_get_dispatch_budget(hctx)) {
-		blk_mq_put_driver_tag(rq);
+	if (!blk_mq_get_driver_tag(rq, NULL, false)) {
+		blk_mq_put_dispatch_budget(hctx);
 		goto insert;
 	}
 
