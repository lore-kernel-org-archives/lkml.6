Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbeECQpP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 12:45:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57868 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeECQpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 12:45:13 -0400
Date: Thu, 3 May 2018 18:45:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: cpu stopper threads and load balancing leads to deadlock
Message-ID: <20180503164508.GG12217@hirez.programming.kicks-ass.net>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503161231.GI26088@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 09:12:31AM -0700, Paul E. McKenney wrote:
> On Thu, May 03, 2018 at 04:44:50PM +0200, Peter Zijlstra wrote:
> > On Thu, May 03, 2018 at 04:16:55PM +0200, Mike Galbraith wrote:
> > > On Thu, 2018-05-03 at 15:56 +0200, Peter Zijlstra wrote:
> > > > On Thu, May 03, 2018 at 03:32:39PM +0200, Mike Galbraith wrote:
> > > > 
> > > > > Dang.  With $subject fix applied as well..
> > > > 
> > > > That's a NO then... :-(
> > > 
> > > Could say who cares about oddball offline wakeup stat. <cringe>
> > 
> > Yeah, nobody.. but I don't want to have to change the wakeup code to
> > deal with this if at all possible. That'd just add conditions that are
> > 'always' false, except in this exceedingly rare circumstance.
> > 
> > So ideally we manage to tell RCU that it needs to pay attention while
> > we're doing this here thing, which is what I thought RCU_NONIDLE() was
> > about.
> 
> One straightforward approach would be to provide a arch-specific
> Kconfig option that tells notify_cpu_starting() not to bother invoking
> rcu_cpu_starting().  Then x86 selects this Kconfig option and invokes
> rcu_cpu_starting() itself early enough to avoid splats.
> 
> See the (untested, probably does not even build) patch below.
> 
> I have no idea where to insert either the "select" or the call to
> rcu_cpu_starting(), so I left those out.  I know that putting the
> call too early will cause trouble, but I have no idea what constitutes
> "too early".  :-/

Something like so perhaps? Mike, can you play around with that? Could
burn your granny and eat your cookies.


diff --git a/arch/x86/kernel/cpu/mtrr/main.c b/arch/x86/kernel/cpu/mtrr/main.c
index 7468de429087..07360523c3ce 100644
--- a/arch/x86/kernel/cpu/mtrr/main.c
+++ b/arch/x86/kernel/cpu/mtrr/main.c
@@ -793,6 +793,9 @@ void mtrr_ap_init(void)
 
 	if (!use_intel() || mtrr_aps_delayed_init)
 		return;
+
+	rcu_cpu_starting(smp_processor_id());
+
 	/*
 	 * Ideally we should hold mtrr_mutex here to avoid mtrr entries
 	 * changed, but this routine will be called in cpu boot time,
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2a734692a581..4dab46950fdb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3775,6 +3775,8 @@ int rcutree_dead_cpu(unsigned int cpu)
 	return 0;
 }
 
+static DEFINE_PER_CPU(int, rcu_cpu_started);
+
 /*
  * Mark the specified CPU as being online so that subsequent grace periods
  * (both expedited and normal) will wait on it.  Note that this means that
@@ -3796,6 +3798,11 @@ void rcu_cpu_starting(unsigned int cpu)
 	struct rcu_node *rnp;
 	struct rcu_state *rsp;
 
+	if (per_cpu(rcu_cpu_started, cpu))
+		return;
+
+	per_cpu(rcu_cpu_started, cpu) = 1;
+
 	for_each_rcu_flavor(rsp) {
 		rdp = per_cpu_ptr(rsp->rda, cpu);
 		rnp = rdp->mynode;
@@ -3852,6 +3859,8 @@ void rcu_report_dead(unsigned int cpu)
 	preempt_enable();
 	for_each_rcu_flavor(rsp)
 		rcu_cleanup_dying_idle_cpu(cpu, rsp);
+
+	per_cpu(rcu_cpu_started, cpu) = 0;
 }
 
 /* Migrate the dead CPU's callbacks to the current CPU. */
