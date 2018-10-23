Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823FDC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5571A20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5571A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeJXA4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:56:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:63620 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728554AbeJXA4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:56:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 09:32:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,416,1534834800"; 
   d="scan'208";a="97862347"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 23 Oct 2018 09:32:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5074827D; Tue, 23 Oct 2018 19:32:04 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 2/2] x86/ldt: Unmap PTEs for the slow before freeing LDT
Date:   Tue, 23 Oct 2018 19:31:57 +0300
Message-Id: <20181023163157.41441-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181023163157.41441-1-kirill.shutemov@linux.intel.com>
References: <20181023163157.41441-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

modify_ldt(2) leaves old LDT mapped after we switch over to the new one.
Memory for the old LDT gets freed and the pages can be re-used.

Leaving the mapping in place can have security implications. The mapping
is present in userspace copy of page tables and Meltdown-like attack can
read these freed and possibly reused pages.

It's relatively simple to fix: just unmap the old LDT and flush TLB
before freeing LDT memory.

We can now avoid flushing TLB on map_ldt_struct() as the slot is
unmapped and flushed by unmap_ldt_struct() (or never mapped in
the first place). The overhead of the change should be negligible.
It shouldn't be a particularly hot path anyway.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: f55f0501cbf6 ("x86/pti: Put the LDT in its own PGD if PTI is on")
---
 arch/x86/kernel/ldt.c | 59 ++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 733e6ace0fa4..8767fea41309 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -199,14 +199,6 @@ static void sanity_check_ldt_mapping(struct mm_struct *mm)
 /*
  * If PTI is enabled, this maps the LDT into the kernelmode and
  * usermode tables for the given mm.
- *
- * There is no corresponding unmap function.  Even if the LDT is freed, we
- * leave the PTEs around until the slot is reused or the mm is destroyed.
- * This is harmless: the LDT is always in ordinary memory, and no one will
- * access the freed slot.
- *
- * If we wanted to unmap freed LDTs, we'd also need to do a flush to make
- * it useful, and the flush would slow down modify_ldt().
  */
 static int
 map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
@@ -214,8 +206,7 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 	unsigned long va;
 	bool is_vmalloc;
 	spinlock_t *ptl;
-	pgd_t *pgd;
-	int i;
+	int i, nr_pages;
 
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return 0;
@@ -229,16 +220,10 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 	/* Check if the current mappings are sane */
 	sanity_check_ldt_mapping(mm);
 
-	/*
-	 * Did we already have the top level entry allocated?  We can't
-	 * use pgd_none() for this because it doens't do anything on
-	 * 4-level page table kernels.
-	 */
-	pgd = pgd_offset(mm, LDT_BASE_ADDR);
-
 	is_vmalloc = is_vmalloc_addr(ldt->entries);
 
-	for (i = 0; i * PAGE_SIZE < ldt->nr_entries * LDT_ENTRY_SIZE; i++) {
+	nr_pages = DIV_ROUND_UP(ldt->nr_entries * LDT_ENTRY_SIZE, PAGE_SIZE);
+	for (i = 0; i < nr_pages; i++) {
 		unsigned long offset = i << PAGE_SHIFT;
 		const void *src = (char *)ldt->entries + offset;
 		unsigned long pfn;
@@ -272,13 +257,39 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 	/* Propagate LDT mapping to the user page-table */
 	map_ldt_struct_to_user(mm);
 
-	va = (unsigned long)ldt_slot_va(slot);
-	flush_tlb_mm_range(mm, va, va + LDT_SLOT_STRIDE, 0);
-
 	ldt->slot = slot;
 	return 0;
 }
 
+static void
+unmap_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt)
+{
+	unsigned long va;
+	int i, nr_pages;
+
+	if (!ldt)
+		return;
+
+	/* LDT map/unmap is only required for PTI */
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return;
+
+	nr_pages = DIV_ROUND_UP(ldt->nr_entries * LDT_ENTRY_SIZE, PAGE_SIZE);
+	for (i = 0; i < nr_pages; i++) {
+		unsigned long offset = i << PAGE_SHIFT;
+		pte_t *ptep;
+		spinlock_t *ptl;
+
+		va = (unsigned long)ldt_slot_va(ldt->slot) + offset;
+		ptep = get_locked_pte(mm, va, &ptl);
+		pte_clear(mm, va, ptep);
+		pte_unmap_unlock(ptep, ptl);
+	}
+
+	va = (unsigned long)ldt_slot_va(ldt->slot);
+	flush_tlb_mm_range(mm, va, va + nr_pages * PAGE_SIZE, 0);
+}
+
 #else /* !CONFIG_PAGE_TABLE_ISOLATION */
 
 static int
@@ -286,6 +297,11 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 {
 	return 0;
 }
+
+static void
+unmap_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt)
+{
+}
 #endif /* CONFIG_PAGE_TABLE_ISOLATION */
 
 static void free_ldt_pgtables(struct mm_struct *mm)
@@ -524,6 +540,7 @@ static int write_ldt(void __user *ptr, unsigned long bytecount, int oldmode)
 	}
 
 	install_ldt(mm, new_ldt);
+	unmap_ldt_struct(mm, old_ldt);
 	free_ldt_struct(old_ldt);
 	error = 0;
 
-- 
2.19.1

