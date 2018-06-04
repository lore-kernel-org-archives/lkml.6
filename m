Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeFDXSB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 19:18:01 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42410 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751998AbeFDXRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 19:17:24 -0400
X-Google-Smtp-Source: ADUXVKK4YVJ5nlXqAbaixtdWS7BQm5YH4JkRhTnrmMP35f/LF7fEWHM4oiYmQmigj3khpWMrTaScZw==
Date: Mon, 04 Jun 2018 16:17:22 -0700 (PDT)
X-Google-Original-Date: Mon, 04 Jun 2018 15:50:06 PDT (-0700)
Subject: Re: [PATCHv2 15/16] atomics/treewide: make unconditional inc/dec ops optional
In-Reply-To: <20180529154346.3168-16-mark.rutland@arm.com>
CC: linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        boqun.feng@gmail.com, peterz@infradead.org,
        Will Deacon <will.deacon@arm.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: mark.rutland@arm.com
Message-ID: <mhng-eab5effb-66ad-4609-b380-c4b0a35c1dd0@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2018 08:43:45 PDT (-0700), mark.rutland@arm.com wrote:
> Many of the inc/dec ops are mandatory, but for most architectures inc/dec are
> simply trivial wrappers around their corresponding add/sub ops.
>
> Let's make all the inc/dec ops optional, so that we can get rid of these
> boilerplate wrappers.
>
> The instrumented atomics are updated accordingly.
>
> There should be no functional change as a result of this patch.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/alpha/include/asm/atomic.h           | 12 -----
>  arch/arc/include/asm/atomic.h             | 11 -----
>  arch/arm/include/asm/atomic.h             | 11 -----
>  arch/arm64/include/asm/atomic.h           | 24 ----------
>  arch/h8300/include/asm/atomic.h           |  7 ---
>  arch/hexagon/include/asm/atomic.h         |  6 ---
>  arch/ia64/include/asm/atomic.h            |  9 ----
>  arch/m68k/include/asm/atomic.h            |  5 +-
>  arch/mips/include/asm/atomic.h            | 38 ----------------
>  arch/parisc/include/asm/atomic.h          | 12 -----
>  arch/powerpc/include/asm/atomic.h         |  4 ++
>  arch/riscv/include/asm/atomic.h           | 76 -------------------------------
>  arch/s390/include/asm/atomic.h            |  8 ----
>  arch/sh/include/asm/atomic.h              |  6 ---
>  arch/sparc/include/asm/atomic_32.h        |  5 --
>  arch/sparc/include/asm/atomic_64.h        | 12 -----
>  arch/x86/include/asm/atomic.h             |  5 +-
>  arch/x86/include/asm/atomic64_32.h        |  4 ++
>  arch/x86/include/asm/atomic64_64.h        |  5 +-
>  arch/xtensa/include/asm/atomic.h          | 32 -------------
>  include/asm-generic/atomic-instrumented.h | 24 ++++++++++
>  include/asm-generic/atomic.h              | 13 ------
>  include/asm-generic/atomic64.h            |  5 --
>  include/linux/atomic.h                    | 48 +++++++++++++++++++
>  24 files changed, 86 insertions(+), 296 deletions(-)
> [...]
> diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> index 68eef0a805ca..512b89485790 100644
> --- a/arch/riscv/include/asm/atomic.h
> +++ b/arch/riscv/include/asm/atomic.h
> @@ -209,82 +209,6 @@ ATOMIC_OPS(xor, xor, i)
>  #undef ATOMIC_FETCH_OP
>  #undef ATOMIC_OP_RETURN
>
> -#define ATOMIC_OP(op, func_op, I, c_type, prefix)			\
> -static __always_inline							\
> -void atomic##prefix##_##op(atomic##prefix##_t *v)			\
> -{									\
> -	atomic##prefix##_##func_op(I, v);				\
> -}
> -
> -#define ATOMIC_FETCH_OP(op, func_op, I, c_type, prefix)			\
> -static __always_inline							\
> -c_type atomic##prefix##_fetch_##op##_relaxed(atomic##prefix##_t *v)	\
> -{									\
> -	return atomic##prefix##_fetch_##func_op##_relaxed(I, v);	\
> -}									\
> -static __always_inline							\
> -c_type atomic##prefix##_fetch_##op(atomic##prefix##_t *v)		\
> -{									\
> -	return atomic##prefix##_fetch_##func_op(I, v);			\
> -}
> -
> -#define ATOMIC_OP_RETURN(op, asm_op, c_op, I, c_type, prefix)		\
> -static __always_inline							\
> -c_type atomic##prefix##_##op##_return_relaxed(atomic##prefix##_t *v)	\
> -{									\
> -        return atomic##prefix##_fetch_##op##_relaxed(v) c_op I;		\
> -}									\
> -static __always_inline							\
> -c_type atomic##prefix##_##op##_return(atomic##prefix##_t *v)		\
> -{									\
> -        return atomic##prefix##_fetch_##op(v) c_op I;			\
> -}
> -
> -#ifdef CONFIG_GENERIC_ATOMIC64
> -#define ATOMIC_OPS(op, asm_op, c_op, I)					\
> -        ATOMIC_OP(       op, asm_op,       I,  int,   )			\
> -        ATOMIC_FETCH_OP( op, asm_op,       I,  int,   )			\
> -        ATOMIC_OP_RETURN(op, asm_op, c_op, I,  int,   )
> -#else
> -#define ATOMIC_OPS(op, asm_op, c_op, I)					\
> -        ATOMIC_OP(       op, asm_op,       I,  int,   )			\
> -        ATOMIC_FETCH_OP( op, asm_op,       I,  int,   )			\
> -        ATOMIC_OP_RETURN(op, asm_op, c_op, I,  int,   )			\
> -        ATOMIC_OP(       op, asm_op,       I, long, 64)			\
> -        ATOMIC_FETCH_OP( op, asm_op,       I, long, 64)			\
> -        ATOMIC_OP_RETURN(op, asm_op, c_op, I, long, 64)
> -#endif
> -
> -ATOMIC_OPS(inc, add, +,  1)
> -ATOMIC_OPS(dec, add, +, -1)
> -
> -#define atomic_inc_return_relaxed	atomic_inc_return_relaxed
> -#define atomic_dec_return_relaxed	atomic_dec_return_relaxed
> -#define atomic_inc_return		atomic_inc_return
> -#define atomic_dec_return		atomic_dec_return
> -
> -#define atomic_fetch_inc_relaxed	atomic_fetch_inc_relaxed
> -#define atomic_fetch_dec_relaxed	atomic_fetch_dec_relaxed
> -#define atomic_fetch_inc		atomic_fetch_inc
> -#define atomic_fetch_dec		atomic_fetch_dec
> -
> -#ifndef CONFIG_GENERIC_ATOMIC64
> -#define atomic64_inc_return_relaxed	atomic64_inc_return_relaxed
> -#define atomic64_dec_return_relaxed	atomic64_dec_return_relaxed
> -#define atomic64_inc_return		atomic64_inc_return
> -#define atomic64_dec_return		atomic64_dec_return
> -
> -#define atomic64_fetch_inc_relaxed	atomic64_fetch_inc_relaxed
> -#define atomic64_fetch_dec_relaxed	atomic64_fetch_dec_relaxed
> -#define atomic64_fetch_inc		atomic64_fetch_inc
> -#define atomic64_fetch_dec		atomic64_fetch_dec
> -#endif
> -
> -#undef ATOMIC_OPS
> -#undef ATOMIC_OP
> -#undef ATOMIC_FETCH_OP
> -#undef ATOMIC_OP_RETURN
> -
>  /* This is required to provide a full barrier on success. */
>  static __always_inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
>  {

As far as the RISC-V stuff goes: this works for me, as I always like to have 
less code in the arch port.

Acked-by: Palmer Dabbelt <palmer@sifive.com>

Thanks!
