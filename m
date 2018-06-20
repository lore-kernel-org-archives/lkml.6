Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817A8C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417D22083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417D22083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754859AbeFTT5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:57:10 -0400
Received: from shelob.surriel.com ([96.67.55.147]:51986 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754580AbeFTT5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:57:06 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fVjDr-0002g7-9P; Wed, 20 Jun 2018 15:56:55 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     86@vger.kernel.org, luto@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, dave.hansen@linux.intel.com, efault@gmx.de,
        songliubraving@fb.com, kernel-team@fb.com,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 1/7] mm: allocate mm_cpumask dynamically based on nr_cpu_ids
Date:   Wed, 20 Jun 2018 15:56:46 -0400
Message-Id: <20180620195652.27251-2-riel@surriel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180620195652.27251-1-riel@surriel.com>
References: <20180620195652.27251-1-riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mm_struct always contains a cpumask bitmap, regardless of
CONFIG_CPUMASK_OFFSTACK. That means the first step can be to
simplify things, and simply have one bitmask at the end of the
mm_struct for the mm_cpumask.

The second step is to determine the correct size for the
mm_struct slab object from the size of the mm_struct
(excluding the cpu bitmap) and the size the cpumask.

For init_mm we can simply allocate the maximum size this
kernel is compiled for, since we only have one init_mm
in the system, anyway.

Signed-off-by: Rik van Riel <riel@surriel.com>
Tested-by: Song Liu <songliubraving@fb.com>
---
 include/linux/mm_types.h | 18 ++++++++----------
 kernel/fork.c            | 14 ++++++++------
 mm/init-mm.c             | 10 ++++++++++
 3 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 21612347d311..8e91632958f3 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -427,8 +427,6 @@ struct mm_struct {
 
 	struct linux_binfmt *binfmt;
 
-	cpumask_var_t cpu_vm_mask_var;
-
 	/* Architecture-specific MM context */
 	mm_context_t context;
 
@@ -465,9 +463,6 @@ struct mm_struct {
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
 	pgtable_t pmd_huge_pte; /* protected by page_table_lock */
 #endif
-#ifdef CONFIG_CPUMASK_OFFSTACK
-	struct cpumask cpumask_allocation;
-#endif
 #ifdef CONFIG_NUMA_BALANCING
 	/*
 	 * numa_next_scan is the next time that the PTEs will be marked
@@ -502,22 +497,25 @@ struct mm_struct {
 	/* HMM needs to track a few things per mm */
 	struct hmm *hmm;
 #endif
+
+	/*
+	 * The mm_cpumask needs to be at the end of mm_struct, because it
+	 * is dynamically sized based on nr_cpu_ids.
+	 */
+	unsigned long cpu_bitmap[];
 } __randomize_layout;
 
 extern struct mm_struct init_mm;
 
 static inline void mm_init_cpumask(struct mm_struct *mm)
 {
-#ifdef CONFIG_CPUMASK_OFFSTACK
-	mm->cpu_vm_mask_var = &mm->cpumask_allocation;
-#endif
-	cpumask_clear(mm->cpu_vm_mask_var);
+	cpumask_clear((struct cpumask *)&mm->cpu_bitmap);
 }
 
 /* Future-safe accessor for struct mm_struct's cpu_vm_mask. */
 static inline cpumask_t *mm_cpumask(struct mm_struct *mm)
 {
-	return mm->cpu_vm_mask_var;
+	return (struct cpumask *)&mm->cpu_bitmap;
 }
 
 struct mmu_gather;
diff --git a/kernel/fork.c b/kernel/fork.c
index a5d21c42acfc..c6a20bc78102 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2242,6 +2242,8 @@ static void sighand_ctor(void *data)
 
 void __init proc_caches_init(void)
 {
+	unsigned int mm_size;
+
 	sighand_cachep = kmem_cache_create("sighand_cache",
 			sizeof(struct sighand_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
@@ -2258,15 +2260,15 @@ void __init proc_caches_init(void)
 			sizeof(struct fs_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
+
 	/*
-	 * FIXME! The "sizeof(struct mm_struct)" currently includes the
-	 * whole struct cpumask for the OFFSTACK case. We could change
-	 * this to *only* allocate as much of it as required by the
-	 * maximum number of CPU's we can ever have.  The cpumask_allocation
-	 * is at the end of the structure, exactly for that reason.
+	 * The mm_cpumask is located at the end of mm_struct, and is
+	 * dynamically sized based on nr_cpu_ids.
 	 */
+	mm_size = sizeof(struct mm_struct) + cpumask_size();
+
 	mm_cachep = kmem_cache_create_usercopy("mm_struct",
-			sizeof(struct mm_struct), ARCH_MIN_MMSTRUCT_ALIGN,
+			mm_size, ARCH_MIN_MMSTRUCT_ALIGN,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			offsetof(struct mm_struct, saved_auxv),
 			sizeof_field(struct mm_struct, saved_auxv),
diff --git a/mm/init-mm.c b/mm/init-mm.c
index f94d5d15ebc0..20fe222fe4c0 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -15,6 +15,15 @@
 #define INIT_MM_CONTEXT(name)
 #endif
 
+/*
+ * For dynamically allocated mm_structs, there is a dynamically sized cpumask
+ * at the end of the structure, the size of which depends on nr_cpu_ids. That
+ * way we allocate only as much memory for mm_cpumask() as needed for the
+ * hundreds, or thousands of processes that a system typically runs.
+ *
+ * Since there is only one init_mm in the entire system, keep it simple
+ * and size this cpu_bitmask to NR_CPUS.
+ */
 struct mm_struct init_mm = {
 	.mm_rb		= RB_ROOT,
 	.pgd		= swapper_pg_dir,
@@ -24,5 +33,6 @@ struct mm_struct init_mm = {
 	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
 	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
 	.user_ns	= &init_user_ns,
+	.cpu_bitmap	= { [BITS_TO_LONGS(NR_CPUS)] = 0},
 	INIT_MM_CONTEXT(init_mm)
 };
-- 
2.14.4

