Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEF4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DCE20652
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DCE20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeIDTH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:07:57 -0400
Received: from twin.jikos.cz ([91.219.245.39]:36320 "EHLO twin.jikos.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727621AbeIDTH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:07:56 -0400
Received: from twin.jikos.cz (jikos@[127.0.0.1])
        by twin.jikos.cz (8.13.6/8.13.6) with ESMTP id w84Eg3fO003850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 4 Sep 2018 16:42:04 +0200
Received: from localhost (jikos@localhost)
        by twin.jikos.cz (8.13.6/8.13.6/Submit) with ESMTP id w84Eg2NE003573;
        Tue, 4 Sep 2018 16:42:02 +0200
X-Authentication-Warning: twin.jikos.cz: jikos owned process doing -bs
Date:   Tue, 4 Sep 2018 16:42:02 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v3 2/3] x86/speculation: apply IBPB more strictly to avoid
 cross-process data leak
In-Reply-To: <nycvar.YFH.7.76.1809041619510.15880@cbobk.fhfr.pm>
Message-ID: <alpine.LRH.2.00.1809041641170.14475@gjva.wvxbf.pm>
References: <nycvar.YFH.7.76.1808312242130.25787@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809041619510.15880@cbobk.fhfr.pm>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

Sorry for the resend, my pine is buggered and broke threading.

 arch/x86/mm/tlb.c      | 15 ++++++---------
 include/linux/ptrace.h |  3 +++
 kernel/ptrace.c        |  4 +++-
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index e96b99eb800c..ce33e58b9327 100644
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
+		    ___ptrace_may_access(current, tsk, PTRACE_MODE_IBPB))
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
