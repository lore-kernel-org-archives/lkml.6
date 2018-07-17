Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A007ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B9420852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B9420852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbeGQKCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:02:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41263 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbeGQKCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:02:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6H9UmuY1462770
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 02:30:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6H9Umbl1462767;
        Tue, 17 Jul 2018 02:30:48 -0700
Date:   Tue, 17 Jul 2018 02:30:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrea Parri <tipbot@zytor.com>
Message-ID: <tip-76e079fefc8f62bd9b2cd2950814d1ee806e31a5@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org,
        andrea.parri@amarulasolutions.com, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de
Reply-To: torvalds@linux-foundation.org, andrea.parri@amarulasolutions.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          paulmck@linux.vnet.ibm.com, mingo@kernel.org, tglx@linutronix.de,
          hpa@zytor.com
In-Reply-To: <20180716180605.16115-10-paulmck@linux.vnet.ibm.com>
References: <20180716180605.16115-10-paulmck@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] sched/core: Use smp_mb() in
 wake_woken_function()
Git-Commit-ID: 76e079fefc8f62bd9b2cd2950814d1ee806e31a5
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  76e079fefc8f62bd9b2cd2950814d1ee806e31a5
Gitweb:     https://git.kernel.org/tip/76e079fefc8f62bd9b2cd2950814d1ee806e31a5
Author:     Andrea Parri <andrea.parri@amarulasolutions.com>
AuthorDate: Mon, 16 Jul 2018 11:06:01 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 17 Jul 2018 09:30:33 +0200

sched/core: Use smp_mb() in wake_woken_function()

wake_woken_function() synchronizes with wait_woken() as follows:

  [wait_woken]                       [wake_woken_function]

  entry->flags &= ~wq_flag_woken;    condition = true;
  smp_mb();                          smp_wmb();
  if (condition)                     wq_entry->flags |= wq_flag_woken;
     break;

This commit replaces the above smp_wmb() with an smp_mb() in order to
guarantee that either wait_woken() sees the wait condition being true
or the store to wq_entry->flags in woken_wake_function() follows the
store in wait_woken() in the coherence order (so that the former can
eventually be observed by wait_woken()).

The commit also fixes a comment associated to set_current_state() in
wait_woken(): the comment pairs the barrier in set_current_state() to
the above smp_wmb(), while the actual pairing involves the barrier in
set_current_state() and the barrier executed by the try_to_wake_up()
in wake_woken_function().

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: stern@rowland.harvard.edu
Cc: will.deacon@arm.com
Link: http://lkml.kernel.org/r/20180716180605.16115-10-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/wait.c | 47 +++++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 928be527477e..a7a2aaa3026a 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -392,35 +392,36 @@ static inline bool is_kthread_should_stop(void)
  *     if (condition)
  *         break;
  *
- *     p->state = mode;				condition = true;
- *     smp_mb(); // A				smp_wmb(); // C
- *     if (!wq_entry->flags & WQ_FLAG_WOKEN)	wq_entry->flags |= WQ_FLAG_WOKEN;
- *         schedule()				try_to_wake_up();
- *     p->state = TASK_RUNNING;		    ~~~~~~~~~~~~~~~~~~
- *     wq_entry->flags &= ~WQ_FLAG_WOKEN;		condition = true;
- *     smp_mb() // B				smp_wmb(); // C
- *						wq_entry->flags |= WQ_FLAG_WOKEN;
- * }
- * remove_wait_queue(&wq_head, &wait);
+ *     // in wait_woken()			// in woken_wake_function()
  *
+ *     p->state = mode;				wq_entry->flags |= WQ_FLAG_WOKEN;
+ *     smp_mb(); // A				try_to_wake_up():
+ *     if (!(wq_entry->flags & WQ_FLAG_WOKEN))	   <full barrier>
+ *         schedule()				   if (p->state & mode)
+ *     p->state = TASK_RUNNING;			      p->state = TASK_RUNNING;
+ *     wq_entry->flags &= ~WQ_FLAG_WOKEN;	~~~~~~~~~~~~~~~~~~
+ *     smp_mb(); // B				condition = true;
+ * }						smp_mb(); // C
+ * remove_wait_queue(&wq_head, &wait);		wq_entry->flags |= WQ_FLAG_WOKEN;
  */
 long wait_woken(struct wait_queue_entry *wq_entry, unsigned mode, long timeout)
 {
-	set_current_state(mode); /* A */
 	/*
-	 * The above implies an smp_mb(), which matches with the smp_wmb() from
-	 * woken_wake_function() such that if we observe WQ_FLAG_WOKEN we must
-	 * also observe all state before the wakeup.
+	 * The below executes an smp_mb(), which matches with the full barrier
+	 * executed by the try_to_wake_up() in woken_wake_function() such that
+	 * either we see the store to wq_entry->flags in woken_wake_function()
+	 * or woken_wake_function() sees our store to current->state.
 	 */
+	set_current_state(mode); /* A */
 	if (!(wq_entry->flags & WQ_FLAG_WOKEN) && !is_kthread_should_stop())
 		timeout = schedule_timeout(timeout);
 	__set_current_state(TASK_RUNNING);
 
 	/*
-	 * The below implies an smp_mb(), it too pairs with the smp_wmb() from
-	 * woken_wake_function() such that we must either observe the wait
-	 * condition being true _OR_ WQ_FLAG_WOKEN such that we will not miss
-	 * an event.
+	 * The below executes an smp_mb(), which matches with the smp_mb() (C)
+	 * in woken_wake_function() such that either we see the wait condition
+	 * being true or the store to wq_entry->flags in woken_wake_function()
+	 * follows ours in the coherence order.
 	 */
 	smp_store_mb(wq_entry->flags, wq_entry->flags & ~WQ_FLAG_WOKEN); /* B */
 
@@ -430,14 +431,8 @@ EXPORT_SYMBOL(wait_woken);
 
 int woken_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *key)
 {
-	/*
-	 * Although this function is called under waitqueue lock, LOCK
-	 * doesn't imply write barrier and the users expects write
-	 * barrier semantics on wakeup functions.  The following
-	 * smp_wmb() is equivalent to smp_wmb() in try_to_wake_up()
-	 * and is paired with smp_store_mb() in wait_woken().
-	 */
-	smp_wmb(); /* C */
+	/* Pairs with the smp_store_mb() in wait_woken(). */
+	smp_mb(); /* C */
 	wq_entry->flags |= WQ_FLAG_WOKEN;
 
 	return default_wake_function(wq_entry, mode, sync, key);
