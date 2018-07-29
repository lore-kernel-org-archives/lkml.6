Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0487C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778C220882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778C220882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbeG2V04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:26:56 -0400
Received: from shelob.surriel.com ([96.67.55.147]:48302 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeG2V04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:26:56 -0400
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fjrmh-0002MM-Vm; Sun, 29 Jul 2018 15:55:19 -0400
Date:   Sun, 29 Jul 2018 15:54:52 -0400
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 11/11] mm,sched: conditionally skip lazy TLB mm
 refcounting
Message-ID: <20180729155452.37eddc11@imladris.surriel.com>
In-Reply-To: <CALCETrWS4pE5Tv3OErM3AD-E=CGG3U+2CBVecRF3N0c+g42vEg@mail.gmail.com>
References: <20180728215357.3249-1-riel@surriel.com>
        <20180728215357.3249-11-riel@surriel.com>
        <CALCETrWS4pE5Tv3OErM3AD-E=CGG3U+2CBVecRF3N0c+g42vEg@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jul 2018 21:21:17 -0700
Andy Lutomirski <luto@kernel.org> wrote:

> On Sat, Jul 28, 2018 at 2:53 PM, Rik van Riel <riel@surriel.com> wrote:
> > Conditionally skip lazy TLB mm refcounting. When an architecture has
> > CONFIG_ARCH_NO_ACTIVE_MM_REFCOUNTING enabled, an mm that is used in
> > lazy TLB mode anywhere will get shot down from exit_mmap, and there
> > in no need to incur the cache line bouncing overhead of refcounting
> > a lazy TLB mm.  
> 
> Unless I've misunderstood something, this patch results in idle tasks
> whose active_mm has been freed still having active_mm pointing at
> freed memory.

---8<---

Author: Rik van Riel <riel@surriel.com>
Subject: [PATCH 11/11] mm,sched: conditionally skip lazy TLB mm refcounting

Conditionally skip lazy TLB mm refcounting. When an architecture has
CONFIG_ARCH_NO_ACTIVE_MM_REFCOUNTING enabled, an mm that is used in
lazy TLB mode anywhere will get shot down from exit_mmap, and there
in no need to incur the cache line bouncing overhead of refcounting
a lazy TLB mm.

Implement this by moving the refcounting of a lazy TLB mm to helper
functions, which skip the refcounting when it is not necessary.

Deal with use_mm and unuse_mm by fully splitting out the refcounting
of the lazy TLB mm a kernel thread may have when entering use_mm from
the refcounting of the mm that use_mm is about to start using.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 arch/x86/mm/tlb.c        |  5 +++--
 fs/exec.c                |  2 +-
 include/linux/sched/mm.h | 25 +++++++++++++++++++++++++
 kernel/sched/core.c      |  6 +++---
 mm/mmu_context.c         | 21 ++++++++++++++-------
 5 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 425cb9fa2640..d53d9c19b97d 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -8,6 +8,7 @@
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
 #include <linux/gfp.h>
+#include <linux/sched/mm.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -141,7 +142,7 @@ void leave_mm(void *dummy)
 
 	switch_mm(NULL, &init_mm, NULL);
 	current->active_mm = &init_mm;
-	mmdrop(loaded_mm);
+	drop_lazy_mm(loaded_mm);
 }
 EXPORT_SYMBOL_GPL(leave_mm);
 
@@ -486,7 +487,7 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 		 */
 		switch_mm_irqs_off(NULL, &init_mm, NULL);
 		current->active_mm = &init_mm;
-		mmdrop(loaded_mm);
+		drop_lazy_mm(loaded_mm);
 		return;
 	}
 
diff --git a/fs/exec.c b/fs/exec.c
index bdd0eacefdf5..7a6d4811b02b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1043,7 +1043,7 @@ static int exec_mmap(struct mm_struct *mm)
 		mmput(old_mm);
 		return 0;
 	}
-	mmdrop(active_mm);
+	drop_lazy_mm(active_mm);
 	return 0;
 }
 
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 44d356f5e47c..7308bf38012f 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -49,6 +49,31 @@ static inline void mmdrop(struct mm_struct *mm)
 		__mmdrop(mm);
 }
 
