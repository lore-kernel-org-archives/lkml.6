Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752055AbeENSg7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:36:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59608 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751498AbeENSg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:36:58 -0400
Date: Mon, 14 May 2018 11:38:23 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH RFC 6/8] rcu: Add back the Startedleaf tracepoint
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180514031541.67247-1-joel@joelfernandes.org>
 <20180514031541.67247-7-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514031541.67247-7-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051418-0044-0000-0000-00000414264D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009025; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032285; UDB=6.00527725; IPR=6.00811416;
 MB=3.00021110; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 18:36:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051418-0045-0000-0000-0000084639D7
Message-Id: <20180514183823.GF26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140187
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 08:15:39PM -0700, Joel Fernandes (Google) wrote:
> In recent discussion [1], the check for whether a leaf believes RCU is
> not idle, is being added back to funnel locking code, to avoid more
> locking. In this we are marking the leaf node for a future grace-period
> and bailing out since a GP is currently in progress. However the
> tracepoint is missing. Lets add it back.
> 
> Also add a small comment about why we do this check (basically the point
> is to avoid locking intermediate nodes unnecessarily) and clarify the
> comments in the trace event header now that we are doing traversal of
> one or more intermediate nodes.
> 
> [1] http://lkml.kernel.org/r/20180513190906.GL26088@linux.vnet.ibm.com
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Looks like a good idea, but it does not apply -- which is not a surprise,
given the change rate in this code.  I hand-applied as a modification
to c1b3f9fce26f ("rcu: Don't funnel-lock above leaf node if GP in progress")
with attribution, but with the changes below.  Please let me know if I
am missing something.

Ah, I see -- this commit depends on your earlier name-change commit.
I therefore made this patch use the old names.

> ---
>  include/trace/events/rcu.h |  4 ++--
>  kernel/rcu/tree.c          | 11 ++++++++++-
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
> index 539900a9f8c7..dc0bd11739c7 100644
> --- a/include/trace/events/rcu.h
> +++ b/include/trace/events/rcu.h
> @@ -91,8 +91,8 @@ TRACE_EVENT(rcu_grace_period,
>   *
>   * "Startleaf": Request a grace period based on leaf-node data.
>   * "Prestarted": Someone beat us to the request
> - * "Startedleaf": Leaf-node start proved sufficient.
> - * "Startedleafroot": Leaf-node start proved sufficient after checking root.
> + * "Startedleaf": Leaf and one or more non-root nodes marked for future start.

Actually, we only get to that trace if all we did was mark the leaf
node, right?

> + * "Startedleafroot": all non-root nodes from leaf to root marked for future start.

I got rid of the "non-root" part, given that we had to have marked
the root to break out of the loop.

							Thanx, Paul

>   * "Startedroot": Requested a nocb grace period based on root-node data.
>   * "NoGPkthread": The RCU grace-period kthread has not yet started.
>   * "StartWait": Start waiting for the requested grace period.
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 40670047d22c..8401a253e7de 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1593,8 +1593,17 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
>  			goto unlock_out;
>  		}
>  		rnp_node->gp_seq_needed = gp_seq_start;
> -		if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq)))
> +
> +		/*
> +		 * Check if leaf believes a GP is in progress, if yes we can
> +		 * bail and avoid more locking. We have already marked the leaf.
> +		 */
> +		if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq))) {
> +			trace_rcu_this_gp(rnp_node, rdp, gp_seq_start,
> +					  TPS("Startedleaf"));
>  			goto unlock_out;
> +		}
> +
>  		if (rnp_node != rnp && rnp_node->parent != NULL)
>  			raw_spin_unlock_rcu_node(rnp_node);
>  		if (!rnp_node->parent) {
> -- 
> 2.17.0.441.gb46fe60e1d-goog
> 
