Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+A3dvASsYXRq05q0KrbIcNfNQmZJ+M9jbGQN36tqz1sUteOLvWvjH/UzzxeGdJKVia//B/
ARC-Seal: i=1; a=rsa-sha256; t=1523981076; cv=none;
        d=google.com; s=arc-20160816;
        b=HL6PmqEkOEmn115GfsQ0d5iiH4ENdO3ADDXcK9JcmPUV9F9xftjLRQMV4YrDmPdWsQ
         M5pbTjaoP8pWiHByWVEFln9Id7R42n5QafbDq3wSo8vCo3wzPfsk7dL2sQM7U8L+Eg3i
         xHzDSLILpNRFo+ls9fNUujEIjuZzGIO48fplUrICzzspPrYGoO1QX6R+fGetbkf6NF48
         3fGf+Ipix+Zcn/gyS0bmImNQvzv1eI0SqjvqRTATCmzJ1vLjfWuccQv5bDrDw/Akr60Y
         F8Ogycnn2dJOE2CjesXpCpTDmp16tCcjPaciJkvJSbVPL84oo2bYLfmxHKfBqEBzVggA
         FZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LnHgsKMUu1QiCx7jtZ1Stoo2ww33oNuCF1yMijxQUi4=;
        b=LAWDLOCjkrSCeMVKVaJueXNRyQ57EKK9aKpvl68oRgUJds1ZpiZFLqJVBZJNWbGjwc
         V4GCZF2rO0Ev3vHDEKhRZFzIcg80v9+2zkioq1klv8EBD6852Uk9iiYnt2xu3xSJtBIW
         W8/McGTUtcV/JE5hroOoNqXtRPgHivA0mUAj0CpaVeM3JTLMO08+6pbbMNxomw3Iz6+o
         zjup2yj2uj4MABUhoMAGId/cmPJurWUQJ8fGrANZ46liZdn/CyqfHbFxcdarE0KoNYCM
         znIn21aOFc3kTZ3Ayku5D8pVzbrG/QIBW7t3+lw4vIH8VFJ8WgIjVQZOGdSFqpPCK/j1
         SfkA==
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
Subject: [PATCH 4.15 31/53] blk-mq: order getting budget and driver tag
Date: Tue, 17 Apr 2018 17:58:56 +0200
Message-Id: <20180417155724.667039673@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009784816995673?=
X-GMAIL-MSGID: =?utf-8?q?1598009980983644754?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1096,7 +1096,12 @@ bool blk_mq_dispatch_rq_list(struct requ
 		blk_status_t ret;
 
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
@@ -1105,8 +1110,7 @@ bool blk_mq_dispatch_rq_list(struct requ
 			 * we'll re-run it below.
 			 */
 			if (!blk_mq_mark_tag_wait(&hctx, rq)) {
-				if (got_budget)
-					blk_mq_put_dispatch_budget(hctx);
+				blk_mq_put_dispatch_budget(hctx);
 				/*
 				 * For non-shared tags, the RESTART check
 				 * will suffice.
@@ -1117,11 +1121,6 @@ bool blk_mq_dispatch_rq_list(struct requ
 			}
 		}
 
-		if (!got_budget && !blk_mq_get_dispatch_budget(hctx)) {
-			blk_mq_put_driver_tag(rq);
-			break;
-		}
-
 		list_del_init(&rq->queuelist);
 
 		bd.rq = rq;
@@ -1619,11 +1618,11 @@ static void __blk_mq_try_issue_directly(
 	if (q->elevator)
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
 
