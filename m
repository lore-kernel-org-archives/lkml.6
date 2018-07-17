Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E728ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA4E20BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA4E20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbeGQKGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:06:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37685 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729602AbeGQKGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:06:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6H9Y7641463334
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 02:34:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6H9Y7cl1463331;
        Tue, 17 Jul 2018 02:34:07 -0700
Date:   Tue, 17 Jul 2018 02:34:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rik van Riel <tipbot@zytor.com>
Message-ID: <tip-2ff6ddf19c0ec40633bd14d8fe28a289816bd98d@git.kernel.org>
Cc:     dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, hpa@zytor.com, riel@surriel.com,
        mingo@kernel.org, torvalds@linux-foundation.org,
        songliubraving@fb.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, mingo@kernel.org, songliubraving@fb.com,
          torvalds@linux-foundation.org, riel@surriel.com, hpa@zytor.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          dave.hansen@intel.com
In-Reply-To: <20180716190337.26133-3-riel@surriel.com>
References: <20180716190337.26133-3-riel@surriel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/tlb: Leave lazy TLB mode at page table free
 time
Git-Commit-ID: 2ff6ddf19c0ec40633bd14d8fe28a289816bd98d
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

Commit-ID:  2ff6ddf19c0ec40633bd14d8fe28a289816bd98d
Gitweb:     https://git.kernel.org/tip/2ff6ddf19c0ec40633bd14d8fe28a289816bd98d
Author:     Rik van Riel <riel@surriel.com>
AuthorDate: Mon, 16 Jul 2018 15:03:32 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 17 Jul 2018 09:35:31 +0200

x86/mm/tlb: Leave lazy TLB mode at page table free time

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

Tested-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: efault@gmx.de
Cc: kernel-team@fb.com
Cc: luto@kernel.org
Link: http://lkml.kernel.org/r/20180716190337.26133-3-riel@surriel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
index 3063125197ad..e811ef7b8350 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -303,4 +303,14 @@ static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
 
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
index 7206a634270b..18355e0b971a 100644
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
