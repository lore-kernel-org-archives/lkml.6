Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753310AbeEOSDL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:03:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57240 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbeEOSDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:03:09 -0400
Date: Tue, 15 May 2018 20:02:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Oleg Nesterov <oleg@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 1/2] locking/rwsem: Add a new RWSEM_ANONYMOUSLY_OWNED
 flag
Message-ID: <20180515180256.GO12217@hirez.programming.kicks-ass.net>
References: <1526405884-4860-1-git-send-email-longman@redhat.com>
 <1526405884-4860-2-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526405884-4860-2-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 01:38:03PM -0400, Waiman Long wrote:
> diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
> index e795908..a27dbb4 100644
> --- a/kernel/locking/rwsem-xadd.c
> +++ b/kernel/locking/rwsem-xadd.c
> @@ -357,11 +357,8 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
>  
>  	rcu_read_lock();
>  	owner = READ_ONCE(sem->owner);
> -	if (!rwsem_owner_is_writer(owner)) {
> -		/*
> -		 * Don't spin if the rwsem is readers owned.
> -		 */
> -		ret = !rwsem_owner_is_reader(owner);
> +	if (!owner || !is_rwsem_owner_spinnable(owner)) {
> +		ret = !owner;	/* !owner is spinnable */
>  		goto done;
>  	}
>  
> @@ -382,8 +379,10 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
>  {
>  	struct task_struct *owner = READ_ONCE(sem->owner);
>  
> -	if (!rwsem_owner_is_writer(owner))
> -		goto out;
> +	if (!owner)
> +		return true;
> +	else if (!is_rwsem_owner_spinnable(owner))
> +		return false;

s/else //

>  	rcu_read_lock();
>  	while (sem->owner == owner) {
> @@ -408,12 +407,12 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
>  		cpu_relax();
>  	}
>  	rcu_read_unlock();
> -out:
> +
>  	/*
>  	 * If there is a new owner or the owner is not set, we continue
>  	 * spinning.
>  	 */
> -	return !rwsem_owner_is_reader(READ_ONCE(sem->owner));
> +	return is_rwsem_owner_spinnable(READ_ONCE(sem->owner));
>  }

The above two cases have explicit owner tests, this one doesn't.

Now I know it works, but maybe:

	return !owner || is_rwsem_owner_spinnable(owner);

is easier to read... dunno.
