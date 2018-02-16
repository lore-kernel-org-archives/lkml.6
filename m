Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756700AbeBPABo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 19:01:44 -0500
Received: from mail.efficios.com ([167.114.142.141]:56927 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752900AbeBPABm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 19:01:42 -0500
Date: Fri, 16 Feb 2018 00:02:42 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Message-ID: <206116170.22740.1518739362681.JavaMail.zimbra@efficios.com>
In-Reply-To: <1144433342.22716.1518732536600.JavaMail.zimbra@efficios.com>
References: <20180214120254.qq4w4s42ecxio7lu@lakrids.cambridge.arm.com> <20180214150739.GH2992@arm.com> <20180214165131.o25r3hhrtrjk3ejq@lakrids.cambridge.arm.com> <254787533.21950.1518634424009.JavaMail.zimbra@efficios.com> <20180215142239.GF16623@arm.com> <20180215164754.GW25201@hirez.programming.kicks-ass.net> <20180215182154.GD15274@arm.com> <1144433342.22716.1518732536600.JavaMail.zimbra@efficios.com>
Subject: Re: arm64/v4.16-rc1: KASAN: use-after-free Read in
 finish_task_switch
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.141]
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - FF52 (Linux)/8.7.11_GA_1854)
Thread-Topic: arm64/v4.16-rc1: KASAN: use-after-free Read in finish_task_switch
Thread-Index: ibTSQFrChGd28w09oDNUx5OVVCysqga7102L
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 15, 2018, at 5:08 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Feb 15, 2018, at 1:21 PM, Will Deacon will.deacon@arm.com wrote:
> 
>> On Thu, Feb 15, 2018 at 05:47:54PM +0100, Peter Zijlstra wrote:
>>> On Thu, Feb 15, 2018 at 02:22:39PM +0000, Will Deacon wrote:
>>> > Instead, we've come up with a more plausible sequence that can in theory
>>> > happen on a single CPU:
>>> > 
>>> > <task foo calls exit()>
>>> > 
>>> > do_exit
>>> > 	exit_mm
>>> 
>>> If this is the last task of the process, we would expect:
>>> 
>>>   mm_count == 1
>>>   mm_users == 1
>>> 
>>> at this point.
>>> 
>>> > 		mmgrab(mm);			// foo's mm has count +1
>>> > 		BUG_ON(mm != current->active_mm);
>>> > 		task_lock(current);
>>> > 		current->mm = NULL;
>>> > 		task_unlock(current);
>>> 
>>> So the whole active_mm is basically the last 'real' mm, and its purpose
>>> is to avoid switch_mm() between user tasks and kernel tasks.
>>> 
>>> A kernel task has !->mm. We do this by incrementing mm_count when
>>> switching from user to kernel task and decrementing when switching from
>>> kernel to user.
>>> 
>>> What exit_mm() does is change a user task into a 'kernel' task. So it
>>> should increment mm_count to mirror the context switch. I suspect this
>>> is what the mmgrab() in exit_mm() is for.
>>> 
>>> > <irq and ctxsw to kthread>
>>> > 
>>> > context_switch(prev=foo, next=kthread)
>>> > 	mm = next->mm;
>>> > 	oldmm = prev->active_mm;
>>> > 
>>> > 	if (!mm) {				// True for kthread
>>> > 		next->active_mm = oldmm;
>>> > 		mmgrab(oldmm);			// foo's mm has count +2
>>> > 	}
>>> > 
>>> > 	if (!prev->mm) {			// True for foo
>>> > 		rq->prev_mm = oldmm;
>>> > 	}
>>> > 
>>> > 	finish_task_switch
>>> > 		mm = rq->prev_mm;
>>> > 		if (mm) {			// True (foo's mm)
>>> > 			mmdrop(mm);		// foo's mm has count +1
>>> > 		}
>>> > 
>>> > 	[...]
>>> > 
>>> > <ctxsw to task bar>
>>> > 
>>> > context_switch(prev=kthread, next=bar)
>>> > 	mm = next->mm;
>>> > 	oldmm = prev->active_mm;		// foo's mm!
>>> > 
>>> > 	if (!prev->mm) {			// True for kthread
>>> > 		rq->prev_mm = oldmm;
>>> > 	}
>>> > 
>>> > 	finish_task_switch
>>> > 		mm = rq->prev_mm;
>>> > 		if (mm) {			// True (foo's mm)
>>> > 			mmdrop(mm);		// foo's mm has count +0
>>> 
>>> The context switch into the next user task will then decrement. At this
>>> point foo no longer has a reference to its mm, except on the stack.
>>> 
>>> > 		}
>>> > 
>>> > 	[...]
>>> > 
>>> > <ctxsw back to task foo>
>>> > 
>>> > context_switch(prev=bar, next=foo)
>>> > 	mm = next->mm;
>>> > 	oldmm = prev->active_mm;
>>> > 
>>> > 	if (!mm) {				// True for foo
>>> > 		next->active_mm = oldmm;	// This is bar's mm
>>> > 		mmgrab(oldmm);			// bar's mm has count +1
>>> > 	}
>>> > 
>>> > 
>>> > 	[return back to exit_mm]
>>> 
>>> Enter mm_users, this counts the number of tasks associated with the mm.
>>> We start with 1 in mm_init(), and when it drops to 0, we decrement
>>> mm_count. Since we also start with mm_count == 1, this would appear
>>> consistent.
>>> 
>>>   mmput() // --mm_users == 0, which then results in:
>>> 
>>> > mmdrop(mm);					// foo's mm has count -1
>>> 
>>> In the above case, that's the very last reference to the mm, and since
>>> we started out with mm_count == 1, this -1 makes 0 and we do the actual
>>> free.
>>> 
>>> > At this point, we've got an imbalanced count on the mm and could free it
>>> > prematurely as seen in the KASAN log.
>>> 
>>> I'm not sure I see premature. At this point mm_users==0, mm_count==0 and
>>> we freed mm and there is no further use of the on-stack mm pointer and
>>> foo no longer has a pointer to it in either ->mm or ->active_mm. It's
>>> well and proper dead.
>>> 
>>> > A subsequent context-switch away from foo would therefore result in a
>>> > use-after-free.
>>> 
>>> At the above point, foo no longer has a reference to mm, we cleared ->mm
>>> early, and the context switch to bar cleared ->active_mm. The switch
>>> back into foo then results with foo->active_mm == bar->mm, which is
>>> fine.
>> 
>> Bugger, you're right. When we switch off foo after freeing the mm, we'll
>> actually access it's active mm which points to bar's mm. So whilst this
>> can explain part of the kasan splat, it doesn't explain the actual
>> use-after-free.
>> 
>> More head-scratching required :(
> 
> My current theory: do_exit() gets preempted after having set current->mm
> to NULL, and after having issued mmput(), which brings the mm_count down
> to 0. Unfortunately, if the scheduler switches from a userspace thread
> to a kernel thread, context_switch() loads prev->active_mm which still
> points to the now-freed mm, mmgrab the mm, and eventually does mmdrop
> in finish_task_switch().
> 
> If my understanding is correct, the following patch should help. The idea
> is to keep a reference on the mm_count until after we are sure the scheduler
> cannot schedule the task anymore. What I'm not sure is where exactly in
> do_exit() are we sure the task cannot ever be preempted anymore ?
> 

Actually, it's the preempt_disable() at the end of do_exit() I was looking
for. The following patch moves the mmdrop() right after preempte_disable.
In my previous patch, the mmdrop() after do_task_dead (which is noreturn)
was rather dumb (leak).

diff --git a/kernel/exit.c b/kernel/exit.c
index 995453d..2804655 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -764,6 +764,7 @@ void __noreturn do_exit(long code)
 {
        struct task_struct *tsk = current;
        int group_dead;
+       struct mm_struct *mm;
 
        profile_task_exit(tsk);
        kcov_task_exit(tsk);
@@ -849,6 +850,10 @@ void __noreturn do_exit(long code)
        tsk->exit_code = code;
        taskstats_exit(tsk, group_dead);
 
+       mm = current->mm;
+       if (mm)
+               mmgrab(mm);
+
        exit_mm();
 
        if (group_dead)
@@ -913,6 +918,8 @@ void __noreturn do_exit(long code)
 
        check_stack_usage();
        preempt_disable();
+       if (mm)
+               mmdrop(mm);
        if (tsk->nr_dirtied)
                __this_cpu_add(dirty_throttle_leaks, tsk->nr_dirtied);
        exit_rcu();


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
