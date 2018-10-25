Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D53DC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB936205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 08:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB936205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbeJYQj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:39:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:34930 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726797AbeJYQj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:39:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CE4C6AFAE;
        Thu, 25 Oct 2018 08:08:17 +0000 (UTC)
Date:   Thu, 25 Oct 2018 10:08:16 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Torsten Duwe <duwe@lst.de>, Will Deacon <will.deacon@arm.com>,
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
Subject: Re: [PATCH] arm64/module: use mod->klp_info section header
 information
Message-ID: <20181025080816.525dppcfrrevf6jc@pathway.suse.cz>
References: <20181001140910.086E768BC7@newverein.lst.de>
 <20181001141652.5478C68BE1@newverein.lst.de>
 <20181023175553.gaobskk26koft6s2@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023175553.gaobskk26koft6s2@linux-8ccs>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-10-23 19:55:54, Jessica Yu wrote:
> The arm64 module loader keeps a pointer into info->sechdrs to keep track
> of section header information for .plt section(s). A pointer to the
> relevent section header (struct elf64_shdr) in info->sechdrs is stored
> in mod->arch.{init,core}.plt. This pointer may be accessed while
> applying relocations in apply_relocate_add() for example. And unlike
> normal modules, livepatch modules can call apply_relocate_add() after
> module load. But the info struct (and therefore info->sechdrs) gets
> freed at the end of load_module() and so mod->arch.{init,core}.plt
> becomes an invalid pointer after the module is done loading.
> 
> Luckily, livepatch modules already keep a copy of Elf section header
> information in mod->klp_info. So make sure livepatch modules on arm64
> have access to the section headers in klp_info and set
> mod->arch.{init,core}.plt to the appropriate section header in
> mod->klp_info so that they can call apply_relocate_add() even after
> module load.
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index f475f30eed8c..f3ac04cc9fc3 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3367,6 +3367,8 @@ int __weak module_finalize(const Elf_Ehdr *hdr,
> 
> static int post_relocation(struct module *mod, const struct load_info *info)
> {
> +	int err;
> +
> 	/* Sort exception table now relocations are done. */
> 	sort_extable(mod->extable, mod->extable + mod->num_exentries);
> 
> @@ -3377,8 +3379,18 @@ static int post_relocation(struct module *mod, const struct load_info *info)
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
> -	return module_finalize(info->hdr, info->sechdrs, mod);
> +	err = module_finalize(info->hdr, info->sechdrs, mod);
> +	if (err < 0)

	if (err < 0 && is_livepatch_module(mod))

> +		free_module_elf(mod);
> +
> +	return err;
> }

Also we need to free the copied stuff in load_module() when
anything called after post_relocation() fails. I think
that the following would work:

--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3823,6 +3823,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	kfree(mod->args);
  free_arch_cleanup:
 	module_arch_cleanup(mod);
+	if (is_livepatch_module(mod))
+		free_module_elf(mod);
  free_modinfo:
 	free_modinfo(mod);
  free_unload:


But I suggest to just move copy_module_elf() up and keep
calling it from load_module() directly. It would make
the error handling more clear.

Best Regards,
Petr
