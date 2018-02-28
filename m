Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933100AbeB1Sko (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 13:40:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932851AbeB1Skm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 13:40:42 -0500
Date: Wed, 28 Feb 2018 10:41:06 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Byungchul Park <byungchul.park@lge.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [PATCH] rcu: Clean up rcu_init_nohz() by removing unnecessary
 statements
Reply-To: paulmck@linux.vnet.ibm.com
References: <1519808695-28097-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519808695-28097-1-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022818-0056-0000-0000-0000042618AA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008603; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00996423; UDB=6.00506566; IPR=6.00775746;
 MB=3.00019782; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-28 18:40:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022818-0057-0000-0000-0000086818BE
Message-Id: <20180228184106.GN3777@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280227
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 06:04:55PM +0900, Byungchul Park wrote:
> Since the commit 44c65ff2e3b0(rcu: Eliminate NOCBs CPU-state Kconfig
> options) made nocb-cpus identified only through the rcu_nocbs= boot
> parameter, we don't have to care NOCBs CPU-state Kconfig options
> anymore, which means now we can just rely on rcu_nocb_mask to
> decide whether going ahead in rcu_init_nohz().
> 
> Remove the deprecated code.
> 
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>

Good catch!  However, you missed a (relatively harmless) bug in my commit
44c65ff2e3b0, namely that if neither the nohz_full= nor the rcu_nocbs=
kernel boot parameters specify any CPUs, we don't need to allocate
rcu_nocb_mask.  (That is, when both of those parameters are omitted.)

Now, if the rcu_nocbs= kernel boot parameter was specified, we know that
rcu_nocb_mask was already allocated in rcu_nocb_setup().  So in
rcu_init_nohz() we only need to do the allocation if NO_HZ_FULL needs
some NOCBs CPUs, that is, when tick_nohz_full_running and when there
is at least one CPU specified in tick_nohz_full_mask.

So the change that is actually needed is to reverse the initialization
of need_rcu_nocb_mask, that is, to initialize it to false rather than
to true.  I annotated your patch with my reasoning and have a patch
below with your Reported-by.  Please take a look and let me know what
you think.

If I am not too confused, the only effect of this bug was to needlessly
allocate rcu_nocb_mask and to initialize it to all zeros bits, but please
let me know if I missed something.

But you did find a bug in RCU, so you are ahead of the formal-verification
folks.  ;-)

							Thanx, Paul

> ---
>  kernel/rcu/tree_plugin.h | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index b0d7f9b..510a6af 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -2313,22 +2313,14 @@ static void do_nocb_deferred_wakeup(struct rcu_data *rdp)
>  void __init rcu_init_nohz(void)
>  {
>  	int cpu;
> -	bool need_rcu_nocb_mask = true;

I initialize this to "false" instead of "true" as discussed above.

>  	struct rcu_state *rsp;
> 
> -#if defined(CONFIG_NO_HZ_FULL)
> -	if (tick_nohz_full_running && cpumask_weight(tick_nohz_full_mask))
> -		need_rcu_nocb_mask = true;
> -#endif /* #if defined(CONFIG_NO_HZ_FULL) */

The above is needed to decide if NO_HZ_FULL needs NOCBs CPUs.

> -
> -	if (!cpumask_available(rcu_nocb_mask) && need_rcu_nocb_mask) {
> +	if (!cpumask_available(rcu_nocb_mask)) {

And we still need this check.  If the rcu_nocbs= kernel boot parameter
was not specified and if NO_HZ_FULL doesn't need NOCBs CPUs, we shouldn't
allocate rcu_nocb_mask.

>  		if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
>  			pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
>  			return;
>  		}
>  	}
> -	if (!cpumask_available(rcu_nocb_mask))
> -		return;

This check remains as an optimization.  We -could- execute the code
below even if rcu_nocb_mask had not been allocated, but the code below
would end up painstakingly rechecking rcu_nocb_mask for each CPU for
each flavor of RCU.  So why not just take an early exit in that case?

>  #if defined(CONFIG_NO_HZ_FULL)
>  	if (tick_nohz_full_running)

------------------------------------------------------------------------

commit 628e565ede22b0155bf2e0daed4d70ea0b5e6d65
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Wed Feb 28 10:34:54 2018 -0800

    rcu: Don't allocate rcu_nocb_mask if no one needs it
    
    Commit 44c65ff2e3b0 ("rcu: Eliminate NOCBs CPU-state Kconfig options")
    made allocation of rcu_nocb_mask depend only on the rcu_nocbs=,
    nohz_full=, or isolcpus= kernel boot parameters.  However, it failed
    to change the initial value of rcu_init_nohz()'s local variable
    need_rcu_nocb_mask to false, which can result in useless allocation
    of an all-zero rcu_nocb_mask.  This commit therefore fixes this bug by
    changing the initial value of need_rcu_nocb_mask to false.
    
    While we are in the area, also correct the error message that is printed
    when someone specifies that can-never-exist CPUs should be NOCBs CPUs.
    
    Reported-by: Byungchul Park <byungchul.park@lge.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b0d7f9ba6bf2..fb3d20d868ed 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2313,7 +2313,7 @@ static void do_nocb_deferred_wakeup(struct rcu_data *rdp)
 void __init rcu_init_nohz(void)
 {
 	int cpu;
-	bool need_rcu_nocb_mask = true;
+	bool need_rcu_nocb_mask = false;
 	struct rcu_state *rsp;
 
 #if defined(CONFIG_NO_HZ_FULL)
@@ -2336,7 +2336,7 @@ void __init rcu_init_nohz(void)
 #endif /* #if defined(CONFIG_NO_HZ_FULL) */
 
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
-		pr_info("\tNote: kernel parameter 'rcu_nocbs=' contains nonexistent CPUs.\n");
+		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
 		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
 			    rcu_nocb_mask);
 	}
