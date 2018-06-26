Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC9CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAFC26C3C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BAFC26C3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965965AbeFZOXG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:23:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:53114 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965296AbeFZOW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:22:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 07:22:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="50671614"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jun 2018 07:22:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 442E19C0; Tue, 26 Jun 2018 17:22:52 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 16/18] x86/mm: Implement sync_direct_mapping()
Date:   Tue, 26 Jun 2018 17:22:43 +0300
Message-Id: <20180626142245.82850-17-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180626142245.82850-1-kirill.shutemov@linux.intel.com>
References: <20180626142245.82850-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For MKTME we use per-KeyID direct mappings. This allows kernel to have
access to encrypted memory.

sync_direct_mapping() sync per-KeyID direct mappings with a canonical
one -- KeyID-0.

The function tracks changes in the canonical mapping:
 - creating or removing chunks of the translation tree;
 - changes in mapping flags (i.e. protection bits);
 - splitting huge page mapping into a page table;
 - replacing page table with a huge page mapping;

The function need to be called on every change to the direct mapping:
hotplug, hotremove, changes in permissions bits, etc.

The function is nop until MKTME is enabled.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h |   8 +
 arch/x86/mm/init_64.c        |  10 +
 arch/x86/mm/mktme.c          | 437 +++++++++++++++++++++++++++++++++++
 3 files changed, 455 insertions(+)

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
index ebbee6a0c495..ba83fba4f9b3 100644
--- a/arch/x86/include/asm/mktme.h
+++ b/arch/x86/include/asm/mktme.h
@@ -27,10 +27,18 @@ void prep_encrypted_page(struct page *page, int order, int keyid, bool zero);
 #define HAVE_ARCH_FREE_PAGE
 void arch_free_page(struct page *page, int order);
 
+int sync_direct_mapping(void);
+
 #else
 #define mktme_keyid_mask	((phys_addr_t)0)
 #define mktme_nr_keyids		0
 #define mktme_keyid_shift	0
