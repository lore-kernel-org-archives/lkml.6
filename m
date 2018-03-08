Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754755AbeCHE3t (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 23:29:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50750 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750761AbeCHE3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 23:29:48 -0500
Date: Wed, 7 Mar 2018 20:30:17 -0800
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308034627.n2xw32zzujnmy2gb@tardis>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18030804-0008-0000-0000-000002E160F2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008632; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00999881; UDB=6.00508594; IPR=6.00779253;
 MB=3.00019906; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-08 04:29:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030804-0009-0000-0000-0000387EAC27
Message-Id: <20180308043017.GL3918@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803080054
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 11:46:27AM +0800, Boqun Feng wrote:
> On Wed, Mar 07, 2018 at 07:48:29AM -0800, Paul E. McKenney wrote:
> > On Wed, Mar 07, 2018 at 04:49:39PM +0800, Boqun Feng wrote:
> > > Since commit d9a3da0699b2 ("rcu: Add expedited grace-period support for
> > > preemptible RCU"), there are comments for some funtions in
> > > rcu_report_exp_rnp()'s call-chain saying that exp_mutex or its
> > > predecessors needs to be held.
> > > 
> > > However, exp_mutex and its predecessors are merely used for synchronize
> > > between GPs, and it's clearly that all variables visited by those
> > > functions are under the protection of rcu_node's ->lock. Moreover, those
> > > functions are currently called without held exp_mutex, and seems that
> > > doesn't introduce any trouble.
> > > 
> > > So this patch fix this problem by correcting the comments
> > > 
> > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > Fixes: d9a3da0699b2 ("rcu: Add expedited grace-period support for preemptible RCU")
> > 
> > Good catch, applied!
> > 
> > These have been around for almost a decade!  ;-)  They happened because
> > I ended up rewriting expedited support several times before it was
> > accepted, and apparently failed to update the comments towards the end.
> > 
> > So thank you for catching this one!
> > 
> > But wouldn't it be better to use lockdep instead of comments in this case?
> > 
> 
> Agreed. That's a good idea. And I might find something about this, so I
> add this for sync_rcu_preempt_exp_done(), 
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 2fd882b08b7c..1fa394fe2f8a 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -20,6 +20,8 @@
>   * Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>   */
>  
> +#include <linux/lockdep.h>
> +
>  /*
>   * Record the start of an expedited grace period.
>   */
> @@ -158,6 +160,8 @@ static void __maybe_unused sync_exp_reset_tree(struct rcu_state *rsp)
>   */
>  static bool sync_rcu_preempt_exp_done(struct rcu_node *rnp)
>  {
> +	BUG_ON(!lockdep_is_held(&rnp->lock));
> +
>  	return rnp->exp_tasks == NULL &&
>  	       READ_ONCE(rnp->expmask) == 0;
>  }
> 
> And I could got this with rcutorture (--configs TREE03 --bootargs
> "rcutorture.gp_exp=1" --duration 10 --kconfig "CONFIG_PROVE_LOCKING=y"):

Certainly stronger medicine than the comment!  ;-)

