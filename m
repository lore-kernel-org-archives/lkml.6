Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B7BC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B930E2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B930E2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeIKWPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:15:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:44672 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728199AbeIKWPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:15:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 10:14:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,361,1531810800"; 
   d="scan'208";a="262579618"
Received: from chenyu-desktop.sh.intel.com ([10.239.160.116])
  by fmsmga006.fm.intel.com with ESMTP; 11 Sep 2018 10:14:47 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Pavel Machek <pavel@ucw.cz>, Rui Zhang <rui.zhang@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Zhimin Gu <kookoo.gu@intel.com>,
        Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 3/4][v2] x86, hibernate: Extract the common code of 64/32 bit system
Date:   Wed, 12 Sep 2018 01:20:46 +0800
Message-Id: <7266f9b93000c57edd41fcf2cee0dd4d6252a8ef.1536685746.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1536685746.git.yu.c.chen@intel.com>
References: <cover.1536685746.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

Reduce the hibernation code duplication between x86-32 and x86-64
by extracting the common code into hibernate.c.

No functional change.

Acked-by: Chen Yu <yu.c.chen@intel.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
---
 arch/x86/power/hibernate.c        | 265 ++++++++++++++++++++++++++++++
 arch/x86/power/hibernate_32.c     |  23 +--
 arch/x86/power/hibernate_64.c     | 246 +--------------------------
 arch/x86/power/hibernate_asm_64.S |   2 +-
 4 files changed, 269 insertions(+), 267 deletions(-)
 create mode 100644 arch/x86/power/hibernate.c

diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
new file mode 100644
index 000000000000..6aeac4d3c9df
--- /dev/null
+++ b/arch/x86/power/hibernate.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Hibernation support for x86
+ *
+ * Copyright (c) 2007 Rafael J. Wysocki <rjw@sisk.pl>
+ * Copyright (c) 2002 Pavel Machek <pavel@ucw.cz>
+ * Copyright (c) 2001 Patrick Mochel <mochel@osdl.org>
+ */
+
+#include <linux/gfp.h>
+#include <linux/smp.h>
+#include <linux/suspend.h>
+#include <linux/scatterlist.h>
+#include <linux/kdebug.h>
+#include <linux/bootmem.h>
+
+#include <crypto/hash.h>
+
+#include <asm/e820/api.h>
+#include <asm/init.h>
+#include <asm/proto.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/mtrr.h>
+#include <asm/sections.h>
+#include <asm/suspend.h>
+#include <asm/tlbflush.h>
+#include <asm/mmzone.h>
+
+/* Defined in hibernate_asm_64.S or hibernate_asm_32.S */
+extern asmlinkage __visible int restore_image(void);
+
+/*
+ * Address to jump to in the last phase of restore in order to get to the image
+ * kernel's text (this value is passed in the image header).
+ */
+unsigned long restore_jump_address __visible;
+unsigned long jump_address_phys;
+
+/*
+ * Value of the cr3 register from before the hibernation (this value is passed
+ * in the image header).
+ */
+unsigned long restore_cr3 __visible;
+unsigned long temp_pgt __visible;
+unsigned long relocated_restore_code __visible;
+
+#ifdef CONFIG_X86_32
+	#define RESTORE_MAGIC	0x12345678UL
+#else
+	#define RESTORE_MAGIC	0x23456789ABCDEF01UL
+#endif
+
+/**
+ * pfn_is_nosave - check if given pfn is in the 'nosave' section
+ * @pfn:	the page frame number to be checked
+ *
+ * returns non-zero if the pfn is in the 'nosave' section,
+ * otherwise returns zero
+ */
+int pfn_is_nosave(unsigned long pfn)
+{
+	unsigned long nosave_begin_pfn;
+	unsigned long nosave_end_pfn;
+
+	nosave_begin_pfn = __pa_symbol(&__nosave_begin) >> PAGE_SHIFT;
+	nosave_end_pfn = PAGE_ALIGN(__pa_symbol(&__nosave_end)) >> PAGE_SHIFT;
+
+	return pfn >= nosave_begin_pfn && pfn < nosave_end_pfn;
+}
+
+#ifdef CONFIG_X86_64
+static int relocate_restore_code(void)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	relocated_restore_code = get_safe_page(GFP_ATOMIC);
+	if (!relocated_restore_code)
+		return -ENOMEM;
+
+	memcpy((void *)relocated_restore_code, core_restore_code, PAGE_SIZE);
+
+	/* Make the page containing the relocated code executable */
+	pgd = (pgd_t *)__va(read_cr3_pa()) +
+		pgd_index(relocated_restore_code);
+	p4d = p4d_offset(pgd, relocated_restore_code);
+	if (p4d_large(*p4d)) {
+		set_p4d(p4d, __p4d(p4d_val(*p4d) & ~_PAGE_NX));
+		goto out;
+	}
+	pud = pud_offset(p4d, relocated_restore_code);
+	if (pud_large(*pud)) {
+		set_pud(pud, __pud(pud_val(*pud) & ~_PAGE_NX));
+		goto out;
+	}
+	pmd = pmd_offset(pud, relocated_restore_code);
+	if (pmd_large(*pmd)) {
+		set_pmd(pmd, __pmd(pmd_val(*pmd) & ~_PAGE_NX));
+		goto out;
+	}
+	pte = pte_offset_kernel(pmd, relocated_restore_code);
+	set_pte(pte, __pte(pte_val(*pte) & ~_PAGE_NX));
+out:
+	__flush_tlb_all();
+	return 0;
+}
+
+#define MD5_DIGEST_SIZE 16
+
+struct restore_data_record {
+	unsigned long jump_address;
+	unsigned long jump_address_phys;
+	unsigned long cr3;
+	unsigned long magic;
+	u8 e820_digest[MD5_DIGEST_SIZE];
+};
+
+#if IS_BUILTIN(CONFIG_CRYPTO_MD5)
+/**
+ * get_e820_md5 - calculate md5 according to given e820 table
+ *
+ * @table: the e820 table to be calculated
+ * @buf: the md5 result to be stored to
+ */
+static int get_e820_md5(struct e820_table *table, void *buf)
+{
+	struct crypto_shash *tfm;
+	struct shash_desc *desc;
+	int size;
+	int ret = 0;
+
+	tfm = crypto_alloc_shash("md5", 0, 0);
+	if (IS_ERR(tfm))
+		return -ENOMEM;
+
+	desc = kmalloc(sizeof(struct shash_desc) + crypto_shash_descsize(tfm),
+		       GFP_KERNEL);
+	if (!desc) {
+		ret = -ENOMEM;
+		goto free_tfm;
+	}
+
+	desc->tfm = tfm;
+	desc->flags = 0;
+
+	size = offsetof(struct e820_table, entries) +
+		sizeof(struct e820_entry) * table->nr_entries;
+
+	if (crypto_shash_digest(desc, (u8 *)table, size, buf))
+		ret = -EINVAL;
+
+	kzfree(desc);
+
+free_tfm:
+	crypto_free_shash(tfm);
+	return ret;
+}
+
+static int hibernation_e820_save(void *buf)
+{
+	return get_e820_md5(e820_table_firmware, buf);
+}
+
+static bool hibernation_e820_mismatch(void *buf)
+{
+	int ret;
+	u8 result[MD5_DIGEST_SIZE];
+
+	memset(result, 0, MD5_DIGEST_SIZE);
+	/* If there is no digest in suspend kernel, let it go. */
+	if (!memcmp(result, buf, MD5_DIGEST_SIZE))
+		return false;
+
+	ret = get_e820_md5(e820_table_firmware, result);
+	if (ret)
+		return true;
+
+	return memcmp(result, buf, MD5_DIGEST_SIZE) ? true : false;
+}
+#else
+static int hibernation_e820_save(void *buf)
+{
+	return 0;
+}
+
+static bool hibernation_e820_mismatch(void *buf)
+{
+	/* If md5 is not builtin for restore kernel, let it go. */
+	return false;
+}
+#endif
+
+/**
+ *	arch_hibernation_header_save - populate the architecture specific part
+ *		of a hibernation image header
+ *	@addr: address to save the data at
+ */
+int arch_hibernation_header_save(void *addr, unsigned int max_size)
+{
+	struct restore_data_record *rdr = addr;
+	int ret = -EINVAL;
+
+	if (max_size < sizeof(struct restore_data_record))
+		return -EOVERFLOW;
+	rdr->jump_address = (unsigned long)restore_registers;
+	rdr->jump_address_phys = __pa_symbol(restore_registers);
+
+	/*
+	 * The restore code fixes up CR3 and CR4 in the following sequence:
+	 *
+	 * [in hibernation asm]
+	 * 1. CR3 <= temporary page tables
+	 * 2. CR4 <= mmu_cr4_features (from the kernel that restores us)
+	 * 3. CR3 <= rdr->cr3
+	 * 4. CR4 <= mmu_cr4_features (from us, i.e. the image kernel)
+	 * [in restore_processor_state()]
+	 * 5. CR4 <= saved CR4
+	 * 6. CR3 <= saved CR3
+	 *
+	 * Our mmu_cr4_features has CR4.PCIDE=0, and toggling
+	 * CR4.PCIDE while CR3's PCID bits are nonzero is illegal, so
+	 * rdr->cr3 needs to point to valid page tables but must not
+	 * have any of the PCID bits set.
+	 */
+	rdr->cr3 = restore_cr3 &(~CR3_PCID_MASK);
+
+	rdr->magic = RESTORE_MAGIC;
+
+	ret = hibernation_e820_save(rdr->e820_digest);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/**
+ *	arch_hibernation_header_restore - read the architecture specific data
+ *		from the hibernation image header
+ *	@addr: address to read the data from
+ */
+int arch_hibernation_header_restore(void *addr)
+{
+	struct restore_data_record *rdr = addr;
+
+	restore_jump_address = rdr->jump_address;
+	jump_address_phys = rdr->jump_address_phys;
+	restore_cr3 = rdr->cr3;
+
+	if (rdr->magic != RESTORE_MAGIC) {
+		pr_crit("Unrecognized hibernate image header format!\n");
+		return -EINVAL;
+	}
+
+	if (hibernation_e820_mismatch(rdr->e820_digest)) {
+		pr_crit("Hibernate inconsistent memory map detected!\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+#endif
diff --git a/arch/x86/power/hibernate_32.c b/arch/x86/power/hibernate_32.c
index afc4ed7b1578..e0e7b9aea22a 100644
--- a/arch/x86/power/hibernate_32.c
+++ b/arch/x86/power/hibernate_32.c
@@ -6,17 +6,7 @@
  * Copyright (c) 2006 Rafael J. Wysocki <rjw@sisk.pl>
  */
 
-#include <linux/gfp.h>
-#include <linux/suspend.h>
-#include <linux/bootmem.h>
-
-#include <asm/page.h>
-#include <asm/pgtable.h>
-#include <asm/mmzone.h>
-#include <asm/sections.h>
-
-/* Defined in hibernate_asm_32.S */
-extern int restore_image(void);
+#include "hibernate.c"
 
 /* Pointer to the temporary resume page tables */
 pgd_t *resume_pg_dir;
@@ -162,14 +152,3 @@ asmlinkage int swsusp_arch_resume(void)
 	restore_image();
 	return 0;
 }
-
-/*
- *	pfn_is_nosave - check if given pfn is in the 'nosave' section
- */
-
-int pfn_is_nosave(unsigned long pfn)
-{
-	unsigned long nosave_begin_pfn = __pa_symbol(&__nosave_begin) >> PAGE_SHIFT;
-	unsigned long nosave_end_pfn = PAGE_ALIGN(__pa_symbol(&__nosave_end)) >> PAGE_SHIFT;
-	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
-}
diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index dc12dc57889e..25946bb34f5a 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -8,43 +8,7 @@
  * Copyright (c) 2001 Patrick Mochel <mochel@osdl.org>
  */
 
-#include <linux/gfp.h>
-#include <linux/smp.h>
-#include <linux/suspend.h>
-#include <linux/scatterlist.h>
-#include <linux/kdebug.h>
-
-#include <crypto/hash.h>
-
-#include <asm/e820/api.h>
-#include <asm/init.h>
-#include <asm/proto.h>
-#include <asm/page.h>
-#include <asm/pgtable.h>
-#include <asm/mtrr.h>
-#include <asm/sections.h>
-#include <asm/suspend.h>
-#include <asm/tlbflush.h>
-
-/* Defined in hibernate_asm_64.S */
-extern asmlinkage __visible int restore_image(void);
-
-/*
- * Address to jump to in the last phase of restore in order to get to the image
- * kernel's text (this value is passed in the image header).
- */
-unsigned long restore_jump_address __visible;
-unsigned long jump_address_phys;
-
-/*
- * Value of the cr3 register from before the hibernation (this value is passed
- * in the image header).
- */
-unsigned long restore_cr3 __visible;
-
-unsigned long temp_level4_pgt __visible;
-
-unsigned long relocated_restore_code __visible;
+#include "hibernate.c"
 
 static int set_up_temporary_text_mapping(pgd_t *pgd)
 {
@@ -141,46 +105,7 @@ static int set_up_temporary_mappings(void)
 			return result;
 	}
 
-	temp_level4_pgt = __pa(pgd);
-	return 0;
-}
-
-static int relocate_restore_code(void)
-{
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-
-	relocated_restore_code = get_safe_page(GFP_ATOMIC);
-	if (!relocated_restore_code)
-		return -ENOMEM;
-
-	memcpy((void *)relocated_restore_code, core_restore_code, PAGE_SIZE);
-
-	/* Make the page containing the relocated code executable */
-	pgd = (pgd_t *)__va(read_cr3_pa()) +
-		pgd_index(relocated_restore_code);
-	p4d = p4d_offset(pgd, relocated_restore_code);
-	if (p4d_large(*p4d)) {
-		set_p4d(p4d, __p4d(p4d_val(*p4d) & ~_PAGE_NX));
-		goto out;
-	}
-	pud = pud_offset(p4d, relocated_restore_code);
-	if (pud_large(*pud)) {
-		set_pud(pud, __pud(pud_val(*pud) & ~_PAGE_NX));
-		goto out;
-	}
-	pmd = pmd_offset(pud, relocated_restore_code);
-	if (pmd_large(*pmd)) {
-		set_pmd(pmd, __pmd(pmd_val(*pmd) & ~_PAGE_NX));
-		goto out;
-	}
-	pte = pte_offset_kernel(pmd, relocated_restore_code);
-	set_pte(pte, __pte(pte_val(*pte) & ~_PAGE_NX));
-out:
-	__flush_tlb_all();
+	temp_pgt = __pa(pgd);
 	return 0;
 }
 
@@ -200,170 +125,3 @@ asmlinkage int swsusp_arch_resume(void)
 	restore_image();
 	return 0;
 }
-
-/*
- *	pfn_is_nosave - check if given pfn is in the 'nosave' section
- */
-
-int pfn_is_nosave(unsigned long pfn)
-{
-	unsigned long nosave_begin_pfn = __pa_symbol(&__nosave_begin) >> PAGE_SHIFT;
-	unsigned long nosave_end_pfn = PAGE_ALIGN(__pa_symbol(&__nosave_end)) >> PAGE_SHIFT;
-	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
-}
-
-#define MD5_DIGEST_SIZE 16
-
-struct restore_data_record {
-	unsigned long jump_address;
-	unsigned long jump_address_phys;
-	unsigned long cr3;
-	unsigned long magic;
-	u8 e820_digest[MD5_DIGEST_SIZE];
-};
-
-#define RESTORE_MAGIC	0x23456789ABCDEF01UL
-
-#if IS_BUILTIN(CONFIG_CRYPTO_MD5)
-/**
- * get_e820_md5 - calculate md5 according to given e820 table
- *
- * @table: the e820 table to be calculated
- * @buf: the md5 result to be stored to
- */
-static int get_e820_md5(struct e820_table *table, void *buf)
-{
-	struct crypto_shash *tfm;
-	struct shash_desc *desc;
-	int size;
-	int ret = 0;
-
-	tfm = crypto_alloc_shash("md5", 0, 0);
-	if (IS_ERR(tfm))
-		return -ENOMEM;
-
-	desc = kmalloc(sizeof(struct shash_desc) + crypto_shash_descsize(tfm),
-		       GFP_KERNEL);
-	if (!desc) {
-		ret = -ENOMEM;
-		goto free_tfm;
-	}
-
-	desc->tfm = tfm;
-	desc->flags = 0;
-
-	size = offsetof(struct e820_table, entries) +
-		sizeof(struct e820_entry) * table->nr_entries;
-
-	if (crypto_shash_digest(desc, (u8 *)table, size, buf))
-		ret = -EINVAL;
-
-	kzfree(desc);
-
-free_tfm:
-	crypto_free_shash(tfm);
-	return ret;
-}
-
-static int hibernation_e820_save(void *buf)
-{
-	return get_e820_md5(e820_table_firmware, buf);
-}
-
-static bool hibernation_e820_mismatch(void *buf)
-{
-	int ret;
-	u8 result[MD5_DIGEST_SIZE];
-
-	memset(result, 0, MD5_DIGEST_SIZE);
-	/* If there is no digest in suspend kernel, let it go. */
-	if (!memcmp(result, buf, MD5_DIGEST_SIZE))
-		return false;
-
-	ret = get_e820_md5(e820_table_firmware, result);
-	if (ret)
-		return true;
-
-	return memcmp(result, buf, MD5_DIGEST_SIZE) ? true : false;
-}
-#else
-static int hibernation_e820_save(void *buf)
-{
-	return 0;
-}
-
-static bool hibernation_e820_mismatch(void *buf)
-{
-	/* If md5 is not builtin for restore kernel, let it go. */
-	return false;
-}
-#endif
-
-/**
- *	arch_hibernation_header_save - populate the architecture specific part
- *		of a hibernation image header
- *	@addr: address to save the data at
- */
-int arch_hibernation_header_save(void *addr, unsigned int max_size)
-{
-	struct restore_data_record *rdr = addr;
-	int ret = -EINVAL;
-
-	if (max_size < sizeof(struct restore_data_record))
-		return -EOVERFLOW;
-	rdr->jump_address = (unsigned long)restore_registers;
-	rdr->jump_address_phys = __pa_symbol(restore_registers);
-
-	/*
-	 * The restore code fixes up CR3 and CR4 in the following sequence:
-	 *
-	 * [in hibernation asm]
-	 * 1. CR3 <= temporary page tables
-	 * 2. CR4 <= mmu_cr4_features (from the kernel that restores us)
-	 * 3. CR3 <= rdr->cr3
-	 * 4. CR4 <= mmu_cr4_features (from us, i.e. the image kernel)
-	 * [in restore_processor_state()]
-	 * 5. CR4 <= saved CR4
-	 * 6. CR3 <= saved CR3
-	 *
-	 * Our mmu_cr4_features has CR4.PCIDE=0, and toggling
-	 * CR4.PCIDE while CR3's PCID bits are nonzero is illegal, so
-	 * rdr->cr3 needs to point to valid page tables but must not
-	 * have any of the PCID bits set.
-	 */
-	rdr->cr3 = restore_cr3 & ~CR3_PCID_MASK;
-
-	rdr->magic = RESTORE_MAGIC;
-
-	ret = hibernation_e820_save(rdr->e820_digest);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-/**
- *	arch_hibernation_header_restore - read the architecture specific data
- *		from the hibernation image header
- *	@addr: address to read the data from
- */
-int arch_hibernation_header_restore(void *addr)
-{
-	struct restore_data_record *rdr = addr;
-
-	restore_jump_address = rdr->jump_address;
-	jump_address_phys = rdr->jump_address_phys;
-	restore_cr3 = rdr->cr3;
-
-	if (rdr->magic != RESTORE_MAGIC) {
-		pr_crit("Unrecognized hibernate image header format!\n");
-		return -EINVAL;
-	}
-
-	if (hibernation_e820_mismatch(rdr->e820_digest)) {
-		pr_crit("Hibernate inconsistent memory map detected!\n");
-		return -ENODEV;
-	}
-
-	return 0;
-}
diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index fd369a6e9ff8..3008baa2fa95 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -59,7 +59,7 @@ ENTRY(restore_image)
 	movq	restore_cr3(%rip), %r9
 
 	/* prepare to switch to temporary page tables */
-	movq	temp_level4_pgt(%rip), %rax
+	movq	temp_pgt(%rip), %rax
 	movq	mmu_cr4_features(%rip), %rbx
 
 	/* prepare to copy image data to their original locations */
-- 
2.17.1

