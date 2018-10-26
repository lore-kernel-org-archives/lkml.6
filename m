Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEA3ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B127420873
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VubXXLQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B127420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeJ0CC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:02:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbeJ0CC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:02:57 -0400
Received: from linux-8ccs (ip5f5adbd5.dynamic.kabel-deutschland.de [95.90.219.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D9FD20834;
        Fri, 26 Oct 2018 17:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540574706;
        bh=NH/jFtg26Sqvz1Ye0YcXn8c+VYgyXxrNMpkdpPRD/tU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VubXXLQV6Qw/naseomYCeO/7QcR8M9aGkkvS1iJHHcichAURJEazVkL+HVydcsvKx
         ZNNR4XaypjvVLFJAurfv6qedrEDkOn1N8J8rNf5IR7FxombDOFjJU15NvV8SrBSoFT
         xpE+/0oa2prf+KZfD+1aQJ4JZ8m92X4PtawWUZ7M=
Date:   Fri, 26 Oct 2018 19:25:01 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Torsten Duwe <duwe@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
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
Subject: [PATCH v2] arm64/module: use mod->klp_info section header
 information for livepatch modules
Message-ID: <20181026172500.g65bl2p7cvey3qsx@linux-8ccs>
References: <20181001140910.086E768BC7@newverein.lst.de>
 <20181001141652.5478C68BE1@newverein.lst.de>
 <20181023175553.gaobskk26koft6s2@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181023175553.gaobskk26koft6s2@linux-8ccs>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.16-default x86_64
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 module loader keeps a pointer into info->sechdrs to keep track
of section header information for .plt section(s). A pointer to the
relevent section header (struct elf64_shdr) in info->sechdrs is stored
in mod->arch.{init,core}.plt. This pointer may be accessed while
applying relocations in apply_relocate_add() for example. And unlike
normal modules, livepatch modules can call apply_relocate_add() after
module load. But the info struct (and therefore info->sechdrs) gets
freed at the end of load_module() and so mod->arch.{init,core}.plt
becomes an invalid pointer after the module is done loading.

Luckily, livepatch modules already keep a copy of Elf section header
information in mod->klp_info. So make sure livepatch modules on arm64
have access to the section headers in klp_info and set
mod->arch.{init,core}.plt to the appropriate section header in
mod->klp_info so that they can call apply_relocate_add() even after
module load.

Signed-off-by: Jessica Yu <jeyu@kernel.org>
---

v2:
  - fix missing free_module_elf() in error path
  - move copy_module_elf() and module_finalize() out of post_relocation()
    to make error handling more clear
  - add braces to if-else block in arm64 module_frob_arch_sections()

 arch/arm64/include/asm/module.h |  1 +
 arch/arm64/kernel/module-plts.c | 17 ++++++++++++-----
 arch/arm64/kernel/module.c      | 10 ++++++++++
 kernel/module.c                 | 29 +++++++++++++++--------------
 4 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index fef773c94e9d..ac9b97f9ae5e 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -25,6 +25,7 @@ struct mod_plt_sec {
 	struct elf64_shdr	*plt;
 	int			plt_num_entries;
 	int			plt_max_entries;
+	int			plt_shndx;
 };
 
 struct mod_arch_specific {
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index f0690c2ca3e0..851311ffd427 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -210,16 +210,23 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	 * entries. Record the symtab address as well.
 	 */
 	for (i = 0; i < ehdr->e_shnum; i++) {
-		if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt"))
+		if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt")) {
 			mod->arch.core.plt = sechdrs + i;
-		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".init.plt"))
+			/*
+			 * Keep the section index for the .plt section for
+			 * livepatching. Note that .init.plt is irrelevant to
+			 * livepatch, so only the shndx for .plt is saved.
+			 */
+			mod->arch.core.plt_shndx = i;
+		} else if (!strcmp(secstrings + sechdrs[i].sh_name, ".init.plt")) {
 			mod->arch.init.plt = sechdrs + i;
-		else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
+		} else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
 			 !strcmp(secstrings + sechdrs[i].sh_name,
-				 ".text.ftrace_trampoline"))
+				 ".text.ftrace_trampoline")) {
 			tramp = sechdrs + i;
-		else if (sechdrs[i].sh_type == SHT_SYMTAB)
+		} else if (sechdrs[i].sh_type == SHT_SYMTAB) {
 			syms = (Elf64_Sym *)sechdrs[i].sh_addr;
+		}
 	}
 
 	if (!mod->arch.core.plt || !mod->arch.init.plt) {
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index dd23655fda3a..490e56070a7e 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -461,5 +461,15 @@ int module_finalize(const Elf_Ehdr *hdr,
 #endif
 	}
 
+#ifdef CONFIG_LIVEPATCH
+	/*
+	 * For livepatching, switch to the saved section header info for .plt
+	 * stored in mod->klp_info. This is needed so that livepatch is able to
+	 * call apply_relocate_add() after patch module load.
+	 */
+	if (is_livepatch_module(me))
+		me->arch.core.plt = me->klp_info->sechdrs + me->arch.core.plt_shndx;
+#endif
+
 	return 0;
 }
diff --git a/kernel/module.c b/kernel/module.c
index f475f30eed8c..611f4fe64370 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3365,7 +3365,7 @@ int __weak module_finalize(const Elf_Ehdr *hdr,
 	return 0;
 }
 
-static int post_relocation(struct module *mod, const struct load_info *info)
+static void post_relocation(struct module *mod, const struct load_info *info)
 {
 	/* Sort exception table now relocations are done. */
 	sort_extable(mod->extable, mod->extable + mod->num_exentries);
@@ -3376,9 +3376,6 @@ static int post_relocation(struct module *mod, const struct load_info *info)
 
 	/* Setup kallsyms-specific fields. */
 	add_kallsyms(mod, info);
-
-	/* Arch-specific module finalizing. */
-	return module_finalize(info->hdr, info->sechdrs, mod);
 }
 
 /* Is this module of this name done loading?  No locks held. */
@@ -3726,9 +3723,18 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	if (err < 0)
 		goto free_modinfo;
 
-	err = post_relocation(mod, info);
+	post_relocation(mod, info);
+
+	if (is_livepatch_module(mod)) {
+		err = copy_module_elf(mod, info);
+		if (err < 0)
+			goto free_modinfo;
+	}
+
+	/* Arch-specific module finalizing. */
+	err = module_finalize(info->hdr, info->sechdrs, mod);
 	if (err < 0)
-		goto free_modinfo;
+		goto free_module_elf;
 
 	flush_module_icache(mod);
 
@@ -3770,12 +3776,6 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	if (err < 0)
 		goto coming_cleanup;
 
-	if (is_livepatch_module(mod)) {
-		err = copy_module_elf(mod, info);
-		if (err < 0)
-			goto sysfs_cleanup;
-	}
-
 	/* Get rid of temporary copy. */
 	free_copy(info);
 
@@ -3784,8 +3784,6 @@ static int load_module(struct load_info *info, const char __user *uargs,
 
 	return do_init_module(mod);
 
- sysfs_cleanup:
-	mod_sysfs_teardown(mod);
  coming_cleanup:
 	mod->state = MODULE_STATE_GOING;
 	destroy_params(mod->kp, mod->num_kp);
@@ -3809,6 +3807,9 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	kfree(mod->args);
  free_arch_cleanup:
 	module_arch_cleanup(mod);
+ free_module_elf:
+	if (is_livepatch_module(mod))
+		free_module_elf(mod);
  free_modinfo:
 	free_modinfo(mod);
  free_unload:
-- 
2.16.4

