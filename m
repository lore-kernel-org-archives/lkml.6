Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbeDILUT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:20:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751464AbeDILUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 07:20:17 -0400
Date: Mon, 9 Apr 2018 13:20:13 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] locking/rwsem: Add up_write_non_owner() for
 percpu_up_write()
Message-ID: <20180409112013.GA23240@redhat.com>
References: <1522852646-2196-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522852646-2196-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04, Waiman Long wrote:
>
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

Hmm. Can you look at lockdep_sb_freeze_release() and lockdep_sb_freeze_acquire()?

At first glance, it would be much better to set sem->owner = current in
percpu_rwsem_acquire(), no?

Oleg.
