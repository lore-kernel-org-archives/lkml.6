Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932094AbeDCMEC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 08:04:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59399 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755300AbeDCMD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 08:03:59 -0400
Date: Tue, 3 Apr 2018 14:03:56 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] irq updates for 4.17
Message-ID: <alpine.DEB.2.21.1804031349110.2511@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1435544939-1522757037=:2511"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1435544939-1522757037=:2511
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Linus,

please pull the latest irq-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-for-linus

The usual pile of boring changes:

 - Consolidate tasklet functions to share code instead of duplicating it

 - The first step for making the low level entry handler management on
   multi-platform kernels generic

 - A new sysfs file which allows to retrieve the wakeup state of
   interrupts.

 - Ensure that the interrupt thread follows the effective affinity and not
   the programmed affinity to avoid cross core wakeups.

 - Two new interrupt controller drivers (Microsemi Ocelot and Qualcomm PDC)

 - Fix the wakeup path clock handling for Reneasas interrupt chips.

 - Rework the boot time register reset for ARM GIC-V2/3

 - Better suspend/resume support for ARM GIV-V3/ITS
 
 - Add missing locking to the ARM GIC set_type() callback

 - Small fixes for the irq simulator code

 - SPDX identifiers for the irq core code and removal of boiler plate

 - Small cleanups all over the place

Thanks,

	tglx

------------------>
Alexandre Belloni (2):
      dt-bindings: interrupt-controller: Add binding for the Microsemi Ocelot interrupt controller
      irqchip: Add a driver for the Microsemi Ocelot controller

Andy Shevchenko (1):
      genirq: Add wakeup sysfs node to show IRQ wakeup state

Aniruddha Banerjee (1):
      irqchip/gic: Take lock when updating irq type

Archana Sathyakumar (2):
      irqchip/pdc: Add PDC interrupt controller for QCOM SoCs
      dt-bindings/interrupt-controller: pdc: Describe PDC device binding

Bartosz Golaszewski (3):
      genirq/irq_sim: Explicitly include slab.h
      genirq/irq_sim: Check the return value of irq_sim_init() for error codes
      genirq/irq_sim: Return the base of the irq range from irq_sim_init()

Davidlohr Bueso (1):
      irqchip/gic: Update supports_deactivate static key to modern api

Derek Basehore (2):
      irqchip/gic-v3-its: Add ability to save/restore ITS state
      irqchip/gic-v3-its: Add ability to resend MAPC on resume

Geert Uytterhoeven (2):
      irqchip/renesas-intc-irqpin: Use wakeup_path i.s.o. explicit clock handling
      irqchip/renesas-irqc: Use wakeup_path i.s.o. explicit clock handling

Ingo Molnar (2):
      softirq: Consolidate common code in __tasklet_[hi]_schedule()
      softirq: Consolidate common code in tasklet_[hi]_action()

Marc Zyngier (8):
      irqchip/gic-v2: Reset APRn registers at boot time
      irqchip/gic-v3: Reset APgRn registers at boot time
      irqchip/gic-v3: Allow LPIs to be disabled from the command line
      irqchip/gic: Loudly complain about the use of IRQ_TYPE_NONE
      irqchip/gic-v3: Loudly complain about the use of IRQ_TYPE_NONE
      irqchip/gic-v3: Do not check trigger configuration of partitionned LPIs
      irqchip/gic-v3: Don't try to reset AP0Rn
      irqchip/gic-v3: Probe for SCR_EL3 being clear before resetting AP0Rn

Palmer Dabbelt (2):
      genirq: Add CONFIG_GENERIC_IRQ_MULTI_HANDLER
      RISC-V: Move to the new GENERIC_IRQ_MULTI_HANDLER handler

Randy Dunlap (1):
      genirq: Drop 5 #included header files from irq.h

Shanker Donthineni (1):
      irqchip/gic-v3: Ensure GICR_CTLR.EnableLPI=0 is observed before enabling

Thomas Gleixner (5):
      genirq: Let irq thread follow the effective hard irq affinity
      genirq: Cleanup top of file comments
      genirq/matrix: Cleanup SPDX identifier
      genirq: Add missing SPDX identifiers
      genirq: Remove license boilerplate/references

Uwe Kleine König (1):
      genirq: Pass desc to __irq_free instead of irq number


 Documentation/ABI/testing/sysfs-kernel-irq         |   7 +
 Documentation/admin-guide/kernel-parameters.txt    |   8 +
 .../interrupt-controller/mscc,ocelot-icpu-intr.txt |  22 ++
 .../bindings/interrupt-controller/qcom,pdc.txt     |  78 ++++++
 arch/arm/include/asm/arch_gicv3.h                  |  47 +++-
 arch/arm64/include/asm/arch_gicv3.h                |   5 -
 arch/riscv/Kconfig                                 |   1 +
 arch/riscv/include/asm/Kbuild                      |   1 +
 arch/riscv/kernel/entry.S                          |   7 +-
 arch/riscv/kernel/irq.c                            |  13 -
 drivers/irqchip/Kconfig                            |  14 +
 drivers/irqchip/Makefile                           |   2 +
 drivers/irqchip/irq-gic-common.c                   |   9 +-
 drivers/irqchip/irq-gic-v3-its.c                   | 267 ++++++++++++++----
 drivers/irqchip/irq-gic-v3.c                       |  99 ++++++-
 drivers/irqchip/irq-gic.c                          |  44 +--
 drivers/irqchip/irq-mscc-ocelot.c                  | 118 ++++++++
 drivers/irqchip/irq-renesas-intc-irqpin.c          |  40 ++-
 drivers/irqchip/irq-renesas-irqc.c                 |  30 +-
 drivers/irqchip/qcom-pdc.c                         | 311 +++++++++++++++++++++
 include/linux/irq.h                                |  23 +-
 include/linux/irqchip/arm-gic-v3.h                 |   4 +-
 kernel/irq/Kconfig                                 |   5 +
 kernel/irq/autoprobe.c                             |   2 -
 kernel/irq/chip.c                                  |  10 +-
 kernel/irq/cpuhotplug.c                            |   1 +
 kernel/irq/debugfs.c                               |   8 +-
 kernel/irq/devres.c                                |   1 +
 kernel/irq/dummychip.c                             |   1 +
 kernel/irq/generic-chip.c                          |   1 +
 kernel/irq/handle.c                                |  23 +-
 kernel/irq/ipi.c                                   |   3 +-
 kernel/irq/irq_sim.c                               |  14 +-
 kernel/irq/irqdesc.c                               |  23 +-
 kernel/irq/irqdomain.c                             |   2 +
 kernel/irq/manage.c                                |  21 +-
 kernel/irq/matrix.c                                |   8 +-
 kernel/irq/msi.c                                   |   3 +-
 kernel/irq/pm.c                                    |   3 +-
 kernel/irq/proc.c                                  |   2 -
 kernel/irq/resend.c                                |   2 -
 kernel/irq/spurious.c                              |   2 -
 kernel/irq/timings.c                               |  13 +-
 kernel/softirq.c                                   |  82 ++----
 44 files changed, 1103 insertions(+), 277 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
 create mode 100644 drivers/irqchip/irq-mscc-ocelot.c
 create mode 100644 drivers/irqchip/qcom-pdc.c

diff --git a/Documentation/ABI/testing/sysfs-kernel-irq b/Documentation/ABI/testing/sysfs-kernel-irq
index eb074b100986..8910d0c4bcd8 100644
--- a/Documentation/ABI/testing/sysfs-kernel-irq
+++ b/Documentation/ABI/testing/sysfs-kernel-irq
@@ -51,3 +51,10 @@ Date:		September 2016
 KernelVersion:	4.9
 Contact:	Craig Gallek <kraig@google.com>
 Description:	The type of the interrupt.  Either the string 'level' or 'edge'.
+
+What:		/sys/kernel/irq/<irq>/wakeup
+Date:		March 2018
+KernelVersion:	4.17
+Contact:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+Description:	The wakeup state of the interrupt. Either the string
+		'enabled' or 'disabled'.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1d1d53f85ddd..60130231db3b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1743,6 +1743,14 @@
 			of a GICv2 controller even if the memory range
 			exposed by the device tree is too small.
 
+	irqchip.gicv3_nolpi=
+			[ARM, ARM64]
+			Force the kernel to ignore the availability of
+			LPIs (and by consequence ITSs). Intended for system
+			that use the kernel as a bootloader, and thus want
+			to let secondary kernels in charge of setting up
+			LPIs.
+
 	irqfixup	[HW]
 			When an interrupt is not handled search all handlers
 			for it. Intended to get systems with badly broken
