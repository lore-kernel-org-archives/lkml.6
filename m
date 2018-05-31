Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756014AbeEaSBM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 14:01:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:18561 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755956AbeEaR7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:59:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="60725528"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 09/15] x86/fsgsbase/64: Enable FSGSBASE instructions in helper functions
Date: Thu, 31 May 2018 10:58:39 -0700
Message-Id: <1527789525-8857-10-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com>
References: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper functions switch on faster access to FS/GS, when
FSGSBASE enabled.

Accessing user GS base needs a couple of SWPAGS. It is avoidable
if the user GS base is copied at kernel entry and updated as
changed, and (actual) GS base is written back at kernel exit.
However, it costs more cycles to do that. The measured
overhead was (almost) offset to the benefit.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Any Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/fsgsbase.h | 17 ++++------
 arch/x86/kernel/process_64.c    | 75 +++++++++++++++++++++++++++++++++++------
 2 files changed, 72 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index ed42015..903c7a0 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -54,26 +54,23 @@ static __always_inline void wrgsbase(unsigned long gsbase)
 			: "memory");
 }
 
+#include <asm/cpufeature.h>
+
 /* Helper functions for reading/writing FS/GS base */
 
 static inline unsigned long read_fsbase(void)
 {
 	unsigned long fsbase;
 
-	rdmsrl(MSR_FS_BASE, fsbase);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE))
+		fsbase = rdfsbase();
+	else
+		rdmsrl(MSR_FS_BASE, fsbase);
 	return fsbase;
 }
 
 void write_fsbase(unsigned long fsbase);
-
-static inline unsigned long read_inactive_gsbase(void)
-{
-	unsigned long gsbase;
-
-	rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
-	return gsbase;
-}
-
+unsigned long read_inactive_gsbase(void);
 void  write_inactive_gsbase(unsigned long gsbase);
 
 #endif /* CONFIG_X86_64 */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index cebf240..8ba947f 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -154,6 +154,38 @@ enum which_selector {
 };
 
 /*
+ * Interrupts are disabled here.
+ * Out of line to be protected from kprobes.
+ */
+static noinline __kprobes unsigned long rd_inactive_gsbase(void)
+{
+	unsigned long gsbase, flags;
+
+	local_irq_save(flags);
+	native_swapgs();
+	gsbase = rdgsbase();
+	native_swapgs();
+	local_irq_restore(flags);
+
+	return gsbase;
+}
+
+/*
+ * Interrupts are disabled here.
+ * Out of line to be protected from kprobes.
+ */
+static noinline __kprobes void wr_inactive_gsbase(unsigned long gsbase)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	native_swapgs();
+	wrgsbase(gsbase);
+	native_swapgs();
+	local_irq_restore(flags);
+}
+
+/*
  * Saves the FS or GS base for an outgoing thread if FSGSBASE extensions are
  * not available.  The goal is to be reasonably fast on non-FSGSBASE systems.
  * It's forcibly inlined because it'll generate better code and this function
@@ -333,16 +365,35 @@ static unsigned long task_seg_base(struct task_struct *task,
 
 void write_fsbase(unsigned long fsbase)
 {
-	/* set the selector to 0 to not confuse __switch_to */
-	loadseg(FS, 0);
-	wrmsrl(MSR_FS_BASE, fsbase);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		wrfsbase(fsbase);
+	} else {
+		/* set the selector to 0 to not confuse __switch_to */
+		loadseg(FS, 0);
+		wrmsrl(MSR_FS_BASE, fsbase);
+	}
+}
+
+unsigned long read_inactive_gsbase(void)
+{
+	unsigned long gsbase;
+
+	if (static_cpu_has(X86_FEATURE_FSGSBASE))
+		gsbase = rd_inactive_gsbase();
+	else
+		rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
+	return gsbase;
 }
 
 void write_inactive_gsbase(unsigned long gsbase)
 {
-	/* set the selector to 0 to not confuse __switch_to */
-	loadseg(GS, 0);
-	wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		wr_inactive_gsbase(gsbase);
+	} else {
+		/* set the selector to 0 to not confuse __switch_to */
+		loadseg(GS, 0);
+		wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
+	}
 }
 
 unsigned long read_task_fsbase(struct task_struct *task)
@@ -351,7 +402,8 @@ unsigned long read_task_fsbase(struct task_struct *task)
 
 	if (task == current)
 		fsbase = read_fsbase();
-	else if (task->thread.fsindex == 0)
+	else if (static_cpu_has(X86_FEATURE_FSGSBASE) ||
+		 (task->thread.fsindex == 0))
 		fsbase = task->thread.fsbase;
 	else
 		fsbase = task_seg_base(task, task->thread.fsindex);
@@ -365,7 +417,8 @@ unsigned long read_task_gsbase(struct task_struct *task)
 
 	if (task == current)
 		gsbase = read_inactive_gsbase();
-	else if (task->thread.gsindex == 0)
+	else if (static_cpu_has(X86_FEATURE_FSGSBASE) ||
+		 (task->thread.gsindex == 0))
 		gsbase = task->thread.gsbase;
 	else
 		gsbase = task_seg_base(task, task->thread.gsindex);
@@ -388,7 +441,8 @@ int write_task_fsbase(struct task_struct *task, unsigned long fsbase)
 	task->thread.fsbase = fsbase;
 	if (task == current)
 		write_fsbase(fsbase);
-	task->thread.fsindex = 0;
+	if (!static_cpu_has(X86_FEATURE_FSGSBASE))
+		task->thread.fsindex = 0;
 	put_cpu();
 
 	return 0;
@@ -405,7 +459,8 @@ int write_task_gsbase(struct task_struct *task, unsigned long gsbase)
 	task->thread.gsbase = gsbase;
 	if (task == current)
 		write_inactive_gsbase(gsbase);
-	task->thread.gsindex = 0;
+	if (!static_cpu_has(X86_FEATURE_FSGSBASE))
+		task->thread.gsindex = 0;
 	put_cpu();
 
 	return 0;
-- 
2.7.4
