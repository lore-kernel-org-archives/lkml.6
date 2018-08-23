Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58486C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 00:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC46208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 00:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC46208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeHWDrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 23:47:31 -0400
Received: from smtprelay0183.hostedemail.com ([216.40.44.183]:50489 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726800AbeHWDrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 23:47:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 5954718224510;
        Thu, 23 Aug 2018 00:20:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: face35_5b5bab9fa5a49
X-Filterd-Recvd-Size: 4274
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu, 23 Aug 2018 00:20:27 +0000 (UTC)
Message-ID: <b68b8748212e74768cf457c9f41dbcf9ae887a88.camel@perches.com>
Subject: Re: [PATCH] include/linux/compiler*.h: make compiler-*.h mutually
 exclusive
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        torvalds@linux-foundation.org
Cc:     keescook@chromium.org, corbet@lwn.net,
        yamada.masahiro@socionext.com, arnd@arndb.de, dwmw@amazon.co.uk,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        will.deacon@arm.com, geert@linux-m68k.org, mingo@kernel.org,
        akpm@linux-foundation.org, asmadeus@codewreck.org,
        daniel@iogearbox.net, hpa@zytor.com
Date:   Wed, 22 Aug 2018 17:20:26 -0700
In-Reply-To: <20180822233724.110454-1-ndesaulniers@google.com>
References: <20180822233724.110454-1-ndesaulniers@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-22 at 16:37 -0700, Nick Desaulniers wrote:
> Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
> recently exposed a brittle part of the build for supporting non-gcc
> compilers.

style trivia:

> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
[]
> @@ -54,32 +54,20 @@ extern void __chk_io_ptr(const volatile void __iomem *);
[]
> +/* Compiler specific macros. */
>  #ifdef __clang__
>  #include <linux/compiler-clang.h>

probably better as

#if defined(__clang)

to match the style of the #elif defined()s below it

> +#elif defined(__INTEL_COMPILER)
> +#include <linux/compiler-intel.h>
> +#elif defined(__GNUC__)
[]
> @@ -272,4 +174,92 @@ struct ftrace_likely_data {
[]
> +#ifdef __GNUC_STDC_INLINE__
> +# define __gnu_inline	__attribute__((gnu_inline))
> +#else
> +# define __gnu_inline
> +#endif

Perhaps __gnu_inline should be in compiler-gcc and this
should use

#ifndef __gnu_inline
#define __gnu_inline
#endif
 
> +
> +/*
> + * Force always-inline if the user requests it so via the .config.
> + * GCC does not warn about unused static inline functions for
> + * -Wunused-function.  This turns out to avoid the need for complex #ifdef
> + * directives.  Suppress the warning in clang as well by using "unused"
> + * function attribute, which is redundant but not harmful for gcc.
> + * Prefer gnu_inline, so that extern inline functions do not emit an
> + * externally visible function. This makes extern inline behave as per gnu89
> + * semantics rather than c99. This prevents multiple symbol definition errors
> + * of extern inline functions at link time.
> + * A lot of inline functions can cause havoc with function tracing.
> + */
> +#if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) || \
> +	!defined(CONFIG_OPTIMIZE_INLINING)
> +#define inline \
> +	inline __attribute__((always_inline, unused)) notrace __gnu_inline
> +#else
> +#define inline inline	__attribute__((unused)) notrace __gnu_inline
> +#endif

This bit might be better adding another __<foo> attribute like:

#if defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) &&
    defined(CONFIG_OPTIMIZE_INLINING)
#define __optimized_inline __unused
#else
#define __optimized_inline __unused __attribute__((always_inline))
#endif

#define inline inline __optimized_inline notrace __gnu_inline

> +
> +#define __inline__ inline
> +#define __inline inline
> +#define noinline	__attribute__((noinline))
> +
> +#ifndef __always_inline
> +#define __always_inline inline __attribute__((always_inline))
> +#endif

[]

> diff --git a/mm/migrate.c b/mm/migrate.c
[]
> @@ -1131,7 +1131,8 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>   * gcc 4.7 and 4.8 on arm get an ICEs when inlining unmap_and_move().  Work
>   * around it.
>   */
> -#if (GCC_VERSION >= 40700 && GCC_VERSION < 40900) && defined(CONFIG_ARM)
> +#if defined(CONFIG_ARM) && \
> +	defined(GCC_VERSION) && GCC_VERSION < 40900 && GCC_VERSION >= 40700

I find the reversed version tests a bit odd to read

>  #define ICE_noinline noinline
>  #else
>  #define ICE_noinline
