Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754613AbeEaLQH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:16:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754441AbeEaLQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:16:03 -0400
Date: Thu, 31 May 2018 04:17:42 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Byungchul Park <byungchul.park@lge.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, joel@joelfernandes.org
Subject: Re: [RFC] rcu: Check the range of jiffies_till_xxx_fqs on setting
 them
Reply-To: paulmck@linux.vnet.ibm.com
References: <1527578616-5595-1-git-send-email-byungchul.park@lge.com>
 <20180529120155.GC3803@linux.vnet.ibm.com>
 <07271222-2e1d-2dc8-1648-4c53d710a092@lge.com>
 <3d2d8dec-445a-da31-dbe0-34b2331523ed@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d2d8dec-445a-da31-dbe0-34b2331523ed@lge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18053111-0008-0000-0000-0000030F4C7A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009102; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01040271; UDB=6.00532494; IPR=6.00819400;
 MB=3.00021392; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-31 11:16:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053111-0009-0000-0000-0000396B545F
Message-Id: <20180531111742.GQ7063@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-31_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=977 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805310128
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 11:51:40AM +0900, Byungchul Park wrote:
> On 2018-05-31 11:18, Byungchul Park wrote:
> >On 2018-05-29 21:01, Paul E. McKenney wrote:
> >
> >>One approach would be to embed the kernel_params_ops structure inside
> >>another structure containing the limits, then just have two structures.
> >>Perhaps something like this already exists?  I don't see it right off,
> >>but then again, I am not exactly an expert on module_param.
> >>
> >>Thoughts?
> >
> >Unfortunately, I couldn't find it. There might be no way to verify
> >range of a variable except the way I did. Could you give your opinion
> >about whether I should go on it?
> 
> Like..

This looks reasonable to me.  Although you could make something that took
ranges, that would be more code than what you have below, so what you
have below is good.  Could you please resend as a patch with Signed-off-by
and commit log?

							Thanx, Paul

> ----->8-----
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
> +static int param_set_first_fqs_jiffies(const char *val, const
> struct kernel_param *kp)
> +{
> +       ulong j;
> +       int ret = kstrtoul(val, 0, &j);
> +
> +       if (!ret)
> +               WRITE_ONCE(*(ulong *)kp->arg, (j > HZ) ? HZ : j);
> +       return ret;
> +}
> +
> +static int param_set_next_fqs_jiffies(const char *val, const struct
> kernel_param *kp)
> +{
> +       ulong j;
> +       int ret = kstrtoul(val, 0, &j);
> +
> +       if (!ret)
> +               WRITE_ONCE(*(ulong *)kp->arg, (j > HZ) ? HZ : (j ?: 1));
> +       return ret;
> +}
> +
> +static struct kernel_param_ops first_fqs_jiffies_ops = {
> +       .set = param_set_first_fqs_jiffies,
> +       .get = param_get_ulong,
> +};
> +
> +static struct kernel_param_ops next_fqs_jiffies_ops = {
> +       .set = param_set_next_fqs_jiffies,
> +       .get = param_get_ulong,
> +};
> +
> +module_param_cb(jiffies_till_first_fqs, &first_fqs_jiffies_ops,
> &jiffies_till_first_fqs, 0644);
> +module_param_cb(jiffies_till_next_fqs, &next_fqs_jiffies_ops,
> &jiffies_till_next_fqs, 0644);
>  module_param(rcu_kick_kthreads, bool, 0644);
> 
>  /*
> @@ -2129,10 +2159,6 @@ static int __noreturn rcu_gp_kthread(void *arg)
>                 /* Handle quiescent-state forcing. */
>                 first_gp_fqs = true;
>                 j = jiffies_till_first_fqs;
> -               if (j > HZ) {
> -                       j = HZ;
> -                       jiffies_till_first_fqs = HZ;
> -               }
>                 ret = 0;
>                 for (;;) {
>                         if (!ret) {
> @@ -2167,13 +2193,6 @@ static int __noreturn rcu_gp_kthread(void *arg)
>                                 WRITE_ONCE(rsp->gp_activity, jiffies);
>                                 ret = 0; /* Force full wait till
> next FQS. */
>                                 j = jiffies_till_next_fqs;
> -                               if (j > HZ) {
> -                                       j = HZ;
> -                                       jiffies_till_next_fqs = HZ;
> -                               } else if (j < 1) {
> -                                       j = 1;
> -                                       jiffies_till_next_fqs = 1;
> -                               }
>                         } else {
>                                 /* Deal with stray signal. */
>                                 cond_resched_tasks_rcu_qs();
> 
> 
> -- 
> Thanks,
> Byungchul
> 
