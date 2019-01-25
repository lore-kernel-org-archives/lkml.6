Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56810C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19EEA21915
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfAYI10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:27:26 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:37452 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfAYI10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:27:26 -0500
Received: by mail-ua1-f68.google.com with SMTP id u19so2974933uae.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 00:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BXKJptZMSBfv+PGSeg6Oj9y3mwSyQnNFAD2m1M6ZCTU=;
        b=MsuYX4IbjusL13xXwJi5l6tIgxhKTEmPiyPubVd9wZ50tFRkIZRfcYAiGQ3d0wMz1+
         n7cJTyCbywNyR60oqKoATzBsEWyfaMG2GkKeTW0JbtvbT4F9oanob7E8BINDHOpdzTYA
         36aiewyaTwyM44UOs0qClHwuhyLz4n6a65Fjo4OLMEnQd+iG0gEINHjCyqQIDvPOWEG0
         oVxJA7TSXUdPRRsLPfAd5ZN3chsFzfGrlh2pimU7Lp7M90pwg6du0VXyJEQbzCMC6Q0S
         gTA7HXTg2KdHMd9mxIM1fEdZdBmN13VRAezRPYm+EDIxp1ubdjm/P9EZ0Jzm0xwWiPaL
         m/JQ==
X-Gm-Message-State: AJcUukfqq39zbNJRR3EPHr/fjaQ4N7zBvqLsvaKDZc0bO4ZGAUVw2XyH
        vI9+z4clssR70mKBB1yHVdsQFMbEo5SOTYNscQM=
X-Google-Smtp-Source: ALg8bN64Qa8pyPkpLQX1oVA+o+Sz/IhUxI7aI9siOX/97AVlE+xI2enn49vixTmJfTKCC3QuQgdlGfClPz6XsGWbZ9g=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr4169400ual.20.1548404844158;
 Fri, 25 Jan 2019 00:27:24 -0800 (PST)
MIME-Version: 1.0
References: <20190125025747.1853-1-jcmvbkbc@gmail.com>
In-Reply-To: <20190125025747.1853-1-jcmvbkbc@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 25 Jan 2019 09:27:12 +0100
Message-ID: <CAMuHMdV-HiZt9PP6LyF8c=7ARNbMX3bJH6r6Ru7koBxEu+9ZSw@mail.gmail.com>
Subject: Re: [PATCH] treewide: get rid of HAVE_FUTEX_CMPXCHG
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On Fri, Jan 25, 2019 at 3:58 AM Max Filippov <jcmvbkbc@gmail.com> wrote:
> CONFIG_HAVE_FUTEX_CMPXCHG is currently used to determine if
> atomic_inatomic is always working or must be probed. For most
> architectures it is either selected, or it is known that they always
> have futex_atomic_cmpxchg_inatomic working.
>
> Drop HAVE_FUTEX_CMPXCHG from the Kconfig and let architectures that may
> not have it working define macro arch_have_futex_cmpxchg that probes
> whether futex_atomic_cmpxchg_inatomic is working, otherwise assume that
> it is working.
>
> Implement arch_have_futex_cmpxchg for MIPS, Xtensa and for the users of
> asm-generic/futex.h.
>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

Thanks for your patch!

