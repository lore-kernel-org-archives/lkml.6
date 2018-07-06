Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45552C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08DD22ACC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08DD22ACC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933057AbeGFV5R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:57:17 -0400
Received: from shelob.surriel.com ([96.67.55.147]:35248 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932765AbeGFV5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:57:13 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fbYir-0003ql-P4; Fri, 06 Jul 2018 17:57:01 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, kernel-team@fb.com, tglx@linutronix.de,
        efault@gmx.de, songliubraving@fb.com, hpa@zytor.com,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 2/7] x86,tlb: leave lazy TLB mode at page table free time
Date:   Fri,  6 Jul 2018 17:56:53 -0400
Message-Id: <20180706215658.18018-3-riel@surriel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180706215658.18018-1-riel@surriel.com>
References: <20180706215658.18018-1-riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy discovered that speculative memory accesses while in lazy
TLB mode can crash a system, when a CPU tries to dereference a
speculative access using memory contents that used to be valid
page table memory, but have since been reused for something else
and point into la-la land.

The latter problem can be prevented in two ways. The first is to
always send a TLB shootdown IPI to CPUs in lazy TLB mode, while
the second one is to only send the TLB shootdown at page table
freeing time.

The second should result in fewer IPIs, since operationgs like
mprotect and madvise are very common with some workloads, but
do not involve page table freeing. Also, on munmap, batching
of page table freeing covers much larger ranges of virtual
memory than the batching of unmapped user pages.

Signed-off-by: Rik van Riel <riel@surriel.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Tested-by: Song Liu <songliubraving@fb.com>
---
 arch/x86/include/asm/tlbflush.h |  5 +++++
 arch/x86/mm/tlb.c               | 27 +++++++++++++++++++++++++++
 include/asm-generic/tlb.h       | 10 ++++++++++
 mm/memory.c                     | 22 ++++++++++++++--------
 4 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 6690cd3fc8b1..3aa3204b5dc0 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -554,4 +554,9 @@ extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 	native_flush_tlb_others(mask, info)
 #endif
 
+extern void tlb_flush_remove_tables(struct mm_struct *mm);
+extern void tlb_flush_remove_tables_local(void *arg);
+
+#define HAVE_TLB_FLUSH_REMOVE_TABLES
+
 #endif /* _ASM_X86_TLBFLUSH_H */
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 6eb1f34c3c85..9a893673c56b 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -646,6 +646,33 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	put_cpu();
 }
 
+void tlb_flush_remove_tables_local(void *arg)
+{
+	struct mm_struct *mm = arg;
+
+	if (this_cpu_read(cpu_tlbstate.loaded_mm) == mm &&
+			this_cpu_read(cpu_tlbstate.is_lazy)) {
+		/*
+		 * We're in lazy mode.  We need to at least flush our
+		 * paging-structure cache to avoid speculatively reading
+		 * garbage into our TLB.  Since switching to init_mm is barely
+		 * slower than a minimal flush, just switch to init_mm.
+		 */
+		switch_mm_irqs_off(NULL, &init_mm, NULL);
+	}
+}
+
+void tlb_flush_remove_tables(struct mm_struct *mm)
+{
+	int cpu = get_cpu();
+	/*
+	 * XXX: this really only needs to be called for CPUs in lazy TLB mode.
+	 */
+	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
+		smp_call_function_many(mm_cpumask(mm), tlb_flush_remove_tables_local, (void *)mm, 1);
+
+	put_cpu();
+}
 
 static void do_flush_tlb_all(void *info)
 {
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index faddde44de8c..f0b462ddfa15 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -295,4 +295,14 @@ static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
 
 #define tlb_migrate_finish(mm) do {} while (0)
 
+/*
+ * Used to flush the TLB when page tables are removed, when lazy
+ * TLB mode may cause a CPU to retain intermediate translations
+ * pointing to about-to-be-freed page table memory.
+ */
+#ifndef HAVE_TLB_FLUSH_REMOVE_TABLES
+#define tlb_flush_remove_tables(mm) do {} while (0)
+#define tlb_flush_remove_tables_local(mm) do {} while (0)
+#endif
+
 #endif /* _ASM_GENERIC__TLB_H */
diff --git a/mm/memory.c b/mm/memory.c
index 9d472e00fc2d..b4117272dc7f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -326,16 +326,20 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_
 
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
 
-/*
- * See the comment near struct mmu_table_batch.
- */
-
 static void tlb_remove_table_smp_sync(void *arg)
 {
-	/* Simply deliver the interrupt */
+	struct mm_struct __maybe_unused *mm = arg;
+	/*
+	 * On most architectures this does nothing. Simply delivering the
+	 * interrupt is enough to prevent races with software page table
+	 * walking like that done in get_user_pages_fast.
+	 *
+	 * See the comment near struct mmu_table_batch.
+	 */
+	tlb_flush_remove_tables_local(mm);
 }
 
-static void tlb_remove_table_one(void *table)
+static void tlb_remove_table_one(void *table, struct mmu_gather *tlb)
 {
 	/*
 	 * This isn't an RCU grace period and hence the page-tables cannot be
@@ -344,7 +348,7 @@ static void tlb_remove_table_one(void *table)
 	 * It is however sufficient for software page-table walkers that rely on
 	 * IRQ disabling. See the comment near struct mmu_table_batch.
 	 */
-	smp_call_function(tlb_remove_table_smp_sync, NULL, 1);
+	smp_call_function(tlb_remove_table_smp_sync, tlb->mm, 1);
 	__tlb_remove_table(table);
 }
 
@@ -365,6 +369,8 @@ void tlb_table_flush(struct mmu_gather *tlb)
 {
 	struct mmu_table_batch **batch = &tlb->batch;
 
+	tlb_flush_remove_tables(tlb->mm);
+
 	if (*batch) {
 		call_rcu_sched(&(*batch)->rcu, tlb_remove_table_rcu);
 		*batch = NULL;
@@ -387,7 +393,7 @@ void tlb_remove_table(struct mmu_gather *tlb, void *table)
 	if (*batch == NULL) {
 		*batch = (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
 		if (*batch == NULL) {
-			tlb_remove_table_one(table);
+			tlb_remove_table_one(table, tlb);
 			return;
 		}
 		(*batch)->nr = 0;
-- 
2.14.4

