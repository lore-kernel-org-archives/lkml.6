Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeENSLB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:11:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36852 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750750AbeENSLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:11:00 -0400
Date: Mon, 14 May 2018 11:12:27 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH RFC 3/8] rcu: Add back the cpuend tracepoint
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180514031541.67247-1-joel@joelfernandes.org>
 <20180514031541.67247-4-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514031541.67247-4-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051418-0040-0000-0000-0000042B2792
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009025; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032276; UDB=6.00527720; IPR=6.00811407;
 MB=3.00021110; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 18:10:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051418-0041-0000-0000-000008313B4E
Message-Id: <20180514181227.GE26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140183
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 08:15:36PM -0700, Joel Fernandes (Google) wrote:
> Commit be4b8beed87d ("rcu: Move RCU's grace-period-change code to ->gp_seq")
> removed the cpuend grace period trace point. This patch adds it back.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Good catch!!!  I queued this to be squashed into the offending commit,
with attribution.

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 9ad931bff409..29ccc60bdbfc 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1774,10 +1774,12 @@ static bool __note_gp_changes(struct rcu_state *rsp, struct rcu_node *rnp,
> 
>  	/* Handle the ends of any preceding grace periods first. */
>  	if (rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) ||
> -	    unlikely(READ_ONCE(rdp->gpwrap)))
> +	    unlikely(READ_ONCE(rdp->gpwrap))) {
>  		ret = rcu_advance_cbs(rsp, rnp, rdp); /* Advance callbacks. */
> -	else
> +		trace_rcu_grace_period(rsp->name, rdp->gp_seq, TPS("cpuend"));
> +	} else {
>  		ret = rcu_accelerate_cbs(rsp, rnp, rdp); /* Recent callbacks. */
> +	}
> 
>  	/* Now handle the beginnings of any new-to-this-CPU grace periods. */
>  	if (rcu_seq_new_gp(rdp->gp_seq, rnp->gp_seq) ||
> -- 
> 2.17.0.441.gb46fe60e1d-goog
> 
