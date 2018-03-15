Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeCOIz2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:55:28 -0400
Received: from exmail.andestech.com ([59.124.169.137]:56469 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbeCOIvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 04:51:33 -0400
From: Zong Li <zong@andestech.com>
To: <palmer@sifive.com>, <albert@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <zong@andestech.com>, <zongbox@gmail.com>
CC: <greentime@andestech.com>
Subject: [PATCH v2 01/11] RISC-V: Add sections of PLT and GOT for kernel module
Date: Thu, 15 Mar 2018 16:50:41 +0800
Message-ID: <eb6662f89b43d9cd1a7e674afdce33c8522afd3a.1521103169.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1521103167.git.zong@andestech.com>
References: <cover.1521103167.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w2F8lVbj080893
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The address of external symbols will locate more than 32-bit offset
in 64-bit kernel with sv39 or sv48 virtual addressing.

Module loader emits the GOT and PLT entries for data symbols and
function symbols respectively.

The PLT entry is a trampoline code for jumping to the 64-bit
real address. The GOT entry is just the data symbol address.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/Kconfig                  |   5 ++
 arch/riscv/Makefile                 |   5 ++
 arch/riscv/include/asm/module.h     | 103 ++++++++++++++++++++++++++
 arch/riscv/kernel/Makefile          |   1 +
 arch/riscv/kernel/module-sections.c | 139 ++++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/module.lds        |   7 ++
 6 files changed, 260 insertions(+)
 create mode 100644 arch/riscv/include/asm/module.h
 create mode 100644 arch/riscv/kernel/module-sections.c
 create mode 100644 arch/riscv/kernel/module.lds

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 310b9a5d6737..bede82480333 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -135,6 +135,10 @@ choice
 		bool "medium any code model"
 endchoice
 
+config MODULE_SECTIONS
+	bool
+	select HAVE_MOD_ARCH_SPECIFIC
+
 choice
 	prompt "Maximum Physical Memory"
 	default MAXPHYSMEM_2GB if 32BIT
@@ -145,6 +149,7 @@ choice
 		bool "2GiB"
 	config MAXPHYSMEM_128GB
 		depends on 64BIT && CMODEL_MEDANY
+		select MODULE_SECTIONS if MODULES
 		bool "128GiB"
 endchoice
 
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 26892daefa05..793544392d31 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -56,6 +56,11 @@ endif
 ifeq ($(CONFIG_CMODEL_MEDANY),y)
 	KBUILD_CFLAGS += -mcmodel=medany
 endif
+ifeq ($(CONFIG_MODULE_SECTIONS),y)
+	KBUILD_LDFLAGS_MODULE += -T $(srctree)/arch/riscv/kernel/module.lds
+endif
+
+KBUILD_CFLAGS_MODULE += $(call cc-option,-mno-relax)
 
 # GCC versions that support the "-mstrict-align" option default to allowing
 # unaligned accesses.  While unaligned accesses are explicitly allowed in the
diff --git a/arch/riscv/include/asm/module.h b/arch/riscv/include/asm/module.h
new file mode 100644
index 000000000000..e61d73f82d4d
--- /dev/null
+++ b/arch/riscv/include/asm/module.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2017 Andes Technology Corporation */
+
+#ifndef _ASM_RISCV_MODULE_H
+#define _ASM_RISCV_MODULE_H
+
+#include <asm-generic/module.h>
+
+#define MODULE_ARCH_VERMAGIC    "riscv"
+
+u64 module_emit_got_entry(struct module *mod, u64 val);
+u64 module_emit_plt_entry(struct module *mod, u64 val);
+
+#ifdef CONFIG_MODULE_SECTIONS
+struct mod_section {
+	struct elf64_shdr *shdr;
+	int num_entries;
+	int max_entries;
+};
+
+struct mod_arch_specific {
+	struct mod_section got;
+	struct mod_section plt;
+};
+
+struct got_entry {
+	u64 symbol_addr;	/* the real variable address */
+};
+
+static inline struct got_entry emit_got_entry(u64 val)
+{
+	return (struct got_entry) {val};
+}
+
+static inline struct got_entry *get_got_entry(u64 val,
+					      const struct mod_section *sec)
+{
+	struct got_entry *got = (struct got_entry *)sec->shdr->sh_addr;
+	int i;
+	for (i = 0; i < sec->num_entries; i++) {
+		if (got[i].symbol_addr == val)
+			return &got[i];
+	}
+	return NULL;
+}
+
+struct plt_entry {
+	/*
+	 * Trampoline code to real target address. The return address
+	 * should be the original (pc+4) before entring plt entry.
+	 * For 8 byte alignment of symbol_addr,
+	 * don't pack structure to remove the padding.
+	 */
+	u32 insn_auipc;		/* auipc t0, 0x0                       */
+	u32 insn_ld;		/* ld    t1, 0x10(t0)                  */
+	u32 insn_jr;		/* jr    t1                            */
+	u64 symbol_addr;	/* the real jump target address        */
+};
+
+#define OPC_AUIPC  0x0017
+#define OPC_LD     0x3003
+#define OPC_JALR   0x0067
+#define REG_T0     0x5
+#define REG_T1     0x6
+#define IMM_OFFSET 0x10
+
+static inline struct plt_entry emit_plt_entry(u64 val)
+{
+	/*
+	 * U-Type encoding:
+	 * +------------+----------+----------+
+	 * | imm[31:12] | rd[11:7] | opc[6:0] |
+	 * +------------+----------+----------+
+	 *
+	 * I-Type encoding:
+	 * +------------+------------+--------+----------+----------+
+	 * | imm[31:20] | rs1[19:15] | funct3 | rd[11:7] | opc[6:0] |
+	 * +------------+------------+--------+----------+----------+
+	 *
+	 */
+	return (struct plt_entry) {
+		OPC_AUIPC | (REG_T0 << 7),
+		OPC_LD | (IMM_OFFSET << 20) | (REG_T0 << 15) | (REG_T1 << 7),
+		OPC_JALR | (REG_T1 << 15),
+		val
+	};
+}
+
+static inline struct plt_entry *get_plt_entry(u64 val,
+					      const struct mod_section *sec)
+{
+	struct plt_entry *plt = (struct plt_entry *)sec->shdr->sh_addr;
+	int i;
+	for (i = 0; i < sec->num_entries; i++) {
+		if (plt[i].symbol_addr == val)
+			return &plt[i];
+	}
+	return NULL;
+}
+
+#endif /* CONFIG_MODULE_SECTIONS */
+
+#endif /* _ASM_RISCV_MODULE_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 196f62ffc428..d355e3c18278 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -34,6 +34,7 @@ CFLAGS_setup.o := -mcmodel=medany
 obj-$(CONFIG_SMP)		+= smpboot.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_MODULES)		+= module.o
+obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
 
diff --git a/arch/riscv/kernel/module-sections.c b/arch/riscv/kernel/module-sections.c
new file mode 100644
index 000000000000..94ba1551eac3
--- /dev/null
+++ b/arch/riscv/kernel/module-sections.c
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2014-2017 Linaro Ltd. <ard.biesheuvel@linaro.org>
+ *
+ * Copyright (C) 2018 Andes Technology Corporation <zong@andestech.com>
+ */
+
+#include <linux/elf.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+u64 module_emit_got_entry(struct module *mod, u64 val)
+{
+	struct mod_section *got_sec = &mod->arch.got;
+	int i = got_sec->num_entries;
+	struct got_entry *got = get_got_entry(val, got_sec);
+
+	if (got)
+		return (u64)got;
+
+	/* There is no duplicate entry, create a new one */
+	got = (struct got_entry *)got_sec->shdr->sh_addr;
+	got[i] = emit_got_entry(val);
+
+	got_sec->num_entries++;
+	BUG_ON(got_sec->num_entries > got_sec->max_entries);
+
+	return (u64)&got[i];
+}
+
+u64 module_emit_plt_entry(struct module *mod, u64 val)
+{
+	struct mod_section *plt_sec = &mod->arch.plt;
+	struct plt_entry *plt = get_plt_entry(val, plt_sec);
+	int i = plt_sec->num_entries;
+
+	if (plt)
+		return (u64)plt;
+
+	/* There is no duplicate entry, create a new one */
+	plt = (struct plt_entry *)plt_sec->shdr->sh_addr;
+	plt[i] = emit_plt_entry(val);
+
+	plt_sec->num_entries++;
+	BUG_ON(plt_sec->num_entries > plt_sec->max_entries);
+
+	return (u64)&plt[i];
+}
+
+static int is_rela_equal(const Elf64_Rela *x, const Elf64_Rela *y)
+{
+	return x->r_info == y->r_info && x->r_addend == y->r_addend;
+}
+
+static bool duplicate_rela(const Elf64_Rela *rela, int idx)
+{
+	int i;
+	for (i = 0; i < idx; i++) {
+		if (is_rela_equal(&rela[i], &rela[idx]))
+			return true;
+	}
+	return false;
+}
+
+static void count_max_entries(Elf64_Rela *relas, int num,
+			      unsigned int *plts, unsigned int *gots)
+{
+	unsigned int type, i;
+
+	for (i = 0; i < num; i++) {
+		type = ELF64_R_TYPE(relas[i].r_info);
+		if (type == R_RISCV_CALL_PLT) {
+			if (!duplicate_rela(relas, i))
+				(*plts)++;
+		} else if (type == R_RISCV_GOT_HI20) {
+			if (!duplicate_rela(relas, i))
+				(*gots)++;
+		}
+	}
+}
+
+int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
+			      char *secstrings, struct module *mod)
+{
+	unsigned int num_plts = 0;
+	unsigned int num_gots = 0;
+	int i;
+
+	/*
+	 * Find the empty .got and .plt sections.
+	 */
+	for (i = 0; i < ehdr->e_shnum; i++) {
+		if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt"))
+			mod->arch.plt.shdr = sechdrs + i;
+		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".got"))
+			mod->arch.got.shdr = sechdrs + i;
+	}
+
+	if (!mod->arch.plt.shdr) {
+		pr_err("%s: module PLT section(s) missing\n", mod->name);
+		return -ENOEXEC;
+	}
+	if (!mod->arch.got.shdr) {
+		pr_err("%s: module GOT section(s) missing\n", mod->name);
+		return -ENOEXEC;
+	}
+
+	/* Calculate the maxinum number of entries */
+	for (i = 0; i < ehdr->e_shnum; i++) {
+		Elf64_Rela *relas = (void *)ehdr + sechdrs[i].sh_offset;
+		int num_rela = sechdrs[i].sh_size / sizeof(Elf64_Rela);
+		Elf64_Shdr *dst_sec = sechdrs + sechdrs[i].sh_info;
+
+		if (sechdrs[i].sh_type != SHT_RELA)
+			continue;
+
+		/* ignore relocations that operate on non-exec sections */
+		if (!(dst_sec->sh_flags & SHF_EXECINSTR))
+			continue;
+
+		count_max_entries(relas, num_rela, &num_plts, &num_gots);
+	}
+
+	mod->arch.plt.shdr->sh_type = SHT_NOBITS;
+	mod->arch.plt.shdr->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
+	mod->arch.plt.shdr->sh_addralign = L1_CACHE_BYTES;
+	mod->arch.plt.shdr->sh_size = (num_plts + 1) * sizeof(struct plt_entry);
+	mod->arch.plt.num_entries = 0;
+	mod->arch.plt.max_entries = num_plts;
+
+	mod->arch.got.shdr->sh_type = SHT_NOBITS;
+	mod->arch.got.shdr->sh_flags = SHF_ALLOC;
+	mod->arch.got.shdr->sh_addralign = L1_CACHE_BYTES;
+	mod->arch.got.shdr->sh_size = (num_gots + 1) * sizeof(struct got_entry);
+	mod->arch.got.num_entries = 0;
+	mod->arch.got.max_entries = num_gots;
+
+	return 0;
+}
diff --git a/arch/riscv/kernel/module.lds b/arch/riscv/kernel/module.lds
new file mode 100644
index 000000000000..7ef580e62883
--- /dev/null
+++ b/arch/riscv/kernel/module.lds
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2017 Andes Technology Corporation */
+
+SECTIONS {
+	.plt (NOLOAD) : { BYTE(0) }
+	.got (NOLOAD) : { BYTE(0) }
+}
-- 
2.16.1
