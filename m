Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbeEKQQY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 12:16:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750950AbeEKQQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 12:16:23 -0400
Date: Fri, 11 May 2018 09:17:46 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Byungchul Park <byungchul.park@lge.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, peterz@infradead.org
Subject: Re: [PATCH] rcu: Report a quiescent state when it's exactly in the
 state
Reply-To: paulmck@linux.vnet.ibm.com
References: <1526027434-21237-1-git-send-email-byungchul.park@lge.com>
 <3af4cec0-4019-e3ac-77f9-8631252fb6da@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3af4cec0-4019-e3ac-77f9-8631252fb6da@lge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051116-0052-0000-0000-000002ED23D3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009006; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01030798; UDB=6.00526834; IPR=6.00809929;
 MB=3.00021049; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-11 16:16:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051116-0053-0000-0000-00005CA5D713
Message-Id: <20180511161746.GX26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805110153
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 09:57:54PM +0900, Byungchul Park wrote:
> Hello folks,
> 
> I think I wrote the title in a misleading way.
> 
> Please change the title to something else such as,
> "rcu: Report a quiescent state when it's in the state" or,
> "rcu: Add points reporting quiescent states where proper" or so on.
> 
> On 2018-05-11 오후 5:30, Byungchul Park wrote:
> >We expect a quiescent state of TASKS_RCU when cond_resched_tasks_rcu_qs()
> >is called, no matter whether it actually be scheduled or not. However,
> >it currently doesn't report the quiescent state when the task enters
> >into __schedule() as it's called with preempt = true. So make it report
> >the quiescent state unconditionally when cond_resched_tasks_rcu_qs() is
> >called.
> >
> >And in TINY_RCU, even though the quiescent state of rcu_bh also should
> >be reported when the tick interrupt comes from user, it doesn't. So make
> >it reported.
> >
> >Lastly in TREE_RCU, rcu_note_voluntary_context_switch() should be
> >reported when the tick interrupt comes from not only user but also idle,
> >as an extended quiescent state.
> >
> >Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> >---
> >  include/linux/rcupdate.h | 4 ++--
> >  kernel/rcu/tiny.c        | 6 +++---
> >  kernel/rcu/tree.c        | 4 ++--
> >  3 files changed, 7 insertions(+), 7 deletions(-)
> >
> >diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> >index ee8cf5fc..7432261 100644
> >--- a/include/linux/rcupdate.h
> >+++ b/include/linux/rcupdate.h
> >@@ -195,8 +195,8 @@ static inline void exit_tasks_rcu_finish(void) { }
> >   */
> >  #define cond_resched_tasks_rcu_qs() \
> >  do { \
> >-	if (!cond_resched()) \
> >-		rcu_note_voluntary_context_switch_lite(current); \
> >+	rcu_note_voluntary_context_switch_lite(current); \
> >+	cond_resched(); \

Ah, good point.

Peter, I have to ask...  Why is "cond_resched()" considered a preemption
while "schedule()" is not?

> >  } while (0)
> >  /*
> >diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> >index a64eee0..68d2332 100644
> >--- a/kernel/rcu/tiny.c
> >+++ b/kernel/rcu/tiny.c
> >@@ -120,12 +120,12 @@ void rcu_bh_qs(void)
> >   */
> >  void rcu_check_callbacks(int user)
> >  {
> >-	if (user)
> >+	if (user) {
> >  		rcu_sched_qs();
> >-	else if (!in_softirq())
> >  		rcu_bh_qs();
> >-	if (user)
> >  		rcu_note_voluntary_context_switch(current);
> >+	} else if (!in_softirq())
> >+		rcu_bh_qs();
> >  }
> >  /*
> >diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >index 36075dd..1abe29a 100644
> >--- a/kernel/rcu/tree.c
> >+++ b/kernel/rcu/tree.c
> >@@ -2595,6 +2595,7 @@ void rcu_check_callbacks(int user)
> >  		rcu_sched_qs();
> >  		rcu_bh_qs();
> >+		rcu_note_voluntary_context_switch(current);
> >  	} else if (!in_softirq()) {
> >@@ -2610,8 +2611,7 @@ void rcu_check_callbacks(int user)
> >  	rcu_preempt_check_callbacks();
> >  	if (rcu_pending())
> >  		invoke_rcu_core();
> >-	if (user)
> >-		rcu_note_voluntary_context_switch(current);
> >+

I recall that I had some reason for wanting this down here, but
do not recall the reason itself.  I will try testing this patch
to see if rcutorture reminds me.

							Thanx, Paul

> >  	trace_rcu_utilization(TPS("End scheduler-tick"));
> >  }
> >
> 
> -- 
> Thanks,
> Byungchul
> 
