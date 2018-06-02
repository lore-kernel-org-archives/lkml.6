Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751527AbeFBLno (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 07:43:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750892AbeFBLnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 07:43:43 -0400
Date: Sat, 2 Jun 2018 04:45:22 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Byungchul Park <byungchul.park@lge.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, joel@joelfernandes.org
Subject: Re: [PATCH] rcu: Check the range of jiffies_till_{first,next}_fqs
 when setting them
Reply-To: paulmck@linux.vnet.ibm.com
References: <1527818589-13476-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527818589-13476-1-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18060211-0052-0000-0000-000002F67845
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009115; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01041197; UDB=6.00533045; IPR=6.00820326;
 MB=3.00021425; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-02 11:43:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060211-0053-0000-0000-00005CDE1ADF
Message-Id: <20180602114522.GH3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806020138
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 11:03:09AM +0900, Byungchul Park wrote:
> Currently, the range of jiffies_till_{first,next}_fqs are checked and
> adjusted on and on in the loop of rcu_gp_kthread on runtime.
> 
> However, it's enough to check them only when setting them, not every
> time in the loop. So make them handled on a setting time via sysfs.
> 
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>

Applied for further review and testing, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 45 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 4e96761..eb54d7d 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -518,8 +518,38 @@ void rcu_all_qs(void)
>  static ulong jiffies_till_next_fqs = ULONG_MAX;
>  static bool rcu_kick_kthreads;
> 
> -module_param(jiffies_till_first_fqs, ulong, 0644);
> -module_param(jiffies_till_next_fqs, ulong, 0644);
> +static int param_set_first_fqs_jiffies(const char *val, const struct kernel_param *kp)
> +{
> +	ulong j;
> +	int ret = kstrtoul(val, 0, &j);
> +
> +	if (!ret)
> +		WRITE_ONCE(*(ulong *)kp->arg, (j > HZ) ? HZ : j);
> +	return ret;
> +}
> +
> +static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param *kp)
> +{
> +	ulong j;
> +	int ret = kstrtoul(val, 0, &j);
> +
> +	if (!ret)
> +		WRITE_ONCE(*(ulong *)kp->arg, (j > HZ) ? HZ : (j ?: 1));
> +	return ret;
> +}
> +
> +static struct kernel_param_ops first_fqs_jiffies_ops = {
> +	.set = param_set_first_fqs_jiffies,
> +	.get = param_get_ulong,
> +};
> +
> +static struct kernel_param_ops next_fqs_jiffies_ops = {
> +	.set = param_set_next_fqs_jiffies,
> +	.get = param_get_ulong,
> +};
> +
> +module_param_cb(jiffies_till_first_fqs, &first_fqs_jiffies_ops, &jiffies_till_first_fqs, 0644);
> +module_param_cb(jiffies_till_next_fqs, &next_fqs_jiffies_ops, &jiffies_till_next_fqs, 0644);
>  module_param(rcu_kick_kthreads, bool, 0644);
> 
>  /*
> @@ -2129,10 +2159,6 @@ static int __noreturn rcu_gp_kthread(void *arg)
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
> @@ -2167,13 +2193,6 @@ static int __noreturn rcu_gp_kthread(void *arg)
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
