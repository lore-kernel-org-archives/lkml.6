Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6BAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A264820868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A264820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeICRF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:05:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:60978 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727330AbeICRF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:05:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6ED89B008;
        Mon,  3 Sep 2018 12:45:26 +0000 (UTC)
Date:   Mon, 3 Sep 2018 14:45:25 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH v2 2/3] x86/speculation: Apply IBPB more strictly to avoid
 cross-process spectre v2 leak
Message-ID: <nycvar.YFH.7.76.1809031443540.25787@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

Currently, we are issuing IBPB only in cases when switching into a non-dumpable
process, the rationale being to protect such 'important and security sensitive'
processess (such as GPG) from data leak into a different userspace process via
spectre v2.

This is however completely insufficient to provide proper userspace-to-userpace
spectrev2 protection, as any process can poison branch buffers before being
scheduled out, and the newly scheduled process immediately becomes spectrev2
victim.

In order to minimize the performance impact (for usecases that do require
spectrev2 protection), issue the barrier only in cases when switching between
processess where the victim can't be ptraced by the potential attacker (as in
such cases, the attacker doesn't have to bother with branch buffers at all).

Fixes: 18bf3c3ea8 ("x86/speculation: Use Indirect Branch Prediction Barrier in context switch")
Originally-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 arch/x86/mm/tlb.c      | 15 ++++++---------
 include/linux/ptrace.h |  3 +++
 kernel/ptrace.c        |  4 +++-
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index e96b99eb800c..4a9503ca173a 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -7,6 +7,7 @@
 #include <linux/export.h>
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
+#include <linux/ptrace.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -262,18 +263,14 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		 * one process from doing Spectre-v2 attacks on another.
 		 *
 		 * As an optimization, flush indirect branches only when
-		 * switching into processes that disable dumping. This
-		 * protects high value processes like gpg, without having
-		 * too high performance overhead. IBPB is *expensive*!
-		 *
-		 * This will not flush branches when switching into kernel
-		 * threads. It will also not flush if we switch to idle
-		 * thread and back to the same process. It will flush if we
-		 * switch to a different non-dumpable process.
+		 * switching into a processes that can't be ptrace by the
+		 * current one (as in such case, attacker has much more
+		 * convenient way how to tamper with the next process than
+		 * branch buffer poisoning).
 		 */
 		if (tsk && tsk->mm &&
 		    tsk->mm->context.ctx_id != last_ctx_id &&
-		    get_dumpable(tsk->mm) != SUID_DUMP_USER)
+		    ___ptrace_may_access(tsk, current, PTRACE_MODE_IBPB))
 			indirect_branch_prediction_barrier();
 
 		if (IS_ENABLED(CONFIG_VMAP_STACK)) {
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 09744d4113fb..adab379b5456 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -64,12 +64,15 @@ extern void exit_ptrace(struct task_struct *tracer, struct list_head *dead);
 #define PTRACE_MODE_NOAUDIT	0x04
 #define PTRACE_MODE_FSCREDS 0x08
 #define PTRACE_MODE_REALCREDS 0x10
+#define PTRACE_MODE_NOACCESS_CHK 0x20
 
 /* shorthands for READ/ATTACH and FSCREDS/REALCREDS combinations */
 #define PTRACE_MODE_READ_FSCREDS (PTRACE_MODE_READ | PTRACE_MODE_FSCREDS)
 #define PTRACE_MODE_READ_REALCREDS (PTRACE_MODE_READ | PTRACE_MODE_REALCREDS)
 #define PTRACE_MODE_ATTACH_FSCREDS (PTRACE_MODE_ATTACH | PTRACE_MODE_FSCREDS)
 #define PTRACE_MODE_ATTACH_REALCREDS (PTRACE_MODE_ATTACH | PTRACE_MODE_REALCREDS)
+#define PTRACE_MODE_IBPB (PTRACE_MODE_ATTACH | PTRACE_MODE_NOAUDIT \
+			  | PTRACE_MODE_NOACCESS_CHK | PTRACE_MODE_REALCREDS)
 
 /**
  * ptrace_may_access - check whether the caller is permitted to access
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 07ff6685ebed..b41c37f44c32 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -330,7 +330,9 @@ int ___ptrace_may_access(struct task_struct *curr, struct task_struct *task,
 	     !ptrace_has_cap(mm->user_ns, mode)))
 	    return -EPERM;
 
-	return security_ptrace_access_check(task, mode);
+	if (!(mode & PTRACE_MODE_NOACCESS_CHK))
+		return security_ptrace_access_check(task, mode);
+	return 0;
 }
 
 static int __ptrace_may_access(struct task_struct *task, unsigned int mode)

-- 
Jiri Kosina
SUSE Labs

