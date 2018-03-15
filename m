Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751696AbeCOIvg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:51:36 -0400
Received: from exmail.andestech.com ([59.124.169.137]:39717 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbeCOIvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 04:51:33 -0400
From: Zong Li <zong@andestech.com>
To: <palmer@sifive.com>, <albert@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <zong@andestech.com>, <zongbox@gmail.com>
CC: <greentime@andestech.com>
Subject: [PATCH v2 02/11] RISC-V: Add section of GOT.PLT for kernel module
Date: Thu, 15 Mar 2018 16:50:42 +0800
Message-ID: <3190d666af9336a5cd3b5963d86b2d5f3acb2780.1521103171.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1521103167.git.zong@andestech.com>
References: <cover.1521103167.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w2F8laiX080906
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the function symbol address from .plt to .got.plt section.

The original plt entry has trampoline code with symbol address,
there is a 32-bit padding bwtween jar instruction and symbol address.

Extract the symbol address to .got.plt to reduce the module size.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/include/asm/module.h     | 40 +++++++++++++++++++++++--------------
 arch/riscv/kernel/module-sections.c | 21 +++++++++++++++++--
 arch/riscv/kernel/module.lds        |  1 +
 3 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/include/asm/module.h b/arch/riscv/include/asm/module.h
index e61d73f82d4d..349df33808c4 100644
--- a/arch/riscv/include/asm/module.h
+++ b/arch/riscv/include/asm/module.h
@@ -21,6 +21,7 @@ struct mod_section {
 struct mod_arch_specific {
 	struct mod_section got;
 	struct mod_section plt;
+	struct mod_section got_plt;
 };
 
 struct got_entry {
@@ -48,13 +49,10 @@ struct plt_entry {
 	/*
 	 * Trampoline code to real target address. The return address
 	 * should be the original (pc+4) before entring plt entry.
-	 * For 8 byte alignment of symbol_addr,
-	 * don't pack structure to remove the padding.
 	 */
 	u32 insn_auipc;		/* auipc t0, 0x0                       */
 	u32 insn_ld;		/* ld    t1, 0x10(t0)                  */
 	u32 insn_jr;		/* jr    t1                            */
-	u64 symbol_addr;	/* the real jump target address        */
 };
 
 #define OPC_AUIPC  0x0017
@@ -62,9 +60,8 @@ struct plt_entry {
 #define OPC_JALR   0x0067
 #define REG_T0     0x5
 #define REG_T1     0x6
-#define IMM_OFFSET 0x10
 
-static inline struct plt_entry emit_plt_entry(u64 val)
+static inline struct plt_entry emit_plt_entry(u64 val, u64 plt, u64 got_plt)
 {
 	/*
 	 * U-Type encoding:
@@ -78,24 +75,37 @@ static inline struct plt_entry emit_plt_entry(u64 val)
 	 * +------------+------------+--------+----------+----------+
 	 *
 	 */
+	u64 offset = got_plt - plt;
+	u32 hi20 = (offset + 0x800) & 0xfffff000;
+	u32 lo12 = (offset - hi20);
 	return (struct plt_entry) {
-		OPC_AUIPC | (REG_T0 << 7),
-		OPC_LD | (IMM_OFFSET << 20) | (REG_T0 << 15) | (REG_T1 << 7),
-		OPC_JALR | (REG_T1 << 15),
-		val
+		OPC_AUIPC | (REG_T0 << 7) | hi20,
+		OPC_LD | (lo12 << 20) | (REG_T0 << 15) | (REG_T1 << 7),
+		OPC_JALR | (REG_T1 << 15)
 	};
 }
 
-static inline struct plt_entry *get_plt_entry(u64 val,
-					      const struct mod_section *sec)
+static inline int get_got_plt_idx(u64 val, const struct mod_section *sec)
 {
-	struct plt_entry *plt = (struct plt_entry *)sec->shdr->sh_addr;
+	struct got_entry *got_plt = (struct got_entry *)sec->shdr->sh_addr;
 	int i;
 	for (i = 0; i < sec->num_entries; i++) {
-		if (plt[i].symbol_addr == val)
-			return &plt[i];
+		if (got_plt[i].symbol_addr == val)
+			return i;
 	}
-	return NULL;
+	return -1;
+}
+
+static inline struct plt_entry *get_plt_entry(u64 val,
+				      const struct mod_section *sec_plt,
+				      const struct mod_section *sec_got_plt)
+{
+	struct plt_entry *plt = (struct plt_entry *)sec_plt->shdr->sh_addr;
+	int got_plt_idx = get_got_plt_idx(val, sec_got_plt);
+	if (got_plt_idx >= 0)
+		return plt + got_plt_idx;
+	else
+		return NULL;
 }
 
 #endif /* CONFIG_MODULE_SECTIONS */
diff --git a/arch/riscv/kernel/module-sections.c b/arch/riscv/kernel/module-sections.c
index 94ba1551eac3..bbbd26e19bfd 100644
--- a/arch/riscv/kernel/module-sections.c
+++ b/arch/riscv/kernel/module-sections.c
@@ -30,18 +30,23 @@ u64 module_emit_got_entry(struct module *mod, u64 val)
 
 u64 module_emit_plt_entry(struct module *mod, u64 val)
 {
+	struct mod_section *got_plt_sec = &mod->arch.got_plt;
+	struct got_entry *got_plt;
 	struct mod_section *plt_sec = &mod->arch.plt;
-	struct plt_entry *plt = get_plt_entry(val, plt_sec);
+	struct plt_entry *plt = get_plt_entry(val, plt_sec, got_plt_sec);
 	int i = plt_sec->num_entries;
 
 	if (plt)
 		return (u64)plt;
 
 	/* There is no duplicate entry, create a new one */
+	got_plt = (struct got_entry *)got_plt_sec->shdr->sh_addr;
+	got_plt[i] = emit_got_entry(val);
 	plt = (struct plt_entry *)plt_sec->shdr->sh_addr;
-	plt[i] = emit_plt_entry(val);
+	plt[i] = emit_plt_entry(val, (u64)&plt[i], (u64)&got_plt[i]);
 
 	plt_sec->num_entries++;
+	got_plt_sec->num_entries++;
 	BUG_ON(plt_sec->num_entries > plt_sec->max_entries);
 
 	return (u64)&plt[i];
@@ -94,6 +99,8 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			mod->arch.plt.shdr = sechdrs + i;
 		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".got"))
 			mod->arch.got.shdr = sechdrs + i;
+		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".got.plt"))
+			mod->arch.got_plt.shdr = sechdrs + i;
 	}
 
 	if (!mod->arch.plt.shdr) {
@@ -104,6 +111,10 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		pr_err("%s: module GOT section(s) missing\n", mod->name);
 		return -ENOEXEC;
 	}
