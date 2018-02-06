Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752229AbeBFHxR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 02:53:17 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:34500 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751924AbeBFHxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 02:53:13 -0500
X-Google-Smtp-Source: AH8x225sJV9J4o7LLt0XtxITH1az/FZAO9+kc4rn9m0deLBiTV25oHRkXl7Vih7Pd+2BGzsu0JO66kNDWEodoMlwe8M=
MIME-Version: 1.0
In-Reply-To: <20180206072608.idxe4hhhu6gkeqac@gmail.com>
References: <151787988045.7847.11830748914544718151.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151787989697.7847.4083702787288600552.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180206072608.idxe4hhhu6gkeqac@gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 5 Feb 2018 23:53:12 -0800
X-Google-Sender-Auth: zQsq9NL-yiCkVSbBsZI-9KsARGY
Message-ID: <CAA9_cmcNxVVAL33QTdpTMgioaf_k3cnA1wEAq5E0xdBTwuS3Dg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] x86/entry: Clear registers for compat syscalls
To: Ingo Molnar <mingo@kernel.org>
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

On Mon, Feb 5, 2018 at 11:26 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Dan Williams <dan.j.williams@intel.com> wrote:
>
>> From: Andi Kleen <ak@linux.intel.com>
>>
>> At entry userspace may have populated registers with values that could
>> be useful in a speculative execution attack. Clear them to minimize the
>> kernel's attack surface.
>>
>> [djbw: interleave the clearing with setting up the stack ]
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: x86@kernel.org
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Signed-off-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>  arch/x86/entry/entry_64_compat.S |   30 ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
>> index 98d5358e4041..fd65e016e413 100644
>> --- a/arch/x86/entry/entry_64_compat.S
>> +++ b/arch/x86/entry/entry_64_compat.S
>> @@ -85,15 +85,25 @@ ENTRY(entry_SYSENTER_compat)
>>       pushq   %rcx                    /* pt_regs->cx */
>>       pushq   $-ENOSYS                /* pt_regs->ax */
>>       pushq   $0                      /* pt_regs->r8  = 0 */
>> +     xorq    %r8, %r8                /* nospec   r8 */
>>       pushq   $0                      /* pt_regs->r9  = 0 */
>> +     xorq    %r9, %r9                /* nospec   r9 */
>>       pushq   $0                      /* pt_regs->r10 = 0 */
>> +     xorq    %r10, %r10              /* nospec   r10 */
>>       pushq   $0                      /* pt_regs->r11 = 0 */
>> +     xorq    %r11, %r11              /* nospec   r11 */
>>       pushq   %rbx                    /* pt_regs->rbx */
>> +     xorl    %ebx, %ebx              /* nospec   rbx */
>>       pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
>> +     xorl    %ebp, %ebp              /* nospec   rbp */
>>       pushq   $0                      /* pt_regs->r12 = 0 */
>> +     xorq    %r12, %r12              /* nospec   r12 */
>>       pushq   $0                      /* pt_regs->r13 = 0 */
>> +     xorq    %r13, %r13              /* nospec   r13 */
>>       pushq   $0                      /* pt_regs->r14 = 0 */
>> +     xorq    %r14, %r14              /* nospec   r14 */
>>       pushq   $0                      /* pt_regs->r15 = 0 */
>> +     xorq    %r15, %r15              /* nospec   r15 */
>>       cld
>>
>>       /*
>> @@ -214,15 +224,25 @@ GLOBAL(entry_SYSCALL_compat_after_hwframe)
>>       pushq   %rbp                    /* pt_regs->cx (stashed in bp) */
>>       pushq   $-ENOSYS                /* pt_regs->ax */
>>       pushq   $0                      /* pt_regs->r8  = 0 */
>> +     xorq    %r8, %r8                /* nospec   r8 */
>>       pushq   $0                      /* pt_regs->r9  = 0 */
>> +     xorq    %r9, %r9                /* nospec   r9 */
>>       pushq   $0                      /* pt_regs->r10 = 0 */
>> +     xorq    %r10, %r10              /* nospec   r10 */
>>       pushq   $0                      /* pt_regs->r11 = 0 */
>> +     xorq    %r11, %r11              /* nospec   r11 */
>>       pushq   %rbx                    /* pt_regs->rbx */
>> +     xorl    %ebx, %ebx              /* nospec   rbx */
>>       pushq   %rbp                    /* pt_regs->rbp (will be overwritten) */
>> +     xorl    %ebp, %ebp              /* nospec   rbp */
>>       pushq   $0                      /* pt_regs->r12 = 0 */
>> +     xorq    %r12, %r12              /* nospec   r12 */
>>       pushq   $0                      /* pt_regs->r13 = 0 */
>> +     xorq    %r13, %r13              /* nospec   r13 */
>>       pushq   $0                      /* pt_regs->r14 = 0 */
>> +     xorq    %r14, %r14              /* nospec   r14 */
>>       pushq   $0                      /* pt_regs->r15 = 0 */
>> +     xorq    %r15, %r15              /* nospec   r15 */
>
> I really love it how you've aligned the comment fields vertically - nice!
>
>>       /*
>>        * User mode is traced as though IRQs are on, and SYSENTER
>> @@ -338,15 +358,25 @@ ENTRY(entry_INT80_compat)
>>       pushq   %rcx                    /* pt_regs->cx */
>>       pushq   $-ENOSYS                /* pt_regs->ax */
>>       pushq   $0                      /* pt_regs->r8  = 0 */
>> +     xorq    %r8, %r8                /* nospec   r8 */
>>       pushq   $0                      /* pt_regs->r9  = 0 */
>> +     xorq    %r9, %r9                /* nospec   r9 */
>>       pushq   $0                      /* pt_regs->r10 = 0 */
>> +     xorq    %r10, %r10              /* nospec   r10 */
>>       pushq   $0                      /* pt_regs->r11 = 0 */
>> +     xorq    %r11, %r11              /* nospec   r11 */
>>       pushq   %rbx                    /* pt_regs->rbx */
>> +     xorl    %ebx, %ebx              /* nospec   rbx */
>>       pushq   %rbp                    /* pt_regs->rbp */
>> +     xorl    %ebp, %ebp              /* nospec   rbp */
>>       pushq   %r12                    /* pt_regs->r12 */
>> +     xorq    %r12, %r12              /* nospec   r12 */
>>       pushq   %r13                    /* pt_regs->r13 */
>> +     xorq    %r13, %r13              /* nospec   r13 */
>>       pushq   %r14                    /* pt_regs->r14 */
>> +     xorq    %r14, %r14              /* nospec   r14 */
>>       pushq   %r15                    /* pt_regs->r15 */
>> +     xorq    %r15, %r15              /* nospec   r15 */
>>       cld
>
> BTW., these last two patches have changed *significantly* from Andi's original
> patches that were submitted originally, so I changed them over to:
>
>   From: Dan Williams <dan.j.williams@intel.com>
>   ...
>   Originally-From: Andi Kleen <ak@linux.intel.com>
>   Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> ... to better show authorship history.
>
> Please let me know if that's not OK.

Works for me.

Thanks Ingo.
