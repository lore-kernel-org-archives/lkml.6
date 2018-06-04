Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbeFDWGS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 18:06:18 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:42412 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbeFDWGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 18:06:17 -0400
X-Google-Smtp-Source: ADUXVKJnJEEuhnmaeE2ezkv6Bn+nJBchvFwZZ2AP8Xg8VaQQZdZXPuBV5N8jPWz+3CBrVKBRdpGVdo9J+NViyjB7eoA=
MIME-Version: 1.0
In-Reply-To: <20180604112131.59100-4-namit@vmware.com>
References: <20180604112131.59100-1-namit@vmware.com> <20180604112131.59100-4-namit@vmware.com>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 4 Jun 2018 15:06:15 -0700
X-Google-Sender-Auth: bUVx7QNegFEXY-p0FmuEWRjJXF8
Message-ID: <CAGXu5jJFUMsQFhxeZivbQZwQRPwdJr6gD8EkKfzasWr2SBoggQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] x86: refcount: prevent gcc distortions
To: Nadav Amit <namit@vmware.com>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 4, 2018 at 4:21 AM, Nadav Amit <namit@vmware.com> wrote:
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
> Interestingly, this allows more aggressive inlining while reducing the
> kernel size.
>
>    text    data     bss     dec     hex filename
> 18140970 10225412 2957312 31323694 1ddf62e ./vmlinux before
> 18140140 10225284 2957312 31322736 1ddf270 ./vmlinux after (-958)
>
> Static text symbols:
> Before: 40302
> After:  40286   (-16)
>
> Functions such as kref_get(), free_user(), fuse_file_get() now get
> inlined.
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
>  arch/x86/include/asm/refcount.h | 73 ++++++++++++++++++++-------------
>  arch/x86/kernel/macros.S        |  1 +
>  2 files changed, 45 insertions(+), 29 deletions(-)
>
> diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
> index 4cf11d88d3b3..53462f32b58e 100644
> --- a/arch/x86/include/asm/refcount.h
> +++ b/arch/x86/include/asm/refcount.h
> @@ -4,6 +4,9 @@
>   * x86-specific implementation of refcount_t. Based on PAX_REFCOUNT from
>   * PaX/grsecurity.
>   */
> +
> +#ifndef __ASSEMBLY__

Can you swap the order here, so that the asm macros are visible first
in the file?

#ifdef __ASSEMBLY__
...macros
#else
....C
#endif

-Kees

