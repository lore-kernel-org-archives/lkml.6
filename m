Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeCNRwU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:52:20 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:43556 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbeCNRwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:52:18 -0400
X-Google-Smtp-Source: AG47ELtxcJITNUllMphXl0MqX5ZDl0l93BRtnkU8DwOtH219LXENUyXCaoGND6cdmMZoBWSrUu9szQ==
Date: Wed, 14 Mar 2018 13:52:16 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
cc: linux-kbuild@vger.kernel.org, Jarod Wilson <jarod@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] kbuild: restore touching autoksyms.h to the top
 Makefile
In-Reply-To: <1521045861-22418-5-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <nycvar.YSQ.7.76.1803141350430.28583@knanqh.ubzr>
References: <1521045861-22418-1-git-send-email-yamada.masahiro@socionext.com> <1521045861-22418-5-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018, Masahiro Yamada wrote:

> Commit d3fc425e819b ("kbuild: make sure autoksyms.h exists early")
> moved the code that touches autoksyms.h to scripts/kconfig/Makefile
> with obscure reason.
> 
> From Nicolas' comment [1], he did not seem to be sure about the root
> cause.
> 
> I guess I figured it out, so here is a fix-up I think is more correct.
> According to the error log in the original post [2], the build failed
> in scripts/mod/devicetable-offsets.c
> 
> scripts/mod/Makefile is descended from scripts/Makefile, which is
> invoked from the top-level Makefile by the 'scripts' target.
> 
> To build vmlinux and/or modules, Kbuild descend into $(vmlinux-dirs).
> This depends on 'prepare' and 'script' as follows:
> 
>   $(vmlinux-dirs): prepare scripts
> 
> Because there is no dependency between 'prepare' and 'scripts', the
> parallel building can run them simultaneously.
> 
> 'prepare' depends on 'prepare1', which touched autoksyms.h, whereas
> 'scripts' descends into script/, then scripts/mod/, which needed
> <generated/autoksyms.h> if CONFIG_TRIM_UNUSED_KSYMS.  This was the
> reason of race.
> 
> I am not happy to have unrelated code in the Kconfig Makefile, so
> getting it back to the top Makefile.
> 
> I remove the standalone test target because I want to use it to
> create an empty autoksyms.h file.  Here is a little improvement;
> unnecessary autoksyms.h is not created when CONFIG_TRIM_UNUSED_KSYMS
> is disabled.
> 
> [1] https://lkml.org/lkml/2016/11/30/734
> [2] https://lkml.org/lkml/2016/11/30/531
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

You're the make master!

Acked-by: Nicolas Pitre <nico@linaro.org>



> Commit:
> 
> The discussion happened in Nov. 2016.
> 
> I was not involved in it.
> I was not the Kbuild maintainer at that time.
> 
> END
> 
> ---
> 
>  Makefile                 | 12 +++++++-----
>  scripts/kconfig/Makefile |  2 --
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index fab0e19..decc870 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1010,9 +1010,11 @@ ifdef CONFIG_TRIM_UNUSED_KSYMS
>  	  "$(MAKE) -f $(srctree)/Makefile vmlinux"
>  endif
>  
> -# standalone target for easier testing
> -include/generated/autoksyms.h: FORCE
> -	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/adjust_autoksyms.sh true
> +autoksyms_h := $(if $(CONFIG_TRIM_UNUSED_KSYMS), include/generated/autoksyms.h)
> +
> +$(autoksyms_h):
> +	$(Q)mkdir -p $(dir $@)
> +	$(Q)touch $@
>  
>  ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
>  
> @@ -1056,7 +1058,7 @@ include/config/kernel.release: include/config/auto.conf FORCE
>  # in parallel
>  PHONY += scripts
>  scripts: scripts_basic include/config/auto.conf include/config/tristate.conf \
> -	 asm-generic gcc-plugins autoksyms
> +	 asm-generic gcc-plugins $(autoksyms_h)
>  	$(Q)$(MAKE) $(build)=$(@)
>  
>  # Things we need to do before we recursively start building the kernel
> @@ -1086,7 +1088,7 @@ endif
>  # that need to depend on updated CONFIG_* values can be checked here.
>  prepare2: prepare3 prepare-compiler-check outputmakefile asm-generic
>  
> -prepare1: prepare2 $(version_h) include/generated/utsrelease.h \
> +prepare1: prepare2 $(version_h) $(autoksyms_h) include/generated/utsrelease.h \
>                     include/config/auto.conf
>  	$(cmd_crmodverdir)
>  
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index cb3ec53..eb139a1 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -38,8 +38,6 @@ nconfig: $(obj)/nconf
>  # for external use.
>  silentoldconfig: $(obj)/conf
>  	$(Q)mkdir -p include/config include/generated
> -	$(Q)test -e include/generated/autoksyms.h || \
> -	    touch   include/generated/autoksyms.h
>  	$< $(silent) --$@ $(Kconfig)
>  
>  localyesconfig localmodconfig: $(obj)/streamline_config.pl $(obj)/conf
> -- 
> 2.7.4
> 
> 
