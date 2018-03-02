Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947440AbeCBSpa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 13:45:30 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:41897 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947427AbeCBSp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 13:45:27 -0500
X-Google-Smtp-Source: AG47ELtbPYXDksp9Wpz6uVcdQb4clVzDqhSPGoB5u4DNFs4jfy/8sY+Z11qm+9bDzmEOF2m/t4FFrdMvk+7VYb1famg=
MIME-Version: 1.0
In-Reply-To: <20180302181636.a2nqgm4ezrbcdxkc@lakrids.cambridge.arm.com>
References: <20180301193803.129195-1-dianders@chromium.org>
 <20180302180131.GA20579@arm.com> <20180302181636.a2nqgm4ezrbcdxkc@lakrids.cambridge.arm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 2 Mar 2018 10:45:25 -0800
X-Google-Sender-Auth: DDSJUtIUS5YgV62-JZrQXHq928s
Message-ID: <CAD=FV=U5QFqn3PU_H1rU0KMJBD9yt1FCLJd=E0afGVPg19wgWA@mail.gmail.com>
Subject: Re: [PATCH] arm64/debug: Fix registers on sleeping tasks
To: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Brian Norris <briannorris@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, evgreen@chromium.org,
        Ingo Molnar <mingo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 2, 2018 at 10:16 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Mar 02, 2018 at 06:01:31PM +0000, Will Deacon wrote:
>> On Thu, Mar 01, 2018 at 11:38:03AM -0800, Douglas Anderson wrote:
>> > This is the equivalent of commit 001bf455d206 ("ARM: 8428/1: kgdb: Fix
>> > registers on sleeping tasks") but for arm64.  Nuff said.
>>
>> It's a pity that 001bf455d206 doesn't explain *why* past_pt_regs doesn't
>> work.
>
> The task_pt_regs are the userspace regs at the highest address on the
> kernel stack:
>
> #define task_pt_regs(p) \
>         ((struct pt_regs *)(THREAD_SIZE + task_stack_page(p)) - 1)
>
> ... for kernel tasks, that's meaningless, and for user tasks, that won't
> correspond to kernel state.
>
>> > diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
>> > index 2122cd187f19..01285d4dcdc3 100644
>> > --- a/arch/arm64/kernel/kgdb.c
>> > +++ b/arch/arm64/kernel/kgdb.c
>> > @@ -138,14 +138,26 @@ int dbg_set_reg(int regno, void *mem, struct pt_regs *regs)
>> >  void
>> >  sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *task)
>> >  {
>> > -   struct pt_regs *thread_regs;
>> > +   struct thread_struct *thread = &task->thread;
>> > +   struct cpu_context *cpu_context = &thread->cpu_context;
>
> We can do this in one go:
>
>         struct cpu_context *cpu_context = &task->thread.cpu_context;
>
> ... since we don't need the thread variable otherwise.

Sure, I can spin it that way if it makes you happy.


>> >
>> >     /* Initialize to zero */
>> >     memset((char *)gdb_regs, 0, NUMREGBYTES);
>> > -   thread_regs = task_pt_regs(task);
>> > -   memcpy((void *)gdb_regs, (void *)thread_regs->regs, GP_REG_BYTES);
>> > -   /* Special case for PSTATE (check comments in asm/kgdb.h for details) */
>> > -   dbg_get_reg(33, gdb_regs + GP_REG_BYTES, thread_regs);
>> > +
>> > +   gdb_regs[19] = cpu_context->x19;
>> > +   gdb_regs[20] = cpu_context->x20;
>> > +   gdb_regs[21] = cpu_context->x21;
>> > +   gdb_regs[22] = cpu_context->x22;
>> > +   gdb_regs[23] = cpu_context->x23;
>> > +   gdb_regs[24] = cpu_context->x24;
>> > +   gdb_regs[25] = cpu_context->x25;
>> > +   gdb_regs[26] = cpu_context->x26;
>> > +   gdb_regs[27] = cpu_context->x27;
>> > +   gdb_regs[28] = cpu_context->x28;
>> > +   gdb_regs[29] = cpu_context->fp;
>> > +
>> > +   gdb_regs[31] = cpu_context->sp;
>> > +   gdb_regs[32] = cpu_context->pc;
>
> Are the other reg fields initialised elsewhere?
>
> We might want to zero them here.

Isn't that covered by the the "/* Initialize to zero */" comment and
and "memset((char *)gdb_regs, 0, NUMREGBYTES);"

...or are you thinking of initting something else to zero?


-Doug
