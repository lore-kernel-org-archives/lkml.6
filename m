Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754633AbeCHRhR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:37:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43958 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752135AbeCHRhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:37:16 -0500
Date: Thu, 8 Mar 2018 09:37:47 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2] rcu: exp: Protect all sync_rcu_preempt_exp_done()
 with rcu_node lock
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180308084831.29674-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308084831.29674-1-boqun.feng@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18030817-2213-0000-0000-0000027CA0F9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008636; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01000134; UDB=6.00508695; IPR=6.00779464;
 MB=3.00019919; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-08 17:37:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030817-2214-0000-0000-0000595A3ACD
Message-Id: <20180308173747.GO3918@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803080199
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 04:48:27PM +0800, Boqun Feng wrote:
> Currently some callsites of sync_rcu_preempt_exp_done() are not called
> with the corresponding rcu_node's ->lock held, which could introduces
> bugs as per Paul:
> 
> o	CPU 0 in sync_rcu_preempt_exp_done() reads ->exp_tasks and
> 	sees that it is NULL.
> 
> o	CPU 1 blocks within an RCU read-side critical section, so
> 	it enqueues the task and points ->exp_tasks at it and
> 	clears CPU 1's bit in ->expmask.
> 
> o	All other CPUs clear their bits in ->expmask.
> 
> o	CPU 0 reads ->expmask, sees that it is zero, so incorrectly
> 	concludes that all quiescent states have completed, despite
> 	the fact that ->exp_tasks is non-NULL.
> 
> To fix this, sync_rcu_preempt_exp_unlocked() is introduced to replace
> lockless callsites of sync_rcu_preempt_exp_done().
> 
> Further, a lockdep annotation is added into sync_rcu_preempt_exp_done()
> to prevent mis-use in the future.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Again, good catch, applied for testing and review.  Thank you!

							Thanx, Paul

> ---
> v1 --> v2:
> 	Kill unnecessary blank lines
> 
> 
>  kernel/rcu/tree_exp.h | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 2fd882b08b7c..3f30cc3b7669 100644
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
> +	lockdep_assert_held(&rnp->lock);
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
> +	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> +
> +	return ret;
> +}
> +
> +
>  /*
>   * Report the exit from RCU read-side critical section for the last task
>   * that queued itself during or before the current expedited preemptible-RCU
> @@ -498,9 +520,9 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
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
> @@ -533,7 +555,7 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
>  			rcu_for_each_node_breadth_first(rsp, rnp) {
>  				if (rnp == rnp_root)
>  					continue; /* printed unconditionally */
> -				if (sync_rcu_preempt_exp_done(rnp))
> +				if (sync_rcu_preempt_exp_done_unlocked(rnp))
>  					continue;
>  				pr_cont(" l=%u:%d-%d:%#lx/%c",
>  					rnp->level, rnp->grplo, rnp->grphi,
> -- 
> 2.16.2
> 
