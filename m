Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeCGJpM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 04:45:12 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:39705 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbeCGJpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 04:45:09 -0500
X-Google-Smtp-Source: AG47ELt6JmNrBIU1aDrtTy0XKV83oROYBqRgKvhSQDoZD2dDVZqP+Fw/j2PNXq5z04P/Iie5/xWIiIT3gTgtn0XoCb8=
MIME-Version: 1.0
In-Reply-To: <20180307090917.2xqifk2wpk5ty36j@pathway.suse.cz>
References: <20180305053742.9149-1-sergey.senozhatsky@gmail.com>
 <CAK8P3a1aCQWwrJuCmx-nrMG58NQFCkCPRuAT5g43Lty13nE2dg@mail.gmail.com>
 <20180307022127.GB802@jagdpanzerIV> <CAK8P3a172j6r2HEwQ3cOOqXgXkFbxYifQ96VRFZ3+=wGawYNLQ@mail.gmail.com>
 <20180307090917.2xqifk2wpk5ty36j@pathway.suse.cz>
From: Greentime Hu <green.hu@gmail.com>
Date: Wed, 7 Mar 2018 17:44:27 +0800
Message-ID: <CAEbi=3d4s5DcsVDjd5kV8=1sg9FgL-Qaqv3gBBy39R_CYwPXww@mail.gmail.com>
Subject: Re: [PATCH] dump_stack: convert generic dump_stack into a weak symbol
To: Petr Mladek <pmladek@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Dave Young <dyoung@redhat.com>, Andi Kleen <ak@linux.intel.com>,
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

2018-03-07 17:09 GMT+08:00 Petr Mladek <pmladek@suse.com>:
> Ah, there was a mid-air collision. Arnd already answered most of my
> questions and even more.
>
> On Wed 2018-03-07 09:46:27, Arnd Bergmann wrote:
>> On Wed, Mar 7, 2018 at 3:21 AM, Sergey Senozhatsky
>> <sergey.senozhatsky.work@gmail.com> wrote:
>> > On (03/06/18 14:27), Arnd Bergmann wrote:
>> >> Weak symbols are generally discouraged in the kernel. We have
>> >> them in a couple of places, but I find them rather confusing as they
>> >> make it harder to figure out what is actually going on.
>> >
>> > Honestly, I kind of find __weak less confusing than EXPORT_SYMBOL(dump_stack)
>> > in 3 different places. __weak hints that the symbol likely will be overridden
>> > somewhere, while EXPORT_SYMBOL() does not (at least not to me). Dunno.
>>
>> It's not either/or, they are both wrong ;-)
>>
>> The EXPORT_SYMBOL() is not the thing that makes it work. The duplicate
>> declaration today only works because lib/dump_stack.o is listed as lib-y
>> in the Makefile instead of obj-y. On blackfin and nds32, this causes the entire
>> file to just not be included in the final vmlinux, because there are no
>> references to it.
>>
>> With your patch, I would actually expect the lib/dump_stack.o file
>> to still not be picked up, so now you have a missing EXPORT_SYMBOL()
>> on the two unusual architectures until the point when you add another
>> (referenced) symbol to it.
>
> Great catch! We should change it from lib-y to obj-y. Of course,
> the best solution would be if nds32 uses the generic implementation
> and we could avoid adding __weak.
>

I agree too.
I think I can add a patch to remove the dump_stack() implementation in
nds32 and use the generic one.

diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index 8828b4aeb72b..6e34eb9824a4 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -156,18 +156,6 @@ static void __dump(struct task_struct *tsk,
unsigned long *base_reg)
        pr_emerg("\n");
 }

-void dump_stack(void)
-{
-       unsigned long *base_reg;
-       if (!IS_ENABLED(CONFIG_FRAME_POINTER))
-               __asm__ __volatile__("\tori\t%0, $sp, #0\n":"=r"(base_reg));
-       else
-               __asm__ __volatile__("\tori\t%0, $fp, #0\n":"=r"(base_reg));
-       __dump(NULL, base_reg);
-}
-
-EXPORT_SYMBOL(dump_stack);
-
