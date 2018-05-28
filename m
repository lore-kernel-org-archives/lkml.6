Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939634AbeE1PHW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:07:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56816 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937156AbeE1PHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:07:05 -0400
Date: Mon, 28 May 2018 17:06:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Paul Burton <paul.burton@mips.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 2/2] sched: Warn if we fail to migrate a task
Message-ID: <20180528150656.GF12217@hirez.programming.kicks-ass.net>
References: <20180526154648.11635-1-paul.burton@mips.com>
 <20180526154648.11635-3-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180526154648.11635-3-paul.burton@mips.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2018 at 08:46:48AM -0700, Paul Burton wrote:
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2380bc228dd0..cda3affd45b7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1127,7 +1127,8 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>  		struct migration_arg arg = { p, dest_cpu };
>  		/* Need help from migration thread: drop lock and wait. */
>  		task_rq_unlock(rq, p, &rf);
> -		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
> +		ret = stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
> +		WARN_ON(ret);
>  		tlb_migrate_finish(p->mm);
>  		return 0;
>  	} else if (task_on_rq_queued(p)) {

I think we can trigger this at will.. Set affinity to the CPU you're
going to take offline and offline concurrently.

It is possible for the offline to happen between task_rq_unlock() and
stop_one_cpu(), at which point the WARM will then trigger.

The point is; and maybe this should be a comment somewhere; that if this
fails, there is nothing we can do about it, and it should be fixed up by
migrate_tasks()/select_task_rq().

There is no point in propagating the error to userspace, since if we'd
have slightly different timing and completed the stop_one_cpu() before
the hot-un-plug, migrate_tasks()/select_task_rq() would've had to fix up
anyway.
