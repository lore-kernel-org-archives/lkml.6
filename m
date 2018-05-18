Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751958AbeERMkh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 08:40:37 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41585 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbeERMke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 08:40:34 -0400
X-Google-Smtp-Source: AB8JxZrnHDdyPLnxCvER4pocdXSNHtvmcn0yksG/obP99lESJJSgl8jbS1yIEtEpwCHnn9dyKnFafQ==
Date: Fri, 18 May 2018 08:40:29 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH 04/10] locking: export osq_lock()/osq_unlock()
Message-ID: <20180518124029.GC16943@kmo-pixel>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
 <20180518074918.13816-9-kent.overstreet@gmail.com>
 <20180518095204.GF12217@hirez.programming.kicks-ass.net>
 <20180518101804.GB15403@kmo-pixel>
 <20180518110808.GH12217@hirez.programming.kicks-ass.net>
 <20180518113205.GA16943@kmo-pixel>
 <20180518114054.GJ12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518114054.GJ12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 01:40:54PM +0200, Peter Zijlstra wrote:
> On Fri, May 18, 2018 at 07:32:05AM -0400, Kent Overstreet wrote:
> > It does strike me that the whole optimistic spin algorithm
> > (mutex_optimistic_spin() and rwsem_optimistic_spin()) are ripe for factoring
> > out. They've been growing more optimizations I see, and the optimizations mostly
> > aren't specific to either locks.
> 
> There's a few unfortunate differences between the two; but yes it would
> be good if we could reduce some of the duplication found there.
> 
> One of the distinct differences is that mutex (now) has the lock state
> and owner in a single atomic word, while rwsem still tracks the owner in
> a separate word and thus needs to account for 'inconsistent' owner
> state.
> 
> And then there's warts such as ww_mutex and rwsem_owner_is_reader and
> similar.

The rwsem code seems workable, osq_optimistic_spin() takes callback for trylock
and get_owner - I just added a OWNER_NO_SPIN value that get_owner() can return.

The mutex code though... wtf...


commit 5c7defe81ee722f5087cbeda9be6e7ee715515d7
Author: Kent Overstreet <kent.overstreet@gmail.com>
Date:   Fri May 18 08:35:55 2018 -0400

    Factor out osq_optimistic_spin()

diff --git a/fs/bcachefs/six.c b/fs/bcachefs/six.c
index afa59a476a..dbaf52abef 100644
--- a/fs/bcachefs/six.c
+++ b/fs/bcachefs/six.c
@@ -1,5 +1,6 @@
 
 #include <linux/log2.h>
+#include <linux/osq_optimistic_spin.h>
 #include <linux/preempt.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
