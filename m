Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbeFEMAo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:00:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33912 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbeFEMAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:00:31 -0400
Date: Tue, 5 Jun 2018 14:00:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH 1/7] atomics/tty: add missing atomic_long_t * cast
Message-ID: <20180605120021.GH12258@hirez.programming.kicks-ass.net>
References: <20180529180746.29684-1-mark.rutland@arm.com>
 <20180529180746.29684-2-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529180746.29684-2-mark.rutland@arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 07:07:40PM +0100, Mark Rutland wrote:
> In ldsem_cmpxchg a pointer to unsigned long is passed to
> atomic_long_cmpxchg(), which expects a pointer to atomic_long_t.

> -	long tmp = atomic_long_cmpxchg(&sem->count, *old, new);
> +	long tmp = atomic_long_cmpxchg((atomic_long_t *)&sem->count, *old, new);

Needing to cast anything to atomic types is dodgy at best, so I had me a
look at this code.

Would not the following patch be much better?

---
 drivers/tty/tty_ldsem.c   | 82 ++++++++++++++++++++---------------------------
 include/linux/tty_ldisc.h |  4 +--
 2 files changed, 37 insertions(+), 49 deletions(-)

diff --git a/drivers/tty/tty_ldsem.c b/drivers/tty/tty_ldsem.c
index 37a91b3df980..0c98d88f795a 100644
--- a/drivers/tty/tty_ldsem.c
+++ b/drivers/tty/tty_ldsem.c
@@ -74,28 +74,6 @@ struct ldsem_waiter {
 	struct task_struct *task;
 };
 
-static inline long ldsem_atomic_update(long delta, struct ld_semaphore *sem)
-{
-	return atomic_long_add_return(delta, (atomic_long_t *)&sem->count);
-}
-
-/*
- * ldsem_cmpxchg() updates @*old with the last-known sem->count value.
- * Returns 1 if count was successfully changed; @*old will have @new value.
- * Returns 0 if count was not changed; @*old will have most recent sem->count
- */
-static inline int ldsem_cmpxchg(long *old, long new, struct ld_semaphore *sem)
-{
-	long tmp = atomic_long_cmpxchg(&sem->count, *old, new);
-	if (tmp == *old) {
-		*old = new;
-		return 1;
-	} else {
-		*old = tmp;
-		return 0;
-	}
-}
-
 /*
  * Initialize an ldsem:
  */
