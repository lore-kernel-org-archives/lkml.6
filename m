Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC641C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCA22146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfBTOJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:09:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:44402 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbfBTOJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:09:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 94830B658;
        Wed, 20 Feb 2019 14:09:06 +0000 (UTC)
Date:   Wed, 20 Feb 2019 15:09:04 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joao Moreira <jmoreira@suse.de>
cc:     live-patching@vger.kernel.org, pmladek@suse.cz, jikos@suse.cz,
        nstange@suse.de, jpoimboe@redhat.com, jeyu@kernel.org,
        matz@suse.de, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com, linux-kbuild@vger.kernel.org,
        michal.lkml@markovi.net
Subject: Re: [PATCH v2 2/8] kbuild: Support for Symbols.list creation
In-Reply-To: <20190130165446.19479-3-jmoreira@suse.de>
Message-ID: <alpine.LSU.2.21.1902201508550.26855@pobox.suse.cz>
References: <20190130165446.19479-1-jmoreira@suse.de> <20190130165446.19479-3-jmoreira@suse.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More CCs added. I'd give you lore.kernel.org link for the whole patch set 
(and cover letter), but the patch set is not archived for some strange 
reason.

On Wed, 30 Jan 2019, Joao Moreira wrote:

> For automatic resolution of livepatch relocations, a file called
> Symbols.list is used. This file maps symbols within every compiled
> kernel object allowing the identification of symbols whose name is
> unique, thus relocation can be automatically inferred, or providing
> information that helps developers when code annotation is required for
> solving the matter.
> 
> Add support for creating Symbols.list in the main Makefile. First,
> ensure that built-in is compiled when CONFIG_LIVEPATCH is enabled (as
> required to achieve a complete Symbols.list file). Define the command to
> build Symbols.list (cmd_klp_map) and hook it in the modules rule.
> 
> As it is undesirable to have symbols from livepatch objects inside
> Symbols.list, make livepatches discernible by modifying
> scripts/Makefile.build to create a .livepatch file for each livepatch
> in $(MODVERDIR). This file then used by cmd_klp_map to identify and
> bypass livepatches.
> 
> For identifying livepatches during the build process, a flag variable
> LIVEPATCH_$(basetarget).o is considered in scripts/Makefile.build. This
> way, set this flag for the livepatch sample Makefile in
> samples/livepatch/Makefile.
> 
> Finally, Add a clean rule to ensure that Symbols.list is removed during
> clean.
> 
> Notes:
> 
> To achieve a correct Symbols.list file, all kernel objects must be
> considered, thus, its construction require these objects to be priorly
> built. On the other hand, invoking scripts/Makefile.modpost without
> having a complete Symbols.list in place would occasionally lead to
> in-tree livepatches being post-processed incorrectly. To prevent this
> from becoming a circular dependency, the construction of Symbols.list
> uses non-post-processed kernel objects and such does not cause harm as
> the symbols normally referenced from within livepatches are visible at
> this stage. Also due to these requirements, the spot in-between modules
> compilation and the invocation of scripts/Makefile.modpost was picked
> for hooking cmd_klp_map.
> 
> The approach based on .livepatch files was proposed as an alternative
> to using MODULE_INFO statementes. This approach was originally
> proposed by Miroslav Benes as a workaround for identifying livepathces
> without depending on modinfo during the modpost stage. It was moved to
> this patch as the approach also shown to be useful while building
> Symbols.list.

If I remember correctly, the approach was originally proposed by Michal 
Marek. I only wanted to avoid modinfo.

