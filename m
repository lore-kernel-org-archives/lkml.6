Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754701AbeEWQQC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:16:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751646AbeEWQQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:16:00 -0400
Date: Wed, 23 May 2018 09:06:17 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>, byungchul.park@lge.com,
        Ingo Molnar <mingo@redhat.com>, Josh Triplett <josh@joshtriplett.org>,
        kernel-team@android.com, Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zilstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/4] rcu: Use better variable names in funnel locking loop
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180523063815.198302-1-joel@joelfernandes.org>
 <20180523063815.198302-4-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523063815.198302-4-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052316-0020-0000-0000-00000DFEE396
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009072; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036558; UDB=6.00530282; IPR=6.00815685;
 MB=3.00021260; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-23 16:15:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052316-0021-0000-0000-00006187058E
Message-Id: <20180523160617.GM3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-23_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805230160
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 11:38:14PM -0700, Joel Fernandes wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> The funnel locking loop in rcu_start_this_gp uses rcu_root as a
> temporary variable while walking the combining tree. This causes a
> tiresome exercise of a code reader reminding themselves that rcu_root
> may not be root. Lets just call it rnp, and rename other variables as
> well to be more appropriate.
> 
> Original patch: https://patchwork.kernel.org/patch/10396577/
> 
> Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

I used to have double Signed-off-by back when I was seconded to Linaro.
But I am guessing that you want the second and don't need the first
one.  Unless you tell me otherwise, I will remove the first one on
my next rebase.

Anyway, the new variable names are much more clear, good stuff,
queued for further review and testing, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 52 +++++++++++++++++++++++------------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 0ad61c97da69..31f4b4b7d824 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1526,7 +1526,7 @@ static void trace_rcu_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
> 
>  /*
>   * rcu_start_this_gp - Request the start of a particular grace period
> - * @rnp: The leaf node of the CPU from which to start.
> + * @rnp_start: The leaf node of the CPU from which to start.
>   * @rdp: The rcu_data corresponding to the CPU from which to start.
>   * @gp_seq_req: The gp_seq of the grace period to start.
>   *
> @@ -1540,12 +1540,12 @@ static void trace_rcu_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
>   *
>   * Returns true if the GP thread needs to be awakened else false.
>   */
> -static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
> +static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
>  			      unsigned long gp_seq_req)
>  {
>  	bool ret = false;
>  	struct rcu_state *rsp = rdp->rsp;
> -	struct rcu_node *rnp_root;
> +	struct rcu_node *rnp;
> 
>  	/*
>  	 * Use funnel locking to either acquire the root rcu_node
> @@ -1556,58 +1556,58 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
>  	 * scan the leaf rcu_node structures.  Note that rnp->lock must
>  	 * not be released.
>  	 */
> -	raw_lockdep_assert_held_rcu_node(rnp);
> -	trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startleaf"));
> -	for (rnp_root = rnp; 1; rnp_root = rnp_root->parent) {
> -		if (rnp_root != rnp)
> -			raw_spin_lock_rcu_node(rnp_root);
> -		if (ULONG_CMP_GE(rnp_root->gp_seq_needed, gp_seq_req) ||
> -		    rcu_seq_started(&rnp_root->gp_seq, gp_seq_req) ||
> -		    (rnp != rnp_root &&
> -		     rcu_seq_state(rcu_seq_current(&rnp_root->gp_seq)))) {
> -			trace_rcu_this_gp(rnp_root, rdp, gp_seq_req,
> +	raw_lockdep_assert_held_rcu_node(rnp_start);
> +	trace_rcu_this_gp(rnp_start, rdp, gp_seq_req, TPS("Startleaf"));
> +	for (rnp = rnp_start; 1; rnp = rnp->parent) {
> +		if (rnp != rnp_start)
> +			raw_spin_lock_rcu_node(rnp);
> +		if (ULONG_CMP_GE(rnp->gp_seq_needed, gp_seq_req) ||
> +		    rcu_seq_started(&rnp->gp_seq, gp_seq_req) ||
> +		    (rnp != rnp_start &&
> +		     rcu_seq_state(rcu_seq_current(&rnp->gp_seq)))) {
> +			trace_rcu_this_gp(rnp, rdp, gp_seq_req,
>  					  TPS("Prestarted"));
>  			goto unlock_out;
>  		}
> -		rnp_root->gp_seq_needed = gp_seq_req;
> -		if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq))) {
> +		rnp->gp_seq_needed = gp_seq_req;
> +		if (rcu_seq_state(rcu_seq_current(&rnp_start->gp_seq))) {
>  			/*
>  			 * We just marked the leaf, and a grace period
>  			 * is in progress, which means that rcu_gp_cleanup()
>  			 * will see the marking.  Bail to reduce contention.
>  			 */
> -			trace_rcu_this_gp(rnp, rdp, gp_seq_req,
> +			trace_rcu_this_gp(rnp_start, rdp, gp_seq_req,
>  					  TPS("Startedleaf"));
>  			goto unlock_out;
>  		}
> -		if (rnp_root != rnp && rnp_root->parent != NULL)
> -			raw_spin_unlock_rcu_node(rnp_root);
> -		if (!rnp_root->parent)
> +		if (rnp != rnp_start && rnp->parent != NULL)
> +			raw_spin_unlock_rcu_node(rnp);
> +		if (!rnp->parent)
>  			break;  /* At root, and perhaps also leaf. */
>  	}
> 
>  	/* If GP already in progress, just leave, otherwise start one. */
>  	if (rcu_gp_in_progress(rsp)) {
> -		trace_rcu_this_gp(rnp_root, rdp, gp_seq_req, TPS("Startedleafroot"));
> +		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startedleafroot"));
>  		goto unlock_out;
>  	}
> -	trace_rcu_this_gp(rnp_root, rdp, gp_seq_req, TPS("Startedroot"));
> +	trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startedroot"));
>  	WRITE_ONCE(rsp->gp_flags, rsp->gp_flags | RCU_GP_FLAG_INIT);
>  	rsp->gp_req_activity = jiffies;
>  	if (!rsp->gp_kthread) {
> -		trace_rcu_this_gp(rnp_root, rdp, gp_seq_req, TPS("NoGPkthread"));
> +		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("NoGPkthread"));
>  		goto unlock_out;
>  	}
>  	trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gp_seq), TPS("newreq"));
>  	ret = true;  /* Caller must wake GP kthread. */
>  unlock_out:
>  	/* Push furthest requested GP to leaf node and rcu_data structure. */
> -	if (ULONG_CMP_GE(rnp_root->gp_seq_needed, gp_seq_req)) {
> -		rnp->gp_seq_needed = gp_seq_req;
> +	if (ULONG_CMP_GE(rnp->gp_seq_needed, gp_seq_req)) {
> +		rnp_start->gp_seq_needed = gp_seq_req;
>  		rdp->gp_seq_needed = gp_seq_req;
>  	}
> -	if (rnp != rnp_root)
> -		raw_spin_unlock_rcu_node(rnp_root);
> +	if (rnp != rnp_start)
> +		raw_spin_unlock_rcu_node(rnp);
>  	return ret;
>  }
> 
> -- 
> 2.17.0.441.gb46fe60e1d-goog
> 
