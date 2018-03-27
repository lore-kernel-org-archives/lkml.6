Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbeC0QUh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:20:37 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46065 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752048AbeC0QTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:19:34 -0400
X-Google-Smtp-Source: AIpwx4+9YrO+0aj/XOb31SzBY500XbhFP9kby/T/r8492NyYBd/d54rJmqBJv4LgujwoCqK0JhRMsg==
Subject: [PATCH v4 7/8] openrisc: Use the new GENERIC_IRQ_MULTI_HANDLER
Date: Tue, 27 Mar 2018 09:19:10 -0700
Message-Id: <20180327161911.14086-8-palmer@sifive.com>
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

It appears that openrisc copied arm64's GENERIC_IRQ_MULTI_HANDLER code
(which came from arm).  I wanted to make this generic so I could use it
in the RISC-V port.  This patch converts the openrisc code to use the
generic version.

Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/openrisc/Kconfig           | 5 +----
 arch/openrisc/include/asm/irq.h | 2 --
 arch/openrisc/kernel/irq.c      | 7 -------
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 9ecad05bfc73..dfb6a79ba7ff 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -27,7 +27,6 @@ config OPENRISC
 	select GENERIC_STRNLEN_USER
 	select GENERIC_SMP_IDLE_THREAD
 	select MODULES_USE_ELF_RELA
-	select MULTI_IRQ_HANDLER
 	select HAVE_DEBUG_STACKOVERFLOW
 	select OR1K_PIC
 	select CPU_NO_EFFICIENT_FFS if !OPENRISC_HAVE_INST_FF1
@@ -36,6 +35,7 @@ config OPENRISC
 	select ARCH_USE_QUEUED_RWLOCKS
 	select OMPIC if SMP
 	select ARCH_WANT_FRAME_POINTERS
+	select GENERIC_IRQ_MULTI_HANDLER
 
 config CPU_BIG_ENDIAN
 	def_bool y
@@ -69,9 +69,6 @@ config STACKTRACE_SUPPORT
 config LOCKDEP_SUPPORT
 	def_bool  y
 
-config MULTI_IRQ_HANDLER
-	def_bool y
-
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/openrisc/include/asm/irq.h b/arch/openrisc/include/asm/irq.h
index d9eee0a2b7b4..eb612b1865d2 100644
--- a/arch/openrisc/include/asm/irq.h
+++ b/arch/openrisc/include/asm/irq.h
@@ -24,6 +24,4 @@
 
 #define NO_IRQ		(-1)
 
-extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
-
 #endif /* __ASM_OPENRISC_IRQ_H__ */
diff --git a/arch/openrisc/kernel/irq.c b/arch/openrisc/kernel/irq.c
index 35e478a93116..5f9445effaf8 100644
--- a/arch/openrisc/kernel/irq.c
+++ b/arch/openrisc/kernel/irq.c
@@ -41,13 +41,6 @@ void __init init_IRQ(void)
 	irqchip_init();
 }
 
-static void (*handle_arch_irq)(struct pt_regs *);
-
-void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
-{
-	handle_arch_irq = handle_irq;
-}
-
 void __irq_entry do_IRQ(struct pt_regs *regs)
 {
 	handle_arch_irq(regs);
-- 
2.16.1
