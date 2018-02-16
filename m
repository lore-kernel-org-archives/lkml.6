Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752519AbeBPSd3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 13:33:29 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43140 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752429AbeBPSd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 13:33:28 -0500
Date: Fri, 16 Feb 2018 18:33:20 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: arm64/v4.16-rc1: KASAN: use-after-free Read in finish_task_switch
Message-ID: <20180216183320.rw7trsakkdtzv5vd@lakrids.cambridge.arm.com>
References: <20180214120254.qq4w4s42ecxio7lu@lakrids.cambridge.arm.com>
 <20180214165131.o25r3hhrtrjk3ejq@lakrids.cambridge.arm.com>
 <254787533.21950.1518634424009.JavaMail.zimbra@efficios.com>
 <20180215142239.GF16623@arm.com>
 <20180215164754.GW25201@hirez.programming.kicks-ass.net>
 <20180215182154.GD15274@arm.com>
 <1144433342.22716.1518732536600.JavaMail.zimbra@efficios.com>
 <20180216165330.65rjxjw7qwkei2ob@lakrids.cambridge.arm.com>
 <1037744516.23063.1518801477666.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037744516.23063.1518801477666.JavaMail.zimbra@efficios.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 05:17:57PM +0000, Mathieu Desnoyers wrote:
> ----- On Feb 16, 2018, at 11:53 AM, Mark Rutland mark.rutland@arm.com wrote:
> > I suspect we have a bogus mmdrop or mmput elsewhere, and do_exit() and
> > finish_task_switch() aren't to blame.
> 
> Currently reviewing: fs/proc/base.c: __set_oom_adj()
> 
>         /*
>          * Make sure we will check other processes sharing the mm if this is
>          * not vfrok which wants its own oom_score_adj.
>          * pin the mm so it doesn't go away and get reused after task_unlock
>          */
>         if (!task->vfork_done) {
>                 struct task_struct *p = find_lock_task_mm(task);
> 
>                 if (p) {
>                         if (atomic_read(&p->mm->mm_users) > 1) {
>                                 mm = p->mm;
>                                 mmgrab(mm);
>                         }
>                         task_unlock(p);
>                 }
>         }
> 
> Considering that mmput() done by exit_mm() is done outside of the
> task_lock critical section, I wonder how the mm_users load is
> synchronized ?

That looks suspicious, but I don't think it can result in this
particular problem.

In find_lock_task_mm() we get the task lock, and check mm != NULL, which
means that mm->mm_count >= 1 (thanks to the implicit reference
context_switch()+finish_task_switch() manage). While we hold the task
lock, task->mm can't change beneath our feet, and hence that reference
can't be dropped by finish_task_switch().

Thus, immediately after the mmgrab(), we know mm->mm_count >= 2. That
shouldn't drop below 1 until the subsequent mmdrop(), even after we drop
the task lock, unless there's a misplaced mmdrop() elsewhere. Locally,
mmgrab() and mmdrop() are balanced.

However, if mm_users can be incremented behind our back, we might skip
updating the oom adjustments for other users of the mm.

Thanks,
Mark.