@@ -146,127 +147,26 @@ struct six_lock_waiter {
 /* This is probably up there with the more evil things I've done */
 #define waitlist_bitnr(id) ilog2((((union six_lock_state) { .waiters = 1 << (id) }).l))
 
-#ifdef CONFIG_LOCK_SPIN_ON_OWNER
-
-static inline int six_can_spin_on_owner(struct six_lock *lock)
-{
-	struct task_struct *owner;
-	int retval = 1;
-
-	if (need_resched())
-		return 0;
-
-	rcu_read_lock();
-	owner = READ_ONCE(lock->owner);
-	if (owner)
-		retval = owner->on_cpu;
-	rcu_read_unlock();
-	/*
-	 * if lock->owner is not set, the mutex owner may have just acquired
-	 * it and not set the owner yet or the mutex has been released.
-	 */
-	return retval;
-}
-
-static inline bool six_spin_on_owner(struct six_lock *lock,
-				     struct task_struct *owner)
+static inline struct task_struct *six_osq_get_owner(struct optimistic_spin_queue *osq)
 {
-	bool ret = true;
-
-	rcu_read_lock();
-	while (lock->owner == owner) {
-		/*
-		 * Ensure we emit the owner->on_cpu, dereference _after_
-		 * checking lock->owner still matches owner. If that fails,
-		 * owner might point to freed memory. If it still matches,
-		 * the rcu_read_lock() ensures the memory stays valid.
-		 */
-		barrier();
-
-		if (!owner->on_cpu || need_resched()) {
-			ret = false;
-			break;
-		}
-
-		cpu_relax();
-	}
-	rcu_read_unlock();
+	struct six_lock *lock = container_of(osq, struct six_lock, osq);
 
-	return ret;
+	return lock->owner;
 }
 
-static inline bool six_optimistic_spin(struct six_lock *lock, enum six_lock_type type)
+static inline bool six_osq_trylock_read(struct optimistic_spin_queue *osq)
 {
-	struct task_struct *task = current;
-
-	if (type == SIX_LOCK_write)
-		return false;
-
-	preempt_disable();
-	if (!six_can_spin_on_owner(lock))
-		goto fail;
-
-	if (!osq_lock(&lock->osq))
-		goto fail;
-
-	while (1) {
-		struct task_struct *owner;
-
-		/*
-		 * If there's an owner, wait for it to either
-		 * release the lock or go to sleep.
-		 */
-		owner = READ_ONCE(lock->owner);
-		if (owner && !six_spin_on_owner(lock, owner))
-			break;
+	struct six_lock *lock = container_of(osq, struct six_lock, osq);
 
-		if (do_six_trylock_type(lock, type)) {
-			osq_unlock(&lock->osq);
-			preempt_enable();
-			return true;
-		}
-
-		/*
-		 * When there's no owner, we might have preempted between the
-		 * owner acquiring the lock and setting the owner field. If
-		 * we're an RT task that will live-lock because we won't let
-		 * the owner complete.
-		 */
-		if (!owner && (need_resched() || rt_task(task)))
-			break;
-
-		/*
-		 * The cpu_relax() call is a compiler barrier which forces
-		 * everything in this loop to be re-loaded. We don't need
-		 * memory barriers as we'll eventually observe the right
-		 * values at the cost of a few extra spins.
-		 */
-		cpu_relax();
-	}
-
-	osq_unlock(&lock->osq);
-fail:
-	preempt_enable();
-
-	/*
-	 * If we fell out of the spin path because of need_resched(),
-	 * reschedule now, before we try-lock again. This avoids getting
-	 * scheduled out right after we obtained the lock.
-	 */
-	if (need_resched())
-		schedule();
-
-	return false;
+	return do_six_trylock_type(lock, SIX_LOCK_read);
 }
 
-#else /* CONFIG_LOCK_SPIN_ON_OWNER */
-
-static inline bool six_optimistic_spin(struct six_lock *lock, enum six_lock_type type)
+static inline bool six_osq_trylock_intent(struct optimistic_spin_queue *osq)
 {
-	return false;
-}
+	struct six_lock *lock = container_of(osq, struct six_lock, osq);
 
-#endif
+	return do_six_trylock_type(lock, SIX_LOCK_intent);
+}
 
 noinline
 static void __six_lock_type_slowpath(struct six_lock *lock, enum six_lock_type type)
