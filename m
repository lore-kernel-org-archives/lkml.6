Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F4BC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A249218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfBAUy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:54:59 -0500
Received: from mga07.intel.com ([134.134.136.100]:49739 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729678AbfBAUy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 15:54:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 12:54:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,549,1539673200"; 
   d="scan'208";a="140866359"
Received: from chang-linux-2.sc.intel.com ([10.3.52.165])
  by fmsmga004.fm.intel.com with ESMTP; 01 Feb 2019 12:54:55 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [PATCH v5 05/13] x86/fsgsbase/64: Enable FSGSBASE instructions in the helper functions
Date:   Fri,  1 Feb 2019 12:53:11 -0800
Message-Id: <20190201205319.15995-7-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190201205319.15995-1-chang.seok.bae@intel.com>
References: <20190201205319.15995-1-chang.seok.bae@intel.com>
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

Also, introduce __{rd,wr}gsbase_inactive() as helpers to access user GSBASE
with SWAPGS. Note, for Xen PV, paravirt hooks can be added, since it may
allow a very efficient but different implementation.

[ Use NOKPROBE_SYMBOL instead of __kprobes ]

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Any Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
---
 arch/x86/include/asm/fsgsbase.h | 27 +++++++-------
 arch/x86/kernel/process_64.c    | 62 +++++++++++++++++++++++++++++++--
 2 files changed, 72 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index fdd1177499b4..aefd53767a5d 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -49,35 +49,32 @@ static __always_inline void wrgsbase(unsigned long gsbase)
 	asm volatile("wrgsbase %0" :: "r" (gsbase) : "memory");
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
 static inline void x86_fsbase_write_cpu(unsigned long fsbase)
 {
-	wrmsrl(MSR_FS_BASE, fsbase);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE))
+		wrfsbase(fsbase);
+	else
+		wrmsrl(MSR_FS_BASE, fsbase);
 }
 
-static inline void x86_gsbase_write_cpu_inactive(unsigned long gsbase)
-{
-	wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
-}
+extern unsigned long x86_gsbase_read_cpu_inactive(void);
+extern void x86_gsbase_write_cpu_inactive(unsigned long gsbase);
 
 #endif /* CONFIG_X86_64 */
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 6a62f4af9fcf..ebc55ed31fe7 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -160,6 +160,42 @@ enum which_selector {
 	GS
 };
 
+/*
+ * Interrupts are disabled here. Out of line to be protected
+ * from kprobes. It is not used on Xen paravirt. When paravirt
+ * support is needed, it needs to be renamed with native_ prefix.
+ */
+static noinline unsigned long __rdgsbase_inactive(void)
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
+NOKPROBE_SYMBOL(__rdgsbase_inactive);
+
+/*
+ * Interrupts are disabled here. Out of line to be protected
+ * from kprobes. It is not used on Xen paravirt. When paravirt
+ * support is needed, it needs to be renamed with native_ prefix.
+ */
+static noinline void __wrgsbase_inactive(unsigned long gsbase)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	native_swapgs();
+	wrgsbase(gsbase);
+	native_swapgs();
+	local_irq_restore(flags);
+}
+NOKPROBE_SYMBOL(__wrgsbase_inactive);
+
 /*
  * Saves the FS or GS base for an outgoing thread if FSGSBASE extensions are
  * not available.  The goal is to be reasonably fast on non-FSGSBASE systems.
@@ -338,13 +374,34 @@ static unsigned long x86_fsgsbase_read_task(struct task_struct *task,
 	return base;
 }
 
+unsigned long x86_gsbase_read_cpu_inactive(void)
+{
+	unsigned long gsbase;
+
+	if (static_cpu_has(X86_FEATURE_FSGSBASE))
+		gsbase = __rdgsbase_inactive();
+	else
+		rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
+
+	return gsbase;
+}
+
+void x86_gsbase_write_cpu_inactive(unsigned long gsbase)
+{
+	if (static_cpu_has(X86_FEATURE_FSGSBASE))
+		__wrgsbase_inactive(gsbase);
+	else
+		wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
+}
+
 unsigned long x86_fsbase_read_task(struct task_struct *task)
 {
 	unsigned long fsbase;
 
 	if (task == current)
 		fsbase = x86_fsbase_read_cpu();
-	else if (task->thread.fsindex == 0)
+	else if (static_cpu_has(X86_FEATURE_FSGSBASE) ||
+		 (task->thread.fsindex == 0))
 		fsbase = task->thread.fsbase;
 	else
 		fsbase = x86_fsgsbase_read_task(task, task->thread.fsindex);
@@ -358,7 +415,8 @@ unsigned long x86_gsbase_read_task(struct task_struct *task)
 
 	if (task == current)
 		gsbase = x86_gsbase_read_cpu_inactive();
-	else if (task->thread.gsindex == 0)
+	else if (static_cpu_has(X86_FEATURE_FSGSBASE) ||
+		 (task->thread.gsindex == 0))
 		gsbase = task->thread.gsbase;
 	else
 		gsbase = x86_fsgsbase_read_task(task, task->thread.gsindex);
-- 
2.19.1

