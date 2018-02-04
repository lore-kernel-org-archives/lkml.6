Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753095AbeBDB3v (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 20:29:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:60022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753045AbeBDB3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 20:29:43 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1A1217A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AH8x224JdoPqHEqC3KQrBiDUzqTiJg3AAi6kkY50bDanY9tvxFTevdpzV9EfQrJRxORH54e1EQhBEYCjpVrf8T9QB7I=
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jczornu9b1kjWEK6MZXNG81NFfwvy_4PL+CsUkLHo+uQ@mail.gmail.com>
References: <151770009169.7213.12476757146099518628.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151770009703.7213.12036560755602017391.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CALCETrUtU7j3wHfvrSmiA0wkE4=gXXgFsTG3VXh3x3E8WHxvMg@mail.gmail.com> <CAPcyv4jczornu9b1kjWEK6MZXNG81NFfwvy_4PL+CsUkLHo+uQ@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Sun, 4 Feb 2018 01:29:21 +0000
X-Gmail-Original-Message-ID: <CALCETrUJuDTxz2irA4zpFAs+gUY70+TR_1Zk_BEzXtr2be5X-g@mail.gmail.com>
Message-ID: <CALCETrUJuDTxz2irA4zpFAs+gUY70+TR_1Zk_BEzXtr2be5X-g@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/entry: Clear extra registers beyond syscall
 arguments for 64bit kernels
To: Dan Williams <dan.j.williams@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 4, 2018 at 1:25 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Sat, Feb 3, 2018 at 4:14 PM, Andy Lutomirski <luto@kernel.org> wrote:
>> On Sat, Feb 3, 2018 at 11:21 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>>> At entry userspace may have populated the extra registers outside the
>>> syscall calling convention with values that could be useful in a
>>> speculative execution attack. Clear them to minimize the kernel's attack
>>> surface. Note, this only clears the extra registers and not the unused
>>> registers for syscalls less than 6 arguments since those registers are
>>> likely to be clobbered well before their values could be put to use
>>> under speculation.
>>>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>> Cc: x86@kernel.org
>>> Cc: Andy Lutomirski <luto@kernel.org>
>>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>>> Reported-by: Andi Kleen <ak@linux.intel.com>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>> ---
>>>  arch/x86/entry/calling.h  |   17 +++++++++++++++++
>>>  arch/x86/entry/entry_64.S |    1 +
>>>  2 files changed, 18 insertions(+)
>>>
>>> diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
>>> index 3f48f695d5e6..daee2d19e73d 100644
>>> --- a/arch/x86/entry/calling.h
>>> +++ b/arch/x86/entry/calling.h
>>> @@ -147,6 +147,23 @@ For 32-bit we have the following conventions - kernel is built with
>>>         UNWIND_HINT_REGS offset=\offset
>>>         .endm
>>>
>>> +       /*
>>> +        * Sanitize extra registers of values that a speculation attack
>>> +        * might want to exploit. In the CONFIG_FRAME_POINTER=y case,
>>> +        * the expectation is that %ebp will be clobbered before it
>>> +        * could be used.
>>> +        */
>>> +       .macro CLEAR_EXTRA_REGS_NOSPEC
>>> +       xorq %r15, %r15
>>> +       xorq %r14, %r14
>>> +       xorq %r13, %r13
>>> +       xorq %r12, %r12
>>> +       xorl %ebx, %ebx
>>> +#ifndef CONFIG_FRAME_POINTER
>>> +       xorl %ebp, %ebp
>>> +#endif
>>> +       .endm
>>> +
>>
>> Can we make the clears only happen if we have CONFIG_RETPOLINE?  Or is
>> there maybe some reason why we want this even without retpolines on?
>
> We have the other Spectre variant1 mitigations on by default. I'm not
> opposed to adding a config to turn them all off, but I think we should
> be consistent either way, and I don't think CONFIG_RETPOLINE is the
> right config to gate those.

Fair enough.

>
>>>         .macro POP_EXTRA_REGS
>>>         popq %r15
>>>         popq %r14
>>> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
>>> index c752abe89d80..46260e951da6 100644
>>> --- a/arch/x86/entry/entry_64.S
>>> +++ b/arch/x86/entry/entry_64.S
>>> @@ -247,6 +247,7 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
>>>         TRACE_IRQS_OFF
>>>
>>>         /* IRQs are off. */
>>> +       CLEAR_EXTRA_REGS_NOSPEC
>>
>> Please put the clears before TRACE_IRQS_OFF to protect users that use tracing.
>
> Ok.
