Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204C9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 00:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADF3208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 00:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADF3208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeHWDwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 23:52:25 -0400
Received: from nautica.notk.org ([91.121.71.147]:51823 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbeHWDwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 23:52:25 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 39CBDC009; Thu, 23 Aug 2018 02:25:23 +0200 (CEST)
Date:   Thu, 23 Aug 2018 02:25:08 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     torvalds@linux-foundation.org, keescook@chromium.org,
        joe@perches.com, corbet@lwn.net, yamada.masahiro@socionext.com,
        arnd@arndb.de, dwmw@amazon.co.uk, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, will.deacon@arm.com, geert@linux-m68k.org,
        mingo@kernel.org, akpm@linux-foundation.org, daniel@iogearbox.net,
        hpa@zytor.com
Subject: Re: [PATCH] include/linux/compiler*.h: make compiler-*.h mutually
 exclusive
Message-ID: <20180823002508.GA822@nautica>
References: <20180822233724.110454-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180822233724.110454-1-ndesaulniers@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Desaulniers wrote on Wed, Aug 22, 2018:
> Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
> recently exposed a brittle part of the build for supporting non-gcc
> compilers.
> 
> Both Clang and ICC define __GNUC__, __GNUC_MINOR__, and
> __GNUC_PATCHLEVEL__ for quick compatibility with code bases that haven't
> added compiler specific checks for __clang__ or __INTEL_COMPILER.
> 
> This is brittle, as they happened to get compatibility by posing as a
> certain version of GCC.  This broke when upgrading the minimal version
> of GCC required to build the kernel, to a version above what ICC and
> Clang claim to be.
> 
> Rather than always including compiler-gcc.h then undefining or
> redefining macros in compiler-intel.h or compiler-clang.h, let's
> separate out the compiler specific macro definitions into mutually
> exclusive headers, do more proper compiler detection, and keep shared
> definitions in compiler_types.h.
> 
> Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Suggested-by: Eli Friedman <efriedma@codeaurora.org>
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Overall looks good to me, just pointing at the same error I wrote in my
other mail here -- I saw that by the time I was done writing this this
patch got taken but that alone will probably warrant a follow-up :/


I've also added a few style nitpicks/questions but feel free to ignore
these.

On a side note, I noticed tools/include/linux/compiler.h includes
linux/compiler-gcc.h but maybe it should include linux/compiler_types.h?
(I'm not sure at who uses that header, so it really is an open question
here)

> ---
>  arch/arm/kernel/asm-offsets.c     |  13 +-
>  drivers/gpu/drm/i915/i915_utils.h |   2 +-
>  drivers/watchdog/kempld_wdt.c     |   5 -
>  include/linux/compiler-clang.h    |  20 ++-
>  include/linux/compiler-gcc.h      |  88 -----------
>  include/linux/compiler-intel.h    |  13 +-
>  include/linux/compiler_types.h    | 238 ++++++++++++++----------------
>  mm/ksm.c                          |   4 +-
>  mm/migrate.c                      |   3 +-
>  9 files changed, 133 insertions(+), 253 deletions(-)
> 
> [...]
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 7087446c24c8..5f0754692ce6 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> [...]
> @@ -40,9 +30,17 @@
>   * checks. Unfortunately, we don't know which version of gcc clang
>   * pretends to be, so the macro may or may not be defined.
>   */
> -#undef COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW
>  #if __has_builtin(__builtin_mul_overflow) && \
>      __has_builtin(__builtin_add_overflow) && \
>      __has_builtin(__builtin_sub_overflow)
>  #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
>  #endif
> +
> +/* The following are for compatibility with GCC, from compiler-gcc.h,
> + * and may be redefined here because they should not be shared with other
> + * compilers, like ICC.
> + */
> +#define barrier() (__asm__ __volatile__("" : : : "memory"))

barrier here has gained external () compared to the definition and
compiler-gcc.h:
#define barrier() __asm__ __volatile__("": : :"memory")

And this fails with bpf:
In file included from <built-in>:3:
In file included from /virtual/include/bcc/helpers.h:23:
In file included from /lib/modules/4.18.0+/build/include/linux/log2.h:16:
In file included from /lib/modules/4.18.0+/build/include/linux/bitops.h:18:
/lib/modules/4.18.0+/build/arch/x86/include/asm/bitops.h:170:2: error: expected expression
        barrier();
        ^
/lib/modules/4.18.0+/build/include/linux/compiler-clang.h:43:20: note: expanded from macro 'barrier'
#define barrier() (__asm__ __volatile__("" : : : "memory"))
                   ^


> +#define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
> +#define __assume_aligned(a, ...)	\
> +	__attribute__((__assume_aligned__(a, ## __VA_ARGS__)))
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 250b9b7cfd60..763bbad1e258 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> [..]
> -#define __cold			__attribute__((__cold__))
> -
>  #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>  
>  #define __optimize(level)	__attribute__((__optimize__(level)))
> -#define __nostackprotector	__optimize("no-stack-protector")

I do not see this being added back, it's probably fine though as it
doesn't look used?
(I didn't check all removed lines, maybe about half)
  
>  #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index fbf337933fd8..90479a0f3986 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> [...]
>  /* Is this type a native word size -- useful for atomic operations */
> -#ifndef __native_word
> -# define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
> +#define __native_word(t) \
> +	(sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
> +	 sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
> +
> +#ifndef __attribute_const__

I'm not sure I understand the logic of where you removed ifndef and
where you kept them (but, well, this should work)

> +#define __attribute_const__	__attribute__((__const__))
>  #endif
>  
> +#ifndef __noclone
> +#define __noclone
> +#endif
> +
> +/* Helpers for emitting diagnostics in pragmas. */
>  #ifndef __diag
>  #define __diag(string)
>  #endif
> @@ -272,4 +174,92 @@ struct ftrace_likely_data {
>  #define __diag_error(compiler, version, option, comment) \
>  	__diag_ ## compiler(version, error, option)
>  
> +/*
> + * From the GCC manual:
> + *
> + * Many functions have no effects except the return value and their
> + * return value depends only on the parameters and/or global
> + * variables.  Such a function can be subject to common subexpression
> + * elimination and loop optimization just as an arithmetic operator
> + * would be.
> + * [...]
> + */
> +#define __pure			__attribute__((pure))
> +#define __aligned(x)		__attribute__((aligned(x)))
> +#define __aligned_largest	__attribute__((aligned))
> +#define __printf(a, b)		__attribute__((format(printf, a, b)))
> +#define __scanf(a, b)		__attribute__((format(scanf, a, b)))
> +#define __maybe_unused		__attribute__((unused))
> +#define __always_unused		__attribute__((unused))
> +#define __mode(x)		__attribute__((mode(x)))
> +#define __malloc		__attribute__((__malloc__))
> +#define __used			__attribute__((__used__))
> +#define __noreturn		__attribute__((noreturn))
> +#define __packed		__attribute__((packed))
> +#define __weak			__attribute__((weak))
> +#define __alias(symbol)		__attribute__((alias(#symbol)))
> +#define __cold			__attribute__((cold))
> +#define __section(S)		__attribute__((__section__(#S)))

If you tried to align these, __always_unused and __alias(symbol) look
off


Thanks!
-- 
Dominique
