Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Syu3IjJPGVsmfAAAmS7hNA
	; Thu, 07 Jun 2018 15:31:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 44C3C60115; Thu,  7 Jun 2018 15:31:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 00A89608C8;
	Thu,  7 Jun 2018 15:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 00A89608C8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934572AbeFGPbS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:31:18 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40974 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935190AbeFGOyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:54:02 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbG-0005Zi-69; Thu, 07 Jun 2018 15:09:14 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0003FT-Qz; Thu, 07 Jun 2018 15:09:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jann Horn" <jannh@google.com>,
        "Kent Overstreet" <kent.overstreet@gmail.com>,
        "Tejun Heo" <tj@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.457141993@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 357/410] fs/aio: Add explicit RCU grace period when
 freeing kioctx
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

From: Tejun Heo <tj@kernel.org>

commit a6d7cff472eea87d96899a20fa718d2bab7109f3 upstream.

While fixing refcounting, e34ecee2ae79 ("aio: Fix a trinity splat")
incorrectly removed explicit RCU grace period before freeing kioctx.
The intention seems to be depending on the internal RCU grace periods
of percpu_ref; however, percpu_ref uses a different flavor of RCU,
sched-RCU.  This can lead to kioctx being freed while RCU read
protected dereferences are still in progress.

Fix it by updating free_ioctx() to go through call_rcu() explicitly.

v2: Comment added to explain double bouncing.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Jann Horn <jannh@google.com>
Fixes: e34ecee2ae79 ("aio: Fix a trinity splat")
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/aio.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

--- a/fs/aio.c
+++ b/fs/aio.c
@@ -115,7 +115,8 @@ struct kioctx {
 	struct page		**ring_pages;
 	long			nr_pages;
 
-	struct work_struct	free_work;
+	struct rcu_head		free_rcu;
+	struct work_struct	free_work;	/* see free_ioctx() */
 
 	/*
 	 * signals when all in-flight requests are done
@@ -512,6 +513,12 @@ static int kiocb_cancel(struct kiocb *ki
 	return cancel(kiocb);
 }
 
+/*
+ * free_ioctx() should be RCU delayed to synchronize against the RCU
+ * protected lookup_ioctx() and also needs process context to call
+ * aio_free_ring(), so the double bouncing through kioctx->free_rcu and
+ * ->free_work.
+ */
 static void free_ioctx(struct work_struct *work)
 {
 	struct kioctx *ctx = container_of(work, struct kioctx, free_work);
@@ -523,6 +530,14 @@ static void free_ioctx(struct work_struc
 	kmem_cache_free(kioctx_cachep, ctx);
 }
 
+static void free_ioctx_rcufn(struct rcu_head *head)
+{
+	struct kioctx *ctx = container_of(head, struct kioctx, free_rcu);
+
+	INIT_WORK(&ctx->free_work, free_ioctx);
+	schedule_work(&ctx->free_work);
+}
+
 static void free_ioctx_reqs(struct percpu_ref *ref)
 {
 	struct kioctx *ctx = container_of(ref, struct kioctx, reqs);
@@ -531,8 +546,8 @@ static void free_ioctx_reqs(struct percp
 	if (ctx->rq_wait && atomic_dec_and_test(&ctx->rq_wait->count))
 		complete(&ctx->rq_wait->comp);
 
-	INIT_WORK(&ctx->free_work, free_ioctx);
-	schedule_work(&ctx->free_work);
+	/* Synchronize against RCU protected table->table[] dereferences */
+	call_rcu(&ctx->free_rcu, free_ioctx_rcufn);
 }
 
 /*
@@ -754,7 +769,7 @@ static int kill_ioctx(struct mm_struct *
 	table->table[ctx->id] = NULL;
 	spin_unlock(&mm->ioctx_lock);
 
-	/* percpu_ref_kill() will do the necessary call_rcu() */
+	/* free_ioctx_reqs() will do the necessary RCU synchronization */
 	wake_up_all(&ctx->wait);
 
 	/*
