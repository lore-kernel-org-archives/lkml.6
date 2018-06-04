Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbeFDJvv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:51:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38904 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751715AbeFDJvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:51:48 -0400
Date: Mon, 4 Jun 2018 11:51:42 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] irq updates for 4.18
Message-ID: <alpine.DEB.2.21.1806041143120.2646@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-644893481-1528105479=:2646"
Content-ID: <alpine.DEB.2.21.1806041145380.2646@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-644893481-1528105479=:2646
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.21.1806041145381.2646@nanos.tec.linutronix.de>

Linus,

please pull the latest irq-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-for-linus

(Soft) Interrupt related updates:

  - Consolidation of softirq pending:

    The softirq mask and its accessors/mutators have many implementations
    scattered around many architectures. Most do the same things consisting
    in a field in a per-cpu struct (often irq_cpustat_t) accessed through
    per-cpu ops. We can provide instead a generic efficient version that
    most of them can use. In fact s390 is the only exception because the
    field is stored in lowcore.

  - Support for level!?! triggered MSI (ARM)

    Over the past couple of years, we've seen some SoCs coming up with ways
    of signalling level interrupts using a new flavor of MSIs, where the
    MSI controller uses two distinct messages: one that raises a virtual
    line, and one that lowers it. The target MSI controller is in charge of
    maintaining the state of the line.

    This allows for a much simplified HW signal routing (no need to have
    hundreds of discrete lines to signal level interrupts if you already
    have a memory bus), but results in a departure from the current idea
    the kernel has of MSIs.

  - Support for Meson-AXG GPIO irqchip
    
  - Large stm32 irqchip rework (suspend/resume, hierarchical domains)
 
  - More SPDX conversions

Thanks,

	tglx

------------------>
Bartosz Golaszewski (2):
      genirq/irq_sim: Remove the license boilerplate
      genirq/irq_sim: Use the SPDX license identifier in the header

Frederic Weisbecker (11):
      softirq/ia64: Convert local_softirq_pending() to per-cpu ops
      softirq/sparc: Convert local_softirq_pending() to use per-cpu op
      softirq/sh: Use nmi_count() on /proc/interrupts print out
      softirq/core: Turn default irq_cpustat_t to standard per-cpu
      softirq/core: Consolidate default local_softirq_pending() implementations
      softirq/ia64: Switch to generic local_softirq_pending() implementation
      softirq/parisc: Switch to generic local_softirq_pending() implementation
      softirq/powerpc: Switch to generic local_softirq_pending() implementation
      softirq/sparc: Switch to generic local_softirq_pending() implementation
      softirq/x86: Switch to generic local_softirq_pending() implementation
      softirq/s390: Move default mutators of overwritten softirq mask to s390

Ludovic Barre (10):
      irqchip/stm32: Checkpatch fix
      irqchip/stm32: Add falling pending register support
      irqchip/stm32: Add suspend support
      irqchip/stm32: Add host and driver data structures
      irqchip/stm32: Prepare common functions
      irqchip/stm32: Add stm32mp1 support with hierarchy domain
      irqchip/stm32: Add suspend/resume support for hierarchy domain
      pinctrl/stm32: Add irq_eoi for stm32gpio irqchip
      ARM: dts: stm32: Add exti support for stm32mp157c
      ARM: dts: stm32: Add exti support to stm32mp157 pinctrl

Marc Zyngier (9):
      genirq/msi: Allow level-triggered MSIs to be exposed by MSI providers
      genirq/msi: Limit level-triggered MSI to platform devices
      irqchip/mvebu-gicp: Use level-triggered MSIs between ICU and GICP
      dma-iommu: Fix compilation when !CONFIG_IOMMU_DMA
      irqdomain: Let irq_find_host default to DOMAIN_BUS_WIRED
      irqchip/gic-v3: Mark the base irq domain as DOMAIN_BUS_WIRED
      irqchip/gic-v3: Add support for Message Based Interrupts as an MSI controller
      irqchip/gic-v3: Add PCI/MSI support to the GICv3 MBI sub-driver
      dt-bindings/gic-v3: Add documentation for MBI support

Radoslaw Pietrzyk (1):
      irqchip/stm32: Optimizes and cleans up stm32-exti irq_domain

Yixun Lan (3):
      dt-bindings: interrupt-controller: Fix the double quotes
      dt-bindings: interrupt-controller: New binding for Meson-AXG SoC
      irqchip/meson-gpio: Add support for Meson-AXG SoCs


 .../amlogic,meson-gpio-intc.txt                    |  11 +-
 .../bindings/interrupt-controller/arm,gic-v3.txt   |  17 +
 .../interrupt-controller/st,stm32-exti.txt         |   3 +
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi          |   4 +
 arch/arm/boot/dts/stm32mp157c.dtsi                 |   7 +
 arch/ia64/include/asm/hardirq.h                    |   2 +-
 arch/parisc/include/asm/hardirq.h                  |   8 -
 arch/powerpc/include/asm/hardirq.h                 |   7 -
 arch/s390/include/asm/hardirq.h                    |   2 +
 arch/sh/kernel/irq.c                               |   2 +-
 arch/sparc/include/asm/hardirq_64.h                |   5 +-
 arch/x86/include/asm/hardirq.h                     |   8 -
 drivers/base/platform-msi.c                        |   3 +
 drivers/bus/fsl-mc/fsl-mc-msi.c                    |   2 +
 drivers/irqchip/Makefile                           |   2 +-
 drivers/irqchip/irq-gic-v3-mbi.c                   | 331 ++++++++++
 drivers/irqchip/irq-gic-v3.c                       |   7 +
 drivers/irqchip/irq-meson-gpio.c                   |   5 +
 drivers/irqchip/irq-mvebu-gicp.c                   |  38 +-
 drivers/irqchip/irq-mvebu-gicp.h                   |  12 -
 drivers/irqchip/irq-mvebu-icu.c                    |  33 +-
 drivers/irqchip/irq-stm32-exti.c                   | 683 ++++++++++++++++++---
 drivers/pci/msi.c                                  |   3 +
 drivers/pinctrl/stm32/pinctrl-stm32.c              |  13 +-
 include/linux/dma-iommu.h                          |   1 +
 include/linux/interrupt.h                          |  13 +-
 include/linux/irq.h                                |   1 +
 include/linux/irq_cpustat.h                        |  10 +-
 include/linux/irq_sim.h                            |  13 +-
 include/linux/irqchip/arm-gic-v3.h                 |   1 +
 include/linux/irqdomain.h                          |   8 +-
 include/linux/msi.h                                |   2 +
 kernel/irq/irq_sim.c                               |   7 +-
 kernel/irq/msi.c                                   |  33 +-
 kernel/softirq.c                                   |   4 +-
 35 files changed, 1079 insertions(+), 222 deletions(-)
 create mode 100644 drivers/irqchip/irq-gic-v3-mbi.c
 delete mode 100644 drivers/irqchip/irq-mvebu-gicp.h

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
index a83f9a5734ca..89674ad8a097 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
@@ -9,11 +9,12 @@ number of interrupt exposed depends on the SoC.
 
 Required properties:
 
-- compatible : must have "amlogic,meson8-gpio-intc” and either
-   “amlogic,meson8-gpio-intc” for meson8 SoCs (S802) or
-   “amlogic,meson8b-gpio-intc” for meson8b SoCs (S805) or
-   “amlogic,meson-gxbb-gpio-intc” for GXBB SoCs (S905) or
-   “amlogic,meson-gxl-gpio-intc” for GXL SoCs (S905X, S912)
+- compatible : must have "amlogic,meson8-gpio-intc" and either
+    "amlogic,meson8-gpio-intc" for meson8 SoCs (S802) or
+    "amlogic,meson8b-gpio-intc" for meson8b SoCs (S805) or
+    "amlogic,meson-gxbb-gpio-intc" for GXBB SoCs (S905) or
+    "amlogic,meson-gxl-gpio-intc" for GXL SoCs (S905X, S912)
+    "amlogic,meson-axg-gpio-intc" for AXG SoCs (A113D, A113X)
 - interrupt-parent : a phandle to the GIC the interrupts are routed to.
    Usually this is provided at the root level of the device tree as it is
    common to most of the SoC.
diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
index 0a57f2f4167d..3ea78c4ef887 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
@@ -57,6 +57,20 @@ Optional
   occupied by the redistributors. Required if more than one such
   region is present.
 
+- msi-controller: Boolean property. Identifies the node as an MSI
+  controller. Only present if the Message Based Interrupt
+  functionnality is being exposed by the HW, and the mbi-ranges
+  property present.
+
+- mbi-ranges: A list of pairs <intid span>, where "intid" is the first
+  SPI of a range that can be used an MBI, and "span" the size of that
+  range. Multiple ranges can be provided. Requires "msi-controller" to
+  be set.
+
+- mbi-alias: Address property. Base address of an alias of the GICD
+  region containing only the {SET,CLR}SPI registers to be used if
+  isolation is required, and if supported by the HW.
+
 Sub-nodes:
 
 PPI affinity can be expressed as a single "ppi-partitions" node,
@@ -99,6 +113,9 @@ Examples:
 		      <0x0 0x2c020000 0 0x2000>;	// GICV
 		interrupts = <1 9 4>;
 
+		msi-controller;
+		mbi-ranges = <256 128>;
+
 		gic-its@2c200000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
index edf03f09244b..136bd612bd83 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
@@ -5,11 +5,14 @@ Required properties:
 - compatible: Should be:
     "st,stm32-exti"
     "st,stm32h7-exti"
+    "st,stm32mp1-exti"
 - reg: Specifies base physical address and size of the registers
 - interrupt-controller: Indentifies the node as an interrupt controller
 - #interrupt-cells: Specifies the number of cells to encode an interrupt
   specifier, shall be 2
 - interrupts: interrupts references to primary interrupt controller
