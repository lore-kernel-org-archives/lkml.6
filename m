Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90318C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB0520831
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xYN0UYZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB0520831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeJ3WMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:12:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727760AbeJ3WMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:12:46 -0400
Received: from linux-8ccs (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7478F2081B;
        Tue, 30 Oct 2018 13:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540905560;
        bh=UzB9Zr5mOesOH5mKle2Hz2f73q4rsDoTZSW3Bu/4vWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xYN0UYZF7ttUskG+7bv43hhr0fQxy5EkBdI7nJdExZCggS47LaLvCqgmjDA5WjSjJ
         VLVh3HnTMCBN0UFXLSnz/tZvUUnoX4a/Geiy5sIk+xBQRKbTv6liICrUBQysUbj7a0
         oG4NGKFIg3jsLa6s2w3WadIb096XvrVhjixB5jWM=
Date:   Tue, 30 Oct 2018 14:19:10 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Torsten Duwe <duwe@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v2] arm64/module: use mod->klp_info section header
 information for livepatch modules
Message-ID: <20181030131910.zuqw523rq4pi7apb@linux-8ccs>
References: <20181001140910.086E768BC7@newverein.lst.de>
 <20181001141652.5478C68BE1@newverein.lst.de>
 <20181023175553.gaobskk26koft6s2@linux-8ccs>
 <20181026172500.g65bl2p7cvey3qsx@linux-8ccs>
 <20181029152834.GA16289@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181029152834.GA16289@arm.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.16-default x86_64
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Will Deacon [29/10/18 15:28 +0000]:
>Hi Jessica,
>
>On Fri, Oct 26, 2018 at 07:25:01PM +0200, Jessica Yu wrote:
>> The arm64 module loader keeps a pointer into info->sechdrs to keep track
>> of section header information for .plt section(s). A pointer to the
>> relevent section header (struct elf64_shdr) in info->sechdrs is stored
>> in mod->arch.{init,core}.plt. This pointer may be accessed while
>> applying relocations in apply_relocate_add() for example. And unlike
>> normal modules, livepatch modules can call apply_relocate_add() after
>> module load. But the info struct (and therefore info->sechdrs) gets
>> freed at the end of load_module() and so mod->arch.{init,core}.plt
>> becomes an invalid pointer after the module is done loading.
>>
>> Luckily, livepatch modules already keep a copy of Elf section header
>> information in mod->klp_info. So make sure livepatch modules on arm64
>> have access to the section headers in klp_info and set
>> mod->arch.{init,core}.plt to the appropriate section header in
>> mod->klp_info so that they can call apply_relocate_add() even after
>> module load.
>>
>> Signed-off-by: Jessica Yu <jeyu@kernel.org>
>> ---
>>
>> v2:
>>  - fix missing free_module_elf() in error path
>>  - move copy_module_elf() and module_finalize() out of post_relocation()
>>    to make error handling more clear
>>  - add braces to if-else block in arm64 module_frob_arch_sections()
>>
>> arch/arm64/include/asm/module.h |  1 +
>> arch/arm64/kernel/module-plts.c | 17 ++++++++++++-----
>> arch/arm64/kernel/module.c      | 10 ++++++++++
>> kernel/module.c                 | 29 +++++++++++++++--------------
>> 4 files changed, 38 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
>> index fef773c94e9d..ac9b97f9ae5e 100644
>> --- a/arch/arm64/include/asm/module.h
>> +++ b/arch/arm64/include/asm/module.h
>> @@ -25,6 +25,7 @@ struct mod_plt_sec {
>> 	struct elf64_shdr	*plt;
>> 	int			plt_num_entries;
>> 	int			plt_max_entries;
>> +	int			plt_shndx;
>> };
>
>Does this mean we can drop the plt pointer from this struct altogether, and
>simply offset into the section headers when applying the relocations?

Hmm, if everyone is OK with dropping the plt pointer from struct
mod_plt_sec, then I think we can simplify this patch even further.

With the plt shndx saved, we can additionally pass a pointer to
sechdrs to module_emit_plt_entry(), and with that just offset into the
section headers as you suggest. Since livepatch *already* passes in
the correct copy of the section headers (mod->klp_info->sechdrs) to
apply_relocate_add(), we wouldn't even need to modify the arm64
module_finalize() to change mod->arch.core.plt to point into
mod->klp_info->sechdrs anymore and we can drop all the changes to the
module loader too.

