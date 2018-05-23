Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754729AbeEWQQ3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:16:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751646AbeEWQQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:16:26 -0400
Date: Wed, 23 May 2018 09:06:40 -0700
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
Subject: Re: [PATCH 4/4] rcu: Identify grace period is in progress as we
 advance up the tree
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180523063815.198302-1-joel@joelfernandes.org>
 <20180523063815.198302-5-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523063815.198302-5-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052316-0012-0000-0000-0000164BF96F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009072; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036558; UDB=6.00530282; IPR=6.00815685;
 MB=3.00021260; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-23 16:16:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052316-0013-0000-0000-000052E8672F
Message-Id: <20180523160640.GN3803@linux.vnet.ibm.com>
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

On Tue, May 22, 2018 at 11:38:15PM -0700, Joel Fernandes wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> There's no need to keep checking the same starting node for whether a
> grace period is in progress as we advance up the funnel lock loop. Its
> sufficient if we just checked it in the start, and then subsequently
> checked the internal nodes as we advanced up the combining tree. This
> also makes sense because the grace-period updates propogate from the
> root to the leaf, so there's a chance we may find a grace period has
> started as we advance up, lets check for the same.
> 
> Reported-by: Paul McKenney <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Looks good, queued for further review and testing, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 31f4b4b7d824..65e49282429c 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1570,11 +1570,12 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
>  			goto unlock_out;
>  		}
>  		rnp->gp_seq_needed = gp_seq_req;
> -		if (rcu_seq_state(rcu_seq_current(&rnp_start->gp_seq))) {
> +		if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq))) {
>  			/*
> -			 * We just marked the leaf, and a grace period
> -			 * is in progress, which means that rcu_gp_cleanup()
> -			 * will see the marking.  Bail to reduce contention.
> +			 * We just marked the leaf or internal node, and a
> +			 * grace period is in progress, which means that
> +			 * rcu_gp_cleanup() will see the marking.  Bail to
> +			 * reduce contention.
>  			 */
>  			trace_rcu_this_gp(rnp_start, rdp, gp_seq_req,
>  					  TPS("Startedleaf"));
> -- 
> 2.17.0.441.gb46fe60e1d-goog
> 
