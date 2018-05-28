Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932948AbeE1QAE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:00:04 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:45950 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932638AbeE1P77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:59:59 -0400
Date: Mon, 28 May 2018 08:59:32 -0700
From: Paul Burton <paul.burton@mips.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 2/2] sched: Warn if we fail to migrate a task
Message-ID: <20180528155932.rcyipmxc5kshjvsy@pburton-laptop>
References: <20180526154648.11635-1-paul.burton@mips.com>
 <20180526154648.11635-3-paul.burton@mips.com>
 <20180528150656.GF12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180528150656.GF12217@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1527523173-531715-32137-306557-1
X-BESS-VER: 2018.6-r1805181819
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193454
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, May 28, 2018 at 05:06:56PM +0200, Peter Zijlstra wrote:
> On Sat, May 26, 2018 at 08:46:48AM -0700, Paul Burton wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 2380bc228dd0..cda3affd45b7 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1127,7 +1127,8 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
> >  		struct migration_arg arg = { p, dest_cpu };
> >  		/* Need help from migration thread: drop lock and wait. */
> >  		task_rq_unlock(rq, p, &rf);
> > -		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
> > +		ret = stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
> > +		WARN_ON(ret);
> >  		tlb_migrate_finish(p->mm);
> >  		return 0;
> >  	} else if (task_on_rq_queued(p)) {
> 
> I think we can trigger this at will.. Set affinity to the CPU you're
> going to take offline and offline concurrently.
> 
> It is possible for the offline to happen between task_rq_unlock() and
> stop_one_cpu(), at which point the WARM will then trigger.

Right, good point. The problem is only if stop_one_cpu() returns an
error whilst cpu_of(rq) is being brought online, not whilst it's being
offlined.

> The point is; and maybe this should be a comment somewhere; that if this
> fails, there is nothing we can do about it, and it should be fixed up by
> migrate_tasks()/select_task_rq().
> 
> There is no point in propagating the error to userspace, since if we'd
> have slightly different timing and completed the stop_one_cpu() before
> the hot-un-plug, migrate_tasks()/select_task_rq() would've had to fix up
> anyway.

I agree userspace shouldn't need to care about this but in my case
(using the test program I linked from the previous patch) this triggers
whilst the CPU is being brought online, not taken offline. That means
migrate_tasks() is not involved, and we actually just return from here
back out from a sched_setaffinity syscall & continue running the user
task on a CPU that is no longer present in the task's cpus_allowed.

I can't think of a good qualifier to limit the warning to only trigger
in that scenario though, so in reality perhaps we're best to just trust
that with patch 1 applied the problem will go away.

Thanks,
    Paul
