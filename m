Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664B2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA4820858
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA4820858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbeKQJl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:41:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:44214 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbeKQJl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:41:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 15:27:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,242,1539673200"; 
   d="scan'208";a="108829745"
Received: from chang-linux-2.sc.intel.com ([10.3.52.165])
  by fmsmga001.fm.intel.com with ESMTP; 16 Nov 2018 15:27:31 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v5] x86/fsgsbase/64: Fix the base write helper functions
Date:   Fri, 16 Nov 2018 15:27:28 -0800
Message-Id: <20181116232728.23538-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper functions that purport to write the base should just write it
only. It shouldn't have magic optimizations to change the index.

Make the index explicitly changed from the caller, instead of including
the code in the helpers.

Subsequently, the task write helpers do not handle for the current task
anymore. The range check for a base value is also factored out, to
minimize code redundancy from the caller.

v2: Fix further on the task write functions. Revert the changes on the
task read helpers.

v3: Fix putreg(). Edit the changelog.

v4: Update the task write helper functions and do_arch_prctl_64(). Fix
the comment in putreg().

v5: Fix preempt_disable() calls in do_arch_prctl_64()

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/include/asm/fsgsbase.h | 15 ++++--
 arch/x86/kernel/process_64.c    | 86 ++++++++++++++++-----------------
 arch/x86/kernel/ptrace.c        |  9 ++--
 3 files changed, 58 insertions(+), 52 deletions(-)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index eb377b6e9eed..bca4c743de77 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -16,8 +16,8 @@
  */
 extern unsigned long x86_fsbase_read_task(struct task_struct *task);
 extern unsigned long x86_gsbase_read_task(struct task_struct *task);
-extern int x86_fsbase_write_task(struct task_struct *task, unsigned long fsbase);
-extern int x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase);
+extern void x86_fsbase_write_task(struct task_struct *task, unsigned long fsbase);
+extern void x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase);
 
 /* Helper functions for reading/writing FS/GS base */
 
@@ -39,8 +39,15 @@ static inline unsigned long x86_gsbase_read_cpu_inactive(void)
 	return gsbase;
 }
 
-extern void x86_fsbase_write_cpu(unsigned long fsbase);
-extern void x86_gsbase_write_cpu_inactive(unsigned long gsbase);
+static inline void x86_fsbase_write_cpu(unsigned long fsbase)
+{
+	wrmsrl(MSR_FS_BASE, fsbase);
+}
+
+static inline void x86_gsbase_write_cpu_inactive(unsigned long gsbase)
+{
+	wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
+}
 
 #endif /* CONFIG_X86_64 */
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 31b4755369f0..e2c3dbe68d69 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -337,24 +337,6 @@ static unsigned long x86_fsgsbase_read_task(struct task_struct *task,
 	return base;
 }
 
-void x86_fsbase_write_cpu(unsigned long fsbase)
-{
-	/*
-	 * Set the selector to 0 as a notion, that the segment base is
-	 * overwritten, which will be checked for skipping the segment load
-	 * during context switch.
-	 */
-	loadseg(FS, 0);
-	wrmsrl(MSR_FS_BASE, fsbase);
-}
-
-void x86_gsbase_write_cpu_inactive(unsigned long gsbase)
-{
-	/* Set the selector to 0 for the same reason as %fs above. */
-	loadseg(GS, 0);
-	wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
-}
-
 unsigned long x86_fsbase_read_task(struct task_struct *task)
 {
 	unsigned long fsbase;
@@ -383,38 +365,18 @@ unsigned long x86_gsbase_read_task(struct task_struct *task)
 	return gsbase;
 }
 
-int x86_fsbase_write_task(struct task_struct *task, unsigned long fsbase)
+void x86_fsbase_write_task(struct task_struct *task, unsigned long fsbase)
 {
-	/*
-	 * Not strictly needed for %fs, but do it for symmetry
-	 * with %gs
-	 */
-	if (unlikely(fsbase >= TASK_SIZE_MAX))
-		return -EPERM;
+	WARN_ON_ONCE(task == current);
 
-	preempt_disable();
 	task->thread.fsbase = fsbase;
-	if (task == current)
-		x86_fsbase_write_cpu(fsbase);
-	task->thread.fsindex = 0;
-	preempt_enable();
-
-	return 0;
 }
 
-int x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase)
+void x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase)
 {
-	if (unlikely(gsbase >= TASK_SIZE_MAX))
-		return -EPERM;
+	WARN_ON_ONCE(task == current);
 
-	preempt_disable();
 	task->thread.gsbase = gsbase;
-	if (task == current)
-		x86_gsbase_write_cpu_inactive(gsbase);
-	task->thread.gsindex = 0;
-	preempt_enable();
-
-	return 0;
 }
 
 int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
@@ -758,11 +720,47 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 
 	switch (option) {
 	case ARCH_SET_GS: {
-		ret = x86_gsbase_write_task(task, arg2);
+		if (unlikely(arg2 >= TASK_SIZE_MAX))
+			return -EPERM;
+
+		preempt_disable();
+		/*
+		 * ARCH_SET_GS has always overwritten the index
+		 * and the base. Zero is the most sensible value
+		 * to put in the index, and is the only value that
+		 * makes any sense if FSGSBASE is unavailable.
+		 */
+		if (task == current) {
+			loadseg(GS, 0);
+			x86_gsbase_write_cpu_inactive(arg2);
+		} else {
+			task->thread.gsindex = 0;
+			x86_gsbase_write_task(task, arg2);
+		}
+		preempt_enable();
 		break;
 	}
 	case ARCH_SET_FS: {
-		ret = x86_fsbase_write_task(task, arg2);
+		/*
+		 * Not strictly needed for %fs, but do it for symmetry
+		 * with %gs
+		 */
+		if (unlikely(arg2 >= TASK_SIZE_MAX))
+			return -EPERM;
+
+		preempt_disable();
+		/*
+		 * Set the selector to 0 for the same reason
+		 * as %gs above.
+		 */
+		if (task == current) {
+			loadseg(FS, 0);
+			x86_fsbase_write_cpu(arg2);
+		} else {
+			task->thread.fsindex = 0;
+			x86_fsbase_write_task(task, arg2);
+		}
+		preempt_enable();
 		break;
 	}
 	case ARCH_GET_FS: {
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index ffae9b9740fd..4b8ee05dd6ad 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -397,11 +397,12 @@ static int putreg(struct task_struct *child,
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
 		/*
-		 * When changing the FS base, use the same
-		 * mechanism as for do_arch_prctl_64().
+		 * When changing the FS base, use do_arch_prctl_64()
+		 * to set the index to zero and to set the base
+		 * as requested.
 		 */
 		if (child->thread.fsbase != value)
-			return x86_fsbase_write_task(child, value);
+			return do_arch_prctl_64(child, ARCH_SET_FS, value);
 		return 0;
 	case offsetof(struct user_regs_struct,gs_base):
 		/*
@@ -410,7 +411,7 @@ static int putreg(struct task_struct *child,
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
 		if (child->thread.gsbase != value)
-			return x86_gsbase_write_task(child, value);
+			return do_arch_prctl_64(child, ARCH_SET_GS, value);
 		return 0;
 #endif
 	}
-- 
2.19.1

