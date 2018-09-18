Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C94ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D44E20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D44E20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbeISEof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 00:44:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:3122 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbeISEof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 00:44:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 16:09:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,391,1531810800"; 
   d="scan'208";a="87288053"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by fmsmga002.fm.intel.com with ESMTP; 18 Sep 2018 16:09:40 -0700
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
Subject: [PATCH v6 3/8] x86/fsgsbase/64: Make ptrace use correct FS/GS base helpers
Date:   Tue, 18 Sep 2018 16:08:54 -0700
Message-Id: <1537312139-5580-4-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537312139-5580-1-git-send-email-chang.seok.bae@intel.com>
References: <1537312139-5580-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FS/GS base helper functions are used on ptrace APIs
(PTRACE_ARCH_PRCTL, PTRACE_SETREG, PTRACE_GETREG, etc).
The FS/GS-update mechanism is now a bit organized.

Based-on-code-from: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/include/asm/fsgsbase.h |  3 ---
 arch/x86/kernel/process_64.c    | 49 +++++++++--------------------------------
 arch/x86/kernel/ptrace.c        | 27 +++++++----------------
 3 files changed, 18 insertions(+), 61 deletions(-)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index 0404dab..949eefc 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -8,9 +8,6 @@
 
 #include <asm/msr-index.h>
 
-unsigned long x86_fsgsbase_read_task(struct task_struct *task,
-				     unsigned short selector);
-
 /*
  * Read/write a task's fsbase or gsbase. This returns the value that
  * the FS/GS base would have (if the task were to be resumed). These
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 52af8c1..710f639 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -285,8 +285,8 @@ static __always_inline void load_seg_legacy(unsigned short prev_index,
 	}
 }
 
-unsigned long x86_fsgsbase_read_task(struct task_struct *task,
-				     unsigned short selector)
+static unsigned long x86_fsgsbase_read_task(struct task_struct *task,
+					    unsigned short selector)
 {
 	unsigned short idx = selector >> 3;
 	unsigned long base;
@@ -749,54 +749,25 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
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
+		ret = x86_gsbase_write_task(task, arg2);
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
+		ret = x86_fsbase_write_task(task, arg2);
 		break;
+	}
 	case ARCH_GET_FS: {
-		unsigned long base;
+		unsigned long base = x86_fsbase_read_task(task);
 
-		if (doit)
-			rdmsrl(MSR_FS_BASE, base);
-		else
-			base = task->thread.fsbase;
 		ret = put_user(base, (unsigned long __user *)arg2);
 		break;
 	}
 	case ARCH_GET_GS: {
-		unsigned long base;
+		unsigned long base = x86_gsbase_read_task(task);
 
-		if (doit)
-			rdmsrl(MSR_KERNEL_GS_BASE, base);
-		else
-			base = task->thread.gsbase;
 		ret = put_user(base, (unsigned long __user *)arg2);
 		break;
 	}
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index fbde2a7..d8f49c7 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -397,12 +397,11 @@ static int putreg(struct task_struct *child,
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
 		/*
-		 * When changing the segment base, use do_arch_prctl_64
-		 * to set either thread.fs or thread.fsindex and the
-		 * corresponding GDT slot.
+		 * When changing the FS base, use the same
+		 * mechanism as for do_arch_prctl_64().
 		 */
 		if (child->thread.fsbase != value)
-			return do_arch_prctl_64(child, ARCH_SET_FS, value);
+			return x86_fsbase_write_task(child, value);
 		return 0;
 	case offsetof(struct user_regs_struct,gs_base):
 		/*
@@ -411,7 +410,7 @@ static int putreg(struct task_struct *child,
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
 		if (child->thread.gsbase != value)
-			return do_arch_prctl_64(child, ARCH_SET_GS, value);
+			return x86_gsbase_write_task(child, value);
 		return 0;
 #endif
 	}
@@ -435,20 +434,10 @@ static unsigned long getreg(struct task_struct *task, unsigned long offset)
 		return get_flags(task);
 
 #ifdef CONFIG_X86_64
-	case offsetof(struct user_regs_struct, fs_base): {
-		if (task->thread.fsindex == 0)
-			return task->thread.fsbase;
-		else
-			return x86_fsgsbase_read_task(task,
-						      task->thread.fsindex);
-	}
-	case offsetof(struct user_regs_struct, gs_base): {
-		if (task->thread.gsindex == 0)
-			return task->thread.gsbase;
-		else
-			return x86_fsgsbase_read_task(task,
-						      task->thread.gsindex);
-	}
+	case offsetof(struct user_regs_struct, fs_base):
+		return x86_fsbase_read_task(task);
+	case offsetof(struct user_regs_struct, gs_base):
+		return x86_gsbase_read_task(task);
 #endif
 	}
 
-- 
2.7.4

