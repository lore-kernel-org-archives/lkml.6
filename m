Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751779AbeDEJR5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 05:17:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56143 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbeDEJR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 05:17:56 -0400
Date: Thu, 5 Apr 2018 02:17:29 -0700
From: tip-bot for Davidlohr Bueso <tipbot@zytor.com>
Message-ID: <tip-adcc8da8859bee9548bb6d323b1e8de8a7252acd@git.kernel.org>
Cc: dave@stgolabs.net, dbueso@suse.de, torvalds@linux-foundation.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, peterz@infradead.org,
        efault@gmx.de, mingo@kernel.org, tglx@linutronix.de
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        efault@gmx.de, tglx@linutronix.de, dave@stgolabs.net, dbueso@suse.de,
        torvalds@linux-foundation.org, hpa@zytor.com
In-Reply-To: <20180404161539.nhadkff2aats74jh@linux-n805>
References: <20180404161539.nhadkff2aats74jh@linux-n805>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/core: Simplify helpers for rq clock update
 skip requests
Git-Commit-ID: adcc8da8859bee9548bb6d323b1e8de8a7252acd
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  adcc8da8859bee9548bb6d323b1e8de8a7252acd
Gitweb:     https://git.kernel.org/tip/adcc8da8859bee9548bb6d323b1e8de8a7252acd
Author:     Davidlohr Bueso <dave@stgolabs.net>
AuthorDate: Wed, 4 Apr 2018 09:15:39 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 5 Apr 2018 09:20:46 +0200

sched/core: Simplify helpers for rq clock update skip requests

By renaming the functions we can get rid of the skip parameter
and have better code redability. It makes zero sense to have
things such as:

  rq_clock_skip_update(rq, false)

When the skip request is in fact not going to happen. Ever. Rename
things such that we end up with:

  rq_clock_skip_update(rq)
  rq_clock_cancel_skipupdate(rq)

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: matt@codeblueprint.co.uk
Cc: rostedt@goodmis.org
Link: http://lkml.kernel.org/r/20180404161539.nhadkff2aats74jh@linux-n805
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c     |  2 +-
 kernel/sched/deadline.c |  2 +-
 kernel/sched/fair.c     |  2 +-
 kernel/sched/rt.c       |  2 +-
 kernel/sched/sched.h    | 17 ++++++++++++-----
 5 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 28b68995a417..550a07f648b6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -874,7 +874,7 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 	 * this case, we can save a useless back to back clock update.
 	 */
 	if (task_on_rq_queued(rq->curr) && test_tsk_need_resched(rq->curr))
-		rq_clock_skip_update(rq, true);
+		rq_clock_skip_update(rq);
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d1c7bf7c7e5b..e7b3008b85bb 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1560,7 +1560,7 @@ static void yield_task_dl(struct rq *rq)
 	 * so we don't do microscopic update in schedule()
 	 * and double the fastpath cost.
 	 */
-	rq_clock_skip_update(rq, true);
+	rq_clock_skip_update(rq);
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0951d1c58d2f..54dc31e7ab9b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7089,7 +7089,7 @@ static void yield_task_fair(struct rq *rq)
 		 * so we don't do microscopic update in schedule()
 		 * and double the fastpath cost.
 		 */
-		rq_clock_skip_update(rq, true);
+		rq_clock_skip_update(rq);
 	}
 
 	set_skip_buddy(se);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ad13e6242481..7aef6b4e885a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -861,7 +861,7 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 				 * 'runtime'.
 				 */
 				if (rt_rq->rt_nr_running && rq->curr == rq->idle)
-					rq_clock_skip_update(rq, false);
+					rq_clock_cancel_skipupdate(rq);
 			}
 			if (rt_rq->rt_time || rt_rq->rt_nr_running)
 				idle = 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c3deaee7a7a2..15750c222ca2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -976,13 +976,20 @@ static inline u64 rq_clock_task(struct rq *rq)
 	return rq->clock_task;
 }
 
-static inline void rq_clock_skip_update(struct rq *rq, bool skip)
+static inline void rq_clock_skip_update(struct rq *rq)
 {
 	lockdep_assert_held(&rq->lock);
-	if (skip)
-		rq->clock_update_flags |= RQCF_REQ_SKIP;
-	else
-		rq->clock_update_flags &= ~RQCF_REQ_SKIP;
+	rq->clock_update_flags |= RQCF_REQ_SKIP;
+}
+
+/*
+ * See rt task throttoling, which is the only time a skip
+ * request is cancelled.
+ */
+static inline void rq_clock_cancel_skipupdate(struct rq *rq)
+{
+	lockdep_assert_held(&rq->lock);
+	rq->clock_update_flags &= ~RQCF_REQ_SKIP;
 }
 
 struct rq_flags {
