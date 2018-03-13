Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932316AbeCMAPN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 20:15:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932222AbeCMAPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 20:15:11 -0400
Date: Mon, 12 Mar 2018 17:15:45 -0700
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
 <20180308154255.GM3918@linux.vnet.ibm.com>
 <20180309065700.qseccsy3z3m72pa7@tardis>
 <20180309201707.GC3918@linux.vnet.ibm.com>
 <20180312052838.676fknxi4kvucgdd@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312052838.676fknxi4kvucgdd@tardis>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18031300-0040-0000-0000-0000040640C8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008662; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01002186; UDB=6.00509922; IPR=6.00781516;
 MB=3.00019996; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-13 00:15:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031300-0041-0000-0000-000008074A7A
Message-Id: <20180313001545.GR3918@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803130002
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 01:28:38PM +0800, Boqun Feng wrote:
> On Fri, Mar 09, 2018 at 12:17:07PM -0800, Paul E. McKenney wrote:
> > On Fri, Mar 09, 2018 at 02:57:00PM +0800, Boqun Feng wrote:
> > > On Thu, Mar 08, 2018 at 07:42:55AM -0800, Paul E. McKenney wrote:
> > > > On Thu, Mar 08, 2018 at 04:30:06PM +0800, Boqun Feng wrote:
> > > > > On Thu, Mar 08, 2018 at 12:54:29PM +0800, Boqun Feng wrote:
> > > > > > On Wed, Mar 07, 2018 at 08:30:17PM -0800, Paul E. McKenney wrote:
> > > > > > [...]
> > > > > > > >  
> > > > > > > > +/*
> > > > > > > > + * Like sync_rcu_preempt_exp_done(), but this function assumes the caller
> > > > > > > > + * doesn't hold the rcu_node's ->lock, and will acquire and release the lock
> > > > > > > > + * itself
> > > > > > > > + */
> > > > > > > > +static bool sync_rcu_preempt_exp_done_unlocked(struct rcu_node *rnp)
> > > > > > > > +{
> > > > > > > > +	unsigned long flags;
> > > > > > > > +	bool ret;
> > > > > > > > +
> > > > > > > > +	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > > > > > > > +	ret = sync_rcu_preempt_exp_done(rnp);
> > > > > > > 
> > > > > > > Let's see...  The sync_rcu_preempt_exp_done() function checks the
> > > > > > > ->exp_tasks pointer and the ->expmask bitmask.  The number of bits in the
> > > > > > > mask can only decrease, and the ->exp_tasks pointer can only transition
> > > > > > > from NULL to non-NULL when there is at least one bit set.  However,
> > > > > > > there is no ordering in sync_rcu_preempt_exp_done(), so it is possible
> > > > > > > that it could be fooled without the lock:
> > > > > > > 
> > > > > > > o	CPU 0 in sync_rcu_preempt_exp_done() reads ->exp_tasks and
> > > > > > > 	sees that it is NULL.
> > > > > > > 
> > > > > > > o	CPU 1 blocks within an RCU read-side critical section, so
> > > > > > > 	it enqueues the task and points ->exp_tasks at it and
> > > > > > > 	clears CPU 1's bit in ->expmask.
> > > > > > > 
> > > > > > > o	All other CPUs clear their bits in ->expmask.
> > > > > > > 
> > > > > > > o	CPU 0 reads ->expmask, sees that it is zero, so incorrectly
> > > > > > > 	concludes that all quiescent states have completed, despite
> > > > > > > 	the fact that ->exp_tasks is non-NULL.
> > > > > > > 
> > > > > > > So it seems to me that the lock is needed.  Good catch!!!  The problem
> > > > > > > would occur only if the task running on CPU 0 received a spurious
> > > > > > > wakeup, but that could potentially happen.
> > > > > > 
> > > > > > Thanks for the analysis ;-)
> > > > 
> > > > The other limitation is that it occurs only on systems small enough
> > > > to have a single-node rcu_node tree.  But still...
> > > > 
> > > > > > > If lock contention becomes a problem, memory-ordering tricks could be
> > > > > > > applied, but the lock is of course simpler.
> > > > > > > 
> > > > > > 
> > > > > > Agreed.
> > > > > > 
> > > > > > > I am guessing that this is a prototype patch, and that you are planning
> > > > > > 
> > > > > > Yes, this is a prototype. And I'm preparing a proper patch to send
> > > > > > later.
> > > > 
> > > > Very good, thank you!
> > > > 
> > > > > > > to add lockdep annotations in more places, but either way please let
> > > > > > > me know.
> > > > > > 
> > > > > > Give it's a bug as per your analysis, I'd like to defer other lockdep
> > > > > > annotations and send this first. However, I'm currently getting other
> > > > > > lockdep splats after applying this, so I need to get that sorted first.
> > > > > 
> > > > > Hmm.. the other lockdep splat seems irrelevant with my patch, I could
> > > > > observe it on mainline using rcutorture with CONFIG_PROVE_LOCKING=y. I'd
> > > > > spend some more time on it, in the meanwhile, send a proper patch for
> > > > > this sync_rcu_preempt_exp_done().
> > > > 
> > > > I am not seeing that one, but am very interested in getting it fixed!  ;-)
> > > 
> > > Found the root cause, and send out the patch ;-)
> > 
> > Very good!  Still not sure why I don't see it, but as long as it is fixed!
> > 
> 
> One thing I could hit this is because I ran rcutorture with
> CONFIG_PROVE_LOCKING=y, maybe you could consider adding that in your
> rcutorture testsuite?

I also need to test without lockdep, but you are right that I should
certainly do a full-up lockdep once in a while!

							Thanx, Paul
