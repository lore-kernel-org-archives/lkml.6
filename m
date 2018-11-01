Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55763C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C31205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C31205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbeKBFg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 01:36:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:65166 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbeKBFg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 01:36:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2018 13:32:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,453,1534834800"; 
   d="scan'208";a="105214730"
Received: from chang-linux-2.sc.intel.com ([10.3.52.60])
  by orsmga002.jf.intel.com with ESMTP; 01 Nov 2018 13:32:25 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] x86/fsgsbase/64: Fix the base write helper functions
Date:   Thu,  1 Nov 2018 13:31:29 -0700
Message-Id: <20181101203129.27494-1-chang.seok.bae@intel.com>
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

v2: Fix further on the task write functions. Revert the changes on the
task read helpers.

v3: Fix putreg(). Edit the changelog.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/kernel/process_64.c | 48 ++++++++++++++++++++++--------------
 arch/x86/kernel/ptrace.c     |  8 +++---
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 31b4755369f0..ad849ce9cb73 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -339,19 +339,11 @@ static unsigned long x86_fsgsbase_read_task(struct task_struct *task,
 
 void x86_fsbase_write_cpu(unsigned long fsbase)
 {
-	/*
-	 * Set the selector to 0 as a notion, that the segment base is
-	 * overwritten, which will be checked for skipping the segment load
-	 * during context switch.
-	 */
-	loadseg(FS, 0);
 	wrmsrl(MSR_FS_BASE, fsbase);
 }
 
 void x86_gsbase_write_cpu_inactive(unsigned long gsbase)
 {
-	/* Set the selector to 0 for the same reason as %fs above. */
-	loadseg(GS, 0);
 	wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
 }
 
@@ -392,12 +384,7 @@ int x86_fsbase_write_task(struct task_struct *task, unsigned long fsbase)
 	if (unlikely(fsbase >= TASK_SIZE_MAX))
 		return -EPERM;
 
-	preempt_disable();
 	task->thread.fsbase = fsbase;
-	if (task == current)
-		x86_fsbase_write_cpu(fsbase);
-	task->thread.fsindex = 0;
-	preempt_enable();
 
 	return 0;
 }
@@ -407,12 +394,7 @@ int x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase)
 	if (unlikely(gsbase >= TASK_SIZE_MAX))
 		return -EPERM;
 
-	preempt_disable();
 	task->thread.gsbase = gsbase;
-	if (task == current)
-		x86_gsbase_write_cpu_inactive(gsbase);
-	task->thread.gsindex = 0;
-	preempt_enable();
 
 	return 0;
 }
@@ -758,11 +740,41 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 
 	switch (option) {
 	case ARCH_SET_GS: {
+		preempt_disable();
 		ret = x86_gsbase_write_task(task, arg2);
+		if (ret == 0) {
+			/*
+			 * ARCH_SET_GS has always overwritten the index
+			 * and the base. Zero is the most sensible value
+			 * to put in the index, and is the only value that
+			 * makes any sense if FSGSBASE is unavailable.
+			 */
+			if (task == current) {
+				loadseg(GS, 0);
+				x86_gsbase_write_cpu_inactive(arg2);
+			} else {
+				task->thread.gsindex = 0;
+			}
+		}
+		preempt_enable();
 		break;
 	}
 	case ARCH_SET_FS: {
+		preempt_disable();
 		ret = x86_fsbase_write_task(task, arg2);
+		if (ret == 0) {
+			/*
+			 * Set the selector to 0 for the same reason
+			 * as %gs above.
+			 */
+			if (task == current) {
+				loadseg(FS, 0);
+				x86_fsbase_write_cpu(arg2);
+			} else {
+				task->thread.fsindex = 0;
+			}
+		}
+		preempt_enable();
 		break;
 	}
 	case ARCH_GET_FS: {
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index ffae9b9740fd..e4ab1abca5b5 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -397,11 +397,11 @@ static int putreg(struct task_struct *child,
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
 		/*
-		 * When changing the FS base, use the same
-		 * mechanism as for do_arch_prctl_64().
+		 * When changing the FS base, use do_arch_prctl_64()
+		 * to set the index and the base.
 		 */
 		if (child->thread.fsbase != value)
-			return x86_fsbase_write_task(child, value);
+			return do_arch_prctl_64(child, ARCH_SET_FS, value);
 		return 0;
 	case offsetof(struct user_regs_struct,gs_base):
 		/*
@@ -410,7 +410,7 @@ static int putreg(struct task_struct *child,
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

