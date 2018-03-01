Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034129AbeCATir (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 14:38:47 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36114 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033435AbeCATiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 14:38:46 -0500
X-Google-Smtp-Source: AG47ELtvHeFVmJTH8RE/hwQJNu3GCoku1c7bW7awqY4wG6m4hBSjQUxPKPRkwlsf0F9Gr8NkHJOIzg==
From: Douglas Anderson <dianders@chromium.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: briannorris@chromium.org, evgreen@chromium.org,
        Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64/debug: Fix registers on sleeping tasks
Date: Thu,  1 Mar 2018 11:38:03 -0800
Message-Id: <20180301193803.129195-1-dianders@chromium.org>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the equivalent of commit 001bf455d206 ("ARM: 8428/1: kgdb: Fix
registers on sleeping tasks") but for arm64.  Nuff said.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/kernel/kgdb.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 2122cd187f19..01285d4dcdc3 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -138,14 +138,26 @@ int dbg_set_reg(int regno, void *mem, struct pt_regs *regs)
 void
 sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *task)
 {
-	struct pt_regs *thread_regs;
+	struct thread_struct *thread = &task->thread;
+	struct cpu_context *cpu_context = &thread->cpu_context;
 
 	/* Initialize to zero */
 	memset((char *)gdb_regs, 0, NUMREGBYTES);
-	thread_regs = task_pt_regs(task);
-	memcpy((void *)gdb_regs, (void *)thread_regs->regs, GP_REG_BYTES);
-	/* Special case for PSTATE (check comments in asm/kgdb.h for details) */
-	dbg_get_reg(33, gdb_regs + GP_REG_BYTES, thread_regs);
+
+	gdb_regs[19] = cpu_context->x19;
+	gdb_regs[20] = cpu_context->x20;
+	gdb_regs[21] = cpu_context->x21;
+	gdb_regs[22] = cpu_context->x22;
+	gdb_regs[23] = cpu_context->x23;
+	gdb_regs[24] = cpu_context->x24;
+	gdb_regs[25] = cpu_context->x25;
+	gdb_regs[26] = cpu_context->x26;
+	gdb_regs[27] = cpu_context->x27;
+	gdb_regs[28] = cpu_context->x28;
+	gdb_regs[29] = cpu_context->fp;
+
+	gdb_regs[31] = cpu_context->sp;
+	gdb_regs[32] = cpu_context->pc;
 }
 
 void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
-- 
2.16.2.395.g2e18187dfd-goog
