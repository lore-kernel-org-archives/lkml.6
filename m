Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2ECECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B0E21479
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcV2mxXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B0E21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbeKIHhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:37:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730348AbeKIHhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:38 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47DCC20989;
        Thu,  8 Nov 2018 22:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714409;
        bh=iLn1hPMd6yYCMsViSjryJtilPKUesG4FPOnhOQlA0Y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EcV2mxXrTULEtFkrRD47cI9G6JfSRheuvO18Vhqp7EAcM2PnloQP6ztq5ZWWIiY7K
         /KdavX+FBGKxZSU+U7STxiXrwp/ctvm3YT1bQ7fNbcwz68gIdnt6/aAtff2BDmKuCA
         m51iWH0eDg8xdeBzdW7yXZ1d4QPviCsxsCeMzxjs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Kravetz <mike.kravetz@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 066/114] sparc64 mm: Fix more TSB sizing issues
Date:   Thu,  8 Nov 2018 13:51:21 -0800
Message-Id: <20181108215107.032409611@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 1e953d846ac015fbfcf09c857e8f893924cb629c ]

Commit af1b1a9b36b8 ("sparc64 mm: Fix base TSB sizing when hugetlb
pages are used") addressed the difference between hugetlb and THP
pages when computing TSB sizes.  The following additional issues
were also discovered while working with the code.

In order to save memory, THP makes use of a huge zero page.  This huge
zero page does not count against a task's RSS, but it does consume TSB
entries.  This is similar to hugetlb pages.  Therefore, count huge
zero page entries in hugetlb_pte_count.

Accounting of THP pages is done in the routine set_pmd_at().
Unfortunately, this does not catch the case where a THP page is split.
To handle this case, decrement the count in pmdp_invalidate().
pmdp_invalidate is only called when splitting a THP.  However, 'sanity
checks' are added in case it is ever called for other purposes.

A more general issue exists with HPAGE_SIZE accounting.
hugetlb_pte_count tracks the number of HPAGE_SIZE (8M) pages.  This
value is used to size the TSB for HPAGE_SIZE pages.  However,
each HPAGE_SIZE page consists of two REAL_HPAGE_SIZE (4M) pages.
The TSB contains an entry for each REAL_HPAGE_SIZE page.  Therefore,
the number of REAL_HPAGE_SIZE pages should be used to size the huge
page TSB.  A new compile time constant REAL_HPAGE_PER_HPAGE is used
to multiply hugetlb_pte_count before sizing the TSB.

Changes from V1
- Fixed build issue if hugetlb or THP not configured

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/include/asm/page_64.h |  1 +
 arch/sparc/mm/fault_64.c         |  1 +
 arch/sparc/mm/tlb.c              | 35 ++++++++++++++++++++++++++++----
 arch/sparc/mm/tsb.c              | 18 ++++++++++------
 4 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/include/asm/page_64.h b/arch/sparc/include/asm/page_64.h
index 8c2a8c937540..c1263fc390db 100644
--- a/arch/sparc/include/asm/page_64.h
+++ b/arch/sparc/include/asm/page_64.h
@@ -25,6 +25,7 @@
 #define HPAGE_MASK		(~(HPAGE_SIZE - 1UL))
 #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
+#define REAL_HPAGE_PER_HPAGE	(_AC(1,UL) << (HPAGE_SHIFT - REAL_HPAGE_SHIFT))
 #endif
 
 #ifndef __ASSEMBLY__
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index e15f33715103..b01ec72522cb 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -487,6 +487,7 @@ good_area:
 		tsb_grow(mm, MM_TSB_BASE, mm_rss);
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	mm_rss = mm->context.hugetlb_pte_count + mm->context.thp_pte_count;
+	mm_rss *= REAL_HPAGE_PER_HPAGE;
 	if (unlikely(mm_rss >
 		     mm->context.tsb_block[MM_TSB_HUGE].tsb_rss_limit)) {
 		if (mm->context.tsb_block[MM_TSB_HUGE].tsb)
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 3659d37b4d81..c56a195c9071 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -174,10 +174,25 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 		return;
 
 	if ((pmd_val(pmd) ^ pmd_val(orig)) & _PAGE_PMD_HUGE) {
-		if (pmd_val(pmd) & _PAGE_PMD_HUGE)
-			mm->context.thp_pte_count++;
-		else
-			mm->context.thp_pte_count--;
+		/*
+		 * Note that this routine only sets pmds for THP pages.
+		 * Hugetlb pages are handled elsewhere.  We need to check
+		 * for huge zero page.  Huge zero pages are like hugetlb
+		 * pages in that there is no RSS, but there is the need
+		 * for TSB entries.  So, huge zero page counts go into
+		 * hugetlb_pte_count.
+		 */
+		if (pmd_val(pmd) & _PAGE_PMD_HUGE) {
+			if (is_huge_zero_page(pmd_page(pmd)))
+				mm->context.hugetlb_pte_count++;
+			else
+				mm->context.thp_pte_count++;
+		} else {
+			if (is_huge_zero_page(pmd_page(orig)))
+				mm->context.hugetlb_pte_count--;
+			else
+				mm->context.thp_pte_count--;
+		}
 
 		/* Do not try to allocate the TSB hash table if we
 		 * don't have one already.  We have various locks held
@@ -204,6 +219,9 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 	}
 }
 
+/*
+ * This routine is only called when splitting a THP
+ */
 void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 		     pmd_t *pmdp)
 {
@@ -213,6 +231,15 @@ void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 
 	set_pmd_at(vma->vm_mm, address, pmdp, entry);
 	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+
+	/*
+	 * set_pmd_at() will not be called in a way to decrement
+	 * thp_pte_count when splitting a THP, so do it now.
+	 * Sanity check pmd before doing the actual decrement.
+	 */
+	if ((pmd_val(entry) & _PAGE_PMD_HUGE) &&
+	    !is_huge_zero_page(pmd_page(entry)))
+		(vma->vm_mm)->context.thp_pte_count--;
 }
 
 void pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index 266411291634..84cd593117a6 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -489,8 +489,10 @@ retry_tsb_alloc:
 
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
+	unsigned long mm_rss = get_mm_rss(mm);
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
-	unsigned long total_huge_pte_count;
+	unsigned long saved_hugetlb_pte_count;
+	unsigned long saved_thp_pte_count;
 #endif
 	unsigned int i;
 
@@ -503,10 +505,12 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	 * will re-increment the counters as the parent PTEs are
 	 * copied into the child address space.
 	 */
-	total_huge_pte_count = mm->context.hugetlb_pte_count +
-			 mm->context.thp_pte_count;
+	saved_hugetlb_pte_count = mm->context.hugetlb_pte_count;
+	saved_thp_pte_count = mm->context.thp_pte_count;
 	mm->context.hugetlb_pte_count = 0;
 	mm->context.thp_pte_count = 0;
+
+	mm_rss -= saved_thp_pte_count * (HPAGE_SIZE / PAGE_SIZE);
 #endif
 
 	/* copy_mm() copies over the parent's mm_struct before calling
@@ -519,11 +523,13 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	/* If this is fork, inherit the parent's TSB size.  We would
 	 * grow it to that size on the first page fault anyways.
 	 */
-	tsb_grow(mm, MM_TSB_BASE, get_mm_rss(mm));
+	tsb_grow(mm, MM_TSB_BASE, mm_rss);
 
 #if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
-	if (unlikely(total_huge_pte_count))
-		tsb_grow(mm, MM_TSB_HUGE, total_huge_pte_count);
+	if (unlikely(saved_hugetlb_pte_count + saved_thp_pte_count))
+		tsb_grow(mm, MM_TSB_HUGE,
+			 (saved_hugetlb_pte_count + saved_thp_pte_count) *
+			 REAL_HPAGE_PER_HPAGE);
 #endif
 
 	if (unlikely(!mm->context.tsb_block[MM_TSB_BASE].tsb))
-- 
2.17.1



