Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF546C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A00122ACC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A00122ACC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933138AbeGFV5h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:57:37 -0400
Received: from shelob.surriel.com ([96.67.55.147]:35336 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932869AbeGFV5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:57:15 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fbYir-0003ql-Ng; Fri, 06 Jul 2018 17:57:01 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org, dave.hansen@linux.intel.com,
        mingo@kernel.org, kernel-team@fb.com, tglx@linutronix.de,
        efault@gmx.de, songliubraving@fb.com, hpa@zytor.com,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 1/7] mm: allocate mm_cpumask dynamically based on nr_cpu_ids
Date:   Fri,  6 Jul 2018 17:56:52 -0400
Message-Id: <20180706215658.18018-2-riel@surriel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180706215658.18018-1-riel@surriel.com>
References: <20180706215658.18018-1-riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mm_struct always contains a cpumask bitmap, regardless of
CONFIG_CPUMASK_OFFSTACK. That means the first step can be to
simplify things, and simply have one bitmask at the end of the
mm_struct for the mm_cpumask.

This does necessitate moving everything else in mm_struct into
an anonymous sub-structure, which can be randomized when struct
randomization is enabled.

The second step is to determine the correct size for the
mm_struct slab object from the size of the mm_struct
(excluding the cpu bitmap) and the size the cpumask.

For init_mm we can simply allocate the maximum size this
kernel is compiled for, since we only have one init_mm
in the system, anyway.

