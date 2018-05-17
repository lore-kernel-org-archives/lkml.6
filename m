Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752061AbeEQOCU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:02:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33354 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750825AbeEQOCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:02:18 -0400
Date: Thu, 17 May 2018 07:03:45 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: cpu stopper threads and load balancing leads to deadlock
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180503122808.GZ12217@hirez.programming.kicks-ass.net>
 <1525351221.9956.4.camel@gmx.de>
 <20180503124943.GB12217@hirez.programming.kicks-ass.net>
 <1525354359.5576.1.camel@gmx.de>
 <20180503135617.GC12217@hirez.programming.kicks-ass.net>
 <1525357015.5577.2.camel@gmx.de>
 <20180503144450.GD12217@hirez.programming.kicks-ass.net>
 <20180503161231.GI26088@linux.vnet.ibm.com>
 <20180503164508.GG12217@hirez.programming.kicks-ass.net>
 <1526358626.19125.0.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526358626.19125.0.camel@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051714-0052-0000-0000-000002F020A3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009040; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01033633; UDB=6.00528533; IPR=6.00812761;
 MB=3.00021161; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-17 14:02:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051714-0053-0000-0000-00005CB79E0A
Message-Id: <20180517140345.GI3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805170130
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 06:30:26AM +0200, Mike Galbraith wrote:
> On Thu, 2018-05-03 at 18:45 +0200, Peter Zijlstra wrote:
> > On Thu, May 03, 2018 at 09:12:31AM -0700, Paul E. McKenney wrote:
> > > On Thu, May 03, 2018 at 04:44:50PM +0200, Peter Zijlstra wrote:
> > > > On Thu, May 03, 2018 at 04:16:55PM +0200, Mike Galbraith wrote:
> > > > > On Thu, 2018-05-03 at 15:56 +0200, Peter Zijlstra wrote:
> > > > > > On Thu, May 03, 2018 at 03:32:39PM +0200, Mike Galbraith wrote:
> > > > > > 
> > > > > > > Dang.  With $subject fix applied as well..
> > > > > > 
> > > > > > That's a NO then... :-(
> > > > > 
> > > > > Could say who cares about oddball offline wakeup stat. <cringe>
> > > > 
> > > > Yeah, nobody.. but I don't want to have to change the wakeup code to
> > > > deal with this if at all possible. That'd just add conditions that are
> > > > 'always' false, except in this exceedingly rare circumstance.
> > > > 
> > > > So ideally we manage to tell RCU that it needs to pay attention while
> > > > we're doing this here thing, which is what I thought RCU_NONIDLE() was
> > > > about.
> > > 
> > > One straightforward approach would be to provide a arch-specific
> > > Kconfig option that tells notify_cpu_starting() not to bother invoking
> > > rcu_cpu_starting().  Then x86 selects this Kconfig option and invokes
> > > rcu_cpu_starting() itself early enough to avoid splats.
> > > 
> > > See the (untested, probably does not even build) patch below.
> > > 
> > > I have no idea where to insert either the "select" or the call to
> > > rcu_cpu_starting(), so I left those out.  I know that putting the
> > > call too early will cause trouble, but I have no idea what constitutes
> > > "too early".  :-/
> > 
> > Something like so perhaps? Mike, can you play around with that? Could
> > burn your granny and eat your cookies.
> 
> Did this get queued anywhere?

I have not queued it, but given Peter's Signed-off-by and your Tested-by
I would be happy to do so.

							Thanx, Paul

> > diff --git a/arch/x86/kernel/cpu/mtrr/main.c b/arch/x86/kernel/cpu/mtrr/main.c
> > index 7468de429087..07360523c3ce 100644
> > --- a/arch/x86/kernel/cpu/mtrr/main.c
> > +++ b/arch/x86/kernel/cpu/mtrr/main.c
> > @@ -793,6 +793,9 @@ void mtrr_ap_init(void)
> >  
> >  	if (!use_intel() || mtrr_aps_delayed_init)
> >  		return;
> > +
> > +	rcu_cpu_starting(smp_processor_id());
> > +
> >  	/*
> >  	 * Ideally we should hold mtrr_mutex here to avoid mtrr entries
> >  	 * changed, but this routine will be called in cpu boot time,
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 2a734692a581..4dab46950fdb 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3775,6 +3775,8 @@ int rcutree_dead_cpu(unsigned int cpu)
> >  	return 0;
> >  }
> >  
> > +static DEFINE_PER_CPU(int, rcu_cpu_started);
> > +
> >  /*
> >   * Mark the specified CPU as being online so that subsequent grace periods
> >   * (both expedited and normal) will wait on it.  Note that this means that
> > @@ -3796,6 +3798,11 @@ void rcu_cpu_starting(unsigned int cpu)
> >  	struct rcu_node *rnp;
> >  	struct rcu_state *rsp;
> >  
> > +	if (per_cpu(rcu_cpu_started, cpu))
> > +		return;
> > +
> > +	per_cpu(rcu_cpu_started, cpu) = 1;
> > +
> >  	for_each_rcu_flavor(rsp) {
> >  		rdp = per_cpu_ptr(rsp->rda, cpu);
> >  		rnp = rdp->mynode;
> > @@ -3852,6 +3859,8 @@ void rcu_report_dead(unsigned int cpu)
> >  	preempt_enable();
> >  	for_each_rcu_flavor(rsp)
> >  		rcu_cleanup_dying_idle_cpu(cpu, rsp);
> > +
> > +	per_cpu(rcu_cpu_started, cpu) = 0;
> >  }
> >  
> >  /* Migrate the dead CPU's callbacks to the current CPU. */
> 
