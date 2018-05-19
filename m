Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeESIgJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 04:36:09 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54706 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751975AbeESIgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 04:36:05 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Anvin <h.peter.anvin@intel.com>,
        kernel test robot <xiaolong.ye@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Anvin <hpa@zytor.com>, tipbuild@zytor.com, LKP <lkp@01.org>
Subject: Re: "interesting" entry in hibernation code was Re: [lkp-robot] [x86/asm] 51bad67ffb: int3:#[##]
Date: Sat, 19 May 2018 10:35:27 +0200
Message-ID: <6938886.d705BbSbgG@aspire.rjw.lan>
In-Reply-To: <20180519070008.GC30676@amd>
References: <20180515080033.GA7714@yexl-desktop> <CA+55aFwrT-BAvdujUonX5MvB=8GFopQJT4x6xMhtjNN2G0AxSw@mail.gmail.com> <20180519070008.GC30676@amd>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, May 19, 2018 9:00:08 AM CEST Pavel Machek wrote:
> Hi!
> 
> > Side note: doing some grepping, I find some other sequences that are a bit
> > scary, like this:
> > 
> > arch/x86/kernel/acpi/wakeup_32.S-.data
> > arch/x86/kernel/acpi/wakeup_32.S-ALIGN
> > arch/x86/kernel/acpi/wakeup_32.S:ENTRY(saved_magic)     .long   0
> > arch/x86/kernel/acpi/wakeup_32.S:ENTRY(saved_eip)       .long   0
> > 
> > so apparently people are using ENTRY() for data too (the same pattern
> > exists in wakeup_64.S).
> > 
> > So we end up having those odd 0x90 bytes (now 0xcc) in the data section as
> > "padding" between those two values. Crazy.
> 
> Sorry about that. I'm pretty sure intention was simply to use the
> variable from C code.. and ENTRY() worked. I was not aware that it has
> side effect of padding...
> 
> Let me see how this can be improved... (untested).
> 
> diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
> index 0c26b1b..d6f477f 100644
> --- a/arch/x86/kernel/acpi/wakeup_32.S
> +++ b/arch/x86/kernel/acpi/wakeup_32.S
> @@ -89,8 +89,8 @@ ret_point:
>  
>  .data
>  ALIGN
> -ENTRY(saved_magic)	.long	0
> -ENTRY(saved_eip)	.long	0
> +GLOBAL(saved_magic)	.long	0
> +saved_eip:	.long	0
>  
>  # saved registers
>  saved_idt:	.long	0,0

The Jiri Slaby's annotation patches touch this:

https://patchwork.kernel.org/patch/10409073/

Thanks,
Rafael
