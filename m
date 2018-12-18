Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01609C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2D121873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeLRNeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:34:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55143 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeLRNeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:34:00 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIDXqSf2847145
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 05:33:52 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIDXqac2847142;
        Tue, 18 Dec 2018 05:33:52 -0800
Date:   Tue, 18 Dec 2018 05:33:52 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Chang S. Bae" <tipbot@zytor.com>
Message-ID: <tip-87ab4689ca6526079ab6f5150219ee88b42000ae@git.kernel.org>
Cc:     tglx@linutronix.de, chang.seok.bae@intel.com, luto@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        ravi.v.shankar@intel.com, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: tglx@linutronix.de, luto@kernel.org, chang.seok.bae@intel.com,
          dave.hansen@linux.intel.com, hpa@zytor.com,
          ravi.v.shankar@intel.com, ak@linux.intel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20181126195524.32179-1-chang.seok.bae@intel.com>
References: <20181126195524.32179-1-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/fsgsbase/64: Fix the base write helper
 functions
Git-Commit-ID: 87ab4689ca6526079ab6f5150219ee88b42000ae
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  87ab4689ca6526079ab6f5150219ee88b42000ae
Gitweb:     https://git.kernel.org/tip/87ab4689ca6526079ab6f5150219ee88b42000ae
Author:     Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate: Mon, 26 Nov 2018 11:55:24 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 18 Dec 2018 14:26:09 +0100

x86/fsgsbase/64: Fix the base write helper functions

Andy spotted a regression in the fs/gs base helpers after the patch series
was committed. The helper functions which write fs/gs base are not just
writing the base, they are also changing the index. That's wrong and needs
to be separated because writing the base has not to modify the index.

While the regression is not causing any harm right now because the only
caller depends on that behaviour, it's a guarantee for subtle breakage down
the road.

Make the index explicitly changed from the caller, instead of including
the code in the helpers.

Subsequently, the task write helpers do not handle for the current task
anymore. The range check for a base value is also factored out, to minimize
code redundancy from the caller.

Fixes: b1378a561fd1 ("x86/fsgsbase/64: Introduce FS/GS base helper functions")
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20181126195524.32179-1-chang.seok.bae@intel.com
---
 arch/x86/include/asm/fsgsbase.h | 15 +++++--
 arch/x86/kernel/process_64.c    | 99 +++++++++++++++++++++++------------------
 arch/x86/kernel/ptrace.c        |  9 ++--
 3 files changed, 71 insertions(+), 52 deletions(-)

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
index bbfbf017065c..ddd4fa718c43 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -339,24 +339,6 @@ static unsigned long x86_fsgsbase_read_task(struct task_struct *task,
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
@@ -385,38 +367,18 @@ unsigned long x86_gsbase_read_task(struct task_struct *task)
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
@@ -754,11 +716,60 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 
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
+
+			/*
+			 * On non-FSGSBASE systems, save_base_legacy() expects
+			 * that we also fill in thread.gsbase.
+			 */
+			task->thread.gsbase = arg2;
+
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
+
+			/*
+			 * On non-FSGSBASE systems, save_base_legacy() expects
+			 * that we also fill in thread.fsbase.
+			 */
+			task->thread.fsbase = arg2;
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
