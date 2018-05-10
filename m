Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757267AbeEJNOb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 09:14:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757098AbeEJNOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 09:14:30 -0400
Date: Thu, 10 May 2018 06:15:46 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel.opensrc@gmail.com, torvalds@linux-foundation.org,
        npiggin@gmail.com
Subject: Re: [tip/core/rcu, 05/21] rcu: Make rcu_gp_cleanup() more accurately
 predict need for new GP
Reply-To: paulmck@linux.vnet.ibm.com
References: <1524452624-27589-5-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180510072133.GA122810@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510072133.GA122810@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051013-0040-0000-0000-00000429701B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009000; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000259; SDB=6.01030257; UDB=6.00526515; IPR=6.00809389;
 MB=3.00021030; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-10 13:14:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051013-0041-0000-0000-0000082F7F44
Message-Id: <20180510131546.GN26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-10_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805100127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 12:21:33AM -0700, Joel Fernandes wrote:
> Hi Paul,
> 
> On Sun, Apr 22, 2018 at 08:03:28PM -0700, Paul E. McKenney wrote:
> > Currently, rcu_gp_cleanup() scans the rcu_node tree in order to reset
> > state to reflect the end of the grace period.  It also checks to see
> > whether a new grace period is needed, but in a number of cases, rather
> > than directly cause the new grace period to be immediately started, it
> > instead leaves the grace-period-needed state where various fail-safes
> > can find it.  This works fine, but results in higher contention on the
> > root rcu_node structure's ->lock, which is undesirable, and contention
> > on that lock has recently become noticeable.
> > 
> > This commit therefore makes rcu_gp_cleanup() immediately start a new
> > grace period if there is any need for one.
> > 
> > It is quite possible that it will later be necessary to throttle the
> > grace-period rate, but that can be dealt with when and if.
> > 
> > Reported-by: Nicholas Piggin <npiggin@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > ---
> >  kernel/rcu/tree.c        | 16 ++++++++++------
> >  kernel/rcu/tree.h        |  1 -
> >  kernel/rcu/tree_plugin.h | 17 -----------------
> >  3 files changed, 10 insertions(+), 24 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 497f139056c7..afc5e32f0da4 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1763,14 +1763,14 @@ rcu_start_future_gp(struct rcu_node *rnp, struct rcu_data *rdp,
> >   * Clean up any old requests for the just-ended grace period.  Also return
> >   * whether any additional grace periods have been requested.
> >   */
> > -static int rcu_future_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
> > +static bool rcu_future_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
> >  {
> >  	int c = rnp->completed;
> > -	int needmore;
> > +	bool needmore;
> >  	struct rcu_data *rdp = this_cpu_ptr(rsp->rda);
> >  
> >  	need_future_gp_element(rnp, c) = 0;
> > -	needmore = need_future_gp_element(rnp, c + 1);
> > +	needmore = need_any_future_gp(rnp);
> >  	trace_rcu_future_gp(rnp, rdp, c,
> >  			    needmore ? TPS("CleanupMore") : TPS("Cleanup"));
> >  	return needmore;
> > @@ -2113,7 +2113,6 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
> >  {
> >  	unsigned long gp_duration;
> >  	bool needgp = false;
> > -	int nocb = 0;
> >  	struct rcu_data *rdp;
> >  	struct rcu_node *rnp = rcu_get_root(rsp);
> >  	struct swait_queue_head *sq;
> > @@ -2152,7 +2151,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
> >  		if (rnp == rdp->mynode)
> >  			needgp = __note_gp_changes(rsp, rnp, rdp) || needgp;
> >  		/* smp_mb() provided by prior unlock-lock pair. */
> > -		nocb += rcu_future_gp_cleanup(rsp, rnp);
> > +		needgp = rcu_future_gp_cleanup(rsp, rnp) || needgp;
> >  		sq = rcu_nocb_gp_get(rnp);
> >  		raw_spin_unlock_irq_rcu_node(rnp);
> >  		rcu_nocb_gp_cleanup(sq);
> > @@ -2162,13 +2161,18 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
> >  	}
> >  	rnp = rcu_get_root(rsp);
> >  	raw_spin_lock_irq_rcu_node(rnp); /* Order GP before ->completed update. */
> > -	rcu_nocb_gp_set(rnp, nocb);
> >  
> >  	/* Declare grace period done. */
> >  	WRITE_ONCE(rsp->completed, rsp->gpnum);
> >  	trace_rcu_grace_period(rsp->name, rsp->completed, TPS("end"));
> >  	rsp->gp_state = RCU_GP_IDLE;
> > +	/* Check for GP requests since above loop. */
> >  	rdp = this_cpu_ptr(rsp->rda);
> > +	if (need_any_future_gp(rnp)) {
> > +		trace_rcu_future_gp(rnp, rdp, rsp->completed - 1,
> > +				    TPS("CleanupMore"));
> > +		needgp = true;
> 
> Patch makes sense to me.
> 
> I didn't get the "rsp->completed - 1" bit in the call to trace_rcu_future_gp.
> The grace period that just completed is in rsp->completed. The future one
> should be completed + 1. What is meaning of the third argument 'c' to the
> trace event?

The thought was that the grace period must have been requested while
rsp->completed was one less than it is now.

In the current code, it uses rnp->gp_seq_needed, which is instead the
grace period that is being requested.

> Also in rcu_future_gp_cleanup, we call:
> 	trace_rcu_future_gp(rnp, rdp, c,
> 			    needmore ? TPS("CleanupMore") : TPS("Cleanup"));
> For this case, in the final trace event record, rnp->completed and c will be
> the same, since c is set to rnp->completed before calling
> trace_rcu_future_gp. I was thinking they should be different, do you expect
> them to be the same?

Hmmm...  That does look a bit inconsistent.  And it currently uses
rnp->gp_seq instead of rnp->gp_seq_needed despite having the same
"CleanupMore" name.

Looks like a review of the calls to trace_rcu_this_gp() is in order.
Or did you have suggestions for name/gp assocations for this trace
message type?

							Thanx, Paul
