Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbeECJZ2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 05:25:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49055 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeECJZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 05:25:26 -0400
Date: Thu, 3 May 2018 02:24:55 -0700
From: tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-0b26351b910fb8fe6a056f8a1bbccabe50c0e19f@git.kernel.org>
Cc: mingo@kernel.org, mhocko@suse.com, umgwanakikbuti@gmail.com,
        hpa@zytor.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
        matt@codeblueprint.co.uk
Reply-To: tglx@linutronix.de, matt@codeblueprint.co.uk, peterz@infradead.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        umgwanakikbuti@gmail.com, hpa@zytor.com, mhocko@suse.com,
        mingo@kernel.org
In-Reply-To: <20180420095005.GH4064@hirez.programming.kicks-ass.net>
References: <20180420095005.GH4064@hirez.programming.kicks-ass.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] stop_machine, sched: Fix migrate_swap() vs.
 active_balance() deadlock
Git-Commit-ID: 0b26351b910fb8fe6a056f8a1bbccabe50c0e19f
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

Commit-ID:  0b26351b910fb8fe6a056f8a1bbccabe50c0e19f
Gitweb:     https://git.kernel.org/tip/0b26351b910fb8fe6a056f8a1bbccabe50c0e19f
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Fri, 20 Apr 2018 11:50:05 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 3 May 2018 07:38:03 +0200

stop_machine, sched: Fix migrate_swap() vs. active_balance() deadlock

Matt reported the following deadlock:

CPU0					CPU1

schedule(.prev=migrate/0)		<fault>
  pick_next_task()			  ...
    idle_balance()			    migrate_swap()
      active_balance()			      stop_two_cpus()
						spin_lock(stopper0->lock)
						spin_lock(stopper1->lock)
						ttwu(migrate/0)
						  smp_cond_load_acquire() -- waits for schedule()
        stop_one_cpu(1)
	  spin_lock(stopper1->lock) -- waits for stopper lock

Fix this deadlock by taking the wakeups out from under stopper->lock.
This allows the active_balance() to queue the stop work and finish the
context switch, which in turn allows the wakeup from migrate_swap() to
observe the context and complete the wakeup.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reported-by: Matt Fleming <matt@codeblueprint.co.uk>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180420095005.GH4064@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/stop_machine.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index b7591261652d..64c0291b579c 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -21,6 +21,7 @@
 #include <linux/smpboot.h>
 #include <linux/atomic.h>
 #include <linux/nmi.h>
+#include <linux/sched/wake_q.h>
 
 /*
  * Structure to determine completion condition and record errors.  May
@@ -65,27 +66,31 @@ static void cpu_stop_signal_done(struct cpu_stop_done *done)
 }
 
 static void __cpu_stop_queue_work(struct cpu_stopper *stopper,
-					struct cpu_stop_work *work)
+					struct cpu_stop_work *work,
+					struct wake_q_head *wakeq)
 {
 	list_add_tail(&work->list, &stopper->works);
-	wake_up_process(stopper->thread);
+	wake_q_add(wakeq, stopper->thread);
 }
 
 /* queue @work to @stopper.  if offline, @work is completed immediately */
 static bool cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
 {
 	struct cpu_stopper *stopper = &per_cpu(cpu_stopper, cpu);
+	DEFINE_WAKE_Q(wakeq);
 	unsigned long flags;
 	bool enabled;
 
 	spin_lock_irqsave(&stopper->lock, flags);
 	enabled = stopper->enabled;
 	if (enabled)
-		__cpu_stop_queue_work(stopper, work);
+		__cpu_stop_queue_work(stopper, work, &wakeq);
 	else if (work->done)
 		cpu_stop_signal_done(work->done);
 	spin_unlock_irqrestore(&stopper->lock, flags);
 
+	wake_up_q(&wakeq);
+
 	return enabled;
 }
 
@@ -229,6 +234,7 @@ static int cpu_stop_queue_two_works(int cpu1, struct cpu_stop_work *work1,
 {
 	struct cpu_stopper *stopper1 = per_cpu_ptr(&cpu_stopper, cpu1);
 	struct cpu_stopper *stopper2 = per_cpu_ptr(&cpu_stopper, cpu2);
+	DEFINE_WAKE_Q(wakeq);
 	int err;
 retry:
 	spin_lock_irq(&stopper1->lock);
@@ -252,8 +258,8 @@ retry:
 			goto unlock;
 
 	err = 0;
-	__cpu_stop_queue_work(stopper1, work1);
-	__cpu_stop_queue_work(stopper2, work2);
+	__cpu_stop_queue_work(stopper1, work1, &wakeq);
+	__cpu_stop_queue_work(stopper2, work2, &wakeq);
 unlock:
 	spin_unlock(&stopper2->lock);
 	spin_unlock_irq(&stopper1->lock);
@@ -263,6 +269,9 @@ unlock:
 			cpu_relax();
 		goto retry;
 	}
+
+	wake_up_q(&wakeq);
+
 	return err;
 }
 /**