> +
>  #include <linux/refcount.h>
>
>  /*
> @@ -14,34 +17,11 @@
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
> -       _ASM_EXTABLE_REFCOUNT(112b, 113b)
> -
> -/* Trigger refcount exception if refcount result is negative. */
> -#define REFCOUNT_CHECK_LT_ZERO                         \
> -       "js 111f\n\t"                                   \
> -       _REFCOUNT_EXCEPTION
> -
> -/* Trigger refcount exception if refcount result is zero or negative. */
> -#define REFCOUNT_CHECK_LE_ZERO                         \
> -       "jz 111f\n\t"                                   \
> -       REFCOUNT_CHECK_LT_ZERO
> -
> -/* Trigger refcount exception unconditionally. */
> -#define REFCOUNT_ERROR                                 \
> -       "jmp 111f\n\t"                                  \
> -       _REFCOUNT_EXCEPTION
>
>  static __always_inline void refcount_add(unsigned int i, refcount_t *r)
>  {
>         asm volatile(LOCK_PREFIX "addl %1,%0\n\t"
> -               REFCOUNT_CHECK_LT_ZERO
> +               "REFCOUNT_CHECK_LT_ZERO counter=\"%[counter]\""
>                 : [counter] "+m" (r->refs.counter)
>                 : "ir" (i)
>                 : "cc", "cx");
> @@ -50,7 +30,7 @@ static __always_inline void refcount_add(unsigned int i, refcount_t *r)
>  static __always_inline void refcount_inc(refcount_t *r)
>  {
>         asm volatile(LOCK_PREFIX "incl %0\n\t"
> -               REFCOUNT_CHECK_LT_ZERO
> +               "REFCOUNT_CHECK_LT_ZERO counter=\"%[counter]\""
>                 : [counter] "+m" (r->refs.counter)
>                 : : "cc", "cx");
>  }
> @@ -58,7 +38,7 @@ static __always_inline void refcount_inc(refcount_t *r)
>  static __always_inline void refcount_dec(refcount_t *r)
>  {
>         asm volatile(LOCK_PREFIX "decl %0\n\t"
> -               REFCOUNT_CHECK_LE_ZERO
> +               "REFCOUNT_CHECK_LE_ZERO counter=\"%[counter]\""
>                 : [counter] "+m" (r->refs.counter)
>                 : : "cc", "cx");
>  }
> @@ -66,13 +46,15 @@ static __always_inline void refcount_dec(refcount_t *r)
>  static __always_inline __must_check
>  bool refcount_sub_and_test(unsigned int i, refcount_t *r)
>  {
> -       GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl", REFCOUNT_CHECK_LT_ZERO,
> +       GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl",
> +                                 "REFCOUNT_CHECK_LT_ZERO counter=\"%0\"",
>                                   r->refs.counter, "er", i, "%0", e, "cx");
>  }
>
>  static __always_inline __must_check bool refcount_dec_and_test(refcount_t *r)
>  {
> -       GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl", REFCOUNT_CHECK_LT_ZERO,
> +       GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
> +                                "REFCOUNT_CHECK_LT_ZERO counter=\"%0\"",
>                                  r->refs.counter, "%0", e, "cx");
>  }
>
> @@ -90,7 +72,7 @@ bool refcount_add_not_zero(unsigned int i, refcount_t *r)
>
>                 /* Did we try to increment from/to an undesirable state? */
>                 if (unlikely(c < 0 || c == INT_MAX || result < c)) {
> -                       asm volatile(REFCOUNT_ERROR
> +                       asm volatile("REFCOUNT_ERROR counter=\"%[counter]\""
>                                      : : [counter] "m" (r->refs.counter)
>                                      : "cc", "cx");
>                         break;
> @@ -106,4 +88,37 @@ static __always_inline __must_check bool refcount_inc_not_zero(refcount_t *r)
>         return refcount_add_not_zero(1, r);
>  }
>
> +#else /* __ASSEMBLY__ */
> +#include <asm/asm.h>
> +#include <asm/bug.h>
> +
> +.macro REFCOUNT_EXCEPTION counter:req
> +       .pushsection .text..refcount
> +111:   lea \counter, %_ASM_CX
> +112:   ud2
> +       ASM_UNREACHABLE
> +       .popsection
> +113:   _ASM_EXTABLE_REFCOUNT(112b, 113b)
> +.endm
> +
> +/* Trigger refcount exception if refcount result is negative. */
> +.macro REFCOUNT_CHECK_LT_ZERO counter:req
> +       js 111f
> +       REFCOUNT_EXCEPTION \counter
> +.endm
> +
> +/* Trigger refcount exception if refcount result is zero or negative. */
> +.macro REFCOUNT_CHECK_LE_ZERO counter:req
> +       jz 111f
> +       REFCOUNT_CHECK_LT_ZERO counter=\counter
> +.endm
> +
> +/* Trigger refcount exception unconditionally. */
> +.macro REFCOUNT_ERROR counter:req
> +       jmp 111f
> +       REFCOUNT_EXCEPTION counter=\counter
> +.endm
> +
> +#endif /* __ASSEMBLY__ */
> +
>  #endif
> diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
> index cee28c3246dc..f1fe1d570365 100644
> --- a/arch/x86/kernel/macros.S
> +++ b/arch/x86/kernel/macros.S
> @@ -7,3 +7,4 @@
>   */
>
>  #include <linux/compiler.h>
> +#include <asm/refcount.h>
> --
> 2.17.0
>



-- 
Kees Cook
Pixel Security
