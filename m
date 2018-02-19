Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752422AbeBTNEQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 08:04:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46492 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752095AbeBTNCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 08:02:07 -0500
Date: Mon, 19 Feb 2018 14:56:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] sched/fair: Add group_misfit_task load-balance type
Message-ID: <20180219135644.GG25181@hirez.programming.kicks-ass.net>
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
 <1518711654-23503-3-git-send-email-morten.rasmussen@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518711654-23503-3-git-send-email-morten.rasmussen@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 04:20:49PM +0000, Morten Rasmussen wrote:
> @@ -6733,9 +6758,12 @@ done: __maybe_unused
>  	if (hrtick_enabled(rq))
>  		hrtick_start_fair(rq, p);
>  
> +	update_misfit_status(p, rq);
> +
>  	return p;
>  
>  idle:
> +	update_misfit_status(NULL, rq);
>  	new_tasks = idle_balance(rq, rf);
>  
>  	/*

So we set a point when picking a task (or tick). We clear said pointer
when idle.

> @@ -7822,6 +7855,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  		 */
>  		if (!nr_running && idle_cpu(i))
>  			sgs->idle_cpus++;
> +
> +		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
> +		    !sgs->group_misfit_task_load && rq->misfit_task_load)
> +			sgs->group_misfit_task_load = rq->misfit_task_load;
>  	}
>  
>  	/* Adjust by relative CPU capacity of the group */

And we read said pointer from another CPU, without holding the
respective rq->lock.

What happens, if right after we set sgs->group_misfit_task_load, our
task decides to exit?
