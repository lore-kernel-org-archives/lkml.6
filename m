Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DE1C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AD020B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cRyQFI2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfAaT3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:29:30 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45166 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfAaT32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:29:28 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so1762086pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9s0Jc+lgI+C1BSYL5mSt9awnQxS0L/t2p2g0lX4vn1Q=;
        b=cRyQFI2WCS8FjD1FVnnc6pGqW7DxKqoEtMnP1mmIEFR3MaERnlX0Puu/0PhnlM+XnV
         wj1Zu9JymVQIG0BQbr/QSfDksLbnH6IbwmpUkPyB4Rr9K9zCZS+DRK1IqDVDc/dEwJvJ
         jtlmFRtnCcDFprijI1AGoinebjPLceATP7Zis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9s0Jc+lgI+C1BSYL5mSt9awnQxS0L/t2p2g0lX4vn1Q=;
        b=C2YiDI+fA7vg4vTrSEav4G//3d6wLSDAJReMbBnjAd8X1ZvmiHXFA5u28IgoNqrGXW
         zB3RzkN7TQal0yd90VFP1MersNMf0AFUodIR7u1o+ZNaEF8WuOG6EtmNWlMZzA5EQIN4
         MAVWbVNpKqoV8HGrcDvukBNjPiEn9BG8s2HJKVPGUa1+kQXEhdki4rW5Y620JcAIK361
         rH+KXXiTetBQtIgHbILoHLl4ORKkr+cm73Th5M6WXfKpjQi2J/86GChNVfO39cQqn5kV
         wZ/vthIXHAUx2PngeGRySsmz1DudcCu29+5PSCkpoJd7T+VD73Z4NCUm8EWNsIsDu8Up
         j7xQ==
X-Gm-Message-State: AJcUukfbg87P/zbwPxFV26OPwHwQK9AQQNn6SPa3IoaC5pLu8Pl7CF4e
        nbPNRjWt35qexR4ZXinZdLFjTBjRipc=
X-Google-Smtp-Source: ALg8bN7y05ZWZkA8E4kxBIiqovexlhMvMxOCDxhr2UjvxJYUcSVRfW/5iY2KzYWPpZcaTG1skj0GFQ==
X-Received: by 2002:a62:3c1:: with SMTP id 184mr36365576pfd.56.1548962967192;
        Thu, 31 Jan 2019 11:29:27 -0800 (PST)
Received: from skynet.sea.corp.google.com ([2620:15c:17:4:29de:3bb1:1270:e679])
        by smtp.gmail.com with ESMTPSA id s130sm11164399pgc.60.2019.01.31.11.29.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:29:26 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Garnier <thgarnie@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 23/27] x86/modules: Adapt module loading for PIE support
Date:   Thu, 31 Jan 2019 11:24:30 -0800
Message-Id: <20190131192533.34130-24-thgarnie@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190131192533.34130-1-thgarnie@chromium.org>
References: <20190131192533.34130-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adapt module loading to support PIE relocations. Generate dynamic GOT if
a symbol requires it but no entry exists in the kernel GOT.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 arch/x86/Makefile               |   4 +
 arch/x86/include/asm/module.h   |  11 ++
 arch/x86/include/asm/sections.h |   4 +
 arch/x86/kernel/module.c        | 181 +++++++++++++++++++++++++++++++-
 arch/x86/kernel/module.lds      |   3 +
 5 files changed, 198 insertions(+), 5 deletions(-)
 create mode 100644 arch/x86/kernel/module.lds

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 65d6d9a1dd22..5e9c1b02cf87 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -129,8 +129,12 @@ else
         KBUILD_CFLAGS += $(cflags-y)
 
         KBUILD_CFLAGS += -mno-red-zone
+ifdef CONFIG_X86_PIE
+        KBUILD_LDFLAGS_MODULE += -T $(srctree)/arch/x86/kernel/module.lds
+else
         KBUILD_CFLAGS += -mcmodel=kernel
 endif
+endif
 
 ifdef CONFIG_X86_GLOBAL_STACKPROTECTOR
         ifeq ($(call cc-option, -mstack-protector-guard=global),)
diff --git a/arch/x86/include/asm/module.h b/arch/x86/include/asm/module.h
index 7948a17febb4..68ff05e14288 100644
--- a/arch/x86/include/asm/module.h
+++ b/arch/x86/include/asm/module.h
@@ -5,12 +5,23 @@
 #include <asm-generic/module.h>
 #include <asm/orc_types.h>
 