+/*
+ * In lazy TLB mode, a CPU keeps the mm of the last process mapped while
+ * running a kernel thread or idle; we must make sure the lazy TLB mm and
+ * page tables do not disappear while a lazy TLB mode CPU uses them.
+ * There are two ways to handle the race between lazy TLB CPUs and exit_mmap:
+ * 1) Have a lazy TLB CPU hold a refcount on the lazy TLB mm.
+ * 2) Have the architecture code shoot down the lazy TLB mm from exit_mmap;
+ *    in that case, refcounting can be skipped, reducing cache line bouncing.
+ */
+static inline void grab_lazy_mm(struct mm_struct *mm)
+{
+	if (IS_ENABLED(CONFIG_ARCH_NO_ACTIVE_MM_REFCOUNTING))
+		return;
+
+	mmgrab(mm);
+}
+
+static inline void drop_lazy_mm(struct mm_struct *mm)
+{
+	if (IS_ENABLED(CONFIG_ARCH_NO_ACTIVE_MM_REFCOUNTING))
+		return;
+
+	mmdrop(mm);
+}
+
 /**
  * mmget() - Pin the address space associated with a &struct mm_struct.
  * @mm: The address space to pin.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c45de46fdf10..11724c9e88b0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2691,7 +2691,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	 */
 	if (mm) {
 		membarrier_mm_sync_core_before_usermode(mm);
-		mmdrop(mm);
+		drop_lazy_mm(mm);
 	}
 	if (unlikely(prev_state == TASK_DEAD)) {
 		if (prev->sched_class->task_dead)
@@ -2805,7 +2805,7 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	 */
 	if (!mm) {
 		next->active_mm = oldmm;
-		mmgrab(oldmm);
+		grab_lazy_mm(oldmm);
 		enter_lazy_tlb(oldmm, next);
 	} else
 		switch_mm_irqs_off(oldmm, mm, next);
@@ -5532,7 +5532,7 @@ void idle_task_exit(void)
 		current->active_mm = &init_mm;
 		finish_arch_post_lock_switch();
 	}
-	mmdrop(mm);
+	drop_lazy_mm(mm);
 }
 
 /*
diff --git a/mm/mmu_context.c b/mm/mmu_context.c
index 3e612ae748e9..d5c2524cdd9a 100644
--- a/mm/mmu_context.c
+++ b/mm/mmu_context.c
@@ -24,12 +24,15 @@ void use_mm(struct mm_struct *mm)
 	struct mm_struct *active_mm;
 	struct task_struct *tsk = current;
 
+	/* Kernel threads have a NULL tsk->mm when entering. */
+	WARN_ON(tsk->mm);
+
 	task_lock(tsk);
+	/* Previous ->active_mm was held in lazy TLB mode. */
 	active_mm = tsk->active_mm;
-	if (active_mm != mm) {
-		mmgrab(mm);
-		tsk->active_mm = mm;
-	}
+	/* Grab mm for reals; tsk->mm needs to stick around until unuse_mm. */
+	mmgrab(mm);
+	tsk->active_mm = mm;
 	tsk->mm = mm;
 	switch_mm(active_mm, mm, tsk);
 	task_unlock(tsk);
@@ -37,8 +40,9 @@ void use_mm(struct mm_struct *mm)
 	finish_arch_post_lock_switch();
 #endif
 
-	if (active_mm != mm)
-		mmdrop(active_mm);
+	/* Drop the lazy TLB mode mm. */
+	if (active_mm)
+		drop_lazy_mm(active_mm);
 }
 EXPORT_SYMBOL_GPL(use_mm);
 
@@ -57,8 +61,11 @@ void unuse_mm(struct mm_struct *mm)
 	task_lock(tsk);
 	sync_mm_rss(mm);
 	tsk->mm = NULL;
-	/* active_mm is still 'mm' */
+	/* active_mm is still 'mm'; grab it as a lazy TLB mm */
+	grab_lazy_mm(mm);
 	enter_lazy_tlb(mm, tsk);
+	/* drop the tsk->mm refcount */
+	mmdrop(mm);
 	task_unlock(tsk);
 }
 EXPORT_SYMBOL_GPL(unuse_mm);
-- 
2.14.4

