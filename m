Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 35F6B60767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752506AbeFFNzj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:55:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40758 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751851AbeFFNzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:55:37 -0400
Date: Wed, 6 Jun 2018 14:55:33 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 1/7] atomics/tty: add missing atomic_long_t * cast
Message-ID: <20180606135533.sjv6game4nalmaan@lakrids.cambridge.arm.com>
References: <20180529180746.29684-1-mark.rutland@arm.com>
 <20180529180746.29684-2-mark.rutland@arm.com>
 <20180605120021.GH12258@hirez.programming.kicks-ass.net>
 <20180605142051.GB12925@kroah.com>
 <20180605144304.GW12180@hirez.programming.kicks-ass.net>
 <20180605145334.GA12235@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605145334.GA12235@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 04:53:34PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 05, 2018 at 04:43:04PM +0200, Peter Zijlstra wrote:
> 
> > I can make a proper patch, hold on.
> 
> ---
> Subject: atomic/tty: Fix up atomic abuse in ldsem
> 
> Mark found ldsem_cmpxchg() needed an (atomic_long_t *) cast to keep
> working after making the atomic_long interface type safe.
> 
> Needing casts is bad form, which made me look at the code. There are no
> ld_semaphore::count users outside of these functions so there is no
> reason why it can not be an atomic_long_t in the first place, obviating
> the need for this cast.
> 
> That also ensures the loads use atomic_long_read(), which implies (at
> least) READ_ONCE() in order to guarantee single-copy-atomic loads.
> 
> When using atomic_long_try_cmpxchg() the ldsem_cmpxchg() wrapper gets
> very thin (the only difference is not changing *old on success, which
> most callers don't seem to care about).
> 
> So rework the whole thing to use atomic_long_t and its accessors
> directly.
> 
> While there, fixup all the horrible comment styles.
> 
> Cc: Peter Hurley <peter@hurleysoftware.com>
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Greg, I assume you'll queue this at some point soon.

In the mean time, I've picked this up as part of this series, replacing
my patch with the atomic_long_t cast.

Thanks,
Mark.

> ---
>  drivers/tty/tty_ldsem.c   | 82 ++++++++++++++++++++---------------------------
>  include/linux/tty_ldisc.h |  4 +--
>  2 files changed, 37 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/tty/tty_ldsem.c b/drivers/tty/tty_ldsem.c
> index 37a91b3df980..0c98d88f795a 100644
> --- a/drivers/tty/tty_ldsem.c
> +++ b/drivers/tty/tty_ldsem.c
> @@ -74,28 +74,6 @@ struct ldsem_waiter {
>  	struct task_struct *task;
>  };
>  
> -static inline long ldsem_atomic_update(long delta, struct ld_semaphore *sem)
> -{
> -	return atomic_long_add_return(delta, (atomic_long_t *)&sem->count);
> -}
> -
> -/*
> - * ldsem_cmpxchg() updates @*old with the last-known sem->count value.
> - * Returns 1 if count was successfully changed; @*old will have @new value.
> - * Returns 0 if count was not changed; @*old will have most recent sem->count
> - */
> -static inline int ldsem_cmpxchg(long *old, long new, struct ld_semaphore *sem)
> -{
> -	long tmp = atomic_long_cmpxchg(&sem->count, *old, new);
> -	if (tmp == *old) {
> -		*old = new;
> -		return 1;
> -	} else {
> -		*old = tmp;
> -		return 0;
> -	}
> -}
> -
>  /*
>   * Initialize an ldsem:
>   */
> @@ -109,7 +87,7 @@ void __init_ldsem(struct ld_semaphore *sem, const char *name,
>  	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
>  	lockdep_init_map(&sem->dep_map, name, key, 0);
>  #endif
> -	sem->count = LDSEM_UNLOCKED;
> +	atomic_long_set(&sem->count, LDSEM_UNLOCKED);
>  	sem->wait_readers = 0;
>  	raw_spin_lock_init(&sem->wait_lock);
>  	INIT_LIST_HEAD(&sem->read_wait);
> @@ -122,16 +100,17 @@ static void __ldsem_wake_readers(struct ld_semaphore *sem)
>  	struct task_struct *tsk;
>  	long adjust, count;
>  
> -	/* Try to grant read locks to all readers on the read wait list.
> +	/*
> +	 * Try to grant read locks to all readers on the read wait list.
>  	 * Note the 'active part' of the count is incremented by
>  	 * the number of readers before waking any processes up.
>  	 */
>  	adjust = sem->wait_readers * (LDSEM_ACTIVE_BIAS - LDSEM_WAIT_BIAS);
> -	count = ldsem_atomic_update(adjust, sem);
> +	count = atomic_long_add_return(adjust, &sem->count);
>  	do {
>  		if (count > 0)
>  			break;
> -		if (ldsem_cmpxchg(&count, count - adjust, sem))
> +		if (atomic_long_try_cmpxchg(&sem->count, &count, count - adjust))
>  			return;
>  	} while (1);
>  
> @@ -148,14 +127,15 @@ static void __ldsem_wake_readers(struct ld_semaphore *sem)
>  
>  static inline int writer_trylock(struct ld_semaphore *sem)
>  {
> -	/* only wake this writer if the active part of the count can be
> +	/*
> +	 * Only wake this writer if the active part of the count can be
>  	 * transitioned from 0 -> 1
>  	 */
> -	long count = ldsem_atomic_update(LDSEM_ACTIVE_BIAS, sem);
> +	long count = atomic_long_add_return(LDSEM_ACTIVE_BIAS, &sem->count);
>  	do {
>  		if ((count & LDSEM_ACTIVE_MASK) == LDSEM_ACTIVE_BIAS)
>  			return 1;
> -		if (ldsem_cmpxchg(&count, count - LDSEM_ACTIVE_BIAS, sem))
> +		if (atomic_long_try_cmpxchg(&sem->count, &count, count - LDSEM_ACTIVE_BIAS))
>  			return 0;
>  	} while (1);
>  }
> @@ -205,12 +185,16 @@ down_read_failed(struct ld_semaphore *sem, long count, long timeout)
>  	/* set up my own style of waitqueue */
>  	raw_spin_lock_irq(&sem->wait_lock);
>  
> -	/* Try to reverse the lock attempt but if the count has changed
> +	/*
> +	 * Try to reverse the lock attempt but if the count has changed
>  	 * so that reversing fails, check if there are are no waiters,
> -	 * and early-out if not */
> +	 * and early-out if not
> +	 */
>  	do {
> -		if (ldsem_cmpxchg(&count, count + adjust, sem))
> +		if (atomic_long_try_cmpxchg(&sem->count, &count, count + adjust)) {
> +			count += adjust;
>  			break;
> +		}
>  		if (count > 0) {
>  			raw_spin_unlock_irq(&sem->wait_lock);
>  			return sem;
> @@ -243,12 +227,14 @@ down_read_failed(struct ld_semaphore *sem, long count, long timeout)
>  	__set_current_state(TASK_RUNNING);
>  
>  	if (!timeout) {
> -		/* lock timed out but check if this task was just
> +		/*
> +		 * Lock timed out but check if this task was just
>  		 * granted lock ownership - if so, pretend there
> -		 * was no timeout; otherwise, cleanup lock wait */
> +		 * was no timeout; otherwise, cleanup lock wait.
> +		 */
>  		raw_spin_lock_irq(&sem->wait_lock);
>  		if (waiter.task) {
> -			ldsem_atomic_update(-LDSEM_WAIT_BIAS, sem);
> +			atomic_long_add_return(-LDSEM_WAIT_BIAS, &sem->count);
>  			list_del(&waiter.list);
>  			raw_spin_unlock_irq(&sem->wait_lock);
>  			put_task_struct(waiter.task);
> @@ -273,11 +259,13 @@ down_write_failed(struct ld_semaphore *sem, long count, long timeout)
>  	/* set up my own style of waitqueue */
>  	raw_spin_lock_irq(&sem->wait_lock);
>  
> -	/* Try to reverse the lock attempt but if the count has changed
> +	/*
> +	 * Try to reverse the lock attempt but if the count has changed
>  	 * so that reversing fails, check if the lock is now owned,
> -	 * and early-out if so */
> +	 * and early-out if so.
> +	 */
>  	do {
> -		if (ldsem_cmpxchg(&count, count + adjust, sem))
> +		if (atomic_long_try_cmpxchg(&sem->count, &count, count + adjust))
>  			break;
>  		if ((count & LDSEM_ACTIVE_MASK) == LDSEM_ACTIVE_BIAS) {
>  			raw_spin_unlock_irq(&sem->wait_lock);
> @@ -303,7 +291,7 @@ down_write_failed(struct ld_semaphore *sem, long count, long timeout)
>  	}
>  
>  	if (!locked)
> -		ldsem_atomic_update(-LDSEM_WAIT_BIAS, sem);
> +		atomic_long_add_return(-LDSEM_WAIT_BIAS, &sem->count);
>  	list_del(&waiter.list);
>  	raw_spin_unlock_irq(&sem->wait_lock);
>  
> @@ -324,7 +312,7 @@ static int __ldsem_down_read_nested(struct ld_semaphore *sem,
>  
>  	lockdep_acquire_read(sem, subclass, 0, _RET_IP_);
>  
> -	count = ldsem_atomic_update(LDSEM_READ_BIAS, sem);
> +	count = atomic_long_add_return(LDSEM_READ_BIAS, &sem->count);
>  	if (count <= 0) {
>  		lock_stat(sem, contended);
>  		if (!down_read_failed(sem, count, timeout)) {
> @@ -343,7 +331,7 @@ static int __ldsem_down_write_nested(struct ld_semaphore *sem,
>  
>  	lockdep_acquire(sem, subclass, 0, _RET_IP_);
>  
> -	count = ldsem_atomic_update(LDSEM_WRITE_BIAS, sem);
> +	count = atomic_long_add_return(LDSEM_WRITE_BIAS, &sem->count);
>  	if ((count & LDSEM_ACTIVE_MASK) != LDSEM_ACTIVE_BIAS) {
>  		lock_stat(sem, contended);
>  		if (!down_write_failed(sem, count, timeout)) {
> @@ -370,10 +358,10 @@ int __sched ldsem_down_read(struct ld_semaphore *sem, long timeout)
>   */
>  int ldsem_down_read_trylock(struct ld_semaphore *sem)
>  {
> -	long count = sem->count;
> +	long count = atomic_long_read(&sem->count);
>  
>  	while (count >= 0) {
> -		if (ldsem_cmpxchg(&count, count + LDSEM_READ_BIAS, sem)) {
> +		if (atomic_long_try_cmpxchg(&sem->count, &count, count + LDSEM_READ_BIAS)) {
>  			lockdep_acquire_read(sem, 0, 1, _RET_IP_);
>  			lock_stat(sem, acquired);
>  			return 1;
> @@ -396,10 +384,10 @@ int __sched ldsem_down_write(struct ld_semaphore *sem, long timeout)
>   */
>  int ldsem_down_write_trylock(struct ld_semaphore *sem)
>  {
> -	long count = sem->count;
> +	long count = atomic_long_read(&sem->count);
>  
>  	while ((count & LDSEM_ACTIVE_MASK) == 0) {
> -		if (ldsem_cmpxchg(&count, count + LDSEM_WRITE_BIAS, sem)) {
> +		if (atomic_long_try_cmpxchg(&sem->count, &count, count + LDSEM_WRITE_BIAS)) {
>  			lockdep_acquire(sem, 0, 1, _RET_IP_);
>  			lock_stat(sem, acquired);
>  			return 1;
> @@ -417,7 +405,7 @@ void ldsem_up_read(struct ld_semaphore *sem)
>  
>  	lockdep_release(sem, 1, _RET_IP_);
>  
> -	count = ldsem_atomic_update(-LDSEM_READ_BIAS, sem);
> +	count = atomic_long_add_return(-LDSEM_READ_BIAS, &sem->count);
>  	if (count < 0 && (count & LDSEM_ACTIVE_MASK) == 0)
>  		ldsem_wake(sem);
>  }
> @@ -431,7 +419,7 @@ void ldsem_up_write(struct ld_semaphore *sem)
>  
>  	lockdep_release(sem, 1, _RET_IP_);
>  
> -	count = ldsem_atomic_update(-LDSEM_WRITE_BIAS, sem);
> +	count = atomic_long_add_return(-LDSEM_WRITE_BIAS, &sem->count);
>  	if (count < 0)
>  		ldsem_wake(sem);
>  }
> diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
> index 1ef64d4ad887..840894ca3fc0 100644
> --- a/include/linux/tty_ldisc.h
> +++ b/include/linux/tty_ldisc.h
> @@ -119,13 +119,13 @@
>  
>  #include <linux/fs.h>
>  #include <linux/wait.h>
> -
> +#include <linux/atomic.h>
>  
>  /*
>   * the semaphore definition
>   */
>  struct ld_semaphore {
> -	long			count;
> +	atomic_long_t		count;
>  	raw_spinlock_t		wait_lock;
>  	unsigned int		wait_readers;
>  	struct list_head	read_wait;
> 
