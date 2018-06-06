Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EBCB4601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932992AbeFFQYx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 12:24:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:61008 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753330AbeFFQXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:23:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,483,1520924400";
   d="scan'208";a="62323463"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/8] x86/fsgsbase/64: Make ptrace read FS/GS base accurately
Date: Wed,  6 Jun 2018 09:23:13 -0700
Message-Id: <1528302199-29619-3-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528302199-29619-1-git-send-email-chang.seok.bae@intel.com>
References: <1528302199-29619-1-git-send-email-chang.seok.bae@intel.com>
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
 arch/x86/kernel/process_64.c | 67 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index ace0158..e498671 100644
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
@@ -297,16 +340,12 @@ unsigned long read_task_fsbase(struct task_struct *task)
 {
 	unsigned long fsbase;
 
-	if (task == current) {
+	if (task == current)
 		fsbase = read_fsbase();
-	} else {
-		/*
-		 * XXX: This will not behave as expected if called
-		 * if fsindex != 0. This preserves an existing bug
-		 * that will be fixed.
-		 */
+	else if (task->thread.fsindex == 0)
 		fsbase = task->thread.fsbase;
-	}
+	else
+		fsbase = task_seg_base(task, task->thread.fsindex);
 
 	return fsbase;
 }
@@ -315,16 +354,12 @@ unsigned long read_task_gsbase(struct task_struct *task)
 {
 	unsigned long gsbase;
 
-	if (task == current) {
+	if (task == current)
 		gsbase = read_inactive_gsbase();
-	} else {
-		/*
-		 * XXX: This will not behave as expected if called
-		 * if gsindex != 0. Same bug preservation as above
-		 * read_task_fsbase.
-		 */
+	else if (task->thread.gsindex == 0)
 		gsbase = task->thread.gsbase;
-	}
+	else
+		gsbase = task_seg_base(task, task->thread.gsindex);
 
 	return gsbase;
 }
-- 
2.7.4
