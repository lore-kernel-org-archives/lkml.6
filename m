Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbeDDOkM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 10:40:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751255AbeDDOkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 10:40:11 -0400
Subject: Re: [PATCH] locking/rwsem: Add up_write_non_owner() for
 percpu_up_write()
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Oleg Nesterov <oleg@redhat.com>
References: <1522852646-2196-1-git-send-email-longman@redhat.com>
To: "Theodore Y. Ts'o" <tytso@mit.edu>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <7745dbe3-f9c0-d624-e692-0d4320c0627a@redhat.com>
Date: Wed, 4 Apr 2018 10:40:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1522852646-2196-1-git-send-email-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2018 10:37 AM, Waiman Long wrote:
> The commit 8c5db92a705d ("locking/rwsem: Add DEBUG_RWSEMS to look for
> lock/unlock mismatches") causes a warning in ext4 fstests due to the
> fact that the freeze and thaw ioctls, by design, are run in different
> processes. This is not a bug in the commit itself. Rather, we need a
> up_write() variant that annotates the fact that it can be called from
> a task different from the one that took the lock.
>
> The new API is up_write_non_owner() and the percpu_up_write() function
> is modified to use it instead of the plain up_write().
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/rwsem.h         |  6 ++++++
>  kernel/locking/percpu-rwsem.c |  4 +++-
>  kernel/locking/rwsem.c        | 13 +++++++++++++
>  3 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
> index 56707d5..0e2a425 100644
> --- a/include/linux/rwsem.h
> +++ b/include/linux/rwsem.h
> @@ -187,4 +187,10 @@ static inline int rwsem_is_contended(struct rw_semaphore *sem)
>  # define up_read_non_owner(sem)			up_read(sem)
>  #endif
>  
> +#ifdef CONFIG_DEBUG_RWSEMS
> +extern void up_write_non_owner(struct rw_semaphore *sem);
> +#else
> +# define up_write_non_owner(sem)	up_write(sem)
> +#endif
> +
>  #endif /* _LINUX_RWSEM_H */
> diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
> index 883cf1b..13decf2 100644
> --- a/kernel/locking/percpu-rwsem.c
> +++ b/kernel/locking/percpu-rwsem.c
> @@ -179,8 +179,10 @@ void percpu_up_write(struct percpu_rw_semaphore *sem)
>  
>  	/*
>  	 * Release the write lock, this will allow readers back in the game.
> +	 * percpu_up_write() may be called from a task different from the one
> +	 * taking the lock.
>  	 */
> -	up_write(&sem->rw_sem);
> +	up_write_non_owner(&sem->rw_sem);
>  
>  	/*
>  	 * Once this completes (at least one RCU-sched grace period hence) the
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 30465a2..140d5ef 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -222,4 +222,17 @@ void up_read_non_owner(struct rw_semaphore *sem)
>  
>  #endif
>  
> +#ifdef CONFIG_DEBUG_RWSEMS
> +/*
> + * release a write lock from a different task
> + */
> +void up_write_non_owner(struct rw_semaphore *sem)
> +{
> +	rwsem_release(&sem->dep_map, 1, _RET_IP_);
> +	DEBUG_RWSEMS_WARN_ON(!sem->owner || (sem->owner == RWSEM_READER_OWNED));
>  
> +	rwsem_clear_owner(sem);
> +	__up_write(sem);
> +}
> +EXPORT_SYMBOL(up_write_non_owner);
> +#endif

Theodore,

Could you try this patch to see if it can fix your fstests warning?

Thanks,
Longman