diff --git a/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
new file mode 100644
index 000000000000..b47a8a02b17b
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
@@ -0,0 +1,22 @@
+Microsemi Ocelot SoC ICPU Interrupt Controller
+
+Required properties:
+
+- compatible : should be "mscc,ocelot-icpu-intr"
+- reg : Specifies base physical address and size of the registers.
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells : Specifies the number of cells needed to encode an
+  interrupt source. The value shall be 1.
+- interrupt-parent : phandle of the CPU interrupt controller.
+- interrupts : Specifies the CPU interrupt the controller is connected to.
+
+Example:
+
+		intc: interrupt-controller@70000070 {
+			compatible = "mscc,ocelot-icpu-intr";
+			reg = <0x70000070 0x70>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			interrupt-parent = <&cpuintc>;
+			interrupts = <2>;
+		};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
new file mode 100644
index 000000000000..0b2c97ddb520
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
@@ -0,0 +1,78 @@
+PDC interrupt controller
+
+Qualcomm Technologies Inc. SoCs based on the RPM Hardened architecture have a
+Power Domain Controller (PDC) that is on always-on domain. In addition to
+providing power control for the power domains, the hardware also has an
+interrupt controller that can be used to help detect edge low interrupts as
+well detect interrupts when the GIC is non-operational.
+
+GIC is parent interrupt controller at the highest level. Platform interrupt
+controller PDC is next in hierarchy, followed by others. Drivers requiring
+wakeup capabilities of their device interrupts routed through the PDC, must
+specify PDC as their interrupt controller and request the PDC port associated
+with the GIC interrupt. See example below.
+
+Properties:
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: Should contain "qcom,<soc>-pdc"
+		    - "qcom,sdm845-pdc": For SDM845
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Specifies the base physical address for PDC hardware.
+
+- interrupt-cells:
+	Usage: required
+	Value type: <u32>
+	Definition: Specifies the number of cells needed to encode an interrupt
+		    source.
+		    Must be 2.
+		    The first element of the tuple is the PDC pin for the
+		    interrupt.
+		    The second element is the trigger type.
+
+- interrupt-parent:
+	Usage: required
+	Value type: <phandle>
+	Definition: Specifies the interrupt parent necessary for hierarchical
+		    domain to operate.
+
+- interrupt-controller:
+	Usage: required
+	Value type: <bool>
+	Definition: Identifies the node as an interrupt controller.
+
+- qcom,pdc-ranges:
+	Usage: required
+	Value type: <u32 array>
+	Definition: Specifies the PDC pin offset and the number of PDC ports.
+		    The tuples indicates the valid mapping of valid PDC ports
+		    and their hwirq mapping.
+		    The first element of the tuple is the starting PDC port.
+		    The second element is the GIC hwirq number for the PDC port.
+		    The third element is the number of interrupts in sequence.
+
+Example:
+
+	pdc: interrupt-controller@b220000 {
+		compatible = "qcom,sdm845-pdc";
+		reg = <0xb220000 0x30000>;
+		qcom,pdc-ranges = <0 512 94>, <94 641 15>, <115 662 7>;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&intc>;
+		interrupt-controller;
+	};
+
+DT binding of a device that wants to use the GIC SPI 514 as a wakeup
+interrupt, must do -
+
+	wake-device {
+		interrupts-extended = <&pdc 2 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+In this case interrupt 514 would be mapped to port 2 on the PDC as defined by
+the qcom,pdc-ranges property.
diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index 1070044f5c3f..0bd530702118 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -35,6 +35,18 @@
 #define ICC_IGRPEN1			__ACCESS_CP15(c12, 0, c12, 7)
 #define ICC_BPR1			__ACCESS_CP15(c12, 0, c12, 3)
 
+#define __ICC_AP0Rx(x)			__ACCESS_CP15(c12, 0, c8, 4 | x)
+#define ICC_AP0R0			__ICC_AP0Rx(0)
+#define ICC_AP0R1			__ICC_AP0Rx(1)
+#define ICC_AP0R2			__ICC_AP0Rx(2)
+#define ICC_AP0R3			__ICC_AP0Rx(3)
+
+#define __ICC_AP1Rx(x)			__ACCESS_CP15(c12, 0, c9, x)
+#define ICC_AP1R0			__ICC_AP1Rx(0)
+#define ICC_AP1R1			__ICC_AP1Rx(1)
+#define ICC_AP1R2			__ICC_AP1Rx(2)
+#define ICC_AP1R3			__ICC_AP1Rx(3)
+
 #define ICC_HSRE			__ACCESS_CP15(c12, 4, c9, 5)
 
 #define ICH_VSEIR			__ACCESS_CP15(c12, 4, c9, 4)
@@ -86,17 +98,17 @@
 #define ICH_LRC14			__LRC8(6)
 #define ICH_LRC15			__LRC8(7)
 
-#define __AP0Rx(x)			__ACCESS_CP15(c12, 4, c8, x)
-#define ICH_AP0R0			__AP0Rx(0)
-#define ICH_AP0R1			__AP0Rx(1)
-#define ICH_AP0R2			__AP0Rx(2)
-#define ICH_AP0R3			__AP0Rx(3)
+#define __ICH_AP0Rx(x)			__ACCESS_CP15(c12, 4, c8, x)
+#define ICH_AP0R0			__ICH_AP0Rx(0)
+#define ICH_AP0R1			__ICH_AP0Rx(1)
+#define ICH_AP0R2			__ICH_AP0Rx(2)
+#define ICH_AP0R3			__ICH_AP0Rx(3)
 
-#define __AP1Rx(x)			__ACCESS_CP15(c12, 4, c9, x)
-#define ICH_AP1R0			__AP1Rx(0)
-#define ICH_AP1R1			__AP1Rx(1)
-#define ICH_AP1R2			__AP1Rx(2)
-#define ICH_AP1R3			__AP1Rx(3)
+#define __ICH_AP1Rx(x)			__ACCESS_CP15(c12, 4, c9, x)
+#define ICH_AP1R0			__ICH_AP1Rx(0)
+#define ICH_AP1R1			__ICH_AP1Rx(1)
+#define ICH_AP1R2			__ICH_AP1Rx(2)
+#define ICH_AP1R3			__ICH_AP1Rx(3)
 
 /* A32-to-A64 mappings used by VGIC save/restore */
 
@@ -125,6 +137,16 @@ static inline u64 read_ ## a64(void)		\
 	return val; 				\
 }
 
+CPUIF_MAP(ICC_PMR, ICC_PMR_EL1)
+CPUIF_MAP(ICC_AP0R0, ICC_AP0R0_EL1)
+CPUIF_MAP(ICC_AP0R1, ICC_AP0R1_EL1)
+CPUIF_MAP(ICC_AP0R2, ICC_AP0R2_EL1)
+CPUIF_MAP(ICC_AP0R3, ICC_AP0R3_EL1)
+CPUIF_MAP(ICC_AP1R0, ICC_AP1R0_EL1)
+CPUIF_MAP(ICC_AP1R1, ICC_AP1R1_EL1)
+CPUIF_MAP(ICC_AP1R2, ICC_AP1R2_EL1)
+CPUIF_MAP(ICC_AP1R3, ICC_AP1R3_EL1)
+
 CPUIF_MAP(ICH_HCR, ICH_HCR_EL2)
 CPUIF_MAP(ICH_VTR, ICH_VTR_EL2)
 CPUIF_MAP(ICH_MISR, ICH_MISR_EL2)
@@ -185,11 +207,6 @@ static inline u32 gic_read_iar(void)
 	return irqstat;
 }
 
-static inline void gic_write_pmr(u32 val)
-{
-	write_sysreg(val, ICC_PMR);
-}
-
 static inline void gic_write_ctlr(u32 val)
 {
 	write_sysreg(val, ICC_CTLR);
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 9becba9ab392..e278f94df0c9 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -76,11 +76,6 @@ static inline u64 gic_read_iar_cavium_thunderx(void)
 	return irqstat;
 }
 
-static inline void gic_write_pmr(u32 val)
-{
-	write_sysreg_s(val, SYS_ICC_PMR_EL1);
-}
-
 static inline void gic_write_ctlr(u32 val)
 {
 	write_sysreg_s(val, SYS_ICC_CTLR_EL1);
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
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index d913aec85109..60d5982d8234 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -286,6 +286,11 @@ config IRQ_MXS
 	select IRQ_DOMAIN
 	select STMP_DEVICE
 
+config MSCC_OCELOT_IRQ
+	bool
+	select IRQ_DOMAIN
+	select GENERIC_IRQ_CHIP
+
 config MVEBU_GICP
 	bool
 
@@ -351,4 +356,13 @@ config GOLDFISH_PIC
          Say yes here to enable Goldfish interrupt controller driver used
          for Goldfish based virtual platforms.
 
+config QCOM_PDC
+	bool "QCOM PDC"
+	depends on ARCH_QCOM
+	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Power Domain Controller driver to manage and configure wakeup
+	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d27e3e3619e0..935868c3292e 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_ARCH_SA1100)		+= irq-sa11x0.o
 obj-$(CONFIG_INGENIC_IRQ)		+= irq-ingenic.o
 obj-$(CONFIG_IMX_GPCV2)			+= irq-imx-gpcv2.o
 obj-$(CONFIG_PIC32_EVIC)		+= irq-pic32-evic.o
+obj-$(CONFIG_MSCC_OCELOT_IRQ)		+= irq-mscc-ocelot.o
 obj-$(CONFIG_MVEBU_GICP)		+= irq-mvebu-gicp.o
 obj-$(CONFIG_MVEBU_ICU)			+= irq-mvebu-icu.o
 obj-$(CONFIG_MVEBU_ODMI)		+= irq-mvebu-odmi.o
@@ -85,3 +86,4 @@ obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+= irq-uniphier-aidet.o
 obj-$(CONFIG_ARCH_SYNQUACER)		+= irq-sni-exiu.o
 obj-$(CONFIG_MESON_IRQ_GPIO)		+= irq-meson-gpio.o
 obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
+obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index 30017df5b54c..01e673c680cd 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -21,6 +21,8 @@
 
 #include "irq-gic-common.h"
 
+static DEFINE_RAW_SPINLOCK(irq_controller_lock);
+
 static const struct gic_kvm_info *gic_kvm_info;
 
 const struct gic_kvm_info *gic_get_kvm_info(void)
@@ -53,11 +55,13 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 	u32 confoff = (irq / 16) * 4;
 	u32 val, oldval;
 	int ret = 0;
+	unsigned long flags;
 
 	/*
 	 * Read current configuration register, and insert the config
 	 * for "irq", depending on "type".
 	 */
+	raw_spin_lock_irqsave(&irq_controller_lock, flags);
 	val = oldval = readl_relaxed(base + GIC_DIST_CONFIG + confoff);
 	if (type & IRQ_TYPE_LEVEL_MASK)
 		val &= ~confmask;
@@ -65,8 +69,10 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 		val |= confmask;
 
 	/* If the current configuration is the same, then we are done */
