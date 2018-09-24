Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DA8ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00002098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00002098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387441AbeIYAlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:41:46 -0400
Received: from shelob.surriel.com ([96.67.55.147]:36314 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbeIYAlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:41:44 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1g4VkD-0002qj-TD; Mon, 24 Sep 2018 14:38:05 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kernel-team@fb.com, songliubraving@fb.com,
        mingo@kernel.org, will.deacon@arm.com, hpa@zytor.com,
        luto@kernel.org, npiggin@gmail.com, Rik van Riel <riel@surriel.com>
Subject: [PATCH 5/7] Add freed_tables argument to flush_tlb_mm_range
Date:   Mon, 24 Sep 2018 14:37:57 -0400
Message-Id: <20180924183759.23955-6-riel@surriel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180924183759.23955-1-riel@surriel.com>
References: <20180924183759.23955-1-riel@surriel.com>
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
 arch/x86/include/asm/tlb.h      |  6 ++++--
 arch/x86/include/asm/tlbflush.h | 12 ++++++++----
 arch/x86/kernel/ldt.c           |  2 +-
 arch/x86/kernel/vm86_32.c       |  2 +-
 arch/x86/mm/tlb.c               |  3 ++-
 5 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index cb0a1f470980..b9237a1f567f 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -9,9 +9,11 @@
 #define tlb_flush(tlb)							\
 {									\
 	if (!tlb->fullmm && !tlb->need_flush_all) 			\
-		flush_tlb_mm_range(tlb->mm, tlb->start, tlb->end, 0UL);	\
+		flush_tlb_mm_range(tlb->mm, tlb->start, tlb->end, 0UL,	\
+				tlb->freed_tables);	\
 	else								\
-		flush_tlb_mm_range(tlb->mm, 0UL, TLB_FLUSH_ALL, 0UL);	\
+		flush_tlb_mm_range(tlb->mm, 0UL, TLB_FLUSH_ALL, 0UL,	\
+				tlb->freed_tables);	\
 }
 
 #include <asm-generic/tlb.h>
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 82898cd3d933..ae1ef755cb94 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -515,19 +515,23 @@ struct flush_tlb_info {
 
 #define local_flush_tlb() __flush_tlb()
 
-#define flush_tlb_mm(mm)	flush_tlb_mm_range(mm, 0UL, TLB_FLUSH_ALL, 0UL)
+/* Simultaneous unmap operations could have freed page tables. */
+#define flush_tlb_mm(mm)			\
+		flush_tlb_mm_range(mm, 0UL, TLB_FLUSH_ALL, 0UL, true)
 
+/* The operations calling flush_tlb_range do not free page tables. */
 #define flush_tlb_range(vma, start, end)	\
-		flush_tlb_mm_range(vma->vm_mm, start, end, vma->vm_flags)
+		flush_tlb_mm_range(vma->vm_mm, start, end, vma->vm_flags, false)
 
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
-				unsigned long end, unsigned long vmflag);
+				unsigned long end, unsigned long vmflag,
+				bool freed_tables);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
 static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
 {
-	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, VM_NONE);
+	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, VM_NONE, false);
 }
 
 void native_flush_tlb_others(const struct cpumask *cpumask,
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 26d713ecad34..2c2291fa14b3 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -190,7 +190,7 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 	}
 
 	va = (unsigned long)ldt_slot_va(slot);
-	flush_tlb_mm_range(mm, va, va + LDT_SLOT_STRIDE, 0);
+	flush_tlb_mm_range(mm, va, va + LDT_SLOT_STRIDE, 0, false);
 
 	ldt->slot = slot;
 #endif
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index 5edb27f1a2c4..51024424dfbe 100644
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
index ac05d61cc90e..62f147b0f6b7 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -571,7 +571,8 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 static unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
 
 void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
-				unsigned long end, unsigned long vmflag)
+				unsigned long end, unsigned long vmflag,
+				bool freed_tables)
 {
 	int cpu;
 
-- 
2.17.1

