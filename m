Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752461AbeEQOXs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:23:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752408AbeEQOXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:23:36 -0400
Date: Thu, 17 May 2018 16:23:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: cpu stopper threads and load balancing leads to deadlock
Message-ID: <20180517142322.GU12217@hirez.programming.kicks-ass.net>
References: <1525351221.9956.4.camel@gmx.de>
 <20180503124943.GB12217@hirez.programming.kicks-ass.net>
 <1525354359.5576.1.camel@gmx.de>
 <20180503135617.GC12217@hirez.programming.kicks-ass.net>
 <1525357015.5577.2.camel@gmx.de>
 <20180503144450.GD12217@hirez.programming.kicks-ass.net>
 <20180503161231.GI26088@linux.vnet.ibm.com>
 <20180503164508.GG12217@hirez.programming.kicks-ass.net>
 <1526358626.19125.0.camel@gmx.de>
 <20180517140345.GI3803@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517140345.GI3803@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 07:03:45AM -0700, Paul E. McKenney wrote:
> On Tue, May 15, 2018 at 06:30:26AM +0200, Mike Galbraith wrote:
> I have not queued it, but given Peter's Signed-off-by and your Tested-by
> I would be happy to do so.

And a Changelog of course :-)

---
From: Peter Zijlstra <peterz@infradead.org>
Subject: rcu/x86: Provide early rcu_cpu_starting() callback

The x86/mtrr code does horrific things because hardware. It uses
stop_machine_from_inactive_cpu(), which does a wakeup (of the stopper
thread on another CPU), which uses RCU, all before the CPU is onlined.

RCU complains about this, because wakeups use RCU and RCU does
(rightfully) not consider offline CPUs for grace-periods.

Fix this by initializing RCU way early in the MTRR case.

Tested-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---

> > > diff --git a/arch/x86/kernel/cpu/mtrr/main.c b/arch/x86/kernel/cpu/mtrr/main.c
> > > index 7468de429087..07360523c3ce 100644
> > > --- a/arch/x86/kernel/cpu/mtrr/main.c
> > > +++ b/arch/x86/kernel/cpu/mtrr/main.c
> > > @@ -793,6 +793,9 @@ void mtrr_ap_init(void)
> > >  
> > >  	if (!use_intel() || mtrr_aps_delayed_init)
> > >  		return;
> > > +
> > > +	rcu_cpu_starting(smp_processor_id());
> > > +
> > >  	/*
> > >  	 * Ideally we should hold mtrr_mutex here to avoid mtrr entries
> > >  	 * changed, but this routine will be called in cpu boot time,
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 2a734692a581..4dab46950fdb 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3775,6 +3775,8 @@ int rcutree_dead_cpu(unsigned int cpu)
> > >  	return 0;
> > >  }
> > >  
> > > +static DEFINE_PER_CPU(int, rcu_cpu_started);
> > > +
> > >  /*
> > >   * Mark the specified CPU as being online so that subsequent grace periods
> > >   * (both expedited and normal) will wait on it.  Note that this means that
> > > @@ -3796,6 +3798,11 @@ void rcu_cpu_starting(unsigned int cpu)
> > >  	struct rcu_node *rnp;
> > >  	struct rcu_state *rsp;
> > >  
> > > +	if (per_cpu(rcu_cpu_started, cpu))
> > > +		return;
> > > +
> > > +	per_cpu(rcu_cpu_started, cpu) = 1;
> > > +
> > >  	for_each_rcu_flavor(rsp) {
> > >  		rdp = per_cpu_ptr(rsp->rda, cpu);
> > >  		rnp = rdp->mynode;
> > > @@ -3852,6 +3859,8 @@ void rcu_report_dead(unsigned int cpu)
> > >  	preempt_enable();
> > >  	for_each_rcu_flavor(rsp)
> > >  		rcu_cleanup_dying_idle_cpu(cpu, rsp);
> > > +
> > > +	per_cpu(rcu_cpu_started, cpu) = 0;
> > >  }
> > >  
> > >  /* Migrate the dead CPU's callbacks to the current CPU. */
> > 
> 
