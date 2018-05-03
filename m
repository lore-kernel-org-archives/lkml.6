Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbeECN42 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 09:56:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49418 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbeECN4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 09:56:25 -0400
Date: Thu, 3 May 2018 15:56:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Matt Fleming <matt@codeblueprint.co.uk>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: cpu stopper threads and load balancing leads to deadlock
Message-ID: <20180503135617.GC12217@hirez.programming.kicks-ass.net>
References: <20180417142119.GA4511@codeblueprint.co.uk>
 <20180420095005.GH4064@hirez.programming.kicks-ass.net>
 <20180424133325.GA3179@codeblueprint.co.uk>
 <1525349542.9956.2.camel@gmx.de>
 <20180503122808.GZ12217@hirez.programming.kicks-ass.net>
 <1525351221.9956.4.camel@gmx.de>
 <20180503124943.GB12217@hirez.programming.kicks-ass.net>
 <1525354359.5576.1.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525354359.5576.1.camel@gmx.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 03:32:39PM +0200, Mike Galbraith wrote:

> Dang.  With $subject fix applied as well..

That's a NO then... :-(

> [  151.103732] smpboot: Booting Node 0 Processor 2 APIC 0x4
> [  151.104908] =============================
> [  151.104909] WARNING: suspicious RCU usage
> [  151.104910] 4.17.0.g66d489e-tip-default #84 Tainted: G            E    
> [  151.104911] -----------------------------
> [  151.104912] kernel/sched/core.c:1625 suspicious rcu_dereference_check() usage!
> [  151.104913] 
>                other info that might help us debug this:
> 
> [  151.104914] 
>                RCU used illegally from offline CPU!
>                rcu_scheduler_active = 2, debug_locks = 0
> [  151.104916] 3 locks held by swapper/2/0:
> [  151.104916]  #0: 00000000560adb60 (stop_cpus_mutex){+.+.}, at: stop_machine_from_inactive_cpu+0x86/0x140
> [  151.104923]  #1: 00000000e4fb0238 (&p->pi_lock){-.-.}, at: try_to_wake_up+0x2d/0x5f0
> [  151.104929]  #2: 000000003341403b (rcu_read_lock){....}, at: rcu_read_lock+0x0/0x80
> [  151.104934] 
>                stack backtrace:
> [  151.104937] CPU: 2 PID: 0 Comm: swapper/2 Kdump: loaded Tainted: G            E     4.17.0.g66d489e-tip-default #84
> [  151.104938] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
> [  151.104938] Call Trace:
> [  151.104942]  dump_stack+0x78/0xb3
> [  151.104945]  ttwu_stat+0x121/0x130
> [  151.104949]  try_to_wake_up+0x2c2/0x5f0
> [  151.104953]  ? cpu_stop_park+0x30/0x30
> [  151.104956]  wake_up_q+0x4a/0x70
> [  151.104959]  cpu_stop_queue_work+0x6b/0xa0
> [  151.104963]  queue_stop_cpus_work+0x61/0xb0
> [  151.104968]  stop_machine_from_inactive_cpu+0xd8/0x140

> > diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
> > index f89014a2c238..a32518c2ba4a 100644
> > --- a/kernel/stop_machine.c
> > +++ b/kernel/stop_machine.c
> > @@ -650,8 +650,10 @@ int stop_machine_from_inactive_cpu(cpu_stop_fn_t fn, void *data,
> >  	/* Schedule work on other CPUs and execute directly for local CPU */
> >  	set_state(&msdata, MULTI_STOP_PREPARE);
> >  	cpu_stop_init_done(&done, num_active_cpus());
> > -	queue_stop_cpus_work(cpu_active_mask, multi_cpu_stop, &msdata,
> > -			     &done);
> > +
> > +	RCU_NONIDLE(queue_stop_cpus_work(cpu_active_mask, multi_cpu_stop,
> > +				         &msdata, &done));
> > +
> >  	ret = multi_cpu_stop(&msdata);

Paul, any clue on what else to try here? The whole MTRR setup is
radically crazy but it's something we're stuck with (yay hardware) :/

So the issue is that we're doing wakeups from an offline CPU (very early
during bringup) and RCU (rightfully) complains about that. I thought
RCU_NONIDLE() was the magic incantation that makes RCU 'watch', but
clearly it's not enough here.
