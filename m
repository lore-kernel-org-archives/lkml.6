Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932271AbeCLSpI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 14:45:08 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40275 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbeCLSpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 14:45:05 -0400
X-Google-Smtp-Source: AG47ELsw0A80uTh3eRL3XJoIjJMjEZMIrOx0OSRh862PEyatMjtd+N14szDwszN+pGV9lYe0lviPig==
Subject: [PATCH v4] openrisc: Use the new GENERIC_IRQ_MULTI_HANDLER
Date: Mon, 12 Mar 2018 11:44:29 -0700
Message-Id: <20180312184429.20515-1-palmer@sifive.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180307235731.22627-6-palmer@sifive.com>
References: <20180307235731.22627-6-palmer@sifive.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
        shorne@gmail.com, openrisc@lists.librecores.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: tglx@linutronix.de
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
 arch/openrisc/Kconfig           | 1 +
 arch/openrisc/include/asm/irq.h | 2 --
 arch/openrisc/kernel/irq.c      | 7 -------
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 339df7324e9c..dfb6a79ba7ff 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -35,6 +35,7 @@ config OPENRISC
 	select ARCH_USE_QUEUED_RWLOCKS
 	select OMPIC if SMP
 	select ARCH_WANT_FRAME_POINTERS
+	select GENERIC_IRQ_MULTI_HANDLER
 
 config CPU_BIG_ENDIAN
 	def_bool y
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
