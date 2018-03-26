Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752040AbeCZLjk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 07:39:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39806 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751890AbeCZLji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 07:39:38 -0400
Date: Mon, 26 Mar 2018 12:39:33 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "Ji.Zhang" <ji.zhang@mediatek.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>, Dave Martin <Dave.Martin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Michael Weiser <michael.weiser@gmx.de>,
        Julien Thierry <julien.thierry@arm.com>,
        Xie XiuQi <xiexiuqi@huawei.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com, shadanji@163.com
Subject: Re: [PATCH] arm64: avoid race condition issue in dump_backtrace
Message-ID: <20180326113932.2i6qp3776jtmcqk4@lakrids.cambridge.arm.com>
References: <1521687960-3744-1-git-send-email-ji.zhang@mediatek.com>
 <20180322055929.z25brvwlmdighz66@salmiak>
 <1521711329.26617.31.camel@mtksdccf07>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521711329.26617.31.camel@mtksdccf07>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 05:35:29PM +0800, Ji.Zhang wrote:
> On Thu, 2018-03-22 at 05:59 +0000, Mark Rutland wrote:
> > On Thu, Mar 22, 2018 at 11:06:00AM +0800, Ji Zhang wrote:
> > > When we dump the backtrace of some specific task, there is a potential race
> > > condition due to the task may be running on other cores if SMP enabled.
> > > That is because for current implementation, if the task is not the current
> > > task, we will get the registers used for unwind from cpu_context saved in
> > > thread_info, which is the snapshot before context switch, but if the task
> > > is running on other cores, the registers and the content of stack are
> > > changed.
> > > This may cause that we get the wrong backtrace or incomplete backtrace or
> > > even crash the kernel.
> > 
> > When do we call dump_backtrace() on a running task that is not current?
> > 
> > AFAICT, we don't do that in the arm64-specific callers of dump_backtrace(), and
> > this would have to be some caller of show_stack() in generic code.
> Yes, show_stack() can make caller specify a task and dump its backtrace.
> For example, SysRq-T (echo t > /proc/sysrq-trigger) will use this to
> dump the backtrace of specific tasks.

Ok. I see that this eventually calls show_state_filter(0), where we call
sched_show_task() for every task.

> > We pin the task's stack via try_get_task_stack(), so this cannot be unmapped
> > while we walk it. In unwind_frame() we check that the frame record falls
> > entirely within the task's stack. So AFAICT, we cannot crash the kernel here,
> > though the backtrace may be misleading (and we could potentially get stuck in
> > an infinite loop).
> You are right, I have checked the code and it seems that the check for
> fp in unwind_frame() is strong enough to handle the case which stack
> being changed due to task running. And as you mentioned, if
> unfortunately fp is point to the address of itself, the unwind will be
> an infinite loop, but it is a very small probability event, so we can
> ignore this, is that right?

I think that it would be preferable to try to avoid the inifinite loop
case. We could hit that by accident if we're tracing a live task.

It's a little tricky to ensure that we don't loop, since we can have
traces that span several stacks, e.g. overflow -> irq -> task, so we
need to know where the last frame was, and we need to defnie a strict
order for stack nesting.

> > > To avoid this case, do not dump the backtrace of the tasks which are
> > > running on other cores.
> > > This patch cannot solve the issue completely but can shrink the window of
> > > race condition.
> > 
> > > @@ -113,6 +113,9 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
> > >  	if (tsk == current) {
> > >  		frame.fp = (unsigned long)__builtin_frame_address(0);
> > >  		frame.pc = (unsigned long)dump_backtrace;
> > > +	else if (tsk->state == TASK_RUNNING) {
> > > +		pr_notice("Do not dump other running tasks\n");
> > > +		return;
> > 
> > As you note, if we can race with the task being scheduled, this doesn't help.
> > 
> > Can we rule this out at a higher level?
> > Thanks,
> > Mark.
> Actually, according to my previous understanding, the low level function
> should be transparent to callers and should provide the right result and
> handle some unexpected cases, which means that if the result may be
> misleading, we should drop it. That is why I bypass all TASK_RUNNING
> tasks. I am not sure if this understanding is reasonable for this case.

Given that this can change under our feet, I think this only provides a
false sense of security and complicates the code.

> And as you mentioned that rule this out at a higher level, is there any
> suggestions, handle this in the caller of show_stack()?

Unfortunately, it doesn't look like we can do this in general given
cases like sysrq-t.

Thanks,
Mark.
