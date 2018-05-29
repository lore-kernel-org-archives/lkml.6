Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933526AbeE2MAW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:00:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933135AbeE2MAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:00:18 -0400
Date: Tue, 29 May 2018 05:01:55 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Byungchul Park <byungchul.park@lge.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, joel@joelfernandes.org
Subject: Re: [RFC] rcu: Check the range of jiffies_till_xxx_fqs on setting
 them
Reply-To: paulmck@linux.vnet.ibm.com
References: <1527578616-5595-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527578616-5595-1-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052912-0040-0000-0000-00000436224E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009096; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01039349; UDB=6.00530820; IPR=6.00818476;
 MB=3.00021357; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-29 12:00:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052912-0041-0000-0000-0000083C46D0
Message-Id: <20180529120155.GC3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805290138
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 04:23:36PM +0900, Byungchul Park wrote:
> Hello Paul and folks,
> 
> I've thought the code should've been like the below since the range
> checking of jiffies_till_first_fqs and jiffies_till_next_fqs everytime
> in the loop of rcu_gp_kthread are unnecessary at all. However, it's ok
> even if you don't think it's worth doing it.

Nice!

> Secondly, I also think jiffies_till_first_fqs = 0 is meaningless so
> added checking and adjusting it as what's done on jiffies_till_next_fqs.
> Thought?

Actually, jiffies_till_first_fqs == 0 is very useful for cases where
at least one CPU is expected to be idle and grace-period latency is
important.  In this case, doing the first scan immediately gets the
dyntick-idle state recorded immediately, getting the idle CPUs out of
the way of the grace period immediately.

So why not do this scan as part of grace-period initialization?  Because
doing so consumes extra CPU and results in extra cache misses, which is
the opposite of what you want on a completely busy system, especially
one where the CPUs are context switching quickly.  Thus no scan during
grace-period initialization.

But I can see the desire to share code.

One approach would be to embed the kernel_params_ops structure inside
another structure containing the limits, then just have two structures.
Perhaps something like this already exists?  I don't see it right off,
but then again, I am not exactly an expert on module_param.

Thoughts?

							Thanx, Paul

> Thank you in advance.
> Byungchul
> 
> ----->8-----
> >From 67fecc15b44b2521de96de109782c04ce65afb85 Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul.park@lge.com>
> Date: Tue, 29 May 2018 15:49:26 +0900
> Subject: [RFC] rcu: Check the range of jiffies_till_xxx_fqs on setting them
> 
> Currently, the range of jiffies_till_first_fqs and jiffies_till_next_fqs
> are always checked and adjusted in the loop of rcu_gp_kthread on runtime.
> However, it would be better and enough to check them only on setting
> them, so remove unnecessary checking and adjusting in the loop.
> 
> Additionally, add adjusting jiffies_till_first_fqs so guaranteed to be
> greater than 0, which hasn't been done before.
> 
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> ---
>  kernel/rcu/tree.c | 38 +++++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 4e96761..4964237 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -518,8 +518,31 @@ void rcu_all_qs(void)
>  static ulong jiffies_till_next_fqs = ULONG_MAX;
>  static bool rcu_kick_kthreads;
> 
> -module_param(jiffies_till_first_fqs, ulong, 0644);
> -module_param(jiffies_till_next_fqs, ulong, 0644);
> +static int param_set_fqs_jiffies(const char *val, const struct kernel_param *kp)
> +{
> +	ulong tmp;
> +	int ret = kstrtoul(val, 0, &tmp);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (tmp > HZ)
> +		tmp = HZ;
> +	else if (tmp < 1)
> +		tmp = 1;
> +
> +	/* Prevent tearing */
> +	WRITE_ONCE(*(ulong *)kp->arg, tmp);
> +	return 0;
> +}
> +
> +static struct kernel_param_ops fqs_jiffies_ops = {
> +	.set = param_set_fqs_jiffies,
> +	.get = param_get_ulong,
> +};
> +
> +module_param_cb(jiffies_till_first_fqs, &fqs_jiffies_ops, &jiffies_till_first_fqs, 0644);
> +module_param_cb(jiffies_till_next_fqs, &fqs_jiffies_ops, &jiffies_till_next_fqs, 0644);
>  module_param(rcu_kick_kthreads, bool, 0644);
> 
>  /*
> @@ -2129,10 +2152,6 @@ static int __noreturn rcu_gp_kthread(void *arg)
>  		/* Handle quiescent-state forcing. */
>  		first_gp_fqs = true;
>  		j = jiffies_till_first_fqs;
> -		if (j > HZ) {
> -			j = HZ;
> -			jiffies_till_first_fqs = HZ;
> -		}
>  		ret = 0;
>  		for (;;) {
>  			if (!ret) {
> @@ -2167,13 +2186,6 @@ static int __noreturn rcu_gp_kthread(void *arg)
>  				WRITE_ONCE(rsp->gp_activity, jiffies);
>  				ret = 0; /* Force full wait till next FQS. */
>  				j = jiffies_till_next_fqs;
> -				if (j > HZ) {
> -					j = HZ;
> -					jiffies_till_next_fqs = HZ;
> -				} else if (j < 1) {
> -					j = 1;
> -					jiffies_till_next_fqs = 1;
> -				}
>  			} else {
>  				/* Deal with stray signal. */
>  				cond_resched_tasks_rcu_qs();
> -- 
> 1.9.1
> 
