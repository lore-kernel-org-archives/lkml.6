Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A309C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0514B2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0514B2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeJHRHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:07:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37131 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeJHRHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:07:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w989tSdL559914
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 Oct 2018 02:55:28 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w989tSCC559911;
        Mon, 8 Oct 2018 02:55:28 -0700
Date:   Mon, 8 Oct 2018 02:55:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Chang S. Bae" <tipbot@zytor.com>
Message-ID: <tip-b1378a561fd16afdd96ef0bc912b1bcd2b85a68e@git.kernel.org>
Cc:     tglx@linutronix.de, luto@kernel.org, peterz@infradead.org,
        chang.seok.bae@intel.com, luto@amacapital.net, hpa@zytor.com,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, bp@alien8.de, markus.t.metzger@intel.com,
        torvalds@linux-foundation.org, dvlasenk@redhat.com,
        riel@surriel.com, ravi.v.shankar@intel.com, brgerst@gmail.com
Reply-To: chang.seok.bae@intel.com, luto@kernel.org, peterz@infradead.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, dave.hansen@linux.intel.com,
          luto@amacapital.net, hpa@zytor.com, dvlasenk@redhat.com,
          riel@surriel.com, markus.t.metzger@intel.com,
          torvalds@linux-foundation.org, bp@alien8.de, brgerst@gmail.com,
          ravi.v.shankar@intel.com
In-Reply-To: <1537312139-5580-3-git-send-email-chang.seok.bae@intel.com>
References: <1537312139-5580-3-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/fsgsbase/64: Introduce FS/GS base helper
 functions
Git-Commit-ID: b1378a561fd16afdd96ef0bc912b1bcd2b85a68e
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

Commit-ID:  b1378a561fd16afdd96ef0bc912b1bcd2b85a68e
Gitweb:     https://git.kernel.org/tip/b1378a561fd16afdd96ef0bc912b1bcd2b85a68e
Author:     Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate: Tue, 18 Sep 2018 16:08:53 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 8 Oct 2018 10:41:08 +0200

x86/fsgsbase/64: Introduce FS/GS base helper functions

Introduce FS/GS base access functionality via <asm/fsgsbase.h>,
not yet used by anything directly.

Factor out task_seg_base() from x86/ptrace.c and rename it to
x86_fsgsbase_read_task() to make it part of the new helpers.

This will allow us to enhance FSGSBASE support and eventually enable
the FSBASE/GSBASE instructions.

An "inactive" GS base refers to a base saved at kernel entry
and being part of an inactive, non-running/stopped user-task.
(The typical ptrace model.)

Here are the new functions:

  x86_fsbase_read_task()
  x86_gsbase_read_task()
  x86_fsbase_write_task()
  x86_gsbase_write_task()
  x86_fsbase_read_cpu()
  x86_fsbase_write_cpu()
  x86_gsbase_read_cpu_inactive()
  x86_gsbase_write_cpu_inactive()

As an advantage of the unified namespace we can now see all FS/GSBASE
API use in the kernel via the following 'git grep' pattern:

  $ git grep x86_.*sbase

[ mingo: Wrote new changelog. ]

Based-on-code-from: Andy Lutomirski <luto@kernel.org>
Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Markus T Metzger <markus.t.metzger@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1537312139-5580-3-git-send-email-chang.seok.bae@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/fsgsbase.h |  50 ++++++++++++++++
 arch/x86/kernel/process_64.c    | 124 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/ptrace.c        |  51 ++---------------
 3 files changed, 179 insertions(+), 46 deletions(-)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
