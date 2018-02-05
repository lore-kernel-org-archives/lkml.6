Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeBEVd0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:33:26 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45655 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751970AbeBEVdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:33:19 -0500
X-Google-Smtp-Source: AH8x224fXnK4LBfVEgtKZQSFeiTQ1yjUNfbWRfCAGJ6IE+xvu6u0KJl2u51QDfrBE2pJKV9qo/gXVOJuatPjxfFncw0=
MIME-Version: 1.0
In-Reply-To: <20180205115836.otnviqbae3pxjk5g@gmail.com>
References: <151776623555.23236.14152911329227555005.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151776624080.23236.1865339140666550495.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180205115836.otnviqbae3pxjk5g@gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 5 Feb 2018 13:33:17 -0800
Message-ID: <CAPcyv4gyP4LAzS=8-ZNfy5gX=QHKK7VpGmeYXoP=rbe47kOg9A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] x86/entry: Clear extra registers beyond syscall
 arguments for 64bit kernels
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 3:58 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Dan Williams <dan.j.williams@intel.com> wrote:
>
>> +     /*
>> +      * Sanitize extra registers of values that a speculation attack
>> +      * might want to exploit. In the CONFIG_FRAME_POINTER=y case,
>> +      * the expectation is that %ebp will be clobbered before it
>> +      * could be used.
>> +      */
>> +     .macro CLEAR_EXTRA_REGS_NOSPEC
>> +     xorq %r15, %r15
>> +     xorq %r14, %r14
>> +     xorq %r13, %r13
>> +     xorq %r12, %r12
>> +     xorl %ebx, %ebx
>> +#ifndef CONFIG_FRAME_POINTER
>> +     xorl %ebp, %ebp
>> +#endif
>
> BTW., is there any reason behind the order of the clearing of these registers?
> This ordering seems rather random:
>
>  - The canonical register order is: RBX, RBP, R12, R13, R14, R15, which is also
>    their push-order on the stack.
>
>  - The CLEAR_EXTRA_REGS_NOSPEC order appears to be the reverse order (pop-order),
>    but with RBX and RBP reversed.
>
> So since this is a 'push side' primitive I'd use the regular (push-) ordering
> instead:
>
>         .macro CLEAR_EXTRA_REGS_NOSPEC
>         xorl %ebx, %ebx
>         xorl %ebp, %ebp
>         xorq %r12, %r12
>         xorq %r13, %r13
>         xorq %r14, %r14
>         xorq %r15, %r15
>
> It obviously doesn't matter to correctness - only to readability.

Sure, will do.

>
> There's also a (very) small micro-optimization argument in favor of the regular
> order: the earlier registers are more likely to be utilized by C functions, so the
> sooner we clear them, the less potential interaction these clearing instructions
> are going to have with any later use.

On a suggestion from Arjan it also appears worthwhile to interleave
'mov' with 'xor'. Perf stat says that this test gets 3.45 instructions
per cycle:

        for (i = 0; i < INT_MAX/1024; i++)
                asm(".rept 1024\n"
                    "xorl %%ebx, %%ebx\n"
                    "movq $0,    %%r10\n"
                    "xorq %%r11, %%r11\n"
                    "movq $0,    %%r12\n"
                    "xorq %%r13, %%r13\n"
                    "movq $0,    %%r14\n"
                    "xorq %%r15, %%r15\n"
                    ".endr"
                    : : : "r15", "r14", "r13", "r12",
                        "ebx", "r11", "r10");

...the 'rept' is there to try to minimize micro-op caching effects.
The straight xor version in comparisons gets 2.88 instructions per
cycle:

        for (i = 0; i < INT_MAX/1024; i++)
                asm(".rept 1024\n"
                    "xorl %%ebx, %%ebx\n"
                    "xorq %%r10, %%r10\n"
                    "xorq %%r11, %%r11\n"
                    "xorq %%r12, %%r12\n"
                    "xorq %%r13, %%r13\n"
                    "xorq %%r14, %%r14\n"
                    "xorq %%r15, %%r15\n"
                    ".endr"
                    : : : "r15", "r14", "r13", "r12",
                        "ebx", "r11", "r10");