@@ -109,7 +87,7 @@ void __init_ldsem(struct ld_semaphore *sem, const char *name,
 	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
 	lockdep_init_map(&sem->dep_map, name, key, 0);
 #endif
-	sem->count = LDSEM_UNLOCKED;
+	atomic_long_set(&sem->count, LDSEM_UNLOCKED);
 	sem->wait_readers = 0;
 	raw_spin_lock_init(&sem->wait_lock);
 	INIT_LIST_HEAD(&sem->read_wait);
@@ -122,16 +100,17 @@ static void __ldsem_wake_readers(struct ld_semaphore *sem)
 	struct task_struct *tsk;
 	long adjust, count;
 
-	/* Try to grant read locks to all readers on the read wait list.
+	/*
+	 * Try to grant read locks to all readers on the read wait list.
 	 * Note the 'active part' of the count is incremented by
 	 * the number of readers before waking any processes up.
 	 */
 	adjust = sem->wait_readers * (LDSEM_ACTIVE_BIAS - LDSEM_WAIT_BIAS);
-	count = ldsem_atomic_update(adjust, sem);
+	count = atomic_long_add_return(adjust, &sem->count);
 	do {
 		if (count > 0)
 			break;
-		if (ldsem_cmpxchg(&count, count - adjust, sem))
+		if (atomic_long_try_cmpxchg(&sem->count, &count, count - adjust))
 			return;
 	} while (1);
 
@@ -148,14 +127,15 @@ static void __ldsem_wake_readers(struct ld_semaphore *sem)
 
 static inline int writer_trylock(struct ld_semaphore *sem)
 {
-	/* only wake this writer if the active part of the count can be
+	/*
+	 * Only wake this writer if the active part of the count can be
 	 * transitioned from 0 -> 1
 	 */
-	long count = ldsem_atomic_update(LDSEM_ACTIVE_BIAS, sem);
+	long count = atomic_long_add_return(LDSEM_ACTIVE_BIAS, &sem->count);
 	do {
 		if ((count & LDSEM_ACTIVE_MASK) == LDSEM_ACTIVE_BIAS)
 			return 1;
-		if (ldsem_cmpxchg(&count, count - LDSEM_ACTIVE_BIAS, sem))
+		if (atomic_long_try_cmpxchg(&sem->count, &count, count - LDSEM_ACTIVE_BIAS))
 			return 0;
 	} while (1);
 }
@@ -205,12 +185,16 @@ down_read_failed(struct ld_semaphore *sem, long count, long timeout)
 	/* set up my own style of waitqueue */
 	raw_spin_lock_irq(&sem->wait_lock);
 
-	/* Try to reverse the lock attempt but if the count has changed
+	/*
+	 * Try to reverse the lock attempt but if the count has changed
 	 * so that reversing fails, check if there are are no waiters,
-	 * and early-out if not */
+	 * and early-out if not
+	 */
 	do {
-		if (ldsem_cmpxchg(&count, count + adjust, sem))
+		if (atomic_long_try_cmpxchg(&sem->count, &count, count + adjust)) {
+			count += adjust;
 			break;
+		}
 		if (count > 0) {
 			raw_spin_unlock_irq(&sem->wait_lock);
 			return sem;
@@ -243,12 +227,14 @@ down_read_failed(struct ld_semaphore *sem, long count, long timeout)
 	__set_current_state(TASK_RUNNING);
 
 	if (!timeout) {
-		/* lock timed out but check if this task was just
+		/*
+		 * Lock timed out but check if this task was just
 		 * granted lock ownership - if so, pretend there
-		 * was no timeout; otherwise, cleanup lock wait */
+		 * was no timeout; otherwise, cleanup lock wait.
+		 */
 		raw_spin_lock_irq(&sem->wait_lock);
 		if (waiter.task) {
-			ldsem_atomic_update(-LDSEM_WAIT_BIAS, sem);
+			atomic_long_add_return(-LDSEM_WAIT_BIAS, &sem->count);
 			list_del(&waiter.list);
 			raw_spin_unlock_irq(&sem->wait_lock);
 			put_task_struct(waiter.task);
@@ -273,11 +259,13 @@ down_write_failed(struct ld_semaphore *sem, long count, long timeout)
 	/* set up my own style of waitqueue */
 	raw_spin_lock_irq(&sem->wait_lock);
 
-	/* Try to reverse the lock attempt but if the count has changed
+	/*
+	 * Try to reverse the lock attempt but if the count has changed
 	 * so that reversing fails, check if the lock is now owned,
-	 * and early-out if so */
+	 * and early-out if so.
+	 */
 	do {
-		if (ldsem_cmpxchg(&count, count + adjust, sem))
+		if (atomic_long_try_cmpxchg(&sem->count, &count, count + adjust))
 			break;
 		if ((count & LDSEM_ACTIVE_MASK) == LDSEM_ACTIVE_BIAS) {
 			raw_spin_unlock_irq(&sem->wait_lock);
@@ -303,7 +291,7 @@ down_write_failed(struct ld_semaphore *sem, long count, long timeout)
 	}
 
 	if (!locked)
-		ldsem_atomic_update(-LDSEM_WAIT_BIAS, sem);
+		atomic_long_add_return(-LDSEM_WAIT_BIAS, &sem->count);
 	list_del(&waiter.list);
 	raw_spin_unlock_irq(&sem->wait_lock);
 
@@ -324,7 +312,7 @@ static int __ldsem_down_read_nested(struct ld_semaphore *sem,
 
 	lockdep_acquire_read(sem, subclass, 0, _RET_IP_);
 
-	count = ldsem_atomic_update(LDSEM_READ_BIAS, sem);
+	count = atomic_long_add_return(LDSEM_READ_BIAS, &sem->count);
 	if (count <= 0) {
 		lock_stat(sem, contended);
 		if (!down_read_failed(sem, count, timeout)) {
@@ -343,7 +331,7 @@ static int __ldsem_down_write_nested(struct ld_semaphore *sem,
 
 	lockdep_acquire(sem, subclass, 0, _RET_IP_);
 
-	count = ldsem_atomic_update(LDSEM_WRITE_BIAS, sem);
+	count = atomic_long_add_return(LDSEM_WRITE_BIAS, &sem->count);
 	if ((count & LDSEM_ACTIVE_MASK) != LDSEM_ACTIVE_BIAS) {
 		lock_stat(sem, contended);
 		if (!down_write_failed(sem, count, timeout)) {
@@ -370,10 +358,10 @@ int __sched ldsem_down_read(struct ld_semaphore *sem, long timeout)
  */
 int ldsem_down_read_trylock(struct ld_semaphore *sem)
 {
-	long count = sem->count;
+	long count = atomic_long_read(&sem->count);
 
 	while (count >= 0) {
-		if (ldsem_cmpxchg(&count, count + LDSEM_READ_BIAS, sem)) {
+		if (atomic_long_try_cmpxchg(&sem->count, &count, count + LDSEM_READ_BIAS)) {
 			lockdep_acquire_read(sem, 0, 1, _RET_IP_);
 			lock_stat(sem, acquired);
 			return 1;
@@ -396,10 +384,10 @@ int __sched ldsem_down_write(struct ld_semaphore *sem, long timeout)
  */
 int ldsem_down_write_trylock(struct ld_semaphore *sem)
 {
-	long count = sem->count;
+	long count = atomic_long_read(&sem->count);
 
 	while ((count & LDSEM_ACTIVE_MASK) == 0) {
-		if (ldsem_cmpxchg(&count, count + LDSEM_WRITE_BIAS, sem)) {
+		if (atomic_long_try_cmpxchg(&sem->count, &count, count + LDSEM_WRITE_BIAS)) {
 			lockdep_acquire(sem, 0, 1, _RET_IP_);
 			lock_stat(sem, acquired);
 			return 1;
@@ -417,7 +405,7 @@ void ldsem_up_read(struct ld_semaphore *sem)
 
 	lockdep_release(sem, 1, _RET_IP_);
 
-	count = ldsem_atomic_update(-LDSEM_READ_BIAS, sem);
+	count = atomic_long_add_return(-LDSEM_READ_BIAS, &sem->count);
 	if (count < 0 && (count & LDSEM_ACTIVE_MASK) == 0)
 		ldsem_wake(sem);
 }
@@ -431,7 +419,7 @@ void ldsem_up_write(struct ld_semaphore *sem)
 
 	lockdep_release(sem, 1, _RET_IP_);
 
-	count = ldsem_atomic_update(-LDSEM_WRITE_BIAS, sem);
+	count = atomic_long_add_return(-LDSEM_WRITE_BIAS, &sem->count);
 	if (count < 0)
 		ldsem_wake(sem);
 }
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index 1ef64d4ad887..840894ca3fc0 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -119,13 +119,13 @@
 
 #include <linux/fs.h>
 #include <linux/wait.h>
-
+#include <linux/atomic.h>
 
 /*
  * the semaphore definition
  */
 struct ld_semaphore {
-	long			count;
+	atomic_long_t		count;
 	raw_spinlock_t		wait_lock;
 	unsigned int		wait_readers;
 	struct list_head	read_wait;
