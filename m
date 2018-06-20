Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB9BC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC30320652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC30320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932482AbeFTXPb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:15:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:8667 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754303AbeFTXP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:15:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 16:15:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,249,1526367600"; 
   d="scan'208";a="66325207"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by orsmga001.jf.intel.com with ESMTP; 20 Jun 2018 16:15:25 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/7] x86/fsgsbase/64: Introduce FS/GS base helper functions
Date:   Wed, 20 Jun 2018 16:15:00 -0700
Message-Id: <1529536506-26237-2-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com>
References: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With new helpers, FS/GS base access is centralized.
Eventually, when FSGSBASE instruction enabled, it will
be faster.

The helpers are used on ptrace APIs (PTRACE_ARCH_PRCTL,
PTRACE_SETREG, PTRACE_GETREG, etc). Idea is to keep
the FS/GS-update mechanism organized.

"inactive" GS base refers to base backed up at kernel
entries and of inactive (user) task's.

The bug that returns stale FS/GS base value (when index
is nonzero) is preserved and will be fixed by next
patch.

Based-on-code-from: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/fsgsbase.h |  47 ++++++++++++++
 arch/x86/kernel/process_64.c    | 132 +++++++++++++++++++++++++++++-----------
 arch/x86/kernel/ptrace.c        |  28 +++------
 3 files changed, 153 insertions(+), 54 deletions(-)
 create mode 100644 arch/x86/include/asm/fsgsbase.h

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
new file mode 100644
index 0000000..f00a8a6
--- /dev/null
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -0,0 +1,47 @@
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
index 12bb445..ace0158 100644
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
@@ -278,6 +279,94 @@ static __always_inline void load_seg_legacy(unsigned short prev_index,
 	}
 }
 
