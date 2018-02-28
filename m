Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933641AbeB1VF3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 16:05:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58474 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932853AbeB1VF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 16:05:28 -0500
Date: Wed, 28 Feb 2018 13:05:50 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Byungchul Park <byungchul.park@lge.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [PATCH] rcu: Call wake_nocb_leader_defer() with 'FORCE' when
 nocb_q_count is high
Reply-To: paulmck@linux.vnet.ibm.com
References: <1519796942-20947-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519796942-20947-1-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022821-0008-0000-0000-000002DD27BB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008603; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00996472; UDB=6.00506595; IPR=6.00775794;
 MB=3.00019784; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-28 21:05:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022821-0009-0000-0000-0000386AD941
Message-Id: <20180228210550.GS3777@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280256
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 02:49:02PM +0900, Byungchul Park wrote:
> If many callbacks have been queued and waking up the nocb leader should
> be deferred, then we should wake up the leader unconditionally when
> it's safe to do so.
> 
> It was well managed in commit fbce7497ee(rcu: Parallelize and economize
> NOCB kthread wakeups) at first, but the commit 8be6e1b15c(rcu: Use timer
> as backstop for NOCB deferred wakeups) made a mistake which passed
> RCU_NOCB_WAKE instead of RCU_NOCB_WAKE_FORCE as a parameter. Fix it.
> 
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>

Good eyes and good fix, thank you!!!

Queued for v4.18 and for testing and further review.

I did update the commit log, please see below and please let me know if
I messed anything up.

							Thanx, Paul

> ---
>  kernel/rcu/tree_plugin.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index b0d7f9b..c06cf87 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1987,7 +1987,7 @@ static void __call_rcu_nocb_enqueue(struct rcu_data *rdp,
>  			trace_rcu_nocb_wake(rdp->rsp->name, rdp->cpu,
>  					    TPS("WakeOvf"));
>  		} else {
> -			wake_nocb_leader_defer(rdp, RCU_NOCB_WAKE,
> +			wake_nocb_leader_defer(rdp, RCU_NOCB_WAKE_FORCE,
>  					       TPS("WakeOvfIsDeferred"));
>  		}
>  		rdp->qlen_last_fqs_check = LONG_MAX / 2;

------------------------------------------------------------------------

commit 5f56c391238eb237b80c8a6f2f91d97e70d547f1
Author: Byungchul Park <byungchul.park@lge.com>
Date:   Wed Feb 28 14:49:02 2018 +0900

    rcu: Call wake_nocb_leader_defer() with 'FORCE' when nocb_q_count is high
    
    If an excessive number of callbacks have been queued, but the NOCB
    leader kthread's wakeup must be deferred, then we should wake up the
    leader unconditionally once it is safe to do so.
    
    This was handled correctly in commit fbce7497ee ("rcu: Parallelize and
    economize NOCB kthread wakeups"), but then commit 8be6e1b15c ("rcu:
    Use timer as backstop for NOCB deferred wakeups") passed RCU_NOCB_WAKE
    instead of the correct RCU_NOCB_WAKE_FORCE to wake_nocb_leader_defer().
    As an interesting aside, RCU_NOCB_WAKE_FORCE is never passed to anything,
    which should have been taken as a hint.  ;-)
    
    This commit therefore passes RCU_NOCB_WAKE_FORCE instead of RCU_NOCB_WAKE
    to wake_nocb_leader_defer() when a callback is queued onto a NOCB CPU
    that already has an excessive number of callbacks pending.
    
    Signed-off-by: Byungchul Park <byungchul.park@lge.com>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fb3d20d868ed..f4ea2d8027b4 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1987,7 +1987,7 @@ static void __call_rcu_nocb_enqueue(struct rcu_data *rdp,
 			trace_rcu_nocb_wake(rdp->rsp->name, rdp->cpu,
 					    TPS("WakeOvf"));
 		} else {
-			wake_nocb_leader_defer(rdp, RCU_NOCB_WAKE,
+			wake_nocb_leader_defer(rdp, RCU_NOCB_WAKE_FORCE,
 					       TPS("WakeOvfIsDeferred"));
 		}
 		rdp->qlen_last_fqs_check = LONG_MAX / 2;
