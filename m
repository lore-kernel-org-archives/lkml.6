Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755955AbeDZMfx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:35:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40527 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755346AbeDZMfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:35:51 -0400
X-Google-Smtp-Source: AIpwx48RMZXX0KV1//0f5wuncCI0DYPqNDfaphhAOCgfmhTqMfzl00FXODThu3sg605xFA9/56e2Bw==
Date: Thu, 26 Apr 2018 14:35:42 +0200
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, oleg@redhat.com,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, mhocko@suse.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, ebiederm@xmission.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 4/4] exit: Lockless iteration over task list in
 mm_update_next_owner()
Message-ID: <20180426123542.GA819@andrea>
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
 <152474046779.29458.5294808258041953930.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152474046779.29458.5294808258041953930.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

On Thu, Apr 26, 2018 at 02:01:07PM +0300, Kirill Tkhai wrote:
> The patch finalizes the series and makes mm_update_next_owner()
> to iterate over task list using RCU instead of tasklist_lock.
> This is possible because of rules of inheritance of mm: it may be
> propagated to a child only, while only kernel thread can obtain
> someone else's mm via use_mm().
> 
> Also, all new tasks are added to tail of tasks list or threads list.
> The only exception is transfer_pid() in de_thread(), when group
> leader is replaced by another thread. But transfer_pid() is called
> in case of successful exec only, where new mm is allocated, so it
> can't be interesting for mm_update_next_owner().
> 
> This patch uses alloc_pid() as a memory barrier, and it's possible
> since it contains two or more spin_lock()/spin_unlock() pairs.
> Single pair does not imply a barrier, while two pairs do imply that.
> 
> There are three barriers:
> 
> 1)for_each_process(g)            copy_process()
>                                    p->mm = mm
>     smp_rmb();                     smp_wmb() implied by alloc_pid()
>     if (g->flags & PF_KTHREAD)     list_add_tail_rcu(&p->tasks, &init_task.tasks)
> 
> 2)for_each_thread(g, c)          copy_process()
>                                    p->mm = mm
>     smp_rmb();                     smp_wmb() implied by alloc_pid()
>     tmp = READ_ONCE(c->mm)         list_add_tail_rcu(&p->thread_node, ...)
> 
> 3)for_each_thread(g, c)          copy_process()
>                                    list_add_tail_rcu(&p->thread_node, ...)
>     p->mm != NULL check          do_exit()
>     smp_rmb()                      smp_mb();
>     get next thread in loop      p->mm = NULL
> 
> 
> This patch may be useful for machines with many processes executing.
> I regulary observe mm_update_next_owner() executing on one of the cpus
> in crash dumps (not related to this function) on big machines. Even
> if iteration over task list looks as unlikely situation, it regularity
> grows with the growth of containers/processes numbers.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  kernel/exit.c |   39 +++++++++++++++++++++++++++++++++++----
>  kernel/fork.c |    1 +
>  kernel/pid.c  |    5 ++++-
>  3 files changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 40f734ed1193..7ce4cdf96a64 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -406,6 +406,8 @@ kill_orphaned_pgrp(struct task_struct *tsk, struct task_struct *parent)
>  void mm_update_next_owner(struct mm_struct *mm)
>  {
>  	struct task_struct *c, *g, *p = current;
> +	struct mm_struct *tmp;
> +	struct list_head *n;
>  
>  retry:
>  	/*
> @@ -440,21 +442,49 @@ void mm_update_next_owner(struct mm_struct *mm)
>  		if (c->mm == mm)
>  			goto new_owner;
>  	}
> +	read_unlock(&tasklist_lock);
>  
>  	/*
>  	 * Search through everything else, we should not get here often.
>  	 */
> +	rcu_read_lock();
>  	for_each_process(g) {
> +		/*
> +		 * g->signal, g->mm and g->flags initialization of a just
> +		 * created task must not reorder with linking the task to
> +		 * tasks list. Pairs with smp_mb() implied by alloc_pid().
> +		 */
> +		smp_rmb();
>  		if (g->flags & PF_KTHREAD)
>  			continue;
>  		for_each_thread(g, c) {
> -			if (c->mm == mm)
> -				goto new_owner;
> -			if (c->mm)
> +			/*
> +			 * Make visible mm of iterated thread.
> +			 * Pairs with smp_mb() implied by alloc_pid().
> +			 */
> +			if (c != g)
> +				smp_rmb();
> +			tmp = READ_ONCE(c->mm);
> +			if (tmp == mm)
> +				goto new_owner_nolock;
> +			if (likely(tmp))
>  				break;
> +			n = READ_ONCE(c->thread_node.next);
> +			/*
> +			 * All mm are NULL, so iterated threads already exited.
> +			 * Make sure we see their children.
> +			 * Pairs with smp_mb() in do_exit().
> +			 */
> +			if (n == &g->signal->thread_head)
> +				smp_rmb();
>  		}
> +		/*
> +		 * Children of exited thread group are visible due to the above
> +		 * smp_rmb(). Threads with mm != NULL can't create a child with
> +		 * the mm we're looking for. So, no additional smp_rmb() needed.
> +		 */
>  	}
> -	read_unlock(&tasklist_lock);
> +	rcu_read_unlock();
>  	/*
>  	 * We found no owner yet mm_users > 1: this implies that we are
>  	 * most likely racing with swapoff (try_to_unuse()) or /proc or
> @@ -466,6 +496,7 @@ void mm_update_next_owner(struct mm_struct *mm)
>  new_owner:
>  	rcu_read_lock();
>  	read_unlock(&tasklist_lock);
> +new_owner_nolock:
>  	BUG_ON(c == p);
>  
>  	/*
> diff --git a/kernel/fork.c b/kernel/fork.c
> index a5d21c42acfc..2032d4657546 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1805,6 +1805,7 @@ static __latent_entropy struct task_struct *copy_process(
>  		goto bad_fork_cleanup_io;
>  
>  	if (pid != &init_struct_pid) {
> +		/* Successfuly returned, this function imply smp_mb() */
>  		pid = alloc_pid(p->nsproxy->pid_ns_for_children);
>  		if (IS_ERR(pid)) {
>  			retval = PTR_ERR(pid);
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 157fe4b19971..cb96473aa058 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -155,7 +155,10 @@ void free_pid(struct pid *pid)
>  
>  	call_rcu(&pid->rcu, delayed_put_pid);
>  }
> -
> +/*
> + * This function contains at least two sequential spin_lock()/spin_unlock(),
> + * and together they imply full memory barrier.

Mmh, it's possible that I am misunderstanding this statement but it does
not seem quite correct to me; a counter-example would be provided by the
test at "tools/memory-model/litmus-tests/SB+mbonceonces.litmus" (replace
either of the smp_mb() with the sequence:

   spin_lock(s); spin_unlock(s); spin_lock(s); spin_unlock(s); ).

BTW, your commit message suggests that your case would work with "imply
an smp_wmb()".  This implication should hold "w.r.t. current implementa-
tions".  We (LKMM people) discussed changes to the LKMM to make it hold
in LKMM but such changes are still in our TODO list as of today...

  Andrea


> + */
>  struct pid *alloc_pid(struct pid_namespace *ns)
>  {
>  	struct pid *pid;
> 
