Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755965AbeEaR7B (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:59:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:18555 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755852AbeEaR64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:58:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="60725500"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 02/15] x86/fsgsbase/64: Make ptrace read FS/GS base accurately
Date: Thu, 31 May 2018 10:58:32 -0700
Message-Id: <1527789525-8857-3-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com>
References: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

ptrace can read FS/GS base using the register access API
(PTRACE_PEEKUSER, etc) or PTRACE_ARCH_PRCTL.  Make both of these
mechanisms return the actual FS/GS base.

This will improve debuggability by providing the correct information
to ptracer (GDB and etc).

Signed-off-by: Andy Lutomirski <luto@kernel.org>
[chang: Rebase and revise patch description]
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/process_64.c | 59 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 5506e1b..e498671 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -279,6 +279,49 @@ static __always_inline void load_seg_legacy(unsigned short prev_index,
 	}
 }
 
+static unsigned long task_seg_base(struct task_struct *task,
+				   unsigned short selector)
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
 void write_fsbase(unsigned long fsbase)
 {
 	/* set the selector to 0 to not confuse __switch_to */
@@ -299,12 +342,10 @@ unsigned long read_task_fsbase(struct task_struct *task)
 
 	if (task == current)
 		fsbase = read_fsbase();
-	else
-		/*
-		 * XXX: This will not behave as expected if called
-		 * if fsindex != 0
-		 */
+	else if (task->thread.fsindex == 0)
 		fsbase = task->thread.fsbase;
+	else
+		fsbase = task_seg_base(task, task->thread.fsindex);
 
 	return fsbase;
 }
@@ -315,12 +356,10 @@ unsigned long read_task_gsbase(struct task_struct *task)
 
 	if (task == current)
 		gsbase = read_inactive_gsbase();
-	else
-		/*
-		 * XXX: This will not behave as expected if called
-		 * if gsindex != 0
-		 */
+	else if (task->thread.gsindex == 0)
 		gsbase = task->thread.gsbase;
+	else
+		gsbase = task_seg_base(task, task->thread.gsindex);
 
 	return gsbase;
 }
-- 
2.7.4
