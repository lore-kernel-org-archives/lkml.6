Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752114AbeFDXR2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 19:17:28 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44969 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeFDXRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 19:17:25 -0400
X-Google-Smtp-Source: ADUXVKKkVpSegZXotucdey9OxEeYKrrPfmUPfx/4obQNxL6ve2SIh+vWG1jOaQxSuC9w9Z1QnmORAw==
Date: Mon, 04 Jun 2018 16:17:24 -0700 (PDT)
X-Google-Original-Date: Mon, 04 Jun 2018 15:52:12 PDT (-0700)
Subject: Re: [PATCHv2 13/16] atomics/treewide: make test ops optional
In-Reply-To: <20180529154346.3168-14-mark.rutland@arm.com>
CC: linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        boqun.feng@gmail.com, Will Deacon <will.deacon@arm.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: mark.rutland@arm.com
Message-ID: <mhng-3c9ac6b6-a8eb-45e4-b763-90698c95059b@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2018 08:43:43 PDT (-0700), mark.rutland@arm.com wrote:
> Some of the atomics return the result of a test applied after the atomic
> operation, and almost all architectures implement these as trivial
> wrappers around the underlying atomic. Specifically:
>
> * <atomic>_inc_and_test(v) is (<atomic>_inc_return(v) == 0)
>
> * <atomic>_dec_and_test(v) is (<atomic>_dec_return(v) == 0)
>
> * <atomic>_sub_and_test(i, v) is (<atomic>_sub_return(i, v) == 0)
>
> * <atomic>_add_negative(i, v) is (<atomic>_add_return(i, v) < 0)
>
> Rather than have these definitions duplicated in all architectures, with
> minor inconsistencies in formatting and documentation, let's make these
> operations optional, with default fallbacks as above. Implementations
> must now provide a preprocessor symbol.
>
> The instrumented atomics are updated accordingly.
>
> Both x86 and m68k have custom implementations, which are left as-is,
> given preprocessor symbols to avoid being overridden.
>
> There should be no functional change as a result of this patch.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/alpha/include/asm/atomic.h           |  12 ---
>  arch/arc/include/asm/atomic.h             |  10 ---
>  arch/arm/include/asm/atomic.h             |   9 ---
>  arch/arm64/include/asm/atomic.h           |   8 --
>  arch/h8300/include/asm/atomic.h           |   5 --
>  arch/hexagon/include/asm/atomic.h         |   5 --
>  arch/ia64/include/asm/atomic.h            |  23 ------
>  arch/m68k/include/asm/atomic.h            |   4 +
>  arch/mips/include/asm/atomic.h            |  84 --------------------
>  arch/parisc/include/asm/atomic.h          |  22 ------
>  arch/powerpc/include/asm/atomic.h         |  30 --------
>  arch/riscv/include/asm/atomic.h           |  46 -----------
>  arch/s390/include/asm/atomic.h            |   8 --
>  arch/sh/include/asm/atomic.h              |   4 -
>  arch/sparc/include/asm/atomic_32.h        |  15 ----
>  arch/sparc/include/asm/atomic_64.h        |  20 -----
>  arch/x86/include/asm/atomic.h             |   4 +
>  arch/x86/include/asm/atomic64_32.h        |  54 -------------
>  arch/x86/include/asm/atomic64_64.h        |   4 +
>  arch/xtensa/include/asm/atomic.h          |  42 ----------
>  include/asm-generic/atomic-instrumented.h |  24 ++++++
>  include/asm-generic/atomic.h              |   9 ---
>  include/asm-generic/atomic64.h            |   4 -
>  include/linux/atomic.h                    | 124 ++++++++++++++++++++++++++++++
>  24 files changed, 160 insertions(+), 410 deletions(-)
> [...]
> diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> index d959bbaaad41..68eef0a805ca 100644
> --- a/arch/riscv/include/asm/atomic.h
> +++ b/arch/riscv/include/asm/atomic.h
> @@ -209,36 +209,6 @@ ATOMIC_OPS(xor, xor, i)
>  #undef ATOMIC_FETCH_OP
>  #undef ATOMIC_OP_RETURN
>
> -/*
> - * The extra atomic operations that are constructed from one of the core
> - * AMO-based operations above (aside from sub, which is easier to fit above).
> - * These are required to perform a full barrier, but they're OK this way
> - * because atomic_*_return is also required to perform a full barrier.
> - *
> - */
> -#define ATOMIC_OP(op, func_op, comp_op, I, c_type, prefix)		\
> -static __always_inline							\
> -bool atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)		\
> -{									\
> -	return atomic##prefix##_##func_op##_return(i, v) comp_op I;	\
> -}
> -
> -#ifdef CONFIG_GENERIC_ATOMIC64
> -#define ATOMIC_OPS(op, func_op, comp_op, I)				\
> -        ATOMIC_OP(op, func_op, comp_op, I,  int,   )
> -#else
> -#define ATOMIC_OPS(op, func_op, comp_op, I)				\
> -        ATOMIC_OP(op, func_op, comp_op, I,  int,   )			\
> -        ATOMIC_OP(op, func_op, comp_op, I, long, 64)
> -#endif
> -
> -ATOMIC_OPS(add_and_test, add, ==, 0)
> -ATOMIC_OPS(sub_and_test, sub, ==, 0)
> -ATOMIC_OPS(add_negative, add,  <, 0)
> -
> -#undef ATOMIC_OP
> -#undef ATOMIC_OPS
> -
>  #define ATOMIC_OP(op, func_op, I, c_type, prefix)			\
>  static __always_inline							\
>  void atomic##prefix##_##op(atomic##prefix##_t *v)			\
> @@ -315,22 +285,6 @@ ATOMIC_OPS(dec, add, +, -1)
>  #undef ATOMIC_FETCH_OP
>  #undef ATOMIC_OP_RETURN
>
> -#define ATOMIC_OP(op, func_op, comp_op, I, prefix)			\
> -static __always_inline							\
> -bool atomic##prefix##_##op(atomic##prefix##_t *v)			\
> -{									\
> -	return atomic##prefix##_##func_op##_return(v) comp_op I;	\
> -}
> -
> -ATOMIC_OP(inc_and_test, inc, ==, 0,   )
> -ATOMIC_OP(dec_and_test, dec, ==, 0,   )
> -#ifndef CONFIG_GENERIC_ATOMIC64
> -ATOMIC_OP(inc_and_test, inc, ==, 0, 64)
> -ATOMIC_OP(dec_and_test, dec, ==, 0, 64)
> -#endif
> -
> -#undef ATOMIC_OP
> -
>  /* This is required to provide a full barrier on success. */
>  static __always_inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
>  {

Acked-by: Palmer Dabbelt <palmer@sifive.com>
