Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5FBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A282921841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217579;
	bh=WZNhccsdAFhLGD6X0oBLfmKXqWfZDhgBiIfUu9u+yZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T5kcEwtGw+hUhr7dSrnBL8PtUklNY/lkVmYtWi4UlSL1URiEcw1tqLMNlOvgbWLch
	 59DXHYPo/ZnpZLRaFNmMgLFWZRgKaSz/9l0PX/7OYUu9yfm8sfGu3GiiKZSYIQTxRj
	 kBgEVwasqJJ7+J9gjdJEwrbpFjlfAJzosgD4PcC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391085AbfAKOji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:39:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:60454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391069AbfAKOjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:39:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3BCA206B6;
        Fri, 11 Jan 2019 14:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217576;
        bh=WZNhccsdAFhLGD6X0oBLfmKXqWfZDhgBiIfUu9u+yZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S8nR+EquIvZRNneQeF1TtHvVz1OoK0HD2k/Z5bewK/EuTNeCWH/swJEUHjJV1JsUZ
         HpmCFrSvSi4WmgKdX7Y3G5KZFtr4IY2nuPcT0JBbWa9XUo7XvlCqE3zmIYdUHR5vLI
         NrZKKtJ0sa7+psQyzFU7gipG+GW2gjQuaiXaCA7g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 113/148] block: mq-deadline: Fix write completion handling
Date:   Fri, 11 Jan 2019 15:14:51 +0100
Message-Id: <20190111131118.775407303@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <damien.lemoal@wdc.com>

commit 7211aef86f79583e59b88a0aba0bc830566f7e8e upstream.

For a zoned block device using mq-deadline, if a write request for a
zone is received while another write was already dispatched for the same
zone, dd_dispatch_request() will return NULL and the newly inserted
write request is kept in the scheduler queue waiting for the ongoing
zone write to complete. With this behavior, when no other request has
been dispatched, rq_list in blk_mq_sched_dispatch_requests() is empty
and blk_mq_sched_mark_restart_hctx() not called. This in turn leads to
__blk_mq_free_request() call of blk_mq_sched_restart() to not run the
queue when the already dispatched write request completes. The newly
dispatched request stays stuck in the scheduler queue until eventually
another request is submitted.

This problem does not affect SCSI disk as the SCSI stack handles queue
restart on request completion. However, this problem is can be triggered
the nullblk driver with zoned mode enabled.

Fix this by always requesting a queue restart in dd_dispatch_request()
if no request was dispatched while WRITE requests are queued.

Fixes: 5700f69178e9 ("mq-deadline: Introduce zone locking support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Add missing export of blk_mq_sched_restart()

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---
 block/blk-mq-sched.c |    3 ++-
 block/blk-mq-sched.h |    1 +
 block/mq-deadline.c  |   12 +++++++++++-
 3 files changed, 14 insertions(+), 2 deletions(-)

--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -54,13 +54,14 @@ void blk_mq_sched_assign_ioc(struct requ
  * Mark a hardware queue as needing a restart. For shared queues, maintain
  * a count of how many hardware queues are marked for restart.
  */
-static void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx)
+void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx)
 {
 	if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
 		return;
 
 	set_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
 }
+EXPORT_SYMBOL_GPL(blk_mq_sched_mark_restart_hctx);
 
 void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
 {
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -15,6 +15,7 @@ bool blk_mq_sched_try_merge(struct reque
 				struct request **merged_request);
 bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio);
 bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq);
+void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx);
 void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_sched_insert_request(struct request *rq, bool at_head,
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -373,9 +373,16 @@ done:
 
 /*
  * One confusing aspect here is that we get called for a specific
- * hardware queue, but we return a request that may not be for a
+ * hardware queue, but we may return a request that is for a
  * different hardware queue. This is because mq-deadline has shared
  * state for all hardware queues, in terms of sorting, FIFOs, etc.
+ *
+ * For a zoned block device, __dd_dispatch_request() may return NULL
+ * if all the queued write requests are directed at zones that are already
+ * locked due to on-going write requests. In this case, make sure to mark
+ * the queue as needing a restart to ensure that the queue is run again
+ * and the pending writes dispatched once the target zones for the ongoing
+ * write requests are unlocked in dd_finish_request().
  */
 static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 {
@@ -384,6 +391,9 @@ static struct request *dd_dispatch_reque
 
 	spin_lock(&dd->lock);
 	rq = __dd_dispatch_request(dd);
+	if (!rq && blk_queue_is_zoned(hctx->queue) &&
+	    !list_empty(&dd->fifo_list[WRITE]))
+		blk_mq_sched_mark_restart_hctx(hctx);
 	spin_unlock(&dd->lock);
 
 	return rq;