+  (only needed for exti controller with multiple exti under
+  same parent interrupt: st,stm32-exti and st,stm32h7-exti")
 
 Example:
 
diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index c0743305f31b..eb96ac3e6c1d 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -12,6 +12,8 @@
 			#size-cells = <1>;
 			compatible = "st,stm32mp157-pinctrl";
 			ranges = <0 0x50002000 0xa400>;
+			interrupt-parent = <&exti>;
+			st,syscfg = <&exti 0x60 0xff>;
 			pins-are-numbered;
 
 			gpioa: gpio@50002000 {
@@ -166,6 +168,8 @@
 			compatible = "st,stm32mp157-z-pinctrl";
 			ranges = <0 0x54004000 0x400>;
 			pins-are-numbered;
+			interrupt-parent = <&exti>;
+			st,syscfg = <&exti 0x60 0xff>;
 			status = "disabled";
 
 			gpioz: gpio@54004000 {
diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 9e17e42b02b2..4fa0df853c8a 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -183,6 +183,13 @@
 			status = "disabled";
 		};
 
+		exti: interrupt-controller@5000d000 {
+			compatible = "st,stm32mp1-exti", "syscon";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x5000d000 0x400>;
+		};
+
 		usart1: serial@5c000000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x5c000000 0x400>;
diff --git a/arch/ia64/include/asm/hardirq.h b/arch/ia64/include/asm/hardirq.h
index bdc4669c71c3..ccde7c2ba00f 100644
--- a/arch/ia64/include/asm/hardirq.h
+++ b/arch/ia64/include/asm/hardirq.h
@@ -13,7 +13,7 @@
 
 #define __ARCH_IRQ_STAT	1
 
-#define local_softirq_pending()		(local_cpu_data->softirq_pending)
+#define local_softirq_pending_ref	ia64_cpu_info.softirq_pending
 
 #include <linux/threads.h>
 #include <linux/irq.h>
diff --git a/arch/parisc/include/asm/hardirq.h b/arch/parisc/include/asm/hardirq.h
index 077815169258..1a1235a9d533 100644
--- a/arch/parisc/include/asm/hardirq.h
+++ b/arch/parisc/include/asm/hardirq.h
@@ -34,14 +34,6 @@ DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 #define __IRQ_STAT(cpu, member) (irq_stat[cpu].member)
 #define inc_irq_stat(member)	this_cpu_inc(irq_stat.member)
 #define __inc_irq_stat(member)	__this_cpu_inc(irq_stat.member)
-#define local_softirq_pending()	this_cpu_read(irq_stat.__softirq_pending)
-
-#define __ARCH_SET_SOFTIRQ_PENDING
-
-#define set_softirq_pending(x)	\
-		this_cpu_write(irq_stat.__softirq_pending, (x))
-#define or_softirq_pending(x)	this_cpu_or(irq_stat.__softirq_pending, (x))
-
 #define ack_bad_irq(irq) WARN(1, "unexpected IRQ trap at vector %02x\n", irq)
 
 #endif /* _PARISC_HARDIRQ_H */
diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
index 5986d473722b..383f628acbf8 100644
--- a/arch/powerpc/include/asm/hardirq.h
+++ b/arch/powerpc/include/asm/hardirq.h
@@ -25,15 +25,8 @@ typedef struct {
 DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 
 #define __ARCH_IRQ_STAT
-
-#define local_softirq_pending()	__this_cpu_read(irq_stat.__softirq_pending)
-
-#define __ARCH_SET_SOFTIRQ_PENDING
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED
 
-#define set_softirq_pending(x) __this_cpu_write(irq_stat.__softirq_pending, (x))
-#define or_softirq_pending(x) __this_cpu_or(irq_stat.__softirq_pending, (x))
-
 static inline void ack_bad_irq(unsigned int irq)
 {
 	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
diff --git a/arch/s390/include/asm/hardirq.h b/arch/s390/include/asm/hardirq.h
index a296c6acfd07..dfbc3c6c0674 100644
--- a/arch/s390/include/asm/hardirq.h
+++ b/arch/s390/include/asm/hardirq.h
@@ -14,6 +14,8 @@
 #include <asm/lowcore.h>
 
 #define local_softirq_pending() (S390_lowcore.softirq_pending)
+#define set_softirq_pending(x) (S390_lowcore.softirq_pending = (x))
+#define or_softirq_pending(x)  (S390_lowcore.softirq_pending |= (x))
 
 #define __ARCH_IRQ_STAT
 #define __ARCH_HAS_DO_SOFTIRQ
diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index 245dbeb20afe..5717c7cbdd97 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -44,7 +44,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 
 	seq_printf(p, "%*s: ", prec, "NMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", irq_stat[j].__nmi_count);
+		seq_printf(p, "%10u ", nmi_count(j));
 	seq_printf(p, "  Non-maskable interrupts\n");
 
 	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count));
diff --git a/arch/sparc/include/asm/hardirq_64.h b/arch/sparc/include/asm/hardirq_64.h
index f56540271993..75b92bfe04b5 100644
--- a/arch/sparc/include/asm/hardirq_64.h
+++ b/arch/sparc/include/asm/hardirq_64.h
@@ -10,8 +10,9 @@
 #include <asm/cpudata.h>
 
 #define __ARCH_IRQ_STAT
-#define local_softirq_pending() \
-	(local_cpu_data().__softirq_pending)
+
+#define local_softirq_pending_ref \
+	__cpu_data.__softirq_pending
 
 void ack_bad_irq(unsigned int irq);
 
diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 5ea2afd4c871..740a428acf1e 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -50,14 +50,6 @@ DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 
 #define inc_irq_stat(member)	this_cpu_inc(irq_stat.member)
 
-#define local_softirq_pending()	this_cpu_read(irq_stat.__softirq_pending)
-
-#define __ARCH_SET_SOFTIRQ_PENDING
-
-#define set_softirq_pending(x)	\
-		this_cpu_write(irq_stat.__softirq_pending, (x))
-#define or_softirq_pending(x)	this_cpu_or(irq_stat.__softirq_pending, (x))
-
 extern void ack_bad_irq(unsigned int irq);
 
 extern u64 arch_irq_stat_cpu(unsigned int cpu);
diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 8e22073aeeed..60d6cc618f1c 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -101,6 +101,9 @@ static void platform_msi_update_chip_ops(struct msi_domain_info *info)
 		chip->irq_set_affinity = msi_domain_set_affinity;
 	if (!chip->irq_write_msi_msg)
 		chip->irq_write_msi_msg = platform_msi_write_msg;
+	if (WARN_ON((info->flags & MSI_FLAG_LEVEL_CAPABLE) &&
+		    !(chip->flags & IRQCHIP_SUPPORTS_LEVEL_MSI)))
+		info->flags &= ~MSI_FLAG_LEVEL_CAPABLE;
 }
 
 static void platform_msi_free_descs(struct device *dev, int base, int nvec)
diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index ec35e255b496..8b9c66d7c4ff 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -163,6 +163,8 @@ struct irq_domain *fsl_mc_msi_create_irq_domain(struct fwnode_handle *fwnode,
 {
 	struct irq_domain *domain;
 
+	if (WARN_ON((info->flags & MSI_FLAG_LEVEL_CAPABLE)))
+		info->flags &= ~MSI_FLAG_LEVEL_CAPABLE;
 	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
 		fsl_mc_msi_update_dom_ops(info);
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 5ed465ab1c76..15f268f646bf 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -27,7 +27,7 @@ obj-$(CONFIG_ARM_GIC)			+= irq-gic.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_PM)		+= irq-gic-pm.o
 obj-$(CONFIG_ARCH_REALVIEW)		+= irq-gic-realview.o
 obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
-obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-common.o
+obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-v3-mbi.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-platform-msi.o irq-gic-v4.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_PCI)	+= irq-gic-v3-its-pci-msi.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+= irq-gic-v3-its-fsl-mc-msi.o
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
new file mode 100644
index 000000000000..ad70e7c416e3
--- /dev/null
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -0,0 +1,331 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 ARM Limited, All Rights Reserved.
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ */
+
+#define pr_fmt(fmt) "GICv3: " fmt
+
+#include <linux/dma-iommu.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/msi.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include <linux/irqchip/arm-gic-v3.h>
+
+struct mbi_range {
+	u32			spi_start;
+	u32			nr_spis;
+	unsigned long		*bm;
+};
+
+static struct mutex		mbi_lock;
+static phys_addr_t		mbi_phys_base;
+static struct mbi_range		*mbi_ranges;
+static unsigned int		mbi_range_nr;
+
+static struct irq_chip mbi_irq_chip = {
+	.name			= "MBI",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+};
+
+static int mbi_irq_gic_domain_alloc(struct irq_domain *domain,
+				       unsigned int virq,
+				       irq_hw_number_t hwirq)
+{
+	struct irq_fwspec fwspec;
+	struct irq_data *d;
+	int err;
+
+	/*
+	 * Using ACPI? There is no MBI support in the spec, you
+	 * shouldn't even be here.
+	 */
+	if (!is_of_node(domain->parent->fwnode))
+		return -EINVAL;
+
+	/*
+	 * Let's default to edge. This is consistent with traditional
+	 * MSIs, and systems requiring level signaling will just
+	 * enforce the trigger on their own.
+	 */
+	fwspec.fwnode = domain->parent->fwnode;
+	fwspec.param_count = 3;
+	fwspec.param[0] = 0;
+	fwspec.param[1] = hwirq - 32;
+	fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
+
+	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
+	if (err)
+		return err;
+
+	d = irq_domain_get_irq_data(domain->parent, virq);
+	return d->chip->irq_set_type(d, IRQ_TYPE_EDGE_RISING);
+}
+
+static void mbi_free_msi(struct mbi_range *mbi, unsigned int hwirq,
+			 int nr_irqs)
+{
+	mutex_lock(&mbi_lock);
+	bitmap_release_region(mbi->bm, hwirq - mbi->spi_start,
+			      get_count_order(nr_irqs));
+	mutex_unlock(&mbi_lock);
+}
+
+static int mbi_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				   unsigned int nr_irqs, void *args)
+{
+	struct mbi_range *mbi = NULL;
+	int hwirq, offset, i, err = 0;
+
+	mutex_lock(&mbi_lock);
+	for (i = 0; i < mbi_range_nr; i++) {
+		offset = bitmap_find_free_region(mbi_ranges[i].bm,
+						 mbi_ranges[i].nr_spis,
+						 get_count_order(nr_irqs));
+		if (offset >= 0) {
+			mbi = &mbi_ranges[i];
+			break;
+		}
+	}
+	mutex_unlock(&mbi_lock);
+
+	if (!mbi)
+		return -ENOSPC;
+
+	hwirq = mbi->spi_start + offset;
+
+	for (i = 0; i < nr_irqs; i++) {
+		err = mbi_irq_gic_domain_alloc(domain, virq + i, hwirq + i);
+		if (err)
+			goto fail;
+
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+					      &mbi_irq_chip, mbi);
+	}
+
+	return 0;
+
+fail:
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+	mbi_free_msi(mbi, hwirq, nr_irqs);
+	return err;
+}
+
+static void mbi_irq_domain_free(struct irq_domain *domain,
+				unsigned int virq, unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct mbi_range *mbi = irq_data_get_irq_chip_data(d);
+
+	mbi_free_msi(mbi, d->hwirq, nr_irqs);
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+}
+
+static const struct irq_domain_ops mbi_domain_ops = {
+	.alloc			= mbi_irq_domain_alloc,
+	.free			= mbi_irq_domain_free,
+};
+
+static void mbi_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	msg[0].address_hi = upper_32_bits(mbi_phys_base + GICD_SETSPI_NSR);
+	msg[0].address_lo = lower_32_bits(mbi_phys_base + GICD_SETSPI_NSR);
+	msg[0].data = data->parent_data->hwirq;
+
+	iommu_dma_map_msi_msg(data->irq, msg);
+}
+
+#ifdef CONFIG_PCI_MSI
+/* PCI-specific irqchip */
+static void mbi_mask_msi_irq(struct irq_data *d)
+{
+	pci_msi_mask_irq(d);
+	irq_chip_mask_parent(d);
+}
+
+static void mbi_unmask_msi_irq(struct irq_data *d)
+{
+	pci_msi_unmask_irq(d);
+	irq_chip_unmask_parent(d);
+}
+
+static struct irq_chip mbi_msi_irq_chip = {
+	.name			= "MSI",
+	.irq_mask		= mbi_mask_msi_irq,
+	.irq_unmask		= mbi_unmask_msi_irq,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_compose_msi_msg	= mbi_compose_msi_msg,
+	.irq_write_msi_msg	= pci_msi_domain_write_msg,
+};
+
+static struct msi_domain_info mbi_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
+	.chip	= &mbi_msi_irq_chip,
+};
+
+static int mbi_allocate_pci_domain(struct irq_domain *nexus_domain,
+				   struct irq_domain **pci_domain)
+{
+	*pci_domain = pci_msi_create_irq_domain(nexus_domain->parent->fwnode,
+						&mbi_msi_domain_info,
+						nexus_domain);
+	if (!*pci_domain)
+		return -ENOMEM;
+
+	return 0;
+}
+#else
+static int mbi_allocate_pci_domain(struct irq_domain *nexus_domain,
+				   struct irq_domain **pci_domain)
+{
+	*pci_domain = NULL;
+	return 0;
+}
+#endif
+
+static void mbi_compose_mbi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	mbi_compose_msi_msg(data, msg);
+
+	msg[1].address_hi = upper_32_bits(mbi_phys_base + GICD_CLRSPI_NSR);
+	msg[1].address_lo = lower_32_bits(mbi_phys_base + GICD_CLRSPI_NSR);
+	msg[1].data = data->parent_data->hwirq;
+
+	iommu_dma_map_msi_msg(data->irq, &msg[1]);
+}
+
+/* Platform-MSI specific irqchip */
+static struct irq_chip mbi_pmsi_irq_chip = {
+	.name			= "pMSI",
+	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_compose_msi_msg	= mbi_compose_mbi_msg,
+	.flags			= IRQCHIP_SUPPORTS_LEVEL_MSI,
+};
+
+static struct msi_domain_ops mbi_pmsi_ops = {
+};
+
+static struct msi_domain_info mbi_pmsi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_LEVEL_CAPABLE),
+	.ops	= &mbi_pmsi_ops,
+	.chip	= &mbi_pmsi_irq_chip,
+};
+
+static int mbi_allocate_domains(struct irq_domain *parent)
+{
+	struct irq_domain *nexus_domain, *pci_domain, *plat_domain;
+	int err;
+
+	nexus_domain = irq_domain_create_tree(parent->fwnode,
+					      &mbi_domain_ops, NULL);
+	if (!nexus_domain)
+		return -ENOMEM;
+
+	irq_domain_update_bus_token(nexus_domain, DOMAIN_BUS_NEXUS);
+	nexus_domain->parent = parent;
+
+	err = mbi_allocate_pci_domain(nexus_domain, &pci_domain);
+
+	plat_domain = platform_msi_create_irq_domain(parent->fwnode,
+						     &mbi_pmsi_domain_info,
+						     nexus_domain);
+
+	if (err || !plat_domain) {
+		if (plat_domain)
+			irq_domain_remove(plat_domain);
+		if (pci_domain)
+			irq_domain_remove(pci_domain);
+		irq_domain_remove(nexus_domain);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+int __init mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent)
+{
+	struct device_node *np;
+	const __be32 *reg;
+	int ret, n;
+
+	np = to_of_node(fwnode);
+
+	if (!of_property_read_bool(np, "msi-controller"))
+		return 0;
+
+	n = of_property_count_elems_of_size(np, "mbi-ranges", sizeof(u32));
+	if (n <= 0 || n % 2)
+		return -EINVAL;
+
+	mbi_range_nr = n / 2;
+	mbi_ranges = kcalloc(mbi_range_nr, sizeof(*mbi_ranges), GFP_KERNEL);
+	if (!mbi_ranges)
+		return -ENOMEM;
+
+	for (n = 0; n < mbi_range_nr; n++) {
+		ret = of_property_read_u32_index(np, "mbi-ranges", n * 2,
+						 &mbi_ranges[n].spi_start);
+		if (ret)
+			goto err_free_mbi;
+		ret = of_property_read_u32_index(np, "mbi-ranges", n * 2 + 1,
+						 &mbi_ranges[n].nr_spis);
+		if (ret)
+			goto err_free_mbi;
+
+		mbi_ranges[n].bm = kcalloc(BITS_TO_LONGS(mbi_ranges[n].nr_spis),
+					   sizeof(long), GFP_KERNEL);
+		if (!mbi_ranges[n].bm) {
+			ret = -ENOMEM;
+			goto err_free_mbi;
+		}
+		pr_info("MBI range [%d:%d]\n", mbi_ranges[n].spi_start,
+			mbi_ranges[n].spi_start + mbi_ranges[n].nr_spis - 1);
+	}
+
+	reg = of_get_property(np, "mbi-alias", NULL);
+	if (reg) {
+		mbi_phys_base = of_translate_address(np, reg);
+		if (mbi_phys_base == OF_BAD_ADDR) {
+			ret = -ENXIO;
+			goto err_free_mbi;
+		}
+	} else {
+		struct resource res;
+
+		if (of_address_to_resource(np, 0, &res)) {
+			ret = -ENXIO;
+			goto err_free_mbi;
+		}
+
+		mbi_phys_base = res.start;
+	}
+
+	pr_info("Using MBI frame %pa\n", &mbi_phys_base);
+
+	ret = mbi_allocate_domains(parent);
+	if (ret)
+		goto err_free_mbi;
+
+	return 0;
+
+err_free_mbi:
+	if (mbi_ranges) {
+		for (n = 0; n < mbi_range_nr; n++)
+			kfree(mbi_ranges[n].bm);
+		kfree(mbi_ranges);
+	}
+
+	return ret;
+}
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e5d101418390..5a67ec084588 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1099,6 +1099,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 
 	gic_data.domain = irq_domain_create_tree(handle, &gic_irq_domain_ops,
 						 &gic_data);
+	irq_domain_update_bus_token(gic_data.domain, DOMAIN_BUS_WIRED);
 	gic_data.rdists.rdist = alloc_percpu(typeof(*gic_data.rdists.rdist));
 	gic_data.rdists.has_vlpis = true;
 	gic_data.rdists.has_direct_lpi = true;
@@ -1112,6 +1113,12 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	pr_info("Distributor has %sRange Selector support\n",
 		gic_data.has_rss ? "" : "no ");
 
+	if (typer & GICD_TYPER_MBIS) {
+		err = mbi_init(handle, gic_data.domain);
+		if (err)
+			pr_err("Failed to initialize MBIs\n");
+	}
+
 	set_handle_irq(gic_handle_irq);
 
 	gic_update_vlpi_properties();
diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index a59bdbc0b9bb..7b531fd075b8 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -63,11 +63,16 @@ static const struct meson_gpio_irq_params gxl_params = {
 	.nr_hwirq = 110,
 };
 
+static const struct meson_gpio_irq_params axg_params = {
+	.nr_hwirq = 100,
+};
+
 static const struct of_device_id meson_irq_gpio_matches[] = {
 	{ .compatible = "amlogic,meson8-gpio-intc", .data = &meson8_params },
 	{ .compatible = "amlogic,meson8b-gpio-intc", .data = &meson8b_params },
 	{ .compatible = "amlogic,meson-gxbb-gpio-intc", .data = &gxbb_params },
 	{ .compatible = "amlogic,meson-gxl-gpio-intc", .data = &gxl_params },
+	{ .compatible = "amlogic,meson-axg-gpio-intc", .data = &axg_params },
 	{ }
 };
 
diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gicp.c
index 17a4a7b6cdbb..4e17f7081efc 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -19,8 +19,6 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-#include "irq-mvebu-gicp.h"
-
 #define GICP_SETSPI_NSR_OFFSET	0x0
 #define GICP_CLRSPI_NSR_OFFSET	0x8
 
@@ -55,34 +53,18 @@ static int gicp_idx_to_spi(struct mvebu_gicp *gicp, int idx)
 	return -EINVAL;
 }
 
