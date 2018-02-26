Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751856AbeBZXzJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 18:55:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52988 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750941AbeBZXzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 18:55:06 -0500
Date: Mon, 26 Feb 2018 15:55:28 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Byungchul Park <byungchul.park@lge.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, jiangshanlai@gmail.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH] rcu: Remove the unnecessary separate function,
 rcu_preempt_do_callback()
Reply-To: paulmck@linux.vnet.ibm.com
References: <1519621896-8786-1-git-send-email-byungchul.park@lge.com>
 <20180226121514.122669b9@vmware.local.home>
 <20180226182254.GU2855@linux.vnet.ibm.com>
 <3513ccbe-f803-dbb9-7f14-117e1e39c125@lge.com>
 <b212ecc3-f382-b4d8-be81-a6ca4ffadb03@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b212ecc3-f382-b4d8-be81-a6ca4ffadb03@lge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022623-0008-0000-0000-000002DBA63F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995571; UDB=6.00506057; IPR=6.00774899;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 23:55:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022623-0009-0000-0000-000038651CCF
Message-Id: <20180226235528.GW2855@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260299
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 08:40:47AM +0900, Byungchul Park wrote:
> On 2/27/2018 8:35 AM, Byungchul Park wrote:
> >On 2/27/2018 3:22 AM, Paul E. McKenney wrote:
> >>On Mon, Feb 26, 2018 at 12:15:14PM -0500, Steven Rostedt wrote:
> >>>On Mon, 26 Feb 2018 14:11:36 +0900
> >>>Byungchul Park <byungchul.park@lge.com> wrote:
> >>>
> >>>>rcu_preemptp_do_callback() was introduced in commit 09223371dea(rcu:
> >>>>Use softirq to address performance regression), where it had to be
> >>>>distinguished between in the case CONFIG_TREE_PREEMPT_RCU is set and
> >>>>it's not.
> >>>>
> >>>>Now that the code was cleaned up so that rcu_preemt_do_callback() is
> >>>>only called in rcu_kthread_do_work() in the same file, tree_plugin.h,
> >>>>we don't have to keep the separate function anymore. Remove it for a
> >>>>better readability.
> >>>
> >>>Looks good to me (looks like commit f8b7fc6b51 "rcu: use softirq
> >>>instead of kthreads except when RCU_BOOST=y" cleaned up the ifdefs and
> >>>removed the requirement).
> >>>
> >>>Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> >>
> >>Thank you both!  I have queued a slightly modified patch for testing
> >>and further review.  Please see below and let me know if I messed
> >>something up.
> >>
> >>                            Thanx, Paul
> >>
> >>------------------------------------------------------------------------
> >>
> >>commit b8a3012ddba397d4a18d9fd4a00432f8c2626bd6
> >>Author: Byungchul Park <byungchul.park@lge.com>
> >>Date:   Mon Feb 26 14:11:36 2018 +0900
> >>
> >>     rcu: Inline rcu_preempt_do_callback() into its sole caller
> >>     The rcu_preempt_do_callbacks() function was introduced in commit
> >>     09223371dea(rcu: Use softirq to address performance
> >>regression), where it
> >>     was necessary to handle kernel builds both containing and
> >>not containing
> >>     RCU-preempt.  Since then, various changes (most notably f8b7fc6b51
> >>     ("rcu: use softirq instead of kthreads except when
> >>RCU_BOOST=y")) have
> >>     resulted in this function being invoked only from
> >>rcu_kthread_do_work(),
> >>     which is present only in kernels containing RCU-preempt,
> >>which in turn
> >>     means that the rcu_preempt_do_callbacks() function is no
> >>longer needed.
> >>     This commit therefore inlines rcu_preempt_do_callbacks() into its
> >>     sole remaining caller and also removes the rcu_state_p and
> >>rcu_data_p
> >>     indirection for added clarity.
> >>     Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> >>     Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> >>     [ paulmck: Remove the rcu_state_p and rcu_data_p indirection. ]
> >>
> >>diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> >>index dc6f2319fc21..9dd0ea77faed 100644
> >>--- a/kernel/rcu/tree.h
> >>+++ b/kernel/rcu/tree.h
> >>@@ -449,7 +449,6 @@ static void
> >>rcu_preempt_boost_start_gp(struct rcu_node *rnp);
> >>  static void invoke_rcu_callbacks_kthread(void);
> >>  static bool rcu_is_callbacks_kthread(void);
> >>  #ifdef CONFIG_RCU_BOOST
> >>-static void rcu_preempt_do_callbacks(void);
> >>  static int rcu_spawn_one_boost_kthread(struct rcu_state *rsp,
> >>                           struct rcu_node *rnp);
> >>  #endif /* #ifdef CONFIG_RCU_BOOST */
> >>diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> >>index 26d7a31e81cb..b0d7f9ba6bf2 100644
> >>--- a/kernel/rcu/tree_plugin.h
> >>+++ b/kernel/rcu/tree_plugin.h
> >>@@ -686,15 +686,6 @@ static void rcu_preempt_check_callbacks(void)
> >>          t->rcu_read_unlock_special.b.need_qs = true;
> >>  }
> >>-#ifdef CONFIG_RCU_BOOST
> >>-
> >>-static void rcu_preempt_do_callbacks(void)
> >>-{
> >>-    rcu_do_batch(rcu_state_p, this_cpu_ptr(rcu_data_p));
> >>-}
> >>-
> >>-#endif /* #ifdef CONFIG_RCU_BOOST */
> >>-
> >>  /**
> >>   * call_rcu() - Queue an RCU callback for invocation after a
> >>grace period.
> >>   * @head: structure to be used for queueing the RCU updates.
> >>@@ -1170,7 +1161,7 @@ static void rcu_kthread_do_work(void)
> >>  {
> >>      rcu_do_batch(&rcu_sched_state, this_cpu_ptr(&rcu_sched_data));
> >>      rcu_do_batch(&rcu_bh_state, this_cpu_ptr(&rcu_bh_data));
> >>-    rcu_preempt_do_callbacks();
> >>+    rcu_do_batch(&rcu_preempt_state, this_cpu_ptr(&rcu_preempt_data));
> >
> >OMG. Sorry for the mistake and thank you very much for fixing it.
> >
> >I will be more careful.
> 
> Ah. Logically no difference between mine and your fixed one.

Yes, your patch was perfectly fine.  It just kept an additional pair of
memory fetches that are unnecessary.  So if you considered your patch
to have a problem, then the original code had that same problem.

> But anyway yours looks much better! Thank you~ :)

And you!

							Thanx, Paul
