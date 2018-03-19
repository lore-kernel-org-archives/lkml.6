Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971819AbeCSU7K (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:59:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:62509 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965540AbeCSSIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:08:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="39330560"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: x86@kernel.org
Cc: luto@kernel.org, ak@linux.intel.com, hpa@zytor.com,
        markus.t.metzger@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH 01/15] x86/fsgsbase/64: Introduce FS/GS base helper functions
Date: Mon, 19 Mar 2018 10:49:13 -0700
Message-Id: <1521481767-22113-2-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With new helpers, FS/GS base access is centralized.
Eventually, when FSGSBASE instruction enabled, it will
be faster.

The helpers are used on ptrace APIs (PTRACE_ARCH_PRCTL,
PTRACE_SETREG, PTRACE_GETREG, etc). Idea is to keep
the FS/GS-update mechanism organized.

Notion of "active" and "shadow" are used to distinguish
GS bases between "kernel" and "user". "shadow" GS base
refers to the GS base backed up at kernel entries;
inactive (user) task's GS base.

Based-on-code-from: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
---
 arch/x86/include/asm/fsgsbase.h |  48 +++++++++++++++
 arch/x86/kernel/process_64.c    | 128 +++++++++++++++++++++++++++++-----------
 arch/x86/kernel/ptrace.c        |  28 +++------
 3 files changed, 150 insertions(+), 54 deletions(-)
 create mode 100644 arch/x86/include/asm/fsgsbase.h

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
new file mode 100644
index 0000000..29249f6
--- /dev/null
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -0,0 +1,48 @@
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
+ * Read/write an (inactive) task's fsbase or gsbase. This returns
+ * the value that the FS/GS base would have (if the task were to be
+ * resumed). The current task is also supported.
+ */
+unsigned long read_task_fsbase(struct task_struct *task);
+unsigned long read_task_gsbase(struct task_struct *task);
+int write_task_fsbase(struct task_struct *task, unsigned long fsbase);
+int write_task_gsbase(struct task_struct *task, unsigned long gsbase);
+
+/*
+ * Helper functions for reading/writing FS/GS base
+ */
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
+static inline unsigned long read_shadow_gsbase(void)
+{
+	unsigned long gsbase;
+
+	rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
+	return gsbase;
+}
+
+void  write_shadow_gsbase(unsigned long gsbase);
+
+#endif /* CONFIG_X86_64 */
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_FSGSBASE_H */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 9eb448c..65be0a6 100644
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
@@ -264,6 +265,90 @@ static __always_inline void load_seg_legacy(unsigned short prev_index,
 	}
 }
 
+void write_fsbase(unsigned long fsbase)
+{
+	/* set the selector to 0 to not confuse __switch_to */
+	loadseg(FS, 0);
+	wrmsrl(MSR_FS_BASE, fsbase);
+}
+
+void write_shadow_gsbase(unsigned long gsbase)
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
+	if (task == current)
+		fsbase = read_fsbase();
+	else
+		/*
+		 * XXX: This will not behave as expected if called
+		 * if fsindex != 0
+		 */
+		fsbase = task->thread.fsbase;
+
+	return fsbase;
+}
+
+unsigned long read_task_gsbase(struct task_struct *task)
+{
+	unsigned long gsbase;
+
+	if (task == current)
+		gsbase = read_shadow_gsbase();
+	else
+		/*
+		 * XXX: This will not behave as expected if called
+		 * if gsindex != 0
+		 */
+		gsbase = task->thread.gsbase;
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
+		write_shadow_gsbase(gsbase);
+	task->thread.gsindex = 0;
+	put_cpu();
+
+	return 0;
+}
+
 int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 		unsigned long arg, struct task_struct *p, unsigned long tls)
 {
@@ -603,54 +688,27 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
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
index ed5c4cd..b2f0beb 100644
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
