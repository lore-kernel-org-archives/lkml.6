Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C311BC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BDB21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BDB21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeJIWSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:18:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58083 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbeJIWSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:18:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w99F0NXI1081429
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Oct 2018 08:00:23 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w99F0NXE1081416;
        Tue, 9 Oct 2018 08:00:23 -0700
Date:   Tue, 9 Oct 2018 08:00:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rik van Riel <tipbot@zytor.com>
Message-ID: <tip-016c4d92cd16f569c6485ae62b076c1a4b779536@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org,
        mingo@kernel.org, tglx@linutronix.de, riel@surriel.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          peterz@infradead.org, mingo@kernel.org, riel@surriel.com
In-Reply-To: <20180926035844.1420-6-riel@surriel.com>
References: <20180926035844.1420-6-riel@surriel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/tlb: Add freed_tables argument to
 flush_tlb_mm_range
Git-Commit-ID: 016c4d92cd16f569c6485ae62b076c1a4b779536
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

Commit-ID:  016c4d92cd16f569c6485ae62b076c1a4b779536
Gitweb:     https://git.kernel.org/tip/016c4d92cd16f569c6485ae62b076c1a4b779536
Author:     Rik van Riel <riel@surriel.com>
AuthorDate: Tue, 25 Sep 2018 23:58:42 -0400
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Tue, 9 Oct 2018 16:51:12 +0200

x86/mm/tlb: Add freed_tables argument to flush_tlb_mm_range

Add an argument to flush_tlb_mm_range to indicate whether page tables
are about to be freed after this TLB flush. This allows for an
optimization of flush_tlb_mm_range to skip CPUs in lazy TLB mode.

No functional changes.

Cc: npiggin@gmail.com
Cc: mingo@kernel.org
Cc: will.deacon@arm.com
Cc: songliubraving@fb.com
Cc: kernel-team@fb.com
Cc: luto@kernel.org
Cc: hpa@zytor.com
Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180926035844.1420-6-riel@surriel.com
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
index 7fdb2414ca65..ab18e0884dc6 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -273,7 +273,7 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 	map_ldt_struct_to_user(mm);
 
 	va = (unsigned long)ldt_slot_va(slot);
-	flush_tlb_mm_range(mm, va, va + LDT_SLOT_STRIDE, PAGE_SHIFT);
+	flush_tlb_mm_range(mm, va, va + LDT_SLOT_STRIDE, PAGE_SHIFT, false);
 
 	ldt->slot = slot;
 	return 0;
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index 52fed70f671e..c2fd39752da8 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -199,7 +199,7 @@ static void mark_screen_rdonly(struct mm_struct *mm)
 	pte_unmap_unlock(pte, ptl);
 out:
 	up_write(&mm->mmap_sem);
-	flush_tlb_mm_range(mm, 0xA0000, 0xA0000 + 32*PAGE_SIZE, PAGE_SHIFT);
+	flush_tlb_mm_range(mm, 0xA0000, 0xA0000 + 32*PAGE_SIZE, PAGE_SHIFT, false);
 }
 
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 9fb30d27854b..14bf39fc0447 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -609,7 +609,8 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 static unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
 
 void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
-				unsigned long end, unsigned int stride_shift)
+				unsigned long end, unsigned int stride_shift,
+				bool freed_tables)
 {
 	int cpu;
 