-	if (val == oldval)
+	if (val == oldval) {
+		raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
 		return 0;
+	}
 
 	/*
 	 * Write back the new configuration, and possibly re-enable
@@ -84,6 +90,7 @@ int gic_configure_irq(unsigned int irq, unsigned int type,
 			pr_warn("GIC: PPI%d is secure or misconfigured\n",
 				irq - 16);
 	}
+	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
 
 	if (sync_access)
 		sync_access();
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 1d3056f53747..cb952c073d77 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -33,6 +33,7 @@
 #include <linux/of_platform.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
+#include <linux/syscore_ops.h>
 
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic-v3.h>
@@ -46,6 +47,7 @@
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
+#define ITS_FLAGS_SAVE_SUSPEND_STATE		(1ULL << 3)
 
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
 
@@ -101,6 +103,8 @@ struct its_node {
 	struct its_collection	*collections;
 	struct fwnode_handle	*fwnode_handle;
 	u64			(*get_msi_base)(struct its_device *its_dev);
+	u64			cbaser_save;
+	u32			ctlr_save;
 	struct list_head	its_device_list;
 	u64			flags;
 	unsigned long		list_nr;
@@ -1875,16 +1879,6 @@ static void its_cpu_init_lpis(void)
 		gic_data_rdist()->pend_page = pend_page;
 	}
 
-	/* Disable LPIs */
-	val = readl_relaxed(rbase + GICR_CTLR);
-	val &= ~GICR_CTLR_ENABLE_LPIS;
-	writel_relaxed(val, rbase + GICR_CTLR);
-
-	/*
-	 * Make sure any change to the table is observable by the GIC.
-	 */
-	dsb(sy);
-
 	/* set PROPBASE */
 	val = (page_to_phys(gic_rdists->prop_page) |
 	       GICR_PROPBASER_InnerShareable |
@@ -1938,52 +1932,53 @@ static void its_cpu_init_lpis(void)
 	dsb(sy);
 }
 
-static void its_cpu_init_collection(void)
+static void its_cpu_init_collection(struct its_node *its)
 {
-	struct its_node *its;
-	int cpu;
-
-	spin_lock(&its_lock);
-	cpu = smp_processor_id();
-
-	list_for_each_entry(its, &its_nodes, entry) {
-		u64 target;
+	int cpu = smp_processor_id();
+	u64 target;
 
-		/* avoid cross node collections and its mapping */
-		if (its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) {
-			struct device_node *cpu_node;
+	/* avoid cross node collections and its mapping */
+	if (its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) {
+		struct device_node *cpu_node;
 
-			cpu_node = of_get_cpu_node(cpu, NULL);
-			if (its->numa_node != NUMA_NO_NODE &&
-				its->numa_node != of_node_to_nid(cpu_node))
-				continue;
-		}
+		cpu_node = of_get_cpu_node(cpu, NULL);
+		if (its->numa_node != NUMA_NO_NODE &&
+			its->numa_node != of_node_to_nid(cpu_node))
+			return;
+	}
 
+	/*
+	 * We now have to bind each collection to its target
+	 * redistributor.
+	 */
+	if (gic_read_typer(its->base + GITS_TYPER) & GITS_TYPER_PTA) {
 		/*
-		 * We now have to bind each collection to its target
+		 * This ITS wants the physical address of the
 		 * redistributor.
 		 */
-		if (gic_read_typer(its->base + GITS_TYPER) & GITS_TYPER_PTA) {
-			/*
-			 * This ITS wants the physical address of the
-			 * redistributor.
-			 */
-			target = gic_data_rdist()->phys_base;
-		} else {
-			/*
-			 * This ITS wants a linear CPU number.
-			 */
-			target = gic_read_typer(gic_data_rdist_rd_base() + GICR_TYPER);
-			target = GICR_TYPER_CPU_NUMBER(target) << 16;
-		}
+		target = gic_data_rdist()->phys_base;
+	} else {
+		/* This ITS wants a linear CPU number. */
+		target = gic_read_typer(gic_data_rdist_rd_base() + GICR_TYPER);
+		target = GICR_TYPER_CPU_NUMBER(target) << 16;
+	}
 
-		/* Perform collection mapping */
-		its->collections[cpu].target_address = target;
-		its->collections[cpu].col_id = cpu;
+	/* Perform collection mapping */
+	its->collections[cpu].target_address = target;
+	its->collections[cpu].col_id = cpu;
 
-		its_send_mapc(its, &its->collections[cpu], 1);
-		its_send_invall(its, &its->collections[cpu]);
-	}
+	its_send_mapc(its, &its->collections[cpu], 1);
+	its_send_invall(its, &its->collections[cpu]);
+}
+
+static void its_cpu_init_collections(void)
+{
+	struct its_node *its;
+
+	spin_lock(&its_lock);
+
+	list_for_each_entry(its, &its_nodes, entry)
+		its_cpu_init_collection(its);
 
 	spin_unlock(&its_lock);
 }
@@ -3042,6 +3037,113 @@ static void its_enable_quirks(struct its_node *its)
 	gic_enable_quirks(iidr, its_quirks, its);
 }
 
