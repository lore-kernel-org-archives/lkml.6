Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs17JRK/OSz5BljcsQRPkah8nU+3NzkViq+8MYoCOgiY7oLOLIZgH4HE9k2Jat6vwvbVC7Y
ARC-Seal: i=1; a=rsa-sha256; t=1520451797; cv=none;
        d=google.com; s=arc-20160816;
        b=bAoL5ywy6/ykH71wWdXvVEQWBKYbZgc8RPePB8wtBMWrqoQzEu86RoClkupHEv7DH7
         9Ym8CVt1U0x0gjHLt2FlqcjbdnNQu7OR3IESTZOCWSLzMwpcSNrZqWAhw/UiHKRlJw+I
         Yw5ozRfCZIaFSrPNHXHJHoOyi96482snwrIYDtg1Ma5t8Z4/MLld2900xi3KYpcnnE+1
         DzaOd3fCaOd8NTZOqzzJtjwtaxz0T/js6MitLmChJdqwe4RGoZc3JK2oOGxnTXIyR8AX
         Z5pGKl+6KU893Ie0v7+P0G2pj/n1igDkebxFsrnlx444nF/tpTWXw1sEHynaNtZU6OnK
         htPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cCqrOvfJOAco7hHj7Kn48Vcfhvt/iryKBxxupCjRWD4=;
        b=h0HVD1K2pzW1uKmuUeHmkrkb9At1Z77nWLfP2g5ynxMeRzhpuvaUUX5Kz5pPY5lvcN
         qoNTrA0d5/MIVnd0RRPosc2blT+W1K6PAPtQJkYwuSmWxTUFAoV79Gb380L0U1QTx63W
         M3cIaZLrr8dyKBVIZAVLm6WkdaeMy1jy0X00BJMuQsoCMYiTDrNCQQujK9eeACwurp2L
         XtTOwv06K5VEtJz8E+8mrB8BygUT02s3QiSxy6zsY+wJDENoxptnGjxlNZlwDtXzRdJg
         1n32f3rdUFQ57PjAdLHBWCSWaXzWNbYsHtMoRJZFGqGDvLuDINalEjPK7rwDDnoTN4D6
         F3Vw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paolo Valente <paolo.valente@linaro.org>,
	Omar Sandoval <osandov@fb.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.15 098/122] blk-mq: dont call io scheds .requeue_request when requeueing rq to ->dispatch
Date: Wed,  7 Mar 2018 11:38:30 -0800
Message-Id: <20180307191743.516746398@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309264299868557?=
X-GMAIL-MSGID: =?utf-8?q?1594309264299868557?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

commit 105976f517791aed3b11f8f53b308a2069d42055 upstream.

__blk_mq_requeue_request() covers two cases:

- one is that the requeued request is added to hctx->dispatch, such as
blk_mq_dispatch_rq_list()

- another case is that the request is requeued to io scheduler, such as
blk_mq_requeue_request().

We should call io sched's .requeue_request callback only for the 2nd
case.

Cc: Paolo Valente <paolo.valente@linaro.org>
Cc: Omar Sandoval <osandov@fb.com>
Fixes: bd166ef183c2 ("blk-mq-sched: add framework for MQ capable IO schedulers")
Cc: stable@vger.kernel.org
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Acked-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-mq.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -655,7 +655,6 @@ static void __blk_mq_requeue_request(str
 
 	trace_block_rq_requeue(q, rq);
 	wbt_requeue(q->rq_wb, &rq->issue_stat);
-	blk_mq_sched_requeue_request(rq);
 
 	if (test_and_clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags)) {
 		if (q->dma_drain_size && blk_rq_bytes(rq))
@@ -667,6 +666,9 @@ void blk_mq_requeue_request(struct reque
 {
 	__blk_mq_requeue_request(rq);
 
+	/* this request will be re-inserted to io scheduler queue */
+	blk_mq_sched_requeue_request(rq);
+
 	BUG_ON(blk_queued_rq(rq));
 	blk_mq_add_to_requeue_list(rq, true, kick_requeue_list);
 }
