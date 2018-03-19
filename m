Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971784AbeCSU4f (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:56:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:62511 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968530AbeCSSIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:08:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="39330592"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: x86@kernel.org
Cc: luto@kernel.org, ak@linux.intel.com, hpa@zytor.com,
        markus.t.metzger@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH 10/15] x86/fsgsbase/64: Enable FSGSBASE instructions in helper functions
Date: Mon, 19 Mar 2018 10:49:22 -0700
Message-Id: <1521481767-22113-11-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
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
---
 arch/x86/include/asm/fsgsbase.h | 17 ++++------
 arch/x86/kernel/process_64.c    | 75 +++++++++++++++++++++++++++++++++++------
 2 files changed, 72 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index cad2831..8936b7f 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -55,6 +55,8 @@ static __always_inline void wrgsbase(unsigned long gsbase)
 			: "memory");
 }
 
+#include <asm/cpufeature.h>
+
 /*
  * Helper functions for reading/writing FS/GS base
  */
@@ -63,20 +65,15 @@ static inline unsigned long read_fsbase(void)
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
-static inline unsigned long read_shadow_gsbase(void)
-{
-	unsigned long gsbase;
-
-	rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
-	return gsbase;
-}
-
+unsigned long read_shadow_gsbase(void);
 void  write_shadow_gsbase(unsigned long gsbase);
 
 #endif /* CONFIG_X86_64 */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 4488f07..877636a 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -154,6 +154,38 @@ enum which_selector {
 };
 
 /*
+ * Interrupts are disabled here.
+ * Out of line to be protected from kprobes.
+ */
+static noinline __kprobes unsigned long rd_shadow_gsbase(void)
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
+static noinline __kprobes void wr_shadow_gsbase(unsigned long gsbase)
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
@@ -319,16 +351,35 @@ static unsigned long task_seg_base(struct task_struct *task,
 
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
+unsigned long read_shadow_gsbase(void)
+{
+	unsigned long gsbase;
+
+	if (static_cpu_has(X86_FEATURE_FSGSBASE))
+		gsbase = rd_shadow_gsbase();
+	else
+		rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
+	return gsbase;
 }
 
 void write_shadow_gsbase(unsigned long gsbase)
 {
-	/* set the selector to 0 to not confuse __switch_to */
-	loadseg(GS, 0);
-	wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		wr_shadow_gsbase(gsbase);
+	} else {
+		/* set the selector to 0 to not confuse __switch_to */
+		loadseg(GS, 0);
+		wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
+	}
 }
 
 unsigned long read_task_fsbase(struct task_struct *task)
@@ -337,7 +388,8 @@ unsigned long read_task_fsbase(struct task_struct *task)
 
 	if (task == current)
 		fsbase = read_fsbase();
-	else if (task->thread.fsindex == 0)
+	else if (static_cpu_has(X86_FEATURE_FSGSBASE) ||
+		 (task->thread.fsindex == 0))
 		fsbase = task->thread.fsbase;
 	else
 		fsbase = task_seg_base(task, task->thread.fsindex);
@@ -351,7 +403,8 @@ unsigned long read_task_gsbase(struct task_struct *task)
 
 	if (task == current)
 		gsbase = read_shadow_gsbase();
-	else if (task->thread.gsindex == 0)
+	else if (static_cpu_has(X86_FEATURE_FSGSBASE) ||
+		 (task->thread.gsindex == 0))
 		gsbase = task->thread.gsbase;
 	else
 		gsbase = task_seg_base(task, task->thread.gsindex);
@@ -374,7 +427,8 @@ int write_task_fsbase(struct task_struct *task, unsigned long fsbase)
 	task->thread.fsbase = fsbase;
 	if (task == current)
 		write_fsbase(fsbase);
-	task->thread.fsindex = 0;
+	if (!static_cpu_has(X86_FEATURE_FSGSBASE))
+		task->thread.fsindex = 0;
 	put_cpu();
 
 	return 0;
@@ -391,7 +445,8 @@ int write_task_gsbase(struct task_struct *task, unsigned long gsbase)
 	task->thread.gsbase = gsbase;
 	if (task == current)
 		write_shadow_gsbase(gsbase);
-	task->thread.gsindex = 0;
+	if (!static_cpu_has(X86_FEATURE_FSGSBASE))
+		task->thread.gsindex = 0;
 	put_cpu();
 
 	return 0;
-- 
2.7.4