+#ifdef CONFIG_X86_PIE
+struct mod_got_sec {
+	struct elf64_shdr	*got;
+	int			got_num_entries;
+	int			got_max_entries;
+};
+#endif
+
 struct mod_arch_specific {
 #ifdef CONFIG_UNWINDER_ORC
 	unsigned int num_orcs;
 	int *orc_unwind_ip;
 	struct orc_entry *orc_unwind;
 #endif
+#ifdef CONFIG_X86_PIE
+	struct mod_got_sec	core;
+#endif
 };
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index 8ea1cfdbeabc..d4468309d743 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -13,4 +13,8 @@ extern char __end_rodata_aligned[];
 extern char __end_rodata_hpage_align[];
 #endif
 
+#if defined(CONFIG_X86_PIE)
+extern char __start_got[], __end_got[];
+#endif
+
 #endif	/* _ASM_X86_SECTIONS_H */
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index b052e883dd8c..f0d3ed92049e 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -30,6 +30,7 @@
 #include <linux/gfp.h>
 #include <linux/jump_label.h>
 #include <linux/random.h>
+#include <linux/sort.h>
 
 #include <asm/text-patching.h>
 #include <asm/page.h>
@@ -77,6 +78,173 @@ static unsigned long int get_module_load_offset(void)
 }
 #endif
 