@@ -276,8 +176,20 @@ static void __six_lock_type_slowpath(struct six_lock *lock, enum six_lock_type t
 	struct six_lock_waiter wait;
 	u64 v;
 
-	if (six_optimistic_spin(lock, type))
-		return;
+	switch (type) {
+	case SIX_LOCK_read:
+		if (osq_optimistic_spin(&lock->osq, six_osq_get_owner,
+					six_osq_trylock_read))
+			return;
+		break;
+	case SIX_LOCK_intent:
+		if (osq_optimistic_spin(&lock->osq, six_osq_get_owner,
+					six_osq_trylock_intent))
+			return;
+		break;
+	case SIX_LOCK_write:
+		break;
+	}
 
 	lock_contended(&lock->dep_map, _RET_IP_);
 
diff --git a/include/linux/osq_optimistic_spin.h b/include/linux/osq_optimistic_spin.h
new file mode 100644
index 0000000000..1f5fd1f85b
--- /dev/null
+++ b/include/linux/osq_optimistic_spin.h
@@ -0,0 +1,155 @@
+#ifndef __LINUX_OSQ_OPTIMISTIC_SPIN_H
+#define __LINUX_OSQ_OPTIMISTIC_SPIN_H
+
+#include <linux/sched.h>
+#include <linux/sched/rt.h>
+
+#ifdef CONFIG_LOCK_SPIN_ON_OWNER
+
+typedef struct task_struct *(*osq_get_owner_fn)(struct optimistic_spin_queue *osq);
+typedef bool (*osq_trylock_fn)(struct optimistic_spin_queue *osq);
+
+#define OWNER_NO_SPIN		((struct task_struct *) 1UL)
+
+static inline bool osq_can_spin_on_owner(struct optimistic_spin_queue *lock,
+					 osq_get_owner_fn get_owner)
+{
+	struct task_struct *owner;
+	bool ret;
+
+	if (need_resched())
+		return false;
+
+	rcu_read_lock();
+	owner = get_owner(lock);
+	/*
+	 * if lock->owner is not set, the lock owner may have just acquired
+	 * it and not set the owner yet, or it may have just been unlocked
+	 */
+	if (!owner)
+		ret = true;
+	else if (owner == OWNER_NO_SPIN)
+		ret = false;
+	else
+		ret = owner->on_cpu != 0;
+	rcu_read_unlock();
+
+	return ret;
+}
+
+static inline bool osq_spin_on_owner(struct optimistic_spin_queue *lock,
+				     struct task_struct *owner,
+				     osq_get_owner_fn get_owner)
+{
+	if (!owner)
+		return true;
+
+	if (owner == OWNER_NO_SPIN)
+		return false;
+
+	while (1) {
+		/*
+		 * Ensure we emit the owner->on_cpu, dereference _after_
+		 * checking lock->owner still matches owner. If that fails,
+		 * owner might point to freed memory. If it still matches,
+		 * the rcu_read_lock() ensures the memory stays valid.
+		 */
+		barrier();
+		if (get_owner(lock) != owner)
+			return true;
+
+		if (!owner->on_cpu || need_resched() ||
+		    vcpu_is_preempted(task_cpu(owner)))
+			return false;
+
+		cpu_relax();
+	}
+}
+
+static inline bool osq_optimistic_spin(struct optimistic_spin_queue *lock,
+				       osq_get_owner_fn get_owner,
+				       osq_trylock_fn trylock)
+{
+	struct task_struct *task = current;
+
+	preempt_disable();
+	if (!osq_can_spin_on_owner(lock, get_owner))
+		goto fail;
+
+	if (!osq_lock(lock))
+		goto fail;
+
+	while (1) {
+		struct task_struct *owner;
+
+		/*
+		 * If there's an owner, wait for it to either
+		 * release the lock or go to sleep.
+		 */
+		rcu_read_lock();
+		owner = get_owner(lock);
+		if (!osq_spin_on_owner(lock, owner, get_owner)) {
+			rcu_read_unlock();
+			break;
+		}
+		rcu_read_unlock();
+
+		if (trylock(lock)) {
+			osq_unlock(lock);
+			preempt_enable();
+			return true;
+		}
+
+		/*
+		 * When there's no owner, we might have preempted between the
+		 * owner acquiring the lock and setting the owner field. If
+		 * we're an RT task that will live-lock because we won't let
+		 * the owner complete.
+		 */
+		if (!owner && (need_resched() || rt_task(task)))
+			break;
+
+		/*
+		 * The cpu_relax() call is a compiler barrier which forces
+		 * everything in this loop to be re-loaded. We don't need
+		 * memory barriers as we'll eventually observe the right
+		 * values at the cost of a few extra spins.
+		 */
+		cpu_relax();
+	}
+
+	osq_unlock(lock);
+fail:
+	preempt_enable();
+
+	/*
+	 * If we fell out of the spin path because of need_resched(),
+	 * reschedule now, before we try-lock again. This avoids getting
+	 * scheduled out right after we obtained the lock.
+	 */
+	if (need_resched())
+		schedule();
+
+	return false;
+}
+
+static inline bool osq_has_spinner(struct optimistic_spin_queue *lock)
+{
+	return osq_is_locked(lock);
+}
+
+#else /* CONFIG_LOCK_SPIN_ON_OWNER */
+
+static inline bool osq_optimistic_spin(struct six_lock *lock, enum six_lock_type type)
+{
+	return false;
+}
+
+static inline bool osq_has_spinner(struct optimistic_spin_queue *lock)
+{
+	return false;
+}
+
+#endif
+
+#endif /* __LINUX_OSQ_OPTIMISTIC_SPIN_H */
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index e795908f36..a25ee6668f 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -13,6 +13,7 @@
 #include <linux/rwsem.h>
 #include <linux/init.h>
 #include <linux/export.h>
+#include <linux/osq_optimistic_spin.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/rt.h>
 #include <linux/sched/wake_q.h>
@@ -325,11 +326,21 @@ static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem)
 }
 
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
+
+static inline struct task_struct *rwsem_osq_get_owner(struct optimistic_spin_queue *osq)
+{
+	struct rw_semaphore *sem = container_of(osq, struct rw_semaphore, osq);
+	struct task_struct *owner = READ_ONCE(sem->owner);
+
+	return rwsem_owner_is_reader(owner) ? OWNER_NO_SPIN : owner;
+}
+
 /*
  * Try to acquire write lock before the writer has been put on wait queue.
  */