+void write_fsbase(unsigned long fsbase)
+{
+	/* set the selector to 0 to not confuse __switch_to */
+	loadseg(FS, 0);
+	wrmsrl(MSR_FS_BASE, fsbase);
+}
+
+void write_inactive_gsbase(unsigned long gsbase)
+{
+	/* set the selector to 0 to not confuse __switch_to */
+	loadseg(GS, 0);
+	wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
+}
+
+unsigned long read_task_fsbase(struct task_struct *task)
+{
+	unsigned long fsbase;
+
+	if (task == current) {
+		fsbase = read_fsbase();
+	} else {
+		/*
+		 * XXX: This will not behave as expected if called
+		 * if fsindex != 0. This preserves an existing bug
+		 * that will be fixed.
+		 */
+		fsbase = task->thread.fsbase;
+	}
+
+	return fsbase;
+}
+
+unsigned long read_task_gsbase(struct task_struct *task)
+{
+	unsigned long gsbase;
+
+	if (task == current) {
+		gsbase = read_inactive_gsbase();
+	} else {
+		/*
+		 * XXX: This will not behave as expected if called
+		 * if gsindex != 0. Same bug preservation as above
+		 * read_task_fsbase.
+		 */
+		gsbase = task->thread.gsbase;
+	}
+
+	return gsbase;
+}
+
+int write_task_fsbase(struct task_struct *task, unsigned long fsbase)
+{
+	int cpu;
+
+	/*
+	 * Not strictly needed for fs, but do it for symmetry
+	 * with gs
+	 */
+	if (unlikely(fsbase >= TASK_SIZE_MAX))
+		return -EPERM;
+
+	cpu = get_cpu();
+	task->thread.fsbase = fsbase;
+	if (task == current)
+		write_fsbase(fsbase);
+	task->thread.fsindex = 0;
+	put_cpu();
+
+	return 0;
+}
+
+int write_task_gsbase(struct task_struct *task, unsigned long gsbase)
+{
+	int cpu;
+
+	if (unlikely(gsbase >= TASK_SIZE_MAX))
+		return -EPERM;
+
+	cpu = get_cpu();
+	task->thread.gsbase = gsbase;
+	if (task == current)
+		write_inactive_gsbase(gsbase);
+	task->thread.gsindex = 0;
+	put_cpu();
+
+	return 0;
+}
+
 int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 		unsigned long arg, struct task_struct *p, unsigned long tls)
 {
@@ -618,54 +707,27 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 {
 	int ret = 0;
-	int doit = task == current;
-	int cpu;
 
 	switch (option) {
-	case ARCH_SET_GS:
-		if (arg2 >= TASK_SIZE_MAX)
-			return -EPERM;
-		cpu = get_cpu();
-		task->thread.gsindex = 0;
-		task->thread.gsbase = arg2;
-		if (doit) {
-			load_gs_index(0);
-			ret = wrmsrl_safe(MSR_KERNEL_GS_BASE, arg2);
-		}
-		put_cpu();
+	case ARCH_SET_GS: {
+		ret = write_task_gsbase(task, arg2);
 		break;
-	case ARCH_SET_FS:
-		/* Not strictly needed for fs, but do it for symmetry
-		   with gs */
-		if (arg2 >= TASK_SIZE_MAX)
-			return -EPERM;
-		cpu = get_cpu();
-		task->thread.fsindex = 0;
-		task->thread.fsbase = arg2;
-		if (doit) {
-			/* set the selector to 0 to not confuse __switch_to */
-			loadsegment(fs, 0);
-			ret = wrmsrl_safe(MSR_FS_BASE, arg2);
-		}
-		put_cpu();
+	}
+	case ARCH_SET_FS: {
+		ret = write_task_fsbase(task, arg2);
 		break;
+	}
 	case ARCH_GET_FS: {
 		unsigned long base;
 
-		if (doit)
-			rdmsrl(MSR_FS_BASE, base);
-		else
-			base = task->thread.fsbase;
+		base = read_task_fsbase(task);
 		ret = put_user(base, (unsigned long __user *)arg2);
 		break;
 	}
 	case ARCH_GET_GS: {
 		unsigned long base;
 
-		if (doit)
-			rdmsrl(MSR_KERNEL_GS_BASE, base);
-		else
-			base = task->thread.gsbase;
+		base = read_task_gsbase(task);
 		ret = put_user(base, (unsigned long __user *)arg2);
 		break;
 	}
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index e2ee403..c53c2bcf6 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -39,6 +39,7 @@
 #include <asm/hw_breakpoint.h>
 #include <asm/traps.h>
 #include <asm/syscall.h>
+#include <asm/fsgsbase.h>
 
 #include "tls.h"
 
@@ -396,12 +397,11 @@ static int putreg(struct task_struct *child,
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
 		/*
-		 * When changing the segment base, use do_arch_prctl_64
-		 * to set either thread.fs or thread.fsindex and the
-		 * corresponding GDT slot.
+		 * When changing the FS base, use the same
+		 * mechanism as for do_arch_prctl_64
 		 */
 		if (child->thread.fsbase != value)
-			return do_arch_prctl_64(child, ARCH_SET_FS, value);
+			return write_task_fsbase(child, value);
 		return 0;
 	case offsetof(struct user_regs_struct,gs_base):
 		/*
@@ -410,7 +410,7 @@ static int putreg(struct task_struct *child,
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
 		if (child->thread.gsbase != value)
-			return do_arch_prctl_64(child, ARCH_SET_GS, value);
+			return write_task_gsbase(child, value);
 		return 0;
 #endif
 	}
@@ -434,20 +434,10 @@ static unsigned long getreg(struct task_struct *task, unsigned long offset)
 		return get_flags(task);
 
 #ifdef CONFIG_X86_64
-	case offsetof(struct user_regs_struct, fs_base): {
-		/*
-		 * XXX: This will not behave as expected if called on
-		 * current or if fsindex != 0.
-		 */
-		return task->thread.fsbase;
-	}
-	case offsetof(struct user_regs_struct, gs_base): {
-		/*
-		 * XXX: This will not behave as expected if called on
-		 * current or if fsindex != 0.
-		 */
-		return task->thread.gsbase;
-	}
+	case offsetof(struct user_regs_struct, fs_base):
+		return read_task_fsbase(task);
+	case offsetof(struct user_regs_struct, gs_base):
+		return read_task_gsbase(task);
 #endif
 	}
 
-- 
2.7.4

