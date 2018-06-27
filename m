Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E09DC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66CC2563E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D66CC2563E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966000AbeF0RFh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:05:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:19413 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754624AbeF0RDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:03:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 10:03:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,279,1526367600"; 
   d="scan'208";a="70478499"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by orsmga002.jf.intel.com with ESMTP; 27 Jun 2018 10:03:31 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/8] x86/arch_prctl/64: Make ptrace read FS/GS base accurately
Date:   Wed, 27 Jun 2018 10:03:06 -0700
Message-Id: <1530118993-13466-2-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530118993-13466-1-git-send-email-chang.seok.bae@intel.com>
References: <1530118993-13466-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/kernel/ptrace.c | 62 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index e2ee403..3acbf45 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -39,6 +39,7 @@
 #include <asm/hw_breakpoint.h>
 #include <asm/traps.h>
 #include <asm/syscall.h>
+#include <asm/mmu_context.h>
 
 #include "tls.h"
 
@@ -342,6 +343,49 @@ static int set_segment_reg(struct task_struct *task,
 	return 0;
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
 #endif	/* CONFIG_X86_32 */
 
 static unsigned long get_flags(struct task_struct *task)
@@ -435,18 +479,16 @@ static unsigned long getreg(struct task_struct *task, unsigned long offset)
 
 #ifdef CONFIG_X86_64
 	case offsetof(struct user_regs_struct, fs_base): {
-		/*
-		 * XXX: This will not behave as expected if called on
-		 * current or if fsindex != 0.
-		 */
-		return task->thread.fsbase;
+		if (task->thread.fsindex == 0)
+			return task->thread.fsbase;
+		else
+			return task_seg_base(task, task->thread.fsindex);
 	}
 	case offsetof(struct user_regs_struct, gs_base): {
-		/*
-		 * XXX: This will not behave as expected if called on
-		 * current or if fsindex != 0.
-		 */
-		return task->thread.gsbase;
+		if (task->thread.gsindex == 0)
+			return task->thread.gsbase;
+		else
+			return task_seg_base(task, task->thread.gsindex);
 	}
 #endif
 	}
-- 
2.7.4

