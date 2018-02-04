Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeBDRme (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 12:42:34 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39008 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751430AbeBDRm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 12:42:28 -0500
X-Google-Smtp-Source: AH8x227TSGZbRUUjLJ6CUidW0gwdhD5n9OiULpCVR2pYVw5JRVZANGxWcCczn5vNDDQvf7EF6WZcRNKKjeALhI2N6nk=
MIME-Version: 1.0
In-Reply-To: <CAMzpN2jeq+LDajvwSALpmaZKOChNX1uhRbuEJ3v97HyOEsH44A@mail.gmail.com>
References: <151770009169.7213.12476757146099518628.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151770009703.7213.12036560755602017391.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAMzpN2jeq+LDajvwSALpmaZKOChNX1uhRbuEJ3v97HyOEsH44A@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 4 Feb 2018 09:42:27 -0800
Message-ID: <CAPcyv4gy=Oq5=ZXCvs0mgziwfgEb2p+pE9BJZZP47W+4yrz0Vg@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/entry: Clear extra registers beyond syscall
 arguments for 64bit kernels
To: Brian Gerst <brgerst@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 4, 2018 at 5:01 AM, Brian Gerst <brgerst@gmail.com> wrote:
> On Sat, Feb 3, 2018 at 6:21 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>> At entry userspace may have populated the extra registers outside the
>> syscall calling convention with values that could be useful in a
>> speculative execution attack. Clear them to minimize the kernel's attack
>> surface. Note, this only clears the extra registers and not the unused
>> registers for syscalls less than 6 arguments since those registers are
>> likely to be clobbered well before their values could be put to use
>> under speculation.
>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: x86@kernel.org
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Reported-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>  arch/x86/entry/calling.h  |   17 +++++++++++++++++
>>  arch/x86/entry/entry_64.S |    1 +
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
>> index 3f48f695d5e6..daee2d19e73d 100644
>> --- a/arch/x86/entry/calling.h
>> +++ b/arch/x86/entry/calling.h
>> @@ -147,6 +147,23 @@ For 32-bit we have the following conventions - kernel is built with
>>         UNWIND_HINT_REGS offset=\offset
>>         .endm
>>
>> +       /*
>> +        * Sanitize extra registers of values that a speculation attack
>> +        * might want to exploit. In the CONFIG_FRAME_POINTER=y case,
>> +        * the expectation is that %ebp will be clobbered before it
>> +        * could be used.
>> +        */
>> +       .macro CLEAR_EXTRA_REGS_NOSPEC
>> +       xorq %r15, %r15
>> +       xorq %r14, %r14
>> +       xorq %r13, %r13
>> +       xorq %r12, %r12
>> +       xorl %ebx, %ebx
>> +#ifndef CONFIG_FRAME_POINTER
>> +       xorl %ebp, %ebp
>> +#endif
>> +       .endm
>> +
>>         .macro POP_EXTRA_REGS
>>         popq %r15
>>         popq %r14
>> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
>> index c752abe89d80..46260e951da6 100644
>> --- a/arch/x86/entry/entry_64.S
>> +++ b/arch/x86/entry/entry_64.S
>> @@ -247,6 +247,7 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
>>         TRACE_IRQS_OFF
>>
>>         /* IRQs are off. */
>> +       CLEAR_EXTRA_REGS_NOSPEC
>>         movq    %rsp, %rdi
>>         call    do_syscall_64           /* returns with IRQs disabled */
>>
>>
>
> Now that the fast syscall path is gone, all regs (except RSP
> obviously) are dead after being saved to pt_regs.

They're saved, but not dead afaics. The concern is that when the CPU
starts speculating it could be in a code path that has not yet touched
the extra registers. Once that happens userspace could potentially
load data from an arbitrary address.