+static int its_save_disable(void)
+{
+	struct its_node *its;
+	int err = 0;
+
+	spin_lock(&its_lock);
+	list_for_each_entry(its, &its_nodes, entry) {
+		void __iomem *base;
+
+		if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
+			continue;
+
+		base = its->base;
+		its->ctlr_save = readl_relaxed(base + GITS_CTLR);
+		err = its_force_quiescent(base);
+		if (err) {
+			pr_err("ITS@%pa: failed to quiesce: %d\n",
+			       &its->phys_base, err);
+			writel_relaxed(its->ctlr_save, base + GITS_CTLR);
+			goto err;
+		}
+
+		its->cbaser_save = gits_read_cbaser(base + GITS_CBASER);
+	}
+
+err:
+	if (err) {
+		list_for_each_entry_continue_reverse(its, &its_nodes, entry) {
+			void __iomem *base;
+
+			if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
+				continue;
+
+			base = its->base;
+			writel_relaxed(its->ctlr_save, base + GITS_CTLR);
+		}
+	}
+	spin_unlock(&its_lock);
+
+	return err;
+}
+
+static void its_restore_enable(void)
+{
+	struct its_node *its;
+	int ret;
+
+	spin_lock(&its_lock);
+	list_for_each_entry(its, &its_nodes, entry) {
+		void __iomem *base;
+		int i;
+
+		if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
+			continue;
+
+		base = its->base;
+
+		/*
+		 * Make sure that the ITS is disabled. If it fails to quiesce,
+		 * don't restore it since writing to CBASER or BASER<n>
+		 * registers is undefined according to the GIC v3 ITS
+		 * Specification.
+		 */
+		ret = its_force_quiescent(base);
+		if (ret) {
+			pr_err("ITS@%pa: failed to quiesce on resume: %d\n",
+			       &its->phys_base, ret);
+			continue;
+		}
+
+		gits_write_cbaser(its->cbaser_save, base + GITS_CBASER);
+
+		/*
+		 * Writing CBASER resets CREADR to 0, so make CWRITER and
+		 * cmd_write line up with it.
+		 */
+		its->cmd_write = its->cmd_base;
+		gits_write_cwriter(0, base + GITS_CWRITER);
+
+		/* Restore GITS_BASER from the value cache. */
+		for (i = 0; i < GITS_BASER_NR_REGS; i++) {
+			struct its_baser *baser = &its->tables[i];
+
+			if (!(baser->val & GITS_BASER_VALID))
+				continue;
+
+			its_write_baser(its, baser, baser->val);
+		}
+		writel_relaxed(its->ctlr_save, base + GITS_CTLR);
+
+		/*
+		 * Reinit the collection if it's stored in the ITS. This is
+		 * indicated by the col_id being less than the HCC field.
+		 * CID < HCC as specified in the GIC v3 Documentation.
+		 */
+		if (its->collections[smp_processor_id()].col_id <
+		    GITS_TYPER_HCC(gic_read_typer(base + GITS_TYPER)))
+			its_cpu_init_collection(its);
+	}
+	spin_unlock(&its_lock);
+}
+
+static struct syscore_ops its_syscore_ops = {
+	.suspend = its_save_disable,
+	.resume = its_restore_enable,
+};
+
 static int its_init_domain(struct fwnode_handle *handle, struct its_node *its)
 {
 	struct irq_domain *inner_domain;
@@ -3261,6 +3363,9 @@ static int __init its_probe_one(struct resource *res,
 		ctlr |= GITS_CTLR_ImDe;
 	writel_relaxed(ctlr, its->base + GITS_CTLR);
 
+	if (GITS_TYPER_HCC(typer))
+		its->flags |= ITS_FLAGS_SAVE_SUSPEND_STATE;
+
 	err = its_init_domain(handle, its);
 	if (err)
 		goto out_free_tables;
@@ -3288,15 +3393,71 @@ static bool gic_rdists_supports_plpis(void)
 	return !!(gic_read_typer(gic_data_rdist_rd_base() + GICR_TYPER) & GICR_TYPER_PLPIS);
 }
 
+static int redist_disable_lpis(void)
+{
+	void __iomem *rbase = gic_data_rdist_rd_base();
+	u64 timeout = USEC_PER_SEC;
+	u64 val;
+
+	if (!gic_rdists_supports_plpis()) {
+		pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
+		return -ENXIO;
+	}
+
+	val = readl_relaxed(rbase + GICR_CTLR);
+	if (!(val & GICR_CTLR_ENABLE_LPIS))
+		return 0;
+
+	pr_warn("CPU%d: Booted with LPIs enabled, memory probably corrupted\n",
+		smp_processor_id());
+	add_taint(TAINT_CRAP, LOCKDEP_STILL_OK);
+
+	/* Disable LPIs */
+	val &= ~GICR_CTLR_ENABLE_LPIS;
+	writel_relaxed(val, rbase + GICR_CTLR);
+
+	/* Make sure any change to GICR_CTLR is observable by the GIC */
+	dsb(sy);
+
+	/*
+	 * Software must observe RWP==0 after clearing GICR_CTLR.EnableLPIs
+	 * from 1 to 0 before programming GICR_PEND{PROP}BASER registers.
+	 * Error out if we time out waiting for RWP to clear.
+	 */
+	while (readl_relaxed(rbase + GICR_CTLR) & GICR_CTLR_RWP) {
+		if (!timeout) {
+			pr_err("CPU%d: Timeout while disabling LPIs\n",
+			       smp_processor_id());
+			return -ETIMEDOUT;
+		}
+		udelay(1);
+		timeout--;
+	}
+
+	/*
+	 * After it has been written to 1, it is IMPLEMENTATION
+	 * DEFINED whether GICR_CTLR.EnableLPI becomes RES1 or can be
+	 * cleared to 0. Error out if clearing the bit failed.
+	 */
+	if (readl_relaxed(rbase + GICR_CTLR) & GICR_CTLR_ENABLE_LPIS) {
+		pr_err("CPU%d: Failed to disable LPIs\n", smp_processor_id());
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 int its_cpu_init(void)
 {
 	if (!list_empty(&its_nodes)) {
-		if (!gic_rdists_supports_plpis()) {
-			pr_info("CPU%d: LPIs not supported\n", smp_processor_id());
-			return -ENXIO;
-		}
+		int ret;
+
+		ret = redist_disable_lpis();
+		if (ret)
+			return ret;
+
 		its_cpu_init_lpis();
-		its_cpu_init_collection();
+		its_cpu_init_collections();
 	}
 
 	return 0;
@@ -3517,5 +3678,7 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 		}
 	}
 
+	register_syscore_ops(&its_syscore_ops);
+
 	return 0;
 }
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d99cc07903ec..e5d101418390 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -61,7 +61,7 @@ struct gic_chip_data {
 };
 
 static struct gic_chip_data gic_data __read_mostly;
-static struct static_key supports_deactivate = STATIC_KEY_INIT_TRUE;
+static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 
 static struct gic_kvm_info gic_v3_kvm_info;
 static DEFINE_PER_CPU(bool, has_rss);
@@ -354,7 +354,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 		if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
 			int err;
 
-			if (static_key_true(&supports_deactivate))
+			if (static_branch_likely(&supports_deactivate_key))
 				gic_write_eoir(irqnr);
 			else
 				isb();
@@ -362,7 +362,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 			err = handle_domain_irq(gic_data.domain, irqnr, regs);
 			if (err) {
 				WARN_ONCE(true, "Unexpected interrupt received!\n");
-				if (static_key_true(&supports_deactivate)) {
+				if (static_branch_likely(&supports_deactivate_key)) {
 					if (irqnr < 8192)
 						gic_write_dir(irqnr);
 				} else {
@@ -373,7 +373,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 		}
 		if (irqnr < 16) {
 			gic_write_eoir(irqnr);
-			if (static_key_true(&supports_deactivate))
+			if (static_branch_likely(&supports_deactivate_key))
 				gic_write_dir(irqnr);
 #ifdef CONFIG_SMP
 			/*
@@ -532,6 +532,8 @@ static void gic_cpu_sys_reg_init(void)
 	int i, cpu = smp_processor_id();
 	u64 mpidr = cpu_logical_map(cpu);
 	u64 need_rss = MPIDR_RS(mpidr);
+	bool group0;
+	u32 val, pribits;
 
 	/*
 	 * Need to check that the SRE bit has actually been set. If
@@ -543,8 +545,28 @@ static void gic_cpu_sys_reg_init(void)
 	if (!gic_enable_sre())
 		pr_err("GIC: unable to set SRE (disabled at EL2), panic ahead\n");
 
+	pribits = gic_read_ctlr();
+	pribits &= ICC_CTLR_EL1_PRI_BITS_MASK;
+	pribits >>= ICC_CTLR_EL1_PRI_BITS_SHIFT;
+	pribits++;
+
+	/*
+	 * Let's find out if Group0 is under control of EL3 or not by
+	 * setting the highest possible, non-zero priority in PMR.
+	 *
+	 * If SCR_EL3.FIQ is set, the priority gets shifted down in
+	 * order for the CPU interface to set bit 7, and keep the
+	 * actual priority in the non-secure range. In the process, it
+	 * looses the least significant bit and the actual priority
+	 * becomes 0x80. Reading it back returns 0, indicating that
+	 * we're don't have access to Group0.
+	 */
+	write_gicreg(BIT(8 - pribits), ICC_PMR_EL1);
+	val = read_gicreg(ICC_PMR_EL1);
+	group0 = val != 0;
+
 	/* Set priority mask register */
-	gic_write_pmr(DEFAULT_PMR_VALUE);
+	write_gicreg(DEFAULT_PMR_VALUE, ICC_PMR_EL1);
 
 	/*
 	 * Some firmwares hand over to the kernel with the BPR changed from
@@ -554,7 +576,7 @@ static void gic_cpu_sys_reg_init(void)
 	 */
 	gic_write_bpr1(0);
 
-	if (static_key_true(&supports_deactivate)) {
+	if (static_branch_likely(&supports_deactivate_key)) {
 		/* EOI drops priority only (mode 1) */
 		gic_write_ctlr(ICC_CTLR_EL1_EOImode_drop);
 	} else {
@@ -562,6 +584,37 @@ static void gic_cpu_sys_reg_init(void)
 		gic_write_ctlr(ICC_CTLR_EL1_EOImode_drop_dir);
 	}
 
+	/* Always whack Group0 before Group1 */
+	if (group0) {
+		switch(pribits) {
+		case 8:
+		case 7:
+			write_gicreg(0, ICC_AP0R3_EL1);
+			write_gicreg(0, ICC_AP0R2_EL1);
+		case 6:
+			write_gicreg(0, ICC_AP0R1_EL1);
+		case 5:
+		case 4:
+			write_gicreg(0, ICC_AP0R0_EL1);
+		}
+
+		isb();
+	}
+
+	switch(pribits) {
+	case 8:
+	case 7:
+		write_gicreg(0, ICC_AP1R3_EL1);
+		write_gicreg(0, ICC_AP1R2_EL1);
+	case 6:
+		write_gicreg(0, ICC_AP1R1_EL1);
+	case 5:
+	case 4:
+		write_gicreg(0, ICC_AP1R0_EL1);
+	}
+
+	isb();
+
 	/* ... and let's hit the road... */
 	gic_write_grpen1(1);
 
@@ -590,9 +643,17 @@ static void gic_cpu_sys_reg_init(void)
 		pr_crit_once("RSS is required but GICD doesn't support it\n");
 }
 
+static bool gicv3_nolpi;
+
+static int __init gicv3_nolpi_cfg(char *buf)
+{
+	return strtobool(buf, &gicv3_nolpi);
+}
+early_param("irqchip.gicv3_nolpi", gicv3_nolpi_cfg);
+
 static int gic_dist_supports_lpis(void)
 {
-	return !!(readl_relaxed(gic_data.dist_base + GICD_TYPER) & GICD_TYPER_LPIS);
+	return !!(readl_relaxed(gic_data.dist_base + GICD_TYPER) & GICD_TYPER_LPIS) && !gicv3_nolpi;
 }
 
 static void gic_cpu_init(void)
@@ -823,7 +884,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 {
 	struct irq_chip *chip = &gic_chip;
 
-	if (static_key_true(&supports_deactivate))
+	if (static_branch_likely(&supports_deactivate_key))
 		chip = &gic_eoimode1_chip;
 
 	/* SGIs are private to the core kernel */
@@ -861,6 +922,8 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
+#define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
+
 static int gic_irq_domain_translate(struct irq_domain *d,
 				    struct irq_fwspec *fwspec,
 				    unsigned long *hwirq,
@@ -875,6 +938,7 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 			*hwirq = fwspec->param[1] + 32;
 			break;
 		case 1:			/* PPI */
+		case GIC_IRQ_TYPE_PARTITION:
 			*hwirq = fwspec->param[1] + 16;
 			break;
 		case GIC_IRQ_TYPE_LPI:	/* LPI */
@@ -885,6 +949,13 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 		}
 
 		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+
+		/*
+		 * Make it clear that broken DTs are... broken.
+		 * Partitionned PPIs are an unfortunate exception.
+		 */
+		WARN_ON(*type == IRQ_TYPE_NONE &&
+			fwspec->param[0] != GIC_IRQ_TYPE_PARTITION);
 		return 0;
 	}
 
@@ -894,6 +965,8 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 
 		*hwirq = fwspec->param[0];
 		*type = fwspec->param[1];
+
+		WARN_ON(*type == IRQ_TYPE_NONE);
 		return 0;
 	}
 
@@ -1002,9 +1075,9 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	int err;
 
 	if (!is_hyp_mode_available())
-		static_key_slow_dec(&supports_deactivate);
+		static_branch_disable(&supports_deactivate_key);
 
-	if (static_key_true(&supports_deactivate))
+	if (static_branch_likely(&supports_deactivate_key))
 		pr_info("GIC: Using split EOI/Deactivate mode\n");
 
 	gic_data.fwnode = handle;
@@ -1140,7 +1213,7 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 			.fwnode		= gic_data.fwnode,
 			.param_count	= 3,
 			.param		= {
-				[0]	= 1,
+				[0]	= GIC_IRQ_TYPE_PARTITION,
 				[1]	= i,
 				[2]	= IRQ_TYPE_NONE,
 			},
@@ -1239,7 +1312,7 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 
 	gic_populate_ppi_partitions(node);
 
-	if (static_key_true(&supports_deactivate))
+	if (static_branch_likely(&supports_deactivate_key))
 		gic_of_setup_kvm_info(node);
 	return 0;
 
@@ -1541,7 +1614,7 @@ gic_acpi_init(struct acpi_subtable_header *header, const unsigned long end)
 
 	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, domain_handle);
 
-	if (static_key_true(&supports_deactivate))
+	if (static_branch_likely(&supports_deactivate_key))
 		gic_acpi_setup_kvm_info();
 
 	return 0;
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 121af5cf688f..ced10c44b68a 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -121,7 +121,7 @@ static DEFINE_RAW_SPINLOCK(cpu_map_lock);
 #define NR_GIC_CPU_IF 8
 static u8 gic_cpu_map[NR_GIC_CPU_IF] __read_mostly;
 
-static struct static_key supports_deactivate = STATIC_KEY_INIT_TRUE;
+static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 
 static struct gic_chip_data gic_data[CONFIG_ARM_GIC_MAX_NR] __read_mostly;
 
@@ -361,7 +361,7 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 		irqnr = irqstat & GICC_IAR_INT_ID_MASK;
 
 		if (likely(irqnr > 15 && irqnr < 1020)) {
-			if (static_key_true(&supports_deactivate))
+			if (static_branch_likely(&supports_deactivate_key))
 				writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
 			isb();
 			handle_domain_irq(gic->domain, irqnr, regs);
@@ -369,7 +369,7 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 		}
 		if (irqnr < 16) {
 			writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
-			if (static_key_true(&supports_deactivate))
+			if (static_branch_likely(&supports_deactivate_key))
 				writel_relaxed(irqstat, cpu_base + GIC_CPU_DEACTIVATE);
 #ifdef CONFIG_SMP
 			/*
@@ -453,15 +453,26 @@ static u8 gic_get_cpumask(struct gic_chip_data *gic)
 	return mask;
 }
 
+static bool gic_check_gicv2(void __iomem *base)
+{
+	u32 val = readl_relaxed(base + GIC_CPU_IDENT);
+	return (val & 0xff0fff) == 0x02043B;
+}
+
 static void gic_cpu_if_up(struct gic_chip_data *gic)
 {
 	void __iomem *cpu_base = gic_data_cpu_base(gic);
 	u32 bypass = 0;
 	u32 mode = 0;
+	int i;
 
-	if (gic == &gic_data[0] && static_key_true(&supports_deactivate))
+	if (gic == &gic_data[0] && static_branch_likely(&supports_deactivate_key))
 		mode = GIC_CPU_CTRL_EOImodeNS;
 
+	if (gic_check_gicv2(cpu_base))
+		for (i = 0; i < 4; i++)
+			writel_relaxed(0, cpu_base + GIC_CPU_ACTIVEPRIO + i * 4);
+
 	/*
 	* Preserve bypass disable bits to be written back later
 	*/
@@ -1000,6 +1011,9 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 			*hwirq += 16;
 
 		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+
+		/* Make it clear that broken DTs are... broken */
+		WARN_ON(*type == IRQ_TYPE_NONE);
 		return 0;
 	}
 
@@ -1009,6 +1023,8 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 
 		*hwirq = fwspec->param[0];
 		*type = fwspec->param[1];
+
+		WARN_ON(*type == IRQ_TYPE_NONE);
 		return 0;
 	}
 
@@ -1203,11 +1219,11 @@ static int __init __gic_init_bases(struct gic_chip_data *gic,
 					  "irqchip/arm/gic:starting",
 					  gic_starting_cpu, NULL);
 		set_handle_irq(gic_handle_irq);
-		if (static_key_true(&supports_deactivate))
+		if (static_branch_likely(&supports_deactivate_key))
 			pr_info("GIC: Using split EOI/Deactivate mode\n");
 	}
 
