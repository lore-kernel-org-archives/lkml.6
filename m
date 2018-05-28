Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753152AbeE1FTk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 01:19:40 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33208 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbeE1FTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 01:19:37 -0400
X-Google-Smtp-Source: ADUXVKIGyH75RqJaczrFjC6yqok6W71OsP9yyTlYel+peb47lJQYPm+Z0slZ4dE8vg1FZWEDU0B4kQ==
Date: Sun, 27 May 2018 22:19:36 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, Davidlohr Bueso <dave@stgolabs.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, Peter Chang <dpf@google.com>,
        Deepa Dinamani <deepadinamani@google.com>,
        John Sperbeck <jsperbeck@google.com>
Subject: Re: [PATCH v3 1/2] rtmutex: allow specifying a subclass for nested
 locking
Message-ID: <20180528051936.GA205298@joelaf.mtv.corp.google.com>
References: <CAFNjLiXZk3Zigfpy9Hj2uY92sPGB7msUxoZHf6pFDOWSuBwkBA@mail.gmail.com>
 <20180524135240.10881-1-peda@axentia.se>
 <20180524135240.10881-2-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524135240.10881-2-peda@axentia.se>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 03:52:39PM +0200, Peter Rosin wrote:
> Needed for annotating rt_mutex locks.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  include/linux/rtmutex.h  |  7 +++++++
>  kernel/locking/rtmutex.c | 29 +++++++++++++++++++++++++----
>  2 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
> index 1b92a28dd672..6fd615a0eea9 100644
> --- a/include/linux/rtmutex.h
> +++ b/include/linux/rtmutex.h
> @@ -106,7 +106,14 @@ static inline int rt_mutex_is_locked(struct rt_mutex *lock)
>  extern void __rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key);
>  extern void rt_mutex_destroy(struct rt_mutex *lock);
>  
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +extern void rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass);
> +#define rt_mutex_lock(lock) rt_mutex_lock_nested(lock, 0)
> +#else
>  extern void rt_mutex_lock(struct rt_mutex *lock);
> +#define rt_mutex_lock_nested(lock, subclass) rt_mutex_lock(lock)
> +#endif
> +
>  extern int rt_mutex_lock_interruptible(struct rt_mutex *lock);
>  extern int rt_mutex_timed_lock(struct rt_mutex *lock,
>  			       struct hrtimer_sleeper *timeout);
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
:
>  }
>  
> +static inline void __rt_mutex_lock(struct rt_mutex *lock, unsigned int subclass)
> +{
> +	might_sleep();
> +
> +	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
> +	rt_mutex_fastlock(lock, TASK_UNINTERRUPTIBLE, rt_mutex_slowlock);
> +}
> +
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +/**
> + * rt_mutex_lock_nested - lock a rt_mutex

This ifdef seems consistent with other nested locking primitives, but its
kind of confusing.

The Kconfig.debug for DEBUG_LOCK_ALLOC says:

config DEBUG_LOCK_ALLOC
	bool "Lock debugging: detect incorrect freeing of live locks"
	[...]
	help
	 This feature will check whether any held lock (spinlock, rwlock,
	 mutex or rwsem) is incorrectly freed by the kernel, via any of the
	 memory-freeing routines (kfree(), kmem_cache_free(), free_pages(),
	 vfree(), etc.), whether a live lock is incorrectly reinitialized via
	 spin_lock_init()/mutex_init()/etc., or whether there is any lock
	 held during task exit.

Shouldn't this ideally be ifdef'd under PROVE_LOCKING for this and other
locking primitives? Any idea what's the reason? I know PROVE_LOCKING selects
DEBUG_LOCK_ALLOC but still..

thanks!

- Joel
 
