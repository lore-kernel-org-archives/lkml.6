Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022B1ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B50208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B50208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731235AbeGQLxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:53:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:45425 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730600AbeGQLxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:53:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 04:21:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,365,1526367600"; 
   d="scan'208";a="57138270"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 17 Jul 2018 04:21:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id BA0A9309; Tue, 17 Jul 2018 14:21:48 +0300 (EEST)
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
Subject: [PATCHv5 02/19] mm: Do not use zero page in encrypted pages
Date:   Tue, 17 Jul 2018 14:20:12 +0300
Message-Id: <20180717112029.42378-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
References: <20180717112029.42378-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero page is not encrypted and putting it into encrypted VMA produces
garbage.

We can map zero page with KeyID-0 into an encrypted VMA, but this would
be violation security boundary between encryption domains.

Forbid zero pages in encrypted VMAs.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/s390/include/asm/pgtable.h | 2 +-
 include/linux/mm.h              | 4 ++--
 mm/huge_memory.c                | 3 +--
 mm/memory.c                     | 3 +--
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 5ab636089c60..2e8658962aae 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -505,7 +505,7 @@ static inline int mm_alloc_pgste(struct mm_struct *mm)
  * In the case that a guest uses storage keys
  * faults should no longer be backed by zero pages
  */
-#define mm_forbids_zeropage mm_has_pgste
+#define vma_forbids_zeropage(vma) mm_has_pgste(vma->vm_mm)
 static inline int mm_uses_skeys(struct mm_struct *mm)
 {
 #ifdef CONFIG_PGSTE
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c8780c5835ad..151d6e6b16e5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -92,8 +92,8 @@ extern int mmap_rnd_compat_bits __read_mostly;
  * s390 does this to prevent multiplexing of hardware bits
  * related to the physical page in case of virtualization.
  */
-#ifndef mm_forbids_zeropage
-#define mm_forbids_zeropage(X)	(0)
+#ifndef vma_forbids_zeropage
+#define vma_forbids_zeropage(vma)	vma_keyid(vma)
 #endif
 
 /*
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1cd7c1a57a14..83f096c7299b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -676,8 +676,7 @@ int do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 		return VM_FAULT_OOM;
 	if (unlikely(khugepaged_enter(vma, vma->vm_flags)))
 		return VM_FAULT_OOM;
-	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
-			!mm_forbids_zeropage(vma->vm_mm) &&
+	if (!(vmf->flags & FAULT_FLAG_WRITE) && !vma_forbids_zeropage(vma) &&
 			transparent_hugepage_use_zero_page()) {
 		pgtable_t pgtable;
 		struct page *zero_page;
diff --git a/mm/memory.c b/mm/memory.c
index 02fbef2bd024..a705637d2ded 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3139,8 +3139,7 @@ static int do_anonymous_page(struct vm_fault *vmf)
 		return 0;
 
 	/* Use the zero-page for reads */
-	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
-			!mm_forbids_zeropage(vma->vm_mm)) {
+	if (!(vmf->flags & FAULT_FLAG_WRITE) && !vma_forbids_zeropage(vma)) {
 		entry = pte_mkspecial(pfn_pte(my_zero_pfn(vmf->address),
 						vma->vm_page_prot));
 		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-- 
2.18.0