-	if (static_key_true(&supports_deactivate) && gic == &gic_data[0]) {
+	if (static_branch_likely(&supports_deactivate_key) && gic == &gic_data[0]) {
 		name = kasprintf(GFP_KERNEL, "GICv2");
 		gic_init_chip(gic, NULL, name, true);
 	} else {
@@ -1234,7 +1250,7 @@ void __init gic_init(unsigned int gic_nr, int irq_start,
 	 * Non-DT/ACPI systems won't run a hypervisor, so let's not
 	 * bother with these...
 	 */
-	static_key_slow_dec(&supports_deactivate);
+	static_branch_disable(&supports_deactivate_key);
 
 	gic = &gic_data[gic_nr];
 	gic->raw_dist_base = dist_base;
@@ -1264,12 +1280,6 @@ static int __init gicv2_force_probe_cfg(char *buf)
 }
 early_param("irqchip.gicv2_force_probe", gicv2_force_probe_cfg);
 
-static bool gic_check_gicv2(void __iomem *base)
-{
-	u32 val = readl_relaxed(base + GIC_CPU_IDENT);
-	return (val & 0xff0fff) == 0x02043B;
-}
-
 static bool gic_check_eoimode(struct device_node *node, void __iomem **base)
 {
 	struct resource cpuif_res;
@@ -1420,7 +1430,7 @@ static void __init gic_of_setup_kvm_info(struct device_node *node)
 	if (ret)
 		return;
 
-	if (static_key_true(&supports_deactivate))
+	if (static_branch_likely(&supports_deactivate_key))
 		gic_set_kvm_info(&gic_v2_kvm_info);
 }
 
@@ -1447,7 +1457,7 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 	 * or the CPU interface is too small.
 	 */
 	if (gic_cnt == 0 && !gic_check_eoimode(node, &gic->raw_cpu_base))
-		static_key_slow_dec(&supports_deactivate);
+		static_branch_disable(&supports_deactivate_key);
 
 	ret = __gic_init_bases(gic, -1, &node->fwnode);
 	if (ret) {
@@ -1628,7 +1638,7 @@ static int __init gic_v2_acpi_init(struct acpi_subtable_header *header,
 	 * interface will always be the right size.
 	 */
 	if (!is_hyp_mode_available())
-		static_key_slow_dec(&supports_deactivate);
+		static_branch_disable(&supports_deactivate_key);
 
 	/*
 	 * Initialize GIC instance zero (no multi-GIC support).
@@ -1653,7 +1663,7 @@ static int __init gic_v2_acpi_init(struct acpi_subtable_header *header,
 	if (IS_ENABLED(CONFIG_ARM_GIC_V2M))
 		gicv2m_init(NULL, gic_data[0].domain);
 
-	if (static_key_true(&supports_deactivate))
+	if (static_branch_likely(&supports_deactivate_key))
 		gic_acpi_setup_kvm_info();
 
 	return 0;
diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
new file mode 100644
index 000000000000..b63e40c00a02
--- /dev/null
+++ b/drivers/irqchip/irq-mscc-ocelot.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Microsemi Ocelot IRQ controller driver
+ *
+ * Copyright (c) 2017 Microsemi Corporation
+ */
+#include <linux/bitops.h>
+#include <linux/irq.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/interrupt.h>
+
+#define ICPU_CFG_INTR_INTR_STICKY	0x10
+#define ICPU_CFG_INTR_INTR_ENA		0x18
+#define ICPU_CFG_INTR_INTR_ENA_CLR	0x1c
+#define ICPU_CFG_INTR_INTR_ENA_SET	0x20
+#define ICPU_CFG_INTR_DST_INTR_IDENT(x)	(0x38 + 0x4 * (x))
+#define ICPU_CFG_INTR_INTR_TRIGGER(x)	(0x5c + 0x4 * (x))
+
+#define OCELOT_NR_IRQ 24
+
+static void ocelot_irq_unmask(struct irq_data *data)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
+	struct irq_chip_type *ct = irq_data_get_chip_type(data);
+	unsigned int mask = data->mask;
+	u32 val;
+
+	irq_gc_lock(gc);
+	val = irq_reg_readl(gc, ICPU_CFG_INTR_INTR_TRIGGER(0)) |
+	      irq_reg_readl(gc, ICPU_CFG_INTR_INTR_TRIGGER(1));
+	if (!(val & mask))
+		irq_reg_writel(gc, mask, ICPU_CFG_INTR_INTR_STICKY);
+
+	*ct->mask_cache &= ~mask;
+	irq_reg_writel(gc, mask, ICPU_CFG_INTR_INTR_ENA_SET);
+	irq_gc_unlock(gc);
+}
+
+static void ocelot_irq_handler(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irq_domain *d = irq_desc_get_handler_data(desc);
+	struct irq_chip_generic *gc = irq_get_domain_generic_chip(d, 0);
+	u32 reg = irq_reg_readl(gc, ICPU_CFG_INTR_DST_INTR_IDENT(0));
+
+	chained_irq_enter(chip, desc);
+
+	while (reg) {
+		u32 hwirq = __fls(reg);
+
+		generic_handle_irq(irq_find_mapping(d, hwirq));
+		reg &= ~(BIT(hwirq));
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static int __init ocelot_irq_init(struct device_node *node,
+				  struct device_node *parent)
+{
+	struct irq_domain *domain;
+	struct irq_chip_generic *gc;
+	int parent_irq, ret;
+
+	parent_irq = irq_of_parse_and_map(node, 0);
+	if (!parent_irq)
+		return -EINVAL;
+
+	domain = irq_domain_add_linear(node, OCELOT_NR_IRQ,
+				       &irq_generic_chip_ops, NULL);
+	if (!domain) {
+		pr_err("%s: unable to add irq domain\n", node->name);
+		return -ENOMEM;
+	}
+
+	ret = irq_alloc_domain_generic_chips(domain, OCELOT_NR_IRQ, 1,
+					     "icpu", handle_level_irq,
+					     0, 0, 0);
+	if (ret) {
+		pr_err("%s: unable to alloc irq domain gc\n", node->name);
+		goto err_domain_remove;
+	}
+
+	gc = irq_get_domain_generic_chip(domain, 0);
+	gc->reg_base = of_iomap(node, 0);
+	if (!gc->reg_base) {
+		pr_err("%s: unable to map resource\n", node->name);
+		ret = -ENOMEM;
+		goto err_gc_free;
+	}
+
+	gc->chip_types[0].regs.ack = ICPU_CFG_INTR_INTR_STICKY;
+	gc->chip_types[0].regs.mask = ICPU_CFG_INTR_INTR_ENA_CLR;
+	gc->chip_types[0].chip.irq_ack = irq_gc_ack_set_bit;
+	gc->chip_types[0].chip.irq_mask = irq_gc_mask_set_bit;
+	gc->chip_types[0].chip.irq_unmask = ocelot_irq_unmask;
+
+	/* Mask and ack all interrupts */
+	irq_reg_writel(gc, 0, ICPU_CFG_INTR_INTR_ENA);
+	irq_reg_writel(gc, 0xffffffff, ICPU_CFG_INTR_INTR_STICKY);
+
+	irq_set_chained_handler_and_data(parent_irq, ocelot_irq_handler,
+					 domain);
+
+	return 0;
+
+err_gc_free:
+	irq_free_generic_chip(gc);
+
+err_domain_remove:
+	irq_domain_remove(domain);
+
+	return ret;
+}
+IRQCHIP_DECLARE(ocelot_icpu, "mscc,ocelot-icpu-intr", ocelot_irq_init);
diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index cee59fe1321c..c6e6c9e9137a 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -17,7 +17,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -78,16 +77,14 @@ struct intc_irqpin_priv {
 	struct platform_device *pdev;
 	struct irq_chip irq_chip;
 	struct irq_domain *irq_domain;
-	struct clk *clk;
+	atomic_t wakeup_path;
 	unsigned shared_irqs:1;
-	unsigned needs_clk:1;
 	u8 shared_irq_mask;
 };
 
 struct intc_irqpin_config {
 	unsigned int irlm_bit;
 	unsigned needs_irlm:1;
-	unsigned needs_clk:1;
 };
 
 static unsigned long intc_irqpin_read32(void __iomem *iomem)
@@ -287,14 +284,10 @@ static int intc_irqpin_irq_set_wake(struct irq_data *d, unsigned int on)
 	int hw_irq = irqd_to_hwirq(d);
 
 	irq_set_irq_wake(p->irq[hw_irq].requested_irq, on);
-
-	if (!p->clk)
-		return 0;
-
 	if (on)
-		clk_enable(p->clk);
+		atomic_inc(&p->wakeup_path);
 	else
-		clk_disable(p->clk);
+		atomic_dec(&p->wakeup_path);
 
 	return 0;
 }
@@ -369,12 +362,10 @@ static const struct irq_domain_ops intc_irqpin_irq_domain_ops = {
 static const struct intc_irqpin_config intc_irqpin_irlm_r8a777x = {
 	.irlm_bit = 23, /* ICR0.IRLM0 */
 	.needs_irlm = 1,
-	.needs_clk = 0,
 };
 
 static const struct intc_irqpin_config intc_irqpin_rmobile = {
 	.needs_irlm = 0,
-	.needs_clk = 1,
 };
 
 static const struct of_device_id intc_irqpin_dt_ids[] = {
@@ -426,18 +417,6 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, p);
 
 	config = of_device_get_match_data(dev);
-	if (config)
-		p->needs_clk = config->needs_clk;
-
-	p->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(p->clk)) {
-		if (p->needs_clk) {
-			dev_err(dev, "unable to get clock\n");
-			ret = PTR_ERR(p->clk);
-			goto err0;
-		}
-		p->clk = NULL;
-	}
 
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
@@ -606,12 +585,25 @@ static int intc_irqpin_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused intc_irqpin_suspend(struct device *dev)
+{
+	struct intc_irqpin_priv *p = dev_get_drvdata(dev);
+
+	if (atomic_read(&p->wakeup_path))
+		device_set_wakeup_path(dev);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(intc_irqpin_pm_ops, intc_irqpin_suspend, NULL);
+
 static struct platform_driver intc_irqpin_device_driver = {
 	.probe		= intc_irqpin_probe,
 	.remove		= intc_irqpin_remove,
 	.driver		= {
 		.name	= "renesas_intc_irqpin",
 		.of_match_table = intc_irqpin_dt_ids,
+		.pm	= &intc_irqpin_pm_ops,
 	}
 };
 
diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 52304b139aa4..a4f11124024d 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -17,7 +17,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
@@ -64,7 +63,7 @@ struct irqc_priv {
 	struct platform_device *pdev;
 	struct irq_chip_generic *gc;
 	struct irq_domain *irq_domain;
-	struct clk *clk;
+	atomic_t wakeup_path;
 };
 
 static struct irqc_priv *irq_data_to_priv(struct irq_data *data)
@@ -111,14 +110,10 @@ static int irqc_irq_set_wake(struct irq_data *d, unsigned int on)
 	int hw_irq = irqd_to_hwirq(d);
 
 	irq_set_irq_wake(p->irq[hw_irq].requested_irq, on);
-
-	if (!p->clk)
-		return 0;
-
 	if (on)
-		clk_enable(p->clk);
+		atomic_inc(&p->wakeup_path);
 	else
-		clk_disable(p->clk);
+		atomic_dec(&p->wakeup_path);
 
 	return 0;
 }
@@ -159,12 +154,6 @@ static int irqc_probe(struct platform_device *pdev)
 	p->pdev = pdev;
 	platform_set_drvdata(pdev, p);
 
-	p->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(p->clk)) {
-		dev_warn(&pdev->dev, "unable to get clock\n");
-		p->clk = NULL;
-	}
-
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
@@ -276,6 +265,18 @@ static int irqc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused irqc_suspend(struct device *dev)
+{
+	struct irqc_priv *p = dev_get_drvdata(dev);
+
+	if (atomic_read(&p->wakeup_path))
+		device_set_wakeup_path(dev);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(irqc_pm_ops, irqc_suspend, NULL);
+
 static const struct of_device_id irqc_dt_ids[] = {
 	{ .compatible = "renesas,irqc", },
 	{},
@@ -288,6 +289,7 @@ static struct platform_driver irqc_device_driver = {
 	.driver		= {
 		.name	= "renesas_irqc",
 		.of_match_table	= irqc_dt_ids,
+		.pm	= &irqc_pm_ops,
 	}
 };
 
diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
new file mode 100644
index 000000000000..b1b47a40a278
--- /dev/null
+++ b/drivers/irqchip/qcom-pdc.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/spinlock.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#define PDC_MAX_IRQS		126
+
+#define CLEAR_INTR(reg, intr)	(reg & ~(1 << intr))
+#define ENABLE_INTR(reg, intr)	(reg | (1 << intr))
+
+#define IRQ_ENABLE_BANK		0x10
+#define IRQ_i_CFG		0x110
+
+struct pdc_pin_region {
+	u32 pin_base;
+	u32 parent_base;
+	u32 cnt;
+};
+
+static DEFINE_RAW_SPINLOCK(pdc_lock);
+static void __iomem *pdc_base;
+static struct pdc_pin_region *pdc_region;
+static int pdc_region_cnt;
+
+static void pdc_reg_write(int reg, u32 i, u32 val)
+{
+	writel_relaxed(val, pdc_base + reg + i * sizeof(u32));
+}
+
+static u32 pdc_reg_read(int reg, u32 i)
+{
+	return readl_relaxed(pdc_base + reg + i * sizeof(u32));
+}
+
+static void pdc_enable_intr(struct irq_data *d, bool on)
+{
+	int pin_out = d->hwirq;
+	u32 index, mask;
+	u32 enable;
+
+	index = pin_out / 32;
+	mask = pin_out % 32;
+
+	raw_spin_lock(&pdc_lock);
+	enable = pdc_reg_read(IRQ_ENABLE_BANK, index);
+	enable = on ? ENABLE_INTR(enable, mask) : CLEAR_INTR(enable, mask);
+	pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
+	raw_spin_unlock(&pdc_lock);
+}
+
+static void qcom_pdc_gic_mask(struct irq_data *d)
+{
+	pdc_enable_intr(d, false);
+	irq_chip_mask_parent(d);
+}
+
+static void qcom_pdc_gic_unmask(struct irq_data *d)
+{
+	pdc_enable_intr(d, true);
+	irq_chip_unmask_parent(d);
+}
+
+/*
+ * GIC does not handle falling edge or active low. To allow falling edge and
+ * active low interrupts to be handled at GIC, PDC has an inverter that inverts
+ * falling edge into a rising edge and active low into an active high.
+ * For the inverter to work, the polarity bit in the IRQ_CONFIG register has to
+ * set as per the table below.
+ * Level sensitive active low    LOW
+ * Rising edge sensitive         NOT USED
+ * Falling edge sensitive        LOW
+ * Dual Edge sensitive           NOT USED
+ * Level sensitive active High   HIGH
+ * Falling Edge sensitive        NOT USED
+ * Rising edge sensitive         HIGH
+ * Dual Edge sensitive           HIGH
+ */
+enum pdc_irq_config_bits {
+	PDC_LEVEL_LOW		= 0b000,
+	PDC_EDGE_FALLING	= 0b010,
+	PDC_LEVEL_HIGH		= 0b100,
+	PDC_EDGE_RISING		= 0b110,
+	PDC_EDGE_DUAL		= 0b111,
+};
+
+/**
+ * qcom_pdc_gic_set_type: Configure PDC for the interrupt
+ *
+ * @d: the interrupt data
+ * @type: the interrupt type
+ *
+ * If @type is edge triggered, forward that as Rising edge as PDC
+ * takes care of converting falling edge to rising edge signal
+ * If @type is level, then forward that as level high as PDC
+ * takes care of converting falling edge to rising edge signal
+ */
+static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
+{
+	int pin_out = d->hwirq;
+	enum pdc_irq_config_bits pdc_type;
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		pdc_type = PDC_EDGE_RISING;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		pdc_type = PDC_EDGE_FALLING;
+		type = IRQ_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		pdc_type = PDC_EDGE_DUAL;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		pdc_type = PDC_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		pdc_type = PDC_LEVEL_LOW;
+		type = IRQ_TYPE_LEVEL_HIGH;
+		break;
+	default:
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	pdc_reg_write(IRQ_i_CFG, pin_out, pdc_type);
+
+	return irq_chip_set_type_parent(d, type);
+}
+
+static struct irq_chip qcom_pdc_gic_chip = {
+	.name			= "PDC",
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_mask		= qcom_pdc_gic_mask,
+	.irq_unmask		= qcom_pdc_gic_unmask,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_type		= qcom_pdc_gic_set_type,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND |
+				  IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE,
+	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+};
+
+static irq_hw_number_t get_parent_hwirq(int pin)
+{
+	int i;
+	struct pdc_pin_region *region;
+
+	for (i = 0; i < pdc_region_cnt; i++) {
+		region = &pdc_region[i];
+		if (pin >= region->pin_base &&
+		    pin < region->pin_base + region->cnt)
+			return (region->parent_base + pin - region->pin_base);
+	}
+
+	WARN_ON(1);
+	return ~0UL;
+}
+
+static int qcom_pdc_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
+			      unsigned long *hwirq, unsigned int *type)
+{
+	if (is_of_node(fwspec->fwnode)) {
+		if (fwspec->param_count != 2)
+			return -EINVAL;
+
+		*hwirq = fwspec->param[0];
+		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int qcom_pdc_alloc(struct irq_domain *domain, unsigned int virq,
+			  unsigned int nr_irqs, void *data)
+{
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec parent_fwspec;
+	irq_hw_number_t hwirq, parent_hwirq;
+	unsigned int type;
+	int ret;
+
+	ret = qcom_pdc_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return -EINVAL;
+
+	parent_hwirq = get_parent_hwirq(hwirq);
+	if (parent_hwirq == ~0UL)
+		return -EINVAL;
+
+	ret  = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
+					     &qcom_pdc_gic_chip, NULL);
+	if (ret)
+		return ret;
+
+	if (type & IRQ_TYPE_EDGE_BOTH)
+		type = IRQ_TYPE_EDGE_RISING;
+
+	if (type & IRQ_TYPE_LEVEL_MASK)
+		type = IRQ_TYPE_LEVEL_HIGH;
+
+	parent_fwspec.fwnode      = domain->parent->fwnode;
+	parent_fwspec.param_count = 3;
+	parent_fwspec.param[0]    = 0;
+	parent_fwspec.param[1]    = parent_hwirq;
+	parent_fwspec.param[2]    = type;
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
+					    &parent_fwspec);
+}
+
+static const struct irq_domain_ops qcom_pdc_ops = {
+	.translate	= qcom_pdc_translate,
+	.alloc		= qcom_pdc_alloc,
+	.free		= irq_domain_free_irqs_common,
+};
+
+static int pdc_setup_pin_mapping(struct device_node *np)
+{
+	int ret, n;
+
+	n = of_property_count_elems_of_size(np, "qcom,pdc-ranges", sizeof(u32));
+	if (n <= 0 || n % 3)
+		return -EINVAL;
+
+	pdc_region_cnt = n / 3;
+	pdc_region = kcalloc(pdc_region_cnt, sizeof(*pdc_region), GFP_KERNEL);
+	if (!pdc_region) {
+		pdc_region_cnt = 0;
+		return -ENOMEM;
+	}
+
+	for (n = 0; n < pdc_region_cnt; n++) {
+		ret = of_property_read_u32_index(np, "qcom,pdc-ranges",
+						 n * 3 + 0,
+						 &pdc_region[n].pin_base);
+		if (ret)
+			return ret;
+		ret = of_property_read_u32_index(np, "qcom,pdc-ranges",
+						 n * 3 + 1,
+						 &pdc_region[n].parent_base);
+		if (ret)
+			return ret;
+		ret = of_property_read_u32_index(np, "qcom,pdc-ranges",
+						 n * 3 + 2,
+						 &pdc_region[n].cnt);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
+{
+	struct irq_domain *parent_domain, *pdc_domain;
+	int ret;
+
+	pdc_base = of_iomap(node, 0);
+	if (!pdc_base) {
+		pr_err("%pOF: unable to map PDC registers\n", node);
+		return -ENXIO;
+	}
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("%pOF: unable to find PDC's parent domain\n", node);
+		ret = -ENXIO;
+		goto fail;
+	}
+
+	ret = pdc_setup_pin_mapping(node);
+	if (ret) {
+		pr_err("%pOF: failed to init PDC pin-hwirq mapping\n", node);
+		goto fail;
+	}
+
+	pdc_domain = irq_domain_create_hierarchy(parent_domain, 0, PDC_MAX_IRQS,
+						 of_fwnode_handle(node),
+						 &qcom_pdc_ops, NULL);
+	if (!pdc_domain) {
+		pr_err("%pOF: GIC domain add failed\n", node);
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	return 0;
+
+fail:
+	kfree(pdc_region);
+	iounmap(pdc_base);
+	return ret;
+}
+
+IRQCHIP_DECLARE(pdc_sdm845, "qcom,sdm845-pdc", qcom_pdc_init);
diff --git a/include/linux/irq.h b/include/linux/irq.h
index a0231e96a578..65916a305f3d 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -10,18 +10,13 @@
  * Thanks. --rmk
  */
 
-#include <linux/smp.h>
-#include <linux/linkage.h>
 #include <linux/cache.h>
 #include <linux/spinlock.h>
 #include <linux/cpumask.h>
-#include <linux/gfp.h>
 #include <linux/irqhandler.h>
 #include <linux/irqreturn.h>
 #include <linux/irqnr.h>
-#include <linux/errno.h>
 #include <linux/topology.h>
-#include <linux/wait.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 
@@ -1170,4 +1165,22 @@ int __ipi_send_mask(struct irq_desc *desc, const struct cpumask *dest);
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
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index c00c4c33e432..5988473e4abf 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -106,6 +106,7 @@
 #define GICR_PIDR2			GICD_PIDR2
 
 #define GICR_CTLR_ENABLE_LPIS		(1UL << 0)
+#define GICR_CTLR_RWP			(1UL << 3)
 
 #define GICR_TYPER_CPU_NUMBER(r)	(((r) >> 8) & 0xffff)
 
@@ -312,7 +313,8 @@
 #define GITS_TYPER_DEVBITS_SHIFT	13
 #define GITS_TYPER_DEVBITS(r)		((((r) >> GITS_TYPER_DEVBITS_SHIFT) & 0x1f) + 1)
 #define GITS_TYPER_PTA			(1UL << 19)
-#define GITS_TYPER_HWCOLLCNT_SHIFT	24
+#define GITS_TYPER_HCC_SHIFT		24
+#define GITS_TYPER_HCC(r)		(((r) >> GITS_TYPER_HCC_SHIFT) & 0xff)
 #define GITS_TYPER_VMOVP		(1ULL << 37)
 
 #define GITS_IIDR_REV_SHIFT		12
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
diff --git a/kernel/irq/autoprobe.c b/kernel/irq/autoprobe.c
index 8c82ea26e837..16cbf6beb276 100644
--- a/kernel/irq/autoprobe.c
+++ b/kernel/irq/autoprobe.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * linux/kernel/irq/autoprobe.c
- *
  * Copyright (C) 1992, 1998-2004 Linus Torvalds, Ingo Molnar
  *
  * This file contains the interrupt probing code and driver APIs.
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index c69357a43849..a2b3d9de999c 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1,13 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * linux/kernel/irq/chip.c
- *
  * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
  * Copyright (C) 2005-2006, Thomas Gleixner, Russell King
  *
- * This file contains the core interrupt handling code, for irq-chip
- * based architectures.
- *
- * Detailed information is available in Documentation/core-api/genericirq.rst
+ * This file contains the core interrupt handling code, for irq-chip based
+ * architectures. Detailed information is available in
+ * Documentation/core-api/genericirq.rst
  */
 
 #include <linux/irq.h>
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 9eb09aef0313..5b1072e394b2 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic cpu hotunplug interrupt migration code copied from the
  * arch/arm implementation
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index acfaaef8672a..4dadeb3d6666 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -1,8 +1,6 @@
-/*
- * Copyright 2017 Thomas Gleixner <tglx@linutronix.de>
- *
- * This file is licensed under the GPL V2.
- */
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2017 Thomas Gleixner <tglx@linutronix.de>
+
 #include <linux/irqdomain.h>
 #include <linux/irq.h>
 #include <linux/uaccess.h>
diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index 194c506d9d20..6a682c229e10 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
diff --git a/kernel/irq/dummychip.c b/kernel/irq/dummychip.c
index 326a67f2410b..0b0cdf206dc4 100644
--- a/kernel/irq/dummychip.c
+++ b/kernel/irq/dummychip.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
  * Copyright (C) 2005-2006, Thomas Gleixner, Russell King
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index 508c03dfef25..e2999a070a99 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Library implementing the most common irq chip callback functions
  *
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 79f987b942b8..38554bc35375 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * linux/kernel/irq/handle.c
- *
  * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
  * Copyright (C) 2005-2006, Thomas Gleixner, Russell King
  *
- * This file contains the core interrupt handling code.
- *
- * Detailed information is available in Documentation/core-api/genericirq.rst
+ * This file contains the core interrupt handling code. Detailed
+ * information is available in Documentation/core-api/genericirq.rst
  *
  */
 
@@ -20,6 +18,10 @@
 
 #include "internals.h"
 
+#ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER
+void (*handle_arch_irq)(struct pt_regs *) __ro_after_init;
+#endif
+
 /**
  * handle_bad_irq - handle spurious and unhandled irqs
  * @desc:      description of the interrupt
@@ -207,3 +209,14 @@ irqreturn_t handle_irq_event(struct irq_desc *desc)
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
diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
index 259a22aa9934..8b778e37dc6d 100644
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -1,6 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * linux/kernel/irq/ipi.c
- *
  * Copyright (C) 2015 Imagination Technologies Ltd
  * Author: Qais Yousef <qais.yousef@imgtec.com>
  *
diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 24caabf1a0f7..fc4f361a86bb 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2017 Bartosz Golaszewski <brgl@bgdev.pl>
  *
@@ -7,6 +8,7 @@
  * option) any later version.
  */
 
+#include <linux/slab.h>
 #include <linux/irq_sim.h>
 #include <linux/irq.h>
 
@@ -49,7 +51,8 @@ static void irq_sim_handle_irq(struct irq_work *work)
  * @sim:        The interrupt simulator object to initialize.
  * @num_irqs:   Number of interrupts to allocate
  *
- * Returns 0 on success and a negative error number on failure.
+ * On success: return the base of the allocated interrupt range.
+ * On failure: a negative errno.
  */
 int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
 {
@@ -78,7 +81,7 @@ int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
 	init_irq_work(&sim->work_ctx.work, irq_sim_handle_irq);
 	sim->irq_count = num_irqs;
 
-	return 0;
+	return sim->irq_base;
 }
 EXPORT_SYMBOL_GPL(irq_sim_init);
 
@@ -110,7 +113,8 @@ static void devm_irq_sim_release(struct device *dev, void *res)
  * @sim:        The interrupt simulator object to initialize.
  * @num_irqs:   Number of interrupts to allocate
  *
- * Returns 0 on success and a negative error number on failure.
+ * On success: return the base of the allocated interrupt range.
+ * On failure: a negative errno.
  */
 int devm_irq_sim_init(struct device *dev, struct irq_sim *sim,
 		      unsigned int num_irqs)
@@ -123,7 +127,7 @@ int devm_irq_sim_init(struct device *dev, struct irq_sim *sim,
 		return -ENOMEM;
 
 	rv = irq_sim_init(sim, num_irqs);
-	if (rv) {
+	if (rv < 0) {
 		devres_free(dr);
 		return rv;
 	}
@@ -131,7 +135,7 @@ int devm_irq_sim_init(struct device *dev, struct irq_sim *sim,
 	dr->sim = sim;
 	devres_add(dev, dr);
 
-	return 0;
+	return rv;
 }
 EXPORT_SYMBOL_GPL(devm_irq_sim_init);
 
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 49b54e9979cc..afc7f902d74a 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -1,10 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
  * Copyright (C) 2005-2006, Thomas Gleixner, Russell King
  *
- * This file contains the interrupt descriptor management code
- *
- * Detailed information is available in Documentation/core-api/genericirq.rst
+ * This file contains the interrupt descriptor management code. Detailed
+ * information is available in Documentation/core-api/genericirq.rst
  *
  */
 #include <linux/irq.h>
@@ -210,6 +210,22 @@ static ssize_t type_show(struct kobject *kobj,
 }
 IRQ_ATTR_RO(type);
 
+static ssize_t wakeup_show(struct kobject *kobj,
+			   struct kobj_attribute *attr, char *buf)
+{
+	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
+	ssize_t ret = 0;
+
+	raw_spin_lock_irq(&desc->lock);
+	ret = sprintf(buf, "%s\n",
+		      irqd_is_wakeup_set(&desc->irq_data) ? "enabled" : "disabled");
+	raw_spin_unlock_irq(&desc->lock);
+
+	return ret;
+
+}
+IRQ_ATTR_RO(wakeup);
+
 static ssize_t name_show(struct kobject *kobj,
 			 struct kobj_attribute *attr, char *buf)
 {
@@ -253,6 +269,7 @@ static struct attribute *irq_attrs[] = {
 	&chip_name_attr.attr,
 	&hwirq_attr.attr,
 	&type_attr.attr,
+	&wakeup_attr.attr,
 	&name_attr.attr,
 	&actions_attr.attr,
 	NULL
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 82b8b18ee1eb..5d9fc01b60a6 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 #define pr_fmt(fmt)  "irq: " fmt
 
 #include <linux/acpi.h>
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 0f922729bab9..e3336d904f64 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1,6 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * linux/kernel/irq/manage.c
- *
  * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
  * Copyright (C) 2005-2006 Thomas Gleixner
  *
@@ -855,10 +854,14 @@ irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action)
 	 * This code is triggered unconditionally. Check the affinity
 	 * mask pointer. For CPU_MASK_OFFSTACK=n this is optimized out.
 	 */
-	if (cpumask_available(desc->irq_common_data.affinity))
-		cpumask_copy(mask, desc->irq_common_data.affinity);
-	else
+	if (cpumask_available(desc->irq_common_data.affinity)) {
+		const struct cpumask *m;
+
+		m = irq_data_get_effective_affinity_mask(&desc->irq_data);
+		cpumask_copy(mask, m);
+	} else {
 		valid = false;
+	}
 	raw_spin_unlock_irq(&desc->lock);
 
 	if (valid)
@@ -1519,9 +1522,9 @@ EXPORT_SYMBOL_GPL(setup_irq);
  * Internal function to unregister an irqaction - used to free
  * regular and special interrupts that are part of the architecture.
  */
-static struct irqaction *__free_irq(unsigned int irq, void *dev_id)
+static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 {
-	struct irq_desc *desc = irq_to_desc(irq);
+	unsigned irq = desc->irq_data.irq;
 	struct irqaction *action, **action_ptr;
 	unsigned long flags;
 
@@ -1651,7 +1654,7 @@ void remove_irq(unsigned int irq, struct irqaction *act)
 	struct irq_desc *desc = irq_to_desc(irq);
 
 	if (desc && !WARN_ON(irq_settings_is_per_cpu_devid(desc)))
-		__free_irq(irq, act->dev_id);
+		__free_irq(desc, act->dev_id);
 }
 EXPORT_SYMBOL_GPL(remove_irq);
 
@@ -1685,7 +1688,7 @@ const void *free_irq(unsigned int irq, void *dev_id)
 		desc->affinity_notify = NULL;
 #endif
 
-	action = __free_irq(irq, dev_id);
+	action = __free_irq(desc, dev_id);
 
 	if (!action)
 		return NULL;
diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 4c5770407031..5092494bf261 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -1,8 +1,6 @@
-/*
- * Copyright (C) 2017 Thomas Gleixner <tglx@linutronix.de>
- *
- * SPDX-License-Identifier: GPL-2.0
- */
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2017 Thomas Gleixner <tglx@linutronix.de>
+
 #include <linux/spinlock.h>
 #include <linux/seq_file.h>
 #include <linux/bitmap.h>
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 2f3c4f5382cc..2a8571f72b17 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1,6 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * linux/kernel/irq/msi.c
- *
  * Copyright (C) 2014 Intel Corp.
  * Author: Jiang Liu <jiang.liu@linux.intel.com>
  *
diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index 6bd9b58429cc..d6961d3c6f9e 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -1,6 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * linux/kernel/irq/pm.c
- *
  * Copyright (C) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
  *
  * This file contains power management functions related to interrupts.
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index e8f374971e37..7cb091d81d91 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * linux/kernel/irq/proc.c
- *
  * Copyright (C) 1992, 1998-2004 Linus Torvalds, Ingo Molnar
  *
  * This file contains the /proc/irq/ handling code.
diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index 1d08f45135c2..95414ad3506a 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * linux/kernel/irq/resend.c
- *
  * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
  * Copyright (C) 2005-2006, Thomas Gleixner
  *
diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index 6cdecc6f4c53..d867d6ddafdd 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * linux/kernel/irq/spurious.c
- *
  * Copyright (C) 1992, 1998-2004 Linus Torvalds, Ingo Molnar
  *
  * This file contains spurious interrupt handling.
diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index e0923fa4927a..1e4cb63a5c82 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -1,13 +1,6 @@
-/*
- * linux/kernel/irq/timings.c
- *
- * Copyright (C) 2016, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2016, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
+
 #include <linux/kernel.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 24d243ef8e71..177de3640c78 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -460,40 +460,46 @@ struct tasklet_head {
 static DEFINE_PER_CPU(struct tasklet_head, tasklet_vec);
 static DEFINE_PER_CPU(struct tasklet_head, tasklet_hi_vec);
 
-void __tasklet_schedule(struct tasklet_struct *t)
+static void __tasklet_schedule_common(struct tasklet_struct *t,
+				      struct tasklet_head __percpu *headp,
+				      unsigned int softirq_nr)
 {
+	struct tasklet_head *head;
 	unsigned long flags;
 
 	local_irq_save(flags);
+	head = this_cpu_ptr(headp);
 	t->next = NULL;
-	*__this_cpu_read(tasklet_vec.tail) = t;
-	__this_cpu_write(tasklet_vec.tail, &(t->next));
-	raise_softirq_irqoff(TASKLET_SOFTIRQ);
+	*head->tail = t;
+	head->tail = &(t->next);
+	raise_softirq_irqoff(softirq_nr);
 	local_irq_restore(flags);
 }
+
+void __tasklet_schedule(struct tasklet_struct *t)
+{
+	__tasklet_schedule_common(t, &tasklet_vec,
+				  TASKLET_SOFTIRQ);
+}
 EXPORT_SYMBOL(__tasklet_schedule);
 
 void __tasklet_hi_schedule(struct tasklet_struct *t)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
-	t->next = NULL;
-	*__this_cpu_read(tasklet_hi_vec.tail) = t;
-	__this_cpu_write(tasklet_hi_vec.tail,  &(t->next));
-	raise_softirq_irqoff(HI_SOFTIRQ);
-	local_irq_restore(flags);
+	__tasklet_schedule_common(t, &tasklet_hi_vec,
+				  HI_SOFTIRQ);
 }
 EXPORT_SYMBOL(__tasklet_hi_schedule);
 
-static __latent_entropy void tasklet_action(struct softirq_action *a)
+static void tasklet_action_common(struct softirq_action *a,
+				  struct tasklet_head *tl_head,
+				  unsigned int softirq_nr)
 {
 	struct tasklet_struct *list;
 
 	local_irq_disable();
-	list = __this_cpu_read(tasklet_vec.head);
-	__this_cpu_write(tasklet_vec.head, NULL);
-	__this_cpu_write(tasklet_vec.tail, this_cpu_ptr(&tasklet_vec.head));
+	list = tl_head->head;
+	tl_head->head = NULL;
+	tl_head->tail = &tl_head->head;
 	local_irq_enable();
 
 	while (list) {
@@ -515,47 +521,21 @@ static __latent_entropy void tasklet_action(struct softirq_action *a)
 
 		local_irq_disable();
 		t->next = NULL;
-		*__this_cpu_read(tasklet_vec.tail) = t;
-		__this_cpu_write(tasklet_vec.tail, &(t->next));
-		__raise_softirq_irqoff(TASKLET_SOFTIRQ);
+		*tl_head->tail = t;
+		tl_head->tail = &t->next;
+		__raise_softirq_irqoff(softirq_nr);
 		local_irq_enable();
 	}
 }
 
-static __latent_entropy void tasklet_hi_action(struct softirq_action *a)
+static __latent_entropy void tasklet_action(struct softirq_action *a)
 {
-	struct tasklet_struct *list;
-
-	local_irq_disable();
-	list = __this_cpu_read(tasklet_hi_vec.head);
-	__this_cpu_write(tasklet_hi_vec.head, NULL);
-	__this_cpu_write(tasklet_hi_vec.tail, this_cpu_ptr(&tasklet_hi_vec.head));
-	local_irq_enable();
-
-	while (list) {
-		struct tasklet_struct *t = list;
-
-		list = list->next;
-
-		if (tasklet_trylock(t)) {
-			if (!atomic_read(&t->count)) {
-				if (!test_and_clear_bit(TASKLET_STATE_SCHED,
-							&t->state))
-					BUG();
-				t->func(t->data);
-				tasklet_unlock(t);
-				continue;
-			}
-			tasklet_unlock(t);
-		}
+	tasklet_action_common(a, this_cpu_ptr(&tasklet_vec), TASKLET_SOFTIRQ);
+}
 
-		local_irq_disable();
-		t->next = NULL;
-		*__this_cpu_read(tasklet_hi_vec.tail) = t;
-		__this_cpu_write(tasklet_hi_vec.tail, &(t->next));
-		__raise_softirq_irqoff(HI_SOFTIRQ);
-		local_irq_enable();
-	}
+static __latent_entropy void tasklet_hi_action(struct softirq_action *a)
+{
+	tasklet_action_common(a, this_cpu_ptr(&tasklet_hi_vec), HI_SOFTIRQ);
 }
 
 void tasklet_init(struct tasklet_struct *t,
--8323329-1435544939-1522757037=:2511--
