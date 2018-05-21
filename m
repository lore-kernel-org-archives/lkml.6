Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751421AbeEUXZv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 19:25:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751019AbeEUXZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 19:25:48 -0400
Date: Mon, 21 May 2018 16:25:38 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH v3 4/4] rcu: Unlock non-start node only after accessing
 its gp_seq_needed
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180521044220.123933-1-joel@joelfernandes.org>
 <20180521044220.123933-5-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521044220.123933-5-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052123-0008-0000-0000-0000030AF6A0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009063; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01035741; UDB=6.00529792; IPR=6.00814868;
 MB=3.00021229; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-21 23:24:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052123-0009-0000-0000-0000395433C7
Message-Id: <20180521232537.GJ3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805210267
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 09:42:20PM -0700, Joel Fernandes wrote:
> We acquire gp_seq_needed locklessly. To be safe, lets do the unlocking
> after the access.

Actually, no, we hold rnp_start's ->lock throughout.  And this CPU (or in
the case of no-CBs CPUs, this task) is in charge of rdp->gp_seq_needed,
so nothing else is accessing it.  Or at least that is the intent.  ;-)

One exception is CPU hotplug, but in that case, only the CPU doing the
hotplugging is allowed to touch rdp->gp_seq_needed and even then only
while the incoming/outgoing CPU is inactive.

							Thanx, Paul

> Signed-off-by: Joel Fernandes <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 879c67a31116..efbd21b2a1a6 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1603,13 +1603,13 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
>  	trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gp_seq), TPS("newreq"));
>  	ret = true;  /* Caller must wake GP kthread. */
>  unlock_out:
> -	if (rnp != rnp_start)
> -		raw_spin_unlock_rcu_node(rnp);
>  	/* Push furthest requested GP to leaf node and rcu_data structure. */
>  	if (ULONG_CMP_GE(rnp->gp_seq_needed, gp_seq_req)) {
>  		rnp_start->gp_seq_needed = gp_seq_req;
>  		rdp->gp_seq_needed = gp_seq_req;
>  	}
> +	if (rnp != rnp_start)
> +		raw_spin_unlock_rcu_node(rnp);
>  	return ret;
>  }
> 
> -- 
> 2.17.0.441.gb46fe60e1d-goog
> 
