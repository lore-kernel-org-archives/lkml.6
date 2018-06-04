Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeFDXRr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 19:17:47 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33448 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752055AbeFDXR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 19:17:26 -0400
X-Google-Smtp-Source: ADUXVKLqz4jqYGQ/VmkjPtR+D+knMmBoUyWMqpneIxDpFnnJno6TXrvXbUKPMyYhCEatP7nRNZKTPw==
Date: Mon, 04 Jun 2018 16:17:25 -0700 (PDT)
X-Google-Original-Date: Mon, 04 Jun 2018 15:53:36 PDT (-0700)
Subject: Re: [PATCHv2 03/16] atomics/treewide: make atomic64_inc_not_zero() optional
In-Reply-To: <20180529154346.3168-4-mark.rutland@arm.com>
CC: linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        boqun.feng@gmail.com, Will Deacon <will.deacon@arm.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: mark.rutland@arm.com
Message-ID: <mhng-bc7520a5-9be6-4f9f-b3f1-3a44d7da233e@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2018 08:43:33 PDT (-0700), mark.rutland@arm.com wrote:
> We define a trivial fallback for atomic_inc_not_zero(), but don't do
> the same for atmic64_inc_not_zero(), leading most architectures to
> define the same boilerplate.

atmic64

> Let's add a fallback in <linux/atomic.h>, and remove the redundant
> implementations. Note that atomic64_add_unless() is always defined in
> <linux/atomic.h>, and promotes its arguments to the requisite types, so
> we need not do this explicitly.
>
> There should be no functional change as a result of this patch.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/alpha/include/asm/atomic.h           |  2 --
>  arch/arc/include/asm/atomic.h             |  1 -
>  arch/arm/include/asm/atomic.h             |  1 -
>  arch/arm64/include/asm/atomic.h           |  2 --
>  arch/ia64/include/asm/atomic.h            |  2 --
>  arch/mips/include/asm/atomic.h            |  2 --
>  arch/parisc/include/asm/atomic.h          |  2 --
>  arch/powerpc/include/asm/atomic.h         |  1 +
>  arch/riscv/include/asm/atomic.h           |  7 -------
>  arch/s390/include/asm/atomic.h            |  1 -
>  arch/sparc/include/asm/atomic_64.h        |  2 --
>  arch/x86/include/asm/atomic64_32.h        |  2 +-
>  arch/x86/include/asm/atomic64_64.h        |  2 --
>  include/asm-generic/atomic-instrumented.h |  3 +++
>  include/asm-generic/atomic64.h            |  1 -
>  include/linux/atomic.h                    | 11 +++++++++++
>  16 files changed, 16 insertions(+), 26 deletions(-)
> [...]
> diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> index 0e27e050ba14..18259e90f57e 100644
> --- a/arch/riscv/include/asm/atomic.h
> +++ b/arch/riscv/include/asm/atomic.h
> @@ -375,13 +375,6 @@ static __always_inline int atomic64_add_unless(atomic64_t *v, long a, long u)
>  }
>  #endif
>
> -#ifndef CONFIG_GENERIC_ATOMIC64
> -static __always_inline long atomic64_inc_not_zero(atomic64_t *v)
> -{
> -        return atomic64_add_unless(v, 1, 0);
> -}
> -#endif
> -
>  /*
>   * atomic_{cmp,}xchg is required to have exactly the same ordering semantics as
>   * {cmp,}xchg and the operations that return, so they need a full barrier.

Acked-by: Palmer Dabbelt <palmer@sifive.com>

Thanks!
