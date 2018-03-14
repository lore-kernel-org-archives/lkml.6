Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeCNUtJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:49:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45501 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbeCNUtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:49:08 -0400
Date: Wed, 14 Mar 2018 13:48:55 -0700
From: tip-bot for Palmer Dabbelt <tipbot@zytor.com>
Message-ID: <tip-caacdbf4aa567ab5e8de1a4070195c5d3e8f1340@git.kernel.org>
Cc: palmer@sifive.com, mingo@kernel.org, will.deacon@arm.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        palmer@sifive.com, will.deacon@arm.com, mingo@kernel.org
In-Reply-To: <20180307235731.22627-2-palmer@sifive.com>
References: <20180307235731.22627-2-palmer@sifive.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Add CONFIG_GENERIC_IRQ_MULTI_HANDLER
Git-Commit-ID: caacdbf4aa567ab5e8de1a4070195c5d3e8f1340
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

Commit-ID:  caacdbf4aa567ab5e8de1a4070195c5d3e8f1340
Gitweb:     https://git.kernel.org/tip/caacdbf4aa567ab5e8de1a4070195c5d3e8f1340
Author:     Palmer Dabbelt <palmer@sifive.com>
AuthorDate: Wed, 7 Mar 2018 15:57:27 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 14 Mar 2018 21:46:29 +0100

genirq: Add CONFIG_GENERIC_IRQ_MULTI_HANDLER

The arm multi irq handler registration mechanism has been copied into a
handful of architectures, including arm64 and openrisc. RISC-V needs the
same mechanism.

Instead of adding yet another copy for RISC-V copy the arm implementation
into the core code depending on a new Kconfig symbol:
CONFIG_GENERIC_MULTI_IRQ_HANDLER.

Subsequent patches will convert the various architectures.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: jonas@southpole.se
Cc: catalin.marinas@arm.com
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux@armlinux.org.uk
Cc: stefan.kristiansson@saunalahti.fi
Cc: openrisc@lists.librecores.org
Cc: shorne@gmail.com
Cc: linux-riscv@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Link: https://lkml.kernel.org/r/20180307235731.22627-2-palmer@sifive.com

---
 include/linux/irq.h | 18 ++++++++++++++++++
 kernel/irq/Kconfig  |  5 +++++
 kernel/irq/handle.c | 15 +++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 979eed1b2654..65916a305f3d 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1165,4 +1165,22 @@ int __ipi_send_mask(struct irq_desc *desc, const struct cpumask *dest);
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
index 6fc87ccda1d7..5f3e2baefca9 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -132,3 +132,8 @@ config GENERIC_IRQ_DEBUGFS
 	  If you don't know what to do here, say N.
 
 endmenu
+
+config GENERIC_IRQ_MULTI_HANDLER
+	bool
+	help
+	  Allow to specify the low level IRQ handler at run time.
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
