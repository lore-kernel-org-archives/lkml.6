Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAFBECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0BE20867
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0BE20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389361AbeIUMH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 08:07:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:30090 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbeIUMHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 08:07:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 23:20:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,283,1534834800"; 
   d="scan'208";a="74798886"
Received: from chenyu-desktop.sh.intel.com ([10.239.160.116])
  by orsmga007.jf.intel.com with ESMTP; 20 Sep 2018 23:20:31 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Zhimin Gu <kookoo.gu@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 04/12][v4] x86, hibernate: Extract the common code of 64/32 bit system
Date:   Fri, 21 Sep 2018 14:26:58 +0800
Message-Id: <5e9214b028fad97382e1e81cea80c337ee931cae.1537448058.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1537448058.git.yu.c.chen@intel.com>
References: <cover.1537448058.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

Reduce the hibernation code duplication between x86-32 and x86-64
by extracting the common code into hibernate.c.

Currently only pfn_is_nosave() is the activated common
function in hibernate.c

No functional change.

Acked-by: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/include/asm/suspend.h |   8 ++
 arch/x86/power/Makefile        |   2 +-
 arch/x86/power/hibernate.c     | 246 +++++++++++++++++++++++++++++++++
 arch/x86/power/hibernate_32.c  |  15 +-
 arch/x86/power/hibernate_64.c  | 221 -----------------------------
 5 files changed, 256 insertions(+), 236 deletions(-)
 create mode 100644 arch/x86/power/hibernate.c

diff --git a/arch/x86/include/asm/suspend.h b/arch/x86/include/asm/suspend.h
index ecffe81ff65c..40b02558749f 100644
--- a/arch/x86/include/asm/suspend.h
+++ b/arch/x86/include/asm/suspend.h
@@ -4,3 +4,11 @@
 #else
 # include <asm/suspend_64.h>
 #endif
+extern unsigned long restore_jump_address __visible;
+extern unsigned long jump_address_phys;
+extern unsigned long restore_cr3 __visible;
+extern unsigned long temp_level4_pgt __visible;
+extern unsigned long relocated_restore_code __visible;
+extern int relocate_restore_code(void);
+/* Defined in hibernate_asm_32/64.S */
+extern asmlinkage __visible int restore_image(void);
diff --git a/arch/x86/power/Makefile b/arch/x86/power/Makefile
index a4701389562c..37923d715741 100644
--- a/arch/x86/power/Makefile
+++ b/arch/x86/power/Makefile
@@ -7,4 +7,4 @@ nostackp := $(call cc-option, -fno-stack-protector)
 CFLAGS_cpu.o	:= $(nostackp)
 
 obj-$(CONFIG_PM_SLEEP)		+= cpu.o
-obj-$(CONFIG_HIBERNATION)	+= hibernate_$(BITS).o hibernate_asm_$(BITS).o
+obj-$(CONFIG_HIBERNATION)	+= hibernate_$(BITS).o hibernate_asm_$(BITS).o hibernate.o
diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
new file mode 100644
index 000000000000..f63793b8de3f
--- /dev/null
+++ b/arch/x86/power/hibernate.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Hibernation support for x86
+ *
+ * Copyright (c) 2007 Rafael J. Wysocki <rjw@sisk.pl>
+ * Copyright (c) 2002 Pavel Machek <pavel@ucw.cz>
+ * Copyright (c) 2001 Patrick Mochel <mochel@osdl.org>
+ */
+#include <linux/gfp.h>
+#include <linux/smp.h>
+#include <linux/suspend.h>
+#include <linux/scatterlist.h>
+#include <linux/kdebug.h>
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
+unsigned long temp_level4_pgt __visible;
+unsigned long relocated_restore_code __visible;
+
+/**
+ *	pfn_is_nosave - check if given pfn is in the 'nosave' section
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
+#define RESTORE_MAGIC	0x23456789ABCDEF01UL
+
+/**
+ *	arch_hibernation_header_save - populate the architecture specific part
+ *		of a hibernation image header
+ *	@addr: address to save the data at
+ */
+int arch_hibernation_header_save(void *addr, unsigned int max_size)
+{
+	struct restore_data_record *rdr = addr;
+
+	if (max_size < sizeof(struct restore_data_record))
+		return -EOVERFLOW;
+	rdr->magic = RESTORE_MAGIC;
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
+	rdr->cr3 = restore_cr3 & ~CR3_PCID_MASK;
+
+	return hibernation_e820_save(rdr->e820_digest);
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
+	if (rdr->magic != RESTORE_MAGIC) {
+		pr_crit("Unrecognized hibernate image header format!\n");
+		return -EINVAL;
+	}
+
+	restore_jump_address = rdr->jump_address;
+	jump_address_phys = rdr->jump_address_phys;
+	restore_cr3 = rdr->cr3;
+
+	if (hibernation_e820_mismatch(rdr->e820_digest)) {
+		pr_crit("Hibernate inconsistent memory map detected!\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+int relocate_restore_code(void)
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
+#endif
diff --git a/arch/x86/power/hibernate_32.c b/arch/x86/power/hibernate_32.c
index afc4ed7b1578..f82fbd279d08 100644
--- a/arch/x86/power/hibernate_32.c
+++ b/arch/x86/power/hibernate_32.c
@@ -14,9 +14,7 @@
 #include <asm/pgtable.h>
 #include <asm/mmzone.h>
 #include <asm/sections.h>
-
-/* Defined in hibernate_asm_32.S */
-extern int restore_image(void);
+#include <asm/suspend.h>
 
 /* Pointer to the temporary resume page tables */
 pgd_t *resume_pg_dir;
@@ -162,14 +160,3 @@ asmlinkage int swsusp_arch_resume(void)
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
index e0de959ad02d..8bc2eb0dc464 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -26,26 +26,6 @@
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
 
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
-
 static int set_up_temporary_text_mapping(pgd_t *pgd)
 {
 	pmd_t *pmd;
@@ -145,45 +125,6 @@ static int set_up_temporary_mappings(void)
 	return 0;
 }
 
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
-	return 0;
-}
-
 asmlinkage int swsusp_arch_resume(void)
 {
 	int error;
@@ -200,165 +141,3 @@ asmlinkage int swsusp_arch_resume(void)
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
-	return hibernation_e820_save(rdr->e820_digest);
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
-- 
2.17.1

