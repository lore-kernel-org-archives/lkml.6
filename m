Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbeFDXRY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 19:17:24 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46540 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbeFDXRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 19:17:23 -0400
X-Google-Smtp-Source: ADUXVKKsGHMWXPahClwPbCi1zhHyrRSDgZkMDt4adiF2Ruz1l0CGjvYhOZTx8iMGIGNOiC9HZ5Ow3w==
Date: Mon, 04 Jun 2018 16:17:21 -0700 (PDT)
X-Google-Original-Date: Mon, 04 Jun 2018 15:43:51 PDT (-0700)
Subject: Re: [PATCHv2 11/16] atomics/riscv: define atomic64_fetch_add_unless()
In-Reply-To: <20180529154346.3168-12-mark.rutland@arm.com>
CC: linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        boqun.feng@gmail.com, Will Deacon <will.deacon@arm.com>,
        albert@sifive.com
From: Palmer Dabbelt <palmer@sifive.com>
To: mark.rutland@arm.com
Message-ID: <mhng-91e430d3-6e37-41ea-974a-520587871f4e@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2018 08:43:41 PDT (-0700), mark.rutland@arm.com wrote:
> As a step towards unifying the atomic/atomic64/atomic_long APIs, this
> patch converts the arch/riscv implementation of atomic64_add_unless()
> into an implementation of atomic64_fetch_add_unless().
>
> A wrapper in <linux/atomic.h> will build atomic_add_unless() atop of
> this, provided it is given a preprocessor definition.
>
> No functional change is intended as a result of this patch.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <albert@sifive.com>
> ---
>  arch/riscv/include/asm/atomic.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> index 5f161daefcd2..d959bbaaad41 100644
> --- a/arch/riscv/include/asm/atomic.h
> +++ b/arch/riscv/include/asm/atomic.h
> @@ -352,7 +352,7 @@ static __always_inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
>  #define atomic_fetch_add_unless atomic_fetch_add_unless
>
>  #ifndef CONFIG_GENERIC_ATOMIC64
> -static __always_inline long __atomic64_add_unless(atomic64_t *v, long a, long u)
> +static __always_inline long atomic64_fetch_add_unless(atomic64_t *v, long a, long u)
>  {
>         long prev, rc;
>
> @@ -369,11 +369,7 @@ static __always_inline long __atomic64_add_unless(atomic64_t *v, long a, long u)
>  		: "memory");
>  	return prev;
>  }
> -
> -static __always_inline int atomic64_add_unless(atomic64_t *v, long a, long u)
> -{
> -	return __atomic64_add_unless(v, a, u) != u;
> -}
> +#define atomic64_fetch_add_unless atomic64_fetch_add_unless
>  #endif
>
>  /*

For some reason I remember there being a reason we were doing this in such an 
odd fashion but I can't remember what it was any more.  Assuming this still 
builds, feel free to add an

Acked-by Palmer Dabbelt <palmer@sifive.com>

Thanks!