Something like the following maybe?

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index fef773c94e9d..ac10fa066487 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -22,7 +22,7 @@
 
 #ifdef CONFIG_ARM64_MODULE_PLTS
 struct mod_plt_sec {
-	struct elf64_shdr	*plt;
+	int			plt_shndx;
 	int			plt_num_entries;
 	int			plt_max_entries;
 };
@@ -37,10 +37,12 @@ struct mod_arch_specific {
 };
 #endif
 
-u64 module_emit_plt_entry(struct module *mod, void *loc, const Elf64_Rela *rela,
+u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
+			  void *loc, const Elf64_Rela *rela,
 			  Elf64_Sym *sym);
 
-u64 module_emit_veneer_for_adrp(struct module *mod, void *loc, u64 val);
+u64 module_emit_veneer_for_adrp(struct module *mod, Elf64_Shdr *sechdrs,
+				void *loc, u64 val);
 
 #ifdef CONFIG_RANDOMIZE_BASE
 extern u64 module_alloc_base;
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index f0690c2ca3e0..3cd744a1cbc2 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -16,13 +16,15 @@ static bool in_init(const struct module *mod, void *loc)
 	return (u64)loc - (u64)mod->init_layout.base < mod->init_layout.size;
 }
 
-u64 module_emit_plt_entry(struct module *mod, void *loc, const Elf64_Rela *rela,
+u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
+			  void *loc, const Elf64_Rela *rela,
 			  Elf64_Sym *sym)
 {
-	struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
-							  &mod->arch.init;
-	struct plt_entry *plt = (struct plt_entry *)pltsec->plt->sh_addr;
-	int i = pltsec->plt_num_entries;
+	struct mod_plt_sec *plt_info = !in_init(mod, loc) ? &mod->arch.core :
+							    &mod->arch.init;
+	Elf64_Shdr *pltsec = sechdrs + plt_info->plt_shndx;
+	struct plt_entry *plt = (struct plt_entry *)pltsec->sh_addr;
+	int i = plt_info->plt_num_entries;
 	u64 val = sym->st_value + rela->r_addend;
 
 	plt[i] = get_plt_entry(val);
@@ -35,24 +37,26 @@ u64 module_emit_plt_entry(struct module *mod, void *loc, const Elf64_Rela *rela,
 	if (i > 0 && plt_entries_equal(plt + i, plt + i - 1))
 		return (u64)&plt[i - 1];
 
-	pltsec->plt_num_entries++;
-	if (WARN_ON(pltsec->plt_num_entries > pltsec->plt_max_entries))
+	plt_info->plt_num_entries++;
+	if (WARN_ON(plt_info->plt_num_entries > plt_info->plt_max_entries))
 		return 0;
 
 	return (u64)&plt[i];
 }
 
 #ifdef CONFIG_ARM64_ERRATUM_843419
-u64 module_emit_veneer_for_adrp(struct module *mod, void *loc, u64 val)
+u64 module_emit_veneer_for_adrp(struct module *mod, Elf64_Shdr *sechdrs,
+				void *loc, u64 val)
 {
-	struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
-							  &mod->arch.init;
-	struct plt_entry *plt = (struct plt_entry *)pltsec->plt->sh_addr;
-	int i = pltsec->plt_num_entries++;
+	struct mod_plt_sec *plt_info = !in_init(mod, loc) ? &mod->arch.core :
+							    &mod->arch.init;
+	Elf64_Shdr *pltsec = sechdrs + plt_info->plt_shndx;
+	struct plt_entry *plt = (struct plt_entry *)pltsec->sh_addr;
+	int i = plt_info->plt_num_entries++;
 	u32 mov0, mov1, mov2, br;
 	int rd;
 
-	if (WARN_ON(pltsec->plt_num_entries > pltsec->plt_max_entries))
+	if (WARN_ON(plt_info->plt_num_entries > plt_info->plt_max_entries))
 		return 0;
 
 	/* get the destination register of the ADRP instruction */
@@ -202,7 +206,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	unsigned long core_plts = 0;
 	unsigned long init_plts = 0;
 	Elf64_Sym *syms = NULL;
-	Elf_Shdr *tramp = NULL;
+	Elf_Shdr *pltsec, *tramp = NULL;
 	int i;
 
 	/*
@@ -211,9 +215,9 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	 */
 	for (i = 0; i < ehdr->e_shnum; i++) {
 		if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt"))
-			mod->arch.core.plt = sechdrs + i;
+			mod->arch.core.plt_shndx = i;
 		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".init.plt"))
-			mod->arch.init.plt = sechdrs + i;
+			mod->arch.init.plt_shndx = i;
 		else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
 			 !strcmp(secstrings + sechdrs[i].sh_name,
 				 ".text.ftrace_trampoline"))