> ---
>  arch/arc/Kconfig                |  1 -
>  arch/m68k/Kconfig               |  1 -
>  arch/mips/include/asm/futex.h   |  2 ++
>  arch/riscv/Kconfig              |  1 -
>  arch/s390/Kconfig               |  1 -
>  arch/sh/Kconfig                 |  1 -
>  arch/um/Kconfig                 |  1 -
>  arch/xtensa/Kconfig             |  1 -
>  arch/xtensa/include/asm/futex.h |  4 ++++
>  include/asm-generic/futex.h     |  2 ++
>  init/Kconfig                    |  8 --------
>  kernel/futex.c                  | 30 ++++++++----------------------
>  12 files changed, 16 insertions(+), 37 deletions(-)
>
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index 376366a7db81..01932be9f7e3 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -29,7 +29,6 @@ config ARC
>         select HAVE_ARCH_KGDB
>         select HAVE_ARCH_TRACEHOOK
>         select HAVE_DEBUG_STACKOVERFLOW
> -       select HAVE_FUTEX_CMPXCHG if FUTEX
>         select HAVE_GENERIC_DMA_COHERENT
>         select HAVE_IOREMAP_PROT
>         select HAVE_KERNEL_GZIP
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index e173ea2ff395..09499af5d22a 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -20,7 +20,6 @@ config M68K
>         select GENERIC_STRNLEN_USER if MMU
>         select ARCH_WANT_IPC_PARSE_VERSION
>         select ARCH_USES_GETTIMEOFFSET if MMU && !COLDFIRE
> -       select HAVE_FUTEX_CMPXCHG if MMU && FUTEX

I guess it didn't really matter for !MMU?

>         select HAVE_MOD_ARCH_SPECIFIC
>         select MODULES_USE_ELF_REL
>         select MODULES_USE_ELF_RELA
> diff --git a/arch/mips/include/asm/futex.h b/arch/mips/include/asm/futex.h
> index c14d798f3888..f61221d080fc 100644
> --- a/arch/mips/include/asm/futex.h
> +++ b/arch/mips/include/asm/futex.h
> @@ -122,6 +122,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
>         return ret;
>  }
>
> +#define arch_have_futex_cmpxchg() (cpu_has_llsc)
> +
>  static inline int
>  futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>                               u32 oldval, u32 newval)
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index feeeaa60697c..074966cdd41d 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -31,7 +31,6 @@ config RISCV
>         select HAVE_ARCH_AUDITSYSCALL
>         select HAVE_MEMBLOCK_NODE_MAP
>         select HAVE_DMA_CONTIGUOUS
> -       select HAVE_FUTEX_CMPXCHG if FUTEX
>         select HAVE_GENERIC_DMA_COHERENT
>         select HAVE_PERF_EVENTS
>         select HAVE_SYSCALL_TRACEPOINTS
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index ed554b09eb3f..6f3819275d08 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -146,7 +146,6 @@ config S390
>         select HAVE_FTRACE_MCOUNT_RECORD
>         select HAVE_FUNCTION_GRAPH_TRACER
>         select HAVE_FUNCTION_TRACER
> -       select HAVE_FUTEX_CMPXCHG if FUTEX
>         select HAVE_GCC_PLUGINS
>         select HAVE_KERNEL_BZIP2
>         select HAVE_KERNEL_GZIP
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index a9c36f95744a..a04bc11c8819 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -50,7 +50,6 @@ config SUPERH
>         select OLD_SIGACTION
>         select PCI_DOMAINS if PCI
>         select HAVE_ARCH_AUDITSYSCALL
> -       select HAVE_FUTEX_CMPXCHG if FUTEX
>         select HAVE_NMI
>         select NEED_SG_DMA_LENGTH
>
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index ec9711d068b7..38c5ce3b64b1 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -10,7 +10,6 @@ config UML
>         select HAVE_ARCH_AUDITSYSCALL
>         select HAVE_ARCH_SECCOMP_FILTER
>         select HAVE_UID16
> -       select HAVE_FUTEX_CMPXCHG if FUTEX
>         select HAVE_DEBUG_KMEMLEAK
>         select HAVE_DEBUG_BUGVERBOSE
>         select GENERIC_IRQ_SHOW
> diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
> index 7021d1e15909..a4d34de57809 100644
> --- a/arch/xtensa/Kconfig
> +++ b/arch/xtensa/Kconfig
> @@ -25,7 +25,6 @@ config XTENSA
>         select HAVE_DMA_CONTIGUOUS
>         select HAVE_EXIT_THREAD
>         select HAVE_FUNCTION_TRACER
> -       select HAVE_FUTEX_CMPXCHG if !MMU
>         select HAVE_HW_BREAKPOINT if PERF_EVENTS
>         select HAVE_IRQ_TIME_ACCOUNTING
>         select HAVE_OPROFILE
> diff --git a/arch/xtensa/include/asm/futex.h b/arch/xtensa/include/asm/futex.h
> index 505d09eff184..ac88d64f94e4 100644
> --- a/arch/xtensa/include/asm/futex.h
> +++ b/arch/xtensa/include/asm/futex.h
> @@ -87,6 +87,10 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
>         return ret;
>  }
>
> +#if !XCHAL_HAVE_S32C1I
> +#define arch_have_futex_cmpxchg() (0)
> +#endif
> +
>  static inline int
>  futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>                               u32 oldval, u32 newval)
> diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
> index fcb61b4659b3..deefe5b22b9b 100644
> --- a/include/asm-generic/futex.h
> +++ b/include/asm-generic/futex.h
> @@ -136,6 +136,8 @@ arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
>         return ret;
>  }
>
> +#define arch_have_futex_cmpxchg() (0)

