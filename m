Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D470EC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1712089D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1712089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbeKQMm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:42:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:45905 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729750AbeKQMm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:42:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 18:27:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,242,1539673200"; 
   d="scan'208";a="281852644"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2018 18:27:53 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [Patch v5 16/16] x86: Group thread info flags by functionality
Date:   Fri, 16 Nov 2018 17:53:59 -0800
Message-Id: <a3487832e8452a8cf157d47ad976c065bc0f4c32.1542418937.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1542418936.git.tim.c.chen@linux.intel.com>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1542418936.git.tim.c.chen@linux.intel.com>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thread info flags are currently randomly distributed in the header
file arch/x86/include/asm/thread_info.h.

Group TIF flags together according to the following categories:
operation mode, syscall mode, pending work, task status and security
status.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/include/asm/thread_info.h | 97 ++++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 41 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index a8c5e52..453616f 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -74,60 +74,75 @@ struct thread_info {
  * - these are process state flags that various assembly files
  *   may need to access
  */
-#define TIF_SYSCALL_TRACE	0	/* syscall trace active */
-#define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
-#define TIF_SIGPENDING		2	/* signal pending */
-#define TIF_NEED_RESCHED	3	/* rescheduling necessary */
-#define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
-#define TIF_SSBD		5	/* Speculative store bypass disable */
-#define TIF_SYSCALL_EMU		6	/* syscall emulation active */
-#define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
-#define TIF_SECCOMP		8	/* secure computing */
-#define TIF_STIBP		9	/* Single thread indirect branch speculation */
-#define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
-#define TIF_UPROBE		12	/* breakpointed or singlestepping */
-#define TIF_PATCH_PENDING	13	/* pending live patching update */
-#define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
-#define TIF_NOTSC		16	/* TSC is not accessible in userland */
-#define TIF_IA32		17	/* IA32 compatibility process */
-#define TIF_NOHZ		19	/* in adaptive nohz mode */
-#define TIF_MEMDIE		20	/* is terminating due to OOM killer */
-#define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
-#define TIF_IO_BITMAP		22	/* uses I/O bitmap */
-#define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
-#define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
-#define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
-#define TIF_SYSCALL_TRACEPOINT	28	/* syscall tracepoint instrumentation */
-#define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
-#define TIF_X32			30	/* 32-bit native x86-64 binary */
-#define TIF_FSCHECK		31	/* Check FS is USER_DS on return */
+
+/* Operation mode */
+#define TIF_NOCPUID		0	/* CPUID is not accessible in userland */
+#define TIF_NOTSC		1	/* TSC is not accessible in userland */
+#define TIF_IA32		2	/* IA32 compatibility process */
+#define TIF_NOHZ		3	/* In adaptive nohz mode */
+#define TIF_ADDR32		4	/* 32-bit address space on 64 bits */
+#define TIF_X32			5	/* 32-bit native x86-64 binary */
+
+/* Syscall mode */
+#define TIF_SYSCALL_TRACE	6	/* Syscall trace active */
+#define TIF_SYSCALL_EMU		7	/* Syscall emulation active */
+#define TIF_SYSCALL_AUDIT	8	/* Syscall auditing active */
+#define TIF_SYSCALL_TRACEPOINT	9	/* Syscall tracepoint instrumentation */
+
+/* Pending work */
+#define TIF_NOTIFY_RESUME	10	/* Callback before returning to user */
+#define TIF_SIGPENDING		11	/* Signal pending */
+#define TIF_NEED_RESCHED	12	/* Rescheduling necessary */
+#define TIF_SINGLESTEP		13	/* Reenable singlestep on user return*/
+#define TIF_USER_RETURN_NOTIFY	14	/* Notify kernel of userspace return */
+#define TIF_PATCH_PENDING	15	/* Pending live patching update */
+#define TIF_FSCHECK		16	/* Check FS is USER_DS on return */
+
+/* Task status */
+#define TIF_UPROBE		17	/* Breakpointed or singlestepping */
+#define TIF_MEMDIE		18	/* Is terminating due to OOM killer */
+#define TIF_POLLING_NRFLAG	19	/* Idle is polling for TIF_NEED_RESCHED */
+#define TIF_IO_BITMAP		20	/* Uses I/O bitmap */
+#define TIF_FORCED_TF		21	/* True if TF in eflags artificially */
+#define TIF_BLOCKSTEP		22	/* Set when we want DEBUGCTLMSR_BTF */
+#define TIF_LAZY_MMU_UPDATES	23	/* Task is updating the mmu lazily */
+
+/* Security mode */
+#define TIF_SECCOMP		24	/* Secure computing */
+#define TIF_SSBD		25	/* Speculative store bypass disable */
+#define TIF_STIBP		26	/* Single thread indirect branch speculation */
+
+#define _TIF_NOCPUID		(1 << TIF_NOCPUID)
+#define _TIF_NOTSC		(1 << TIF_NOTSC)
+#define _TIF_IA32		(1 << TIF_IA32)
+#define _TIF_NOHZ		(1 << TIF_NOHZ)
+#define _TIF_ADDR32		(1 << TIF_ADDR32)
+#define _TIF_X32		(1 << TIF_X32)
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
+#define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
+#define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
+#define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
+
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
-#define _TIF_SSBD		(1 << TIF_SSBD)
-#define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
-#define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
-#define _TIF_SECCOMP		(1 << TIF_SECCOMP)
-#define _TIF_STIBP		(1 << TIF_STIBP)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
-#define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
-#define _TIF_NOCPUID		(1 << TIF_NOCPUID)
-#define _TIF_NOTSC		(1 << TIF_NOTSC)
-#define _TIF_IA32		(1 << TIF_IA32)
-#define _TIF_NOHZ		(1 << TIF_NOHZ)
+#define _TIF_FSCHECK		(1 << TIF_FSCHECK)
+
+#define _TIF_UPROBE		(1 << TIF_UPROBE)
+#define _TIF_MEMDIE		(1 << TIF_MEMDIE)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
 #define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
-#define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
-#define _TIF_ADDR32		(1 << TIF_ADDR32)
-#define _TIF_X32		(1 << TIF_X32)
-#define _TIF_FSCHECK		(1 << TIF_FSCHECK)
+
+#define _TIF_SECCOMP		(1 << TIF_SECCOMP)
+#define _TIF_SSBD		(1 << TIF_SSBD)
+#define _TIF_STIBP		(1 << TIF_STIBP)
 
 /*
  * work to do in syscall_trace_enter().  Also includes TIF_NOHZ for
-- 
2.9.4

