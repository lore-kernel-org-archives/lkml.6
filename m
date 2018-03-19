Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754891AbeCSAlq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 20:41:46 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:57071 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754646AbeCSAln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 20:41:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Mar 2018 01:41:41 +0100
From: Stefan Agner <stefan@agner.ch>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org,
        mka@chromium.org, arnd@arndb.de
Subject: Re: kbuild: move cc-option and cc-disable-warning after incl. arch
 Makefile
In-Reply-To: <1511784913-3396-1-git-send-email-yamada.masahiro@socionext.com>
References: <1511784913-3396-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <9026b476c29fdd2d68b2e90ab0a155d0@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On 27.11.2017 13:15, Masahiro Yamada wrote:
> Geert reported commit ae6b289a3789 ("kbuild: Set KBUILD_CFLAGS before
> incl. arch Makefile") broke cross-compilation using a cross-compiler
> that supports less compiler options than the host compiler.
> 
> For example,
> 
>   cc1: error: unrecognized command line option "-Wno-unused-but-set-variable"
> 
> This problem happens on architectures that setup CROSS_COMPILE in their
> arch/*/Makefile.
> 
> Move the cc-option and cc-disable-warning back to the original position,
> but keep the Clang target options.

This seems to break arm (32-bit) clang support for me. It seems to break
correct compiler flag detection in some way.

Just moving no-integrated-as back to before including the arch Makefile
seems to fix the issue:

--- a/Makefile
+++ b/Makefile
@@ -487,6 +487,7 @@ CLANG_GCC_TC        :=
--gcc-toolchain=$(GCC_TOOLCHAIN)
 endif
 KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
 KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
+KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
 endif
 
 RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern
-mindirect-branch-register
@@ -744,7 +745,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning,
tautological-compare)
 # See modpost pattern 2
 KBUILD_CFLAGS += $(call cc-option, -mno-global-merge,)
 KBUILD_CFLAGS += $(call cc-option, -fcatch-undefined-behavior)
-KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
 KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
 else

Does that sound like a reasonable fix?

Note that arm support is not completely upstream yet, but only few
patches are necessary currently:
http://git.agner.ch/gitweb/?p=linux.git;a=shortlog;h=refs/heads/v4.16-rc5-clang-arm-no-revert

--
Stefan


> 
> Fixes: ae6b289a3789 ("kbuild: Set KBUILD_CFLAGS before incl. arch Makefile")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> 
>  Makefile | 43 +++++++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index aa67428..ac2d4e1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -484,26 +484,6 @@ CLANG_GCC_TC	:= --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
>  KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
>  KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
> -KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
> -KBUILD_CFLAGS += $(call cc-disable-warning, unused-variable)
> -KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
> -KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
> -KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
> -# Quiet clang warning: comparison of unsigned expression < 0 is always false
> -KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
> -# CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
> -# source of a reference will be _MergedGlobals and not on of the
> whitelisted names.
> -# See modpost pattern 2
> -KBUILD_CFLAGS += $(call cc-option, -mno-global-merge,)
> -KBUILD_CFLAGS += $(call cc-option, -fcatch-undefined-behavior)
> -KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
> -KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
> -else
> -
> -# These warnings generated too much noise in a regular build.
> -# Use make W=1 to enable them (see scripts/Makefile.extrawarn)
> -KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
> -KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
>  endif
>  
>  ifeq ($(config-targets),1)
> @@ -715,6 +695,29 @@ ifdef CONFIG_CC_STACKPROTECTOR
>  endif
>  KBUILD_CFLAGS += $(stackp-flag)
>  
> +ifeq ($(cc-name),clang)
> +KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
> +KBUILD_CFLAGS += $(call cc-disable-warning, unused-variable)
> +KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
> +KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
> +KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
> +# Quiet clang warning: comparison of unsigned expression < 0 is always false
> +KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
> +# CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
> +# source of a reference will be _MergedGlobals and not on of the
> whitelisted names.
> +# See modpost pattern 2
> +KBUILD_CFLAGS += $(call cc-option, -mno-global-merge,)
> +KBUILD_CFLAGS += $(call cc-option, -fcatch-undefined-behavior)
> +KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
> +KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
> +else
> +
> +# These warnings generated too much noise in a regular build.
> +# Use make W=1 to enable them (see scripts/Makefile.extrawarn)
> +KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
> +KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
> +endif
> +
>  ifdef CONFIG_FRAME_POINTER
>  KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
>  else
