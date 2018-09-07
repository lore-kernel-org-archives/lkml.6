Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC70C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCAB2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCAB2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbeIHB4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:56:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40754 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbeIHB4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:56:10 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DE8FAF07;
        Fri,  7 Sep 2018 21:13:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.18 027/145] powerpc/64s: Fix page table fragment refcount race vs speculative references
Date:   Fri,  7 Sep 2018 23:08:13 +0200
Message-Id: <20180907210906.048696408@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit 4231aba000f5a4583dd9f67057aadb68c3eca99d upstream.

The page table fragment allocator uses the main page refcount racily
with respect to speculative references. A customer observed a BUG due
to page table page refcount underflow in the fragment allocator. This
can be caused by the fragment allocator set_page_count stomping on a
speculative reference, and then the speculative failure handler
decrements the new reference, and the underflow eventually pops when
the page tables are freed.

Fix this by using a dedicated field in the struct page for the page
table fragment allocator.

Fixes: 5c1f6ee9a31c ("powerpc: Reduce PTE table memory wastage")
Cc: stable@vger.kernel.org # v3.10+
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/mmu_context_book3s64.c |    8 ++++----
 arch/powerpc/mm/pgtable-book3s64.c     |   17 +++++++++++------
 include/linux/mm_types.h               |    5 ++++-
 3 files changed, 19 insertions(+), 11 deletions(-)

--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -200,9 +200,9 @@ static void pte_frag_destroy(void *pte_f
 	/* drop all the pending references */
 	count = ((unsigned long)pte_frag & ~PAGE_MASK) >> PTE_FRAG_SIZE_SHIFT;
 	/* We allow PTE_FRAG_NR fragments from a PTE page */
-	if (page_ref_sub_and_test(page, PTE_FRAG_NR - count)) {
+	if (atomic_sub_and_test(PTE_FRAG_NR - count, &page->pt_frag_refcount)) {
 		pgtable_page_dtor(page);
-		free_unref_page(page);
+		__free_page(page);
 	}
 }
 
@@ -215,9 +215,9 @@ static void pmd_frag_destroy(void *pmd_f
 	/* drop all the pending references */
 	count = ((unsigned long)pmd_frag & ~PAGE_MASK) >> PMD_FRAG_SIZE_SHIFT;
 	/* We allow PTE_FRAG_NR fragments from a PTE page */
-	if (page_ref_sub_and_test(page, PMD_FRAG_NR - count)) {
+	if (atomic_sub_and_test(PMD_FRAG_NR - count, &page->pt_frag_refcount)) {
 		pgtable_pmd_page_dtor(page);
-		free_unref_page(page);
+		__free_page(page);
 	}
 }
 
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -270,6 +270,8 @@ static pmd_t *__alloc_for_pmdcache(struc
 		return NULL;
 	}
 
+	atomic_set(&page->pt_frag_refcount, 1);
+
 	ret = page_address(page);
 	/*
 	 * if we support only one fragment just return the
@@ -285,7 +287,7 @@ static pmd_t *__alloc_for_pmdcache(struc
 	 * count.
 	 */
 	if (likely(!mm->context.pmd_frag)) {
-		set_page_count(page, PMD_FRAG_NR);
+		atomic_set(&page->pt_frag_refcount, PMD_FRAG_NR);
 		mm->context.pmd_frag = ret + PMD_FRAG_SIZE;
 	}
 	spin_unlock(&mm->page_table_lock);
@@ -308,9 +310,10 @@ void pmd_fragment_free(unsigned long *pm
 {
 	struct page *page = virt_to_page(pmd);
 
-	if (put_page_testzero(page)) {
+	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
+	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
 		pgtable_pmd_page_dtor(page);
-		free_unref_page(page);
+		__free_page(page);
 	}
 }
 
@@ -352,6 +355,7 @@ static pte_t *__alloc_for_ptecache(struc
 			return NULL;
 	}
 
+	atomic_set(&page->pt_frag_refcount, 1);
 
 	ret = page_address(page);
 	/*
@@ -367,7 +371,7 @@ static pte_t *__alloc_for_ptecache(struc
 	 * count.
 	 */
 	if (likely(!mm->context.pte_frag)) {
-		set_page_count(page, PTE_FRAG_NR);
+		atomic_set(&page->pt_frag_refcount, PTE_FRAG_NR);
 		mm->context.pte_frag = ret + PTE_FRAG_SIZE;
 	}
 	spin_unlock(&mm->page_table_lock);
@@ -390,10 +394,11 @@ void pte_fragment_free(unsigned long *ta
 {
 	struct page *page = virt_to_page(table);
 
-	if (put_page_testzero(page)) {
+	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
+	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
 		if (!kernel)
 			pgtable_page_dtor(page);
-		free_unref_page(page);
+		__free_page(page);
 	}
 }
 
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -139,7 +139,10 @@ struct page {
 			unsigned long _pt_pad_1;	/* compound_head */
 			pgtable_t pmd_huge_pte; /* protected by page->ptl */
 			unsigned long _pt_pad_2;	/* mapping */
-			struct mm_struct *pt_mm;	/* x86 pgds only */
+			union {
+				struct mm_struct *pt_mm; /* x86 pgds only */
+				atomic_t pt_frag_refcount; /* powerpc */
+			};
 #if ALLOC_SPLIT_PTLOCKS
 			spinlock_t *ptl;
 #else


