Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeEOEa7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 00:30:59 -0400
Received: from mout.gmx.net ([212.227.17.22]:41127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbeEOEa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 00:30:57 -0400
Message-ID: <1526358626.19125.0.camel@gmx.de>
Subject: Re: cpu stopper threads and load balancing leads to deadlock
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Date: Tue, 15 May 2018 06:30:26 +0200
In-Reply-To: <20180503164508.GG12217@hirez.programming.kicks-ass.net>
References: <20180424133325.GA3179@codeblueprint.co.uk>
         <1525349542.9956.2.camel@gmx.de>
         <20180503122808.GZ12217@hirez.programming.kicks-ass.net>
         <1525351221.9956.4.camel@gmx.de>
         <20180503124943.GB12217@hirez.programming.kicks-ass.net>
         <1525354359.5576.1.camel@gmx.de>
         <20180503135617.GC12217@hirez.programming.kicks-ass.net>
         <1525357015.5577.2.camel@gmx.de>
         <20180503144450.GD12217@hirez.programming.kicks-ass.net>
         <20180503161231.GI26088@linux.vnet.ibm.com>
         <20180503164508.GG12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QJyJooW/CAc9RmKwIlPc7CIKGLVCR1twFxdWtGVVPtszFLm4Ryx
 fxTArCn0waGZAio8SajuiRdcOJ8rRlLkJLqXx0SjC2XjThEb3Ik9H9S23vlAsn9SGUvLGph
 kYR8Z5PV1KHyEU0UU4kauUIt/pgWAUGdZYJD2RY59bCo6nIOMsCMxu9tUYzHkMh3CxrYHjG
 UQmxVr1kKEQTu+CmWB1og==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L2Em4ah341I=:kCFybmjBVxu4quQUKYrIes
 1KWnoJ3vSgp8HSDqouqK+bBAJgC2RnQn8jp0aOxqI4un0Tb0aMgA5cURUQw2/4YfgwGOTqgre
 BxpQVdRCHokEkid94svsJ/KQTDR5jxuqKetokaYEeaVdfJ3721hDPusccEMi4C38KEWkh84t9
 vcvRBpb9jgAz0oW9sRFOXeAsfDHdxGr5fTrYDjeXKD9xaX/5eLN/KK9SNbs+DqjkgxUWAQKN6
 1+x0XYJ1GJAdUN3C9HBjVpf7sJZhFBgOF0szv+sZp5wOBEYwXAPH39zJUV1Yvtn0+eQVyzWmP
 n2pn0hHOGcrFvDCHL+YUFUwWTjgmTXNGazFkd35efWnAaguQokDqJlwXrHSSYjBNNHTubcetb
 09deFyWI63vxwC2I25/RmFPC6hggfT3ppr7jyAgh7Q4QXWbdvbhTnRqDynRYxwJEEzcvO/xyP
 5qwNkT7SblqkyUXig7TsINr6D50JdSMDC/qcfMBVLNBon4Gqa4ZH1x+YJSXm6jTwd+relEwu5
 Q8EiZNx5gESEs0kRyq8smFVq+fvnibs5UL8MnQ++gpRo8/CVLwXRSDdwGSUVkxfqeBTxMOQBL
 RKZDX1y0TlEMwEjoZLtkog7SaglR/wy7234s2Agi2xlOqiBSJaWVODoGoXNYcuAufWiBuSTvx
 MekABn0gFTkS6kPlWC+54mNWbphPoI/W7Wd+9sq+aSAu74iKD/a1ZiFAVTU8RJ0dIqosL/Wzm
 TUXKQ6KZ6l+ewbi7mjj7GPjflDx2+5Oz4/FrrPzm6SKEA9QCfOfw6ax+HADwM7VWuW/4Dhu0+
 snD3sw/
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-03 at 18:45 +0200, Peter Zijlstra wrote:
> On Thu, May 03, 2018 at 09:12:31AM -0700, Paul E. McKenney wrote:
> > On Thu, May 03, 2018 at 04:44:50PM +0200, Peter Zijlstra wrote:
> > > On Thu, May 03, 2018 at 04:16:55PM +0200, Mike Galbraith wrote:
> > > > On Thu, 2018-05-03 at 15:56 +0200, Peter Zijlstra wrote:
> > > > > On Thu, May 03, 2018 at 03:32:39PM +0200, Mike Galbraith wrote:
> > > > > 
> > > > > > Dang.  With $subject fix applied as well..
> > > > > 
> > > > > That's a NO then... :-(
> > > > 
> > > > Could say who cares about oddball offline wakeup stat. <cringe>
> > > 
> > > Yeah, nobody.. but I don't want to have to change the wakeup code to
> > > deal with this if at all possible. That'd just add conditions that are
> > > 'always' false, except in this exceedingly rare circumstance.
> > > 
> > > So ideally we manage to tell RCU that it needs to pay attention while
> > > we're doing this here thing, which is what I thought RCU_NONIDLE() was
> > > about.
> > 
> > One straightforward approach would be to provide a arch-specific
> > Kconfig option that tells notify_cpu_starting() not to bother invoking
> > rcu_cpu_starting().  Then x86 selects this Kconfig option and invokes
> > rcu_cpu_starting() itself early enough to avoid splats.
> > 
> > See the (untested, probably does not even build) patch below.
> > 
> > I have no idea where to insert either the "select" or the call to
> > rcu_cpu_starting(), so I left those out.  I know that putting the
> > call too early will cause trouble, but I have no idea what constitutes
> > "too early".  :-/
> 
> Something like so perhaps? Mike, can you play around with that? Could
> burn your granny and eat your cookies.

Did this get queued anywhere?

> diff --git a/arch/x86/kernel/cpu/mtrr/main.c b/arch/x86/kernel/cpu/mtrr/main.c
> index 7468de429087..07360523c3ce 100644
> --- a/arch/x86/kernel/cpu/mtrr/main.c
> +++ b/arch/x86/kernel/cpu/mtrr/main.c
> @@ -793,6 +793,9 @@ void mtrr_ap_init(void)
>  
>  	if (!use_intel() || mtrr_aps_delayed_init)
>  		return;
> +
> +	rcu_cpu_starting(smp_processor_id());
> +
>  	/*
>  	 * Ideally we should hold mtrr_mutex here to avoid mtrr entries
>  	 * changed, but this routine will be called in cpu boot time,
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 2a734692a581..4dab46950fdb 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3775,6 +3775,8 @@ int rcutree_dead_cpu(unsigned int cpu)
>  	return 0;
>  }
>  
> +static DEFINE_PER_CPU(int, rcu_cpu_started);
> +
>  /*
>   * Mark the specified CPU as being online so that subsequent grace periods
>   * (both expedited and normal) will wait on it.  Note that this means that
> @@ -3796,6 +3798,11 @@ void rcu_cpu_starting(unsigned int cpu)
>  	struct rcu_node *rnp;
>  	struct rcu_state *rsp;
>  
> +	if (per_cpu(rcu_cpu_started, cpu))
> +		return;
> +
> +	per_cpu(rcu_cpu_started, cpu) = 1;
> +
>  	for_each_rcu_flavor(rsp) {
>  		rdp = per_cpu_ptr(rsp->rda, cpu);
>  		rnp = rdp->mynode;
> @@ -3852,6 +3859,8 @@ void rcu_report_dead(unsigned int cpu)
>  	preempt_enable();
>  	for_each_rcu_flavor(rsp)
>  		rcu_cleanup_dying_idle_cpu(cpu, rsp);
> +
> +	per_cpu(rcu_cpu_started, cpu) = 0;
>  }
>  
>  /* Migrate the dead CPU's callbacks to the current CPU. */
