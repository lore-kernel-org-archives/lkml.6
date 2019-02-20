Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B277EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B6E2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfBTPuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:50:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:34176 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726019AbfBTPuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:50:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 51E45AF1E;
        Wed, 20 Feb 2019 15:50:11 +0000 (UTC)
Date:   Wed, 20 Feb 2019 16:50:08 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joao Moreira <jmoreira@suse.de>
cc:     live-patching@vger.kernel.org, pmladek@suse.cz, jikos@suse.cz,
        nstange@suse.de, jpoimboe@redhat.com, khlebnikov@yandex-team.ru,
        jeyu@kernel.org, matz@suse.de, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v2 6/8] modpost: Add modinfo flag to livepatch modules
In-Reply-To: <20190130165446.19479-7-jmoreira@suse.de>
Message-ID: <alpine.LSU.2.21.1902201648310.26855@pobox.suse.cz>
References: <20190130165446.19479-1-jmoreira@suse.de> <20190130165446.19479-7-jmoreira@suse.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding CCs...

On Wed, 30 Jan 2019, Joao Moreira wrote:

> From: Miroslav Benes <mbenes@suse.cz>
> 
> Currently, livepatch infrastructure in the kernel relies on
> MODULE_INFO(livepatch, "Y") statement in a livepatch module. Then the
> kernel module loader knows a module is indeed livepatch module and can
> behave accordingly.
> 
> klp-convert, on the other hand relies on LIVEPATCH_* statement in the
> module's Makefile for exactly the same reason.
> 
> Remove dependency on modinfo and generate MODULE_INFO flag
> automatically in modpost when LIVEPATCH_* is defined in the module's
> Makefile. Generate a list of all built livepatch modules based on
> the .livepatch file and store it in (MODVERDIR)/livepatchmods. Give
> this list as an argument for modpost which will use it to identify
> livepatch modules.
> 
> As MODULE_INFO is no longer needed, remove it.
> 
> [jmoreira:
> * fix modpost.c (add_livepatch_flag) to update module structure with
> livepatch flag and prevent modpost from breaking due to unresolved
> symbols]
> 
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> Signed-off-by: Joao Moreira <jmoreira@suse.de>
> ---
>  samples/livepatch/livepatch-sample.c |  1 -
>  scripts/Makefile.modpost             |  8 +++-
>  scripts/mod/modpost.c                | 84 +++++++++++++++++++++++++++++++++---
>  3 files changed, 85 insertions(+), 8 deletions(-)
> 
> diff --git a/samples/livepatch/livepatch-sample.c b/samples/livepatch/livepatch-sample.c
> index 2d554dd930e2..20a5891ebf7b 100644
> --- a/samples/livepatch/livepatch-sample.c
> +++ b/samples/livepatch/livepatch-sample.c
> @@ -90,4 +90,3 @@ static void livepatch_exit(void)
>  module_init(livepatch_init);
>  module_exit(livepatch_exit);
>  MODULE_LICENSE("GPL");
> -MODULE_INFO(livepatch, "Y");

Again, we shoud do the same for the other samples we have in 
samples/livepatch/ directory.

> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index da779a185218..0149a72ea7ae 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -65,6 +65,11 @@ MODLISTCMD := find $(MODVERDIR) -name '*.mod' | xargs -r grep -h '\.ko$$' | sort
>  __modules := $(shell $(MODLISTCMD))
>  modules   := $(patsubst %.o,%.ko, $(wildcard $(__modules:.ko=.o)))
>  
> +# find all .livepatch files listed in $(MODVERDIR)/
> +ifdef CONFIG_LIVEPATCH
> +$(shell find $(MODVERDIR) -name '*.livepatch' | xargs -r -I{} basename {} .livepatch > $(MODVERDIR)/livepatchmods)
> +endif
> +
>  # Stop after building .o files if NOFINAL is set. Makes compile tests quicker
>  _modpost: $(if $(KBUILD_MODPOST_NOFINAL), $(modules:.ko:.o),$(modules))
>  
> @@ -79,7 +84,8 @@ modpost = scripts/mod/modpost                    \
>   $(if $(KBUILD_EXTMOD),-o $(modulesymfile))      \
>   $(if $(CONFIG_DEBUG_SECTION_MISMATCH),,-S)      \
>   $(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)  \
> - $(if $(KBUILD_EXTMOD)$(KBUILD_MODPOST_WARN),-w)
> + $(if $(KBUILD_EXTMOD)$(KBUILD_MODPOST_WARN),-w) \
> + $(if $(CONFIG_LIVEPATCH),-l $(MODVERDIR)/livepatchmods)
>  
>  MODPOST_OPT=$(subst -i,-n,$(filter -i,$(MAKEFLAGS)))
>  
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 1dfc34d8b668..2fd1d409ca5a 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1979,10 +1979,6 @@ static void read_symbols(const char *modname)
>  		license = get_next_modinfo(&info, "license", license);
>  	}
>  
> -	/* Livepatch modules have unresolved symbols resolved by klp-convert */
> -	if (get_modinfo(info.modinfo, info.modinfo_len, "livepatch"))
> -		mod->livepatch = 1;
> -
>  	for (sym = info.symtab_start; sym < info.symtab_stop; sym++) {
>  		symname = remove_dot(info.strtab + sym->st_name);
>  
> @@ -2421,6 +2417,76 @@ static void write_dump(const char *fname)
>  	free(buf.p);
>  }
>  
> +struct livepatch_mod_list {
> +	struct livepatch_mod_list *next;
> +	char *livepatch_mod;
> +};
> +
> +static struct livepatch_mod_list *load_livepatch_mods(const char *fname)
> +{
> +	struct livepatch_mod_list *list_iter, *list_start = NULL;
> +	unsigned long size, pos = 0;
> +	void *file = grab_file(fname, &size);
> +	char *line;
> +
> +	if (!file)
> +		return NULL;
> +
> +	while ((line = get_next_line(&pos, file, size))) {
> +		list_iter = NOFAIL(malloc(sizeof(*list_iter)));
> +		list_iter->next = list_start;
> +		list_iter->livepatch_mod = NOFAIL(strdup(line));
> +		list_start = list_iter;
> +	}
> +	release_file(file, size);
> +
> +	return list_start;
> +}
> +
> +static void free_livepatch_mods(struct livepatch_mod_list *list_start)
> +{
> +	struct livepatch_mod_list *list_iter;
> +
> +	while (list_start) {
> +		list_iter = list_start->next;
> +		free(list_start->livepatch_mod);
> +		free(list_start);
> +		list_start = list_iter;
> +	}
> +}
> +
> +static int is_livepatch_mod(const char *modname,
> +		struct livepatch_mod_list *list)
> +{
> +	const char *myname;
> +
> +	if (!list)
> +		return 0;
> +
> +	myname = strrchr(modname, '/');
> +	if (myname)
> +		myname++;
> +	else
> +		myname = modname;
> +
> +	while (list) {
> +		if (!strcmp(myname, list->livepatch_mod))
> +			return 1;
> +		list = list->next;
> +	}
> +	return 0;
> +}
> +
> +static void add_livepatch_flag(struct buffer *b, struct module *mod,
> +		struct livepatch_mod_list *list)
> +{
> +	if (is_livepatch_mod(mod->name, list)) {
> +		buf_printf(b, "\nMODULE_INFO(livepatch, \"Y\");\n");
> +		mod->livepatch = 1;
> +	}
> +}
> +
> +
>  struct ext_sym_list {
>  	struct ext_sym_list *next;
>  	const char *file;
> @@ -2436,8 +2502,9 @@ int main(int argc, char **argv)
>  	int err;
>  	struct ext_sym_list *extsym_iter;
>  	struct ext_sym_list *extsym_start = NULL;
> +	struct livepatch_mod_list *livepatch_mods = NULL;
>  
> -	while ((opt = getopt(argc, argv, "i:I:e:mnsST:o:awE")) != -1) {
> +	while ((opt = getopt(argc, argv, "i:I:e:l:mnsST:o:awM:K:E")) != -1) {
>  		switch (opt) {
>  		case 'i':
>  			kernel_read = optarg;
> @@ -2454,6 +2521,9 @@ int main(int argc, char **argv)
>  			extsym_iter->file = optarg;
>  			extsym_start = extsym_iter;
>  			break;
> +		case 'l':
> +			livepatch_mods = load_livepatch_mods(optarg);
> +			break;
>  		case 'm':
>  			modversions = 1;
>  			break;
> @@ -2514,15 +2584,16 @@ int main(int argc, char **argv)
>  		buf.pos = 0;
>  
>  		err |= check_modname_len(mod);
> -		err |= check_exports(mod);
>  		add_header(&buf, mod);
>  		add_intree_flag(&buf, !external_module);
>  		add_retpoline(&buf);
>  		add_staging_flag(&buf, mod->name);
> +		add_livepatch_flag(&buf, mod, livepatch_mods);
>  		err |= add_versions(&buf, mod);
>  		add_depends(&buf, mod);
>  		add_moddevtable(&buf, mod);
>  		add_srcversion(&buf, mod);
> +		err |= check_exports(mod);
>  
>  		sprintf(fname, "%s.mod.c", mod->name);
>  		write_if_changed(&buf, fname);
> @@ -2541,6 +2612,7 @@ int main(int argc, char **argv)
>  			      "Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.\n");
>  		}
>  	}
> +	free_livepatch_mods(livepatch_mods);
>  	free(buf.p);
>  
>  	return err;
> -- 
> 2.16.4
> 

Miroslav