> [    0.013629] ------------[ cut here ]------------
> [    0.014000] kernel BUG at /home/fixme/linux-rcu/kernel/rcu/tree_exp.h:163!
> [    0.014009] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [    0.014697] Modules linked in:
> [    0.014992] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.16.0-rc1+ #1
> [    0.015000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-20171110_100015-anatol 04/01/2014
> [    0.015000] RIP: 0010:sync_rcu_preempt_exp_done+0x30/0x40
> [    0.015000] RSP: 0000:ffffffffb7003d00 EFLAGS: 00010246
> [    0.015000] RAX: 0000000000000000 RBX: ffffffffb7064d00 RCX: 0000000000000003
> [    0.015000] RDX: 0000000080000003 RSI: ffffffffb7064d18 RDI: ffffffffb7024da8
> [    0.015000] RBP: ffffffffb7064d00 R08: 0000000000000000 R09: 0000000000000000
> [    0.015000] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffb70686d0
> [    0.015000] R13: ffffffffb765e2e0 R14: ffffffffb7064d00 R15: 0000000000000004
> [    0.015000] FS:  0000000000000000(0000) GS:ffff94fb9fc00000(0000) knlGS:0000000000000000
> [    0.015000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.015000] CR2: ffff94fb8e57f000 CR3: 000000000d01e000 CR4: 00000000000006f0
> [    0.015000] Call Trace:
> [    0.015000]  rcu_exp_wait_wake+0x6d/0x9e0
> [    0.015000]  ? rcu_cleanup_dead_rnp+0x90/0x90
> [    0.015000]  ? rcu_report_exp_cpu_mult+0x60/0x60
> [    0.015000]  _synchronize_rcu_expedited+0x680/0x6f0
> [    0.015000]  ? rcu_cleanup_dead_rnp+0x90/0x90
> [    0.015000]  ? acpi_hw_read_port+0x4c/0xc2
> [    0.015000]  ? acpi_hw_read+0xf4/0x153
> [    0.015000]  synchronize_rcu.part.79+0x53/0x60
> [    0.015000]  ? acpi_read_bit_register+0x38/0x69
> [    0.015000]  rcu_test_sync_prims+0x5/0x20
> [    0.015000]  rest_init+0x6/0xc0
> [    0.015000]  start_kernel+0x447/0x467
> [    0.015000]  secondary_startup_64+0xa5/0xb0
> [    0.015000] Code: ff 48 89 fb 48 83 c7 18 e8 9e 52 fd ff 85 c0 74 1a 31 c0 48 83 bb c0 00 00 00 00 74 02 5b c3 48 8b 43 68 5b 48 85 c0 0f 94 c0 c3 <0f> 0b 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 41 56 49 89 fe 
> [    0.015000] RIP: sync_rcu_preempt_exp_done+0x30/0x40 RSP: ffffffffb7003d00
> [    0.015007] ---[ end trace 09539f6b90637d6c ]---
> 
> 
> And I found in rcu_exp_wait_wake(), some of sync_rcu_preempt_exp_done()
> are not protected by rcu_node's lock. I have a straight-forward fix
> (along with the debug changes I mention above).
> 
> With this fix, rcutorture doesn't complain about the lock missing
> anymore. I will continue to investigate whether missing lock is a
> problem, but in the meanwhile, looking forward to your insight ;-)
> 
> Regards,
> Boqun
> ---------------------------------->8
> Subject: [PATCH] rcu: exp: Protect sync_rcu_preempt_exp_done() with rcu_node
>  lock
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  kernel/rcu/tree_exp.h | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 2fd882b08b7c..0001ac0ce6a7 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -20,6 +20,8 @@
>   * Authors: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>   */
>  
> +#include <linux/lockdep.h>
> +
>  /*
>   * Record the start of an expedited grace period.
>   */
> @@ -158,10 +160,30 @@ static void __maybe_unused sync_exp_reset_tree(struct rcu_state *rsp)
>   */
>  static bool sync_rcu_preempt_exp_done(struct rcu_node *rnp)
>  {
> +	BUG_ON(!lockdep_is_held(&rnp->lock));
> +
>  	return rnp->exp_tasks == NULL &&
>  	       READ_ONCE(rnp->expmask) == 0;
>  }
>  
> +/*
> + * Like sync_rcu_preempt_exp_done(), but this function assumes the caller
> + * doesn't hold the rcu_node's ->lock, and will acquire and release the lock
> + * itself
> + */
> +static bool sync_rcu_preempt_exp_done_unlocked(struct rcu_node *rnp)
> +{
> +	unsigned long flags;
> +	bool ret;
> +
> +	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> +	ret = sync_rcu_preempt_exp_done(rnp);

Let's see...  The sync_rcu_preempt_exp_done() function checks the
->exp_tasks pointer and the ->expmask bitmask.  The number of bits in the
mask can only decrease, and the ->exp_tasks pointer can only transition
from NULL to non-NULL when there is at least one bit set.  However,
there is no ordering in sync_rcu_preempt_exp_done(), so it is possible
that it could be fooled without the lock:

o	CPU 0 in sync_rcu_preempt_exp_done() reads ->exp_tasks and
	sees that it is NULL.

o	CPU 1 blocks within an RCU read-side critical section, so
	it enqueues the task and points ->exp_tasks at it and
	clears CPU 1's bit in ->expmask.

o	All other CPUs clear their bits in ->expmask.

o	CPU 0 reads ->expmask, sees that it is zero, so incorrectly
	concludes that all quiescent states have completed, despite
	the fact that ->exp_tasks is non-NULL.

So it seems to me that the lock is needed.  Good catch!!!  The problem
would occur only if the task running on CPU 0 received a spurious
wakeup, but that could potentially happen.

If lock contention becomes a problem, memory-ordering tricks could be
applied, but the lock is of course simpler.

I am guessing that this is a prototype patch, and that you are planning
to add lockdep annotations in more places, but either way please let
me know.

						Thanx, Paul

> +	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> +
> +	return ret;
> +}
> +
> +
>  /*
>   * Report the exit from RCU read-side critical section for the last task
>   * that queued itself during or before the current expedited preemptible-RCU
> @@ -490,6 +512,7 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
>  	struct rcu_node *rnp;
>  	struct rcu_node *rnp_root = rcu_get_root(rsp);
>  	int ret;
> +	unsigned long flags;
>  
>  	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("startwait"));
>  	jiffies_stall = rcu_jiffies_till_stall_check();
> @@ -498,9 +521,9 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
>  	for (;;) {
>  		ret = swait_event_timeout(
>  				rsp->expedited_wq,
> -				sync_rcu_preempt_exp_done(rnp_root),
> +				sync_rcu_preempt_exp_done_unlocked(rnp_root),
>  				jiffies_stall);
> -		if (ret > 0 || sync_rcu_preempt_exp_done(rnp_root))
> +		if (ret > 0 || sync_rcu_preempt_exp_done_unlocked(rnp_root))
>  			return;
>  		WARN_ON(ret < 0);  /* workqueues should not be signaled. */
>  		if (rcu_cpu_stall_suppress)
> @@ -533,8 +556,14 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
>  			rcu_for_each_node_breadth_first(rsp, rnp) {
>  				if (rnp == rnp_root)
>  					continue; /* printed unconditionally */
> -				if (sync_rcu_preempt_exp_done(rnp))
> +
> +				raw_spin_lock_irqsave_rcu_node(rnp, flags);
> +				if (sync_rcu_preempt_exp_done(rnp)) {
> +					raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  					continue;
> +				}
> +				raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> +
>  				pr_cont(" l=%u:%d-%d:%#lx/%c",
>  					rnp->level, rnp->grplo, rnp->grphi,
>  					rnp->expmask,
> -- 
> 2.16.2
> 
