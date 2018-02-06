Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbeBFL5y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 06:57:54 -0500
Received: from terminus.zytor.com ([65.50.211.136]:57211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbeBFL5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 06:57:42 -0500
Date: Tue, 6 Feb 2018 03:54:16 -0800
From: "tip-bot for Steven Rostedt (VMware)" <tipbot@zytor.com>
Message-ID: <tip-ad0f1d9d65938aec72a698116cd73a980916895e@git.kernel.org>
Cc: pkondeti@codeaurora.org, efault@gmx.de, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
        peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        torvalds@linux-foundation.org
Reply-To: pkondeti@codeaurora.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, efault@gmx.de, peterz@infradead.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <CAEU1=PkiHO35Dzna8EQqNSKW1fr1y1zRQ5y66X117MG06sQtNA@mail.gmail.com>
References: <CAEU1=PkiHO35Dzna8EQqNSKW1fr1y1zRQ5y66X117MG06sQtNA@mail.gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/rt: Use container_of() to get root domain
 in rto_push_irq_work_func()
Git-Commit-ID: ad0f1d9d65938aec72a698116cd73a980916895e
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

Commit-ID:  ad0f1d9d65938aec72a698116cd73a980916895e
Gitweb:     https://git.kernel.org/tip/ad0f1d9d65938aec72a698116cd73a980916895e
Author:     Steven Rostedt (VMware) <rostedt@goodmis.org>
AuthorDate: Tue, 23 Jan 2018 20:45:37 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 6 Feb 2018 10:20:33 +0100

sched/rt: Use container_of() to get root domain in rto_push_irq_work_func()

When the rto_push_irq_work_func() is called, it looks at the RT overloaded
bitmask in the root domain via the runqueue (rq->rd). The problem is that
during CPU up and down, nothing here stops rq->rd from changing between
taking the rq->rd->rto_lock and releasing it. That means the lock that is
released is not the same lock that was taken.

Instead of using this_rq()->rd to get the root domain, as the irq work is
part of the root domain, we can simply get the root domain from the irq work
that is passed to the routine:

 container_of(work, struct root_domain, rto_push_work)

This keeps the root domain consistent.

Reported-by: Pavan Kondeti <pkondeti@codeaurora.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 4bdced5c9a292 ("sched/rt: Simplify the IPI based RT balancing logic")
Link: http://lkml.kernel.org/r/CAEU1=PkiHO35Dzna8EQqNSKW1fr1y1zRQ5y66X117MG06sQtNA@mail.gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/rt.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 862a513..2fb627d 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1907,9 +1907,8 @@ static void push_rt_tasks(struct rq *rq)
  * the rt_loop_next will cause the iterator to perform another scan.
  *
  */
-static int rto_next_cpu(struct rq *rq)
+static int rto_next_cpu(struct root_domain *rd)
 {
-	struct root_domain *rd = rq->rd;
 	int next;
 	int cpu;
 
@@ -1985,7 +1984,7 @@ static void tell_cpu_to_push(struct rq *rq)
 	 * Otherwise it is finishing up and an ipi needs to be sent.
 	 */
 	if (rq->rd->rto_cpu < 0)
-		cpu = rto_next_cpu(rq);
+		cpu = rto_next_cpu(rq->rd);
 
 	raw_spin_unlock(&rq->rd->rto_lock);
 
@@ -1998,6 +1997,8 @@ static void tell_cpu_to_push(struct rq *rq)
 /* Called from hardirq context */
 void rto_push_irq_work_func(struct irq_work *work)
 {
+	struct root_domain *rd =
+		container_of(work, struct root_domain, rto_push_work);
 	struct rq *rq;
 	int cpu;
 
@@ -2013,18 +2014,18 @@ void rto_push_irq_work_func(struct irq_work *work)
 		raw_spin_unlock(&rq->lock);
 	}
 
-	raw_spin_lock(&rq->rd->rto_lock);
+	raw_spin_lock(&rd->rto_lock);
 
 	/* Pass the IPI to the next rt overloaded queue */
-	cpu = rto_next_cpu(rq);
+	cpu = rto_next_cpu(rd);
 
-	raw_spin_unlock(&rq->rd->rto_lock);
+	raw_spin_unlock(&rd->rto_lock);
 
 	if (cpu < 0)
 		return;
 
 	/* Try the next RT overloaded CPU */
-	irq_work_queue_on(&rq->rd->rto_push_work, cpu);
+	irq_work_queue_on(&rd->rto_push_work, cpu);
 }
 #endif /* HAVE_RT_PUSH_IPI */
 