+#ifdef CONFIG_X86_PIE
+static u64 find_got_kernel_entry(Elf64_Sym *sym, const Elf64_Rela *rela)
+{
+	u64 *pos;
+
+	for (pos = (u64 *)__start_got; pos < (u64 *)__end_got; pos++) {
+		if (*pos == sym->st_value)
+			return (u64)pos + rela->r_addend;
+	}
+
+	return 0;
+}
+
+static u64 module_emit_got_entry(struct module *mod, void *loc,
+				 const Elf64_Rela *rela, Elf64_Sym *sym)
+{
+	struct mod_got_sec *gotsec = &mod->arch.core;
+	u64 *got = (u64 *)gotsec->got->sh_addr;
+	int i = gotsec->got_num_entries;
+	u64 ret;
+
+	/* Check if we can use the kernel GOT */
+	ret = find_got_kernel_entry(sym, rela);
+	if (ret)
+		return ret;
+
+	got[i] = sym->st_value;
+
+	/*
+	 * Check if the entry we just created is a duplicate. Given that the
+	 * relocations are sorted, this will be the last entry we allocated.
+	 * (if one exists).
+	 */
+	if (i > 0 && got[i] == got[i - 2]) {
+		ret = (u64)&got[i - 1];
+	} else {
+		gotsec->got_num_entries++;
+		BUG_ON(gotsec->got_num_entries > gotsec->got_max_entries);
+		ret = (u64)&got[i];
+	}
+
+	return ret + rela->r_addend;
+}
+
+#define cmp_3way(a, b)	((a) < (b) ? -1 : (a) > (b))
+
+static int cmp_rela(const void *a, const void *b)
+{
+	const Elf64_Rela *x = a, *y = b;
+	int i;
+
+	/* sort by type, symbol index and addend */
+	i = cmp_3way(ELF64_R_TYPE(x->r_info), ELF64_R_TYPE(y->r_info));
+	if (i == 0)
+		i = cmp_3way(ELF64_R_SYM(x->r_info), ELF64_R_SYM(y->r_info));
+	if (i == 0)
+		i = cmp_3way(x->r_addend, y->r_addend);
+	return i;
+}
+
+static bool duplicate_rel(const Elf64_Rela *rela, int num)
+{
+	/*
+	 * Entries are sorted by type, symbol index and addend. That means
+	 * that, if a duplicate entry exists, it must be in the preceding
+	 * slot.
+	 */
+	return num > 0 && cmp_rela(rela + num, rela + num - 1) == 0;
+}
+
+static unsigned int count_gots(Elf64_Sym *syms, Elf64_Rela *rela, int num)
+{
+	unsigned int ret = 0;
+	Elf64_Sym *s;
+	int i;
+
+	for (i = 0; i < num; i++) {
+		switch (ELF64_R_TYPE(rela[i].r_info)) {
+		case R_X86_64_GOTPCREL:
+			s = syms + ELF64_R_SYM(rela[i].r_info);
+
+			/*
+			 * Use the kernel GOT when possible, else reserve a
+			 * custom one for this module.
+			 */
+			if (!duplicate_rel(rela, i) &&
+			    !find_got_kernel_entry(s, rela + i))
+				ret++;
+			break;
+		}
+	}
+	return ret;
+}
+
+/*
+ * Generate GOT entries for GOTPCREL relocations that do not exists in the
+ * kernel GOT. Based on arm64 module-plts implementation.
+ */
+int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
+			      char *secstrings, struct module *mod)
+{
+	unsigned long gots = 0;
+	Elf_Shdr *symtab = NULL;
+	Elf64_Sym *syms = NULL;
+	char *strings, *name;
+	int i;
+
+	/*
+	 * Find the empty .got section so we can expand it to store the PLT
+	 * entries. Record the symtab address as well.
+	 */
+	for (i = 0; i < ehdr->e_shnum; i++) {
+		if (!strcmp(secstrings + sechdrs[i].sh_name, ".got")) {
+			mod->arch.core.got = sechdrs + i;
+		} else if (sechdrs[i].sh_type == SHT_SYMTAB) {
+			symtab = sechdrs + i;
+			syms = (Elf64_Sym *)symtab->sh_addr;
+		}
+	}
+
+	if (!mod->arch.core.got) {
+		pr_err("%s: module GOT section missing\n", mod->name);
+		return -ENOEXEC;
+	}
+	if (!syms) {
+		pr_err("%s: module symtab section missing\n", mod->name);
+		return -ENOEXEC;
+	}
+
+	for (i = 0; i < ehdr->e_shnum; i++) {
+		Elf64_Rela *rels = (void *)ehdr + sechdrs[i].sh_offset;
+		int numrels = sechdrs[i].sh_size / sizeof(Elf64_Rela);
+
+		if (sechdrs[i].sh_type != SHT_RELA)
+			continue;
+
+		/* sort by type, symbol index and addend */
+		sort(rels, numrels, sizeof(Elf64_Rela), cmp_rela, NULL);
+
+		gots += count_gots(syms, rels, numrels);
+	}
+
+	mod->arch.core.got->sh_type = SHT_NOBITS;
+	mod->arch.core.got->sh_flags = SHF_ALLOC;
+	mod->arch.core.got->sh_addralign = L1_CACHE_BYTES;
+	mod->arch.core.got->sh_size = (gots + 1) * sizeof(u64);
+	mod->arch.core.got_num_entries = 0;
+	mod->arch.core.got_max_entries = gots;
+
+	/*
+	 * If a _GLOBAL_OFFSET_TABLE_ symbol exists, make it absolute for
+	 * modules to correctly reference it. Similar to s390 implementation.
+	 */
+	strings = (void *) ehdr + sechdrs[symtab->sh_link].sh_offset;
+	for (i = 0; i < symtab->sh_size/sizeof(Elf_Sym); i++) {
+		if (syms[i].st_shndx != SHN_UNDEF)
+			continue;
+		name = strings + syms[i].st_name;
+		if (!strcmp(name, "_GLOBAL_OFFSET_TABLE_")) {
+			syms[i].st_shndx = SHN_ABS;
+			break;
+		}
+	}
+	return 0;
+}
+#endif
+
 void *module_alloc(unsigned long size)
 {
 	void *p;
@@ -190,16 +358,20 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 			if ((s64)val != *(s32 *)loc)
 				goto overflow;
 			break;
+#ifdef CONFIG_X86_PIE
+		case R_X86_64_GOTPCREL:
+			val = module_emit_got_entry(me, loc, rel + i, sym);
+			/* fallthrough */
+#endif
 		case R_X86_64_PC32:
 		case R_X86_64_PLT32:
 			if (*(u32 *)loc != 0)
 				goto invalid_relocation;
 			val -= (u64)loc;
 			*(u32 *)loc = val;
-#if 0
-			if ((s64)val != *(s32 *)loc)
+			if (IS_ENABLED(CONFIG_X86_PIE) &&
+			    (s64)val != *(s32 *)loc)
 				goto overflow;
-#endif
 			break;
 		case R_X86_64_PC64:
 			if (*(u64 *)loc != 0)
@@ -223,8 +395,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 overflow:
 	pr_err("overflow in relocation type %d val %Lx\n",
 	       (int)ELF64_R_TYPE(rel[i].r_info), val);
-	pr_err("`%s' likely not compiled with -mcmodel=kernel\n",
-	       me->name);
+	pr_err("`%s' likely too far from the kernel\n", me->name);
 	return -ENOEXEC;
 }
 #endif
diff --git a/arch/x86/kernel/module.lds b/arch/x86/kernel/module.lds
new file mode 100644
index 000000000000..fd6e95a4b454
--- /dev/null
+++ b/arch/x86/kernel/module.lds
@@ -0,0 +1,3 @@
+SECTIONS {
+	.got (NOLOAD) : { BYTE(0) }
+}
-- 
2.20.1.495.gaa96b0ce6b-goog

