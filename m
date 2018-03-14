Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751719AbeCNUtk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:49:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40531 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbeCNUti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:49:38 -0400
Date: Wed, 14 Mar 2018 13:49:25 -0700
From: tip-bot for Palmer Dabbelt <tipbot@zytor.com>
Message-ID: <tip-cc6c98485f8e61fb3d6c51821fc75384e5a3a9c3@git.kernel.org>
Cc: will.deacon@arm.com, linux-kernel@vger.kernel.org, palmer@sifive.com,
        hch@lst.de, hpa@zytor.com, mingo@kernel.org, shorne@gmail.com,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, tglx@linutronix.de, shorne@gmail.com,
        will.deacon@arm.com, hch@lst.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, palmer@sifive.com
In-Reply-To: <20180307235731.22627-3-palmer@sifive.com>
References: <20180307235731.22627-3-palmer@sifive.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] RISC-V: Move to the new GENERIC_IRQ_MULTI_HANDLER
 handler
Git-Commit-ID: cc6c98485f8e61fb3d6c51821fc75384e5a3a9c3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cc6c98485f8e61fb3d6c51821fc75384e5a3a9c3
Gitweb:     https://git.kernel.org/tip/cc6c98485f8e61fb3d6c51821fc75384e5a3a9c3
Author:     Palmer Dabbelt <palmer@sifive.com>
AuthorDate: Wed, 7 Mar 2018 15:57:28 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 14 Mar 2018 21:46:29 +0100

RISC-V: Move to the new GENERIC_IRQ_MULTI_HANDLER handler

The existing mechanism for handling IRQs on RISC-V is pretty ugly: the irq
entry code selects the handler via Kconfig dependencies.

Use the new generic IRQ handling infastructure, which allows boot time
registration of the low level entry handler.

This does add an additional load to the interrupt latency, but there's a
lot of tuning left to be done there on RISC-V so it's OK for now.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Stafford Horne <shorne@gmail.com>
Cc: jonas@southpole.se
Cc: catalin.marinas@arm.com
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux@armlinux.org.uk
Cc: stefan.kristiansson@saunalahti.fi
Cc: openrisc@lists.librecores.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Link: https://lkml.kernel.org/r/20180307235731.22627-3-palmer@sifive.com

---
 arch/riscv/Kconfig            |  1 +
 arch/riscv/include/asm/Kbuild |  1 +
 arch/riscv/kernel/entry.S     |  7 +++----
 arch/riscv/kernel/irq.c       | 13 -------------
 4 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 04807c7f64cc..148865de1692 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -33,6 +33,7 @@ config RISCV
 	select MODULES_USE_ELF_RELA if MODULES
 	select THREAD_INFO_IN_TASK
 	select RISCV_TIMER
+	select GENERIC_IRQ_MULTI_HANDLER
 
 config MMU
 	def_bool y
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 4286a5f83876..1e5fd280fb4d 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -15,6 +15,7 @@ generic-y += fcntl.h
 generic-y += futex.h
 generic-y += hardirq.h
 generic-y += hash.h
+generic-y += handle_irq.h
 generic-y += hw_irq.h
 generic-y += ioctl.h
 generic-y += ioctls.h
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 56fa592cfa34..9aaf6c986771 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -167,10 +167,9 @@ ENTRY(handle_exception)
 	bge s4, zero, 1f
 
 	/* Handle interrupts */
-	slli a0, s4, 1
-	srli a0, a0, 1
-	move a1, sp /* pt_regs */
-	tail do_IRQ
+	move a0, sp /* pt_regs */
+	REG_L a1, handle_arch_irq
+	jr a1
 1:
 	/* Exceptions run with interrupts enabled */
 	csrs sstatus, SR_SIE
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 328718e8026e..b74cbfbce2d0 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -24,16 +24,3 @@ void __init init_IRQ(void)
 {
 	irqchip_init();
 }
-
-asmlinkage void __irq_entry do_IRQ(unsigned int cause, struct pt_regs *regs)
-{
-#ifdef CONFIG_RISCV_INTC
-	/*
-	 * FIXME: We don't want a direct call to riscv_intc_irq here.  The plan
-	 * is to put an IRQ domain here and let the interrupt controller
-	 * register with that, but I poked around the arm64 code a bit and
-	 * there might be a better way to do it (ie, something fully generic).
-	 */
-	riscv_intc_irq(cause, regs);
-#endif
-}
