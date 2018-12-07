Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612EDC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12FD320892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtA0qCkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FD320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLGJEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:04:46 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36220 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeLGJEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:04:46 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so1648138pfc.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 01:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sPapJUSBPFaUxc0iV6+vtBTGeecFdqf54ukPZOqakLw=;
        b=dtA0qCkMiFkIiP5K0y4LAjAB7RG6C9mScHXx1vUVu+hcqohlM0yQyTjYHK8GlrW9N0
         KjMrAjGlYmsKF7htgTDD2XU5YbkLKhHYRA47yTVOUFwyJ3TxUyxcqwN2WBGe+Cc0hPy7
         sos91GZsPsCmbu2IK9m7jrw787k7xaO66b/2r7B9ykHD2sl93/lkg4rVkKRYbk2E32uo
         h5NXjgzW5ghyCMmx8yWE86LZIDQajWZ1QJhp96bS7eQ3NeW3FRU65udSy6cw0KVF/AWi
         j3K6Mm0Ih+uMsPz1wyFfiZjTEVKrRpOQ1naxMSegjouu4sLy3Uwa/36/MmzxA8uhU4EP
         Kv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sPapJUSBPFaUxc0iV6+vtBTGeecFdqf54ukPZOqakLw=;
        b=nedauvtgCV9Y9/Al1LD2iMhjqpJiDN9wB6ggKqYwAvwE2N7D2xsJQpAZ+L94nGmwNn
         NgV4R6VyakTNIDeKK8O7lkbYaObsxImsuRayiplMVL6rSrLcP2miRHnJUFQhWxK5C5qV
         Q4hOLY4fPryHESPCp+8FOx2goZPEiY7ixQ1k8F/uq/l0uUNOne+fUvclCsMEfDePTKGE
         hWAC2G4FUqeaFmdsXE3olfgVcaLK0+hlvCCD9jiZ8KBAwFkCtKmL0VE9TQJ3PBH5agiH
         L7mqWRy9bL3NBRYZ5CFd9oBq4MqIgEGOG8TCk7JRM46pe+MxAbYCbENgEnFthoQ+wykp
         YyNA==
X-Gm-Message-State: AA+aEWaw0g7g/H77ut+C+6okA2RkTv/1V7Q3zPK0gTUC/kAzvcht/oSo
        qmRpFdtBwqE1gxQf9Obaam6oRIHC
X-Google-Smtp-Source: AFSGD/URaB7hVreN6Vs0kU+5T991ZkICnZVlKmcTgcHK7ePcy32Wfh7aHSPdHMFKAqsMzgStwTgG1g==
X-Received: by 2002:a65:4049:: with SMTP id h9mr1209633pgp.304.1544173483765;
        Fri, 07 Dec 2018 01:04:43 -0800 (PST)
Received: from app09.andestech.com (59-120-53-16.HINET-IP.hinet.net. [59.120.53.16])
        by smtp.gmail.com with ESMTPSA id k191sm3178222pgd.9.2018.12.07.01.04.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 01:04:43 -0800 (PST)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     zong@andestech.com, Zong Li <zongbox@gmail.com>
Subject: [PATCH] RISC-V: Support MODULE_SECTIONS mechanism on RV32
Date:   Fri,  7 Dec 2018 17:02:16 +0800
Message-Id: <20181207090216.3529-1-zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch supports dynamic generate got and plt sections mechanism on
rv32. It contains the modification as follows:
 - Always enable MODULE_SECTIONS (both rv64 and rv32)
 - Change the fixed size type.

This patch had been tested by following modules:

btrfs 6795991 0 - Live 0xa544b000
test_static_keys 17304 0 - Live 0xa28be000
zstd_compress 1198986 1 btrfs, Live 0xa2a25000
zstd_decompress 608112 1 btrfs, Live 0xa24e7000
lzo 8787 0 - Live 0xa2049000
xor 27461 1 btrfs, Live 0xa2041000
zram 78849 0 - Live 0xa2276000
netdevsim 55909 0 - Live 0xa202d000
tun 211534 0 - Live 0xa21b5000
fuse 566049 0 - Live 0xa25fb000
nfs_layout_flexfiles 192597 0 - Live 0xa229b000
ramoops 74895 0 - Live 0xa2019000
xfs 3973221 0 - Live 0xa507f000
libcrc32c 3053 2 btrfs,xfs, Live 0xa34af000
lzo_compress 17302 2 btrfs,lzo, Live 0xa347d000
lzo_decompress 7178 2 btrfs,lzo, Live 0xa3451000
raid6_pq 142086 1 btrfs, Live 0xa33a4000
reed_solomon 31022 1 ramoops, Live 0xa31eb000
test_bitmap 3734 0 - Live 0xa31af000
test_bpf 1588736 0 - Live 0xa2c11000
test_kmod 41161 0 - Live 0xa29f8000
test_module 1356 0 - Live 0xa299e000
test_printf 6024 0 [permanent], Live 0xa2971000
test_static_key_base 5797 1 test_static_keys, Live 0xa2931000
test_user_copy 4382 0 - Live 0xa28c9000
xxhash 70501 2 zstd_compress,zstd_decompress, Live 0xa2055000

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/Kconfig                  |  2 +-
 arch/riscv/include/asm/module.h     | 28 +++++++++++++++-------------
 arch/riscv/kernel/module-sections.c | 30 ++++++++++++++++--------------
 3 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 55da93f..477f1e8 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -39,6 +39,7 @@ config RISCV
 	select SYSCTL_EXCEPTION_TRACE
 	select HAVE_ARCH_TRACEHOOK
 	select MODULES_USE_ELF_RELA if MODULES
