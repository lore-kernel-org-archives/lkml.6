Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752814AbeBEBa3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:30:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:44135 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752696AbeBEB3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:29:35 -0500
From: Davidlohr Bueso <dbueso@suse.de>
To: akpm@linux-foundation.org, mingo@kernel.org
Cc: peterz@infradead.org, ldufour@linux.vnet.ibm.com, jack@suse.cz,
        mhocko@kernel.org, kirill.shutemov@linux.intel.com,
        mawilcox@microsoft.com, mgorman@techsingularity.net, dave@stgolabs.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbuesO@suse.de>
Subject: [PATCH 64/64] mm: convert mmap_sem to range mmap_lock
Date: Mon,  5 Feb 2018 02:27:54 +0100
Message-Id: <20180205012754.23615-65-dbueso@wotan.suse.de>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180205012754.23615-1-dbueso@wotan.suse.de>
References: <20180205012754.23615-1-dbueso@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

With mmrange now in place and everyone using the mm
locking wrappers, we can convert the rwsem to a the
range locking scheme. Every single user of mmap_sem
will use a full range, which means that there is no
more parallelism than what we already had. This is
the worst case scenario. Prefetching has been blindly
converted (for now).

This lays out the foundations for later mm address
space locking scalability.

Signed-off-by: Davidlohr Bueso <dbuesO@suse.de>
---
 arch/ia64/mm/fault.c     |  2 +-
 arch/x86/events/core.c   |  2 +-
 arch/x86/kernel/tboot.c  |  2 +-
 arch/x86/mm/fault.c      |  2 +-
 include/linux/mm.h       | 51 +++++++++++++++++++++++++-----------------------
 include/linux/mm_types.h |  4 ++--
 kernel/fork.c            |  2 +-
 mm/init-mm.c             |  2 +-
 mm/memory.c              |  2 +-
 9 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index 9d379a9a9a5c..fd495bbb3726 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -95,7 +95,7 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 		| (((isr >> IA64_ISR_W_BIT) & 1UL) << VM_WRITE_BIT));
 
 	/* mmap_sem is performance critical.... */
-	prefetchw(&mm->mmap_sem);
+	prefetchw(&mm->mmap_lock);
 
 	/*
 	 * If we're in an interrupt or have no user context, we must not take the fault..
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 140d33288e78..9b94559160b2 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2144,7 +2144,7 @@ static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
 	 * For now, this can't happen because all callers hold mmap_sem
 	 * for write.  If this changes, we'll need a different solution.
 	 */
-	lockdep_assert_held_exclusive(&mm->mmap_sem);
+	lockdep_assert_held_exclusive(&mm->mmap_lock);
 
 	if (atomic_inc_return(&mm->context.perf_rdpmc_allowed) == 1)
 		on_each_cpu_mask(mm_cpumask(mm), refresh_pce, NULL, 1);
diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index a2486f444073..ec23bc6a1eb0 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -104,7 +104,7 @@ static struct mm_struct tboot_mm = {
 	.pgd            = swapper_pg_dir,
 	.mm_users       = ATOMIC_INIT(2),
 	.mm_count       = ATOMIC_INIT(1),
-	.mmap_sem       = __RWSEM_INITIALIZER(init_mm.mmap_sem),
+	.mmap_lock       = __RANGE_LOCK_TREE_INITIALIZER(init_mm.mmap_lock),
 	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
 	.mmlist         = LIST_HEAD_INIT(init_mm.mmlist),
 };
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 87bdcb26a907..c025dbf349a1 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1258,7 +1258,7 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 	 * Detect and handle instructions that would cause a page fault for
 	 * both a tracked kernel page and a userspace page.
 	 */
-	prefetchw(&mm->mmap_sem);
+	prefetchw(&mm->mmap_lock);
 
 	if (unlikely(kmmio_fault(regs, address)))
 		return;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0b9867e8a35d..a0c2f4b17e3c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2699,73 +2699,76 @@ static inline void setup_nr_node_ids(void) {}
  * Address space locking wrappers.
  */
 static inline bool mm_is_locked(struct mm_struct *mm,
-				struct range_lock *range)
+				struct range_lock *mmrange)
 {
-	return rwsem_is_locked(&mm->mmap_sem);
+	return range_is_locked(&mm->mmap_lock, mmrange);
 }
 
 /* Reader wrappers */
 static inline int mm_read_trylock(struct mm_struct *mm,
-				  struct range_lock *range)
+				  struct range_lock *mmrange)
 {
-	return down_read_trylock(&mm->mmap_sem);
+	return range_read_trylock(&mm->mmap_lock, mmrange);
 }
 
