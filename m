Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753674AbeCFN1d (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 08:27:33 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:45853 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753497AbeCFN1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 08:27:31 -0500
X-Google-Smtp-Source: AG47ELvjYBS7xtFh24FfD76bLFoPC8QIqmsIw7gRhdTxSH2zSexETrB58cHYwNvgXkcFS9E7Jjkx2QIJSmk/EfqxGTk=
MIME-Version: 1.0
In-Reply-To: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
References: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Mar 2018 14:27:30 +0100
X-Google-Sender-Auth: gqLkA6Rt0h-fw9euvxQfB0_qV6Y
Message-ID: <CAK8P3a1aCQWwrJuCmx-nrMG58NQFCkCPRuAT5g43Lty13nE2dg@mail.gmail.com>
Subject: Re: [PATCH] dump_stack: convert generic dump_stack into a weak symbol
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, Dave Young <dyoung@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        adi-buildroot-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 5, 2018 at 6:37 AM, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
> We want to move dump_stack related functions out of printk C
> code and consolidate them in lib/dump_stack file. The reason why
> dump_stack_print_info()/etc ended up in printk.c was a "generic"
> (dummy) lib dump_stack() function, which archs can override.
> For example, blackfin and nds32, define their own EXPORT_SYMBOL
> dump_stack() functions.
>
> In case of blackfin that arch-specific dump_stack() symbol invokes
> a global dump_stack_print_info() function. So we can't easily move
> dump_stack_print_info() to lib/dump_stack, because this way we will
> link with lib/dump_stack.o file, which will bring in a generic
> dump_stack() symbol with it, causing a multiple definitions error:
>   - one dump_stack() from arch/blackfin/dumpstack
>   - the other one from lib/dump_stack
>
> Convert generic dump_stack() into a weak symbol. So we will be
> able link with lib/dump_stack and at the same time archs will
> be able to override dump_stack(). It also opens up a way for us
> to move dump_stack_set_arch_desc(), dump_stack_print_info() and
> show_regs_print_info() to lib/dump_stack.
>
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  arch/blackfin/kernel/dumpstack.c | 1 -
>  arch/nds32/kernel/traps.c        | 2 --
>  lib/dump_stack.c                 | 4 ++--
>  3 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/arch/blackfin/kernel/dumpstack.c b/arch/blackfin/kernel/dumpstack.c
> index 3c992c1f8ef2..61af017130cd 100644
> --- a/arch/blackfin/kernel/dumpstack.c
> +++ b/arch/blackfin/kernel/dumpstack.c
> @@ -174,4 +174,3 @@ void dump_stack(void)
>         show_stack(current, &stack);
>         trace_buffer_restore(tflags);
>  }
> -EXPORT_SYMBOL(dump_stack);

As we are now removing blackfin, based on the latest discussion, this
part should no longer be necessary.

> diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
> index 8828b4aeb72b..455bb0787367 100644
> --- a/arch/nds32/kernel/traps.c
> +++ b/arch/nds32/kernel/traps.c
> @@ -166,8 +166,6 @@ void dump_stack(void)
>         __dump(NULL, base_reg);
>  }
>
> -EXPORT_SYMBOL(dump_stack);
> -
>  void show_stack(struct task_struct *tsk, unsigned long *sp)
>  {
>         unsigned long *base_reg;

nds32 currently only exists in linux-next, not in the mainline kernel.
If it's the only architecture that does something different from everyone
else, I think we should change nds32.

I looked at the nds32 show_stack() implementation now and it
seems to me that it is completely unnecessary, as the implementation
from lib/dump_stack.c does basically the same thing (by calling
show_stack(NULL, NULL)).

> diff --git a/lib/dump_stack.c b/lib/dump_stack.c
> index c5edbedd364d..02a8ad163760 100644
> --- a/lib/dump_stack.c
> +++ b/lib/dump_stack.c
> @@ -25,7 +25,7 @@ static void __dump_stack(void)
>  #ifdef CONFIG_SMP
>  static atomic_t dump_lock = ATOMIC_INIT(-1);
>
> -asmlinkage __visible void dump_stack(void)
> +asmlinkage __weak __visible void dump_stack(void)
>  {
>         unsigned long flags;
>         int was_locked;
> @@ -58,7 +58,7 @@ asmlinkage __visible void dump_stack(void)
>         local_irq_restore(flags);
>  }
>  #else
> -asmlinkage __visible void dump_stack(void)
> +asmlinkage __weak __visible void dump_stack(void)
>  {
>         __dump_stack();
>  }

Weak symbols are generally discouraged in the kernel. We have
them in a couple of places, but I find them rather confusing as they
make it harder to figure out what is actually going on.

       Arnd