-static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
+static inline bool rwsem_osq_trylock(struct optimistic_spin_queue *osq)
 {
+	struct rw_semaphore *sem = container_of(osq, struct rw_semaphore, osq);
 	long old, count = atomic_long_read(&sem->count);
 
 	while (true) {
@@ -347,125 +358,10 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
 	}
 }
 
-static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
-{
-	struct task_struct *owner;
-	bool ret = true;
-
-	if (need_resched())
-		return false;
-
-	rcu_read_lock();
-	owner = READ_ONCE(sem->owner);
-	if (!rwsem_owner_is_writer(owner)) {
-		/*
-		 * Don't spin if the rwsem is readers owned.
-		 */
-		ret = !rwsem_owner_is_reader(owner);
-		goto done;
-	}
-
-	/*
-	 * As lock holder preemption issue, we both skip spinning if task is not
-	 * on cpu or its cpu is preempted
-	 */
-	ret = owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
-done:
-	rcu_read_unlock();
-	return ret;
-}
-
-/*
- * Return true only if we can still spin on the owner field of the rwsem.
- */
-static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
-{
-	struct task_struct *owner = READ_ONCE(sem->owner);
-
-	if (!rwsem_owner_is_writer(owner))
-		goto out;
-
-	rcu_read_lock();
-	while (sem->owner == owner) {
-		/*
-		 * Ensure we emit the owner->on_cpu, dereference _after_
-		 * checking sem->owner still matches owner, if that fails,
-		 * owner might point to free()d memory, if it still matches,
-		 * the rcu_read_lock() ensures the memory stays valid.
-		 */
-		barrier();
-
-		/*
-		 * abort spinning when need_resched or owner is not running or
-		 * owner's cpu is preempted.
-		 */
-		if (!owner->on_cpu || need_resched() ||
-				vcpu_is_preempted(task_cpu(owner))) {
-			rcu_read_unlock();
-			return false;
-		}
-
-		cpu_relax();
-	}
-	rcu_read_unlock();
-out:
-	/*
-	 * If there is a new owner or the owner is not set, we continue
-	 * spinning.
-	 */
-	return !rwsem_owner_is_reader(READ_ONCE(sem->owner));
-}
-
 static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 {
-	bool taken = false;
-
-	preempt_disable();
-
-	/* sem->wait_lock should not be held when doing optimistic spinning */
-	if (!rwsem_can_spin_on_owner(sem))
-		goto done;
-
-	if (!osq_lock(&sem->osq))
-		goto done;
-
-	/*
-	 * Optimistically spin on the owner field and attempt to acquire the
-	 * lock whenever the owner changes. Spinning will be stopped when:
-	 *  1) the owning writer isn't running; or
-	 *  2) readers own the lock as we can't determine if they are
-	 *     actively running or not.
-	 */
-	while (rwsem_spin_on_owner(sem)) {
-		/*
-		 * Try to acquire the lock
-		 */
-		if (rwsem_try_write_lock_unqueued(sem)) {
-			taken = true;
-			break;
-		}
-
-		/*
-		 * When there's no owner, we might have preempted between the
-		 * owner acquiring the lock and setting the owner field. If
-		 * we're an RT task that will live-lock because we won't let
-		 * the owner complete.
-		 */
-		if (!sem->owner && (need_resched() || rt_task(current)))
-			break;
-
-		/*
-		 * The cpu_relax() call is a compiler barrier which forces
-		 * everything in this loop to be re-loaded. We don't need
-		 * memory barriers as we'll eventually observe the right
-		 * values at the cost of a few extra spins.
-		 */
-		cpu_relax();
-	}
-	osq_unlock(&sem->osq);
-done:
-	preempt_enable();
-	return taken;
+	return osq_optimistic_spin(&sem->osq, rwsem_osq_get_owner,
+				   rwsem_osq_trylock);
 }
 
 /*