-int mvebu_gicp_get_doorbells(struct device_node *dn, phys_addr_t *setspi,
-			     phys_addr_t *clrspi)
-{
-	struct platform_device *pdev;
-	struct mvebu_gicp *gicp;
-
-	pdev = of_find_device_by_node(dn);
-	if (!pdev)
-		return -ENODEV;
-
-	gicp = platform_get_drvdata(pdev);
-	if (!gicp)
-		return -ENODEV;
-
-	*setspi = gicp->res->start + GICP_SETSPI_NSR_OFFSET;
-	*clrspi = gicp->res->start + GICP_CLRSPI_NSR_OFFSET;
-
-	return 0;
-}
-
 static void gicp_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct mvebu_gicp *gicp = data->chip_data;
 	phys_addr_t setspi = gicp->res->start + GICP_SETSPI_NSR_OFFSET;
-
-	msg->data = data->hwirq;
-	msg->address_lo = lower_32_bits(setspi);
-	msg->address_hi = upper_32_bits(setspi);
+	phys_addr_t clrspi = gicp->res->start + GICP_CLRSPI_NSR_OFFSET;
+
+	msg[0].data = data->hwirq;
+	msg[0].address_lo = lower_32_bits(setspi);
+	msg[0].address_hi = upper_32_bits(setspi);
+	msg[1].data = data->hwirq;
+	msg[1].address_lo = lower_32_bits(clrspi);
+	msg[1].address_hi = upper_32_bits(clrspi);
 }
 
 static struct irq_chip gicp_irq_chip = {
@@ -170,13 +152,15 @@ static const struct irq_domain_ops gicp_domain_ops = {
 static struct irq_chip gicp_msi_irq_chip = {
 	.name		= "GICP",
 	.irq_set_type	= irq_chip_set_type_parent,
+	.flags		= IRQCHIP_SUPPORTS_LEVEL_MSI,
 };
 
 static struct msi_domain_ops gicp_msi_ops = {
 };
 
 static struct msi_domain_info gicp_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_LEVEL_CAPABLE),
 	.ops	= &gicp_msi_ops,
 	.chip	= &gicp_msi_irq_chip,
 };
