Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751067AbeCILEZ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 06:04:25 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41030 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbeCILEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 06:04:23 -0500
Date: Fri, 9 Mar 2018 12:04:18 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Corey Minyard <cminyard@mvista.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: Warning from swake_up_all in 4.14.15-rt13 non-RT
Message-ID: <20180309110418.lwtennjqwqcxh422@linutronix.de>
References: <dd6ad0b5-569b-067d-257f-dbf15ffa7077@mvista.com>
 <20180306174604.nta5rcvfvrfdfftz@linutronix.de>
 <1704d817-8fb9-ce8f-1aa1-fe6e8b0c3919@mvista.com>
 <20180308174103.mduy5qq2ttlcvig3@linutronix.de>
 <a11f140e-c44f-f967-1cd4-d8a6f09d4d29@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <a11f140e-c44f-f967-1cd4-d8a6f09d4d29@mvista.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-08 13:54:17 [-0600], Corey Minyard wrote:
> > It will work but I don't think pushing this into workqueue/tasklet is a
> > good idea. You want to wakeup all waiters on waitqueue X (probably one
> > waiter) and instead there is one one wakeup + ctx-switch which does the
> > final wakeup.
> 
> True, but this is an uncommon and already fairly expensive operation being
> done.  Adding a context switch doesn't seem that bad.

still no need to make it more expensive if it can be avoided.

> > But now I had an idea: swake_up_all() could iterate over list and
> > instead performing wakes it would just wake_q_add() the tasks. Drop the
> > lock and then wake_up_q(). So in case there is wakeup pending and the
> > task removed itself from the list then the task may observe a spurious
> > wakeup.
> 
> That sounds promising, but where does wake_up_q() get called?  No matter
> what
> it's an expensive operation and I'm not sure where you would put it in this
> case.

Look at this:

Subject: [RFC PATCH RT] sched/swait: use WAKE_Q for possible multiple wake ups

Corey Minyard reported swake_up_all() invocation with disabled
interrupts with the RT patch applied but disabled (low latency config).
The reason why swake_up_all() avoids the irqsafe variant is because it
shouldn't be called from IRQ-disabled section. The idea was to wake up
one task after the other, enable interrupts (and drop the lock) during
the wake ups so we can schedule away in case a task with a higher
priority was just waken up.
In RT we have swait based completions so I kind of needed a complete()
which could wake multiple sleepers without dropping the lock and
enabling interrupts.
To work around this shortcoming I propose to use WAKE_Q. swake_up_all()
will queue all to be woken up tasks on wake-queue with interrupts
disabled which should be "quick". After dropping the lock (and enabling
interrupts) it can wake the tasks one after the other.

Reported-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/swait.h     |  4 +++-
 kernel/sched/completion.c |  5 ++++-
 kernel/sched/swait.c      | 35 ++++++++++-------------------------
 3 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/include/linux/swait.h b/include/linux/swait.h
index 853f3e61a9f4..929721cffdb3 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -148,7 +148,9 @@ static inline bool swq_has_sleeper(struct swait_queue_head *wq)
 extern void swake_up(struct swait_queue_head *q);
 extern void swake_up_all(struct swait_queue_head *q);
 extern void swake_up_locked(struct swait_queue_head *q);
-extern void swake_up_all_locked(struct swait_queue_head *q);
+
+struct wake_q_head;
+extern void swake_add_all_wq(struct swait_queue_head *q, struct wake_q_head *wq);
 
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
 extern void prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait, int state);
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 0fe2982e46a0..461d992e30f9 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -15,6 +15,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
 #include <linux/completion.h>
+#include <linux/sched/wake_q.h>
 
 /**
  * complete: - signals a single thread waiting on this completion
@@ -65,11 +66,13 @@ EXPORT_SYMBOL(complete);
 void complete_all(struct completion *x)
 {
 	unsigned long flags;
+	DEFINE_WAKE_Q(wq);
 
 	raw_spin_lock_irqsave(&x->wait.lock, flags);
 	x->done = UINT_MAX;
-	swake_up_all_locked(&x->wait);
+	swake_add_all_wq(&x->wait, &wq);
 	raw_spin_unlock_irqrestore(&x->wait.lock, flags);
+	wake_up_q(&wq);
 }
 EXPORT_SYMBOL(complete_all);
 
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index b14638a05ec9..1a09cc425bd8 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -2,6 +2,7 @@
 #include <linux/sched/signal.h>
 #include <linux/swait.h>
 #include <linux/suspend.h>
+#include <linux/sched/wake_q.h>
 
 void __init_swait_queue_head(struct swait_queue_head *q, const char *name,
 			     struct lock_class_key *key)
@@ -31,24 +32,19 @@ void swake_up_locked(struct swait_queue_head *q)
 }
 EXPORT_SYMBOL(swake_up_locked);
 
-void swake_up_all_locked(struct swait_queue_head *q)
+void swake_add_all_wq(struct swait_queue_head *q, struct wake_q_head *wq)
 {
 	struct swait_queue *curr;
-	int wakes = 0;
 
 	while (!list_empty(&q->task_list)) {
 
 		curr = list_first_entry(&q->task_list, typeof(*curr),
 					task_list);
-		wake_up_process(curr->task);
 		list_del_init(&curr->task_list);
-		wakes++;
+		wake_q_add(wq, curr->task);
 	}
-	if (pm_in_action)
-		return;
-	WARN(wakes > 2, "complete_all() with %d waiters\n", wakes);
 }
-EXPORT_SYMBOL(swake_up_all_locked);
+EXPORT_SYMBOL(swake_add_all_wq);
 
 void swake_up(struct swait_queue_head *q)
 {
@@ -66,25 +62,14 @@ EXPORT_SYMBOL(swake_up);
  */
 void swake_up_all(struct swait_queue_head *q)
 {
-	struct swait_queue *curr;
-	LIST_HEAD(tmp);
+	unsigned long flags;
+	DEFINE_WAKE_Q(wq);
 
-	WARN_ON(irqs_disabled());
-	raw_spin_lock_irq(&q->lock);
-	list_splice_init(&q->task_list, &tmp);
-	while (!list_empty(&tmp)) {
-		curr = list_first_entry(&tmp, typeof(*curr), task_list);
+	raw_spin_lock_irqsave(&q->lock, flags);
+	swake_add_all_wq(q, &wq);
+	raw_spin_unlock_irqrestore(&q->lock, flags);
 
-		wake_up_state(curr->task, TASK_NORMAL);
-		list_del_init(&curr->task_list);
-
-		if (list_empty(&tmp))
-			break;
-
-		raw_spin_unlock_irq(&q->lock);
-		raw_spin_lock_irq(&q->lock);
-	}
-	raw_spin_unlock_irq(&q->lock);
+	wake_up_q(&wq);
 }
 EXPORT_SYMBOL(swake_up_all);
 

> I had another idea.  This is only occurring if RT is not enabled, because
> with
> RT all the irq disable things go away and you are generally running in task
> context.  So why not have a different version of swake_up_all() for non-RT
> that does work from irqs-off context?

With the patch above I have puzzle part which would allow to use swait
based completions upstream. That ifdef would probably not help.

> -corey

Sebastian
