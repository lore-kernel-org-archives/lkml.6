Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCF1C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BA22086C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BA22086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbeKGGId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:08:33 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53751 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbeKGGIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:08:32 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA6KePn2947505
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Nov 2018 12:40:25 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA6KePXs947502;
        Tue, 6 Nov 2018 12:40:25 -0800
Date:   Tue, 6 Nov 2018 12:40:25 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-a0e6e0831c516860fc7f9be1db6c081fe902ebcf@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
          kirill.shutemov@linux.intel.com, mingo@kernel.org
In-Reply-To: <20181026122856.66224-3-kirill.shutemov@linux.intel.com>
References: <20181026122856.66224-3-kirill.shutemov@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/ldt: Unmap PTEs for the slot before freeing
 LDT pages
Git-Commit-ID: a0e6e0831c516860fc7f9be1db6c081fe902ebcf
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a0e6e0831c516860fc7f9be1db6c081fe902ebcf
Gitweb:     https://git.kernel.org/tip/a0e6e0831c516860fc7f9be1db6c081fe902ebcf
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Fri, 26 Oct 2018 15:28:55 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 6 Nov 2018 21:35:11 +0100

x86/ldt: Unmap PTEs for the slot before freeing LDT pages

modify_ldt(2) leaves the old LDT mapped after switching over to the new
one. The old LDT gets freed and the pages can be re-used.

Leaving the mapping in place can have security implications. The mapping is
present in the userspace page tables and Meltdown-like attacks can read
these freed and possibly reused pages.

It's relatively simple to fix: unmap the old LDT and flush TLB before
freeing the old LDT memory.

This further allows to avoid flushing the TLB in map_ldt_struct() as the
slot is unmapped and flushed by unmap_ldt_struct() or has never been mapped
at all.

[ tglx: Massaged changelog and removed the needless line breaks ]

Fixes: f55f0501cbf6 ("x86/pti: Put the LDT in its own PGD if PTI is on")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: dave.hansen@linux.intel.com
Cc: luto@kernel.org
Cc: peterz@infradead.org
Cc: boris.ostrovsky@oracle.com
Cc: jgross@suse.com
Cc: bhe@redhat.com
Cc: willy@infradead.org
Cc: linux-mm@kvack.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181026122856.66224-3-kirill.shutemov@linux.intel.com

---
 arch/x86/kernel/ldt.c | 51 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index ab18e0884dc6..18e4525c5933 100644
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
@@ -214,8 +206,8 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 	unsigned long va;
 	bool is_vmalloc;
 	spinlock_t *ptl;
+	int i, nr_pages;
 	pgd_t *pgd;
-	int i;
 
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return 0;
@@ -238,7 +230,9 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 
 	is_vmalloc = is_vmalloc_addr(ldt->entries);
 
-	for (i = 0; i * PAGE_SIZE < ldt->nr_entries * LDT_ENTRY_SIZE; i++) {
+	nr_pages = DIV_ROUND_UP(ldt->nr_entries * LDT_ENTRY_SIZE, PAGE_SIZE);
+
+	for (i = 0; i < nr_pages; i++) {
 		unsigned long offset = i << PAGE_SHIFT;
 		const void *src = (char *)ldt->entries + offset;
 		unsigned long pfn;
@@ -272,13 +266,39 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 	/* Propagate LDT mapping to the user page-table */
 	map_ldt_struct_to_user(mm);
 
-	va = (unsigned long)ldt_slot_va(slot);
-	flush_tlb_mm_range(mm, va, va + LDT_SLOT_STRIDE, PAGE_SHIFT, false);
-
 	ldt->slot = slot;
 	return 0;
 }
 
+static void unmap_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt)
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
+
+	for (i = 0; i < nr_pages; i++) {
+		unsigned long offset = i << PAGE_SHIFT;
+		spinlock_t *ptl;
+		pte_t *ptep;
+
+		va = (unsigned long)ldt_slot_va(ldt->slot) + offset;
+		ptep = get_locked_pte(mm, va, &ptl);
+		pte_clear(mm, va, ptep);
+		pte_unmap_unlock(ptep, ptl);
+	}
+
+	va = (unsigned long)ldt_slot_va(ldt->slot);
+	flush_tlb_mm_range(mm, va, va + nr_pages * PAGE_SIZE, PAGE_SHIFT, false);
+}
+
 #else /* !CONFIG_PAGE_TABLE_ISOLATION */
 
 static int
@@ -286,6 +306,10 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 {
 	return 0;
 }
+
+static void unmap_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt)
+{
+}
 #endif /* CONFIG_PAGE_TABLE_ISOLATION */
 
 static void free_ldt_pgtables(struct mm_struct *mm)
@@ -524,6 +548,7 @@ static int write_ldt(void __user *ptr, unsigned long bytecount, int oldmode)
 	}
 
 	install_ldt(mm, new_ldt);
+	unmap_ldt_struct(mm, old_ldt);
 	free_ldt_struct(old_ldt);
 	error = 0;
 
