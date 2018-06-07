Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id gU5CCto9GVvtRQAAmS7hNA
	; Thu, 07 Jun 2018 14:16:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A4F48608BA; Thu,  7 Jun 2018 14:16:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 055256063F;
	Thu,  7 Jun 2018 14:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 055256063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933326AbeFGOQU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:16:20 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39592 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933103AbeFGOJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:15 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbF-0005hL-QP; Thu, 07 Jun 2018 15:09:13 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0003FC-OX; Thu, 07 Jun 2018 15:09:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Oleg Nesterov" <oleg@redhat.com>,
        "Benjamin LaHaise" <bcrl@kvack.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.102450320@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 354/410] aio: change exit_aio() to load
 mm->ioctx_table once and avoid rcu_read_lock()
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

From: Oleg Nesterov <oleg@redhat.com>

commit 4b70ac5fd9b58bfaa5f25b4ea48f528aefbf3308 upstream.

On 04/30, Benjamin LaHaise wrote:
>
> > -		ctx->mmap_size = 0;
> > -
> > -		kill_ioctx(mm, ctx, NULL);
> > +		if (ctx) {
> > +			ctx->mmap_size = 0;
> > +			kill_ioctx(mm, ctx, NULL);
> > +		}
>
> Rather than indenting and moving the two lines changing mmap_size and the
> kill_ioctx() call, why not just do "if (!ctx) ... continue;"?  That reduces
> the number of lines changed and avoid excessive indentation.

OK. To me the code looks better/simpler with "if (ctx)", but this is subjective
of course, I won't argue.

The patch still removes the empty line between mmap_size = 0 and kill_ioctx(),
we reset mmap_size only for kill_ioctx(). But feel free to remove this change.

-------------------------------------------------------------------------------
Subject: [PATCH v3 1/2] aio: change exit_aio() to load mm->ioctx_table once and avoid rcu_read_lock()

1. We can read ->ioctx_table only once and we do not read rcu_read_lock()
   or even rcu_dereference().

   This mm has no users, nobody else can play with ->ioctx_table. Otherwise
   the code is buggy anyway, if we need rcu_read_lock() in a loop because
   ->ioctx_table can be updated then kfree(table) is obviously wrong.

2. Update the comment. "exit_mmap(mm) is coming" is the good reason to avoid
   munmap(), but another reason is that we simply can't do vm_munmap() unless
   current->mm == mm and this is not true in general, the caller is mmput().

3. We do not really need to nullify mm->ioctx_table before return, probably
   the current code does this to catch the potential problems. But in this
   case RCU_INIT_POINTER(NULL) looks better.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Benjamin LaHaise <bcrl@kvack.org>
[bwh: Backported to 3.16: Adjust context to apply after backport of commit
 6098b45b32e6 "aio: block exit_aio() until all context requests are completed"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -803,46 +803,35 @@ EXPORT_SYMBOL(wait_on_sync_kiocb);
  */
 void exit_aio(struct mm_struct *mm)
 {
-	struct kioctx_table *table;
-	struct kioctx *ctx;
-	unsigned i = 0;
+	struct kioctx_table *table = rcu_dereference_raw(mm->ioctx_table);
+	int i;
 
-	while (1) {
+	if (!table)
+		return;
+
+	for (i = 0; i < table->nr; ++i) {
+		struct kioctx *ctx = table->table[i];
 		struct completion requests_done =
 			COMPLETION_INITIALIZER_ONSTACK(requests_done);
 
-		rcu_read_lock();
-		table = rcu_dereference(mm->ioctx_table);
-
-		do {
-			if (!table || i >= table->nr) {
-				rcu_read_unlock();
-				rcu_assign_pointer(mm->ioctx_table, NULL);
-				if (table)
-					kfree(table);
-				return;
-			}
-
-			ctx = table->table[i++];
-		} while (!ctx);
-
-		rcu_read_unlock();
-
+		if (!ctx)
+			continue;
 		/*
-		 * We don't need to bother with munmap() here -
-		 * exit_mmap(mm) is coming and it'll unmap everything.
-		 * Since aio_free_ring() uses non-zero ->mmap_size
-		 * as indicator that it needs to unmap the area,
-		 * just set it to 0; aio_free_ring() is the only
-		 * place that uses ->mmap_size, so it's safe.
+		 * We don't need to bother with munmap() here - exit_mmap(mm)
+		 * is coming and it'll unmap everything. And we simply can't,
+		 * this is not necessarily our ->mm.
+		 * Since kill_ioctx() uses non-zero ->mmap_size as indicator
+		 * that it needs to unmap the area, just set it to 0.
 		 */
 		ctx->mmap_size = 0;
-
 		kill_ioctx(mm, ctx, &requests_done);
 
 		/* Wait until all IO for the context are done. */
 		wait_for_completion(&requests_done);
 	}
+
+	RCU_INIT_POINTER(mm->ioctx_table, NULL);
+	kfree(table);
 }
 
 static void put_reqs_available(struct kioctx *ctx, unsigned nr)
