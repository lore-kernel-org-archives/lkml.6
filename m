Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754290AbeDTJuQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:50:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47982 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754282AbeDTJuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:50:15 -0400
Date: Fri, 20 Apr 2018 11:50:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: cpu stopper threads and load balancing leads to deadlock
Message-ID: <20180420095005.GH4064@hirez.programming.kicks-ass.net>
References: <20180417142119.GA4511@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417142119.GA4511@codeblueprint.co.uk>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 03:21:19PM +0100, Matt Fleming wrote:
> Hi guys,
> 
> We've seen a bug in one of our SLE kernels where the cpu stopper
> thread ("migration/15") is entering idle balance. This then triggers
> active load balance.
> 
> At the same time, a task on another CPU triggers a page fault and NUMA
> balancing kicks in to try and migrate the task closer to the NUMA node
> for that page (we're inside stop_two_cpus()). This faulting task is
> spinning in try_to_wake_up() (inside smp_cond_load_acquire(&p->on_cpu,
> !VAL)), waiting for "migration/15" to context switch.
> 
> Unfortunately, because "migration/15" is doing active load balance
> it's spinning waiting for the NUMA-page-faulting CPU's stopper lock,
> which is already held (since it's inside stop_two_cpus()).
> 
> Deadlock ensues.


So if I read that right, something like the following happens:

CPU0					CPU1

schedule(.prev=migrate/0)		<fault>
  pick_next_task			  ...
    idle_balance			    migrate_swap()
      active_balance			      stop_two_cpus()
						spin_lock(stopper0->lock)
						spin_lock(stopper1->lock)
						ttwu(migrate/0)
						  smp_cond_load_acquire() -- waits for schedule()
        stop_one_cpu(1)
	  spin_lock(stopper1->lock) -- waits for stopper lock


Fix _this_ deadlock by taking out the wakeups from under stopper->lock.
I'm not entirely sure there isn't more dragons here, but this particular
one seems fixable by doing that.

Is there any way you can reproduce/test this?

Maybe-signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
@@ -252,8 +258,8 @@ static int cpu_stop_queue_two_works(int cpu1, struct cpu_stop_work *work1,
 			goto unlock;
 
 	err = 0;
-	__cpu_stop_queue_work(stopper1, work1);
-	__cpu_stop_queue_work(stopper2, work2);
+	__cpu_stop_queue_work(stopper1, work1, &wakeq);
+	__cpu_stop_queue_work(stopper2, work2, &wakeq);
 unlock:
 	spin_unlock(&stopper2->lock);
 	spin_unlock_irq(&stopper1->lock);
@@ -263,6 +269,9 @@ static int cpu_stop_queue_two_works(int cpu1, struct cpu_stop_work *work1,
 			cpu_relax();
 		goto retry;
 	}
+
+	wake_up_q(&wakeq);
+
 	return err;
 }
 /**
