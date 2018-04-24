Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758333AbeDXOSE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:18:04 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:9048 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758299AbeDXOSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:18:01 -0400
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/signal32: Use fault_in_pages_readable() to prefault
 user context
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mathieu Malaterre <malat@debian.org>
Message-Id: <20180424141759.F02AF6C59D@po15720vm.idsi0.si.c-s.fr>
Date: Tue, 24 Apr 2018 16:17:59 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use fault_in_pages_readable() to prefault user context
instead of open coding

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/signal_32.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 492f03451877..cfacb2726152 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -25,6 +25,7 @@
 #include <linux/errno.h>
 #include <linux/elf.h>
 #include <linux/ptrace.h>
+#include <linux/pagemap.h>
 #include <linux/ratelimit.h>
 #ifdef CONFIG_PPC64
 #include <linux/syscalls.h>
@@ -1045,7 +1046,6 @@ long sys_swapcontext(struct ucontext __user *old_ctx,
 		     struct ucontext __user *new_ctx,
 		     int ctx_size, int r6, int r7, int r8, struct pt_regs *regs)
 {
-	unsigned char tmp __maybe_unused;
 	int ctx_has_vsx_region = 0;
 
 #ifdef CONFIG_PPC64
@@ -1109,9 +1109,8 @@ long sys_swapcontext(struct ucontext __user *old_ctx,
 	}
 	if (new_ctx == NULL)
 		return 0;
-	if (!access_ok(VERIFY_READ, new_ctx, ctx_size)
-	    || __get_user(tmp, (u8 __user *) new_ctx)
-	    || __get_user(tmp, (u8 __user *) new_ctx + ctx_size - 1))
+	if (!access_ok(VERIFY_READ, new_ctx, ctx_size) ||
+	    fault_in_pages_readable((u8 __user *)new_ctx, ctx_size))
 		return -EFAULT;
 
 	/*
@@ -1231,7 +1230,6 @@ int sys_debug_setcontext(struct ucontext __user *ctx,
 {
 	struct sig_dbg_op op;
 	int i;
-	unsigned char tmp __maybe_unused;
 	unsigned long new_msr = regs->msr;
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 	unsigned long new_dbcr0 = current->thread.debug.dbcr0;
@@ -1287,9 +1285,8 @@ int sys_debug_setcontext(struct ucontext __user *ctx,
 	current->thread.debug.dbcr0 = new_dbcr0;
 #endif
 
-	if (!access_ok(VERIFY_READ, ctx, sizeof(*ctx))
-	    || __get_user(tmp, (u8 __user *) ctx)
-	    || __get_user(tmp, (u8 __user *) (ctx + 1) - 1))
+	if (!access_ok(VERIFY_READ, ctx, sizeof(*ctx)) ||
+	    fault_in_pages_readable((u8 __user *)ctx, 1))
 		return -EFAULT;
 
 	/*
-- 
2.13.3
