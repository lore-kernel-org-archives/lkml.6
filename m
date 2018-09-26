Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E03C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5177214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5177214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbeIZKJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 06:09:53 -0400
Received: from shelob.surriel.com ([96.67.55.147]:49952 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbeIZKJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 06:09:53 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1g50yN-0006sG-VE; Tue, 25 Sep 2018 23:58:47 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kernel-team@fb.com, will.deacon@arm.com,
        songliubraving@fb.com, mingo@kernel.org, luto@kernel.org,
        hpa@zytor.com, npiggin@gmail.com, Rik van Riel <riel@surriel.com>
Subject: [PATCH 5/7] Add freed_tables argument to flush_tlb_mm_range
Date:   Tue, 25 Sep 2018 23:58:42 -0400
Message-Id: <20180926035844.1420-6-riel@surriel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926035844.1420-1-riel@surriel.com>
References: <20180926035844.1420-1-riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an argument to flush_tlb_mm_range to indicate whether page tables
are about to be freed after this TLB flush. This allows for an
optimization of flush_tlb_mm_range to skip CPUs in lazy TLB mode.

No functional changes.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 arch/x86/include/asm/tlb.h      |  2 +-
 arch/x86/include/asm/tlbflush.h | 10 ++++++----
 arch/x86/kernel/ldt.c           |  2 +-
 arch/x86/kernel/vm86_32.c       |  2 +-
 arch/x86/mm/tlb.c               |  3 ++-
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index afbe7d1e68cf..404b8b1d44f5 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -20,7 +20,7 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 		end = tlb->end;
 	}
 
-	flush_tlb_mm_range(tlb->mm, start, end, stride_shift);
+	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
 }
 
 /*
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index d6c0cd9e9591..1dea9860ce5b 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -536,22 +536,24 @@ struct flush_tlb_info {
 
 #define local_flush_tlb() __flush_tlb()
 
-#define flush_tlb_mm(mm)	flush_tlb_mm_range(mm, 0UL, TLB_FLUSH_ALL, 0UL)
+#define flush_tlb_mm(mm)						\
+		flush_tlb_mm_range(mm, 0UL, TLB_FLUSH_ALL, 0UL, true)
 
 #define flush_tlb_range(vma, start, end)				\
 	flush_tlb_mm_range((vma)->vm_mm, start, end,			\
 			   ((vma)->vm_flags & VM_HUGETLB)		\
 				? huge_page_shift(hstate_vma(vma))	\
-				: PAGE_SHIFT)
+				: PAGE_SHIFT, false)
 
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
-				unsigned long end, unsigned int stride_shift);
+				unsigned long end, unsigned int stride_shift,
+				bool freed_tables);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
 static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
 {
-	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, PAGE_SHIFT);
+	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, PAGE_SHIFT, false);
 }
 
 void native_flush_tlb_others(const struct cpumask *cpumask,
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 733e6ace0fa4..91eae79ef686 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -273,7 +273,7 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 	map_ldt_struct_to_user(mm);
 
 	va = (unsigned long)ldt_slot_va(slot);
-	flush_tlb_mm_range(mm, va, va + LDT_SLOT_STRIDE, 0);
+	flush_tlb_mm_range(mm, va, va + LDT_SLOT_STRIDE, 0, false);
 
 	ldt->slot = slot;
 	return 0;
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index 1c03e4aa6474..91460acbb650 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -199,7 +199,7 @@ static void mark_screen_rdonly(struct mm_struct *mm)
 	pte_unmap_unlock(pte, ptl);
 out:
 	up_write(&mm->mmap_sem);
-	flush_tlb_mm_range(mm, 0xA0000, 0xA0000 + 32*PAGE_SIZE, 0UL);
+	flush_tlb_mm_range(mm, 0xA0000, 0xA0000 + 32*PAGE_SIZE, 0UL, false);
 }
 
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 1224f7fb1311..1d74fbc71ad6 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -611,7 +611,8 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 static unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
 
 void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
-				unsigned long end, unsigned int stride_shift)
+				unsigned long end, unsigned int stride_shift,
+				bool freed_tables)
 {
 	int cpu;
 
-- 
2.17.1

