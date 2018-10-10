Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF283C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF36214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF36214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=santannapisa.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeJJSFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:05:09 -0400
Received: from mail.santannapisa.it ([193.205.80.99]:26919 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeJJSFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:05:08 -0400
X-Greylist: delayed 549 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Oct 2018 14:05:06 EDT
Received: from [10.30.3.207] (account l.abeni@santannapisa.it HELO luca64)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 133569294; Wed, 10 Oct 2018 12:43:32 +0200
Date:   Wed, 10 Oct 2018 12:43:28 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFD/RFC PATCH 3/8] locking/mutex: Rework
 task_struct::blocked_on
Message-ID: <20181010124328.16052fd3@luca64>
In-Reply-To: <20181009092434.26221-4-juri.lelli@redhat.com>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
        <20181009092434.26221-4-juri.lelli@redhat.com>
Organization: Scuola Superiore S. Anna
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue,  9 Oct 2018 11:24:29 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:

> From: Peter Zijlstra <peterz@infradead.org>
> 
> Track the blocked-on relation for mutexes, this allows following this
> relation at schedule time. Add blocked_task to track the inverse
> relation.
> 
>                 ,-> task
>                 |     | blocked-on
>                 |     v
>    blocked-task |   mutex
>                 |     | owner
>                 |     v
>                 `-- task

I was a little bit confused by this description, because (if I
understand the code well) blocked_task does not actually track the
inverse of the "blocked_on" relationship, but just points to the task
that is _currently_ acting as a proxy for a given task.

In theory, we could have multiple tasks blocked on "mutex" (which is
owned by "task"), so if "blocked_task" tracked the inverse of
"blocked_on" it should have been a list (or a data structure containing
pointers to multiple task structures), no?

I would propose to change "blocked_task" into something like
"current_proxy", or similar, which should be more clear (unless I
completely misunderstood this stuff... In that case, sorry about the
noise)


Also, I suspect that this "blocked_task" (or "current_proxy") field
should be introcuced in patch 5 (same for the "task_is_blocked()"
function from patch 4... Should it go in patch 5?)

				Luca
> 
> This patch only enables blocked-on relation, blocked-task will be
> enabled in a later patch implementing proxy().
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> [minor changes while rebasing]
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>  include/linux/sched.h        | 6 ++----
>  kernel/fork.c                | 6 +++---
>  kernel/locking/mutex-debug.c | 7 +++----
>  kernel/locking/mutex.c       | 3 +++
>  4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 977cb57d7bc9..a35e8ab3eef1 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -907,10 +907,8 @@ struct task_struct {
>  	struct rt_mutex_waiter		*pi_blocked_on;
>  #endif
>  
> -#ifdef CONFIG_DEBUG_MUTEXES
> -	/* Mutex deadlock detection: */
> -	struct mutex_waiter		*blocked_on;
> -#endif
> +	struct task_struct 	*blocked_task;	/* task
> that's boosting us */
> +	struct mutex 		*blocked_on;	/* lock
> we're blocked on */ 
>  #ifdef CONFIG_TRACE_IRQFLAGS
>  	unsigned int			irq_events;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index f0b58479534f..ef27a675b0d7 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1827,9 +1827,9 @@ static __latent_entropy struct task_struct
> *copy_process( lockdep_init_task(p);
>  #endif
>  
> -#ifdef CONFIG_DEBUG_MUTEXES
> -	p->blocked_on = NULL; /* not blocked yet */
> -#endif
> +	p->blocked_task = NULL; /* nobody is boosting us yet*/
> +	p->blocked_on = NULL;  /* not blocked yet */
> +
>  #ifdef CONFIG_BCACHE
>  	p->sequential_io	= 0;
>  	p->sequential_io_avg	= 0;
> diff --git a/kernel/locking/mutex-debug.c
> b/kernel/locking/mutex-debug.c index a660d38b6c29..6605e083a3e9 100644
> --- a/kernel/locking/mutex-debug.c
> +++ b/kernel/locking/mutex-debug.c
> @@ -53,8 +53,8 @@ void debug_mutex_add_waiter(struct mutex *lock,
> struct mutex_waiter *waiter, {
>  	SMP_DEBUG_LOCKS_WARN_ON(!raw_spin_is_locked(&lock->wait_lock));
>  
> -	/* Mark the current thread as blocked on the lock: */
> -	task->blocked_on = waiter;
> +	/* Current thread can't be alredy blocked (since it's
> executing!) */
> +	DEBUG_LOCKS_WARN_ON(task->blocked_on);
>  }
>  
>  void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter
> *waiter, @@ -62,8 +62,7 @@ void mutex_remove_waiter(struct mutex
> *lock, struct mutex_waiter *waiter, {
>  	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
>  	DEBUG_LOCKS_WARN_ON(waiter->task != task);
> -	DEBUG_LOCKS_WARN_ON(task->blocked_on != waiter);
> -	task->blocked_on = NULL;
> +	DEBUG_LOCKS_WARN_ON(task->blocked_on != lock);
>  
>  	list_del_init(&waiter->list);
>  	waiter->task = NULL;
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index f37402cd8496..76b59b555da3 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -979,6 +979,7 @@ __mutex_lock_common(struct mutex *lock, long
> state, unsigned int subclass, }
>  
>  	waiter.task = current;
> +	current->blocked_on = lock;
>  
>  	set_current_state(state);
>  	for (;;) {
> @@ -1047,6 +1048,8 @@ __mutex_lock_common(struct mutex *lock, long
> state, unsigned int subclass, }
>  
>  	mutex_remove_waiter(lock, &waiter, current);
> +	current->blocked_on = NULL;
> +
>  	if (likely(list_empty(&lock->wait_list)))
>  		__mutex_clear_flag(lock, MUTEX_FLAGS);
>  

