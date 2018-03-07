Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754675AbeCGPDU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:03:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754608AbeCGPDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:03:17 -0500
Date: Wed, 7 Mar 2018 07:03:43 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Byungchul Park <byungchul.park@lge.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, jiangshanlai@gmail.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [RFC] rcu: Prevent expedite reporting within RCU read-side
 section
Reply-To: paulmck@linux.vnet.ibm.com
References: <1520314318-30916-1-git-send-email-byungchul.park@lge.com>
 <20180306134205.lwmn3cgisnwkngcf@tardis>
 <908c33f9-c8ed-5d4e-91cb-a123de5dbbc7@lge.com>
 <a2e0a9c5-4246-d3b9-2eb7-9bdd87aef636@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2e0a9c5-4246-d3b9-2eb7-9bdd87aef636@lge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18030715-0048-0000-0000-0000024622B3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008629; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00999623; UDB=6.00508472; IPR=6.00779025;
 MB=3.00019893; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-07 15:03:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030715-0049-0000-0000-0000445CD8F8
Message-Id: <20180307150343.GD3918@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803070174
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 03:25:36PM +0900, Byungchul Park wrote:
> On 3/7/2018 2:55 PM, Byungchul Park wrote:
> >On 3/6/2018 10:42 PM, Boqun Feng wrote:
> >>On Tue, Mar 06, 2018 at 02:31:58PM +0900, Byungchul Park wrote:
> >>>Hello Paul and RCU folks,
> >>>
> >>>I am afraid I correctly understand and fix it. But I really wonder why
> >>>sync_rcu_exp_handler() reports the quiescent state even in the case that
> >>>current task is within a RCU read-side section. Do I miss something?
> >>>
> >>>If I correctly understand it and you agree with it, I can add more logic
> >>>which make it more expedited by boosting current or making it urgent
> >>>when we fail to report the quiescent state on the IPI.
> >>>
> >>>----->8-----
> >>> From 0b0191f506c19ce331a1fdb7c2c5a00fb23fbcf2 Mon Sep 17 00:00:00 2001
> >>>From: Byungchul Park <byungchul.park@lge.com>
> >>>Date: Tue, 6 Mar 2018 13:54:41 +0900
> >>>Subject: [RFC] rcu: Prevent expedite reporting within RCU
> >>>read-side section
> >>>
> >>>We report the quiescent state for this cpu if it's out of RCU read-side
> >>>section at the moment IPI was just fired during the expedite process.
> >>>
> >>>However, current code reports the quiescent state even in the case:
> >>>
> >>>    1) the current task is still within a RCU read-side section
> >>>    2) the current task has been blocked within the RCU
> >>>read-side section
> >>>
> >>
> >>If this happens, the task will queue itself in
> >>rcu_preempt_note_context_switch() using rcu_preempt_ctxt_queue(). The gp
> >>kthread will wait for this task to dequeue itself. IOW, we have other
> >>mechanism to wait for this task other than bottom-up qs reporting tree.
> >>So I think we are fine here.
> >
> >Right. Basically we consider both the quiscent state within the current
> >task and queued tasks on rcu nodes that you mentioned, to control grace
> >periods when PREEMPT kernel is used.
> >
> >Actually my concern was if it's safe to clear the bit of 'expmask' on
> >the IPI for all possible cases, even though anyway blocked tasks would
> >try to prevent the grace period from ending.
> >
> >I worried if something subtle might cause problems, but the code looks
> >fine on second thought as you said. Thank you for your explanation.
> 
> In addition, by making quiescent states reported and bits of expmask
> cleared only when it's out of rcu read sections, of course keeping
> other mechanism unchanged like what you mentioned, I think we can avoid
> unnecessary locking ops and other statements, keeping the code still
> sane, even though the benefit might be small.
> 
> For example, by removing some evitable calls to rcu_report_cpu_mult()
> either directly or indirectly. I'm not sure if RCU maintainers think
> it's worthy tho.

You mean rcu_report_exp_cpu_mult()?  If so, which calls to this function
do you believe should be removed?

(Please note that there are likely to be changes in this area soon,
but still, I would like to understand what might be make more
efficient.)

							Thanx, Paul

> >>Regards,
> >>Boqun
> >>
> >>>Since we don't get to the quiescent state yet in the case, we shouldn't
> >>>report it but check it another time.
> >>>
> >>>Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> >>>---
> >>>  kernel/rcu/tree_exp.h | 12 ++++++------
> >>>  1 file changed, 6 insertions(+), 6 deletions(-)
> >>>
> >>>diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> >>>index 73e1d3d..cc69d14 100644
> >>>--- a/kernel/rcu/tree_exp.h
> >>>+++ b/kernel/rcu/tree_exp.h
> >>>@@ -731,13 +731,13 @@ static void sync_rcu_exp_handler(void *info)
> >>>      /*
> >>>       * We are either exiting an RCU read-side critical
> >>>section (negative
> >>>       * values of t->rcu_read_lock_nesting) or are not in one at all
> >>>-     * (zero value of t->rcu_read_lock_nesting).  Or we are in an RCU
> >>>-     * read-side critical section that blocked before this expedited
> >>>-     * grace period started.  Either way, we can immediately report
> >>>-     * the quiescent state.
> >>>+     * (zero value of t->rcu_read_lock_nesting). We can immediately
> >>>+     * report the quiescent state.
> >>>       */
> >>>-    rdp = this_cpu_ptr(rsp->rda);
> >>>-    rcu_report_exp_rdp(rsp, rdp, true);
> >>>+    if (t->rcu_read_lock_nesting <= 0) {
> >>>+        rdp = this_cpu_ptr(rsp->rda);
> >>>+        rcu_report_exp_rdp(rsp, rdp, true);
> >>>+    }
> >>>  }
> >>>  /**
> >>>-- 
> >>>1.9.1
> >>>
> >
> 
> -- 
> Thanks,
> Byungchul
> 
