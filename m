Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966597AbeEJQPc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 12:15:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45292 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964881AbeEJQPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 12:15:30 -0400
Date: Thu, 10 May 2018 18:15:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH 3/3] sched/fair: schedutil: explicit update only when
 required
Message-ID: <20180510161515.GH12217@hirez.programming.kicks-ass.net>
References: <20180510150553.28122-1-patrick.bellasi@arm.com>
 <20180510150553.28122-4-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510150553.28122-4-patrick.bellasi@arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 04:05:53PM +0100, Patrick Bellasi wrote:
> All the above considered, let's make schedutil updates more explicit in
> fair.c by removing the cfs_rq_util_change() wrapper function in favour
> of the existing cpufreq_update_util() public API.
> This can be done by calling cpufreq_update_util() explicitly in the few
> call sites where it really makes sense and when all the (potentially)
> required cfs_rq's information have been updated.

Aside from having to redraw my ever stale diagrams _again_ I don't think
I object too much here. As you write tracking the exact point where we
did do the update was fairly tedious.

> @@ -5397,9 +5366,27 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  		update_cfs_group(se);
>  	}
>  
> +	/* The task is visible from the root cfs_rq */
> +	if (!se) {
> +		unsigned int flags = 0;

That one shadows the @flags argument. Some checker is bound to complain
about it.

> +
>  		add_nr_running(rq, 1);
>  
> +		if (p->in_iowait)
> +			flags |= SCHED_CPUFREQ_IOWAIT;
> +
> +		/*
> +		 * !last_update_time means we've passed through
> +		 * migrate_task_rq_fair() indicating we migrated.
> +		 *
> +		 * IOW we're enqueueing a task on a new CPU.
> +		 */
> +		if (!p->se.avg.last_update_time)
> +			flags |= SCHED_CPUFREQ_MIGRATION;
> +
> +		cpufreq_update_util(rq, flags);
> +	}
> +
>  	hrtick_update(rq);
>  }
