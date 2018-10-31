Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C4DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD4E2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD4E2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbeKADtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:49:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:29420 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730097AbeKADtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:49:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2018 11:50:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,447,1534834800"; 
   d="scan'208";a="85716937"
Received: from chang-linux-2.sc.intel.com ([10.3.52.60])
  by orsmga007.jf.intel.com with ESMTP; 31 Oct 2018 11:50:31 -0700
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
Date:   Wed, 31 Oct 2018 11:49:37 -0700
Message-Id: <20181031184937.9571-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the code to change index from the relavant helpers. Now,
the code is located in do_arch_prctl_64().

The helper functions that purport to write the base should just write it
only. It shouldn't have magic optimizations to change the index.

putreg() in ptrace does not write the current task, but a stopped task.

v2: Fix further on the task write functions. Revert the changes on the
task read helpers.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/kernel/process_64.c | 48 ++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 18 deletions(-)

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
-- 
2.19.1

