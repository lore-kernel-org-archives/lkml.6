Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A2EC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BA325347
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="glwzAslW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BA325347
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbeGBPMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:12:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54211 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752386AbeGBPMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:12:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id b188-v6so9469813wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 08:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZYatWEuy5Qf3+Cjj8pQwzQqjHGU3v1omyncQYvVH8aY=;
        b=glwzAslWN7yr5HE7JaZYhryvXhUjZcZM08dhXsELNEg2dfnrNnfOwjAe/Vncf7EzsW
         chHGpe1Lrl21FVNQu5WJqxopVRW5evLQMMjrn1BIs5v7csP/2qIYRgrtqZeFGWjqtqSN
         zpF+HWSJC3uBuYXimrURxso3w/ix3iiK1/Ei4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZYatWEuy5Qf3+Cjj8pQwzQqjHGU3v1omyncQYvVH8aY=;
        b=h60IOis5YWmUm6w14fPiVdTofn2akVGm6eVVAd3N9DQO+l4nIJksyAqIADnbLPjjDc
         i74VNanicfssrHleIyq2QyMvGBveZUzq1ZqdN6LJdFUfATTbbuOdWD8qssIlkc4UdQ5P
         9+kRbwkeZ1IlhHUfaAJn+qmInhLpJX16br4CpEnMNVeojrNGh7jtTTAeZMptNZN8PQNF
         oO0sWmK7qxVaBQL6QcLrd24dTTsd2SrYofPugdDnI0qropFdaq7Eaksvi9aLShVOyPMp
         oLFtrRv44Oa1eGhzc2L5pPTQERgia1Le0bYw+wzLb7Ny0U3Mt0mJvQJ9uLgdyVTi3hB0
         Jrpw==
X-Gm-Message-State: APt69E16MchwBNoLaiXyx4USnl4x3wN7Y80Uxvr01Hfl8Z3E3AoDHH39
        ROaD7AwVoqg6XlydOhaY7WDQgNNf
X-Google-Smtp-Source: AAOMgpeXK8tSIS1p1yFV8NzAvFdxnCHK7QQDxS+azVSOKyqQwou9Y9kMFyPAo7iK91WI1XeO5cXBww==
X-Received: by 2002:a1c:5d0e:: with SMTP id r14-v6mr8224928wmb.152.1530544336693;
        Mon, 02 Jul 2018 08:12:16 -0700 (PDT)
Received: from andrea.amarulasolutions.com (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id s184-v6sm8994794wmf.5.2018.07.02.08.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 08:12:15 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH v2 2/3] locking: Clarify requirements for smp_mb__after_spinlock()
Date:   Mon,  2 Jul 2018 17:11:55 +0200
Message-Id: <1530544315-14614-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530182480-13205-3-git-send-email-andrea.parri@amarulasolutions.com>
References: <1530182480-13205-3-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 11 interpretations of the requirements described in the header
comment for smp_mb__after_spinlock(): one for each LKMM maintainer, and
one currently encoded in the Cat file. Stick to the latter (until a more
satisfactory solution is available).

