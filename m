Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750835AbeELFHB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 01:07:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43186 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750722AbeELFHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 01:07:00 -0400
Date: Fri, 11 May 2018 22:08:24 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Byungchul Park <byungchul.park@lge.com>, jiangshanlai@gmail.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, peterz@infradead.org
Subject: Re: [PATCH] rcu: Report a quiescent state when it's exactly in the
 state
Reply-To: paulmck@linux.vnet.ibm.com
References: <1526027434-21237-1-git-send-email-byungchul.park@lge.com>
 <3af4cec0-4019-e3ac-77f9-8631252fb6da@lge.com>
 <20180511161746.GX26088@linux.vnet.ibm.com>
 <20180511224138.GA89902@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180511224138.GA89902@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051205-0024-0000-0000-00000357C46C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009010; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01031055; UDB=6.00526987; IPR=6.00810186;
 MB=3.00021064; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-12 05:06:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051205-0025-0000-0000-000047FB9BC0
Message-Id: <20180512050824.GF26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805120045
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 03:41:38PM -0700, Joel Fernandes wrote:
> On Fri, May 11, 2018 at 09:17:46AM -0700, Paul E. McKenney wrote:
> > On Fri, May 11, 2018 at 09:57:54PM +0900, Byungchul Park wrote:
> > > Hello folks,
> > > 
> > > I think I wrote the title in a misleading way.
> > > 
> > > Please change the title to something else such as,
> > > "rcu: Report a quiescent state when it's in the state" or,
> > > "rcu: Add points reporting quiescent states where proper" or so on.
> > > 
> > > On 2018-05-11 오후 5:30, Byungchul Park wrote:
> > > >We expect a quiescent state of TASKS_RCU when cond_resched_tasks_rcu_qs()
> > > >is called, no matter whether it actually be scheduled or not. However,
> > > >it currently doesn't report the quiescent state when the task enters
> > > >into __schedule() as it's called with preempt = true. So make it report
> > > >the quiescent state unconditionally when cond_resched_tasks_rcu_qs() is
> > > >called.
> > > >
> > > >And in TINY_RCU, even though the quiescent state of rcu_bh also should
> > > >be reported when the tick interrupt comes from user, it doesn't. So make
> > > >it reported.
> > > >
> > > >Lastly in TREE_RCU, rcu_note_voluntary_context_switch() should be
> > > >reported when the tick interrupt comes from not only user but also idle,
> > > >as an extended quiescent state.
> > > >
> > > >Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> > > >---
> > > >  include/linux/rcupdate.h | 4 ++--
> > > >  kernel/rcu/tiny.c        | 6 +++---
> > > >  kernel/rcu/tree.c        | 4 ++--
> > > >  3 files changed, 7 insertions(+), 7 deletions(-)
> > > >
> > > >diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > >index ee8cf5fc..7432261 100644
> > > >--- a/include/linux/rcupdate.h
> > > >+++ b/include/linux/rcupdate.h
> > > >@@ -195,8 +195,8 @@ static inline void exit_tasks_rcu_finish(void) { }
> > > >   */
> > > >  #define cond_resched_tasks_rcu_qs() \
> > > >  do { \
> > > >-	if (!cond_resched()) \
> > > >-		rcu_note_voluntary_context_switch_lite(current); \
> > > >+	rcu_note_voluntary_context_switch_lite(current); \
> > > >+	cond_resched(); \
> > 
> > Ah, good point.
> > 
> > Peter, I have to ask...  Why is "cond_resched()" considered a preemption
> > while "schedule()" is not?
> 
> Infact something interesting I inferred from the __schedule loop related to
> your question:
> 
> switch_count can either be set to prev->invcsw or prev->nvcsw. If we can
> assume that switch_count reflects whether the context switch is involuntary
> or voluntary,
>                       
> task-running-state	preempt		switch_count
> 0 (running)		1		involuntary
> 0			0		involuntary
> 1			0		voluntary
> 1			1		involuntary
> 
> According to the above table, both the task's running state and the preempt
> parameter to __schedule should be used together to determine if the switch is
> a voluntary one or not.
> 
> So this code in rcu_note_context_switch should really be:
> if (!preempt && !(current->state & TASK_RUNNING))
> 	rcu_note_voluntary_context_switch_lite(current);
> 
> According to the above table, cond_resched always classifies as an
> involuntary switch which makes sense to me. Even though cond_resched is
> explicitly called, its still sort of involuntary in the sense its not called
> into the scheduler for sleeping, but rather for seeing if something else can
> run instead (a preemption point). Infact none of the task deactivation in the
> __schedule loop will run if cond_resched is used.
> 
> I agree that if schedule was called directly but with TASK_RUNNING=1, then
> that could probably be classified an involuntary switch too...
> 
> Also since we're deciding to call rcu_note_voluntary_context_switch_lite
> unconditionally, then IMO this comment on that macro:
> 
> /*
>  * Note a voluntary context switch for RCU-tasks benefit.  This is a
>  * macro rather than an inline function to avoid #include hell.
>  */
>  #ifdef CONFIG_TASKS_RCU
>  #define rcu_note_voluntary_context_switch_lite(t)
> 
> Should be changed to:
> 
> /*
>  * Note a attempt to perform a voluntary context switch for RCU-tasks
>  * benefit.  This is called even in situations where a context switch
>  * didn't really happen even though it was requested. This is a
>  * macro rather than an inline function to avoid #include hell.
>  */
>  #ifdef CONFIG_TASKS_RCU
>  #define rcu_note_voluntary_context_switch_lite(t)
> 
> Right?
> 
> Correct me if I'm wrong about anything, thanks,

The starting point for me is that Tasks RCU is a special-purpose mechanism
for freeing trampolines in PREEMPT=y kernels.  The approach is to arrange
for the trampoline to be inaccessible to future execution, wait for a
tasks-RCU grace period, then free the trampoline.  So a tasks-RCU grace
period must wait until all tasks have spent at least some time outside
of a trampoline.  My understanding is that trampolines cannot contain
preemption points, such as cond_resched() and cond_resched_tasks_rcu_qs(),
so we want to count them as quiescent states regardless of whether or
not any associated context switch is counted as involuntary.

What situations lead to the second line of your table above?
The sched_yield() system call, but trampolines don't do system calls,
either, as far as I know.

So it looks to me like that test can leave out the TASK_RUNNING check.

Or am I missing something subtle?

							Thanx, Paul
