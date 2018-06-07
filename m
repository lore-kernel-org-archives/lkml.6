Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HvwkJoJAGVulYgAAmS7hNA
	; Thu, 07 Jun 2018 14:26:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id ABBCA608CE; Thu,  7 Jun 2018 14:26:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 927E7608FB;
	Thu,  7 Jun 2018 14:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 927E7608FB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933591AbeFGO0F (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:26:05 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40156 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933420AbeFGO0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:26:02 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbG-0005Zv-5x; Thu, 07 Jun 2018 15:09:14 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0003FL-Q1; Thu, 07 Jun 2018 15:09:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jens Axboe" <axboe@fb.com>,
        "Jeff Moyer" <jmoyer@redhat.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.80529077@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 356/410] aio: fix serial draining in exit_aio()
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@fb.com>

commit dc48e56d761610da4ea1088d1bea0a030b8e3e43 upstream.

exit_aio() currently serializes killing io contexts. Each context
killing ends up having to do percpu_ref_kill(), which in turns has
to wait for an RCU grace period. This can take a long time, depending
on the number of contexts. And there's no point in doing them serially,
when we could be waiting for all of them in one fell swoop.

This patches makes my fio thread offload test case exit 0.2s instead
of almost 6s.

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/aio.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

--- a/fs/aio.c
+++ b/fs/aio.c
@@ -77,6 +77,11 @@ struct kioctx_cpu {
 	unsigned		reqs_available;
 };
 
+struct ctx_rq_wait {
+	struct completion comp;
+	atomic_t count;
+};
+
 struct kioctx {
 	struct percpu_ref	users;
 	atomic_t		dead;
@@ -115,7 +120,7 @@ struct kioctx {
 	/*
 	 * signals when all in-flight requests are done
 	 */
-	struct completion *requests_done;
+	struct ctx_rq_wait	*rq_wait;
 
 	struct {
 		/*
@@ -523,8 +528,8 @@ static void free_ioctx_reqs(struct percp
 	struct kioctx *ctx = container_of(ref, struct kioctx, reqs);
 
 	/* At this point we know that there are no any in-flight requests */
-	if (ctx->requests_done)
-		complete(ctx->requests_done);
+	if (ctx->rq_wait && atomic_dec_and_test(&ctx->rq_wait->count))
+		complete(&ctx->rq_wait->comp);
 
 	INIT_WORK(&ctx->free_work, free_ioctx);
 	schedule_work(&ctx->free_work);
@@ -735,7 +740,7 @@ err:
  *	the rapid destruction of the kioctx.
  */
 static int kill_ioctx(struct mm_struct *mm, struct kioctx *ctx,
-		struct completion *requests_done)
+		      struct ctx_rq_wait *wait)
 {
 	struct kioctx_table *table;
 
@@ -764,7 +769,7 @@ static int kill_ioctx(struct mm_struct *
 	if (ctx->mmap_size)
 		vm_munmap(ctx->mmap_base, ctx->mmap_size);
 
-	ctx->requests_done = requests_done;
+	ctx->rq_wait = wait;
 	percpu_ref_kill(&ctx->users);
 	return 0;
 }
@@ -796,18 +801,24 @@ EXPORT_SYMBOL(wait_on_sync_kiocb);
 void exit_aio(struct mm_struct *mm)
 {
 	struct kioctx_table *table = rcu_dereference_raw(mm->ioctx_table);
-	int i;
+	struct ctx_rq_wait wait;
+	int i, skipped;
 
 	if (!table)
 		return;
 
+	atomic_set(&wait.count, table->nr);
+	init_completion(&wait.comp);
+
+	skipped = 0;
 	for (i = 0; i < table->nr; ++i) {
 		struct kioctx *ctx = table->table[i];
-		struct completion requests_done =
-			COMPLETION_INITIALIZER_ONSTACK(requests_done);
 
-		if (!ctx)
+		if (!ctx) {
+			skipped++;
 			continue;
+		}
+
 		/*
 		 * We don't need to bother with munmap() here - exit_mmap(mm)
 		 * is coming and it'll unmap everything. And we simply can't,
@@ -816,10 +827,12 @@ void exit_aio(struct mm_struct *mm)
 		 * that it needs to unmap the area, just set it to 0.
 		 */
 		ctx->mmap_size = 0;
-		kill_ioctx(mm, ctx, &requests_done);
+		kill_ioctx(mm, ctx, &wait);
+	}
 
+	if (!atomic_sub_and_test(skipped, &wait.count)) {
 		/* Wait until all IO for the context are done. */
-		wait_for_completion(&requests_done);
+		wait_for_completion(&wait.comp);
 	}
 
 	RCU_INIT_POINTER(mm->ioctx_table, NULL);
@@ -1299,15 +1312,17 @@ SYSCALL_DEFINE1(io_destroy, aio_context_
 {
 	struct kioctx *ioctx = lookup_ioctx(ctx);
 	if (likely(NULL != ioctx)) {
-		struct completion requests_done =
-			COMPLETION_INITIALIZER_ONSTACK(requests_done);
+		struct ctx_rq_wait wait;
 		int ret;
 
+		init_completion(&wait.comp);
+		atomic_set(&wait.count, 1);
+
 		/* Pass requests_done to kill_ioctx() where it can be set
 		 * in a thread-safe way. If we try to set it here then we have
 		 * a race condition if two io_destroy() called simultaneously.
 		 */
-		ret = kill_ioctx(current->mm, ioctx, &requests_done);
+		ret = kill_ioctx(current->mm, ioctx, &wait);
 		percpu_ref_put(&ioctx->users);
 
 		/* Wait until all IO for the context are done. Otherwise kernel
@@ -1315,7 +1330,7 @@ SYSCALL_DEFINE1(io_destroy, aio_context_
 		 * is destroyed.
 		 */
 		if (!ret)
-			wait_for_completion(&requests_done);
+			wait_for_completion(&wait.comp);
 
 		return ret;
 	}