Signed-off-by: Rik van Riel <riel@surriel.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Tested-by: Song Liu <songliubraving@fb.com>
---
 include/linux/mm_types.h | 237 ++++++++++++++++++++++++-----------------------
 kernel/fork.c            |  15 +--
 mm/init-mm.c             |  11 +++
 3 files changed, 140 insertions(+), 123 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 99ce070e7dcb..e06de7e492d0 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -335,176 +335,179 @@ struct core_state {
 
 struct kioctx_table;
 struct mm_struct {
-	struct vm_area_struct *mmap;		/* list of VMAs */
-	struct rb_root mm_rb;
-	u32 vmacache_seqnum;                   /* per-thread vmacache */
+	struct {
+		struct vm_area_struct *mmap;		/* list of VMAs */
+		struct rb_root mm_rb;
+		u32 vmacache_seqnum;                   /* per-thread vmacache */
 #ifdef CONFIG_MMU
-	unsigned long (*get_unmapped_area) (struct file *filp,
+		unsigned long (*get_unmapped_area) (struct file *filp,
 				unsigned long addr, unsigned long len,
 				unsigned long pgoff, unsigned long flags);
 #endif
-	unsigned long mmap_base;		/* base of mmap area */
-	unsigned long mmap_legacy_base;         /* base of mmap area in bottom-up allocations */
+		unsigned long mmap_base;	/* base of mmap area */
+		unsigned long mmap_legacy_base;	/* base of mmap area in bottom-up allocations */
 #ifdef CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
-	/* Base adresses for compatible mmap() */
-	unsigned long mmap_compat_base;
-	unsigned long mmap_compat_legacy_base;
+		/* Base adresses for compatible mmap() */
+		unsigned long mmap_compat_base;
+		unsigned long mmap_compat_legacy_base;
 #endif
-	unsigned long task_size;		/* size of task vm space */
-	unsigned long highest_vm_end;		/* highest vma end address */
-	pgd_t * pgd;
-
-	/**
-	 * @mm_users: The number of users including userspace.
-	 *
-	 * Use mmget()/mmget_not_zero()/mmput() to modify. When this drops
-	 * to 0 (i.e. when the task exits and there are no other temporary
-	 * reference holders), we also release a reference on @mm_count
-	 * (which may then free the &struct mm_struct if @mm_count also
-	 * drops to 0).
-	 */
-	atomic_t mm_users;
-
-	/**
-	 * @mm_count: The number of references to &struct mm_struct
-	 * (@mm_users count as 1).
-	 *
-	 * Use mmgrab()/mmdrop() to modify. When this drops to 0, the
-	 * &struct mm_struct is freed.
-	 */
-	atomic_t mm_count;
+		unsigned long task_size;	/* size of task vm space */
+		unsigned long highest_vm_end;	/* highest vma end address */
+		pgd_t * pgd;
+
+		/**
+		 * @mm_users: The number of users including userspace.
+		 *
+		 * Use mmget()/mmget_not_zero()/mmput() to modify. When this
+		 * drops to 0 (i.e. when the task exits and there are no other
+		 * temporary reference holders), we also release a reference on
+		 * @mm_count (which may then free the &struct mm_struct if
+		 * @mm_count also drops to 0).
+		 */
+		atomic_t mm_users;
+
+		/**
+		 * @mm_count: The number of references to &struct mm_struct
+		 * (@mm_users count as 1).
+		 *
+		 * Use mmgrab()/mmdrop() to modify. When this drops to 0, the
+		 * &struct mm_struct is freed.
+		 */
+		atomic_t mm_count;
 
 #ifdef CONFIG_MMU
-	atomic_long_t pgtables_bytes;		/* PTE page table pages */
+		atomic_long_t pgtables_bytes;	/* PTE page table pages */
 #endif
-	int map_count;				/* number of VMAs */
+		int map_count;			/* number of VMAs */
 
-	spinlock_t page_table_lock;		/* Protects page tables and some counters */
-	struct rw_semaphore mmap_sem;
+		spinlock_t page_table_lock; /* Protects page tables and some
+					     * counters
+					     */
+		struct rw_semaphore mmap_sem;
 
-	struct list_head mmlist;		/* List of maybe swapped mm's.	These are globally strung
-						 * together off init_mm.mmlist, and are protected
-						 * by mmlist_lock
-						 */
+		struct list_head mmlist; /* List of maybe swapped mm's.	These
+					  * are globally strung together off
+					  * init_mm.mmlist, and are protected
+					  * by mmlist_lock
+					  */
 
 
-	unsigned long hiwater_rss;	/* High-watermark of RSS usage */
-	unsigned long hiwater_vm;	/* High-water virtual memory usage */
+		unsigned long hiwater_rss; /* High-watermark of RSS usage */
+		unsigned long hiwater_vm;  /* High-water virtual memory usage */
 
-	unsigned long total_vm;		/* Total pages mapped */
-	unsigned long locked_vm;	/* Pages that have PG_mlocked set */
-	unsigned long pinned_vm;	/* Refcount permanently increased */
-	unsigned long data_vm;		/* VM_WRITE & ~VM_SHARED & ~VM_STACK */
-	unsigned long exec_vm;		/* VM_EXEC & ~VM_WRITE & ~VM_STACK */
-	unsigned long stack_vm;		/* VM_STACK */
-	unsigned long def_flags;
+		unsigned long total_vm;	   /* Total pages mapped */
+		unsigned long locked_vm;   /* Pages that have PG_mlocked set */
+		unsigned long pinned_vm;   /* Refcount permanently increased */
+		unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
+		unsigned long exec_vm;	   /* VM_EXEC & ~VM_WRITE & ~VM_STACK */
+		unsigned long stack_vm;	   /* VM_STACK */
+		unsigned long def_flags;
 
-	spinlock_t arg_lock; /* protect the below fields */
-	unsigned long start_code, end_code, start_data, end_data;
-	unsigned long start_brk, brk, start_stack;
-	unsigned long arg_start, arg_end, env_start, env_end;
+		spinlock_t arg_lock; /* protect the below fields */
+		unsigned long start_code, end_code, start_data, end_data;
+		unsigned long start_brk, brk, start_stack;
+		unsigned long arg_start, arg_end, env_start, env_end;
 
-	unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
+		unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
 
-	/*
-	 * Special counters, in some configurations protected by the
-	 * page_table_lock, in other configurations by being atomic.
-	 */
-	struct mm_rss_stat rss_stat;
-
-	struct linux_binfmt *binfmt;
+		/*
+		 * Special counters, in some configurations protected by the
+		 * page_table_lock, in other configurations by being atomic.
+		 */
+		struct mm_rss_stat rss_stat;
 
-	cpumask_var_t cpu_vm_mask_var;
+		struct linux_binfmt *binfmt;
 
-	/* Architecture-specific MM context */
-	mm_context_t context;
+		/* Architecture-specific MM context */
+		mm_context_t context;
 
-	unsigned long flags; /* Must use atomic bitops to access the bits */
+		unsigned long flags; /* Must use atomic bitops to access */
 
-	struct core_state *core_state; /* coredumping support */
+		struct core_state *core_state; /* coredumping support */
 #ifdef CONFIG_MEMBARRIER
-	atomic_t membarrier_state;
+		atomic_t membarrier_state;
 #endif
 #ifdef CONFIG_AIO
-	spinlock_t			ioctx_lock;
-	struct kioctx_table __rcu	*ioctx_table;
+		spinlock_t			ioctx_lock;
+		struct kioctx_table __rcu	*ioctx_table;
 #endif
 #ifdef CONFIG_MEMCG
-	/*
-	 * "owner" points to a task that is regarded as the canonical
-	 * user/owner of this mm. All of the following must be true in
-	 * order for it to be changed:
-	 *
-	 * current == mm->owner
-	 * current->mm != mm
-	 * new_owner->mm == mm
-	 * new_owner->alloc_lock is held
-	 */
-	struct task_struct __rcu *owner;
+		/*
+		 * "owner" points to a task that is regarded as the canonical
+		 * user/owner of this mm. All of the following must be true in
+		 * order for it to be changed:
+		 *
+		 * current == mm->owner
+		 * current->mm != mm
+		 * new_owner->mm == mm
+		 * new_owner->alloc_lock is held
+		 */
+		struct task_struct __rcu *owner;
 #endif
-	struct user_namespace *user_ns;
+		struct user_namespace *user_ns;
 
-	/* store ref to file /proc/<pid>/exe symlink points to */
-	struct file __rcu *exe_file;
+		/* store ref to file /proc/<pid>/exe symlink points to */
+		struct file __rcu *exe_file;
 #ifdef CONFIG_MMU_NOTIFIER
-	struct mmu_notifier_mm *mmu_notifier_mm;
+		struct mmu_notifier_mm *mmu_notifier_mm;
 #endif
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
-	pgtable_t pmd_huge_pte; /* protected by page_table_lock */
-#endif
-#ifdef CONFIG_CPUMASK_OFFSTACK
-	struct cpumask cpumask_allocation;
+		pgtable_t pmd_huge_pte; /* protected by page_table_lock */
 #endif
 #ifdef CONFIG_NUMA_BALANCING
-	/*
-	 * numa_next_scan is the next time that the PTEs will be marked
-	 * pte_numa. NUMA hinting faults will gather statistics and migrate
-	 * pages to new nodes if necessary.
-	 */
-	unsigned long numa_next_scan;
+		/*
+		 * numa_next_scan is the next time that the PTEs will be marked
+		 * pte_numa. NUMA hinting faults will gather statistics and
+		 * migrate pages to new nodes if necessary.
+		 */
+		unsigned long numa_next_scan;
 
-	/* Restart point for scanning and setting pte_numa */
-	unsigned long numa_scan_offset;
+		/* Restart point for scanning and setting pte_numa */
+		unsigned long numa_scan_offset;
 
-	/* numa_scan_seq prevents two threads setting pte_numa */
-	int numa_scan_seq;
+		/* numa_scan_seq prevents two threads setting pte_numa */
+		int numa_scan_seq;
 #endif
-	/*
-	 * An operation with batched TLB flushing is going on. Anything that
-	 * can move process memory needs to flush the TLB when moving a
-	 * PROT_NONE or PROT_NUMA mapped page.
-	 */
-	atomic_t tlb_flush_pending;
+		/*
+		 * An operation with batched TLB flushing is going on. Anything
+		 * that can move process memory needs to flush the TLB when
+		 * moving a PROT_NONE or PROT_NUMA mapped page.
+		 */
+		atomic_t tlb_flush_pending;
 #ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
-	/* See flush_tlb_batched_pending() */
-	bool tlb_flush_batched;
+		/* See flush_tlb_batched_pending() */
+		bool tlb_flush_batched;
 #endif
-	struct uprobes_state uprobes_state;
+		struct uprobes_state uprobes_state;
 #ifdef CONFIG_HUGETLB_PAGE
-	atomic_long_t hugetlb_usage;
+		atomic_long_t hugetlb_usage;
 #endif
-	struct work_struct async_put_work;
+		struct work_struct async_put_work;
 
 #if IS_ENABLED(CONFIG_HMM)
-	/* HMM needs to track a few things per mm */
-	struct hmm *hmm;
+		/* HMM needs to track a few things per mm */
+		struct hmm *hmm;
 #endif
-} __randomize_layout;
+	} __randomize_layout;
+
+	/*
+	 * The mm_cpumask needs to be at the end of mm_struct, because it
+	 * is dynamically sized based on nr_cpu_ids.
+	 */
+	unsigned long cpu_bitmap[];
+};
 
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
index 9440d61b925c..5b64c1b8461e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2253,6 +2253,8 @@ static void sighand_ctor(void *data)
 
 void __init proc_caches_init(void)
 {
+	unsigned int mm_size;
+
 	sighand_cachep = kmem_cache_create("sighand_cache",
 			sizeof(struct sighand_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
@@ -2269,15 +2271,16 @@ void __init proc_caches_init(void)
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
+	 * dynamically sized based on the maximum CPU number this system
+	 * can have, taking hotplug into account (nr_cpu_ids).
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
index f0179c9c04c2..a787a319211e 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -15,6 +15,16 @@
 #define INIT_MM_CONTEXT(name)
 #endif
 
+/*
+ * For dynamically allocated mm_structs, there is a dynamically sized cpumask
+ * at the end of the structure, the size of which depends on the maximum CPU
+ * number the system can see. That way we allocate only as much memory for
+ * mm_cpumask() as needed for the hundreds, or thousands of processes that
+ * a system typically runs.
+ *
+ * Since there is only one init_mm in the entire system, keep it simple
+ * and size this cpu_bitmask to NR_CPUS.
+ */
 struct mm_struct init_mm = {
 	.mm_rb		= RB_ROOT,
 	.pgd		= swapper_pg_dir,
@@ -25,5 +35,6 @@ struct mm_struct init_mm = {
 	.arg_lock	=  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
 	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
 	.user_ns	= &init_user_ns,
+	.cpu_bitmap	= { [BITS_TO_LONGS(NR_CPUS)] = 0},
 	INIT_MM_CONTEXT(init_mm)
 };
-- 
2.14.4

