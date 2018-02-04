Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeBDNCF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 08:02:05 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:36697 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbeBDNB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 08:01:57 -0500
X-Google-Smtp-Source: AH8x226LzduF9w8EGvELGaasFiUD9Jgl2kR7pNMO/sSQAfDpBEOJw1WS6IYyv1C9m0iJSHm2IxATt5bBdYOEfJEldxg=
MIME-Version: 1.0
In-Reply-To: <151770009703.7213.12036560755602017391.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151770009169.7213.12476757146099518628.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151770009703.7213.12036560755602017391.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Sun, 4 Feb 2018 08:01:56 -0500
Message-ID: <CAMzpN2jeq+LDajvwSALpmaZKOChNX1uhRbuEJ3v97HyOEsH44A@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/entry: Clear extra registers beyond syscall
 arguments for 64bit kernels
To: Dan Williams <dan.j.williams@intel.com>
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

On Sat, Feb 3, 2018 at 6:21 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> At entry userspace may have populated the extra registers outside the
> syscall calling convention with values that could be useful in a
> speculative execution attack. Clear them to minimize the kernel's attack
> surface. Note, this only clears the extra registers and not the unused
> registers for syscalls less than 6 arguments since those registers are
> likely to be clobbered well before their values could be put to use
> under speculation.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Andy Lutomirski <luto@kernel.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Reported-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/x86/entry/calling.h  |   17 +++++++++++++++++
>  arch/x86/entry/entry_64.S |    1 +
>  2 files changed, 18 insertions(+)
>
> diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
> index 3f48f695d5e6..daee2d19e73d 100644
> --- a/arch/x86/entry/calling.h
> +++ b/arch/x86/entry/calling.h
> @@ -147,6 +147,23 @@ For 32-bit we have the following conventions - kernel is built with
>         UNWIND_HINT_REGS offset=\offset
>         .endm
>
> +       /*
> +        * Sanitize extra registers of values that a speculation attack
> +        * might want to exploit. In the CONFIG_FRAME_POINTER=y case,
> +        * the expectation is that %ebp will be clobbered before it
> +        * could be used.
> +        */
> +       .macro CLEAR_EXTRA_REGS_NOSPEC
> +       xorq %r15, %r15
> +       xorq %r14, %r14
> +       xorq %r13, %r13
> +       xorq %r12, %r12
> +       xorl %ebx, %ebx
> +#ifndef CONFIG_FRAME_POINTER
> +       xorl %ebp, %ebp
> +#endif
> +       .endm
> +
>         .macro POP_EXTRA_REGS
>         popq %r15
>         popq %r14
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index c752abe89d80..46260e951da6 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -247,6 +247,7 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
>         TRACE_IRQS_OFF
>
>         /* IRQs are off. */
> +       CLEAR_EXTRA_REGS_NOSPEC
>         movq    %rsp, %rdi
>         call    do_syscall_64           /* returns with IRQs disabled */
>
>

Now that the fast syscall path is gone, all regs (except RSP
obviously) are dead after being saved to pt_regs.

--
Brian Gerst