+	select MODULE_SECTIONS if MODULES
 	select THREAD_INFO_IN_TASK
 	select RISCV_TIMER
 	select GENERIC_IRQ_MULTI_HANDLER
@@ -149,7 +150,6 @@ choice
 		bool "2GiB"
 	config MAXPHYSMEM_128GB
 		depends on 64BIT && CMODEL_MEDANY
-		select MODULE_SECTIONS if MODULES
 		bool "128GiB"
 endchoice
 
diff --git a/arch/riscv/include/asm/module.h b/arch/riscv/include/asm/module.h
index cd2af4b..46202da 100644
--- a/arch/riscv/include/asm/module.h
+++ b/arch/riscv/include/asm/module.h
@@ -9,12 +9,12 @@
 #define MODULE_ARCH_VERMAGIC    "riscv"
 
 struct module;
-u64 module_emit_got_entry(struct module *mod, u64 val);
-u64 module_emit_plt_entry(struct module *mod, u64 val);
+unsigned long module_emit_got_entry(struct module *mod, unsigned long val);
+unsigned long module_emit_plt_entry(struct module *mod, unsigned long val);
 
 #ifdef CONFIG_MODULE_SECTIONS
 struct mod_section {
-	struct elf64_shdr *shdr;
+	Elf_Shdr *shdr;
 	int num_entries;
 	int max_entries;
 };
@@ -26,18 +26,18 @@ struct mod_arch_specific {
 };
 
 struct got_entry {
-	u64 symbol_addr;	/* the real variable address */
+	unsigned long symbol_addr;	/* the real variable address */
 };
 
-static inline struct got_entry emit_got_entry(u64 val)
+static inline struct got_entry emit_got_entry(unsigned long val)
 {
 	return (struct got_entry) {val};
 }
 
