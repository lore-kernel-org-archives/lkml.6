Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeCEOsv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:48:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:57050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752003AbeCEOst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:48:49 -0500
Date: Mon, 5 Mar 2018 15:48:46 +0100
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Dave Young <dyoung@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] dump_stack: convert generic dump_stack into a weak symbol
Message-ID: <20180305144846.3jommv372c73dltt@pathway.suse.cz>
References: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-03-05 14:37:42, Sergey Senozhatsky wrote:
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
>  	show_stack(current, &stack);
>  	trace_buffer_restore(tflags);
>  }
> -EXPORT_SYMBOL(dump_stack);

I was afraid that blackfin modules would not longer be able
to use arch-specific dump_stack symbol. But it seems that only
the symbol name is important. Alos the list of symbols look
promissing:

before:

$> objdump -x vmlinux | less | grep dump_stack
00248530 l     O __ksymtab      00000008 ___ksymtab_dump_stack
002500d4 l     O __ksymtab_strings      0000000c ___kstrtab_dump_stack
00272bb6 l     O .bss   00000080 _dump_stack_arch_desc_str
000051a8 g     F .text  00000042 _dump_stack
002ab05c g     F .init.text     0000002a _dump_stack_set_arch_desc
0003051c g     F .text  000000a4 _dump_stack_print_info


after:

$> objdump -x vmlinux.patched | less | grep dump_stack
00000000 l    df *ABS*  00000000 lib/dump_stack.c
0027c3e8 l     O .bss   00000080 _dump_stack_arch_desc_str
00248580 l     O __ksymtab      00000008 ___ksymtab_dump_stack
002653d4 l     O __ksymtab_strings      0000000c ___kstrtab_dump_stack
000051a8 g     F .text  00000042 _dump_stack
002b69dc g     F .init.text     0000002a _dump_stack_set_arch_desc
001c2a90 g     F .text  000000a4 _dump_stack_print_info

I hope that I did not miss anything. I could not try this at
runtime. I could just cross-compile.

Anyway, from my side:

Reviewed-by: Petr Mladek <pmladek@suse.com>

I'll wait a bit and push it into printk.git for-4.17.


Greentime Hu, you tested this on nds32. Could I use your Tested-by,
please?

Best Regards,
Petr