diff --git a/drivers/irqchip/irq-mvebu-gicp.h b/drivers/irqchip/irq-mvebu-gicp.h
deleted file mode 100644
index eaa12fb72102..000000000000
--- a/drivers/irqchip/irq-mvebu-gicp.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __MVEBU_GICP_H__
-#define __MVEBU_GICP_H__
-
-#include <linux/types.h>
-
-struct device_node;
-
-int mvebu_gicp_get_doorbells(struct device_node *dn, phys_addr_t *setspi,
-			     phys_addr_t *clrspi);
-
-#endif /* __MVEBU_GICP_H__ */
diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index e18c48d3a92e..13063339b416 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -21,8 +21,6 @@
 
 #include <dt-bindings/interrupt-controller/mvebu-icu.h>
 
-#include "irq-mvebu-gicp.h"
-
 /* ICU registers */
 #define ICU_SETSPI_NSR_AL	0x10
 #define ICU_SETSPI_NSR_AH	0x14
@@ -43,6 +41,7 @@ struct mvebu_icu {
 	void __iomem *base;
 	struct irq_domain *domain;
 	struct device *dev;
+	atomic_t initialized;
 };
 
 struct mvebu_icu_irq_data {
@@ -51,6 +50,18 @@ struct mvebu_icu_irq_data {
 	unsigned int type;
 };
 
+static void mvebu_icu_init(struct mvebu_icu *icu, struct msi_msg *msg)
+{
+	if (atomic_cmpxchg(&icu->initialized, false, true))
+		return;
+
+	/* Set Clear/Set ICU SPI message address in AP */
+	writel_relaxed(msg[0].address_hi, icu->base + ICU_SETSPI_NSR_AH);
+	writel_relaxed(msg[0].address_lo, icu->base + ICU_SETSPI_NSR_AL);
+	writel_relaxed(msg[1].address_hi, icu->base + ICU_CLRSPI_NSR_AH);
+	writel_relaxed(msg[1].address_lo, icu->base + ICU_CLRSPI_NSR_AL);
+}
+
 static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 {
 	struct irq_data *d = irq_get_irq_data(desc->irq);
@@ -59,6 +70,8 @@ static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 	unsigned int icu_int;
 
 	if (msg->address_lo || msg->address_hi) {
+		/* One off initialization */
+		mvebu_icu_init(icu, msg);
 		/* Configure the ICU with irq number & type */
 		icu_int = msg->data | ICU_INT_ENABLE;
 		if (icu_irqd->type & IRQ_TYPE_EDGE_RISING)
@@ -197,9 +210,7 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct device_node *gicp_dn;
 	struct resource *res;
-	phys_addr_t setspi, clrspi;
-	u32 i, icu_int;
-	int ret;
+	int i;
 
 	icu = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_icu),
 			   GFP_KERNEL);
@@ -242,22 +253,12 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 	if (!gicp_dn)
 		return -ENODEV;
 
-	ret = mvebu_gicp_get_doorbells(gicp_dn, &setspi, &clrspi);
-	if (ret)
-		return ret;
-
-	/* Set Clear/Set ICU SPI message address in AP */
-	writel_relaxed(upper_32_bits(setspi), icu->base + ICU_SETSPI_NSR_AH);
-	writel_relaxed(lower_32_bits(setspi), icu->base + ICU_SETSPI_NSR_AL);
-	writel_relaxed(upper_32_bits(clrspi), icu->base + ICU_CLRSPI_NSR_AH);
-	writel_relaxed(lower_32_bits(clrspi), icu->base + ICU_CLRSPI_NSR_AL);
-
 	/*
 	 * Clean all ICU interrupts with type SPI_NSR, required to
 	 * avoid unpredictable SPI assignments done by firmware.
 	 */
 	for (i = 0 ; i < ICU_MAX_IRQS ; i++) {
-		icu_int = readl(icu->base + ICU_INT_CFG(i));
+		u32 icu_int = readl_relaxed(icu->base + ICU_INT_CFG(i));
 		if ((icu_int >> ICU_GROUP_SHIFT) == ICU_GRP_NSR)
 			writel_relaxed(0x0, icu->base + ICU_INT_CFG(i));
 	}
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 36f0fbe36c35..5089c1e2838d 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -14,6 +14,9 @@
 #include <linux/irqdomain.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/syscore_ops.h>
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #define IRQS_PER_BANK 32
 
@@ -23,29 +26,69 @@ struct stm32_exti_bank {
 	u32 rtsr_ofst;
 	u32 ftsr_ofst;
 	u32 swier_ofst;
-	u32 pr_ofst;
+	u32 rpr_ofst;
+	u32 fpr_ofst;
+};
+
+#define UNDEF_REG ~0
+
+struct stm32_desc_irq {
+	u32 exti;
+	u32 irq_parent;
+};
+
+struct stm32_exti_drv_data {
+	const struct stm32_exti_bank **exti_banks;
+	const struct stm32_desc_irq *desc_irqs;
+	u32 bank_nr;
+	u32 irq_nr;
+};
+
+struct stm32_exti_chip_data {
+	struct stm32_exti_host_data *host_data;
+	const struct stm32_exti_bank *reg_bank;
+	struct raw_spinlock rlock;
+	u32 wake_active;
+	u32 mask_cache;
+	u32 rtsr_cache;
+	u32 ftsr_cache;
 };
 
+struct stm32_exti_host_data {
+	void __iomem *base;
+	struct stm32_exti_chip_data *chips_data;
+	const struct stm32_exti_drv_data *drv_data;
+};
+
+static struct stm32_exti_host_data *stm32_host_data;
+
 static const struct stm32_exti_bank stm32f4xx_exti_b1 = {
 	.imr_ofst	= 0x00,
 	.emr_ofst	= 0x04,
 	.rtsr_ofst	= 0x08,
 	.ftsr_ofst	= 0x0C,
 	.swier_ofst	= 0x10,
-	.pr_ofst	= 0x14,
+	.rpr_ofst	= 0x14,
+	.fpr_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank *stm32f4xx_exti_banks[] = {
 	&stm32f4xx_exti_b1,
 };
 
+static const struct stm32_exti_drv_data stm32f4xx_drv_data = {
+	.exti_banks = stm32f4xx_exti_banks,
+	.bank_nr = ARRAY_SIZE(stm32f4xx_exti_banks),
+};
+
 static const struct stm32_exti_bank stm32h7xx_exti_b1 = {
 	.imr_ofst	= 0x80,
 	.emr_ofst	= 0x84,
 	.rtsr_ofst	= 0x00,
 	.ftsr_ofst	= 0x04,
 	.swier_ofst	= 0x08,
-	.pr_ofst	= 0x88,
+	.rpr_ofst	= 0x88,
+	.fpr_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank stm32h7xx_exti_b2 = {
@@ -54,7 +97,8 @@ static const struct stm32_exti_bank stm32h7xx_exti_b2 = {
 	.rtsr_ofst	= 0x20,
 	.ftsr_ofst	= 0x24,
 	.swier_ofst	= 0x28,
-	.pr_ofst	= 0x98,
+	.rpr_ofst	= 0x98,
+	.fpr_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank stm32h7xx_exti_b3 = {
@@ -63,7 +107,8 @@ static const struct stm32_exti_bank stm32h7xx_exti_b3 = {
 	.rtsr_ofst	= 0x40,
 	.ftsr_ofst	= 0x44,
 	.swier_ofst	= 0x48,
-	.pr_ofst	= 0xA8,
+	.rpr_ofst	= 0xA8,
+	.fpr_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank *stm32h7xx_exti_banks[] = {
@@ -72,18 +117,105 @@ static const struct stm32_exti_bank *stm32h7xx_exti_banks[] = {
 	&stm32h7xx_exti_b3,
 };
 
-static unsigned long stm32_exti_pending(struct irq_chip_generic *gc)
+static const struct stm32_exti_drv_data stm32h7xx_drv_data = {
+	.exti_banks = stm32h7xx_exti_banks,
+	.bank_nr = ARRAY_SIZE(stm32h7xx_exti_banks),
+};
+
+static const struct stm32_exti_bank stm32mp1_exti_b1 = {
+	.imr_ofst	= 0x80,
+	.emr_ofst	= 0x84,
+	.rtsr_ofst	= 0x00,
+	.ftsr_ofst	= 0x04,
+	.swier_ofst	= 0x08,
+	.rpr_ofst	= 0x0C,
+	.fpr_ofst	= 0x10,
+};
+
+static const struct stm32_exti_bank stm32mp1_exti_b2 = {
+	.imr_ofst	= 0x90,
+	.emr_ofst	= 0x94,
+	.rtsr_ofst	= 0x20,
+	.ftsr_ofst	= 0x24,
+	.swier_ofst	= 0x28,
+	.rpr_ofst	= 0x2C,
+	.fpr_ofst	= 0x30,
+};
+
+static const struct stm32_exti_bank stm32mp1_exti_b3 = {
+	.imr_ofst	= 0xA0,
+	.emr_ofst	= 0xA4,
+	.rtsr_ofst	= 0x40,
+	.ftsr_ofst	= 0x44,
+	.swier_ofst	= 0x48,
+	.rpr_ofst	= 0x4C,
+	.fpr_ofst	= 0x50,
+};
+
+static const struct stm32_exti_bank *stm32mp1_exti_banks[] = {
+	&stm32mp1_exti_b1,
+	&stm32mp1_exti_b2,
+	&stm32mp1_exti_b3,
+};
+
+static const struct stm32_desc_irq stm32mp1_desc_irq[] = {
+	{ .exti = 1, .irq_parent = 7 },
+	{ .exti = 2, .irq_parent = 8 },
+	{ .exti = 3, .irq_parent = 9 },
+	{ .exti = 4, .irq_parent = 10 },
+	{ .exti = 5, .irq_parent = 23 },
+	{ .exti = 6, .irq_parent = 64 },
+	{ .exti = 7, .irq_parent = 65 },
+	{ .exti = 8, .irq_parent = 66 },
+	{ .exti = 9, .irq_parent = 67 },
+	{ .exti = 10, .irq_parent = 40 },
+	{ .exti = 11, .irq_parent = 42 },
+	{ .exti = 12, .irq_parent = 76 },
+	{ .exti = 13, .irq_parent = 77 },
+	{ .exti = 14, .irq_parent = 121 },
+	{ .exti = 15, .irq_parent = 127 },
+	{ .exti = 16, .irq_parent = 1 },
+	{ .exti = 65, .irq_parent = 144 },
+	{ .exti = 68, .irq_parent = 143 },
+	{ .exti = 73, .irq_parent = 129 },
+};
+
+static const struct stm32_exti_drv_data stm32mp1_drv_data = {
+	.exti_banks = stm32mp1_exti_banks,
+	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
+	.desc_irqs = stm32mp1_desc_irq,
+	.irq_nr = ARRAY_SIZE(stm32mp1_desc_irq),
+};
+
+static int stm32_exti_to_irq(const struct stm32_exti_drv_data *drv_data,
+			     irq_hw_number_t hwirq)
 {
-	const struct stm32_exti_bank *stm32_bank = gc->private;
+	const struct stm32_desc_irq *desc_irq;
+	int i;
 
-	return irq_reg_readl(gc, stm32_bank->pr_ofst);
+	if (!drv_data->desc_irqs)
+		return -EINVAL;
+
+	for (i = 0; i < drv_data->irq_nr; i++) {
+		desc_irq = &drv_data->desc_irqs[i];
+		if (desc_irq->exti == hwirq)
+			return desc_irq->irq_parent;
+	}
+
+	return -EINVAL;
 }
 
-static void stm32_exti_irq_ack(struct irq_chip_generic *gc, u32 mask)
+static unsigned long stm32_exti_pending(struct irq_chip_generic *gc)
 {
-	const struct stm32_exti_bank *stm32_bank = gc->private;
+	struct stm32_exti_chip_data *chip_data = gc->private;
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	unsigned long pending;
+
+	pending = irq_reg_readl(gc, stm32_bank->rpr_ofst);
+	if (stm32_bank->fpr_ofst != UNDEF_REG)
+		pending |= irq_reg_readl(gc, stm32_bank->fpr_ofst);
 
-	irq_reg_writel(gc, mask, stm32_bank->pr_ofst);
+	return pending;
 }
 
 static void stm32_irq_handler(struct irq_desc *desc)
@@ -92,7 +224,6 @@ static void stm32_irq_handler(struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int virq, nbanks = domain->gc->num_chips;
 	struct irq_chip_generic *gc;
-	const struct stm32_exti_bank *stm32_bank;
 	unsigned long pending;
 	int n, i, irq_base = 0;
 
@@ -100,13 +231,11 @@ static void stm32_irq_handler(struct irq_desc *desc)
 
 	for (i = 0; i < nbanks; i++, irq_base += IRQS_PER_BANK) {
 		gc = irq_get_domain_generic_chip(domain, irq_base);
-		stm32_bank = gc->private;
 
 		while ((pending = stm32_exti_pending(gc))) {
 			for_each_set_bit(n, &pending, IRQS_PER_BANK) {
 				virq = irq_find_mapping(domain, irq_base + n);
 				generic_handle_irq(virq);
-				stm32_exti_irq_ack(gc, BIT(n));
 			}
 		}
 	}
@@ -114,36 +243,50 @@ static void stm32_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static int stm32_irq_set_type(struct irq_data *data, unsigned int type)
+static int stm32_exti_set_type(struct irq_data *d,
+			       unsigned int type, u32 *rtsr, u32 *ftsr)
 {
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
-	const struct stm32_exti_bank *stm32_bank = gc->private;
-	int pin = data->hwirq % IRQS_PER_BANK;
-	u32 rtsr, ftsr;
-
-	irq_gc_lock(gc);
-
-	rtsr = irq_reg_readl(gc, stm32_bank->rtsr_ofst);
-	ftsr = irq_reg_readl(gc, stm32_bank->ftsr_ofst);
+	u32 mask = BIT(d->hwirq % IRQS_PER_BANK);
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
-		rtsr |= BIT(pin);
-		ftsr &= ~BIT(pin);
+		*rtsr |= mask;
+		*ftsr &= ~mask;
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
-		rtsr &= ~BIT(pin);
-		ftsr |= BIT(pin);
+		*rtsr &= ~mask;
+		*ftsr |= mask;
 		break;
 	case IRQ_TYPE_EDGE_BOTH:
-		rtsr |= BIT(pin);
-		ftsr |= BIT(pin);
+		*rtsr |= mask;
+		*ftsr |= mask;
 		break;
 	default:
-		irq_gc_unlock(gc);
 		return -EINVAL;
 	}
 
+	return 0;
+}
+
+static int stm32_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct stm32_exti_chip_data *chip_data = gc->private;
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	u32 rtsr, ftsr;
+	int err;
+
+	irq_gc_lock(gc);
+
+	rtsr = irq_reg_readl(gc, stm32_bank->rtsr_ofst);
+	ftsr = irq_reg_readl(gc, stm32_bank->ftsr_ofst);
+
+	err = stm32_exti_set_type(d, type, &rtsr, &ftsr);
+	if (err) {
+		irq_gc_unlock(gc);
+		return err;
+	}
+
 	irq_reg_writel(gc, rtsr, stm32_bank->rtsr_ofst);
 	irq_reg_writel(gc, ftsr, stm32_bank->ftsr_ofst);
 
@@ -152,40 +295,59 @@ static int stm32_irq_set_type(struct irq_data *data, unsigned int type)
 	return 0;
 }
 
-static int stm32_irq_set_wake(struct irq_data *data, unsigned int on)
+static void stm32_chip_suspend(struct stm32_exti_chip_data *chip_data,
+			       u32 wake_active)
 {
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
-	const struct stm32_exti_bank *stm32_bank = gc->private;
-	int pin = data->hwirq % IRQS_PER_BANK;
-	u32 imr;
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	void __iomem *base = chip_data->host_data->base;
 
-	irq_gc_lock(gc);
+	/* save rtsr, ftsr registers */
+	chip_data->rtsr_cache = readl_relaxed(base + stm32_bank->rtsr_ofst);
+	chip_data->ftsr_cache = readl_relaxed(base + stm32_bank->ftsr_ofst);
 
-	imr = irq_reg_readl(gc, stm32_bank->imr_ofst);
-	if (on)
-		imr |= BIT(pin);
-	else
-		imr &= ~BIT(pin);
-	irq_reg_writel(gc, imr, stm32_bank->imr_ofst);
+	writel_relaxed(wake_active, base + stm32_bank->imr_ofst);
+}
+
+static void stm32_chip_resume(struct stm32_exti_chip_data *chip_data,
+			      u32 mask_cache)
+{
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	void __iomem *base = chip_data->host_data->base;
+
+	/* restore rtsr, ftsr, registers */
+	writel_relaxed(chip_data->rtsr_cache, base + stm32_bank->rtsr_ofst);
+	writel_relaxed(chip_data->ftsr_cache, base + stm32_bank->ftsr_ofst);
 
+	writel_relaxed(mask_cache, base + stm32_bank->imr_ofst);
+}
+
+static void stm32_irq_suspend(struct irq_chip_generic *gc)
+{
+	struct stm32_exti_chip_data *chip_data = gc->private;
+
+	irq_gc_lock(gc);
+	stm32_chip_suspend(chip_data, gc->wake_active);
 	irq_gc_unlock(gc);
+}
 
-	return 0;
+static void stm32_irq_resume(struct irq_chip_generic *gc)
+{
+	struct stm32_exti_chip_data *chip_data = gc->private;
+
+	irq_gc_lock(gc);
+	stm32_chip_resume(chip_data, gc->mask_cache);
+	irq_gc_unlock(gc);
 }
 
 static int stm32_exti_alloc(struct irq_domain *d, unsigned int virq,
 			    unsigned int nr_irqs, void *data)
 {
-	struct irq_chip_generic *gc;
 	struct irq_fwspec *fwspec = data;
 	irq_hw_number_t hwirq;
 
 	hwirq = fwspec->param[0];
-	gc = irq_get_domain_generic_chip(d, hwirq);
 
 	irq_map_generic_chip(d, virq, hwirq);
-	irq_domain_set_info(d, virq, hwirq, &gc->chip_types->chip, gc,
-			    handle_simple_irq, NULL, NULL);
 
 	return 0;
 }
@@ -198,30 +360,318 @@ static void stm32_exti_free(struct irq_domain *d, unsigned int virq,
 	irq_domain_reset_irq_data(data);
 }
 
-struct irq_domain_ops irq_exti_domain_ops = {
+static const struct irq_domain_ops irq_exti_domain_ops = {
 	.map	= irq_map_generic_chip,
-	.xlate	= irq_domain_xlate_onetwocell,
 	.alloc  = stm32_exti_alloc,
 	.free	= stm32_exti_free,
 };
 
-static int
-__init stm32_exti_init(const struct stm32_exti_bank **stm32_exti_banks,
-		       int bank_nr, struct device_node *node)
+static void stm32_irq_ack(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct stm32_exti_chip_data *chip_data = gc->private;
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+
+	irq_gc_lock(gc);
+
+	irq_reg_writel(gc, d->mask, stm32_bank->rpr_ofst);
+	if (stm32_bank->fpr_ofst != UNDEF_REG)
+		irq_reg_writel(gc, d->mask, stm32_bank->fpr_ofst);
+
+	irq_gc_unlock(gc);
+}
+
+static inline u32 stm32_exti_set_bit(struct irq_data *d, u32 reg)
 {
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	void __iomem *base = chip_data->host_data->base;
+	u32 val;
+
+	val = readl_relaxed(base + reg);
+	val |= BIT(d->hwirq % IRQS_PER_BANK);
+	writel_relaxed(val, base + reg);
+
+	return val;
+}
+
+static inline u32 stm32_exti_clr_bit(struct irq_data *d, u32 reg)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	void __iomem *base = chip_data->host_data->base;
+	u32 val;
+
+	val = readl_relaxed(base + reg);
+	val &= ~BIT(d->hwirq % IRQS_PER_BANK);
+	writel_relaxed(val, base + reg);
+
+	return val;
+}
+
+static void stm32_exti_h_eoi(struct irq_data *d)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+
+	raw_spin_lock(&chip_data->rlock);
+
+	stm32_exti_set_bit(d, stm32_bank->rpr_ofst);
+	if (stm32_bank->fpr_ofst != UNDEF_REG)
+		stm32_exti_set_bit(d, stm32_bank->fpr_ofst);
+
+	raw_spin_unlock(&chip_data->rlock);
+
+	if (d->parent_data->chip)
+		irq_chip_eoi_parent(d);
+}
+
+static void stm32_exti_h_mask(struct irq_data *d)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+
+	raw_spin_lock(&chip_data->rlock);
+	chip_data->mask_cache = stm32_exti_clr_bit(d, stm32_bank->imr_ofst);
+	raw_spin_unlock(&chip_data->rlock);
+
+	if (d->parent_data->chip)
+		irq_chip_mask_parent(d);
+}
+
+static void stm32_exti_h_unmask(struct irq_data *d)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+
+	raw_spin_lock(&chip_data->rlock);
+	chip_data->mask_cache = stm32_exti_set_bit(d, stm32_bank->imr_ofst);
+	raw_spin_unlock(&chip_data->rlock);
+
+	if (d->parent_data->chip)
+		irq_chip_unmask_parent(d);
+}
+
+static int stm32_exti_h_set_type(struct irq_data *d, unsigned int type)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	void __iomem *base = chip_data->host_data->base;
+	u32 rtsr, ftsr;
+	int err;
+
+	raw_spin_lock(&chip_data->rlock);
+	rtsr = readl_relaxed(base + stm32_bank->rtsr_ofst);
+	ftsr = readl_relaxed(base + stm32_bank->ftsr_ofst);
+
+	err = stm32_exti_set_type(d, type, &rtsr, &ftsr);
+	if (err) {
+		raw_spin_unlock(&chip_data->rlock);
+		return err;
+	}
+
+	writel_relaxed(rtsr, base + stm32_bank->rtsr_ofst);
+	writel_relaxed(ftsr, base + stm32_bank->ftsr_ofst);
+	raw_spin_unlock(&chip_data->rlock);
+
+	return 0;
+}
+
+static int stm32_exti_h_set_wake(struct irq_data *d, unsigned int on)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	u32 mask = BIT(d->hwirq % IRQS_PER_BANK);
+
+	raw_spin_lock(&chip_data->rlock);
+
+	if (on)
+		chip_data->wake_active |= mask;
+	else
+		chip_data->wake_active &= ~mask;
+
+	raw_spin_unlock(&chip_data->rlock);
+
+	return 0;
+}
+
+static int stm32_exti_h_set_affinity(struct irq_data *d,
+				     const struct cpumask *dest, bool force)
+{
+	if (d->parent_data->chip)
+		return irq_chip_set_affinity_parent(d, dest, force);
+
+	return -EINVAL;
+}
+
+#ifdef CONFIG_PM
+static int stm32_exti_h_suspend(void)
+{
+	struct stm32_exti_chip_data *chip_data;
+	int i;
+
+	for (i = 0; i < stm32_host_data->drv_data->bank_nr; i++) {
+		chip_data = &stm32_host_data->chips_data[i];
+		raw_spin_lock(&chip_data->rlock);
+		stm32_chip_suspend(chip_data, chip_data->wake_active);
+		raw_spin_unlock(&chip_data->rlock);
+	}
+
+	return 0;
+}
+
+static void stm32_exti_h_resume(void)
+{
+	struct stm32_exti_chip_data *chip_data;
+	int i;
+
+	for (i = 0; i < stm32_host_data->drv_data->bank_nr; i++) {
+		chip_data = &stm32_host_data->chips_data[i];
+		raw_spin_lock(&chip_data->rlock);
+		stm32_chip_resume(chip_data, chip_data->mask_cache);
+		raw_spin_unlock(&chip_data->rlock);
+	}
+}
+
+static struct syscore_ops stm32_exti_h_syscore_ops = {
+	.suspend	= stm32_exti_h_suspend,
+	.resume		= stm32_exti_h_resume,
+};
+
+static void stm32_exti_h_syscore_init(void)
+{
+	register_syscore_ops(&stm32_exti_h_syscore_ops);
+}
+#else
+static inline void stm32_exti_h_syscore_init(void) {}
+#endif
+
+static struct irq_chip stm32_exti_h_chip = {
+	.name			= "stm32-exti-h",
+	.irq_eoi		= stm32_exti_h_eoi,
+	.irq_mask		= stm32_exti_h_mask,
+	.irq_unmask		= stm32_exti_h_unmask,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_type		= stm32_exti_h_set_type,
+	.irq_set_wake		= stm32_exti_h_set_wake,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= stm32_exti_h_set_affinity,
+#endif
+};
+
+static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
+				     unsigned int virq,
+				     unsigned int nr_irqs, void *data)
+{
+	struct stm32_exti_host_data *host_data = dm->host_data;
+	struct stm32_exti_chip_data *chip_data;
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec p_fwspec;
+	irq_hw_number_t hwirq;
+	int p_irq, bank;
+
+	hwirq = fwspec->param[0];
+	bank  = hwirq / IRQS_PER_BANK;
+	chip_data = &host_data->chips_data[bank];
+
+	irq_domain_set_hwirq_and_chip(dm, virq, hwirq,
+				      &stm32_exti_h_chip, chip_data);
+
+	p_irq = stm32_exti_to_irq(host_data->drv_data, hwirq);
+	if (p_irq >= 0) {
+		p_fwspec.fwnode = dm->parent->fwnode;
+		p_fwspec.param_count = 3;
+		p_fwspec.param[0] = GIC_SPI;
+		p_fwspec.param[1] = p_irq;
+		p_fwspec.param[2] = IRQ_TYPE_LEVEL_HIGH;
+
+		return irq_domain_alloc_irqs_parent(dm, virq, 1, &p_fwspec);
+	}
+
+	return 0;
+}
+
+static struct
+stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
+					   struct device_node *node)
+{
+	struct stm32_exti_host_data *host_data;
+
+	host_data = kzalloc(sizeof(*host_data), GFP_KERNEL);
+	if (!host_data)
+		return NULL;
+
+	host_data->drv_data = dd;
+	host_data->chips_data = kcalloc(dd->bank_nr,
+					sizeof(struct stm32_exti_chip_data),
+					GFP_KERNEL);
+	if (!host_data->chips_data)
+		return NULL;
+
+	host_data->base = of_iomap(node, 0);
+	if (!host_data->base) {
+		pr_err("%pOF: Unable to map registers\n", node);
+		return NULL;
+	}
+
+	stm32_host_data = host_data;
+
+	return host_data;
+}
+
+static struct
+stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
+					   u32 bank_idx,
+					   struct device_node *node)
+{
+	const struct stm32_exti_bank *stm32_bank;
+	struct stm32_exti_chip_data *chip_data;
+	void __iomem *base = h_data->base;
+	u32 irqs_mask;
+
+	stm32_bank = h_data->drv_data->exti_banks[bank_idx];
+	chip_data = &h_data->chips_data[bank_idx];
+	chip_data->host_data = h_data;
+	chip_data->reg_bank = stm32_bank;
+
+	raw_spin_lock_init(&chip_data->rlock);
+
+	/* Determine number of irqs supported */
+	writel_relaxed(~0UL, base + stm32_bank->rtsr_ofst);
+	irqs_mask = readl_relaxed(base + stm32_bank->rtsr_ofst);
+
+	/*
+	 * This IP has no reset, so after hot reboot we should
+	 * clear registers to avoid residue
+	 */
+	writel_relaxed(0, base + stm32_bank->imr_ofst);
+	writel_relaxed(0, base + stm32_bank->emr_ofst);
+	writel_relaxed(0, base + stm32_bank->rtsr_ofst);
+	writel_relaxed(0, base + stm32_bank->ftsr_ofst);
+	writel_relaxed(~0UL, base + stm32_bank->rpr_ofst);
+	if (stm32_bank->fpr_ofst != UNDEF_REG)
+		writel_relaxed(~0UL, base + stm32_bank->fpr_ofst);
+
+	pr_info("%s: bank%d, External IRQs available:%#x\n",
+		node->full_name, bank_idx, irqs_mask);
+
+	return chip_data;
+}
+
+static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
+				  struct device_node *node)
+{
+	struct stm32_exti_host_data *host_data;
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
-	int nr_irqs, nr_exti, ret, i;
+	int nr_irqs, ret, i;
 	struct irq_chip_generic *gc;
 	struct irq_domain *domain;
-	void *base;
 
-	base = of_iomap(node, 0);
-	if (!base) {
-		pr_err("%pOF: Unable to map registers\n", node);
-		return -ENOMEM;
+	host_data = stm32_exti_host_init(drv_data, node);
+	if (!host_data) {
+		ret = -ENOMEM;
+		goto out_free_mem;
 	}
 
-	domain = irq_domain_add_linear(node, bank_nr * IRQS_PER_BANK,
+	domain = irq_domain_add_linear(node, drv_data->bank_nr * IRQS_PER_BANK,
 				       &irq_exti_domain_ops, NULL);
 	if (!domain) {
 		pr_err("%s: Could not register interrupt domain.\n",
@@ -234,44 +684,32 @@ __init stm32_exti_init(const struct stm32_exti_bank **stm32_exti_banks,
 					     handle_edge_irq, clr, 0, 0);
 	if (ret) {
 		pr_err("%pOF: Could not allocate generic interrupt chip.\n",
-			node);
+		       node);
 		goto out_free_domain;
 	}
 
-	for (i = 0; i < bank_nr; i++) {
-		const struct stm32_exti_bank *stm32_bank = stm32_exti_banks[i];
-		u32 irqs_mask;
+	for (i = 0; i < drv_data->bank_nr; i++) {
+		const struct stm32_exti_bank *stm32_bank;
+		struct stm32_exti_chip_data *chip_data;
+
+		stm32_bank = drv_data->exti_banks[i];
+		chip_data = stm32_exti_chip_init(host_data, i, node);
 
 		gc = irq_get_domain_generic_chip(domain, i * IRQS_PER_BANK);
 
-		gc->reg_base = base;
+		gc->reg_base = host_data->base;
 		gc->chip_types->type = IRQ_TYPE_EDGE_BOTH;
-		gc->chip_types->chip.irq_ack = irq_gc_ack_set_bit;
+		gc->chip_types->chip.irq_ack = stm32_irq_ack;
 		gc->chip_types->chip.irq_mask = irq_gc_mask_clr_bit;
 		gc->chip_types->chip.irq_unmask = irq_gc_mask_set_bit;
 		gc->chip_types->chip.irq_set_type = stm32_irq_set_type;
-		gc->chip_types->chip.irq_set_wake = stm32_irq_set_wake;
-		gc->chip_types->regs.ack = stm32_bank->pr_ofst;
+		gc->chip_types->chip.irq_set_wake = irq_gc_set_wake;
+		gc->suspend = stm32_irq_suspend;
+		gc->resume = stm32_irq_resume;
+		gc->wake_enabled = IRQ_MSK(IRQS_PER_BANK);
+
 		gc->chip_types->regs.mask = stm32_bank->imr_ofst;
-		gc->private = (void *)stm32_bank;
-
-		/* Determine number of irqs supported */
-		writel_relaxed(~0UL, base + stm32_bank->rtsr_ofst);
-		irqs_mask = readl_relaxed(base + stm32_bank->rtsr_ofst);
-		nr_exti = fls(readl_relaxed(base + stm32_bank->rtsr_ofst));
-
-		/*
-		 * This IP has no reset, so after hot reboot we should
-		 * clear registers to avoid residue
-		 */
-		writel_relaxed(0, base + stm32_bank->imr_ofst);
-		writel_relaxed(0, base + stm32_bank->emr_ofst);
-		writel_relaxed(0, base + stm32_bank->rtsr_ofst);
-		writel_relaxed(0, base + stm32_bank->ftsr_ofst);
-		writel_relaxed(~0UL, base + stm32_bank->pr_ofst);
-
-		pr_info("%s: bank%d, External IRQs available:%#x\n",
-			node->full_name, i, irqs_mask);
+		gc->private = (void *)chip_data;
 	}
 
 	nr_irqs = of_irq_count(node);
@@ -287,15 +725,69 @@ __init stm32_exti_init(const struct stm32_exti_bank **stm32_exti_banks,
 out_free_domain:
 	irq_domain_remove(domain);
 out_unmap:
-	iounmap(base);
+	iounmap(host_data->base);
+out_free_mem:
+	kfree(host_data->chips_data);
+	kfree(host_data);
+	return ret;
+}
+
+static const struct irq_domain_ops stm32_exti_h_domain_ops = {
+	.alloc	= stm32_exti_h_domain_alloc,
+	.free	= irq_domain_free_irqs_common,
+};
+
+static int
+__init stm32_exti_hierarchy_init(const struct stm32_exti_drv_data *drv_data,
+				 struct device_node *node,
+				 struct device_node *parent)
+{
+	struct irq_domain *parent_domain, *domain;
+	struct stm32_exti_host_data *host_data;
+	int ret, i;
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("interrupt-parent not found\n");
+		return -EINVAL;
+	}
+
+	host_data = stm32_exti_host_init(drv_data, node);
+	if (!host_data) {
+		ret = -ENOMEM;
+		goto out_free_mem;
+	}
+
+	for (i = 0; i < drv_data->bank_nr; i++)
+		stm32_exti_chip_init(host_data, i, node);
+
+	domain = irq_domain_add_hierarchy(parent_domain, 0,
+					  drv_data->bank_nr * IRQS_PER_BANK,
+					  node, &stm32_exti_h_domain_ops,
+					  host_data);
+
+	if (!domain) {
+		pr_err("%s: Could not register exti domain.\n", node->name);
+		ret = -ENOMEM;
+		goto out_unmap;
+	}
+
+	stm32_exti_h_syscore_init();
+
+	return 0;
+
+out_unmap:
+	iounmap(host_data->base);
+out_free_mem:
+	kfree(host_data->chips_data);
+	kfree(host_data);
 	return ret;
 }
 
 static int __init stm32f4_exti_of_init(struct device_node *np,
 				       struct device_node *parent)
 {
-	return stm32_exti_init(stm32f4xx_exti_banks,
-			ARRAY_SIZE(stm32f4xx_exti_banks), np);
+	return stm32_exti_init(&stm32f4xx_drv_data, np);
 }
 
 IRQCHIP_DECLARE(stm32f4_exti, "st,stm32-exti", stm32f4_exti_of_init);
@@ -303,8 +795,15 @@ IRQCHIP_DECLARE(stm32f4_exti, "st,stm32-exti", stm32f4_exti_of_init);
 static int __init stm32h7_exti_of_init(struct device_node *np,
 				       struct device_node *parent)
 {
-	return stm32_exti_init(stm32h7xx_exti_banks,
-			ARRAY_SIZE(stm32h7xx_exti_banks), np);
+	return stm32_exti_init(&stm32h7xx_drv_data, np);
 }
 
 IRQCHIP_DECLARE(stm32h7_exti, "st,stm32h7-exti", stm32h7_exti_of_init);
+
+static int __init stm32mp1_exti_of_init(struct device_node *np,
+					struct device_node *parent)
+{
+	return stm32_exti_hierarchy_init(&stm32mp1_drv_data, np, parent);
+}
+
+IRQCHIP_DECLARE(stm32mp1_exti, "st,stm32mp1-exti", stm32mp1_exti_of_init);
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 30250631efe7..f45b74fcc059 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1434,6 +1434,9 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 {
 	struct irq_domain *domain;
 
+	if (WARN_ON(info->flags & MSI_FLAG_LEVEL_CAPABLE))
+		info->flags &= ~MSI_FLAG_LEVEL_CAPABLE;
+
 	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
 		pci_msi_domain_update_dom_ops(info);
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 6cbcff42ba47..dfed60982a8a 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -267,12 +267,13 @@ static void stm32_gpio_irq_release_resources(struct irq_data *irq_data)
 }
 
 static struct irq_chip stm32_gpio_irq_chip = {
-	.name           = "stm32gpio",
-	.irq_ack       = irq_chip_ack_parent,
-	.irq_mask       = irq_chip_mask_parent,
-	.irq_unmask     = irq_chip_unmask_parent,
-	.irq_set_type   = irq_chip_set_type_parent,
-	.irq_set_wake   = irq_chip_set_wake_parent,
+	.name		= "stm32gpio",
+	.irq_eoi	= irq_chip_eoi_parent,
+	.irq_ack	= irq_chip_ack_parent,
+	.irq_mask	= irq_chip_mask_parent,
+	.irq_unmask	= irq_chip_unmask_parent,
+	.irq_set_type	= irq_chip_set_type_parent,
+	.irq_set_wake	= irq_chip_set_wake_parent,
 	.irq_request_resources = stm32_gpio_irq_request_resources,
 	.irq_release_resources = stm32_gpio_irq_release_resources,
 };
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 92f20832fd28..e8ca5e654277 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -17,6 +17,7 @@
 #define __DMA_IOMMU_H
 
 #ifdef __KERNEL__
+#include <linux/types.h>
 #include <asm/errno.h>
 
 #ifdef CONFIG_IOMMU_DMA
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 5426627f9c55..eeceac3376fc 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -432,11 +432,18 @@ extern bool force_irqthreads;
 #define force_irqthreads	(0)
 #endif
 
-#ifndef __ARCH_SET_SOFTIRQ_PENDING
-#define set_softirq_pending(x) (local_softirq_pending() = (x))
-#define or_softirq_pending(x)  (local_softirq_pending() |= (x))
+#ifndef local_softirq_pending
+
+#ifndef local_softirq_pending_ref
+#define local_softirq_pending_ref irq_stat.__softirq_pending
 #endif
 
+#define local_softirq_pending()	(__this_cpu_read(local_softirq_pending_ref))
+#define set_softirq_pending(x)	(__this_cpu_write(local_softirq_pending_ref, (x)))
+#define or_softirq_pending(x)	(__this_cpu_or(local_softirq_pending_ref, (x)))
+
+#endif /* local_softirq_pending */
+
 /* Some architectures might implement lazy enabling/disabling of
  * interrupts. In some cases, such as stop_machine, we might want
  * to ensure that after a local_irq_disable(), interrupts have
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 65916a305f3d..b2067083aa94 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -512,6 +512,7 @@ enum {
 	IRQCHIP_SKIP_SET_WAKE		= (1 <<  4),
 	IRQCHIP_ONESHOT_SAFE		= (1 <<  5),
 	IRQCHIP_EOI_THREADED		= (1 <<  6),
+	IRQCHIP_SUPPORTS_LEVEL_MSI	= (1 <<  7),
 };
 
 #include <linux/irqdesc.h>
diff --git a/include/linux/irq_cpustat.h b/include/linux/irq_cpustat.h
index 4954948d1973..6e8895cd4d92 100644
--- a/include/linux/irq_cpustat.h
+++ b/include/linux/irq_cpustat.h
@@ -18,15 +18,11 @@
  */
 
 #ifndef __ARCH_IRQ_STAT
-extern irq_cpustat_t irq_stat[];		/* defined in asm/hardirq.h */
-#define __IRQ_STAT(cpu, member)	(irq_stat[cpu].member)
+DECLARE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);	/* defined in asm/hardirq.h */
+#define __IRQ_STAT(cpu, member)	(per_cpu(irq_stat.member, cpu))
 #endif
 
-  /* arch independent irq_stat fields */
-#define local_softirq_pending() \
-	__IRQ_STAT(smp_processor_id(), __softirq_pending)
-
-  /* arch dependent irq_stat fields */
+/* arch dependent irq_stat fields */
 #define nmi_count(cpu)		__IRQ_STAT((cpu), __nmi_count)	/* i386 */
 
 #endif	/* __irq_cpustat_h */
diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
index 0380d899b955..630a57e55db6 100644
--- a/include/linux/irq_sim.h
+++ b/include/linux/irq_sim.h
@@ -1,14 +1,11 @@
-#ifndef _LINUX_IRQ_SIM_H
-#define _LINUX_IRQ_SIM_H
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright (C) 2017 Bartosz Golaszewski <brgl@bgdev.pl>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
+ * Copyright (C) 2017-2018 Bartosz Golaszewski <brgl@bgdev.pl>
  */
 
+#ifndef _LINUX_IRQ_SIM_H
+#define _LINUX_IRQ_SIM_H
+
 #include <linux/irq_work.h>
 #include <linux/device.h>
 
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index f5af3b594e6e..cbb872c1b607 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -587,6 +587,7 @@ struct fwnode_handle;
 int its_cpu_init(void);
 int its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	     struct irq_domain *domain);
+int mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent);
 
 static inline bool gic_enable_sre(void)
 {
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 48c7e86bb556..dccfa65aee96 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -301,7 +301,13 @@ static inline struct irq_domain *irq_find_matching_host(struct device_node *node
 
 static inline struct irq_domain *irq_find_host(struct device_node *node)
 {
-	return irq_find_matching_host(node, DOMAIN_BUS_ANY);
+	struct irq_domain *d;
+
+	d = irq_find_matching_host(node, DOMAIN_BUS_WIRED);
+	if (!d)
+		d = irq_find_matching_host(node, DOMAIN_BUS_ANY);
+
+	return d;
 }
 
 /**
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 1f1bbb5b4679..5839d8062dfc 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -289,6 +289,8 @@ enum {
 	 * MSI_FLAG_ACTIVATE_EARLY has been set.
 	 */
 	MSI_FLAG_MUST_REACTIVATE	= (1 << 5),
+	/* Is level-triggered capable, using two messages */
+	MSI_FLAG_LEVEL_CAPABLE		= (1 << 6),
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index fc4f361a86bb..dd20d0d528d4 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -1,11 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2017 Bartosz Golaszewski <brgl@bgdev.pl>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
+ * Copyright (C) 2017-2018 Bartosz Golaszewski <brgl@bgdev.pl>
  */
 
 #include <linux/slab.h>
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 2a8571f72b17..4ca2fd46645d 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -76,6 +76,19 @@ static inline void irq_chip_write_msi_msg(struct irq_data *data,
 	data->chip->irq_write_msi_msg(data, msg);
 }
 
+static void msi_check_level(struct irq_domain *domain, struct msi_msg *msg)
+{
+	struct msi_domain_info *info = domain->host_data;
+
+	/*
+	 * If the MSI provider has messed with the second message and
+	 * not advertized that it is level-capable, signal the breakage.
+	 */
+	WARN_ON(!((info->flags & MSI_FLAG_LEVEL_CAPABLE) &&
+		  (info->chip->flags & IRQCHIP_SUPPORTS_LEVEL_MSI)) &&
+		(msg[1].address_lo || msg[1].address_hi || msg[1].data));
+}
+
 /**
  * msi_domain_set_affinity - Generic affinity setter function for MSI domains
  * @irq_data:	The irq data associated to the interrupt
@@ -89,13 +102,14 @@ int msi_domain_set_affinity(struct irq_data *irq_data,
 			    const struct cpumask *mask, bool force)
 {
 	struct irq_data *parent = irq_data->parent_data;
-	struct msi_msg msg;
+	struct msi_msg msg[2] = { [1] = { }, };
 	int ret;
 
 	ret = parent->chip->irq_set_affinity(parent, mask, force);
 	if (ret >= 0 && ret != IRQ_SET_MASK_OK_DONE) {
-		BUG_ON(irq_chip_compose_msi_msg(irq_data, &msg));
-		irq_chip_write_msi_msg(irq_data, &msg);
+		BUG_ON(irq_chip_compose_msi_msg(irq_data, msg));
+		msi_check_level(irq_data->domain, msg);
+		irq_chip_write_msi_msg(irq_data, msg);
 	}
 
 	return ret;
@@ -104,20 +118,21 @@ int msi_domain_set_affinity(struct irq_data *irq_data,
 static int msi_domain_activate(struct irq_domain *domain,
 			       struct irq_data *irq_data, bool early)
 {
-	struct msi_msg msg;
+	struct msi_msg msg[2] = { [1] = { }, };
 
-	BUG_ON(irq_chip_compose_msi_msg(irq_data, &msg));
-	irq_chip_write_msi_msg(irq_data, &msg);
+	BUG_ON(irq_chip_compose_msi_msg(irq_data, msg));
+	msi_check_level(irq_data->domain, msg);
+	irq_chip_write_msi_msg(irq_data, msg);
 	return 0;
 }
 
 static void msi_domain_deactivate(struct irq_domain *domain,
 				  struct irq_data *irq_data)
 {
-	struct msi_msg msg;
+	struct msi_msg msg[2];
 
-	memset(&msg, 0, sizeof(msg));
-	irq_chip_write_msi_msg(irq_data, &msg);
+	memset(msg, 0, sizeof(msg));
+	irq_chip_write_msi_msg(irq_data, msg);
 }
 
 static int msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 177de3640c78..c5fafd792df1 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -49,8 +49,8 @@
  */
 
 #ifndef __ARCH_IRQ_STAT
-irq_cpustat_t irq_stat[NR_CPUS] ____cacheline_aligned;
-EXPORT_SYMBOL(irq_stat);
+DEFINE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);
+EXPORT_PER_CPU_SYMBOL(irq_stat);
 #endif
 
 static struct softirq_action softirq_vec[NR_SOFTIRQS] __cacheline_aligned_in_smp;
--8323329-644893481-1528105479=:2646--
