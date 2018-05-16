Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbeEPN7G (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:59:06 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34500 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752505AbeEPN7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:59:04 -0400
X-Google-Smtp-Source: AB8JxZrCEPXZOV+qJ0j5xVjnEKZCgSzpfGN7nwyWFBY6t9ejgEaoBqjdASKvxy+7xB1sk4MOeXLErroM1KSl1k603Mk=
MIME-Version: 1.0
In-Reply-To: <20180515141124.84254-6-namit@vmware.com>
References: <20180515141124.84254-1-namit@vmware.com> <20180515141124.84254-6-namit@vmware.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 16 May 2018 06:59:02 -0700
X-Google-Sender-Auth: iabVJPc_2xAqCX4lXEpYcGTnKu8
Message-ID: <CAGXu5j+wXoAaAFzmnU=VuYeHrGTyzBsEnCdeALYb=jXUaeeQ6g@mail.gmail.com>
Subject: Re: [RFC 5/8] x86: refcount: prevent gcc distortions
To: Nadav Amit <namit@vmware.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 7:11 AM, Nadav Amit <namit@vmware.com> wrote:
> GCC considers the number of statements in inlined assembly blocks,
> according to new-lines and semicolons, as an indication to the cost of
> the block in time and space. This data is distorted by the kernel code,
> which puts information in alternative sections. As a result, the
> compiler may perform incorrect inlining and branch optimizations.
>
> The solution is to set an assembly macro and call it from the inlined
> assembly block. As a result GCC considers the inline assembly block as
> a single instruction.
>
> This patch allows to inline functions such as __get_seccomp_filter().
> The effect of the patch is as follows on the kernel size:
>
>    text    data     bss     dec     hex filename
> 18146418 10064100 2936832 31147350 1db4556 ./vmlinux before
> 18148228 10063968 2936832 31149028 1db4be4 ./vmlinux after (+1678)
>
> Static text symbols:
> Before: 39673
> After:  39649   (-24)
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Jan Beulich <JBeulich@suse.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/x86/include/asm/refcount.h | 55 ++++++++++++++++++++-------------
>  1 file changed, 33 insertions(+), 22 deletions(-)
>
> diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
> index 4cf11d88d3b3..a668c534206d 100644
> --- a/arch/x86/include/asm/refcount.h
> +++ b/arch/x86/include/asm/refcount.h
> @@ -14,34 +14,43 @@
>   * central refcount exception. The fixup address for the exception points
>   * back to the regular execution flow in .text.
>   */
> -#define _REFCOUNT_EXCEPTION                            \
> -       ".pushsection .text..refcount\n"                \
> -       "111:\tlea %[counter], %%" _ASM_CX "\n"         \
> -       "112:\t" ASM_UD2 "\n"                           \
> -       ASM_UNREACHABLE                                 \
> -       ".popsection\n"                                 \
> -       "113:\n"                                        \
> +
> +asm ("\n"
> +       ".macro __REFCOUNT_EXCEPTION counter:vararg\n\t"

Why are these vararg?

Also, I think for the whole series, these #define-a-macro cases need a
comment in the code. It's not obvious from looking at the code why
they've defined a macro instead of just leaving the asm as it was.

Beyond that, as long as there is no behavioral changes, I'm fine with
the changes.

-Kees

-- 
Kees Cook
Pixel Security
