Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AB8JxZoIJQ0gcOG3EpRHDTjg//dGKSHYwGyFi+jdSGZ+7DOaagN5tXBVWISrGB2jvWhZBAs1GjRy
ARC-Seal: i=1; a=rsa-sha256; t=1525448652; cv=none;
        d=google.com; s=arc-20160816;
        b=Kij2eTZFubeolbVKnqQtUx9lHctbj5y8JzpYObdMJZ0Q+cv9eaH4Bqjiua8C9pezhl
         1oZpTq+4O7ti4hGhqOtJhzOOdOCRLr8ownM4Js/BiI4GJYi+jThkYTMkm5CC3yFaxKhu
         Hc7znhJroo4zbf1IBcHkCTA+PqFq7aDB4gX2XX3tP2WO00Jf8X2FHyGIWK+kNSk9OIkl
         iMDIcfAbs0Uh1M7s6jq1FaMYOGqI3i6kBbcza63OKGXjNDdJUIEcgc54GyPj9VKb7Z4T
         oOEHCUyrlNSTFqm9yu7yzd8FyUWwk6xkVx+wBMsqSCAPMpa9kcxPYYy1QYeIEGcb2tE3
         Uolg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=YQl9k7/Aza8bPTd+U1kC7KzEisZyuIRnNTJMd45LJ6E=;
        b=wUOLPmIwfMc+wkRE98VJ/5d8z5pv38z3SFTu5lU3Shfm0ISvo+4kMywLQKR0jxbkdh
         MAVxepfI799TkMPoBZEpTyz5F+E/DgJoPlQ1U5YerLFoNxZbWqfreehzwAewLqD+pKJo
         tpqIy8l1pJKXUc+lzzR/LuORiivwdOxo8iXfE/enPhOEhmDdz5KtS8FVGa74+K+KARLO
         0otNuRT/JzsJm5gEk1RqXx1jAPC+ag4O3XLxMt3tyPNDhmY8ngGb/D8dtPXtoJOLsLLz
         YjHkUiMLqiaEIPOnOOKuhWIttmeAMaSw88uLh5chTdyBpujvNArg2zDXorGwuaAW6gdw
         gm4A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=rHo/jjcJ;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=rHo/jjcJ;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Fri, 4 May 2018 17:43:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: zhangq95 <qiangzh.hust@gmail.com>
Cc: linux-kernel@vger.kernel.org, tj@kernel.org, lizefan@huawei.com,
	hannes@cmpxchg.org, mingo@redhat.com, cgroups@vger.kernel.org,
	riel@redhat.com, gs051095@gmail.com, akpm@linux-foundation.org,
	oleg@redhat.com, tglx@linutronix.de, keescook@chromium.org,
	gregkh@linuxfoundation.org, longman@redhat.com,
	prsood@codeaurora.org, guro@fb.com, davem@davemloft.net,
	mhocko@suse.com, kirill.shutemov@linux.intel.com,
	marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
	rostedt@goodmis.org, bigeasy@linutronix.de,
	alexander.levin@verizon.com, paulmck@linux.vnet.ibm.com,
	fweisbec@gmail.com
