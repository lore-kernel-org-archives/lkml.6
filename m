Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754972AbeEaM2g (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:28:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39913 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754197AbeEaM2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:28:32 -0400
Date: Thu, 31 May 2018 05:28:05 -0700
From: tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-175f0e25abeaa2218d431141ce19cf1de70fa82d@git.kernel.org>
Cc: tglx@linutronix.de, paulmck@linux.vnet.ibm.com, tj@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org,
        rostedt@goodmis.org, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, tj@kernel.org, tglx@linutronix.de,
        paulmck@linux.vnet.ibm.com, rostedt@goodmis.org, hpa@zytor.com,
        peterz@infradead.org, mingo@kernel.org, torvalds@linux-foundation.org
In-Reply-To: <20170725165821.cejhb7v2s3kecems@hirez.programming.kicks-ass.net>
References: <20170725165821.cejhb7v2s3kecems@hirez.programming.kicks-ass.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/core: Fix rules for running on online &&
 !active CPUs
Git-Commit-ID: 175f0e25abeaa2218d431141ce19cf1de70fa82d
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

Commit-ID:  175f0e25abeaa2218d431141ce19cf1de70fa82d
Gitweb:     https://git.kernel.org/tip/175f0e25abeaa2218d431141ce19cf1de70fa82d
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Tue, 25 Jul 2017 18:58:21 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 31 May 2018 12:24:24 +0200

sched/core: Fix rules for running on online && !active CPUs

As already enforced by the WARN() in __set_cpus_allowed_ptr(), the rules
for running on an online && !active CPU are stricter than just being a
kthread, you need to be a per-cpu kthread.

If you're not strictly per-CPU, you have better CPUs to run on and
don't need the partially booted one to get your work done.

The exception is to allow smpboot threads to bootstrap the CPU itself
and get kernel 'services' initialized before we allow userspace on it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 955dbdf4ce87 ("sched: Allow migrating kthreads into online but inactive CPUs")
Link: http://lkml.kernel.org/r/20170725165821.cejhb7v2s3kecems@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 42 ++++++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 092f7c4de903..1c58f54b9114 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -881,6 +881,33 @@ void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags)
 }
 
 #ifdef CONFIG_SMP
+
+static inline bool is_per_cpu_kthread(struct task_struct *p)
+{
+	if (!(p->flags & PF_KTHREAD))
+		return false;
+
+	if (p->nr_cpus_allowed != 1)
+		return false;
+
+	return true;
+}
+
+/*
+ * Per-CPU kthreads are allowed to run on !actie && online CPUs, see
+ * __set_cpus_allowed_ptr() and select_fallback_rq().
+ */
+static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
+{
+	if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
+		return false;
+
+	if (is_per_cpu_kthread(p))
+		return cpu_online(cpu);
+
+	return cpu_active(cpu);
+}
+
 /*
  * This is how migration works:
  *
@@ -938,16 +965,8 @@ struct migration_arg {
 static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
 				 struct task_struct *p, int dest_cpu)
 {
-	if (p->flags & PF_KTHREAD) {
-		if (unlikely(!cpu_online(dest_cpu)))
-			return rq;
-	} else {
-		if (unlikely(!cpu_active(dest_cpu)))
-			return rq;
-	}
-
 	/* Affinity changed (again). */
-	if (!cpumask_test_cpu(dest_cpu, &p->cpus_allowed))
+	if (!is_cpu_allowed(p, dest_cpu))
 		return rq;
 
 	update_rq_clock(rq);
@@ -1476,10 +1495,9 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 	for (;;) {
 		/* Any allowed, online CPU? */
 		for_each_cpu(dest_cpu, &p->cpus_allowed) {
-			if (!(p->flags & PF_KTHREAD) && !cpu_active(dest_cpu))
-				continue;
-			if (!cpu_online(dest_cpu))
+			if (!is_cpu_allowed(p, dest_cpu))
 				continue;
+
 			goto out;
 		}
 
