Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeEMAJv (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 20:09:51 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43854 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751010AbeEMAJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 20:09:50 -0400
X-Google-Smtp-Source: AB8JxZrLXnFIzbZ0MLjRFEWiFrXAtHqiy9AIxRat3X/adJhGgu1TJJuNms7j84FjIg7TmiCwpwAjHA==
Date: Sat, 12 May 2018 17:09:48 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Byungchul Park <byungchul.park@lge.com>, jiangshanlai@gmail.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, peterz@infradead.org
Subject: Re: [PATCH] rcu: Report a quiescent state when it's exactly in the
 state
Message-ID: <20180513000948.GE192642@joelaf.mtv.corp.google.com>
References: <1526027434-21237-1-git-send-email-byungchul.park@lge.com>
 <3af4cec0-4019-e3ac-77f9-8631252fb6da@lge.com>
 <20180511161746.GX26088@linux.vnet.ibm.com>
 <20180511224138.GA89902@joelaf.mtv.corp.google.com>
 <20180512050824.GF26088@linux.vnet.ibm.com>
 <20180512063037.GC192642@joelaf.mtv.corp.google.com>
 <20180512144119.GJ26088@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180512144119.GJ26088@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2018 at 07:41:19AM -0700, Paul E. McKenney wrote:
> On Fri, May 11, 2018 at 11:30:37PM -0700, Joel Fernandes wrote:
> > On Fri, May 11, 2018 at 10:08:24PM -0700, Paul E. McKenney wrote:
> > > On Fri, May 11, 2018 at 03:41:38PM -0700, Joel Fernandes wrote:
> > > > On Fri, May 11, 2018 at 09:17:46AM -0700, Paul E. McKenney wrote:
> > > > > On Fri, May 11, 2018 at 09:57:54PM +0900, Byungchul Park wrote:
> > > > > > Hello folks,
> > > > > > 
> > > > > > I think I wrote the title in a misleading way.
> > > > > > 
> > > > > > Please change the title to something else such as,
> > > > > > "rcu: Report a quiescent state when it's in the state" or,
> > > > > > "rcu: Add points reporting quiescent states where proper" or so on.
> > > > > > 
> > > > > > On 2018-05-11 오후 5:30, Byungchul Park wrote:
> > > > > > >We expect a quiescent state of TASKS_RCU when cond_resched_tasks_rcu_qs()
> > > > > > >is called, no matter whether it actually be scheduled or not. However,
> > > > > > >it currently doesn't report the quiescent state when the task enters
> > > > > > >into __schedule() as it's called with preempt = true. So make it report
> > > > > > >the quiescent state unconditionally when cond_resched_tasks_rcu_qs() is
> > > > > > >called.
> > > > > > >
> > > > > > >And in TINY_RCU, even though the quiescent state of rcu_bh also should
> > > > > > >be reported when the tick interrupt comes from user, it doesn't. So make
> > > > > > >it reported.
> > > > > > >
> > > > > > >Lastly in TREE_RCU, rcu_note_voluntary_context_switch() should be
> > > > > > >reported when the tick interrupt comes from not only user but also idle,
> > > > > > >as an extended quiescent state.
> > > > > > >
> > > > > > >Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> > > > > > >---
> > > > > > >  include/linux/rcupdate.h | 4 ++--
> > > > > > >  kernel/rcu/tiny.c        | 6 +++---
> > > > > > >  kernel/rcu/tree.c        | 4 ++--
> > > > > > >  3 files changed, 7 insertions(+), 7 deletions(-)
> > > > > > >
> > > > > > >diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > > > > >index ee8cf5fc..7432261 100644
> > > > > > >--- a/include/linux/rcupdate.h
> > > > > > >+++ b/include/linux/rcupdate.h
> > > > > > >@@ -195,8 +195,8 @@ static inline void exit_tasks_rcu_finish(void) { }
> > > > > > >   */
> > > > > > >  #define cond_resched_tasks_rcu_qs() \
> > > > > > >  do { \
> > > > > > >-	if (!cond_resched()) \
> > > > > > >-		rcu_note_voluntary_context_switch_lite(current); \
> > > > > > >+	rcu_note_voluntary_context_switch_lite(current); \
> > > > > > >+	cond_resched(); \
> > > > > 
> > > > > Ah, good point.
> > > > > 
> > > > > Peter, I have to ask...  Why is "cond_resched()" considered a preemption
> > > > > while "schedule()" is not?
> > > > 
> > > > Infact something interesting I inferred from the __schedule loop related to
> > > > your question:
> > > > 
> > > > switch_count can either be set to prev->invcsw or prev->nvcsw. If we can
> > > > assume that switch_count reflects whether the context switch is involuntary
> > > > or voluntary,
> > > >                       
> > > > task-running-state	preempt		switch_count
> > > > 0 (running)		1		involuntary
> > > > 0			0		involuntary
> > > > 1			0		voluntary
> > > > 1			1		involuntary
> > > > 
> > > > According to the above table, both the task's running state and the preempt
> > > > parameter to __schedule should be used together to determine if the switch is
> > > > a voluntary one or not.
> > > > 
> > > > So this code in rcu_note_context_switch should really be:
> > > > if (!preempt && !(current->state & TASK_RUNNING))
> > 
> > I should have writte here- !preempt && current->state
> > 
> > > > 	rcu_note_voluntary_context_switch_lite(current);
> > > > 
> > > > According to the above table, cond_resched always classifies as an
> > > > involuntary switch which makes sense to me. Even though cond_resched is
> > > > explicitly called, its still sort of involuntary in the sense its not called
> > > > into the scheduler for sleeping, but rather for seeing if something else can
> > > > run instead (a preemption point). Infact none of the task deactivation in the
> > > > __schedule loop will run if cond_resched is used.
> > > > 
> > > > I agree that if schedule was called directly but with TASK_RUNNING=1, then
> > > > that could probably be classified an involuntary switch too...
> > > > 
> > > > Also since we're deciding to call rcu_note_voluntary_context_switch_lite
> > > > unconditionally, then IMO this comment on that macro:
> > > > 
> > > > /*
> > > >  * Note a voluntary context switch for RCU-tasks benefit.  This is a
> > > >  * macro rather than an inline function to avoid #include hell.
> > > >  */
> > > >  #ifdef CONFIG_TASKS_RCU
> > > >  #define rcu_note_voluntary_context_switch_lite(t)
> > > > 
> > > > Should be changed to:
> > > > 
> > > > /*
> > > >  * Note a attempt to perform a voluntary context switch for RCU-tasks
> > > >  * benefit.  This is called even in situations where a context switch
> > > >  * didn't really happen even though it was requested. This is a
> > > >  * macro rather than an inline function to avoid #include hell.
> > > >  */
> > > >  #ifdef CONFIG_TASKS_RCU
> > > >  #define rcu_note_voluntary_context_switch_lite(t)
> > > > 
> > > > Right?
> > > > 
> > > > Correct me if I'm wrong about anything, thanks,
> > > 
> > > The starting point for me is that Tasks RCU is a special-purpose mechanism
> > > for freeing trampolines in PREEMPT=y kernels.  The approach is to arrange
> > > for the trampoline to be inaccessible to future execution, wait for a
> > > tasks-RCU grace period, then free the trampoline.  So a tasks-RCU grace
> > > period must wait until all tasks have spent at least some time outside
> > > of a trampoline.  My understanding is that trampolines cannot contain
> > > preemption points, such as cond_resched() and cond_resched_tasks_rcu_qs(),
> > > so we want to count them as quiescent states regardless of whether or
> > > not any associated context switch is counted as involuntary.
> > > 
> > > What situations lead to the second line of your table above?
> > > The sched_yield() system call, but trampolines don't do system calls,
> > > either, as far as I know.
> > > 
> > > So it looks to me like that test can leave out the TASK_RUNNING check.
> > 
> > I don't know much about tasks-RCU to comment more, sorry. Probably a few more
> > reading nights for me to catch up with that. Its possible the check is not
> > needed and tasks-RCU can survive without it, but I was thinking from a
> > correctness and future-proofing stand point... I generally don't like
> > inconsistencies. The check in the __schedule loop is as:
> > 
> > 	if (!preempt && prev->state) {
> > 		....
> > 		// switch_count = voluntary context switch counter pointer
> > 		....
> > 	} else {
> > 		....
> > 
> > 		// switch_count = involuntary context switch counter pointer
> > 		....
> > 	}
> > 
> > 	// context switch really happening
> > 	if (prev != next) {
> > 		....
> > 		++switch_count;
> > 	}
> > 
> > The first conditional if (!preempt...) above is what I was referring to which
> > also checks the state.
> > 
> > Also this issue aside, I was more trying to answer your question about why
> > schedule() is or isn't a preemption point, by sharing the table but I
> > possibly caused more confusion, sorry :-(. I'll let Peter and Steven chime in
> > since they know more than me about that and will just shutup and listen
> > instead of being more noisy.. :-D
> 
> Don't get me wrong, this discussion was quite useful to me.  We probably

Cool, I'm glad, thanks.

> need to at least change the comments, and perhaps the code as well.  But

Ok. I can make this kind of a comment in my clean up patch series just to
clarify how the macro is used for.

> I agree that we need input from Peter and Steven to make much more forward
> progress.

I saw Steven's email just now about cond_resched and stuff and it makes sense.

thanks,

- Joel
