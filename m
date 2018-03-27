Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeC0QTg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:19:36 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46457 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbeC0QT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:19:29 -0400
X-Google-Smtp-Source: AG47ELuIbscDtV2ttrQYn4DW43lFHOj5sbCQGP2Ru/fcQDyqTVaGoKCm8OoRYFoT/Y4S7x1HCNWo9Q==
Subject: [PATCH v4 3/8] irq: Add CONFIG_GENERIC_IRQ_MULTI_HANDLER
Date: Tue, 27 Mar 2018 09:19:06 -0700
Message-Id: <20180327161911.14086-4-palmer@sifive.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180327161911.14086-1-palmer@sifive.com>
References: <20180327161911.14086-1-palmer@sifive.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@sifive.com>,
        Shea Levy <shea@shealevy.com>, Arnd Bergmann <arnd@arndb.de>
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

It looks like the arm irqchip registration mechanism has been copied
into a handful of ports, including arm64 and openrisc.  I want to use
this in the RISC-V port, so I thought it would be good to make this
generic instead.

This patch copies the arm definition of CONFIG_MULTI_IRQ_HANDLER into
kernel/irq under CONFIG_GENERIC_IRQ_MULTI_HANDLER.  This patch is
currently all dead code, but it will be enabled in the various other
architectures in subsequent patches.

GENERIC_IRQ_MULTI_HANDLER is incompatible with MULTI_IRQ_HANDLER because
they define the same symbols.  Multiple generic irqchip drivers select
MULTI_IRQ_HANDLER, which is now defined on all architectures that
provide set_handle_irq().  This patch selects GENERIC_IRQ_MULTI_HANDLER
for all drivers that used to select MULTI_IRQ_HANDLER, but only when
MULTI_IRQ_HANDLER doesn't exist.  I'll then convert every architecture
over from MULTI_IRQ_HANDLER to GENERIC_IRQ_MULTI_HANDLER before removing
the extra MULTI_IRQ_HANDLER scaffolding.

CC: Shea Levy <shea@shealevy.com>
CC: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 drivers/irqchip/Kconfig |  8 ++++++++
 include/linux/irq.h     | 18 ++++++++++++++++++
 kernel/irq/Kconfig      |  6 ++++++
 kernel/irq/handle.c     | 15 +++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index d913aec85109..5af28ac6ce35 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -9,6 +9,7 @@ config ARM_GIC
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 
 config ARM_GIC_PM
@@ -35,6 +36,7 @@ config ARM_GIC_V3
 	bool
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 	select IRQ_DOMAIN_HIERARCHY
 	select PARTITION_PERCPU
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
@@ -61,6 +63,7 @@ config ARM_VIC
 	bool
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 
 config ARM_VIC_NR
 	int
@@ -88,6 +91,7 @@ config ATMEL_AIC_IRQ
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 
 config ATMEL_AIC5_IRQ
@@ -95,6 +99,7 @@ config ATMEL_AIC5_IRQ
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 
 config I8259
@@ -132,6 +137,7 @@ config FARADAY_FTINTC010
 	bool
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 
 config HISILICON_IRQ_MBIGEN
@@ -157,6 +163,7 @@ config CLPS711X_IRQCHIP
 	depends on ARCH_CLPS711X
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 	default y
 
@@ -176,6 +183,7 @@ config ORION_IRQCHIP
 	bool
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 
 config PIC32_EVIC
 	bool
diff --git a/include/linux/irq.h b/include/linux/irq.h
index a0231e96a578..77e97872a13e 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1170,4 +1170,22 @@ int __ipi_send_mask(struct irq_desc *desc, const struct cpumask *dest);
 int ipi_send_single(unsigned int virq, unsigned int cpu);
 int ipi_send_mask(unsigned int virq, const struct cpumask *dest);
 
+#ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
+/*
+ * Registers a generic IRQ handling function as the top-level IRQ handler in
+ * the system, which is generally the first C code called from an assembly
+ * architecture-specific interrupt handler.
+ *
+ * Returns 0 on success, or -EBUSY if an IRQ handler has already been
+ * registered.
+ */
+int __init set_handle_irq(void (*handle_irq)(struct pt_regs *));
+
+/*
+ * Allows interrupt handlers to find the irqchip that's been registered as the
+ * top-level IRQ handler.
+ */
+extern void (*handle_arch_irq)(struct pt_regs *) __ro_after_init;
+#endif
+
 #endif /* _LINUX_IRQ_H */
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 6fc87ccda1d7..8596baa8e53d 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -132,3 +132,9 @@ config GENERIC_IRQ_DEBUGFS
 	  If you don't know what to do here, say N.
 
 endmenu
+
+config GENERIC_IRQ_MULTI_HANDLER
+	depends on !MULTI_IRQ_HANDLER
+	bool
+	help
+	  Allow each machine to specify it's own IRQ handler at run time.
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 79f987b942b8..3570c715c3e7 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -20,6 +20,10 @@
 
 #include "internals.h"
 
+#ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
+void (*handle_arch_irq)(struct pt_regs *) __ro_after_init;
+#endif
+
 /**
  * handle_bad_irq - handle spurious and unhandled irqs
  * @desc:      description of the interrupt
@@ -207,3 +211,14 @@ irqreturn_t handle_irq_event(struct irq_desc *desc)
 	irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
 	return ret;
 }
+
+#ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
+int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
+{
+	if (handle_arch_irq)
+		return -EBUSY;
+
+	handle_arch_irq = handle_irq;
+	return 0;
+}
+#endif
-- 
2.16.1