@@ -222,7 +226,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			syms = (Elf64_Sym *)sechdrs[i].sh_addr;
 	}
 
-	if (!mod->arch.core.plt || !mod->arch.init.plt) {
+	if (!mod->arch.core.plt_shndx || !mod->arch.init.plt_shndx) {
 		pr_err("%s: module PLT section(s) missing\n", mod->name);
 		return -ENOEXEC;
 	}
@@ -254,17 +258,19 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 						sechdrs[i].sh_info, dstsec);
 	}
 
-	mod->arch.core.plt->sh_type = SHT_NOBITS;
-	mod->arch.core.plt->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
-	mod->arch.core.plt->sh_addralign = L1_CACHE_BYTES;
-	mod->arch.core.plt->sh_size = (core_plts  + 1) * sizeof(struct plt_entry);
+	pltsec = sechdrs + mod->arch.core.plt_shndx;
+	pltsec->sh_type = SHT_NOBITS;
+	pltsec->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
+	pltsec->sh_addralign = L1_CACHE_BYTES;
+	pltsec->sh_size = (core_plts  + 1) * sizeof(struct plt_entry);
 	mod->arch.core.plt_num_entries = 0;
 	mod->arch.core.plt_max_entries = core_plts;
 
-	mod->arch.init.plt->sh_type = SHT_NOBITS;
-	mod->arch.init.plt->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
-	mod->arch.init.plt->sh_addralign = L1_CACHE_BYTES;
-	mod->arch.init.plt->sh_size = (init_plts + 1) * sizeof(struct plt_entry);
+	pltsec = sechdrs + mod->arch.init.plt_shndx;
+	pltsec->sh_type = SHT_NOBITS;
+	pltsec->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
+	pltsec->sh_addralign = L1_CACHE_BYTES;
+	pltsec->sh_size = (init_plts + 1) * sizeof(struct plt_entry);
 	mod->arch.init.plt_num_entries = 0;
 	mod->arch.init.plt_max_entries = init_plts;
 
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index dd23655fda3a..8e6444db2d8e 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -198,7 +198,8 @@ static int reloc_insn_imm(enum aarch64_reloc_op op, __le32 *place, u64 val,
 	return 0;
 }
 
-static int reloc_insn_adrp(struct module *mod, __le32 *place, u64 val)
+static int reloc_insn_adrp(struct module *mod, Elf64_Shdr *sechdrs,
+			   __le32 *place, u64 val)
 {
 	u32 insn;
 
@@ -215,7 +216,7 @@ static int reloc_insn_adrp(struct module *mod, __le32 *place, u64 val)
 		insn &= ~BIT(31);
 	} else {
 		/* out of range for ADR -> emit a veneer */
-		val = module_emit_veneer_for_adrp(mod, place, val & ~0xfff);
+		val = module_emit_veneer_for_adrp(mod, sechdrs, place, val & ~0xfff);
 		if (!val)
 			return -ENOEXEC;
 		insn = aarch64_insn_gen_branch_imm((u64)place, val,
@@ -368,7 +369,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 		case R_AARCH64_ADR_PREL_PG_HI21_NC:
 			overflow_check = false;
 		case R_AARCH64_ADR_PREL_PG_HI21:
-			ovf = reloc_insn_adrp(me, loc, val);
+			ovf = reloc_insn_adrp(me, sechdrs, loc, val);
 			if (ovf && ovf != -ERANGE)
 				return ovf;
 			break;
@@ -413,7 +414,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 
 			if (IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
 			    ovf == -ERANGE) {
-				val = module_emit_plt_entry(me, loc, &rel[i], sym);
+				val = module_emit_plt_entry(me, sechdrs, loc, &rel[i], sym);
 				if (!val)
 					return -ENOEXEC;
 				ovf = reloc_insn_imm(RELOC_OP_PREL, loc, val, 2,

Perhaps this approach is better. Miroslav and Petr, do you think this
would work? (Apologies for the efforts to review the last two
versions, if we end up scrapping the old patch :-/)

Thanks,

Jessica
