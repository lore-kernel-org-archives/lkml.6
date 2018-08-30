Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A02AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F62720658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F62720658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbeH3USn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:18:43 -0400
Received: from foss.arm.com ([217.140.101.70]:44902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbeH3USn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:18:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 178FE1BB2;
        Thu, 30 Aug 2018 09:15:50 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DD25C3F994;
        Thu, 30 Aug 2018 09:15:49 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id B45241AE3A87; Thu, 30 Aug 2018 17:16:01 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, benh@au1.ibm.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 10/12] arm64: tlb: Adjust stride and type of TLBI according to mmu_gather
Date:   Thu, 30 Aug 2018 17:15:44 +0100
Message-Id: <1535645747-9823-11-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the core mmu_gather code keeps track of both the levels of page
table cleared and also whether or not these entries correspond to
intermediate entries, we can use this in our tlb_flush() callback to
reduce the number of invalidations we issue as well as their scope.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/tlb.h | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index bd00017d529a..b078fdec10d5 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -34,20 +34,21 @@ static void tlb_flush(struct mmu_gather *tlb);
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 	struct vm_area_struct vma = TLB_FLUSH_VMA(tlb->mm, 0);
+	bool last_level = !tlb->freed_tables;
+	unsigned long stride = tlb_get_unmap_size(tlb);
 
 	/*
-	 * The ASID allocator will either invalidate the ASID or mark
-	 * it as used.
+	 * If we're tearing down the address space then we only care about
+	 * invalidating the walk-cache, since the ASID allocator won't
+	 * reallocate our ASID without invalidating the entire TLB.
 	 */
-	if (tlb->fullmm)
+	if (tlb->fullmm) {
+		if (!last_level)
+			flush_tlb_mm(tlb->mm);
 		return;
+	}
 
-	/*
-	 * The intermediate page table levels are already handled by
-	 * the __(pte|pmd|pud)_free_tlb() functions, so last level
-	 * TLBI is sufficient here.
-	 */
-	__flush_tlb_range(&vma, tlb->start, tlb->end, PAGE_SIZE, true);
+	__flush_tlb_range(&vma, tlb->start, tlb->end, stride, last_level);
 }
 
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
-- 
2.1.4