new file mode 100644
index 000000000000..1ab465ee23fe
--- /dev/null
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_FSGSBASE_H
+#define _ASM_FSGSBASE_H 1
+
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_X86_64
+
+#include <asm/msr-index.h>
+
+unsigned long x86_fsgsbase_read_task(struct task_struct *task,
+				     unsigned short selector);
+
+/*
+ * Read/write a task's fsbase or gsbase. This returns the value that
+ * the FS/GS base would have (if the task were to be resumed). These
+ * work on current or on a different non-running task.
+ */
+unsigned long x86_fsbase_read_task(struct task_struct *task);
+unsigned long x86_gsbase_read_task(struct task_struct *task);
+int x86_fsbase_write_task(struct task_struct *task, unsigned long fsbase);
+int x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase);
+
+/* Helper functions for reading/writing FS/GS base */
+
+static inline unsigned long x86_fsbase_read_cpu(void)
+{
+	unsigned long fsbase;
+
+	rdmsrl(MSR_FS_BASE, fsbase);
+	return fsbase;
+}
+
+void x86_fsbase_write_cpu(unsigned long fsbase);
+
+static inline unsigned long x86_gsbase_read_cpu_inactive(void)
+{
+	unsigned long gsbase;
+
+	rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
+	return gsbase;
+}
+
+void x86_gsbase_write_cpu_inactive(unsigned long gsbase);
+
+#endif /* CONFIG_X86_64 */
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_FSGSBASE_H */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index ea5ea850348d..2a53ff8d1baf 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -54,6 +54,7 @@
 #include <asm/vdso.h>
 #include <asm/intel_rdt_sched.h>
 #include <asm/unistd.h>
+#include <asm/fsgsbase.h>
 #ifdef CONFIG_IA32_EMULATION
 /* Not included via unistd.h */
 #include <asm/unistd_32_ia32.h>
@@ -286,6 +287,129 @@ static __always_inline void load_seg_legacy(unsigned short prev_index,
 	}
 }
 