+	if (!mod->arch.got_plt.shdr) {
+		pr_err("%s: module GOT.PLT section(s) missing\n", mod->name);
+		return -ENOEXEC;
+	}
 
 	/* Calculate the maxinum number of entries */
 	for (i = 0; i < ehdr->e_shnum; i++) {
@@ -135,5 +146,11 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	mod->arch.got.num_entries = 0;
 	mod->arch.got.max_entries = num_gots;
 
+	mod->arch.got_plt.shdr->sh_type = SHT_NOBITS;
+	mod->arch.got_plt.shdr->sh_flags = SHF_ALLOC;
+	mod->arch.got_plt.shdr->sh_addralign = L1_CACHE_BYTES;
+	mod->arch.got_plt.shdr->sh_size = (num_plts + 1) * sizeof(struct got_entry);
+	mod->arch.got_plt.num_entries = 0;
+	mod->arch.got_plt.max_entries = num_plts;
 	return 0;
 }
diff --git a/arch/riscv/kernel/module.lds b/arch/riscv/kernel/module.lds
index 7ef580e62883..295ecfb341a2 100644
--- a/arch/riscv/kernel/module.lds
+++ b/arch/riscv/kernel/module.lds
@@ -4,4 +4,5 @@
 SECTIONS {
 	.plt (NOLOAD) : { BYTE(0) }
 	.got (NOLOAD) : { BYTE(0) }
+	.got.plt (NOLOAD) : { BYTE(0) }
 }
-- 
2.16.1
