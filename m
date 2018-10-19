Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFB5ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C418214C2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C418214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeJSUEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:04:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:39698 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727170AbeJSUEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:04:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E50F4AE10;
        Fri, 19 Oct 2018 11:59:02 +0000 (UTC)
Date:   Fri, 19 Oct 2018 13:59:01 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Jessica Yu <jeyu@kernel.org>
cc:     Torsten Duwe <duwe@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v3 3/4] arm64: implement live patching
In-Reply-To: <20181018125820.iw54zbirq74ulknj@linux-8ccs>
Message-ID: <alpine.LSU.2.21.1810191338020.4692@pobox.suse.cz>
References: <20181001140910.086E768BC7@newverein.lst.de> <20181001141652.5478C68BE1@newverein.lst.de> <alpine.LSU.2.21.1810171051560.21847@pobox.suse.cz> <20181018125820.iw54zbirq74ulknj@linux-8ccs>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018, Jessica Yu wrote:

> +++ Miroslav Benes [17/10/18 15:39 +0200]:
> >On Mon, 1 Oct 2018, Torsten Duwe wrote:
> >
> >Ad relocations. I checked that everything in struct mod_arch_specific
> >stays after the module is load. Both core and init get SHF_ALLOC set
> >(mod->arch.core.plt->sh_flags in module_frob_arch_sections(). It is
> >important because apply_relocate_add() may use those sections
> >through module_emit_plt_entry() call.
> 
> Yes, it looks like the needed .plt sections will remain in module
> memory. However, I think I found a slight issue... :/
> 
> In module_frob_arch_sections(), mod->arch.core.plt is set to an offset
> within info->sechdrs:
> 
>             if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt"))
>                     mod->arch.core.plt = sechdrs + i;
> 
> sechdrs is from info->sechdrs, which is freed at the end of
> load_module() via free_copy(). So although the relevant plt section(s)
> are in module memory, mod->arch.core.plt will point to invalid memory
> after info is freed. In other words, the section (.plt) *is* in memory
> but the section header (struct elf64_shdr) containing section metadata
> like sh_addr, sh_size etc., is not.
> 
> But we have mod->klp_info->sechdrs (which is a copy of the section
> headers) for this very reason. It is initialized only at the very end
> of load_module(). I don't think copy_module_elf() is dependent on
> anything, so it can just be moved earlier.
> 
> Note that we cannot set mod->arch.core.plt to mod->klp_info->sechdrs + i
> during module_frob_arch_sections() because it is still too early, none
> of the module sections have been copied and none of their sh_addr's
> have been set to their final locations as this is all happening before
> move_module() is called. So we can use a module_finalize() function
> for arm64 to switch the mod->arch.core.plt to use the klp_info section
> headers.

Thanks for the analysis. You seem to be right.
 
> Maybe this will be more clear in the example fix below (completely
> untested and unreviewed!):
> 
> diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
> index 97d0ef12e2ff..150afc29171b 100644
> --- a/arch/arm64/include/asm/module.h
> +++ b/arch/arm64/include/asm/module.h
> @@ -25,6 +25,7 @@ struct mod_plt_sec {
> 	struct elf64_shdr	*plt;
> 	int			plt_num_entries;
> 	int			plt_max_entries;
> +	int			plt_shndx;
> };
> 
> struct mod_arch_specific {
> diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
> index f0690c2ca3e0..c23cef8f0165 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -196,6 +196,21 @@ static unsigned int count_plts(Elf64_Sym *syms,
> Elf64_Rela *rela, int num,
> 	return ret;
> }
> 
> +int module_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
> +		    struct module *mod)
> +{
> +	/*
> +	 * Livepatch modules need to keep access to section headers to apply
> +	 * relocations. Note mod->klp_info should have already been
> initialized
> +	 * and all section sh_addr's should have their final addresses by the
> +	 * time module_finalize() is called.
> +	 */
> +	if (is_livepatch_module(mod))
> +		mod->arch.core.plt = mod->klp_info->sechdrs +
> mod->arch.core.plt_shndx;
> +
> +	return 0;
> +}

There is already module_finalize() in arch/arm64/kernel/module.c, so this 
should probably go there.

If I am not mistaken, we do not care for arch.init.plt in livepatch. Is 
that correct?

> int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
> 			      char *secstrings, struct module *mod)
> {
> @@ -210,11 +225,13 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr
> *sechdrs,
> 	 * entries. Record the symtab address as well.
> 	 */
> 	for (i = 0; i < ehdr->e_shnum; i++) {
> -		if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt"))
> +		if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt")) {
> 			mod->arch.core.plt = sechdrs + i;
> -		else if (!strcmp(secstrings + sechdrs[i].sh_name,
> ".init.plt"))
> +			mod->arch.core.plt_shndx = i;
> +		} else if (!strcmp(secstrings + sechdrs[i].sh_name,
> ".init.plt")) {
> 			mod->arch.init.plt = sechdrs + i;
> -		else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
> +			mod->arch.init.plt_shndx = i;

It is initialized here, but that's not necessarily a bad thing.

> +		} else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
> 			 !strcmp(secstrings + sechdrs[i].sh_name,
> 				 ".text.ftrace_trampoline"))
> 			tramp = sechdrs + i;
> diff --git a/kernel/module.c b/kernel/module.c
> index 6746c85511fe..2fc4d74288dd 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3363,6 +3363,12 @@ static int post_relocation(struct module *mod, const
> struct load_info *info)
> 	/* Setup kallsyms-specific fields. */
> 	add_kallsyms(mod, info);
> 
> +	if (is_livepatch_module(mod)) {
> +		err = copy_module_elf(mod, info);
> +		if (err < 0)
> +			return err;
> +	}
> +
> 	/* Arch-specific module finalizing. */
> 	return module_finalize(info->hdr, info->sechdrs, mod);
> }
> @@ -3775,12 +3781,6 @@ static int load_module(struct load_info *info, const
> char __user *uargs,
> 	if (err < 0)
> 		goto coming_cleanup;
> 
> -	if (is_livepatch_module(mod)) {
> -		err = copy_module_elf(mod, info);
> -		if (err < 0)
> -			goto sysfs_cleanup;
> -	}
> -
> 	/* Get rid of temporary copy. */
> 	free_copy(info);

Hm, this is hopefully all right. We'd need to change the error handling a 
bit. free_module_elf() is now called in free_module() and it should be 
moved somewhere to load_module(). Probably under free_arch_cleanup label. 
Although it would be much better to rework post_relocation() and handle it 
right there.

Something like

-	return module_finalize(info->hdr, info->sechdrs, mod);
+	err = module_finalize(info->hdr, info->sechdrs, mod);
+	if (err < 0)
+		free_module_elf();
+
+	return err;

> Thoughts? Does the fix make sense?

I think so.

> >The last thing is count_plts() function called from
> >module_frob_arch_sections(). It needed to be changed in 2016 as well. See
> >Jessica's patch
> >(20160713001113.GA30925@packer-debian-8-amd64.digitalocean.com). The logic
> >in the function has changed since then. If I am not mistaken,
> >count_plts() is fine as it is right now. It does not consider SHN_UNDEF
> >anymore, it looks at the destination section (where a symbol should
> >resolved to) only.
> >
> >Jessica, could you doublecheck, please?
> 
> Yes, I think count_plts() is fine now in this case (because it is
> always true that sym->st_shndx != dstidx for SHN_LIVEPATCH symbols)
> and my old patch from 2016 is no longer needed.

Thanks a lot, Jessica.

Torsten, could you include the outcome to your patch set once we settle on 
it? Thanks.

Miroslav
