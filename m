Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CABC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289D320880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfBTPgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:36:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:60130 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725865AbfBTPgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:36:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0EA66ABC1;
        Wed, 20 Feb 2019 15:36:14 +0000 (UTC)
Date:   Wed, 20 Feb 2019 16:36:13 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joao Moreira <jmoreira@suse.de>
cc:     live-patching@vger.kernel.org, pmladek@suse.cz, jikos@suse.cz,
        nstange@suse.de, jpoimboe@redhat.com, khlebnikov@yandex-team.ru,
        jeyu@kernel.org, matz@suse.de, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v2 5/8] modpost: Integrate klp-convert
In-Reply-To: <20190130165446.19479-6-jmoreira@suse.de>
Message-ID: <alpine.LSU.2.21.1902201635570.26855@pobox.suse.cz>
References: <20190130165446.19479-1-jmoreira@suse.de> <20190130165446.19479-6-jmoreira@suse.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding CCs...

On Wed, 30 Jan 2019, Joao Moreira wrote:

> From: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Create cmd_klp_convert and hook it into scripts/Makefile.modpost.
> cmd_klp_convert invokes klp-convert with the right arguments for the
> conversion of unresolved symbols inside a livepatch.
> 
> [khlebnikov:
> * save cmd_ld_ko_o into .module.cmd, if_changed_rule doesn't do that
> * fix bashisms for debian where /bin/sh is a symlink to /bin/dash
> * rename rule_link_module to rule_ld_ko_o, otherwise arg-check inside
>   if_changed_rule compares cmd_link_module and cmd_ld_ko_o
> * check modinfo -F livepatch only if CONFIG_LIVEPATCH is true
> ]
> 
> [mbenes:
> * remove modinfo call. LIVEPATCH_ in Makefiled
> ]
> 
> [jmoreira:
> * split up: move the .livepatch file-based scheme for identifying
> livepatches to a previous patch, as it was required for correctly
> building Symbols.list there.
> ]
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> Signed-off-by: Joao Moreira <jmoreira@suse.de>

I'm definitely not an expert on this topic (and we talked about it in the 
past off-list), but I'd simplify the SoB chain. At least you don't need my 
SoB there. I'm happy that you took the code and transformed it.

> ---
>  scripts/Kbuild.include   |  4 +++-
>  scripts/Makefile.modpost | 16 +++++++++++++++-
>  scripts/mod/modpost.c    |  6 +++++-
>  scripts/mod/modpost.h    |  1 +
>  4 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index 30816037036e..c30a8573c816 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -239,6 +239,8 @@ endif
>  # (needed for the shell)
>  make-cmd = $(call escsq,$(subst $(pound),$$(pound),$(subst $$,$$$$,$(cmd_$(1)))))
>  
> +save-cmd = printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd
> +
>  # Find any prerequisites that is newer than target or that does not exist.
>  # PHONY targets skipped in both cases.
>  any-prereq = $(filter-out $(PHONY),$?) $(filter-out $(PHONY) $(wildcard $^),$^)
> @@ -246,7 +248,7 @@ any-prereq = $(filter-out $(PHONY),$?) $(filter-out $(PHONY) $(wildcard $^),$^)
>  # Execute command if command has changed or prerequisite(s) are updated.
>  if_changed = $(if $(strip $(any-prereq) $(arg-check)),                       \
>  	$(cmd);                                                              \
> -	printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
> +	$(save-cmd), @:)
>  
>  # Execute the command and also postprocess generated .d dependencies file.
>  if_changed_dep = $(if $(strip $(any-prereq) $(arg-check)),$(cmd_and_fixdep),@:)
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 7d4af0d0accb..da779a185218 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -125,8 +125,22 @@ quiet_cmd_ld_ko_o = LD [M]  $@
>                   -o $@ $(filter-out FORCE,$^) ;                         \
>  	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
>  
> +SLIST = $(objtree)/Symbols.list
> +KLP_CONVERT = scripts/livepatch/klp-convert
> +quiet_cmd_klp_convert = KLP $@
> +      cmd_klp_convert = mv $@ $(@:.ko=.klp.o);				\
> +			$(KLP_CONVERT) $(SLIST) $(@:.ko=.klp.o) $@
> +
> +define rule_ld_ko_o
> +	$(call cmd,ld_ko_o) $(cmd_ld_ko_o) ;				\
> +	$(call save-cmd,ld_ko_o) ;					\
> +	$(if $(CONFIG_LIVEPATCH),					\
> +	  $(if $(wildcard $(MODVERDIR)/$(basetarget).livepatch),	\
> +	    $(call echo-cmd,klp_convert) $(cmd_klp_convert) ))
> +endef
> +
>  $(modules): %.ko :%.o %.mod.o FORCE
> -	+$(call if_changed,ld_ko_o)
> +	+$(call if_changed_rule,ld_ko_o)
>  
>  targets += $(modules)
>  
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 26bf886bd168..1dfc34d8b668 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1979,6 +1979,10 @@ static void read_symbols(const char *modname)
>  		license = get_next_modinfo(&info, "license", license);
>  	}
>  
> +	/* Livepatch modules have unresolved symbols resolved by klp-convert */
> +	if (get_modinfo(info.modinfo, info.modinfo_len, "livepatch"))
> +		mod->livepatch = 1;
> +
>  	for (sym = info.symtab_start; sym < info.symtab_stop; sym++) {
>  		symname = remove_dot(info.strtab + sym->st_name);
>  
> @@ -2106,7 +2110,7 @@ static int check_exports(struct module *mod)
>  		const char *basename;
>  		exp = find_symbol(s->name);
>  		if (!exp || exp->module == mod) {
> -			if (have_vmlinux && !s->weak) {
> +			if (have_vmlinux && !s->weak && !mod->livepatch) {
>  				if (warn_unresolved) {
>  					warn("\"%s\" [%s.ko] undefined!\n",
>  					     s->name, mod->name);
> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index 8453d6ac2f77..2acfaae064ec 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -118,6 +118,7 @@ struct module {
>  	int skip;
>  	int has_init;
>  	int has_cleanup;
> +	int livepatch;
>  	struct buffer dev_table_buf;
>  	char	     srcversion[25];
>  	int is_dot_o;
> -- 
> 2.16.4
> 

Miroslav
