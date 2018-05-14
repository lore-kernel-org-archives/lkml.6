Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeENR71 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:59:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750750AbeENR70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:59:26 -0400
Date: Mon, 14 May 2018 11:00:27 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH RFC 5/8] rcu: Use rcu_node as temporary variable in
 funnel locking loop
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180514031541.67247-1-joel@joelfernandes.org>
 <20180514031541.67247-6-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514031541.67247-6-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051417-0008-0000-0000-00000307534E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009025; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032272; UDB=6.00527718; IPR=6.00811403;
 MB=3.00021110; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 17:58:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051417-0009-0000-0000-0000393F5881
Message-Id: <20180514180027.GC26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140181
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 08:15:38PM -0700, Joel Fernandes (Google) wrote:
> The funnel locking loop in rcu_start_this_gp uses rcu_root as a
> temporary variable while walking the combining tree. This causes a
> tiresome exercise of a code reader reminding themselves that rcu_root
> may not be root. Lets just call it rcu_node, and then finally when
> rcu_node is the rcu_root, lets assign it at that time.
> 
> Just a clean up patch, no logical change.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

I agree that my names could use some improvement, but given that you
called it rnp_node in the patch and rcu_node in the commit log, I would
argue that rnp_node has a Hamming-distance problem.  ;-)

How about rnp_start for the formal parameter, rnp for the cursor running
up the tree, and retaining rnp_root for the root?

I considered and rejected the thought of rnp_leaf for the formal
parameter because this function is not necessarily called with a leaf
rcu_node structure.

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 9f5679ba413b..40670047d22c 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1568,7 +1568,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
>  {
>  	bool ret = false;
>  	struct rcu_state *rsp = rdp->rsp;
> -	struct rcu_node *rnp_root;
> +	struct rcu_node *rnp_node, *rnp_root = NULL;
> 
>  	/*
>  	 * Use funnel locking to either acquire the root rcu_node
> @@ -1581,24 +1581,26 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
>  	 */
>  	raw_lockdep_assert_held_rcu_node(rnp);
>  	trace_rcu_this_gp(rnp, rdp, gp_seq_start, TPS("Startleaf"));
> -	for (rnp_root = rnp; 1; rnp_root = rnp_root->parent) {
> -		if (rnp_root != rnp)
> -			raw_spin_lock_rcu_node(rnp_root);
> -		if (ULONG_CMP_GE(rnp_root->gp_seq_needed, gp_seq_start) ||
> -		    rcu_seq_done(&rnp_root->gp_seq, gp_seq_start) ||
> -		    (rnp != rnp_root &&
> -		     rcu_seq_state(rcu_seq_current(&rnp_root->gp_seq)))) {
> -			trace_rcu_this_gp(rnp_root, rdp, gp_seq_start,
> +	for (rnp_node = rnp; 1; rnp_node = rnp_node->parent) {
> +		if (rnp_node != rnp)
> +			raw_spin_lock_rcu_node(rnp_node);
> +		if (ULONG_CMP_GE(rnp_node->gp_seq_needed, gp_seq_start) ||
> +		    rcu_seq_done(&rnp_node->gp_seq, gp_seq_start) ||
> +		    (rnp != rnp_node &&
> +		     rcu_seq_state(rcu_seq_current(&rnp_node->gp_seq)))) {
> +			trace_rcu_this_gp(rnp_node, rdp, gp_seq_start,
>  					  TPS("Prestarted"));
>  			goto unlock_out;
>  		}
> -		rnp_root->gp_seq_needed = gp_seq_start;
> +		rnp_node->gp_seq_needed = gp_seq_start;
>  		if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq)))
>  			goto unlock_out;
> -		if (rnp_root != rnp && rnp_root->parent != NULL)
> -			raw_spin_unlock_rcu_node(rnp_root);
> -		if (!rnp_root->parent)
> +		if (rnp_node != rnp && rnp_node->parent != NULL)
> +			raw_spin_unlock_rcu_node(rnp_node);
> +		if (!rnp_node->parent) {
> +			rnp_root = rnp_node;
>  			break;  /* At root, and perhaps also leaf. */
> +		}
>  	}
> 
>  	/* If GP already in progress, just leave, otherwise start one. */
> @@ -1616,10 +1618,10 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
>  	trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gp_seq), TPS("newreq"));
>  	ret = true;  /* Caller must wake GP kthread. */
>  unlock_out:
> -	if (rnp != rnp_root)
> -		raw_spin_unlock_rcu_node(rnp_root);
> +	if (rnp != rnp_node)
> +		raw_spin_unlock_rcu_node(rnp_node);
>  	/* Push furthest requested GP to leaf node and rcu_data structure. */
> -	if (ULONG_CMP_GE(rnp_root->gp_seq_needed, gp_seq_start)) {
> +	if (ULONG_CMP_GE(rnp_node->gp_seq_needed, gp_seq_start)) {
>  		rnp->gp_seq_needed = gp_seq_start;
>  		rdp->gp_seq_needed = gp_seq_start;
>  	}
> -- 
> 2.17.0.441.gb46fe60e1d-goog
> 
