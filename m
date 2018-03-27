Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeC0QTe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:19:34 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38945 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbeC0QTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:19:30 -0400
X-Google-Smtp-Source: AG47ELvztFjlf0jH66I2M0bEsnfn+9SCx2JFppSsPjk+7V3UvcGm0jugUeh+ImEk3CnPiIG/ksThlw==
Subject: [PATCH v4 4/8] RISC-V: Move to the new GENERIC_IRQ_MULTI_HANDLER handler
Date: Tue, 27 Mar 2018 09:19:07 -0700
Message-Id: <20180327161911.14086-5-palmer@sifive.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180327161911.14086-1-palmer@sifive.com>
References: <20180327161911.14086-1-palmer@sifive.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: linux@armlinux.org.uk, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org,
        linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old mechanism for handling IRQs on RISC-V was pretty ugly: the arch
code looked at the Kconfig entry for our first-level irqchip driver and
called into it directly.

This patch uses the new generic IRQ handling infastructure, which
essentially just deletes a bunch of code.  This does add an additional
load to the interrupt latency, but there's a lot of tuning left to be
done there on RISC-V so I think it's OK for now.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
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
-- 
2.16.1