-static inline struct got_entry *get_got_entry(u64 val,
+static inline struct got_entry *get_got_entry(unsigned long val,
 					      const struct mod_section *sec)
 {
-	struct got_entry *got = (struct got_entry *)sec->shdr->sh_addr;
+	struct got_entry *got = (struct got_entry *)(sec->shdr->sh_addr);
 	int i;
 	for (i = 0; i < sec->num_entries; i++) {
 		if (got[i].symbol_addr == val)
@@ -62,7 +62,9 @@ struct plt_entry {
 #define REG_T0     0x5
 #define REG_T1     0x6
 
-static inline struct plt_entry emit_plt_entry(u64 val, u64 plt, u64 got_plt)
+static inline struct plt_entry emit_plt_entry(unsigned long val,
+					      unsigned long plt,
+					      unsigned long got_plt)
 {
 	/*
 	 * U-Type encoding:
@@ -76,7 +78,7 @@ static inline struct plt_entry emit_plt_entry(u64 val, u64 plt, u64 got_plt)
 	 * +------------+------------+--------+----------+----------+
 	 *
 	 */
-	u64 offset = got_plt - plt;
+	unsigned long offset = got_plt - plt;
 	u32 hi20 = (offset + 0x800) & 0xfffff000;
 	u32 lo12 = (offset - hi20);
 	return (struct plt_entry) {
@@ -86,7 +88,7 @@ static inline struct plt_entry emit_plt_entry(u64 val, u64 plt, u64 got_plt)
 	};
 }
 
-static inline int get_got_plt_idx(u64 val, const struct mod_section *sec)
+static inline int get_got_plt_idx(unsigned long val, const struct mod_section *sec)
 {
 	struct got_entry *got_plt = (struct got_entry *)sec->shdr->sh_addr;
 	int i;
@@ -97,9 +99,9 @@ static inline int get_got_plt_idx(u64 val, const struct mod_section *sec)
 	return -1;
 }
 
-static inline struct plt_entry *get_plt_entry(u64 val,
-				      const struct mod_section *sec_plt,
-				      const struct mod_section *sec_got_plt)
+static inline struct plt_entry *get_plt_entry(unsigned long val,
+					      const struct mod_section *sec_plt,
+					      const struct mod_section *sec_got_plt)
 {
 	struct plt_entry *plt = (struct plt_entry *)sec_plt->shdr->sh_addr;
 	int got_plt_idx = get_got_plt_idx(val, sec_got_plt);
diff --git a/arch/riscv/kernel/module-sections.c b/arch/riscv/kernel/module-sections.c
index bbbd26e..c9ae483 100644
--- a/arch/riscv/kernel/module-sections.c
+++ b/arch/riscv/kernel/module-sections.c
@@ -9,14 +9,14 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 
-u64 module_emit_got_entry(struct module *mod, u64 val)
+unsigned long module_emit_got_entry(struct module *mod, unsigned long val)
 {
 	struct mod_section *got_sec = &mod->arch.got;
 	int i = got_sec->num_entries;
 	struct got_entry *got = get_got_entry(val, got_sec);
 
 	if (got)
-		return (u64)got;
+		return (unsigned long)got;
 
 	/* There is no duplicate entry, create a new one */
 	got = (struct got_entry *)got_sec->shdr->sh_addr;
@@ -25,10 +25,10 @@ u64 module_emit_got_entry(struct module *mod, u64 val)
 	got_sec->num_entries++;
 	BUG_ON(got_sec->num_entries > got_sec->max_entries);
 
-	return (u64)&got[i];
+	return (unsigned long)&got[i];
 }
 
-u64 module_emit_plt_entry(struct module *mod, u64 val)
+unsigned long module_emit_plt_entry(struct module *mod, unsigned long val)
 {
 	struct mod_section *got_plt_sec = &mod->arch.got_plt;
 	struct got_entry *got_plt;
@@ -37,27 +37,29 @@ u64 module_emit_plt_entry(struct module *mod, u64 val)
 	int i = plt_sec->num_entries;
 
 	if (plt)
-		return (u64)plt;
+		return (unsigned long)plt;
 
 	/* There is no duplicate entry, create a new one */
 	got_plt = (struct got_entry *)got_plt_sec->shdr->sh_addr;
 	got_plt[i] = emit_got_entry(val);
 	plt = (struct plt_entry *)plt_sec->shdr->sh_addr;
-	plt[i] = emit_plt_entry(val, (u64)&plt[i], (u64)&got_plt[i]);
+	plt[i] = emit_plt_entry(val,
+				(unsigned long)&plt[i],
+				(unsigned long)&got_plt[i]);
 
 	plt_sec->num_entries++;
 	got_plt_sec->num_entries++;
 	BUG_ON(plt_sec->num_entries > plt_sec->max_entries);
 
-	return (u64)&plt[i];
+	return (unsigned long)&plt[i];
 }
 
-static int is_rela_equal(const Elf64_Rela *x, const Elf64_Rela *y)
+static int is_rela_equal(const Elf_Rela *x, const Elf_Rela *y)
 {
 	return x->r_info == y->r_info && x->r_addend == y->r_addend;
 }
 
-static bool duplicate_rela(const Elf64_Rela *rela, int idx)
+static bool duplicate_rela(const Elf_Rela *rela, int idx)
 {
 	int i;
 	for (i = 0; i < idx; i++) {
@@ -67,13 +69,13 @@ static bool duplicate_rela(const Elf64_Rela *rela, int idx)
 	return false;
 }
 
-static void count_max_entries(Elf64_Rela *relas, int num,
+static void count_max_entries(Elf_Rela *relas, int num,
 			      unsigned int *plts, unsigned int *gots)
 {
 	unsigned int type, i;
 
 	for (i = 0; i < num; i++) {
-		type = ELF64_R_TYPE(relas[i].r_info);
+		type = ELF_RISCV_R_TYPE(relas[i].r_info);
 		if (type == R_RISCV_CALL_PLT) {
 			if (!duplicate_rela(relas, i))
 				(*plts)++;
@@ -118,9 +120,9 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 
 	/* Calculate the maxinum number of entries */
 	for (i = 0; i < ehdr->e_shnum; i++) {
-		Elf64_Rela *relas = (void *)ehdr + sechdrs[i].sh_offset;
-		int num_rela = sechdrs[i].sh_size / sizeof(Elf64_Rela);
-		Elf64_Shdr *dst_sec = sechdrs + sechdrs[i].sh_info;
+		Elf_Rela *relas = (void *)ehdr + sechdrs[i].sh_offset;
+		int num_rela = sechdrs[i].sh_size / sizeof(Elf_Rela);
+		Elf_Shdr *dst_sec = sechdrs + sechdrs[i].sh_info;
 
 		if (sechdrs[i].sh_type != SHT_RELA)
 			continue;
-- 
2.7.4

