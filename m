Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbeFDXYr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 19:24:47 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46211 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbeFDXYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 19:24:45 -0400
X-Google-Smtp-Source: ADUXVKLvvhdvh2Z/HUqaPcVsBzMAlGNVlgjF3y39FXOK/+iSps4T5AhnNFisZw9doM8/VDBOi0oVbQ==
Date: Mon, 04 Jun 2018 16:24:44 -0700 (PDT)
X-Google-Original-Date: Mon, 04 Jun 2018 16:20:06 PDT (-0700)
Subject: Re: [PATCHv2 01/16] atomics/treewide: s/__atomic_add_unless/atomic_fetch_add_unless/
In-Reply-To: <20180529154346.3168-2-mark.rutland@arm.com>
CC: linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        boqun.feng@gmail.com, Will Deacon <will.deacon@arm.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: mark.rutland@arm.com
Message-ID: <mhng-5a3b251f-49f3-4e9e-8aa3-d9286c9cc8e5@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2018 08:43:31 PDT (-0700), mark.rutland@arm.com wrote:
> While __atomic_add_unless was originally intended as a building-block
> for atomic_add_unless, it's now used in a number of places around the
> kernel. It's the only common atomic operation named __atomic*(), rather
> than atomic_*(), and for consistency it would be better named
> atomic_fetch_add_unless().
>
> This lack of consistency is slightly confusing, and gets in the way of
> scripting atomics. Given that, let's clean things up and promote it to
> an offical part of the atomics API, in the form of
> atomic_fetch_add_unless().
>
> This patch converts definitions and uses over to the new name, including
> the instrumented version, using the following script:
>
> ----
> git grep -w __atomic_add_unless | while read line; do
> sed -i '{s/\<__atomic_add_unless\>/atomic_fetch_add_unless/}' "${line%%:*}";
> done
> git grep -w __arch_atomic_add_unless | while read line; do
> sed -i '{s/\<__arch_atomic_add_unless\>/arch_atomic_fetch_add_unless/}' "${line%%:*}";
> done
> ----
>
> Note that we do not have atomic{64,_long}_fetch_add_unless(), which will
> be introduced by later patches.
>
> There should be no functional change as a result of this patch.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/alpha/include/asm/atomic.h           | 4 ++--
>  arch/arc/include/asm/atomic.h             | 4 ++--
>  arch/arm/include/asm/atomic.h             | 4 ++--
>  arch/arm64/include/asm/atomic.h           | 2 +-
>  arch/h8300/include/asm/atomic.h           | 2 +-
>  arch/hexagon/include/asm/atomic.h         | 4 ++--
>  arch/ia64/include/asm/atomic.h            | 2 +-
>  arch/m68k/include/asm/atomic.h            | 2 +-
>  arch/mips/include/asm/atomic.h            | 4 ++--
>  arch/openrisc/include/asm/atomic.h        | 4 ++--
>  arch/parisc/include/asm/atomic.h          | 4 ++--
>  arch/powerpc/include/asm/atomic.h         | 8 ++++----
>  arch/riscv/include/asm/atomic.h           | 4 ++--
>  arch/s390/include/asm/atomic.h            | 2 +-
>  arch/sh/include/asm/atomic.h              | 4 ++--
>  arch/sparc/include/asm/atomic_32.h        | 2 +-
>  arch/sparc/include/asm/atomic_64.h        | 2 +-
>  arch/sparc/lib/atomic32.c                 | 4 ++--
>  arch/x86/include/asm/atomic.h             | 4 ++--
>  arch/xtensa/include/asm/atomic.h          | 4 ++--
>  drivers/block/rbd.c                       | 2 +-
>  drivers/infiniband/core/rdma_core.c       | 2 +-
>  fs/afs/rxrpc.c                            | 2 +-
>  include/asm-generic/atomic-instrumented.h | 4 ++--
>  include/asm-generic/atomic.h              | 4 ++--
>  include/linux/atomic.h                    | 2 +-
>  kernel/bpf/syscall.c                      | 4 ++--
>  net/rxrpc/call_object.c                   | 2 +-
>  net/rxrpc/conn_object.c                   | 4 ++--
>  net/rxrpc/local_object.c                  | 2 +-
>  net/rxrpc/peer_object.c                   | 2 +-
>  31 files changed, 50 insertions(+), 50 deletions(-)
> [...]
> diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> index 855115ace98c..739e810c857e 100644
> --- a/arch/riscv/include/asm/atomic.h
> +++ b/arch/riscv/include/asm/atomic.h
> @@ -332,7 +332,7 @@ ATOMIC_OP(dec_and_test, dec, ==, 0, 64)
>  #undef ATOMIC_OP
>
>  /* This is required to provide a full barrier on success. */
> -static __always_inline int __atomic_add_unless(atomic_t *v, int a, int u)
> +static __always_inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
>  {
>         int prev, rc;
>
> @@ -381,7 +381,7 @@ static __always_inline int atomic64_add_unless(atomic64_t *v, long a, long u)
>   */
>  static __always_inline int atomic_inc_not_zero(atomic_t *v)
>  {
> -        return __atomic_add_unless(v, 1, 0);
> +        return atomic_fetch_add_unless(v, 1, 0);
>  }
>
>  #ifndef CONFIG_GENERIC_ATOMIC64
> diff --git a/arch/s390/include/asm/atomic.h b/arch/s390/include/asm/atomic.h
> index 4b55532f15c4..c2858cdd8c29 100644
> --- a/arch/s390/include/asm/atomic.h
> +++ b/arch/s390/include/asm/atomic.h
> @@ -90,7 +90,7 @@ static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
>  	return __atomic_cmpxchg(&v->counter, old, new);
>  }
>
> -static inline int __atomic_add_unless(atomic_t *v, int a, int u)
> +static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
>  {
>  	int c, old;
>  	c = atomic_read(v);

Acked-by: Palmer Dabbelt <palmer@sifive.com>

Thanks!
