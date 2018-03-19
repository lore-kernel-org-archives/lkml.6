Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971856AbeCSU6g (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:58:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:62510 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965554AbeCSSIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:08:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="39330563"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: x86@kernel.org
Cc: luto@kernel.org, ak@linux.intel.com, hpa@zytor.com,
        markus.t.metzger@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH 02/15] x86/fsgsbase/64: Make ptrace read FS/GS base accurately
Date: Mon, 19 Mar 2018 10:49:14 -0700
Message-Id: <1521481767-22113-3-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
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
---
 arch/x86/kernel/process_64.c | 59 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 65be0a6..2375f10 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -265,6 +265,49 @@ static __always_inline void load_seg_legacy(unsigned short prev_index,
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
@@ -285,12 +328,10 @@ unsigned long read_task_fsbase(struct task_struct *task)
 
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
@@ -301,12 +342,10 @@ unsigned long read_task_gsbase(struct task_struct *task)
 
 	if (task == current)
 		gsbase = read_shadow_gsbase();
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