Subject: Re: [PATCH] Add a file named cgroup.procs_stat in cgroup
Message-ID: <20180504154350.GN12217@hirez.programming.kicks-ass.net>
References: <1525444100-4858-1-git-send-email-qiangzh.hust@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525444100-4858-1-git-send-email-qiangzh.hust@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599544125456268964?=
X-GMAIL-MSGID: =?utf-8?q?1599548845840699708?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 10:28:20PM +0800, zhangq95 wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5e10aae..ba969af 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3404,11 +3404,19 @@ static void __sched notrace __schedule(bool preempt)
>  	struct rq_flags rf;
>  	struct rq *rq;
>  	int cpu;
> +	struct task_struct *prev_root = NULL, *next_root = NULL;
>  
>  	cpu = smp_processor_id();
>  	rq = cpu_rq(cpu);
>  	prev = rq->curr;
>  
> +	if (task_active_pid_ns(prev)) {
> +		prev_root = task_active_pid_ns(prev)->child_reaper;
> +		if (prev_root != init_pid_ns.child_reaper)
> +			update_cpuacct_procs_stat(prev, prev->cpu,
> +				CPUACCT_PROCS_SWITCHES, 1, 0);
> +	}
> +
>  	schedule_debug(prev);
>  
>  	if (sched_feat(HRTICK))
> @@ -3462,6 +3470,12 @@ static void __sched notrace __schedule(bool preempt)
>  	}
>  
>  	next = pick_next_task(rq, prev, &rf);
> +	if (task_active_pid_ns(next)) {
> +		next_root = task_active_pid_ns(next)->child_reaper;
> +		if (prev_root && prev_root != next_root)
> +			update_cpuacct_procs_stat(next, next->cpu,
> +				CPUACCT_PROCS_SWITCHES, 1, 0);
> +	}
>  	clear_tsk_need_resched(prev);
>  	clear_preempt_need_resched();
>  

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 54dc31e..46adf63 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4757,6 +4774,7 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
>  		if (dequeue)
>  			dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
>  		qcfs_rq->h_nr_running -= task_delta;
> +		update_cpuacct_running_from_cfs(qcfs_rq, -task_delta);
>  
>  		if (qcfs_rq->load.weight)
>  			dequeue = 0;
> @@ -4820,6 +4838,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  		if (enqueue)
>  			enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
>  		cfs_rq->h_nr_running += task_delta;
> +		update_cpuacct_running_from_cfs(cfs_rq, task_delta);
>  
>  		if (cfs_rq_throttled(cfs_rq))
>  			break;
> @@ -5379,6 +5398,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  		if (cfs_rq_throttled(cfs_rq))
>  			break;
>  		cfs_rq->h_nr_running++;
> +		update_cpuacct_running_from_cfs(cfs_rq, 1);
>  
>  		flags = ENQUEUE_WAKEUP;
>  	}
> @@ -5386,6 +5406,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	for_each_sched_entity(se) {
>  		cfs_rq = cfs_rq_of(se);
>  		cfs_rq->h_nr_running++;
> +		update_cpuacct_running_from_cfs(cfs_rq, 1);
>  
>  		if (cfs_rq_throttled(cfs_rq))
>  			break;
> @@ -5427,6 +5448,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  		if (cfs_rq_throttled(cfs_rq))
>  			break;
>  		cfs_rq->h_nr_running--;
> +		update_cpuacct_running_from_cfs(cfs_rq, -1);
>  
>  		/* Don't dequeue parent if it has other entities besides us */
>  		if (cfs_rq->load.weight) {
> @@ -5446,6 +5468,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	for_each_sched_entity(se) {
>  		cfs_rq = cfs_rq_of(se);
>  		cfs_rq->h_nr_running--;
> +		update_cpuacct_running_from_cfs(cfs_rq, -1);
>  
>  		if (cfs_rq_throttled(cfs_rq))
>  			break;
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 7aef6b4..766ec16 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1327,6 +1327,7 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
>  		rt_se->timeout = 0;
>  
>  	enqueue_rt_entity(rt_se, flags);
> +	update_cpuacct_procs_stat(p, cpu_of(rq), CPUACCT_PROCS_RUNNING, 1, 0);
>  
>  	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
>  		enqueue_pushable_task(rq, p);
> @@ -1338,6 +1339,7 @@ static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
>  
>  	update_curr_rt(rq);
>  	dequeue_rt_entity(rt_se, flags);
> +	update_cpuacct_procs_stat(p, cpu_of(rq), CPUACCT_PROCS_RUNNING, -1, 0);
>  
>  	dequeue_pushable_task(rq, p);
>  }


Yeah, I think not... death by accounting.
