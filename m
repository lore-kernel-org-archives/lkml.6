Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D77AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507B8208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507B8208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934120AbeGBLIi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:08:38 -0400
Received: from foss.arm.com ([217.140.101.70]:57504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933305AbeGBLEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:04:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FDE116A3;
        Mon,  2 Jul 2018 04:04:38 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8FB6B3F5BA;
        Mon,  2 Jul 2018 04:04:36 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        dave.martin@arm.com, hch@infradead.org, james.morse@arm.com,
        linux@dominikbrodowski.net, linux-fsdevel@vger.kernel.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, viro@zeniv.linux.org.uk
Subject: [PATCHv4 06/19] arm64: remove sigreturn wrappers
Date:   Mon,  2 Jul 2018 12:04:02 +0100
Message-Id: <20180702110415.10465-7-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180702110415.10465-1-mark.rutland@arm.com>
References: <20180702110415.10465-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 sigreturn* syscall handlers are non-standard. Rather than
taking a number of user parameters in registers as per the AAPCS,
they expect the pt_regs as their sole argument.

To make this work, we override the syscall definitions to invoke
wrappers written in assembly, which mov the SP into x0, and branch to
their respective C functions.

On other architectures (such as x86), the sigreturn* functions take no
argument and instead use current_pt_regs() to acquire the user
registers. This requires less boilerplate code, and allows for other
features such as interposing C code in this path.

This patch takes the same approach for arm64.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Tentatively-reviewed-by: Dave Martin <dave.martin@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/unistd32.h |  4 ++--
 arch/arm64/kernel/entry.S         |  8 --------
 arch/arm64/kernel/entry32.S       | 10 ----------
 arch/arm64/kernel/signal.c        |  3 ++-
 arch/arm64/kernel/signal32.c      |  6 ++++--
 arch/arm64/kernel/sys.c           |  3 +--
 arch/arm64/kernel/sys32.c         |  4 ++--
 7 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index ef292160748c..ab95554b1734 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -260,7 +260,7 @@ __SYSCALL(117, sys_ni_syscall)
 #define __NR_fsync 118
 __SYSCALL(__NR_fsync, sys_fsync)
 #define __NR_sigreturn 119
-__SYSCALL(__NR_sigreturn, compat_sys_sigreturn_wrapper)
+__SYSCALL(__NR_sigreturn, compat_sys_sigreturn)
 #define __NR_clone 120
 __SYSCALL(__NR_clone, sys_clone)
 #define __NR_setdomainname 121
@@ -368,7 +368,7 @@ __SYSCALL(__NR_getresgid, sys_getresgid16)
 #define __NR_prctl 172
 __SYSCALL(__NR_prctl, sys_prctl)
 #define __NR_rt_sigreturn 173
-__SYSCALL(__NR_rt_sigreturn, compat_sys_rt_sigreturn_wrapper)
+__SYSCALL(__NR_rt_sigreturn, compat_sys_rt_sigreturn)
 #define __NR_rt_sigaction 174
 __SYSCALL(__NR_rt_sigaction, compat_sys_rt_sigaction)
 #define __NR_rt_sigprocmask 175
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 28ad8799406f..62f2876f9c63 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1138,14 +1138,6 @@ __entry_tramp_data_start:
 #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
 
 /*
- * Special system call wrappers.
- */
-ENTRY(sys_rt_sigreturn_wrapper)
-	mov	x0, sp
-	b	sys_rt_sigreturn
-ENDPROC(sys_rt_sigreturn_wrapper)
-
-/*
  * Register switch for AArch64. The callee-saved registers need to be saved
  * and restored. On entry:
  *   x0 = previous task_struct (must be preserved across the switch)
diff --git a/arch/arm64/kernel/entry32.S b/arch/arm64/kernel/entry32.S
index f332d5d1f6b4..f9461696dde4 100644
--- a/arch/arm64/kernel/entry32.S
+++ b/arch/arm64/kernel/entry32.S
@@ -30,16 +30,6 @@
  * System call wrappers for the AArch32 compatibility layer.
  */
 
-ENTRY(compat_sys_sigreturn_wrapper)
-	mov	x0, sp
-	b	compat_sys_sigreturn
-ENDPROC(compat_sys_sigreturn_wrapper)
-
-ENTRY(compat_sys_rt_sigreturn_wrapper)
-	mov	x0, sp
-	b	compat_sys_rt_sigreturn
-ENDPROC(compat_sys_rt_sigreturn_wrapper)
-
 ENTRY(compat_sys_statfs64_wrapper)
 	mov	w3, #84
 	cmp	w1, #88
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 70287634706e..f03e664f773f 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -539,8 +539,9 @@ static int restore_sigframe(struct pt_regs *regs,
 	return err;
 }
 
-asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
+asmlinkage long sys_rt_sigreturn(void)
 {
+	struct pt_regs *regs = current_pt_regs();
 	struct rt_sigframe __user *frame;
 
 	/* Always make any pending restarted system calls return -EINTR */
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 77b91f478995..cb10588a7cb2 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -282,8 +282,9 @@ static int compat_restore_sigframe(struct pt_regs *regs,
 	return err;
 }
 
-asmlinkage int compat_sys_sigreturn(struct pt_regs *regs)
+asmlinkage int compat_sys_sigreturn(void)
 {
+	struct pt_regs *regs = current_pt_regs();
 	struct compat_sigframe __user *frame;
 
 	/* Always make any pending restarted system calls return -EINTR */
@@ -312,8 +313,9 @@ asmlinkage int compat_sys_sigreturn(struct pt_regs *regs)
 	return 0;
 }
 
-asmlinkage int compat_sys_rt_sigreturn(struct pt_regs *regs)
+asmlinkage int compat_sys_rt_sigreturn(void)
 {
+	struct pt_regs *regs = current_pt_regs();
 	struct compat_rt_sigframe __user *frame;
 
 	/* Always make any pending restarted system calls return -EINTR */
diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index 72981bae10eb..31045f3fed92 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -48,8 +48,7 @@ SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
 /*
  * Wrappers to pass the pt_regs argument.
  */
-asmlinkage long sys_rt_sigreturn_wrapper(void);
-#define sys_rt_sigreturn	sys_rt_sigreturn_wrapper
+asmlinkage long sys_rt_sigreturn(void);
 #define sys_personality		sys_arm64_personality
 
 #undef __SYSCALL
diff --git a/arch/arm64/kernel/sys32.c b/arch/arm64/kernel/sys32.c
index a40b1343b819..1ef103c95410 100644
--- a/arch/arm64/kernel/sys32.c
+++ b/arch/arm64/kernel/sys32.c
@@ -25,8 +25,8 @@
 #include <linux/compiler.h>
 #include <linux/syscalls.h>
 
-asmlinkage long compat_sys_sigreturn_wrapper(void);
-asmlinkage long compat_sys_rt_sigreturn_wrapper(void);
+asmlinkage long compat_sys_sigreturn(void);
+asmlinkage long compat_sys_rt_sigreturn(void);
 asmlinkage long compat_sys_statfs64_wrapper(void);
 asmlinkage long compat_sys_fstatfs64_wrapper(void);
 asmlinkage long compat_sys_pread64_wrapper(void);
-- 
2.11.0

