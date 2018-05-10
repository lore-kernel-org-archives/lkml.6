Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757290AbeEJMPi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 08:15:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757069AbeEJMPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 08:15:37 -0400
Date: Thu, 10 May 2018 14:15:32 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, keescook@chromium.org, riel@redhat.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, dhowells@redhat.com,
        rppt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        Balbir Singh <balbir@linux.vnet.ibm.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC][PATCH] cgroup: Don't mess with tasks in exec
Message-ID: <20180510121531.GA29222@redhat.com>
References: <87r2mrh4is.fsf@xmission.com>
 <20180504145435.GA26573@redhat.com>
 <87y3gzfmjt.fsf@xmission.com>
 <20180504162209.GB26573@redhat.com>
 <871serfk77.fsf@xmission.com>
 <20180507143358.GA3071@redhat.com>
 <87vabyvnw0.fsf@xmission.com>
 <20180509144016.GA25742@redhat.com>
 <87vabwp5p6.fsf@xmission.com>
 <871sekp378.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871sekp378.fsf_-_@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09, Eric W. Biederman wrote:
>
> Semantically exec is supposed to be atomic with no user space visible
> intermediate points. Migrating tasks during exec may change that and
> lead to all manner of difficult to analyze and maintin corner cases.

Apart from race with copy_strings() we discuss in another thread?

> So avoid the problems by simply blocking cgroup migration over the
> entirety of exec.

This patch, even if it was correct, will bring much more problems.

If nothing else exec() is very slow. If it races with migration which needs
this sem for writing the new readers will be blocked. This means that clone(),
exit(), or another exec() will block too.

Now. if some IO path does kthread_stop() we have a deadlock.

Or request_module() in search_binary_handler(). Deadlock.

Plus this adds the nice security problem, a PTRACE_O_TRACEEXEC'ed task will
sleep in TASK_TRACED with cgroup_threadgroup_rwsem.

Oleg.

> Reported-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
> 
> Unless this leads to some kind of deadlock 
>  fs/exec.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 32461a1543fc..54bb01cfc635 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1101,7 +1099,6 @@ static int de_thread(struct task_struct *tsk)
>  		struct task_struct *leader = tsk->group_leader;
>  
>  		for (;;) {
> -			cgroup_threadgroup_change_begin(tsk);
>  			write_lock_irq(&tasklist_lock);
>  			/*
>  			 * Do this under tasklist_lock to ensure that
> @@ -1112,7 +1109,6 @@ static int de_thread(struct task_struct *tsk)
>  				break;
>  			__set_current_state(TASK_KILLABLE);
>  			write_unlock_irq(&tasklist_lock);
> -			cgroup_threadgroup_change_end(tsk);
>  			schedule();
>  			if (unlikely(__fatal_signal_pending(tsk)))
>  				goto killed;
> @@ -1750,6 +1746,7 @@ static int do_execveat_common(int fd, struct filename *filename,
>  	if (retval)
>  		goto out_free;
>  
> +	cgroup_threadgroup_change_begin(current);
>  	check_unsafe_exec(bprm);
>  	current->in_execve = 1;
>  
> @@ -1822,6 +1819,7 @@ static int do_execveat_common(int fd, struct filename *filename,
>  	/* execve succeeded */
>  	current->fs->in_exec = 0;
>  	current->in_execve = 0;
> +	cgroup_threadgroup_change_end(current);
>  	membarrier_execve(current);
>  	acct_update_integrals(current);
>  	task_numa_free(current);
> @@ -1841,6 +1839,7 @@ static int do_execveat_common(int fd, struct filename *filename,
>  out_unmark:
>  	current->fs->in_exec = 0;
>  	current->in_execve = 0;
> +	cgroup_threadgroup_change_end(current);
>  
>  out_free:
>  	free_bprm(bprm);
> -- 
> 2.14.1
> 
