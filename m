Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751098AbeELOil (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 10:38:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750852AbeELOik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 10:38:40 -0400
Date: Sat, 12 May 2018 07:40:02 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel.opensrc@gmail.com, torvalds@linux-foundation.org,
        npiggin@gmail.com
Subject: Re: [tip/core/rcu,16/21] rcu: Add funnel locking to
 rcu_start_this_gp()
Reply-To: paulmck@linux.vnet.ibm.com
References: <1524452624-27589-16-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180512060325.GA53808@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180512060325.GA53808@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051214-2213-0000-0000-000002A37990
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009012; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01031245; UDB=6.00527101; IPR=6.00810377;
 MB=3.00021071; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-12 14:38:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051214-2214-0000-0000-00005A176725
Message-Id: <20180512144002.GI26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805120146
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 11:03:25PM -0700, Joel Fernandes wrote:
> On Sun, Apr 22, 2018 at 08:03:39PM -0700, Paul E. McKenney wrote:
> > The rcu_start_this_gp() function had a simple form of funnel locking that
> > used only the leaves and root of the rcu_node tree, which is fine for
> > systems with only a few hundred CPUs, but sub-optimal for systems having
> > thousands of CPUs.  This commit therefore adds full-tree funnel locking.
> > 
> > This variant of funnel locking is unusual in the following ways:
> > 
> > 1.	The leaf-level rcu_node structure's ->lock is held throughout.
> > 	Other funnel-locking implementations drop the leaf-level lock
> > 	before progressing to the next level of the tree.
> > 
> > 2.	Funnel locking can be started at the root, which is convenient
> > 	for code that already holds the root rcu_node structure's ->lock.
> > 	Other funnel-locking implementations start at the leaves.
> > 
> > 3.	If an rcu_node structure other than the initial one believes
> > 	that a grace period is in progress, it is not necessary to
> > 	go further up the tree.  This is because grace-period cleanup
> > 	scans the full tree, so that marking the need for a subsequent
> > 	grace period anywhere in the tree suffices -- but only if
> > 	a grace period is currently in progress.
> > 
> > 4.	It is possible that the RCU grace-period kthread has not yet
> > 	started, and this case must be handled appropriately.
> > 
> > However, the general approach of using a tree to control lock contention
> > is still in place.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > ---
> >  kernel/rcu/tree.c | 92 +++++++++++++++++++++----------------------------------
> >  1 file changed, 35 insertions(+), 57 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 94519c7d552f..d3c769502929 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1682,74 +1682,52 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
> >  {
> >  	bool ret = false;
> >  	struct rcu_state *rsp = rdp->rsp;
> > -	struct rcu_node *rnp_root = rcu_get_root(rsp);
> > -
> > -	raw_lockdep_assert_held_rcu_node(rnp);
> > -
> > -	/* If the specified GP is already known needed, return to caller. */
> > -	trace_rcu_this_gp(rnp, rdp, c, TPS("Startleaf"));
> > -	if (need_future_gp_element(rnp, c)) {
> > -		trace_rcu_this_gp(rnp, rdp, c, TPS("Prestartleaf"));
> > -		goto out;
> > -	}
> > +	struct rcu_node *rnp_root;
> >  
> >  	/*
> > -	 * If this rcu_node structure believes that a grace period is in
> > -	 * progress, then we must wait for the one following, which is in
> > -	 * "c".  Because our request will be noticed at the end of the
> > -	 * current grace period, we don't need to explicitly start one.
> > +	 * Use funnel locking to either acquire the root rcu_node
> > +	 * structure's lock or bail out if the need for this grace period
> > +	 * has already been recorded -- or has already started.  If there
> > +	 * is already a grace period in progress in a non-leaf node, no
> > +	 * recording is needed because the end of the grace period will
> > +	 * scan the leaf rcu_node structures.  Note that rnp->lock must
> > +	 * not be released.
> >  	 */
> > -	if (rnp->gpnum != rnp->completed) {
> > -		need_future_gp_element(rnp, c) = true;
> > -		trace_rcu_this_gp(rnp, rdp, c, TPS("Startedleaf"));
> > -		goto out;
> 
> Referring to the above negative diff as [1] (which I wanted to refer to later
> in this message..)
> 
> > +	raw_lockdep_assert_held_rcu_node(rnp);
> > +	trace_rcu_this_gp(rnp, rdp, c, TPS("Startleaf"));
> > +	for (rnp_root = rnp; 1; rnp_root = rnp_root->parent) {
> > +		if (rnp_root != rnp)
> > +			raw_spin_lock_rcu_node(rnp_root);
> > +		if (need_future_gp_element(rnp_root, c) ||
> > +		    ULONG_CMP_GE(rnp_root->gpnum, c) ||
> > +		    (rnp != rnp_root &&
> > +		     rnp_root->gpnum != rnp_root->completed)) {
> > +			trace_rcu_this_gp(rnp_root, rdp, c, TPS("Prestarted"));
> > +			goto unlock_out;
> 
> I was a bit confused about the implementation of the above for loop:
> 
> In the previous code (which I refer to in the negative diff [1]), we were
> checking the leaf, and if the leaf believed that RCU was not idle, then we
> were marking the need for the future GP and quitting this function. In the
> new code, it seems like even if the leaf believes RCU is not-idle, we still
> go all the way up the tree.
> 
> I think the big change is, in the above new for loop, we either bail of if a
> future GP need was already marked by an intermediate node, or we go marking
> up the whole tree about the need for one.
> 
> If a leaf believes RCU is not idle, can we not just mark the future GP need
> like before and return? It seems we would otherwise increase the lock
> contention since now we lock intermediate nodes and then finally even the
> root. Where as before we were not doing that if the leaf believed RCU was not
> idle.
> 
> I am sorry if I missed something obvious.

The trick is that we do the check before we have done the marking.
So if we bailed, we would not have marked at all.  If we are at an
intermediate node and a grace period is in progress, we do bail.

You are right that this means that we (perhaps unnecessarily) acquire
the lock of the parent rcu_node, which might or might not be the root.
And on systems with default fanout with 1024 CPUs or fewer, yes, it will
be the root, and yes, this is the common case.  So might be well worth
improving.

One way to implement the old mark-and-return approach as you suggest
above would be as shown below (untested, probably doesn't build, and
against current rcu/dev).  What do you think?

> The other thing is we now don't have the 'Startedleaf' trace like we did
> before. I sent a patch to remove it, but I think the removal of that is
> somehow connected to what I was just talking about.. and I was thinking if we
> should really remove it. Should we add the case for checking leaves only back
> or is that a bad thing to do?

Suppose I got hit by a bus and you were stuck with the job of debugging
this.  What traces would you want and where would they be?  Keeping in
mind that too-frequent traces have their problems as well.

(Yes, I will be trying very hard to avoid this scenario for as long as
I can, but this might be a good way for you (and everyone else) to be
thinking about this.)

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1abe29a43944..abf3195e01dc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1585,6 +1585,8 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 			goto unlock_out;
 		}
 		rnp_root->gp_seq_needed = c;
+		if (rcu_seq_state(rcu_seq_current(&rnp_root->gp_seq)))
+			goto unlock_out;
 		if (rnp_root != rnp && rnp_root->parent != NULL)
 			raw_spin_unlock_rcu_node(rnp_root);
 		if (!rnp_root->parent)
