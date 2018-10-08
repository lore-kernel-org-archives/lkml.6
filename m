Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77DFC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B7520645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B7520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeJHRHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:07:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49125 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJHRHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:07:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w989sq0Y559825
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 Oct 2018 02:54:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w989spVq559822;
        Mon, 8 Oct 2018 02:54:51 -0700
Date:   Mon, 8 Oct 2018 02:54:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-07e1d88adaaeab247b300926f78cc3f950dbeda3@git.kernel.org>
Cc:     mingo@kernel.org, riel@surriel.com, brgerst@gmail.com,
        dave.hansen@linux.intel.com, bp@alien8.de, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, luto@kernel.org,
        torvalds@linux-foundation.org, dvlasenk@redhat.com,
        ravi.v.shankar@intel.com, peterz@infradead.org,
        markus.t.metzger@intel.com, luto@amacapital.net
Reply-To: brgerst@gmail.com, mingo@kernel.org, riel@surriel.com,
          hpa@zytor.com, dave.hansen@linux.intel.com, bp@alien8.de,
          tglx@linutronix.de, peterz@infradead.org,
          torvalds@linux-foundation.org, dvlasenk@redhat.com,
          ravi.v.shankar@intel.com, markus.t.metzger@intel.com,
          luto@kernel.org, chang.seok.bae@intel.com,
          linux-kernel@vger.kernel.org, luto@amacapital.net
In-Reply-To: <1537312139-5580-2-git-send-email-chang.seok.bae@intel.com>
References: <1537312139-5580-2-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/fsgsbase/64: Fix ptrace() to read the FS/GS base
 accurately
Git-Commit-ID: 07e1d88adaaeab247b300926f78cc3f950dbeda3
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

Commit-ID:  07e1d88adaaeab247b300926f78cc3f950dbeda3
Gitweb:     https://git.kernel.org/tip/07e1d88adaaeab247b300926f78cc3f950dbeda3
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Tue, 18 Sep 2018 16:08:52 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 8 Oct 2018 10:41:08 +0200

x86/fsgsbase/64: Fix ptrace() to read the FS/GS base accurately

On 64-bit kernels ptrace can read the FS/GS base using the register access
APIs (PTRACE_PEEKUSER, etc.) or PTRACE_ARCH_PRCTL.

Make both of these mechanisms return the actual FS/GS base.

This will improve debuggability by providing the correct information
to ptracer such as GDB.

[ chang: Rebased and revised patch description. ]
[ mingo: Revised the changelog some more. ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Markus T Metzger <markus.t.metzger@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1537312139-5580-2-git-send-email-chang.seok.bae@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/ptrace.c | 62 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index e2ee403865eb..3acbf45cb7fb 100644
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