+
+static inline int sync_direct_mapping(void)
+{
+	return 0;
+}
+
 #endif
 
 #endif
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 6fc506f33e58..5a20fe465947 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -698,6 +698,7 @@ kernel_physical_mapping_init(unsigned long paddr_start,
 {
 	bool pgd_changed = false;
 	unsigned long vaddr, vaddr_start, vaddr_end, vaddr_next, paddr_last;
+	int ret;
 
 	paddr_last = paddr_end;
 	vaddr = (unsigned long)__va(paddr_start);
@@ -731,6 +732,9 @@ kernel_physical_mapping_init(unsigned long paddr_start,
 		pgd_changed = true;
 	}
 
+	ret = sync_direct_mapping();
+	WARN_ON(ret);
+
 	if (pgd_changed)
 		sync_global_pgds(vaddr_start, vaddr_end - 1);
 
@@ -1142,10 +1146,13 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
 static void __meminit
 kernel_physical_mapping_remove(unsigned long start, unsigned long end)
 {
+	int ret;
 	start = (unsigned long)__va(start);
 	end = (unsigned long)__va(end);
 
 	remove_pagetable(start, end, true, NULL);
+	ret = sync_direct_mapping();
+	WARN_ON(ret);
 }
 
 int __ref arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
@@ -1253,6 +1260,7 @@ void mark_rodata_ro(void)
 	unsigned long text_end = PFN_ALIGN(&__stop___ex_table);
 	unsigned long rodata_end = PFN_ALIGN(&__end_rodata);
 	unsigned long all_end;
+	int ret;
 
 	printk(KERN_INFO "Write protecting the kernel read-only data: %luk\n",
 	       (end - start) >> 10);
@@ -1290,6 +1298,8 @@ void mark_rodata_ro(void)
 			(unsigned long) __va(__pa_symbol(rodata_end)),
 			(unsigned long) __va(__pa_symbol(_sdata)));
 
+	ret = sync_direct_mapping();
+	WARN_ON(ret);
 	debug_checkwx();
 
 	/*
diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
index bb6210dbcf0e..660caf6a5ce1 100644
--- a/arch/x86/mm/mktme.c
+++ b/arch/x86/mm/mktme.c
@@ -1,6 +1,8 @@
 #include <linux/mm.h>
 #include <linux/highmem.h>
 #include <asm/mktme.h>
+#include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
 
 phys_addr_t mktme_keyid_mask;
 int mktme_nr_keyids;
@@ -42,6 +44,7 @@ static bool need_page_mktme(void)
 static void init_page_mktme(void)
 {
 	static_branch_enable(&mktme_enabled_key);
+	sync_direct_mapping();
 }
 
 struct page_ext_operations page_mktme_ops = {
@@ -107,3 +110,437 @@ void arch_free_page(struct page *page, int order)
 		page++;
 	}
 }
+
+static int sync_direct_mapping_pte(unsigned long keyid,
+		pmd_t *dst_pmd, pmd_t *src_pmd,
+		unsigned long addr, unsigned long end)
+{
+	pte_t *src_pte, *dst_pte;
+	pte_t *new_pte = NULL;
+	bool remove_pte;
+
+	/*
+	 * We want to unmap and free the page table if the source is empty and
+	 * the range covers whole page table.
+	 */
+	remove_pte = !src_pmd && PAGE_ALIGNED(addr) && PAGE_ALIGNED(end);
+
+	/*
+	 * PMD page got split into page table.
+	 * Clear PMD mapping. Page table will be established instead.
+	 */
+	if (pmd_large(*dst_pmd)) {
+		spin_lock(&init_mm.page_table_lock);
+		pmd_clear(dst_pmd);
+		spin_unlock(&init_mm.page_table_lock);
+	}
+
+	/* Allocate a new page table if needed. */
+	if (pmd_none(*dst_pmd)) {
+		new_pte = (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+		if (!new_pte)
+			return -ENOMEM;
+		dst_pte = new_pte + pte_index(addr + keyid * direct_mapping_size);
+	} else {
+		dst_pte = pte_offset_map(dst_pmd, addr + keyid * direct_mapping_size);
+	}
+	src_pte = src_pmd ? pte_offset_map(src_pmd, addr) : NULL;
+
+	spin_lock(&init_mm.page_table_lock);
+
+	do {
+		pteval_t val;
+
+		if (!src_pte || pte_none(*src_pte)) {
+			set_pte(dst_pte, __pte(0));
+			goto next;
+		}
+
+		if (!pte_none(*dst_pte)) {
+			/*
+			 * Sanity check: PFNs must match between source
+			 * and destination even if the rest doesn't.
+			 */
+			BUG_ON(pte_pfn(*dst_pte) != pte_pfn(*src_pte));
+		}
+
+		/* Copy entry, but set KeyID. */
+		val = pte_val(*src_pte) | keyid << mktme_keyid_shift;
+		set_pte(dst_pte, __pte(val));
+next:
+		addr += PAGE_SIZE;
+		dst_pte++;
+		if (src_pte)
+			src_pte++;
+	} while (addr != end);
+
+	if (new_pte)
+		pmd_populate_kernel(&init_mm, dst_pmd, new_pte);
+
+	if (remove_pte) {
+		__free_page(pmd_page(*dst_pmd));
+		pmd_clear(dst_pmd);
+	}
+
+	spin_unlock(&init_mm.page_table_lock);
+
+	return 0;
+}
+
+static int sync_direct_mapping_pmd(unsigned long keyid,
+		pud_t *dst_pud, pud_t *src_pud,
+		unsigned long addr, unsigned long end)
+{
+	pmd_t *src_pmd, *dst_pmd;
+	pmd_t *new_pmd = NULL;
+	bool remove_pmd = false;
+	unsigned long next;
+	int ret;
+
+	/*
+	 * We want to unmap and free the page table if the source is empty and
+	 * the range covers whole page table.
+	 */
+	remove_pmd = !src_pud && IS_ALIGNED(addr, PUD_SIZE) && IS_ALIGNED(end, PUD_SIZE);
+
+	/*
+	 * PUD page got split into page table.
+	 * Clear PUD mapping. Page table will be established instead.
+	 */
+	if (pud_large(*dst_pud)) {
+		spin_lock(&init_mm.page_table_lock);
+		pud_clear(dst_pud);
+		spin_unlock(&init_mm.page_table_lock);
+	}
+
+	/* Allocate a new page table if needed. */
+	if (pud_none(*dst_pud)) {
+		new_pmd = (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+		if (!new_pmd)
+			return -ENOMEM;
+		dst_pmd = new_pmd + pmd_index(addr + keyid * direct_mapping_size);
+	} else {
+		dst_pmd = pmd_offset(dst_pud, addr + keyid * direct_mapping_size);
+	}
+	src_pmd = src_pud ? pmd_offset(src_pud, addr) : NULL;
+
+	do {
+		pmd_t *__src_pmd = src_pmd;
+
+		next = pmd_addr_end(addr, end);
+		if (!__src_pmd || pmd_none(*__src_pmd)) {
+			if (pmd_none(*dst_pmd))
+				goto next;
+			if (pmd_large(*dst_pmd)) {
+				spin_lock(&init_mm.page_table_lock);
+				set_pmd(dst_pmd, __pmd(0));
+				spin_unlock(&init_mm.page_table_lock);
+				goto next;
+			}
+			__src_pmd = NULL;
+		}
+
+		if (__src_pmd && pmd_large(*__src_pmd)) {
+			pmdval_t val;
+
+			if (pmd_large(*dst_pmd)) {
+				/*
+				 * Sanity check: PFNs must match between source
+				 * and destination even if the rest doesn't.
+				 */
+				BUG_ON(pmd_pfn(*dst_pmd) != pmd_pfn(*__src_pmd));
+			} else if (!pmd_none(*dst_pmd)) {
+				/*
+				 * Page table is replaced with a PMD page.
+				 * Free and unmap the page table.
+				 */
+				__free_page(pmd_page(*dst_pmd));
+				spin_lock(&init_mm.page_table_lock);
+				pmd_clear(dst_pmd);
+				spin_unlock(&init_mm.page_table_lock);
+			}
+
+			/* Copy entry, but set KeyID. */
+			val = pmd_val(*__src_pmd) | keyid << mktme_keyid_shift;
+			spin_lock(&init_mm.page_table_lock);
+			set_pmd(dst_pmd, __pmd(val));
+			spin_unlock(&init_mm.page_table_lock);
+			goto next;
+		}
+
+		ret = sync_direct_mapping_pte(keyid, dst_pmd, __src_pmd,
+				addr, next);
+next:
+		addr = next;
+		dst_pmd++;
+		if (src_pmd)
+			src_pmd++;
+	} while (addr != end && !ret);
+
+	if (new_pmd) {
+		spin_lock(&init_mm.page_table_lock);
+		pud_populate(&init_mm, dst_pud, new_pmd);
+		spin_unlock(&init_mm.page_table_lock);
+	}
+
+	if (remove_pmd) {
+		spin_lock(&init_mm.page_table_lock);
+		__free_page(pud_page(*dst_pud));
+		pud_clear(dst_pud);
+		spin_unlock(&init_mm.page_table_lock);
+	}
+
+	return ret;
+}
+
+static int sync_direct_mapping_pud(unsigned long keyid,
+		p4d_t *dst_p4d, p4d_t *src_p4d,
+		unsigned long addr, unsigned long end)
+{
+	pud_t *src_pud, *dst_pud;
+	pud_t *new_pud = NULL;
+	bool remove_pud = false;
+	unsigned long next;
+	int ret;
+
+	/*
+	 * We want to unmap and free the page table if the source is empty and
+	 * the range covers whole page table.
+	 */
+	remove_pud = !src_p4d && IS_ALIGNED(addr, P4D_SIZE) && IS_ALIGNED(end, P4D_SIZE);
+
+	/*
+	 * P4D page got split into page table.
+	 * Clear P4D mapping. Page table will be established instead.
+	 */
+	if (p4d_large(*dst_p4d)) {
+		spin_lock(&init_mm.page_table_lock);
+		p4d_clear(dst_p4d);
+		spin_unlock(&init_mm.page_table_lock);
+	}
+
+	/* Allocate a new page table if needed. */
+	if (p4d_none(*dst_p4d)) {
+		new_pud = (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+		if (!new_pud)
+			return -ENOMEM;
+		dst_pud = new_pud + pud_index(addr + keyid * direct_mapping_size);
+	} else {
+		dst_pud = pud_offset(dst_p4d, addr + keyid * direct_mapping_size);
+	}
+	src_pud = src_p4d ? pud_offset(src_p4d, addr) : NULL;
+
+	do {
+		pud_t *__src_pud = src_pud;
+
+		next = pud_addr_end(addr, end);
+		if (!__src_pud || pud_none(*__src_pud)) {
+			if (pud_none(*dst_pud))
+				goto next;
+			if (pud_large(*dst_pud)) {
+				spin_lock(&init_mm.page_table_lock);
+				set_pud(dst_pud, __pud(0));
+				spin_unlock(&init_mm.page_table_lock);
+				goto next;
+			}
+			__src_pud = NULL;
+		}
+
+		if (__src_pud && pud_large(*__src_pud)) {
+			pudval_t val;
+
+			if (pud_large(*dst_pud)) {
+				/*
+				 * Sanity check: PFNs must match between source
+				 * and destination even if the rest doesn't.
+				 */
+				BUG_ON(pud_pfn(*dst_pud) != pud_pfn(*__src_pud));
+			} else if (!pud_none(*dst_pud)) {
+				/*
+				 * Page table is replaced with a pud page.
+				 * Free and unmap the page table.
+				 */
+				__free_page(pud_page(*dst_pud));
+				spin_lock(&init_mm.page_table_lock);
+				pud_clear(dst_pud);
+				spin_unlock(&init_mm.page_table_lock);
+			}
+
+			/* Copy entry, but set KeyID. */
+			val = pud_val(*__src_pud) | keyid << mktme_keyid_shift;
+			spin_lock(&init_mm.page_table_lock);
+			set_pud(dst_pud, __pud(val));
+			spin_unlock(&init_mm.page_table_lock);
+			goto next;
+		}
+
+		ret = sync_direct_mapping_pmd(keyid, dst_pud, __src_pud,
+				addr, next);
+next:
+		addr = next;
+		dst_pud++;
+		if (src_pud)
+			src_pud++;
+	} while (addr != end && !ret);
+
+	if (new_pud) {
+		spin_lock(&init_mm.page_table_lock);
+		p4d_populate(&init_mm, dst_p4d, new_pud);
+		spin_unlock(&init_mm.page_table_lock);
+	}
+
+	if (remove_pud) {
+		spin_lock(&init_mm.page_table_lock);
+		__free_page(p4d_page(*dst_p4d));
+		p4d_clear(dst_p4d);
+		spin_unlock(&init_mm.page_table_lock);
+	}
+
+	return ret;
+}
+
+static int sync_direct_mapping_p4d(unsigned long keyid,
+		pgd_t *dst_pgd, pgd_t *src_pgd,
+		unsigned long addr, unsigned long end)
+{
+	p4d_t *src_p4d, *dst_p4d;
+	p4d_t *new_p4d_1 = NULL, *new_p4d_2 = NULL;
+	bool remove_p4d = false;
+	unsigned long next;
+	int ret = 0;
+
+	/*
+	 * We want to unmap and free the page table if the source is empty and
+	 * the range covers whole page table.
+	 */
+	remove_p4d = !src_pgd && IS_ALIGNED(addr, PGDIR_SIZE) && IS_ALIGNED(end, PGDIR_SIZE);
+
+	/* Allocate a new page table if needed. */
+	if (pgd_none(*dst_pgd)) {
+		new_p4d_1 = (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+		if (!new_p4d_1)
+			return -ENOMEM;
+		dst_p4d = new_p4d_1 + p4d_index(addr + keyid * direct_mapping_size);
+	} else {
+		dst_p4d = p4d_offset(dst_pgd, addr + keyid * direct_mapping_size);
+	}
+	src_p4d = src_pgd ? p4d_offset(src_pgd, addr) : NULL;
+
+	do {
+		p4d_t *__src_p4d = src_p4d;
+
+		next = p4d_addr_end(addr, end);
+		if (!__src_p4d || p4d_none(*__src_p4d)) {
+			if (p4d_none(*dst_p4d))
+				goto next;
+			__src_p4d = NULL;
+		}
+
+		ret = sync_direct_mapping_pud(keyid, dst_p4d, __src_p4d,
+				addr, next);
+next:
+		addr = next;
+		dst_p4d++;
+
+		/*
+		 * Direct mappings are 1TiB-aligned. With 5-level paging it
+		 * means that on PGD level there can be misalignment between
+		 * source and distiantion.
+		 *
+		 * Allocate the new page table if dst_p4d crosses page table
+		 * boundary.
+		 */
+		if (!((unsigned long)dst_p4d & ~PAGE_MASK) && addr != end) {
+			if (pgd_none(dst_pgd[1])) {
+				new_p4d_2 = (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+				if (!new_p4d_2)
+					ret = -ENOMEM;
+				dst_p4d = new_p4d_2;
+			} else {
+				dst_p4d = p4d_offset(dst_pgd + 1, 0);
+			}
+		}
+		if (src_p4d)
+			src_p4d++;
+	} while (addr != end && !ret);
+
+	if (new_p4d_1 || new_p4d_2) {
+		spin_lock(&init_mm.page_table_lock);
+		if (new_p4d_1)
+			pgd_populate(&init_mm, dst_pgd, new_p4d_1);
+		if (new_p4d_2)
+			pgd_populate(&init_mm, dst_pgd + 1, new_p4d_2);
+		spin_unlock(&init_mm.page_table_lock);
+	}
+
+	if (remove_p4d) {
+		spin_lock(&init_mm.page_table_lock);
+		__free_page(pgd_page(*dst_pgd));
+		pgd_clear(dst_pgd);
+		spin_unlock(&init_mm.page_table_lock);
+	}
+
+	return ret;
+}
+
+static int sync_direct_mapping_keyid(unsigned long keyid)
+{
+	pgd_t *src_pgd, *dst_pgd;
+	unsigned long addr, end, next;
+	int ret;
+
+	addr = PAGE_OFFSET;
+	end = PAGE_OFFSET + direct_mapping_size;
+
+	dst_pgd = pgd_offset_k(addr + keyid * direct_mapping_size);
+	src_pgd = pgd_offset_k(addr);
+
+	do {
+		pgd_t *__src_pgd = src_pgd;
+
+		next = pgd_addr_end(addr, end);
+		if (pgd_none(*__src_pgd)) {
+			if (pgd_none(*dst_pgd))
+				continue;
+			__src_pgd = NULL;
+		}
+
+		ret = sync_direct_mapping_p4d(keyid, dst_pgd, __src_pgd,
+				addr, next);
+	} while (dst_pgd++, src_pgd++, addr = next, addr != end && !ret);
+
+	return ret;
+}
+
+/*
+ * For MKTME we maintain per-KeyID direct mappings. This allows kernel to have
+ * access to encrypted memory.
+ *
+ * sync_direct_mapping() sync per-KeyID direct mappings with a canonical
+ * one -- KeyID-0.
+ *
+ * The function tracks changes in the canonical mapping:
+ *  - creating or removing chunks of the translation tree;
+ *  - changes in mapping flags (i.e. protection bits);
+ *  - splitting huge page mapping into a page table;
+ *  - replacing page table with a huge page mapping;
+ *
+ * The function need to be called on every change to the direct mapping:
+ * hotplug, hotremove, changes in permissions bits, etc.
+ *
+ * The function is nop until MKTME is enabled.
+ */
+int sync_direct_mapping(void)
+{
+	int i, ret = 0;
+
+	if (!mktme_enabled())
+		return 0;
+
+	for (i = 1; !ret && i <= mktme_nr_keyids; i++)
+		ret = sync_direct_mapping_keyid(i);
+
+	__flush_tlb_all();
+
+	return ret;
+}
-- 
2.18.0