This is for the SMP=y case only, right?

> +
>  static inline int
>  futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>                               u32 oldval, u32 newval)
> diff --git a/init/Kconfig b/init/Kconfig
> index 513fa544a134..351f4c93f932 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1338,14 +1338,6 @@ config FUTEX_PI
>         depends on FUTEX && RT_MUTEXES
>         default y
>
> -config HAVE_FUTEX_CMPXCHG
> -       bool
> -       depends on FUTEX
> -       help
> -         Architectures should select this if futex_atomic_cmpxchg_inatomic()
> -         is implemented and always working. This removes a couple of runtime
> -         checks.
> -
>  config EPOLL
>         bool "Enable eventpoll support" if EXPERT
>         default y
> diff --git a/kernel/futex.c b/kernel/futex.c
> index be3bff2315ff..5697c1f2254d 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -174,7 +174,11 @@
>   * double_lock_hb() and double_unlock_hb(), respectively.
>   */
>
> -#ifdef CONFIG_HAVE_FUTEX_CMPXCHG
> +/*
> + * Architectures should define this macro if futex_atomic_cmpxchg_inatomic()
> + * may not be always working.
> + */
> +#ifdef arch_have_futex_cmpxchg

Shouldn't this be #ifndef now...

>  #define futex_cmpxchg_enabled 1
>  #else
>  static int  __read_mostly futex_cmpxchg_enabled;
> @@ -3842,26 +3846,6 @@ COMPAT_SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
>  }
>  #endif /* CONFIG_COMPAT_32BIT_TIME */
>
> -static void __init futex_detect_cmpxchg(void)
> -{
> -#ifndef CONFIG_HAVE_FUTEX_CMPXCHG
> -       u32 curval;
> -
> -       /*
> -        * This will fail and we want it. Some arch implementations do
> -        * runtime detection of the futex_atomic_cmpxchg_inatomic()
> -        * functionality. We want to know that before we call in any
> -        * of the complex code paths. Also we want to prevent
> -        * registration of robust lists in that case. NULL is
> -        * guaranteed to fault and we get -EFAULT on functional
> -        * implementation, the non-functional ones will return
> -        * -ENOSYS.
> -        */
> -       if (cmpxchg_futex_value_locked(&curval, NULL, 0, 0) == -EFAULT)
> -               futex_cmpxchg_enabled = 1;
> -#endif
> -}
> -
>  static int __init futex_init(void)
>  {
>         unsigned int futex_shift;
> @@ -3880,7 +3864,9 @@ static int __init futex_init(void)
>                                                futex_hashsize, futex_hashsize);
>         futex_hashsize = 1UL << futex_shift;
>
> -       futex_detect_cmpxchg();
> +#ifdef arch_have_futex_cmpxchg
> +       futex_cmpxchg_enabled = arch_have_futex_cmpxchg();

... else you're assigning to the constant:

    error: lvalue required as left operand of assignment

> +#endif
>
>         for (i = 0; i < futex_hashsize; i++) {
>                 atomic_set(&futex_queues[i].waiters, 0);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
