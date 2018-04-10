Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeDJQlb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 12:41:31 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:47161 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbeDJQlU (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 10 Apr 2018 12:41:20 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org
Cc: longman@redhat.com, dave@stgolabs.net, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbues@suse.de>
Subject: [PATCH 2/2] rtmutex: Reduce top-waiter blocking on a lock
Date: Tue, 10 Apr 2018 09:27:50 -0700
Message-Id: <20180410162750.8290-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180410162750.8290-1-dave@stgolabs.net>
References: <20180410162750.8290-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By applying well known spin-on-lock-owner techniques, we can avoid the
blocking overhead during the process of when the task is trying to take
the rtmutex. The idea is that as long as the owner is running, there is a
fair chance it'll release the lock soon, and thus a task trying to acquire
the rtmutex will better off spinning instead of blocking immediately after
the fastpath. This is similar to what we use for other locks, borrowed
from -rt. The main difference (due to the obvious realtime constraints)
is that top-waiter spinning must account for any new higher priority waiter,
and therefore cannot steal the lock and avoid any pi-dance. As such there
will be at most only one spinner waiter upon contended lock.

Conditions to stop spinning and block are simple:

(1) Upon need_resched()
(2) Current lock owner blocks
(3) The top-waiter has changed while spinning.

The unlock side remains unchanged as wake_up_process can safely deal with
calls where the task is not actually blocked (TASK_NORMAL). As such, there
is only unnecessary overhead dealing with the wake_q, but this allows us not
to miss any wakeups between the spinning step and the unlocking side.

Passes running the pi_stress program with increasing thread-group counts.

Signed-off-by: Davidlohr Bueso <dbues@suse.de>
---
 kernel/Kconfig.locks     |  6 ++++-
 kernel/locking/rtmutex.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 84d882f3e299..42d330e0557f 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -227,13 +227,17 @@ config MUTEX_SPIN_ON_OWNER
 	def_bool y
 	depends on SMP && ARCH_SUPPORTS_ATOMIC_RMW
 
+config RT_MUTEX_SPIN_ON_OWNER
+	def_bool y
+	depends on SMP && RT_MUTEXES && !DEBUG_RT_MUTEXES && ARCH_SUPPORTS_ATOMIC_RMW
+
 config RWSEM_SPIN_ON_OWNER
        def_bool y
        depends on SMP && RWSEM_XCHGADD_ALGORITHM && ARCH_SUPPORTS_ATOMIC_RMW
 
 config LOCK_SPIN_ON_OWNER
        def_bool y
-       depends on MUTEX_SPIN_ON_OWNER || RWSEM_SPIN_ON_OWNER
+       depends on MUTEX_SPIN_ON_OWNER || RWSEM_SPIN_ON_OWNER || RT_MUTEX_SPIN_ON_OWNER
 
 config ARCH_USE_QUEUED_SPINLOCKS
 	bool
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 4f014be7a4b8..772ca39e67e7 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1154,6 +1154,55 @@ void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
 	waiter->task = NULL;
 }
 
+#ifdef CONFIG_RT_MUTEX_SPIN_ON_OWNER
+static bool rt_mutex_spin_on_owner(struct rt_mutex *lock,
+				   struct rt_mutex_waiter *waiter,
+				   struct task_struct *owner)
+{
+	bool ret = true;
+
+	/*
+	 * The last owner could have just released the lock,
+	 * immediately try taking it again.
+	 */
+	if (!owner)
+		goto done;
+
+	rcu_read_lock();
+	while (rt_mutex_owner(lock) == owner) {
+		/*
+		 * Ensure we emit the owner->on_cpu, dereference _after_
+		 * checking lock->owner still matches owner. If that fails,
+		 * owner might point to freed memory. If it still matches,
+		 * the rcu_read_lock() ensures the memory stays valid.
+		 *
+		 * Also account for changes in the lock's top-waiter, if it's
+		 * not us, it was updated while busy waiting.
+		 */
+		barrier();
+
+		if (!owner->on_cpu || need_resched() ||
+		    waiter != rt_mutex_top_waiter(lock)) {
+			ret = false;
+			break;
+		}
+
+		cpu_relax();
+	}
+	rcu_read_unlock();
+done:
+	return ret;
+}
+
+#else
+static bool rt_mutex_spin_on_owner(struct rt_mutex *lock,
+				   struct rt_mutex_waiter *waiter,
+				   struct task_struct *owner)
+{
+	return false;
+}
+#endif
+
 /**
  * __rt_mutex_slowlock() - Perform the wait-wake-try-to-take loop
  * @lock:		 the rt_mutex to take
@@ -1172,6 +1221,8 @@ __rt_mutex_slowlock(struct rt_mutex *lock, int state,
 	int ret = 0;
 
 	for (;;) {
+		struct rt_mutex_waiter *top_waiter = NULL;
+
 		/* Try to acquire the lock: */
 		if (try_to_take_rt_mutex(lock, current, waiter))
 			break;
@@ -1190,11 +1241,20 @@ __rt_mutex_slowlock(struct rt_mutex *lock, int state,
 				break;
 		}
 
+		top_waiter = rt_mutex_top_waiter(lock);
 		raw_spin_unlock_irq(&lock->wait_lock);
 
 		debug_rt_mutex_print_deadlock(waiter);
 
-		schedule();
+		/*
+		 * At this point the PI-dance is done, and, as the top waiter,
+		 * we are next in line for the lock. Try to spin on the current
+		 * owner for a while, in the hope that the lock will be released
+		 * soon. Otherwise fallback and block.
+		 */
+		if (top_waiter != waiter ||
+		    !rt_mutex_spin_on_owner(lock, waiter, rt_mutex_owner(lock)))
+			schedule();
 
 		raw_spin_lock_irq(&lock->wait_lock);
 		set_current_state(state);
-- 
2.13.6
