Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbeBUVjV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:39:21 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:45735 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeBUVjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 16:39:20 -0500
X-Google-Smtp-Source: AH8x227QZjU2qkIHpXZ6o7gEsyMzTbNUUYUgYPJiQ6rqcZWyF9lgOg51TCRexMN+TE6hEn0wYmueRzW82zUrbWERuWk=
MIME-Version: 1.0
In-Reply-To: <5A8AF1F802000078001A91E1@prv-mh.provo.novell.com>
References: <5A8AF1F802000078001A91E1@prv-mh.provo.novell.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 21 Feb 2018 13:39:18 -0800
X-Google-Sender-Auth: g3fwGE08kFtiMPgeWQNuDK_OqX8
Message-ID: <CAGXu5jLB9WXdaHg7ox85BftejyHUBHrUe7EpCLU08e5eRLstLQ@mail.gmail.com>
Subject: Re: [PATCH] x86/asm: improve how GEN_*_SUFFIXED_RMWcc() specify clobbers
To: Jan Beulich <JBeulich@suse.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 6:49 AM, Jan Beulich <JBeulich@suse.com> wrote:
> Commit df3405245a ("x86/asm: Add suffix macro for GEN_*_RMWcc()")
> introduced "suffix" RMWcc operations, adding bogus clobber specifiers:
> For one, on x86 there's no point explicitly clobbering "cc". In fact,

Do you have more details on this? It seems from the GCC clobbers
docs[1] that "cc" is needed for asm that changes the flags register.
Given the explicit subl and decl being used for these macros, it seems
needed to me.

> with gcc properly fixed, this results in an overlap being detected by
> the compiler between outputs and clobbers. Further more it seems bad

Do you mean the flags register is already being included as an
implicit clobber because there is an output of any kind? I can't find
documentation that says this is true. If anything it looks like it
could be "improved" from a full "cc" clobber to an output operand
flag, like =@ccs.

> practice to me to have clobber specification and use of the clobbered
> register(s) disconnected - it should rather be at the invocation place
> of that GEN_{UN,BIN}ARY_SUFFIXED_RMWcc() macros that the clobber is
> specified which this particular invocation needs.
>
> Drop the "cc" clobber altogether and move the "cx" one to refcount.h.
>
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/include/asm/refcount.h |    4 ++--
>  arch/x86/include/asm/rmwcc.h    |   16 ++++++++--------
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> --- 4.16-rc2/arch/x86/include/asm/refcount.h
> +++ 4.16-rc2-x86-rmwcc-clobbers/arch/x86/include/asm/refcount.h
> @@ -67,13 +67,13 @@ static __always_inline __must_check
>  bool refcount_sub_and_test(unsigned int i, refcount_t *r)
>  {
>         GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl", REFCOUNT_CHECK_LT_ZERO,
> -                                 r->refs.counter, "er", i, "%0", e);
> +                                 r->refs.counter, "er", i, "%0", e, "cx");
>  }
>
>  static __always_inline __must_check bool refcount_dec_and_test(refcount_t *r)
>  {
>         GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl", REFCOUNT_CHECK_LT_ZERO,
> -                                r->refs.counter, "%0", e);
> +                                r->refs.counter, "%0", e, "cx");
>  }
>
>  static __always_inline __must_check
> --- 4.16-rc2/arch/x86/include/asm/rmwcc.h
> +++ 4.16-rc2-x86-rmwcc-clobbers/arch/x86/include/asm/rmwcc.h
> @@ -2,8 +2,7 @@
>  #ifndef _ASM_X86_RMWcc
>  #define _ASM_X86_RMWcc
>
> -#define __CLOBBERS_MEM         "memory"
> -#define __CLOBBERS_MEM_CC_CX   "memory", "cc", "cx"
> +#define __CLOBBERS_MEM(clb...) "memory", ## clb

This leaves a trailing comma in the non-cx case. I thought that caused
me problems in the past, but maybe that's GCC version-specific?

>  #if !defined(__GCC_ASM_FLAG_OUTPUTS__) && defined(CC_HAVE_ASM_GOTO)
>
> @@ -40,18 +39,19 @@ do {                                                                        \
>  #endif /* defined(__GCC_ASM_FLAG_OUTPUTS__) || !defined(CC_HAVE_ASM_GOTO) */
>
>  #define GEN_UNARY_RMWcc(op, var, arg0, cc)                             \
> -       __GEN_RMWcc(op " " arg0, var, cc, __CLOBBERS_MEM)
> +       __GEN_RMWcc(op " " arg0, var, cc, __CLOBBERS_MEM())
>
> -#define GEN_UNARY_SUFFIXED_RMWcc(op, suffix, var, arg0, cc)            \
> +#define GEN_UNARY_SUFFIXED_RMWcc(op, suffix, var, arg0, cc, clobbers...)\
>         __GEN_RMWcc(op " " arg0 "\n\t" suffix, var, cc,                 \
> -                   __CLOBBERS_MEM_CC_CX)
> +                   __CLOBBERS_MEM(clobbers))
>
>  #define GEN_BINARY_RMWcc(op, var, vcon, val, arg0, cc)                 \
>         __GEN_RMWcc(op __BINARY_RMWcc_ARG arg0, var, cc,                \
> -                   __CLOBBERS_MEM, vcon (val))
> +                   __CLOBBERS_MEM(), vcon (val))
>
> -#define GEN_BINARY_SUFFIXED_RMWcc(op, suffix, var, vcon, val, arg0, cc)        \
> +#define GEN_BINARY_SUFFIXED_RMWcc(op, suffix, var, vcon, val, arg0, cc,        \
> +                                 clobbers...)                          \
>         __GEN_RMWcc(op __BINARY_RMWcc_ARG arg0 "\n\t" suffix, var, cc,  \
> -                   __CLOBBERS_MEM_CC_CX, vcon (val))
> +                   __CLOBBERS_MEM(clobbers), vcon (val))
>
>  #endif /* _ASM_X86_RMWcc */

Anyway, I'm fine to clean it up, sure, but I'd like more details on
why this doesn't break things. :)

Thanks!

-Kees

[1] https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html

-- 
Kees Cook
Pixel Security
