Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935659AbeCCAyQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 19:54:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935181AbeCCAyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 19:54:15 -0500
Date: Fri, 2 Mar 2018 16:54:41 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Byungchul Park <byungchul.park@lge.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [PATCH] rcu: Remove deprecated RCU debugfs tracing code
Reply-To: paulmck@linux.vnet.ibm.com
References: <1519976352-25400-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519976352-25400-1-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18030300-0056-0000-0000-0000042760DE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008611; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00997508; UDB=6.00507213; IPR=6.00776827;
 MB=3.00019827; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-03 00:54:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030300-0057-0000-0000-0000086962EB
Message-Id: <20180303005441.GB3918@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-02_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803030010
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 04:39:12PM +0900, Byungchul Park wrote:
> Commit ae91aa0adb14(rcu: Remove debugfs tracing) removed the RCU debugfs
> tracing code, and left deprecated code.
> 
> Because exp_workdone{0,1,2,3} won't be used anymore since the commit,
> it's better to remove code to do with those variables. Remove it.
> 
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>

Good catch, queued for testing and review, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tree.h     |  4 ----
>  kernel/rcu/tree_exp.h | 13 +++++--------
>  2 files changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 9dd0ea7..cfeb351 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -234,10 +234,6 @@ struct rcu_data {
>  #ifdef CONFIG_RCU_FAST_NO_HZ
>  	struct rcu_head oom_head;
>  #endif /* #ifdef CONFIG_RCU_FAST_NO_HZ */
> -	atomic_long_t exp_workdone0;	/* # done by workqueue. */
> -	atomic_long_t exp_workdone1;	/* # done by others #1. */
> -	atomic_long_t exp_workdone2;	/* # done by others #2. */
> -	atomic_long_t exp_workdone3;	/* # done by others #3. */
>  	int exp_dynticks_snap;		/* Double-check need for IPI. */
> 
>  	/* 6) Callback offloading. */
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 73e1d3d..f8e4571 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -248,14 +248,12 @@ static void rcu_report_exp_rdp(struct rcu_state *rsp, struct rcu_data *rdp,
>  }
> 
>  /* Common code for synchronize_{rcu,sched}_expedited() work-done checking. */
> -static bool sync_exp_work_done(struct rcu_state *rsp, atomic_long_t *stat,
> -			       unsigned long s)
> +static bool sync_exp_work_done(struct rcu_state *rsp, unsigned long s)
>  {
>  	if (rcu_exp_gp_seq_done(rsp, s)) {
>  		trace_rcu_exp_grace_period(rsp->name, s, TPS("done"));
>  		/* Ensure test happens before caller kfree(). */
>  		smp_mb__before_atomic(); /* ^^^ */
> -		atomic_long_inc(stat);
>  		return true;
>  	}
>  	return false;
> @@ -289,7 +287,7 @@ static bool exp_funnel_lock(struct rcu_state *rsp, unsigned long s)
>  	 * promoting locality and is not strictly needed for correctness.
>  	 */
>  	for (; rnp != NULL; rnp = rnp->parent) {
> -		if (sync_exp_work_done(rsp, &rdp->exp_workdone1, s))
> +		if (sync_exp_work_done(rsp, s))
>  			return true;
> 
>  		/* Work not done, either wait here or go up. */
> @@ -302,8 +300,7 @@ static bool exp_funnel_lock(struct rcu_state *rsp, unsigned long s)
>  						  rnp->grplo, rnp->grphi,
>  						  TPS("wait"));
>  			wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
> -				   sync_exp_work_done(rsp,
> -						      &rdp->exp_workdone2, s));
> +				   sync_exp_work_done(rsp, s));
>  			return true;
>  		}
>  		rnp->exp_seq_rq = s; /* Followers can wait on us. */
> @@ -313,7 +310,7 @@ static bool exp_funnel_lock(struct rcu_state *rsp, unsigned long s)
>  	}
>  	mutex_lock(&rsp->exp_mutex);
>  fastpath:
> -	if (sync_exp_work_done(rsp, &rdp->exp_workdone3, s)) {
> +	if (sync_exp_work_done(rsp, s)) {
>  		mutex_unlock(&rsp->exp_mutex);
>  		return true;
>  	}
> @@ -661,7 +658,7 @@ static void _synchronize_rcu_expedited(struct rcu_state *rsp,
>  	rdp = per_cpu_ptr(rsp->rda, raw_smp_processor_id());
>  	rnp = rcu_get_root(rsp);
>  	wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
> -		   sync_exp_work_done(rsp, &rdp->exp_workdone0, s));
> +		   sync_exp_work_done(rsp, s));
>  	smp_mb(); /* Workqueue actions happen before return. */
> 
>  	/* Let the next expedited grace period start. */
> -- 
> 1.9.1
> 
