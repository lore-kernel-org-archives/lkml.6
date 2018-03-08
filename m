Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755892AbeCHPme (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:42:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752072AbeCHPmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:42:32 -0500
Date: Thu, 8 Mar 2018 07:42:55 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: exp: Fix "must hold exp_mutex" comments for QS
 reporting functions
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180307084944.10229-1-boqun.feng@gmail.com>
 <20180307154829.GE3918@linux.vnet.ibm.com>
 <20180308034627.n2xw32zzujnmy2gb@tardis>
 <20180308043017.GL3918@linux.vnet.ibm.com>
 <20180308045429.py66d76trikiuguf@tardis>
 <20180308083006.wsgvkiw2ejbcwhhu@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308083006.wsgvkiw2ejbcwhhu@tardis>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18030815-0044-0000-0000-000003F07812
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008635; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01000095; UDB=6.00508672; IPR=6.00779426;
 MB=3.00019917; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-08 15:42:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030815-0045-0000-0000-000008207E8B
Message-Id: <20180308154255.GM3918@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803080180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 04:30:06PM +0800, Boqun Feng wrote:
> On Thu, Mar 08, 2018 at 12:54:29PM +0800, Boqun Feng wrote:
> > On Wed, Mar 07, 2018 at 08:30:17PM -0800, Paul E. McKenney wrote:
> > [...]
> > > >  
> > > > +/*
> > > > + * Like sync_rcu_preempt_exp_done(), but this function assumes the caller
> > > > + * doesn't hold the rcu_node's ->lock, and will acquire and release the lock
> > > > + * itself
> > > > + */
> > > > +static bool sync_rcu_preempt_exp_done_unlocked(struct rcu_node *rnp)
> > > > +{
> > > > +	unsigned long flags;
> > > > +	bool ret;
> > > > +
> > > > +	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > > > +	ret = sync_rcu_preempt_exp_done(rnp);
> > > 
> > > Let's see...  The sync_rcu_preempt_exp_done() function checks the
> > > ->exp_tasks pointer and the ->expmask bitmask.  The number of bits in the
> > > mask can only decrease, and the ->exp_tasks pointer can only transition
> > > from NULL to non-NULL when there is at least one bit set.  However,
> > > there is no ordering in sync_rcu_preempt_exp_done(), so it is possible
> > > that it could be fooled without the lock:
> > > 
> > > o	CPU 0 in sync_rcu_preempt_exp_done() reads ->exp_tasks and
> > > 	sees that it is NULL.
> > > 
> > > o	CPU 1 blocks within an RCU read-side critical section, so
> > > 	it enqueues the task and points ->exp_tasks at it and
> > > 	clears CPU 1's bit in ->expmask.
> > > 
> > > o	All other CPUs clear their bits in ->expmask.
> > > 
> > > o	CPU 0 reads ->expmask, sees that it is zero, so incorrectly
> > > 	concludes that all quiescent states have completed, despite
> > > 	the fact that ->exp_tasks is non-NULL.
> > > 
> > > So it seems to me that the lock is needed.  Good catch!!!  The problem
> > > would occur only if the task running on CPU 0 received a spurious
> > > wakeup, but that could potentially happen.
> > 
> > Thanks for the analysis ;-)

The other limitation is that it occurs only on systems small enough
to have a single-node rcu_node tree.  But still...

> > > If lock contention becomes a problem, memory-ordering tricks could be
> > > applied, but the lock is of course simpler.
> > > 
> > 
> > Agreed.
> > 
> > > I am guessing that this is a prototype patch, and that you are planning
> > 
> > Yes, this is a prototype. And I'm preparing a proper patch to send
> > later.

Very good, thank you!

> > > to add lockdep annotations in more places, but either way please let
> > > me know.
> > 
> > Give it's a bug as per your analysis, I'd like to defer other lockdep
> > annotations and send this first. However, I'm currently getting other
> > lockdep splats after applying this, so I need to get that sorted first.
> 
> Hmm.. the other lockdep splat seems irrelevant with my patch, I could
> observe it on mainline using rcutorture with CONFIG_PROVE_LOCKING=y. I'd
> spend some more time on it, in the meanwhile, send a proper patch for
> this sync_rcu_preempt_exp_done().

I am not seeing that one, but am very interested in getting it fixed!  ;-)

							Thanx, Paul

> Regards,
> Boqun
> 
> > Regards,
> > Boqun
> > 
> > > 						Thanx, Paul
> > > 
> > > > +	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +
> > > >  /*
> > > >   * Report the exit from RCU read-side critical section for the last task
> > > >   * that queued itself during or before the current expedited preemptible-RCU
> > > > @@ -490,6 +512,7 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
> > > >  	struct rcu_node *rnp;
> > > >  	struct rcu_node *rnp_root = rcu_get_root(rsp);
> > > >  	int ret;
> > > > +	unsigned long flags;
> > > >  
> > > >  	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("startwait"));
> > > >  	jiffies_stall = rcu_jiffies_till_stall_check();
> > > > @@ -498,9 +521,9 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
> > > >  	for (;;) {
> > > >  		ret = swait_event_timeout(
> > > >  				rsp->expedited_wq,
> > > > -				sync_rcu_preempt_exp_done(rnp_root),
> > > > +				sync_rcu_preempt_exp_done_unlocked(rnp_root),
> > > >  				jiffies_stall);
> > > > -		if (ret > 0 || sync_rcu_preempt_exp_done(rnp_root))
> > > > +		if (ret > 0 || sync_rcu_preempt_exp_done_unlocked(rnp_root))
> > > >  			return;
> > > >  		WARN_ON(ret < 0);  /* workqueues should not be signaled. */
> > > >  		if (rcu_cpu_stall_suppress)
> > > > @@ -533,8 +556,14 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
> > > >  			rcu_for_each_node_breadth_first(rsp, rnp) {
> > > >  				if (rnp == rnp_root)
> > > >  					continue; /* printed unconditionally */
> > > > -				if (sync_rcu_preempt_exp_done(rnp))
> > > > +
> > > > +				raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > > > +				if (sync_rcu_preempt_exp_done(rnp)) {
> > > > +					raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > > >  					continue;
> > > > +				}
> > > > +				raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > > > +
> > > >  				pr_cont(" l=%u:%d-%d:%#lx/%c",
> > > >  					rnp->level, rnp->grplo, rnp->grphi,
> > > >  					rnp->expmask,
> > > > -- 
> > > > 2.16.2
> > > > 
> > > 
> > > 
> 
> 
