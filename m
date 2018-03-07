Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755198AbeCGX6o (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 18:58:44 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42719 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755104AbeCGX5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 18:57:40 -0500
X-Google-Smtp-Source: AG47ELvBV5Ea2irvL04doIvWBf3t0+6prKhmB39zsTXN0uXATGNoyI9mC4GLXNKgkl8mYXyA/giNsg==
Subject: [PATCH v3 1/5] irq: Add CONFIG_GENERIC_IRQ_MULTI_HANDLER
Date: Wed,  7 Mar 2018 15:57:27 -0800
Message-Id: <20180307235731.22627-2-palmer@sifive.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180307235731.22627-1-palmer@sifive.com>
References: <20180307235731.22627-1-palmer@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
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
kernel/irq under CONFIG_GENERIC_MULTI_IRQ_HANDLER.  This patch is
currently all dead code, but it will be enabled in the various other
architectures in subsequent patches.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 include/linux/irq.h | 18 ++++++++++++++++++
 kernel/irq/Kconfig  |  5 +++++
 kernel/irq/handle.c | 15 +++++++++++++++
 3 files changed, 38 insertions(+)

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
index 6fc87ccda1d7..116a6972f124 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -132,3 +132,8 @@ config GENERIC_IRQ_DEBUGFS
 	  If you don't know what to do here, say N.
 
 endmenu
+
+config GENERIC_IRQ_MULTI_HANDLER
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
