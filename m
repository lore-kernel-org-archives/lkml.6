Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933956AbeCGPsJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:48:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933386AbeCGPsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:48:03 -0500
Date: Wed, 7 Mar 2018 07:48:29 -0800
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307084944.10229-1-boqun.feng@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18030715-0008-0000-0000-000002E0D4C6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008629; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00999627; UDB=6.00508477; IPR=6.00779033;
 MB=3.00019894; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-07 15:47:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030715-0009-0000-0000-0000387CF69C
Message-Id: <20180307154829.GE3918@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803070182
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 04:49:39PM +0800, Boqun Feng wrote:
> Since commit d9a3da0699b2 ("rcu: Add expedited grace-period support for
> preemptible RCU"), there are comments for some funtions in
> rcu_report_exp_rnp()'s call-chain saying that exp_mutex or its
> predecessors needs to be held.
> 
> However, exp_mutex and its predecessors are merely used for synchronize
> between GPs, and it's clearly that all variables visited by those
> functions are under the protection of rcu_node's ->lock. Moreover, those
> functions are currently called without held exp_mutex, and seems that
> doesn't introduce any trouble.
> 
> So this patch fix this problem by correcting the comments
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Fixes: d9a3da0699b2 ("rcu: Add expedited grace-period support for preemptible RCU")

Good catch, applied!

These have been around for almost a decade!  ;-)  They happened because
I ended up rewriting expedited support several times before it was
accepted, and apparently failed to update the comments towards the end.

So thank you for catching this one!

But wouldn't it be better to use lockdep instead of comments in this case?

							Thanx, Paul

> ---
>  kernel/rcu/tree_exp.h | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index f8e4571efabf..2fd882b08b7c 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -154,7 +154,7 @@ static void __maybe_unused sync_exp_reset_tree(struct rcu_state *rsp)
>   * for the current expedited grace period.  Works only for preemptible
>   * RCU -- other RCU implementation use other means.
>   *
> - * Caller must hold the rcu_state's exp_mutex.
> + * Caller must hold the specificed rcu_node structure's ->lock
>   */
>  static bool sync_rcu_preempt_exp_done(struct rcu_node *rnp)
>  {
> @@ -170,8 +170,7 @@ static bool sync_rcu_preempt_exp_done(struct rcu_node *rnp)
>   * recursively up the tree.  (Calm down, calm down, we do the recursion
>   * iteratively!)
>   *
> - * Caller must hold the rcu_state's exp_mutex and the specified rcu_node
> - * structure's ->lock.
> + * Caller must hold the specified rcu_node structure's ->lock.
>   */
>  static void __rcu_report_exp_rnp(struct rcu_state *rsp, struct rcu_node *rnp,
>  				 bool wake, unsigned long flags)
> @@ -207,8 +206,6 @@ static void __rcu_report_exp_rnp(struct rcu_state *rsp, struct rcu_node *rnp,
>  /*
>   * Report expedited quiescent state for specified node.  This is a
>   * lock-acquisition wrapper function for __rcu_report_exp_rnp().
> - *
> - * Caller must hold the rcu_state's exp_mutex.
>   */
>  static void __maybe_unused rcu_report_exp_rnp(struct rcu_state *rsp,
>  					      struct rcu_node *rnp, bool wake)
> @@ -221,8 +218,7 @@ static void __maybe_unused rcu_report_exp_rnp(struct rcu_state *rsp,
> 
>  /*
>   * Report expedited quiescent state for multiple CPUs, all covered by the
> - * specified leaf rcu_node structure.  Caller must hold the rcu_state's
> - * exp_mutex.
> + * specified leaf rcu_node structure.
>   */
>  static void rcu_report_exp_cpu_mult(struct rcu_state *rsp, struct rcu_node *rnp,
>  				    unsigned long mask, bool wake)
> -- 
> 2.16.2
> 
