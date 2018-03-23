Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeCWPlC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:41:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41649 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbeCWPlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:41:01 -0400
Date: Fri, 23 Mar 2018 16:40:57 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, Daniel Wagner <wagi@monom.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH RT] kernel/time/posix-timer: avoid schedule() while holding
 the RCU lock
Message-ID: <20180323154057.pptgxusdgfb2h6ag@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On -RT it is possible that an invocation of timer_set() or
timer_delete() preempts an itimer which results in TIMER_RETRY. We can't
retry immediately because if the process preempted the softirq then it
has a higher priority and will loop and retry forever.

As a workaround for -RT the "retry" thread waited for the hrtimer to
complete (hrtimer_wait_for_timer()) or left the CPU via
schedule_timeout() in case of CPU-timer.
During hrtimer_wait_for_timer() the timer could be removed (and memory
freed) which would result in use-after-free for the waiter (in
hrtimer_wait_for_timer()). Therefore the RCU read section has been
extended to cover the whole period while the thread is scheduled out.
This change is part of 8df8ef7b2b9b ("hrtimers: Prepare full
preemption") in the RT patch.

This behaviour ("sleeping" while holding the RCU lock) is reported since
commit 5b72f9643b52 ("rcu: Complain if blocking in preemptible RCU
read-side critical section") and both Daniel Wagner and Grygorii
Strashko noticed [0] it.

I revert the RCU read section to what we had before. I am adding a
`kref' object to avoid removal of the itimer (incl. the hrtimer) while
there is someone waiting on it. This looks simple in timer_settime() and
timer_delete(). We had one lookup, hold the lock, increment ref-count.
If timer is deleted the waiter does the final put and the following RCU
lookup will fail.

I don't understand why the RCU lock is also held in itimer_delete(). At
this point, the process is dead (even exit_signals() was invoked) and
there is nothing that can remove that timer. timer_delete() and
timer_settime() always lookups the timer via its id during the retry.
This is not the case for itimer_delete() which gets a struct k_itimer
handed over. The comment says that "on RT it might race against
deletion" but I have no idea where it might come from.
While I understand why timer_delete() sets
	timer->it_signal = NULL
I don't know why itimer_delete() does the same. At this point there
should be no lookup or removal happen via RCU. Also ->list is protected
via sighand->siglock which is not held at this point. I *think* this was
just copied from the above (timer_delete()) while the timer were
accidently per-thread and fixed in commit 0e568881178f ("fix
posix-timers to have proper per-process scope").

[0] https://lkml.kernel.org/r/ec8b4367-ef5b-5446-2cd0-9f8f7fd6954f@monom.org
[1] https://git.kernel.org/history/history/c/0e568881178ff0e0aceeafdb51f9fecab39e1923

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/posix-timers.h |  1 +
 kernel/time/posix-timers.c   | 41 +++++++++++++++++++++++++----------------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 672c4f32311e..b4cac3d8da1b 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -78,6 +78,7 @@ struct k_itimer {
 	struct list_head	list;
 	struct hlist_node	t_hash;
 	spinlock_t		it_lock;
+	struct kref		kref;
 	const struct k_clock	*kclock;
 	clockid_t		it_clock;
 	timer_t			it_id;
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 0b568087bd64..77fdd050016d 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -465,6 +465,7 @@ static struct k_itimer * alloc_posix_timer(void)
 		return NULL;
 	}
 	memset(&tmr->sigq->info, 0, sizeof(siginfo_t));
+	kref_init(&tmr->kref);
 	return tmr;
 }
 
@@ -475,6 +476,23 @@ static void k_itimer_rcu_free(struct rcu_head *head)
 	kmem_cache_free(posix_timers_cache, tmr);
 }
 
+static void kitimer_get(struct k_itimer *timer)
+{
+	kref_get(&timer->kref);
+}
+
+static void kitimer_release(struct kref *kref)
+{
+	struct k_itimer *tmr = container_of(kref, struct k_itimer, kref);
+
+	call_rcu(&tmr->it.rcu, k_itimer_rcu_free);
+}
+
+static void kitimer_put(struct k_itimer *timer)
+{
+	kref_put(&timer->kref, kitimer_release);
+}
+
 #define IT_ID_SET	1
 #define IT_ID_NOT_SET	0
 static void release_posix_timer(struct k_itimer *tmr, int it_id_set)
@@ -487,7 +505,7 @@ static void release_posix_timer(struct k_itimer *tmr, int it_id_set)
 	}
 	put_pid(tmr->it_pid);
 	sigqueue_free(tmr->sigq);
-	call_rcu(&tmr->it.rcu, k_itimer_rcu_free);
+	kitimer_put(tmr);
 }
 
 static int common_timer_create(struct k_itimer *new_timer)
@@ -904,7 +922,7 @@ static int do_timer_settime(timer_t timer_id, int flags,
 	if (!timr)
 		return -EINVAL;
 
-	rcu_read_lock();
+	kitimer_get(timr);
 	kc = timr->kclock;
 	if (WARN_ON_ONCE(!kc || !kc->timer_set))
 		error = -EINVAL;
@@ -914,12 +932,11 @@ static int do_timer_settime(timer_t timer_id, int flags,
 	unlock_timer(timr, flag);
 	if (error == TIMER_RETRY) {
 		timer_wait_for_callback(kc, timr);
+		kitimer_put(timr);
 		old_spec64 = NULL;	// We already got the old time...
-		rcu_read_unlock();
 		goto retry;
 	}
-	rcu_read_unlock();
-
+	kitimer_put(timr);
 	return error;
 }
 
@@ -1000,15 +1017,15 @@ SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
 	if (!timer)
 		return -EINVAL;
 
-	rcu_read_lock();
 	if (timer_delete_hook(timer) == TIMER_RETRY) {
+		kitimer_get(timer);
 		unlock_timer(timer, flags);
+
 		timer_wait_for_callback(clockid_to_kclock(timer->it_clock),
 					timer);
-		rcu_read_unlock();
+		kitimer_put(timer);
 		goto retry_delete;
 	}
-	rcu_read_unlock();
 
 	spin_lock(&current->sighand->siglock);
 	list_del(&timer->list);
@@ -1034,18 +1051,10 @@ static void itimer_delete(struct k_itimer *timer)
 retry_delete:
 	spin_lock_irqsave(&timer->it_lock, flags);
 
-	/* On RT we can race with a deletion */
-	if (!timer->it_signal) {
-		unlock_timer(timer, flags);
-		return;
-	}
-
 	if (timer_delete_hook(timer) == TIMER_RETRY) {
-		rcu_read_lock();
 		unlock_timer(timer, flags);
 		timer_wait_for_callback(clockid_to_kclock(timer->it_clock),
 					timer);
-		rcu_read_unlock();
 		goto retry_delete;
 	}
 	list_del(&timer->list);
-- 
2.16.2
