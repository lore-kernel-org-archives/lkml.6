Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751566AbeB0SVq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 13:21:46 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45708 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbeB0SVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 13:21:44 -0500
X-Google-Smtp-Source: AH8x226mmz/8EPVsvAB4CD/AioZ85cZw2u889W5YMaGbzaQGsyPv9bcbga8kxYvpzz/bNC8jlJAQrQ==
Date: Tue, 27 Feb 2018 10:21:43 -0800 (PST)
X-Google-Original-Date: Tue, 27 Feb 2018 08:53:31 PST (-0800)
Subject: Re: [PATCH] riscv/barrier: Define __smp_{store_release,load_acquire}
In-Reply-To: <1519698251-19272-1-git-send-email-parri.andrea@gmail.com>
CC: albert@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, parri.andrea@gmail.com
From: Palmer Dabbelt <palmer@sifive.com>
To: parri.andrea@gmail.com, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <mhng-d0fc25e5-9a3f-4988-9260-3d584b8f4606@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2018 18:24:11 PST (-0800), parri.andrea@gmail.com wrote:
> Introduce __smp_{store_release,load_acquire}, and rely on the generic
> definitions for smp_{store_release,load_acquire}. This avoids the use
> of full ("rw,rw") fences on SMP.
>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
>  arch/riscv/include/asm/barrier.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
> index 5510366d169ae..d4628e4b3a5ea 100644
> --- a/arch/riscv/include/asm/barrier.h
> +++ b/arch/riscv/include/asm/barrier.h
> @@ -38,6 +38,21 @@
>  #define __smp_rmb()	RISCV_FENCE(r,r)
>  #define __smp_wmb()	RISCV_FENCE(w,w)
>
> +#define __smp_store_release(p, v)					\
> +do {									\
> +	compiletime_assert_atomic_type(*p);				\
> +	RISCV_FENCE(rw,w);						\
> +	WRITE_ONCE(*p, v);						\
> +} while (0)
> +
> +#define __smp_load_acquire(p)						\
> +({									\
> +	typeof(*p) ___p1 = READ_ONCE(*p);				\
> +	compiletime_assert_atomic_type(*p);				\
> +	RISCV_FENCE(r,rw);						\
> +	___p1;								\
> +})
> +
>  /*
>   * This is a very specific barrier: it's currently only used in two places in
>   * the kernel, both in the scheduler.  See include/linux/spinlock.h for the two

I'm adding Daniel just in case I misunderstood what's going on here, but these 
look good to me.  As this is a non-trivial memory model change I'm going to let 
it bake in linux-next for a bit just so it gets some visibility.

Thanks!
