Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755951AbeBPRQ5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:16:57 -0500
Received: from mail.efficios.com ([167.114.142.141]:38129 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbeBPRQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:16:56 -0500
Date: Fri, 16 Feb 2018 17:17:57 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Message-ID: <1037744516.23063.1518801477666.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180216165330.65rjxjw7qwkei2ob@lakrids.cambridge.arm.com>
References: <20180214120254.qq4w4s42ecxio7lu@lakrids.cambridge.arm.com> <20180214165131.o25r3hhrtrjk3ejq@lakrids.cambridge.arm.com> <254787533.21950.1518634424009.JavaMail.zimbra@efficios.com> <20180215142239.GF16623@arm.com> <20180215164754.GW25201@hirez.programming.kicks-ass.net> <20180215182154.GD15274@arm.com> <1144433342.22716.1518732536600.JavaMail.zimbra@efficios.com> <20180216165330.65rjxjw7qwkei2ob@lakrids.cambridge.arm.com>
Subject: Re: arm64/v4.16-rc1: KASAN: use-after-free Read in
 finish_task_switch
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.141]
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - FF52 (Linux)/8.7.11_GA_1854)
Thread-Topic: arm64/v4.16-rc1: KASAN: use-after-free Read in finish_task_switch
Thread-Index: gxXlrppHEFr00T7k/Mejg8z+8wABgg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 16, 2018, at 11:53 AM, Mark Rutland mark.rutland@arm.com wrote:

> Hi,
> 
> On Thu, Feb 15, 2018 at 10:08:56PM +0000, Mathieu Desnoyers wrote:
>> My current theory: do_exit() gets preempted after having set current->mm
>> to NULL, and after having issued mmput(), which brings the mm_count down
>> to 0.
>>
>> Unfortunately, if the scheduler switches from a userspace thread
>> to a kernel thread, context_switch() loads prev->active_mm which still
>> points to the now-freed mm, mmgrab the mm, and eventually does mmdrop
>> in finish_task_switch().
> 
> For this to happen, we need to get to the mmput() in exit_mm() with:
> 
>  mm->mm_count == 1
>  mm->mm_users == 1
>  mm == active_mm
> 
> ... but AFAICT, this cannot happen.
> 
> If there's no context_switch between clearing current->mm and the
> mmput(), then mm->mm_count >= 2, thanks to the prior mmgrab() and the
> active_mm reference (in mm_count) that context_switch+finish_task_switch
> manage.
> 
> If there is a context_switch between the two, then AFAICT, either:
> 
> a) The task re-inherits its old mm as active_mm, and mm_count >= 2. In
>   context_switch we mmgrab() the active_mm to inherit it, and in
>   finish_task_switch() we drop the oldmm, balancing the mmgrab() with
>   an mmput().
> 
>   e.g we go task -> kernel_task -> task
> 
> b) At some point, another user task is scheduled, and we switch to its
>   mm. We don't mmgrab() the active_mm, but we mmdrop() the oldmm, which
>   means mm_count >= 1. Since we witched to a new mm, if we switch back
>   to the first task, it cannot have its own mm as active_mm.
> 
>   e.g. we go task -> other_task -> task
> 
> I suspect we have a bogus mmdrop or mmput elsewhere, and do_exit() and
> finish_task_switch() aren't to blame.

Currently reviewing: fs/proc/base.c: __set_oom_adj()

        /*
         * Make sure we will check other processes sharing the mm if this is
         * not vfrok which wants its own oom_score_adj.
         * pin the mm so it doesn't go away and get reused after task_unlock
         */
        if (!task->vfork_done) {
                struct task_struct *p = find_lock_task_mm(task);

                if (p) {
                        if (atomic_read(&p->mm->mm_users) > 1) {
                                mm = p->mm;
                                mmgrab(mm);
                        }
                        task_unlock(p);
                }
        }

Considering that mmput() done by exit_mm() is done outside of the
task_lock critical section, I wonder how the mm_users load is
synchronized ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
