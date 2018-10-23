Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA55C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9A82082F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9A82082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbeJXDIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:08:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:55080 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbeJXDIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:08:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 11:43:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,417,1534834800"; 
   d="scan'208";a="243726577"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by orsmga004.jf.intel.com with ESMTP; 23 Oct 2018 11:43:25 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [v3 04/12] x86/fsgsbase/64: Enable FSGSBASE instructions in the helper functions
Date:   Tue, 23 Oct 2018 11:42:26 -0700
Message-Id: <20181023184234.14025-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181023184234.14025-1-chang.seok.bae@intel.com>
References: <20181023184234.14025-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper functions will switch on faster accesses to FSBASE and GSBASE
when the FSGSBASE feature is enabled.

Accessing user GSBASE needs a couple of SWAPGS operations. It is avoidable
if the user GSBASE is saved at kernel entry, being updated as changes, and
restored back at kernel exit. However, it seems to spend more cycles for
savings and restorations. Little or no benefit was measured from
experiments.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Any Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/include/asm/fsgsbase.h | 17 +++----
 arch/x86/kernel/process_64.c    | 82 +++++++++++++++++++++++++++------
 2 files changed, 75 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index b4d4509b786c..e500d771155f 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -57,26 +57,23 @@ static __always_inline void wrgsbase(unsigned long gsbase)
 			: "memory");
 }
 
+#include <asm/cpufeature.h>
+
 /* Helper functions for reading/writing FS/GS base */
 
 static inline unsigned long x86_fsbase_read_cpu(void)
 {
 	unsigned long fsbase;
 
-	rdmsrl(MSR_FS_BASE, fsbase);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE))
+		fsbase = rdfsbase();
+	else
+		rdmsrl(MSR_FS_BASE, fsbase);
 
 	return fsbase;
 }
 
-static inline unsigned long x86_gsbase_read_cpu_inactive(void)
-{
-	unsigned long gsbase;
-
-	rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
-
-	return gsbase;
-}
-
+extern unsigned long x86_gsbase_read_cpu_inactive(void);
 extern void x86_fsbase_write_cpu(unsigned long fsbase);
 extern void x86_gsbase_write_cpu_inactive(unsigned long gsbase);
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 31b4755369f0..fcf18046c3d6 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -159,6 +159,36 @@ enum which_selector {
 	GS
 };
 
+/*
+ * Interrupts are disabled here. Out of line to be protected from kprobes.
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
+ * Interrupts are disabled here. Out of line to be protected from kprobes.
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
 /*
  * Saves the FS or GS base for an outgoing thread if FSGSBASE extensions are
  * not available.  The goal is to be reasonably fast on non-FSGSBASE systems.
@@ -337,22 +367,42 @@ static unsigned long x86_fsgsbase_read_task(struct task_struct *task,
 	return base;
 }
 
+unsigned long x86_gsbase_read_cpu_inactive(void)
+{
+	unsigned long gsbase;
+
+	if (static_cpu_has(X86_FEATURE_FSGSBASE))
+		gsbase = rd_inactive_gsbase();
+	else
+		rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
+
+	return gsbase;
+}
+
 void x86_fsbase_write_cpu(unsigned long fsbase)
 {
-	/*
-	 * Set the selector to 0 as a notion, that the segment base is
-	 * overwritten, which will be checked for skipping the segment load
-	 * during context switch.
-	 */
-	loadseg(FS, 0);
-	wrmsrl(MSR_FS_BASE, fsbase);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		wrfsbase(fsbase);
+	} else {
+		/*
+		 * Set the selector to 0 as a notion, that the segment base is
+		 * overwritten, which will be checked for skipping the segment load
+		 * during context switch.
+		 */
+		loadseg(FS, 0);
+		wrmsrl(MSR_FS_BASE, fsbase);
+	}
 }
 
 void x86_gsbase_write_cpu_inactive(unsigned long gsbase)
 {
-	/* Set the selector to 0 for the same reason as %fs above. */
-	loadseg(GS, 0);
-	wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		wr_inactive_gsbase(gsbase);
+	} else {
+		/* Set the selector to 0 for the same reason as %fs above. */
+		loadseg(GS, 0);
+		wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
+	}
 }
 
 unsigned long x86_fsbase_read_task(struct task_struct *task)
@@ -361,7 +411,8 @@ unsigned long x86_fsbase_read_task(struct task_struct *task)
 
 	if (task == current)
 		fsbase = x86_fsbase_read_cpu();
-	else if (task->thread.fsindex == 0)
+	else if (static_cpu_has(X86_FEATURE_FSGSBASE) ||
+		 (task->thread.fsindex == 0))
 		fsbase = task->thread.fsbase;
 	else
 		fsbase = x86_fsgsbase_read_task(task, task->thread.fsindex);
@@ -375,7 +426,8 @@ unsigned long x86_gsbase_read_task(struct task_struct *task)
 
 	if (task == current)
 		gsbase = x86_gsbase_read_cpu_inactive();
-	else if (task->thread.gsindex == 0)
+	else if (static_cpu_has(X86_FEATURE_FSGSBASE) ||
+		 (task->thread.gsindex == 0))
 		gsbase = task->thread.gsbase;
 	else
 		gsbase = x86_fsgsbase_read_task(task, task->thread.gsindex);
@@ -396,7 +448,8 @@ int x86_fsbase_write_task(struct task_struct *task, unsigned long fsbase)
 	task->thread.fsbase = fsbase;
 	if (task == current)
 		x86_fsbase_write_cpu(fsbase);
-	task->thread.fsindex = 0;
+	if (!static_cpu_has(X86_FEATURE_FSGSBASE))
+		task->thread.fsindex = 0;
 	preempt_enable();
 
 	return 0;
@@ -411,7 +464,8 @@ int x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase)
 	task->thread.gsbase = gsbase;
 	if (task == current)
 		x86_gsbase_write_cpu_inactive(gsbase);
-	task->thread.gsindex = 0;
+	if (!static_cpu_has(X86_FEATURE_FSGSBASE))
+		task->thread.gsindex = 0;
 	preempt_enable();
 
 	return 0;
-- 
2.19.1

