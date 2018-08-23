Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0907C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943A4208F7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943A4208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbeHWUQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:16:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:1808 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbeHWUPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:15:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2018 09:45:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,278,1531810800"; 
   d="scan'208";a="227129260"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by orsmga004.jf.intel.com with ESMTP; 23 Aug 2018 09:45:14 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH V5 2/8] x86/fsgsbase/64: Introduce FS/GS base helper functions
Date:   Thu, 23 Aug 2018 09:44:32 -0700
Message-Id: <1535042678-31366-3-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535042678-31366-1-git-send-email-chang.seok.bae@intel.com>
References: <1535042678-31366-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With new helpers, FS/GS base access is centralized.
Eventually, when FSGSBASE instruction enabled, it will
be faster.

"inactive" GS base refers to base backed up at kernel
entries and of inactive (user) task's.

task_seg_base() is moved out to kernel/process_64.c, where
the helper functions are implemented as closely coupled.
When next patch makes ptrace to use the helpers, it
won't be directly accessed from ptrace.

Based-on-code-from: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/include/asm/fsgsbase.h |  49 ++++++++++++++++
 arch/x86/kernel/process_64.c    | 123 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/ptrace.c        |  45 +--------------
 3 files changed, 173 insertions(+), 44 deletions(-)
 create mode 100644 arch/x86/include/asm/fsgsbase.h

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
new file mode 100644
index 0000000..9dce8c0
--- /dev/null
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -0,0 +1,49 @@
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
+unsigned long task_seg_base(struct task_struct *task, unsigned short selector);
+
+/*
+ * Read/write a task's fsbase or gsbase. This returns the value that
+ * the FS/GS base would have (if the task were to be resumed). These
+ * work on current or on a different non-running task.
+ */
+unsigned long read_task_fsbase(struct task_struct *task);
+unsigned long read_task_gsbase(struct task_struct *task);
+int write_task_fsbase(struct task_struct *task, unsigned long fsbase);
+int write_task_gsbase(struct task_struct *task, unsigned long gsbase);
+
+/* Helper functions for reading/writing FS/GS base */
+
+static inline unsigned long read_fsbase(void)
+{
+	unsigned long fsbase;
+
+	rdmsrl(MSR_FS_BASE, fsbase);
+	return fsbase;
+}
+
+void write_fsbase(unsigned long fsbase);
+
+static inline unsigned long read_inactive_gsbase(void)
+{
+	unsigned long gsbase;
+
+	rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
+	return gsbase;
+}
+
+void  write_inactive_gsbase(unsigned long gsbase);
+
+#endif /* CONFIG_X86_64 */
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_FSGSBASE_H */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 12bb445..ec76796 100644
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
@@ -278,6 +279,128 @@ static __always_inline void load_seg_legacy(unsigned short prev_index,
 	}
 }
 
+unsigned long task_seg_base(struct task_struct *task, unsigned short selector)
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
+void write_fsbase(unsigned long fsbase)
+{
+	/*
+	 * set the selector to 0 as a notion, that the segment base is
+	 * overwritten, which will be checked for skipping the segment load
+	 * during context switch.
+	 */
+	loadseg(FS, 0);
+	wrmsrl(MSR_FS_BASE, fsbase);
+}
+
+void write_inactive_gsbase(unsigned long gsbase)
+{
+	/* set the selector to 0 for the same reason as %fs above. */
+	loadseg(GS, 0);
+	wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
+}
+
+unsigned long read_task_fsbase(struct task_struct *task)
+{
+	unsigned long fsbase;
+
+	if (task == current)
+		fsbase = read_fsbase();
+	else if (task->thread.fsindex == 0)
+		fsbase = task->thread.fsbase;
+	else
+		fsbase = task_seg_base(task, task->thread.fsindex);
+
+	return fsbase;
+}
+
+unsigned long read_task_gsbase(struct task_struct *task)
+{
+	unsigned long gsbase;
+
+	if (task == current)
+		gsbase = read_inactive_gsbase();
+	else if (task->thread.gsindex == 0)
+		gsbase = task->thread.gsbase;
+	else
+		gsbase = task_seg_base(task, task->thread.gsindex);
+
+	return gsbase;
+}
+
+int write_task_fsbase(struct task_struct *task, unsigned long fsbase)
+{
+	/*
+	 * Not strictly needed for fs, but do it for symmetry
+	 * with gs
+	 */
+	if (unlikely(fsbase >= TASK_SIZE_MAX))
+		return -EPERM;
+
+	preempt_disable();
+	task->thread.fsbase = fsbase;
+	if (task == current)
+		write_fsbase(fsbase);
+	task->thread.fsindex = 0;
+	preempt_enable();
+
+	return 0;
+}
+
+int write_task_gsbase(struct task_struct *task, unsigned long gsbase)
+{
+	if (unlikely(gsbase >= TASK_SIZE_MAX))
+		return -EPERM;
+
+	preempt_disable();
+	task->thread.gsbase = gsbase;
+	if (task == current)
+		write_inactive_gsbase(gsbase);
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
index 3acbf45..7be53f9 100644
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
-- 
2.7.4