-static inline void mm_read_lock(struct mm_struct *mm, struct range_lock *range)
+static inline void mm_read_lock(struct mm_struct *mm,
+				struct range_lock *mmrange)
 {
-	down_read(&mm->mmap_sem);
+        range_read_lock(&mm->mmap_lock, mmrange);
 }
 
 static inline void mm_read_lock_nested(struct mm_struct *mm,
-				       struct range_lock *range, int subclass)
+				       struct range_lock *mmrange, int subclass)
 {
-	down_read_nested(&mm->mmap_sem, subclass);
+        range_read_lock_nested(&mm->mmap_lock, mmrange, subclass);
 }
 
 static inline void mm_read_unlock(struct mm_struct *mm,
-				  struct range_lock *range)
+				  struct range_lock *mmrange)
 {
-	up_read(&mm->mmap_sem);
+	range_read_unlock(&mm->mmap_lock, mmrange);
 }
 
 /* Writer wrappers */
 static inline int mm_write_trylock(struct mm_struct *mm,
-				   struct range_lock *range)
+				   struct range_lock *mmrange)
 {
-	return down_write_trylock(&mm->mmap_sem);
+	return range_write_trylock(&mm->mmap_lock, mmrange);
 }
 
-static inline void mm_write_lock(struct mm_struct *mm, struct range_lock *range)
+static inline void mm_write_lock(struct mm_struct *mm,
+				 struct range_lock *mmrange)
 {
-	down_write(&mm->mmap_sem);
+	range_write_lock(&mm->mmap_lock, mmrange);
 }
 
 static inline int mm_write_lock_killable(struct mm_struct *mm,
-					 struct range_lock *range)
+					 struct range_lock *mmrange)
 {
-	return down_write_killable(&mm->mmap_sem);
+	return range_write_lock_killable(&mm->mmap_lock, mmrange);
 }
 
 static inline void mm_downgrade_write(struct mm_struct *mm,
-				      struct range_lock *range)
+				      struct range_lock *mmrange)
 {
-	downgrade_write(&mm->mmap_sem);
+	range_downgrade_write(&mm->mmap_lock, mmrange);
 }
 
 static inline void mm_write_unlock(struct mm_struct *mm,
-				   struct range_lock *range)
+				   struct range_lock *mmrange)
 {
-	up_write(&mm->mmap_sem);
+        range_write_unlock(&mm->mmap_lock, mmrange);
 }
 
 static inline void mm_write_lock_nested(struct mm_struct *mm,
-					struct range_lock *range, int subclass)
+					struct range_lock *mmrange,
+					int subclass)
 {
-	down_write_nested(&mm->mmap_sem, subclass);
+        range_write_lock_nested(&mm->mmap_lock, mmrange, subclass);
 }
 
-#define mm_write_nest_lock(mm, range, nest_lock)		\
-	down_write_nest_lock(&(mm)->mmap_sem, nest_lock)
+#define mm_write_lock_nest_lock(mm, range, nest_lock)		\
+	range_write_lock_nest_lock(&(mm)->mmap_lock, mmrange, nest_lock)
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index fd1af6b9591d..fd9545fe4735 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -8,7 +8,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
-#include <linux/rwsem.h>
+#include <linux/range_lock.h>
 #include <linux/completion.h>
 #include <linux/cpumask.h>
 #include <linux/uprobes.h>
@@ -393,7 +393,7 @@ struct mm_struct {
 	int map_count;				/* number of VMAs */
 
 	spinlock_t page_table_lock;		/* Protects page tables and some counters */
-	struct rw_semaphore mmap_sem;
+	struct range_lock_tree mmap_lock;
 
 	struct list_head mmlist;		/* List of maybe swapped mm's.	These are globally strung
 						 * together off init_mm.mmlist, and are protected
diff --git a/kernel/fork.c b/kernel/fork.c
index 060554e33111..252a1fe18f16 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -899,7 +899,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm->vmacache_seqnum = 0;
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
-	init_rwsem(&mm->mmap_sem);
+	range_lock_tree_init(&mm->mmap_lock);
 	INIT_LIST_HEAD(&mm->mmlist);
 	mm->core_state = NULL;
 	mm_pgtables_bytes_init(mm);
diff --git a/mm/init-mm.c b/mm/init-mm.c
index f94d5d15ebc0..c4aee632702f 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -20,7 +20,7 @@ struct mm_struct init_mm = {
 	.pgd		= swapper_pg_dir,
 	.mm_users	= ATOMIC_INIT(2),
 	.mm_count	= ATOMIC_INIT(1),
-	.mmap_sem	= __RWSEM_INITIALIZER(init_mm.mmap_sem),
+	.mmap_lock	= __RANGE_LOCK_TREE_INITIALIZER(init_mm.mmap_lock),
 	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
 	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
 	.user_ns	= &init_user_ns,
diff --git a/mm/memory.c b/mm/memory.c
index e3bf2879f7c3..d4fc526d82a4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4568,7 +4568,7 @@ void __might_fault(const char *file, int line)
 	__might_sleep(file, line, 0);
 #if defined(CONFIG_DEBUG_ATOMIC_SLEEP)
 	if (current->mm)
-		might_lock_read(&current->mm->mmap_sem);
+		might_lock_read(&current->mm->mmap_lock);
 #endif
 }
 EXPORT_SYMBOL(__might_fault);
-- 
2.13.6