This also reworks some snippets related to the barrier to illustrate the
requirements and to link them to the idioms which are relied upon at its
call sites.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
---
Changes since v1:

  - reworked the snippets (Peter Zijlstra)
  - style fixes (Alan Stern and Matthew Wilcox)
  - added Boqun's Suggested-by: tag

 include/linux/spinlock.h | 51 ++++++++++++++++++++++++++++++++----------------
 kernel/sched/core.c      | 41 +++++++++++++++++++-------------------
 2 files changed, 55 insertions(+), 37 deletions(-)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 1e8a464358384..0b46efca659f9 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -114,29 +114,46 @@ do {								\
 #endif /*arch_spin_is_contended*/
 
 /*
- * This barrier must provide two things:
+ * smp_mb__after_spinlock() provides the equivalent of a full memory barrier
+ * between program-order earlier lock acquisitions and program-order later
+ * memory accesses.
  *
- *   - it must guarantee a STORE before the spin_lock() is ordered against a
- *     LOAD after it, see the comments at its two usage sites.
+ * This guarantees that the following two properties hold:
  *
- *   - it must ensure the critical section is RCsc.
+ *   1) Given the snippet:
  *
- * The latter is important for cases where we observe values written by other
- * CPUs in spin-loops, without barriers, while being subject to scheduling.
+ *	  { X = 0;  Y = 0; }
  *
- * CPU0			CPU1			CPU2
+ *	  CPU0				CPU1
  *
- *			for (;;) {
- *			  if (READ_ONCE(X))
- *			    break;
- *			}
- * X=1
- *			<sched-out>
- *						<sched-in>
- *						r = X;
+ *	  WRITE_ONCE(X, 1);		WRITE_ONCE(Y, 1);
+ *	  spin_lock(S);			smp_mb();
+ *	  smp_mb__after_spinlock();	r1 = READ_ONCE(X);
+ *	  r0 = READ_ONCE(Y);
+ *	  spin_unlock(S);
  *
- * without transitivity it could be that CPU1 observes X!=0 breaks the loop,
- * we get migrated and CPU2 sees X==0.
+ *      it is forbidden that CPU0 does not observe CPU1's store to Y (r0 = 0)
+ *      and CPU1 does not observe CPU0's store to X (r1 = 0); see the comments
+ *      preceding the call to smp_mb__after_spinlock() in __schedule() and in
+ *      try_to_wake_up().
+ *
+ *   2) Given the snippet:
+ *
+ *  { X = 0;  Y = 0; }
+ *
+ *  CPU0		CPU1				CPU2
+ *
+ *  spin_lock(S);	spin_lock(S);			r1 = READ_ONCE(Y);
+ *  WRITE_ONCE(X, 1);	smp_mb__after_spinlock();	smp_rmb();
+ *  spin_unlock(S);	r0 = READ_ONCE(X);		r2 = READ_ONCE(X);
+ *			WRITE_ONCE(Y, 1);
+ *			spin_unlock(S);
+ *
+ *      it is forbidden that CPU0's critical section executes before CPU1's
+ *      critical section (r0 = 1), CPU2 observes CPU1's store to Y (r1 = 1)
+ *      and CPU2 does not observe CPU0's store to X (r2 = 0); see the comments
+ *      preceding the calls to smp_rmb() in try_to_wake_up() for similar
+ *      snippets but "projected" onto two CPUs.
  *
  * Since most load-store architectures implement ACQUIRE with an smp_mb() after
  * the LL/SC loop, they need no further barriers. Similarly all our TSO
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da8f12119a127..ec9ef0aec71ac 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1999,21 +1999,20 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * be possible to, falsely, observe p->on_rq == 0 and get stuck
 	 * in smp_cond_load_acquire() below.
 	 *
-	 * sched_ttwu_pending()                 try_to_wake_up()
-	 *   [S] p->on_rq = 1;                  [L] P->state
-	 *       UNLOCK rq->lock  -----.
-	 *                              \
-	 *				 +---   RMB
-	 * schedule()                   /
-	 *       LOCK rq->lock    -----'
-	 *       UNLOCK rq->lock
+	 * sched_ttwu_pending()			try_to_wake_up()
+	 *   STORE p->on_rq = 1			  LOAD p->state
+	 *   UNLOCK rq->lock
+	 *
+	 * __schedule() (switch to task 'p')
+	 *   LOCK rq->lock			  smp_rmb();
+	 *   smp_mb__after_spinlock();
+	 *   UNLOCK rq->lock
 	 *
 	 * [task p]
-	 *   [S] p->state = UNINTERRUPTIBLE     [L] p->on_rq
+	 *   STORE p->state = UNINTERRUPTIBLE	  LOAD p->on_rq
 	 *
-	 * Pairs with the UNLOCK+LOCK on rq->lock from the
-	 * last wakeup of our task and the schedule that got our task
-	 * current.
+	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
+	 * __schedule().  See the comment for smp_mb__after_spinlock().
 	 */
 	smp_rmb();
 	if (p->on_rq && ttwu_remote(p, wake_flags))
@@ -2027,15 +2026,17 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * One must be running (->on_cpu == 1) in order to remove oneself
 	 * from the runqueue.
 	 *
-	 *  [S] ->on_cpu = 1;	[L] ->on_rq
-	 *      UNLOCK rq->lock
-	 *			RMB
-	 *      LOCK   rq->lock
-	 *  [S] ->on_rq = 0;    [L] ->on_cpu
+	 * __schedule() (switch to task 'p')	try_to_wake_up()
+	 *   STORE p->on_cpu = 1		  LOAD p->on_rq
+	 *   UNLOCK rq->lock
+	 *
+	 * __schedule() (put 'p' to sleep)
+	 *   LOCK rq->lock			  smp_rmb();
+	 *   smp_mb__after_spinlock();
+	 *   STORE p->on_rq = 0			  LOAD p->on_cpu
 	 *
-	 * Pairs with the full barrier implied in the UNLOCK+LOCK on rq->lock
-	 * from the consecutive calls to schedule(); the first switching to our
-	 * task, the second putting it to sleep.
+	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
+	 * __schedule().  See the comment for smp_mb__after_spinlock().
 	 */
 	smp_rmb();
 
-- 
2.7.4

