Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbeCNTGW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:06:22 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:40325 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbeCNTGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:06:20 -0400
X-Google-Smtp-Source: AG47ELsi8Hkvkdy/qk+ZoCXJFnMrM2cVDY+QwWNeZZDG/OLd3RpGW/McLN3yHloQZPX7rqcoUIjesw==
Date: Wed, 14 Mar 2018 15:06:17 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
cc: linux-kbuild@vger.kernel.org, Jarod Wilson <jarod@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] kbuild: link vmlinux just once for
 CONFIG_TRIM_UNUSED_KSYMS
In-Reply-To: <1521045861-22418-8-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <nycvar.YSQ.7.76.1803141448330.28583@knanqh.ubzr>
References: <1521045861-22418-1-git-send-email-yamada.masahiro@socionext.com> <1521045861-22418-8-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018, Masahiro Yamada wrote:

> If CONFIG_TRIM_UNUSED_KSYMS is enabled and the kernel is built from
> a pristine state, the vmlinux is linked twice.
> 
> [1] A user runs "make"
> 
> [2] First build with empty autoksyms.h
> 
> [3] adjust_autoksyms.sh updates autoksyms.h and recurses "make vmlinux"
> 
>   --------(begin sub-make)--------
>   [4] Second build with new autoksyms.h
> 
>   [5] link-vmlinux.sh is invoked because "vmlinux" is missing
>   ---------(end sub-make)---------
> 
> [6] link-vmlinux.sh is invoked again despite "vmlinux" is up-to-date.
> 
> The reason of [6] is probably because Make already decided to update
> "vmlinux" at the time of [2] because "vmlinux" was missing when Make
> generated the dependency list.

But the dependency list for vmlinux contains FORCE so the target is 
always remade in (2) anyway. The decision to actually invoke 
link-vmlinux.sh comes from "if_changed". Why is $(call if_changed,...) 
in (6) not noticing that vmlinux is up to date?

> 
> link-vmlinus.sh is costly, so it is better to not run it when unneeded.
> Split CONFIG_TRIM_UNUSED_KSYMS handling to a dedicated target.
> 
> The reason of commit 2441e78b1919 ("krbuild: better abstract vmlinux
> sequential prerequisites") was to cater to CONFIG_BUILD_DOCSRC, but
> it was later removed by commit 184892925118 ("samples: move blackfin
> gptimers-example from Documentation").
> 
> I also changed adjust_autoksyms.sh to simply exit with 1 or 0 to make
> it look straightforward.

That is wrong. If the script fails for some reason (it runs with -e set) 
then this will trigger an endless recursive make instead of failing the 
build.

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  Makefile                    | 28 ++++++++++++----------------
>  scripts/adjust_autoksyms.sh |  3 +--
>  2 files changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 1dab647..0a7bab6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -987,21 +987,11 @@ export KBUILD_ALLDIRS := $(sort $(filter-out arch/%,$(vmlinux-alldirs)) arch Doc
>  
>  vmlinux-deps := $(KBUILD_LDS) $(KBUILD_VMLINUX_INIT) $(KBUILD_VMLINUX_MAIN) $(KBUILD_VMLINUX_LIBS)
>  
> -# Include targets which we want to execute sequentially if the rest of the
> -# kernel build went well. If CONFIG_TRIM_UNUSED_KSYMS is set, this might be
> -# evaluated more than once.
> -PHONY += vmlinux_prereq
> -vmlinux_prereq: $(vmlinux-deps) FORCE
> -ifdef CONFIG_HEADERS_CHECK
> -	$(Q)$(MAKE) -f $(srctree)/Makefile headers_check
> -endif
> -ifdef CONFIG_GDB_SCRIPTS
> -	$(Q)ln -fsn $(abspath $(srctree)/scripts/gdb/vmlinux-gdb.py)
> -endif
> -ifdef CONFIG_TRIM_UNUSED_KSYMS
> -	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/adjust_autoksyms.sh \
> -	  "$(MAKE) -f $(srctree)/Makefile vmlinux"
> -endif
> +# Recurse until adjust_autoksyms.sh is satisfied
> +PHONY += autoksyms_recursive
> +autoksyms_recursive: $(vmlinux-deps)
> +	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/adjust_autoksyms.sh || \
> +	$(MAKE) -f $(srctree)/Makefile autoksyms_recursive
>  
>  # For the kernel to actually contain only the needed exported symbols,
>  # we have to build modules as well to determine what those symbols are.
> @@ -1023,7 +1013,13 @@ cmd_link-vmlinux =                                                 \
>  	$(CONFIG_SHELL) $< $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) ;    \
>  	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
>  
> -vmlinux: scripts/link-vmlinux.sh vmlinux_prereq $(vmlinux-deps) FORCE
> +vmlinux: scripts/link-vmlinux.sh autoksyms_recursive $(vmlinux-deps) FORCE
> +ifdef CONFIG_HEADERS_CHECK
> +	$(Q)$(MAKE) -f $(srctree)/Makefile headers_check
> +endif
> +ifdef CONFIG_GDB_SCRIPTS
> +	$(Q)ln -fsn $(abspath $(srctree)/scripts/gdb/vmlinux-gdb.py)
> +endif
>  	+$(call if_changed,link-vmlinux)
>  
>  # Build samples along the rest of the kernel
> diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
> index 7bb3618..1377cf8 100755
> --- a/scripts/adjust_autoksyms.sh
> +++ b/scripts/adjust_autoksyms.sh
> @@ -95,8 +95,7 @@ if [ $changed -gt 0 ]; then
>  	info "KSYMS" "symbols: before=$old, after=$new, changed=$changed"
>  	info "UPD" "$cur_ksyms_file"
>  	mv -f "$new_ksyms_file" "$cur_ksyms_file"
> -	# Then trigger a rebuild of affected source files
> -	exec $@
> +	exit 1
>  else
>  	rm -f "$new_ksyms_file"
>  fi
> -- 
> 2.7.4
> 
> 
