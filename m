Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751766AbeA3HwN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 02:52:13 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40329 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbeA3HwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 02:52:12 -0500
X-Google-Smtp-Source: AH8x225YeBExT8jAuzozgHA25l++A8HtAFToi3K6LmUIAqXg1cdmcCL3vW/LzsGFtIYBj9bf7zaopA==
From: Zong Li <zongbox@gmail.com>
To: palmer@sifive.com, albert@sifive.com, patches@groups.riscv.org,
        linux-kernel@vger.kernel.org
Cc: zongbox@gmail.com, zong@andestech.com
Subject: [PATCH] RISC-V: Enable IRQ during exception handling
Date: Tue, 30 Jan 2018 15:51:45 +0800
Message-Id: <1517298705-19061-1-git-send-email-zongbox@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupt is allowed during exception handling.
There are warning messages if the kernel enables the configuration
'CONFIG_DEBUG_ATOMIC_SLEEP=y'.

BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:23
in_atomic(): 0, irqs_disabled(): 1, pid: 43, name: ash
CPU: 0 PID: 43 Comm: ash Tainted:  G        W        4.15.0-rc8-00089-g89ffdae-dirty #17
Call Trace:
[<000000009abb1587>] walk_stackframe+0x0/0x7a
[<00000000d4f3d088>] ___might_sleep+0x102/0x11a
[<00000000b1fd792a>] down_read+0x18/0x28
[<000000000289ec01>] do_page_fault+0x86/0x2f6
[<00000000012441f6>] _do_fork+0x1b4/0x1e0
[<00000000f46c3e3b>] ret_from_syscall+0xa/0xe

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/kernel/entry.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 7404ec2..61f063e 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -169,6 +169,9 @@ ENTRY(handle_exception)
 	move a1, sp /* pt_regs */
 	tail do_IRQ
 1:
+	/* Exceptions run with interrupts enabled */
+	csrs sstatus, SR_SIE
+
 	/* Handle syscalls */
 	li t0, EXC_SYSCALL
 	beq s4, t0, handle_syscall
@@ -195,8 +198,6 @@ handle_syscall:
 	 */
 	addi s2, s2, 0x4
 	REG_S s2, PT_SEPC(sp)
-	/* System calls run with interrupts enabled */
-	csrs sstatus, SR_SIE
 	/* Trace syscalls, but only if requested by the user. */
 	REG_L t0, TASK_TI_FLAGS(tp)
 	andi t0, t0, _TIF_SYSCALL_TRACE
-- 
2.9.3
