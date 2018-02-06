Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752941AbeBFL6T (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 06:58:19 -0500
Received: from terminus.zytor.com ([65.50.211.136]:34541 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752792AbeBFL6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 06:58:07 -0500
Date: Tue, 6 Feb 2018 03:54:42 -0800
From: "tip-bot for Steven Rostedt (VMware)" <tipbot@zytor.com>
Message-ID: <tip-364f56653708ba8bcdefd4f0da2a42904baa8eeb@git.kernel.org>
Cc: pkondeti@codeaurora.org, efault@gmx.de, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        rostedt@goodmis.org, hpa@zytor.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        hpa@zytor.com, rostedt@goodmis.org, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        efault@gmx.de, pkondeti@codeaurora.org
In-Reply-To: <CAEU1=PkiHO35Dzna8EQqNSKW1fr1y1zRQ5y66X117MG06sQtNA@mail.gmail.com>
References: <CAEU1=PkiHO35Dzna8EQqNSKW1fr1y1zRQ5y66X117MG06sQtNA@mail.gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/rt: Up the root domain ref count when
 passing it around via IPIs
Git-Commit-ID: 364f56653708ba8bcdefd4f0da2a42904baa8eeb
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

Commit-ID:  364f56653708ba8bcdefd4f0da2a42904baa8eeb
Gitweb:     https://git.kernel.org/tip/364f56653708ba8bcdefd4f0da2a42904baa8eeb
Author:     Steven Rostedt (VMware) <rostedt@goodmis.org>
AuthorDate: Tue, 23 Jan 2018 20:45:38 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 6 Feb 2018 10:20:33 +0100

sched/rt: Up the root domain ref count when passing it around via IPIs

When issuing an IPI RT push, where an IPI is sent to each CPU that has more
than one RT task scheduled on it, it references the root domain's rto_mask,
that contains all the CPUs within the root domain that has more than one RT
task in the runable state. The problem is, after the IPIs are initiated, the
rq->lock is released. This means that the root domain that is associated to
the run queue could be freed while the IPIs are going around.

Add a sched_get_rd() and a sched_put_rd() that will increment and decrement
the root domain's ref count respectively. This way when initiating the IPIs,
the scheduler will up the root domain's ref count before releasing the
rq->lock, ensuring that the root domain does not go away until the IPI round
is complete.

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
 kernel/sched/rt.c       |  9 +++++++--
 kernel/sched/sched.h    |  2 ++
 kernel/sched/topology.c | 13 +++++++++++++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 2fb627d..89a086e 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1990,8 +1990,11 @@ static void tell_cpu_to_push(struct rq *rq)
 
 	rto_start_unlock(&rq->rd->rto_loop_start);
 
-	if (cpu >= 0)
+	if (cpu >= 0) {
+		/* Make sure the rd does not get freed while pushing */
+		sched_get_rd(rq->rd);
 		irq_work_queue_on(&rq->rd->rto_push_work, cpu);
+	}
 }
 
 /* Called from hardirq context */
@@ -2021,8 +2024,10 @@ void rto_push_irq_work_func(struct irq_work *work)
 
 	raw_spin_unlock(&rd->rto_lock);
 
-	if (cpu < 0)
+	if (cpu < 0) {
+		sched_put_rd(rd);
 		return;
+	}
 
 	/* Try the next RT overloaded CPU */
 	irq_work_queue_on(&rd->rto_push_work, cpu);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2e95505..fb5fc45 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -691,6 +691,8 @@ extern struct mutex sched_domains_mutex;
 extern void init_defrootdomain(void);
 extern int sched_init_domains(const struct cpumask *cpu_map);
 extern void rq_attach_root(struct rq *rq, struct root_domain *rd);
+extern void sched_get_rd(struct root_domain *rd);
+extern void sched_put_rd(struct root_domain *rd);
 
 #ifdef HAVE_RT_PUSH_IPI
 extern void rto_push_irq_work_func(struct irq_work *work);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 034cbed..519b024 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -259,6 +259,19 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 		call_rcu_sched(&old_rd->rcu, free_rootdomain);
 }
 
+void sched_get_rd(struct root_domain *rd)
+{
+	atomic_inc(&rd->refcount);
+}
+
+void sched_put_rd(struct root_domain *rd)
+{
+	if (!atomic_dec_and_test(&rd->refcount))
+		return;
+
+	call_rcu_sched(&rd->rcu, free_rootdomain);
+}
+
 static int init_rootdomain(struct root_domain *rd)
 {
 	if (!zalloc_cpumask_var(&rd->span, GFP_KERNEL))
