Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F27CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D9520658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D9520658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeH3USn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:18:43 -0400
Received: from foss.arm.com ([217.140.101.70]:44846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbeH3USm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:18:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE964174E;
        Thu, 30 Aug 2018 09:15:49 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B01633F557;
        Thu, 30 Aug 2018 09:15:49 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 58BE71AE3700; Thu, 30 Aug 2018 17:16:01 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, benh@au1.ibm.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 05/12] arm64: tlbflush: Allow stride to be specified for __flush_tlb_range()
Date:   Thu, 30 Aug 2018 17:15:39 +0100
Message-Id: <1535645747-9823-6-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we are unmapping intermediate page-table entries or huge pages, we
don't need to issue a TLBI instruction for every PAGE_SIZE chunk in the
VA range being unmapped.

Allow the invalidation stride to be passed to __flush_tlb_range(), and
adjust our "just nuke the ASID" heuristic to take this into account.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/tlb.h      |  2 +-
 arch/arm64/include/asm/tlbflush.h | 15 +++++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index a3233167be60..1e1f68ce28f4 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -53,7 +53,7 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 	 * the __(pte|pmd|pud)_free_tlb() functions, so last level
 	 * TLBI is sufficient here.
 	 */
-	__flush_tlb_range(&vma, tlb->start, tlb->end, true);
+	__flush_tlb_range(&vma, tlb->start, tlb->end, PAGE_SIZE, true);
 }
 
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index ddbf1718669d..37ccdb246b20 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -149,25 +149,28 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
  * This is meant to avoid soft lock-ups on large TLB flushing ranges and not
  * necessarily a performance improvement.
  */
-#define MAX_TLB_RANGE	(1024UL << PAGE_SHIFT)
+#define MAX_TLBI_OPS	1024UL
 
 static inline void __flush_tlb_range(struct vm_area_struct *vma,
 				     unsigned long start, unsigned long end,
-				     bool last_level)
+				     unsigned long stride, bool last_level)
 {
 	unsigned long asid = ASID(vma->vm_mm);
 	unsigned long addr;
 
-	if ((end - start) > MAX_TLB_RANGE) {
+	if ((end - start) > (MAX_TLBI_OPS * stride)) {
 		flush_tlb_mm(vma->vm_mm);
 		return;
 	}
 
+	/* Convert the stride into units of 4k */
+	stride >>= 12;
+
 	start = __TLBI_VADDR(start, asid);
 	end = __TLBI_VADDR(end, asid);
 
 	dsb(ishst);
-	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12)) {
+	for (addr = start; addr < end; addr += stride) {
 		if (last_level) {
 			__tlbi(vale1is, addr);
 			__tlbi_user(vale1is, addr);
@@ -186,14 +189,14 @@ static inline void flush_tlb_range(struct vm_area_struct *vma,
 	 * We cannot use leaf-only invalidation here, since we may be invalidating
 	 * table entries as part of collapsing hugepages or moving page tables.
 	 */
-	__flush_tlb_range(vma, start, end, false);
+	__flush_tlb_range(vma, start, end, PAGE_SIZE, false);
 }
 
 static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
 	unsigned long addr;
 
-	if ((end - start) > MAX_TLB_RANGE) {
+	if ((end - start) > (MAX_TLBI_OPS * PAGE_SIZE)) {
 		flush_tlb_all();
 		return;
 	}
-- 
2.1.4

