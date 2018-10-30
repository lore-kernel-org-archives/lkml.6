Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10C0C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF4C20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 17:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF4C20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbeJaCWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 22:22:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:47936 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbeJaCWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 22:22:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 10:28:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,445,1534834800"; 
   d="scan'208";a="101972827"
Received: from chang-linux-2.sc.intel.com ([10.3.52.60])
  by fmsmga004.fm.intel.com with ESMTP; 30 Oct 2018 10:28:11 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/fsgsbase/64: Fix the base write helper functions
Date:   Tue, 30 Oct 2018 10:27:19 -0700
Message-Id: <20181030172719.6753-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the code to change index from x86_fsbase_write_cpu() and
x86_gsbase_write_cpu_inactive(). Now the code is located in
do_arch_prctl_64().

The helper functions that purport to write the base register should just
write the base register only. It shouldn't have magic optimizations to
change the index.

putreg() in ptrace does not write the current task, but a stopped task.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/kernel/process_64.c | 67 +++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 31b4755369f0..4fd865fb7097 100644
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
 
@@ -359,9 +351,7 @@ unsigned long x86_fsbase_read_task(struct task_struct *task)
 {
 	unsigned long fsbase;
 
-	if (task == current)
-		fsbase = x86_fsbase_read_cpu();
-	else if (task->thread.fsindex == 0)
+	if (task->thread.fsindex == 0)
 		fsbase = task->thread.fsbase;
 	else
 		fsbase = x86_fsgsbase_read_task(task, task->thread.fsindex);
@@ -373,9 +363,7 @@ unsigned long x86_gsbase_read_task(struct task_struct *task)
 {
 	unsigned long gsbase;
 
-	if (task == current)
-		gsbase = x86_gsbase_read_cpu_inactive();
-	else if (task->thread.gsindex == 0)
+	if (task->thread.gsindex == 0)
 		gsbase = task->thread.gsbase;
 	else
 		gsbase = x86_fsgsbase_read_task(task, task->thread.gsindex);
@@ -392,12 +380,8 @@ int x86_fsbase_write_task(struct task_struct *task, unsigned long fsbase)
 	if (unlikely(fsbase >= TASK_SIZE_MAX))
 		return -EPERM;
 
-	preempt_disable();
 	task->thread.fsbase = fsbase;
-	if (task == current)
-		x86_fsbase_write_cpu(fsbase);
 	task->thread.fsindex = 0;
-	preempt_enable();
 
 	return 0;
 }
@@ -407,12 +391,8 @@ int x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase)
 	if (unlikely(gsbase >= TASK_SIZE_MAX))
 		return -EPERM;
 
-	preempt_disable();
 	task->thread.gsbase = gsbase;
-	if (task == current)
-		x86_gsbase_write_cpu_inactive(gsbase);
 	task->thread.gsindex = 0;
-	preempt_enable();
 
 	return 0;
 }
@@ -757,22 +737,53 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	int ret = 0;
 
 	switch (option) {
-	case ARCH_SET_GS: {
-		ret = x86_gsbase_write_task(task, arg2);
-		break;
-	}
 	case ARCH_SET_FS: {
+		preempt_disable();
 		ret = x86_fsbase_write_task(task, arg2);
+		if (task == current && ret == 0) {
+			/*
+			 * Set the selector to 0, implying that the base is
+			 * overwritten. The index value will be checked
+			 * during context switch for skipping segment reload.
+			 */
+			loadseg(FS, 0);
+			x86_fsbase_write_cpu(arg2);
+		}
+		preempt_enable();
+		break;
+	}
+	case ARCH_SET_GS: {
+		preempt_disable();
+		ret = x86_gsbase_write_task(task, arg2);
+		if (task == current && ret == 0) {
+			/*
+			 * Set the selector to 0 for the same reason
+			 * as %fs above.
+			 */
+			loadseg(GS, 0);
+			x86_gsbase_write_cpu_inactive(arg2);
+		}
+		preempt_enable();
 		break;
 	}
 	case ARCH_GET_FS: {
-		unsigned long base = x86_fsbase_read_task(task);
+		unsigned long base;
+
+		if (task == current)
+			base = x86_fsbase_read_cpu();
+		else
+			base = x86_fsbase_read_task(task);
 
 		ret = put_user(base, (unsigned long __user *)arg2);
 		break;
 	}
 	case ARCH_GET_GS: {
-		unsigned long base = x86_gsbase_read_task(task);
+		unsigned long base;
+
+		if (task == current)
+			base = x86_gsbase_read_cpu_inactive();
+		else
+			base = x86_gsbase_read_task(task);
 
 		ret = put_user(base, (unsigned long __user *)arg2);
 		break;
-- 
2.19.1