+unsigned long x86_fsgsbase_read_task(struct task_struct *task,
+				     unsigned short selector)
+{
+	unsigned short idx = selector >> 3;
+	unsigned long base;
+
+	if (likely((selector & SEGMENT_TI_MASK) == 0)) {
+		if (unlikely(idx >= GDT_ENTRIES))
+			return 0;
+
+		/*
+		 * There are no user segments in the GDT with nonzero bases
+		 * other than the TLS segments.
+		 */
+		if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
+			return 0;
+
+		idx -= GDT_ENTRY_TLS_MIN;
+		base = get_desc_base(&task->thread.tls_array[idx]);
+	} else {
+#ifdef CONFIG_MODIFY_LDT_SYSCALL
+		struct ldt_struct *ldt;
+
+		/*
+		 * If performance here mattered, we could protect the LDT
+		 * with RCU.  This is a slow path, though, so we can just
+		 * take the mutex.
+		 */
+		mutex_lock(&task->mm->context.lock);
+		ldt = task->mm->context.ldt;
+		if (unlikely(idx >= ldt->nr_entries))
+			base = 0;
+		else
+			base = get_desc_base(ldt->entries + idx);
+		mutex_unlock(&task->mm->context.lock);
+#else
+		base = 0;
+#endif
+	}
+
+	return base;
+}
+
+void x86_fsbase_write_cpu(unsigned long fsbase)
+{
+	/*
+	 * Set the selector to 0 as a notion, that the segment base is
+	 * overwritten, which will be checked for skipping the segment load
+	 * during context switch.
+	 */
+	loadseg(FS, 0);
+	wrmsrl(MSR_FS_BASE, fsbase);
+}
+
+void x86_gsbase_write_cpu_inactive(unsigned long gsbase)
+{
+	/* Set the selector to 0 for the same reason as %fs above. */
+	loadseg(GS, 0);
+	wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
+}
+
+unsigned long x86_fsbase_read_task(struct task_struct *task)
+{
+	unsigned long fsbase;
+
+	if (task == current)
+		fsbase = x86_fsbase_read_cpu();
+	else if (task->thread.fsindex == 0)
+		fsbase = task->thread.fsbase;
+	else
+		fsbase = x86_fsgsbase_read_task(task, task->thread.fsindex);
+
+	return fsbase;
+}
+
+unsigned long x86_gsbase_read_task(struct task_struct *task)
+{
+	unsigned long gsbase;
+
+	if (task == current)
+		gsbase = x86_gsbase_read_cpu_inactive();
+	else if (task->thread.gsindex == 0)
+		gsbase = task->thread.gsbase;
+	else
+		gsbase = x86_fsgsbase_read_task(task, task->thread.gsindex);
+
+	return gsbase;
+}
+
+int x86_fsbase_write_task(struct task_struct *task, unsigned long fsbase)
+{
+	/*
+	 * Not strictly needed for %fs, but do it for symmetry
+	 * with %gs
+	 */
+	if (unlikely(fsbase >= TASK_SIZE_MAX))
+		return -EPERM;
+
+	preempt_disable();
+	task->thread.fsbase = fsbase;
+	if (task == current)
+		x86_fsbase_write_cpu(fsbase);
+	task->thread.fsindex = 0;
+	preempt_enable();
+
+	return 0;
+}
+
+int x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase)
+{
+	if (unlikely(gsbase >= TASK_SIZE_MAX))
+		return -EPERM;
+
+	preempt_disable();
+	task->thread.gsbase = gsbase;
+	if (task == current)
+		x86_gsbase_write_cpu_inactive(gsbase);
+	task->thread.gsindex = 0;
+	preempt_enable();
+
+	return 0;
+}
+
 int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 		unsigned long arg, struct task_struct *p, unsigned long tls)
 {
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 3acbf45cb7fb..fbde2a7ce377 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -39,7 +39,7 @@
 #include <asm/hw_breakpoint.h>
 #include <asm/traps.h>
 #include <asm/syscall.h>
-#include <asm/mmu_context.h>
+#include <asm/fsgsbase.h>
 
 #include "tls.h"
 
@@ -343,49 +343,6 @@ static int set_segment_reg(struct task_struct *task,
 	return 0;
 }
 
-static unsigned long task_seg_base(struct task_struct *task,
-				   unsigned short selector)
-{
-	unsigned short idx = selector >> 3;
-	unsigned long base;
-
-	if (likely((selector & SEGMENT_TI_MASK) == 0)) {
-		if (unlikely(idx >= GDT_ENTRIES))
-			return 0;
-
-		/*
-		 * There are no user segments in the GDT with nonzero bases
-		 * other than the TLS segments.
-		 */
-		if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
-			return 0;
-
-		idx -= GDT_ENTRY_TLS_MIN;
-		base = get_desc_base(&task->thread.tls_array[idx]);
-	} else {
-#ifdef CONFIG_MODIFY_LDT_SYSCALL
-		struct ldt_struct *ldt;
-
-		/*
-		 * If performance here mattered, we could protect the LDT
-		 * with RCU.  This is a slow path, though, so we can just
-		 * take the mutex.
-		 */
-		mutex_lock(&task->mm->context.lock);
-		ldt = task->mm->context.ldt;
-		if (unlikely(idx >= ldt->nr_entries))
-			base = 0;
-		else
-			base = get_desc_base(ldt->entries + idx);
-		mutex_unlock(&task->mm->context.lock);
-#else
-		base = 0;
-#endif
-	}
-
-	return base;
-}
-
 #endif	/* CONFIG_X86_32 */
 
 static unsigned long get_flags(struct task_struct *task)
@@ -482,13 +439,15 @@ static unsigned long getreg(struct task_struct *task, unsigned long offset)
 		if (task->thread.fsindex == 0)
 			return task->thread.fsbase;
 		else
-			return task_seg_base(task, task->thread.fsindex);
+			return x86_fsgsbase_read_task(task,
+						      task->thread.fsindex);
 	}
 	case offsetof(struct user_regs_struct, gs_base): {
 		if (task->thread.gsindex == 0)
 			return task->thread.gsbase;
 		else
-			return task_seg_base(task, task->thread.gsindex);
+			return x86_fsgsbase_read_task(task,
+						      task->thread.gsindex);
 	}
 #endif
 	}
