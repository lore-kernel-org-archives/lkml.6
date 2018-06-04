Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeFDXY7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 19:24:59 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36931 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbeFDXYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 19:24:49 -0400
X-Google-Smtp-Source: ADUXVKJ6hQDJt5IBd7MbWmPeJC8jtsVG3xYUX5Po9pqbpzBytsr6niLb4Rz8WfMxwrH4edE7b8x2sw==
Date: Mon, 04 Jun 2018 16:24:47 -0700 (PDT)
X-Google-Original-Date: Mon, 04 Jun 2018 16:21:55 PDT (-0700)
Subject: Re: [PATCHv2 04/16] atomics/treewide: make atomic_fetch_add_unless() optional
In-Reply-To: <20180529154346.3168-5-mark.rutland@arm.com>
CC: linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        boqun.feng@gmail.com, Will Deacon <will.deacon@arm.com>,
        vgupta@synopsys.com
From: Palmer Dabbelt <palmer@sifive.com>
To: mark.rutland@arm.com
Message-ID: <mhng-20f0f4d8-bc31-410d-950b-d3ae00d7a2ee@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2018 08:43:34 PDT (-0700), mark.rutland@arm.com wrote:
> Several architectures these have a near-identical implementation based
> on atomic_read() and atomic_cmpxchg() that we can instead define in
> <linux/atomic.h>, so let's do so, using something close to the existing
> x86 implementation with try_cmpxchg().
>
> Where an architecture provides its own atomic_fetch_add_unless(), it
> must define a preprocessor symbol for it. The instrumented atomics are
> updated accordingly.
>
> Note that arch/arc's existing atomic_fetch_add_unless() had redundant
> barriers, as these are already present in its atomic_cmpxchg()
> implementation.
>
> There should be no functional change as a result of this patch.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> ---
>  arch/alpha/include/asm/atomic.h           |  2 +-
>  arch/arc/include/asm/atomic.h             | 28 ----------------------------
>  arch/arm/include/asm/atomic.h             | 11 +----------
>  arch/arm64/include/asm/atomic.h           |  1 -
>  arch/h8300/include/asm/atomic.h           |  1 +
>  arch/hexagon/include/asm/atomic.h         |  1 +
>  arch/ia64/include/asm/atomic.h            | 16 ----------------
>  arch/m68k/include/asm/atomic.h            | 15 ---------------
>  arch/mips/include/asm/atomic.h            | 24 ------------------------
>  arch/parisc/include/asm/atomic.h          | 24 ------------------------
>  arch/powerpc/include/asm/atomic.h         |  1 +
>  arch/riscv/include/asm/atomic.h           |  1 +
>  arch/s390/include/asm/atomic.h            | 15 ---------------
>  arch/sh/include/asm/atomic.h              | 25 -------------------------
>  arch/sparc/include/asm/atomic_32.h        |  2 ++
>  arch/sparc/include/asm/atomic_64.h        | 15 ---------------
>  arch/x86/include/asm/atomic.h             | 21 ---------------------
>  arch/xtensa/include/asm/atomic.h          | 24 ------------------------
>  include/asm-generic/atomic-instrumented.h |  4 +++-
>  include/asm-generic/atomic.h              | 11 -----------
>  include/linux/atomic.h                    | 23 +++++++++++++++++++++++
>  21 files changed, 34 insertions(+), 231 deletions(-)
> [...]
> diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> index 18259e90f57e..5f161daefcd2 100644
> --- a/arch/riscv/include/asm/atomic.h
> +++ b/arch/riscv/include/asm/atomic.h
> @@ -349,6 +349,7 @@ static __always_inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
>  		: "memory");
>  	return prev;
>  }
> +#define atomic_fetch_add_unless atomic_fetch_add_unless
>
>  #ifndef CONFIG_GENERIC_ATOMIC64
>  static __always_inline long __atomic64_add_unless(atomic64_t *v, long a, long u)

Acked-by: Palmer Dabbelt <palmer@sifive.com>

Thanks!
