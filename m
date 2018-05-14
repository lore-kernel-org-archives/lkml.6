Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752693AbeENJsF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:48:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38348 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752611AbeENJsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:48:01 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        dave.martin@arm.com, james.morse@arm.com, linux@dominikbrodowski.net,
        linux-fsdevel@vger.kernel.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, viro@zeniv.linux.org.uk, will.deacon@arm.com
Subject: [PATCH 15/18] arm64: use {COMPAT,}SYSCALL_DEFINE0 for sigreturn
Date: Mon, 14 May 2018 10:46:37 +0100
Message-Id: <20180514094640.27569-16-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180514094640.27569-1-mark.rutland@arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't currently annotate our various sigreturn functions as syscalls,
as we need to do to use pt_regs syscall wrappers.

Let's mark them as real syscalls.

For compat_sys_sigreturn and compat_sys_rt_sigreturn, this changes the
return type from int to long, matching the prototypes in sys32.c.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/signal.c   | 2 +-
 arch/arm64/kernel/signal32.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index caa7a68cf2d2..04a26dcbea32 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -538,7 +538,7 @@ static int restore_sigframe(struct pt_regs *regs,
 	return err;
 }
 
-asmlinkage long sys_rt_sigreturn(void)
+SYSCALL_DEFINE0(rt_sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct rt_sigframe __user *frame;
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index cb10588a7cb2..1948566dcccf 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -282,7 +282,7 @@ static int compat_restore_sigframe(struct pt_regs *regs,
 	return err;
 }
 
-asmlinkage int compat_sys_sigreturn(void)
+COMPAT_SYSCALL_DEFINE0(sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct compat_sigframe __user *frame;
@@ -313,7 +313,7 @@ asmlinkage int compat_sys_sigreturn(void)
 	return 0;
 }
 
-asmlinkage int compat_sys_rt_sigreturn(void)
+COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct compat_rt_sigframe __user *frame;
-- 
2.11.0