> Signed-off-by: Joao Moreira <jmoreira@suse.de>
> ---
>  .gitignore                 |  1 +
>  Makefile                   | 28 +++++++++++++++++++++++++---
>  samples/livepatch/Makefile |  1 +
>  scripts/Makefile.build     |  6 ++++++
>  4 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index a20ac26aa2f5..5cd5758f5ffe 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -45,6 +45,7 @@
>  *.xz
>  Module.symvers
>  modules.builtin
> +Symbols.list
>  
>  #
>  # Top-level generic files
> diff --git a/Makefile b/Makefile
> index f5b1d0d168e0..8903d72793b4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -560,10 +560,13 @@ KBUILD_BUILTIN := 1
>  # If we have only "make modules", don't compile built-in objects.
>  # When we're building modules with modversions, we need to consider
>  # the built-in objects during the descend as well, in order to
> -# make sure the checksums are up to date before we record them.
> +# make sure the checksums are up to date before we record them. The
> +# same applies for building livepatches, as built-in objects may hold
> +# symbols which are referenced from livepatches and are required by
> +# klp-convert post-processing tool for resolving these cases.
>  
>  ifeq ($(MAKECMDGOALS),modules)
> -  KBUILD_BUILTIN := $(if $(CONFIG_MODVERSIONS),1)
> +  KBUILD_BUILTIN := $(if $(or $(CONFIG_MODVERSIONS), $(CONFIG_LIVEPATCH)),1)
>  endif
>  
>  # If we have "make <whatever> modules", compile modules
> @@ -1255,9 +1258,25 @@ all: modules
>  # duplicate lines in modules.order files.  Those are removed
>  # using awk while concatenating to the final file.
>  
> +quiet_cmd_klp_map = KLP	Symbols.list
> +SLIST = $(objtree)/Symbols.list
> +
> +define cmd_klp_map
> +	$(shell echo "klp-convert-symbol-data.0.1" > $(SLIST))				\
> +	$(shell echo "*vmlinux" >> $(SLIST))						\
> +	$(shell nm -f posix $(objtree)/vmlinux | cut -d\  -f1 >> $(SLIST))		\
> +	$(foreach m, $(wildcard $(MODVERDIR)/*.mod),					\
> +		$(eval mod = $(patsubst %.ko,%.o,$(shell head -n1 $(m))))		\
> +		$(if $(wildcard $(MODVERDIR)/$(shell basename -s .o $(mod)).livepatch),,\
> +			$(eval fmod = $(subst $(quote),_,$(subst -,_,$(mod))))		\
> +			$(shell echo "*$(shell basename -s .o $(fmod))" >> $(SLIST))	\
> +			$(shell nm -f posix $(mod) | cut -d\  -f1 >> $(SLIST))))
> +endef
> +
>  PHONY += modules
>  modules: $(vmlinux-dirs) $(if $(KBUILD_BUILTIN),vmlinux) modules.builtin
>  	$(Q)$(AWK) '!x[$$0]++' $(vmlinux-dirs:%=$(objtree)/%/modules.order) > $(objtree)/modules.order
> +	$(if $(CONFIG_LIVEPATCH), $(call cmd,klp_map))
>  	@$(kecho) '  Building modules, stage 2.';
>  	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
>  
> @@ -1352,7 +1371,10 @@ vmlinuxclean:
>  	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/link-vmlinux.sh clean
>  	$(Q)$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) clean)
>  
> -clean: archclean vmlinuxclean
> +klpclean:
> +	$(Q) rm -f $(objtree)/Symbols.list
> +
> +clean: archclean vmlinuxclean klpclean
>  
>  # mrproper - Delete all generated files, including .config
>  #
> diff --git a/samples/livepatch/Makefile b/samples/livepatch/Makefile
> index 2472ce39a18d..9705df7f9a86 100644
> --- a/samples/livepatch/Makefile
> +++ b/samples/livepatch/Makefile
> @@ -1,3 +1,4 @@
> +LIVEPATCH_livepatch-sample.o := y
>  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-sample.o
>  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-shadow-mod.o
>  obj-$(CONFIG_SAMPLE_LIVEPATCH) += livepatch-shadow-fix1.o

We should eventually add the same flag even for the rest of samples.

> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index fd03d60f6c5a..1e28ad21314c 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -247,6 +247,11 @@ cmd_gen_ksymdeps = \
>  	$(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> $(dot-target).cmd
>  endif
>  
> +ifdef CONFIG_LIVEPATCH
> +cmd_livepatch = $(if $(LIVEPATCH_$(basetarget).o),			\
> +	$(shell touch $(MODVERDIR)/$(basetarget).livepatch))
> +endif
> +
>  define rule_cc_o_c
>  	$(call cmd,checksrc)
>  	$(call cmd_and_fixdep,cc_o_c)
> @@ -283,6 +288,7 @@ $(single-used-m): $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) F
>  	$(call if_changed_rule,cc_o_c)
>  	@{ echo $(@:.o=.ko); echo $@; \
>  	   $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
> +	$(call cmd_livepatch)
>  
>  quiet_cmd_cc_lst_c = MKLST   $@
>        cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \
> -- 
> 2.16.4
> 

Miroslav
