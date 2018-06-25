Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5788EC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186F225FE3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186F225FE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964888AbeFYRyM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:54:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35026 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755521AbeFYRyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:54:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CD4AED1;
        Mon, 25 Jun 2018 10:54:09 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F28173F7CE;
        Mon, 25 Jun 2018 10:54:08 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 510941AE111F; Mon, 25 Jun 2018 18:54:46 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        mathieu.desnoyers@efficios.com, peterz@infradead.org,
        paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com,
        catalin.marinas@arm.com, peter.maydell@linaro.org,
        mark.rutland@arm.com, Will Deacon <will.deacon@arm.com>
Subject: [PATCH 1/3] arm64: rseq: Implement backend rseq calls and select HAVE_RSEQ
Date:   Mon, 25 Jun 2018 18:54:43 +0100
Message-Id: <1529949285-11013-2-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1529949285-11013-1-git-send-email-will.deacon@arm.com>
References: <1529949285-11013-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement calls to rseq_signal_deliver, rseq_handle_notify_resume
and rseq_syscall so that we can select HAVE_RSEQ on arm64.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig                | 1 +
 arch/arm64/include/asm/unistd.h   | 2 +-
 arch/arm64/include/asm/unistd32.h | 2 ++
 arch/arm64/kernel/entry.S         | 2 ++
 arch/arm64/kernel/ptrace.c        | 2 ++
 arch/arm64/kernel/signal.c        | 3 +++
 6 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090cf0292..26cb550673b2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -127,6 +127,7 @@ config ARM64
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RCU_TABLE_FREE
+	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index a0baa9af5487..e0d0f5b856e7 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -43,7 +43,7 @@
 #define __ARM_NR_compat_cacheflush	(__ARM_NR_COMPAT_BASE+2)
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE+5)
 
-#define __NR_compat_syscalls		398
+#define __NR_compat_syscalls		399
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index ef292160748c..0fdc7ef8a776 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -817,6 +817,8 @@ __SYSCALL(__NR_pkey_alloc, sys_pkey_alloc)
 __SYSCALL(__NR_pkey_free, sys_pkey_free)
 #define __NR_statx 397
 __SYSCALL(__NR_statx, sys_statx)
+#define __NR_rseq 398
+__SYSCALL(__NR_rseq, sys_rseq)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 28ad8799406f..1eda9e1a1f4a 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -904,6 +904,7 @@ ENDPROC(el0_error)
 ret_fast_syscall:
 	disable_daif
 	str	x0, [sp, #S_X0]			// returned x0
+#ifndef CONFIG_DEBUG_RSEQ
 	ldr	x1, [tsk, #TSK_TI_FLAGS]	// re-check for syscall tracing
 	and	x2, x1, #_TIF_SYSCALL_WORK
 	cbnz	x2, ret_fast_syscall_trace
@@ -911,6 +912,7 @@ ret_fast_syscall:
 	cbnz	x2, work_pending
 	enable_step_tsk x1, x2
 	kernel_exit 0
+#endif
 ret_fast_syscall_trace:
 	enable_daif
 	b	__sys_trace_return_skipped	// we already saved x0
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 5c338ce5a7fa..9f479c111675 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1656,6 +1656,8 @@ asmlinkage void syscall_trace_exit(struct pt_regs *regs)
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		tracehook_report_syscall(regs, PTRACE_SYSCALL_EXIT);
+
+	rseq_syscall(regs);
 }
 
 /*
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 511af13e8d8f..e3b1d1b0aee8 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -802,6 +802,8 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	int usig = ksig->sig;
 	int ret;
 
+	rseq_signal_deliver(ksig, regs);
+
 	/*
 	 * Set up the stack frame
 	 */
@@ -940,6 +942,7 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 			if (thread_flags & _TIF_NOTIFY_RESUME) {
 				clear_thread_flag(TIF_NOTIFY_RESUME);
 				tracehook_notify_resume(regs);
+				rseq_handle_notify_resume(NULL, regs);
 			}
 
 			if (thread_flags & _TIF_FOREIGN_FPSTATE)
-- 
2.1.4

