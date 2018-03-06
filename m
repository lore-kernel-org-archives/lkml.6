Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753257AbeCFCuz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 21:50:55 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:39329 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752910AbeCFCuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 21:50:54 -0500
X-Google-Smtp-Source: AG47ELvBc/SzqOvqktJDCsiQBksA0qrFbO7+KTFC3/SCNB1Uo8SiOFci4WnCaFMi0nG7GB0P3yYFT5SoTprs43wDqIM=
MIME-Version: 1.0
In-Reply-To: <20180305144846.3jommv372c73dltt@pathway.suse.cz>
References: <20180305053742.9149-1-sergey.senozhatsky@gmail.com> <20180305144846.3jommv372c73dltt@pathway.suse.cz>
From: Greentime Hu <green.hu@gmail.com>
Date: Tue, 6 Mar 2018 10:50:12 +0800
Message-ID: <CAEbi=3f2h0Uw3UOFOyVHXUtzPhr02AK6FfCaZ=N-8jfZDLNpHQ@mail.gmail.com>
Subject: Re: [PATCH] dump_stack: convert generic dump_stack into a weak symbol
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Dave Young <dyoung@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Vincent Chen <deanbo422@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
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

2018-03-05 22:48 GMT+08:00 Petr Mladek <pmladek@suse.com>:
> On Mon 2018-03-05 14:37:42, Sergey Senozhatsky wrote:
>> We want to move dump_stack related functions out of printk C
>> code and consolidate them in lib/dump_stack file. The reason why
>> dump_stack_print_info()/etc ended up in printk.c was a "generic"
>> (dummy) lib dump_stack() function, which archs can override.
>> For example, blackfin and nds32, define their own EXPORT_SYMBOL
>> dump_stack() functions.
>>
>> In case of blackfin that arch-specific dump_stack() symbol invokes
>> a global dump_stack_print_info() function. So we can't easily move
>> dump_stack_print_info() to lib/dump_stack, because this way we will
>> link with lib/dump_stack.o file, which will bring in a generic
>> dump_stack() symbol with it, causing a multiple definitions error:
>>   - one dump_stack() from arch/blackfin/dumpstack
>>   - the other one from lib/dump_stack
>>
>> Convert generic dump_stack() into a weak symbol. So we will be
>> able link with lib/dump_stack and at the same time archs will
>> be able to override dump_stack(). It also opens up a way for us
>> to move dump_stack_set_arch_desc(), dump_stack_print_info() and
>> show_regs_print_info() to lib/dump_stack.
>>
>> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>> ---
>>  arch/blackfin/kernel/dumpstack.c | 1 -
>>  arch/nds32/kernel/traps.c        | 2 --
>>  lib/dump_stack.c                 | 4 ++--
>>  3 files changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/blackfin/kernel/dumpstack.c b/arch/blackfin/kernel/dumpstack.c
>> index 3c992c1f8ef2..61af017130cd 100644
>> --- a/arch/blackfin/kernel/dumpstack.c
>> +++ b/arch/blackfin/kernel/dumpstack.c
>> @@ -174,4 +174,3 @@ void dump_stack(void)
>>       show_stack(current, &stack);
>>       trace_buffer_restore(tflags);
>>  }
>> -EXPORT_SYMBOL(dump_stack);
>
> I was afraid that blackfin modules would not longer be able
> to use arch-specific dump_stack symbol. But it seems that only
> the symbol name is important. Alos the list of symbols look
> promissing:
>
> before:
>
> $> objdump -x vmlinux | less | grep dump_stack
> 00248530 l     O __ksymtab      00000008 ___ksymtab_dump_stack
> 002500d4 l     O __ksymtab_strings      0000000c ___kstrtab_dump_stack
> 00272bb6 l     O .bss   00000080 _dump_stack_arch_desc_str
> 000051a8 g     F .text  00000042 _dump_stack
> 002ab05c g     F .init.text     0000002a _dump_stack_set_arch_desc
> 0003051c g     F .text  000000a4 _dump_stack_print_info
>
>
> after:
>
> $> objdump -x vmlinux.patched | less | grep dump_stack
> 00000000 l    df *ABS*  00000000 lib/dump_stack.c
> 0027c3e8 l     O .bss   00000080 _dump_stack_arch_desc_str
> 00248580 l     O __ksymtab      00000008 ___ksymtab_dump_stack
> 002653d4 l     O __ksymtab_strings      0000000c ___kstrtab_dump_stack
> 000051a8 g     F .text  00000042 _dump_stack
> 002b69dc g     F .init.text     0000002a _dump_stack_set_arch_desc
> 001c2a90 g     F .text  000000a4 _dump_stack_print_info
>
> I hope that I did not miss anything. I could not try this at
> runtime. I could just cross-compile.
>
> Anyway, from my side:
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
> I'll wait a bit and push it into printk.git for-4.17.
>
>
> Greentime Hu, you tested this on nds32. Could I use your Tested-by,
> please?
>

Yes, please use it. :)

greentime@atcsqa02:/NOBACKUP/sqa2/greentime/contrib/src_pkg/linux-next
<next-20180302> $ nds32le-elf-objdump -x vmlinux | less | grep
dump_stack
00000000 l    df *ABS*  00000000 dump_stack.c
b04f7910 l     O .bss   00000080 dump_stack_arch_desc_str
b04995e8 l     O __ksymtab      00000008 __ksymtab_dump_stack
b04b9086 l     O __ksymtab_strings      0000000b __kstrtab_dump_stack
b002a464 g     F .text  00000022 dump_stack
b03a568c g     F .text  000000c2 dump_stack_print_info
b0024cf4 g     F .init.text     00000038 dump_stack_set_arch_desc
