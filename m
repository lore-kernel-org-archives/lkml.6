Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA13C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E786020020
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wUU2aoWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E786020020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030319AbeFSRfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:35:25 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:18584 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966368AbeFSRfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:35:23 -0400
Received: from mail-ua0-f173.google.com (mail-ua0-f173.google.com [209.85.217.173]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w5JHZHk0032008;
        Wed, 20 Jun 2018 02:35:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w5JHZHk0032008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529429718;
        bh=PJu6Zziv+jk9s+cId3nLu/n8efPlTKEzdQdiY5eRG/c=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=wUU2aoWZf+0Jatb5Qk15DC2Oga4akcPfwgkExhJxdvYBd3rAkXmrOQc8269X/cWpx
         srwcbvfYd5N0cgj3ie/p7NWG1zsW9abE1ZhthPSU2yCRh5QJzIq6m50Lv4VjeltHdH
         vAWvfXcgr457YDV9hhl5YFkDRK5DaFWgW/1Il6guUH7NBM9UnzShYeBgDrs5Owr4bc
         Wz2lUp6GkFHTCwH//tRP6yE6og3WV7b2Z/5gP5QmuEElilVt6/Ms0NxRNu50GPxvij
         iJOdnk7U0RxWBqP/axQAxKXLW5s1nMJDvvBl/osJWKgkO5/j71UNKTDS8ISNJWVG/n
         RXJxCpfPkDPww==
X-Nifty-SrcIP: [209.85.217.173]
Received: by mail-ua0-f173.google.com with SMTP id 59-v6so344625uas.5;
        Tue, 19 Jun 2018 10:35:17 -0700 (PDT)
X-Gm-Message-State: APt69E2NptGOihtkJKlWVGDf7N/xkuYZaPH6pj2L8aJl8gcKzJbnIzA7
        h7RTaLSv26HA/v+X6C9bHQR23cFB2ZVKydseHBI=
X-Google-Smtp-Source: ADUXVKIAC14oFY/uuxS4R569XwhcgvDv2XElYS9BeH0qIXMlFkUib1tqJMOHwyqc1jskWEH3UvTr6kOOhwnF2Ug7Z/Q=
X-Received: by 2002:ab0:13c8:: with SMTP id n8-v6mr11056761uae.140.1529429716370;
 Tue, 19 Jun 2018 10:35:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 10:34:35
 -0700 (PDT)
In-Reply-To: <20180616005323.7938-2-paul.burton@mips.com>
References: <20180616005323.7938-1-paul.burton@mips.com> <20180616005323.7938-2-paul.burton@mips.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 20 Jun 2018 02:34:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNASvCha27kU4ipn23uOpNuxkzJrNzWBwYcxN4n=3xtv8SA@mail.gmail.com>
Message-ID: <CAK7LNASvCha27kU4ipn23uOpNuxkzJrNzWBwYcxN4n=3xtv8SA@mail.gmail.com>
Subject: Re: [PATCH 1/3] kbuild: add macro for controlling warnings to linux/compiler.h
To:     Paul Burton <paul.burton@mips.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Thomas Gleixner <tglx@linutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        He Zhe <zhe.he@windriver.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Khem Raj <raj.khem@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Gideon Israel Dsouza <gidisrael@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

2018-06-16 9:53 GMT+09:00 Paul Burton <paul.burton@mips.com>:
> From: Arnd Bergmann <arnd@arndb.de>
>
> I have occasionally run into a situation where it would make sense to
> control a compiler warning from a source file rather than doing so from
> a Makefile using the $(cc-disable-warning, ...) or $(cc-option, ...)
> helpers.
>
> The approach here is similar to what glibc uses, using __diag() and
> related macros to encapsulate a _Pragma("GCC diagnostic ...") statement
> that gets turned into the respective "#pragma GCC diagnostic ..." by
> the preprocessor when the macro gets expanded.
>
> Like glibc, I also have an argument to pass the affected compiler
> version, but decided to actually evaluate that one. For now, this
> supports GCC_4_6, GCC_4_7, GCC_4_8, GCC_4_9, GCC_5, GCC_6, GCC_7,
> GCC_8 and GCC_9. Adding support for CLANG_5 and other interesting
> versions is straightforward here. GNU compilers starting with gcc-4.2
> could support it in principle, but "#pragma GCC diagnostic push"
> was only added in gcc-4.6, so it seems simpler to not deal with those
> at all. The same versions show a large number of warnings already,
> so it seems easier to just leave it at that and not do a more
> fine-grained control for them.
>
> The use cases I found so far include:
>
> - turning off the gcc-8 -Wattribute-alias warning inside of the
>   SYSCALL_DEFINEx() macro without having to do it globally.
>
> - Reducing the build time for a simple re-make after a change,
>   once we move the warnings from ./Makefile and
>   ./scripts/Makefile.extrawarn into linux/compiler.h
>
> - More control over the warnings based on other configurations,
>   using preprocessor syntax instead of Makefile syntax. This should make
>   it easier for the average developer to understand and change things.
>
> - Adding an easy way to turn the W=1 option on unconditionally
>   for a subdirectory or a specific file. This has been requested
>   by several developers in the past that want to have their subsystems
>   W=1 clean.
>
> - Integrating clang better into the build systems. Clang supports
>   more warnings than GCC, and we probably want to classify them
>   as default, W=1, W=2 etc, but there are cases in which the
>   warnings should be classified differently due to excessive false
>   positives from one or the other compiler.
>
> - Adding a way to turn the default warnings into errors (e.g. using
>   a new "make E=0" tag) while not also turning the W=1 warnings into
>   errors.
>
> This patch for now just adds the minimal infrastructure in order to
> do the first of the list above. As the #pragma GCC diagnostic
> takes precedence over command line options, the next step would be
> to convert a lot of the individual Makefiles that set nonstandard
> options to use __diag() instead.
>
> [paul.burton@mips.com:
>   - Rebase atop current master.
>   - Add __diag_GCC, or more generally __diag_<compiler>, abstraction to
>     avoid code outside of linux/compiler-gcc.h needing to duplicate
>     knowledge about different GCC versions.
>   - Add a comment argument to __diag_{ignore,warn,error} which isn't
>     used in the expansion of the macros but serves to push people to
>     document the reason for using them - per feedback from Kees Cook.]
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Matthew Wilcox <matthew@wil.cx>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Gideon Israel Dsouza <gidisrael@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Khem Raj <raj.khem@gmail.com>
> Cc: He Zhe <zhe.he@windriver.com>
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>
>  include/linux/compiler-gcc.h   | 66 ++++++++++++++++++++++++++++++++++
>  include/linux/compiler_types.h | 18 ++++++++++
>  2 files changed, 84 insertions(+)
>
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index f1a7492a5cc8..aba64a2912d8 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -347,3 +347,69 @@
>  #if GCC_VERSION >= 50100
>  #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
>  #endif
> +
> +/*
> + * turn individual warnings and errors on and off locally, depending
> + * on version.
> + */
> +#define __diag_GCC(version, s) __diag_GCC_ ## version(s)
> +
> +#if GCC_VERSION >= 40600
> +#define __diag_str1(s) #s
> +#define __diag_str(s) __diag_str1(s)
> +#define __diag(s) _Pragma(__diag_str(GCC diagnostic s))
> +
> +/* compilers before gcc-4.6 do not understand "#pragma GCC diagnostic push" */
> +#define __diag_GCC_4_6(s) __diag(s)
> +#else
> +#define __diag(s)
> +#define __diag_GCC_4_6(s)
> +#endif
> +
> +#if GCC_VERSION >= 40700
> +#define __diag_GCC_4_7(s) __diag(s)
> +#else
> +#define __diag_GCC_4_7(s)
> +#endif
> +
> +#if GCC_VERSION >= 40800
> +#define __diag_GCC_4_8(s) __diag(s)
> +#else
> +#define __diag_GCC_4_8(s)
> +#endif
> +
> +#if GCC_VERSION >= 40900
> +#define __diag_GCC_4_9(s) __diag(s)
> +#else
> +#define __diag_GCC_4_9(s)
> +#endif
> +
> +#if GCC_VERSION >= 50000
> +#define __diag_GCC_5(s) __diag(s)
> +#else
> +#define __diag_GCC_5(s)
> +#endif
> +
> +#if GCC_VERSION >= 60000
> +#define __diag_GCC_6(s) __diag(s)
> +#else
> +#define __diag_GCC_6(s)
> +#endif
> +
> +#if GCC_VERSION >= 70000
> +#define __diag_GCC_7(s) __diag(s)
> +#else
> +#define __diag_GCC_7(s)
> +#endif
> +
> +#if GCC_VERSION >= 80000
> +#define __diag_GCC_8(s) __diag(s)
> +#else
> +#define __diag_GCC_8(s)
> +#endif
> +
> +#if GCC_VERSION >= 90000
> +#define __diag_GCC_9(s) __diag(s)
> +#else
> +#define __diag_GCC_9(s)
> +#endif


Hmm, we would have to add this for every release.



> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 6b79a9bba9a7..313a2ad884e0 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -271,4 +271,22 @@ struct ftrace_likely_data {
>  # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>  #endif
>
> +#ifndef __diag
> +#define __diag(string)
> +#endif
> +
> +#ifndef __diag_GCC
> +#define __diag_GCC(string)
> +#endif




__diag_GCC() takes two arguments,
so it should be:

#ifndef __diag_GCC
#define __diag_GCC(version, s)
#endif


Otherwise, this would cause warning like this:


arch/arm64/kernel/sys.c:40:1: error: macro "__diag_GCC" passed 2
arguments, but takes just 1
 SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
 ^~~~~~~~~~







> +#define __diag_push()  __diag(push)
> +#define __diag_pop()   __diag(pop)
> +
> +#define __diag_ignore(compiler, version, option, comment) \
> +       __diag_ ## compiler(version, ignored option)
> +#define __diag_warn(compiler, version, option, comment) \
> +       __diag_ ## compiler(version, warning option)
> +#define __diag_error(compiler, version, option, comment) \
> +       __diag_ ## compiler(version, error   option)
> +


To me, it looks like this is putting GCC/Clang specific things
in the common file, <linux/compiler_types.h> .

All compilers must use "ignored", "warning", "error",
not allowed to use "ignore".



I also wonder if we could avoid proliferating __diag_GCC_*.



>  #endif /* __LINUX_COMPILER_TYPES_H */
> --
> 2.17.1
>


I attached a bit different implementation below.

I used -Wno-pragmas to avoid unknown option warnings.




diff --git a/Makefile b/Makefile
index ca2af1a..d610d81 100644
--- a/Makefile
+++ b/Makefile
@@ -817,6 +817,8 @@ KBUILD_CFLAGS   += $(call cc-option,-Werror=designated-init)
 # change __FILE__ to the relative path from the srctree
 KBUILD_CFLAGS  += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)

+KBUILD_CFLAGS   += $(call cc-option,-Wno-pragmas)
+
 # use the deterministic mode of AR if available
 KBUILD_ARFLAGS := $(call ar-option,D)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index f1a7492..3f9c1cc 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -3,6 +3,8 @@
 #error "Please don't include <linux/compiler-gcc.h> directly, include
<linux/compiler.h> instead."
 #endif

+#include <linux/stringify.h>
+
 /*
  * Common definitions for all gcc versions go here.
  */
@@ -259,6 +261,16 @@
  */
 #define __visible      __attribute__((externally_visible))

+/* turn individual warnings and errors on and off locally */
+#define __diag_gcc(s)  _Pragma(__stringify(GCC diagnostic s))
+
+#define __diag_push()  __diag_gcc(push)
+#define __diag_pop()   __diag_gcc(pop)
+
+#define __diag_ignore(option, comment) __diag_gcc(ignored __stringify(option))
+#define __diag_warn(option, comment)   __diag_gcc(warning __stringify(option))
+#define __diag_error(option, comment)  __diag_gcc(error __stringify(option))
+
 #endif /* GCC_VERSION >= 40600 */
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 6b79a9b..32e354f 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -271,4 +271,24 @@ struct ftrace_likely_data {
 # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) ==
sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) ==
sizeof(long))
 #endif

+#ifndef __diag_push
+#define __diag_push()
+#endif
+
+#ifndef __diag_pop
+#define __diag_pop()
+#endif
+
+#ifndef __diag_ignore
+#define __diag_ignore(option, comment)
+#endif
+
+#ifndef __diag_warn
+#define __diag_warn(option, comment)
+#endif
+
+#ifndef __diag_error
+#define __diag_error(option, comment)
+#endif
+
 #endif /* __LINUX_COMPILER_TYPES_H */





Usage is

       __diag_push();
       __diag_ignore(-Wattribute-alias,
                     "Type aliasing is used to sanitize syscall arguments");
              ...
       __diag_pop();




Comments, ideas are appreciated.




-- 
Best Regards
Masahiro Yamada
