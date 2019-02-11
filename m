Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2484C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D91021B24
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbfBKR7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:59:46 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55048 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfBKR7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:59:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A29715AD;
        Mon, 11 Feb 2019 09:59:43 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D4AE83F675;
        Mon, 11 Feb 2019 09:59:41 -0800 (PST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH 1/4] mm: Check user stack pointer is mapped with MAP_STACK
Date:   Mon, 11 Feb 2019 17:59:32 +0000
Message-Id: <20190211175935.4602-2-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190211175935.4602-1-will.deacon@arm.com>
References: <20190211175935.4602-1-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By marking stack VMAs with VM_USERSTACK, we can perform optional checks
on entry to the kernel from system calls and user faults to ensure that
the user stack pointer does indeed point to a stack VMA. If the stack
pointer is found to point elsewhere, a SIGSEGV can be delivered to the
current application.

This acts as a best-effort defense against stack-pivoting attacks.

Cc: Kees Cook <keescook@chromium.org>
Cc: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/linux/mm.h    | 10 +++++++++-
 include/linux/mman.h  |  3 ++-
 include/linux/sched.h |  4 ++++
 mm/memory.c           | 45 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 80bb6408fe73..9fa02d47a270 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -233,6 +233,7 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_ARCH_1	0x01000000	/* Architecture-specific flag */
 #define VM_WIPEONFORK	0x02000000	/* Wipe VMA contents in child. */
 #define VM_DONTDUMP	0x04000000	/* Do not include in the core dump */
+#define VM_USERSTACK	0x08000000	/* User stack VM */
 
 #ifdef CONFIG_MEM_SOFT_DIRTY
 # define VM_SOFTDIRTY	0x08000000	/* Not soft dirty clean area */
@@ -310,7 +311,8 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_STACK	VM_GROWSDOWN
 #endif
 
-#define VM_STACK_FLAGS	(VM_STACK | VM_STACK_DEFAULT_FLAGS | VM_ACCOUNT)
+#define VM_STACK_FLAGS	(VM_STACK | VM_STACK_DEFAULT_FLAGS | VM_ACCOUNT | \
+			 VM_USERSTACK)
 
 /*
  * Special vmas that are non-mergable, non-mlock()able.
@@ -1480,6 +1482,12 @@ int truncate_inode_page(struct address_space *mapping, struct page *page);
 int generic_error_remove_page(struct address_space *mapping, struct page *page);
 int invalidate_inode_page(struct page *page);
 
+#ifdef CONFIG_USER_STACK_POINTER_CHECKS
+bool usp_check_syscall(void);
+#else
+static inline bool usp_check_syscall(void) { return true; }
+#endif
+
 #ifdef CONFIG_MMU
 extern vm_fault_t handle_mm_fault(struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags);
diff --git a/include/linux/mman.h b/include/linux/mman.h
index 4b08e9c9c538..d4f2d39fca70 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -131,7 +131,8 @@ calc_vm_flag_bits(unsigned long flags)
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_DENYWRITE,  VM_DENYWRITE ) |
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
-	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      );
+	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
+	       _calc_vm_trans(flags, MAP_STACK,      VM_USERSTACK ) ;
 }
 
 unsigned long vm_commit_limit(void);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index bba3afb4e9bf..2e6766301645 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1208,6 +1208,10 @@ struct task_struct {
 	unsigned long			prev_lowest_stack;
 #endif
 
+#ifdef CONFIG_USER_STACK_POINTER_CHECKS
+	unsigned int			usp_checks;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/mm/memory.c b/mm/memory.c
index e11ca9dd823f..e0b449f520da 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -44,6 +44,7 @@
 #include <linux/sched/coredump.h>
 #include <linux/sched/numa_balancing.h>
 #include <linux/sched/task.h>
+#include <linux/sched/task_stack.h>
 #include <linux/hugetlb.h>
 #include <linux/mman.h>
 #include <linux/swap.h>
@@ -63,6 +64,7 @@
 #include <linux/elf.h>
 #include <linux/gfp.h>
 #include <linux/migrate.h>
+#include <linux/ptrace.h>
 #include <linux/string.h>
 #include <linux/dma-debug.h>
 #include <linux/debugfs.h>
@@ -3911,6 +3913,46 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 	return handle_pte_fault(&vmf);
 }
 
+#ifdef CONFIG_USER_STACK_POINTER_CHECKS
+#define USP_CHECK_FAULT		(1U << 0)
+#define USP_CHECK_SYSCALL	(1U << 1)
+
+static bool __usp_check(void)
+{
+	struct vm_area_struct *vma;
+
+	vma = find_vma(current->mm, current_user_stack_pointer());
+	return vma && (vma->vm_flags & VM_USERSTACK);
+}
+
+static bool usp_check_fault(unsigned int flags)
+{
+	if (!(flags & FAULT_FLAG_USER))
+		return true;
+
+	if (!(current->usp_checks & USP_CHECK_FAULT))
+		return true;
+
+	return __usp_check();
+}
+
+bool usp_check_syscall(void)
+{
+	bool ret;
+	struct mm_struct *mm = current->mm;
+
+	if (!(current->usp_checks & USP_CHECK_SYSCALL))
+		return true;
+
+	down_read(&mm->mmap_sem);
+	ret = __usp_check();
+	up_read(&mm->mmap_sem);
+	return ret;
+}
+#else
+static bool usp_check_fault(unsigned int flags) { return true; }
+#endif
+
 /*
  * By the time we get here, we already hold the mm semaphore
  *
@@ -3930,6 +3972,9 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	/* do counter updates before entering really critical section. */
 	check_sync_rss_stat(current);
 
+	if (!usp_check_fault(flags))
+		return VM_FAULT_SIGSEGV;
+
 	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
 					    flags & FAULT_FLAG_INSTRUCTION,
 					    flags & FAULT_FLAG_REMOTE))
-- 
2.11.0

