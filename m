Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B28C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7120421873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbfB0QGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:06:22 -0500
Received: from mga02.intel.com ([134.134.136.20]:24149 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729987AbfB0QFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:05:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 08:05:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="303011718"
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
  by orsmga005.jf.intel.com with ESMTP; 27 Feb 2019 08:05:53 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     Ashok Raj <ashok.raj@intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [RFC PATCH v2 11/14] x86/watchdog/hardlockup: Add an HPET-based hardlockup detector
Date:   Wed, 27 Feb 2019 08:05:15 -0800
Message-Id: <1551283518-18922-12-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the initial implementation of a hardlockup detector driven by an
HPET timer. This initial implementation includes functions to control
the timer via its registers. It also requests such timer, installs
an NMI interrupt handler and performs the initial configuration of
the timer.

The detector is not functional at this stage. A subsequent changeset will
invoke the interfaces provides by this detector.

In order to minimize the reconfiguration of interrupts, the HPET timer
always target the same CPU (the first CPU present in the
watchdog_allowed_mask cpumask, the handling CPU). If the HPET caused
an NMI on the handling CPU, an NMI interprocessor interrupt is sent
to the other CPUs in the watchdog_allowed_mask. Upon receiving the
interrupt, such CPUs will check a cpumask and inspect for hardlockups
if requested in such mask.

This detector relies on an HPET timer that is capable of using Front Side
Bus interrupts. In order to avoid using the generic interrupt code,
program directly the MSI message register of the HPET timer.

HPET registers are only accessed to kick the timer after looking for
hardlockups. This happens every watchdog_thresh seconds. A subsequent
changeset will determine whether the HPET timer caused the interrupt based
on the value of the time-stamp counter. For now, just add a stub function.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: x86@kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/Kconfig.debug              |  10 +
 arch/x86/include/asm/hpet.h         |  12 +
 arch/x86/kernel/Makefile            |   1 +
 arch/x86/kernel/watchdog_hld_hpet.c | 405 ++++++++++++++++++++++++++++
 4 files changed, 428 insertions(+)
 create mode 100644 arch/x86/kernel/watchdog_hld_hpet.c

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 15d0fbe27872..3a2845a29e8a 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -169,6 +169,16 @@ config IOMMU_LEAK
 config HAVE_MMIOTRACE_SUPPORT
 	def_bool y
 
+config X86_HARDLOCKUP_DETECTOR_HPET
+	bool "Use HPET Timer for Hard Lockup Detection"
+	select SOFTLOCKUP_DETECTOR
+	select HARDLOCKUP_DETECTOR
+	depends on HPET_TIMER && HPET && X86_64
+	help
+	  Say y to enable a hardlockup detector that is driven by an High-
+	  Precision Event Timer. This option is helpful to not use counters
+	  from the Performance Monitoring Unit to drive the detector.
+
 config X86_DECODER_SELFTEST
 	bool "x86 instruction decoder selftest"
 	depends on DEBUG_KERNEL && KPROBES
diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 4d559e0c746f..15dc3b576496 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -123,12 +123,24 @@ struct hpet_hld_data {
 	u32		num;
 	u32		flags;
 	u64		ticks_per_second;
+	u32		handling_cpu;
+	struct cpumask	cpu_monitored_mask;
+	struct msi_msg	msi_msg;
 };
 
 extern struct hpet_hld_data *hpet_hardlockup_detector_assign_timer(void);
+extern int hardlockup_detector_hpet_init(void);
+extern void hardlockup_detector_hpet_stop(void);
+extern void hardlockup_detector_hpet_enable(void);
+extern void hardlockup_detector_hpet_disable(void);
 #else
 static inline struct hpet_hld_data *hpet_hardlockup_detector_assign_timer(void)
 { return NULL; }
+static inline int hardlockup_detector_hpet_init(void)
+{ return -ENODEV; }
+static inline void hardlockup_detector_hpet_stop(void) {}
+static inline void hardlockup_detector_hpet_enable(void) {}
+static inline void hardlockup_detector_hpet_disable(void) {}
 #endif /* CONFIG_X86_HARDLOCKUP_DETECTOR_HPET */
 
 #else /* CONFIG_HPET_TIMER */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 00b7e27bc2b7..9d610e8a9224 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -106,6 +106,7 @@ obj-$(CONFIG_VM86)		+= vm86_32.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
+obj-$(CONFIG_X86_HARDLOCKUP_DETECTOR_HPET) += watchdog_hld_hpet.o
 obj-$(CONFIG_APB_TIMER)		+= apb_timer.o
 
 obj-$(CONFIG_AMD_NB)		+= amd_nb.o
diff --git a/arch/x86/kernel/watchdog_hld_hpet.c b/arch/x86/kernel/watchdog_hld_hpet.c
new file mode 100644
index 000000000000..cfa284da4bf6
--- /dev/null
+++ b/arch/x86/kernel/watchdog_hld_hpet.c
@@ -0,0 +1,405 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A hardlockup detector driven by an HPET timer.
+ *
+ * Copyright (C) Intel Corporation 2019
+ *
+ * A hardlockup detector driven by an HPET timer. It implements the same
+ * interfaces as the PERF-based hardlockup detector.
+ *
+ * In order to minimize the reconfiguration of interrupts, the HPET timer
+ * always targets the same CPU (the first CPU present in the
+ * watchdog_allowed_mask cpumask, the handling CPU). If the HPET caused
+ * an NMI on the handling CPU, an NMI interprocessor interrupt is sent
+ * to the other CPUs in the watchdog_allowed_mask.
+ */
+
+#include <linux/nmi.h>
+#include <linux/hpet.h>
+#include <asm/msidef.h>
+#include <asm/hpet.h>
+
+static struct hpet_hld_data *hld_data;
+
+/**
+ * get_count() - Get the current count of the HPET timer
+ *
+ * Returns:
+ *
+ * Value of the main counter of the HPET timer
+ */
+static inline unsigned long get_count(void)
+{
+	return hpet_readq(HPET_COUNTER);
+}
+
+/**
+ * set_comparator() - Update the comparator in an HPET timer instance
+ * @hdata:	A data structure with the timer instance to update
+ * @cmp:	The value to write in the in the comparator registere
+ *
+ * Returns:
+ *
+ * None
+ */
+static inline void set_comparator(struct hpet_hld_data *hdata,
+				  unsigned long cmp)
+{
+	hpet_writeq(cmp, HPET_Tn_CMP(hdata->num));
+}
+
+/**
+ * kick_timer() - Reprogram timer to expire in the future
+ * @hdata:	A data structure with the timer instance to update
+ * @force:	Force reprogram. Useful enabling or re-enabling detector.
+ *
+ * Reprogram the timer to expire within watchdog_thresh seconds in the future.
+ *
+ * Returns:
+ *
+ * None
+ */
+static void kick_timer(struct hpet_hld_data *hdata, bool force)
+{
+	bool kick_needed = force || !(hdata->flags & HPET_DEV_PERI_CAP);
+	unsigned long new_compare, count;
+
+	/*
+	 * Update the comparator in increments of watch_thresh seconds relative
+	 * to the current count. Since watch_thresh is given in seconds, we
+	 * are able to update the comparator before the counter reaches such new
+	 * value.
+	 *
+	 * Let it wrap around if needed.
+	 */
+
+	if (kick_needed) {
+		count = get_count();
+
+		new_compare = count + watchdog_thresh * hdata->ticks_per_second;
+
+		set_comparator(hdata, new_compare);
+	}
+}
+
+/**
+ * disable_timer() - Disable an HPET timer instance
+ * @hdata:	A data structure with the timer instance to disable
+ *
+ * Returns:
+ *
+ * None
+ */
+static void disable_timer(struct hpet_hld_data *hdata)
+{
+	unsigned int v;
+
+	v = hpet_readl(HPET_Tn_CFG(hdata->num));
+	v &= ~HPET_TN_ENABLE;
+	hpet_writel(v, HPET_Tn_CFG(hdata->num));
+}
+
+/**
+ * enable_timer() - Enable an HPET timer instance
+ * @hdata:	A data structure with the timer instance to enable
+ *
+ * Returns:
+ *
+ * None
+ */
+static void enable_timer(struct hpet_hld_data *hdata)
+{
+	unsigned long v;
+
+	v = hpet_readl(HPET_Tn_CFG(hdata->num));
+	v |= HPET_TN_ENABLE;
+	hpet_writel(v, HPET_Tn_CFG(hdata->num));
+}
+
+/**
+ * set_periodic() - Set an HPET timer instance in periodic mode
+ * @hdata:	A data structure with the timer instance to enable
+ *
+ * If the timer supports periodic mode, configure it in such mode.
+ * Returns:
+ *
+ * None
+ */
+static void set_periodic(struct hpet_hld_data *hdata)
+{
+	unsigned long v;
+
+	if (!(hdata->flags & HPET_DEV_PERI_CAP))
+		return;
+
+	v = hpet_readl(HPET_Tn_CFG(hdata->num));
+	v |= HPET_TN_PERIODIC;
+	hpet_writel(v, HPET_Tn_CFG(hdata->num));
+}
+
+/**
+ * is_hpet_wdt_interrupt() - Determine if an HPET timer caused interrupt
+ * @hdata:	A data structure with the timer instance to enable
+ *
+ * Returns:
+ *
+ * True if the HPET watchdog timer caused the interrupt. False otherwise.
+ */
+static bool is_hpet_wdt_interrupt(struct hpet_hld_data *hdata)
+{
+	return false;
+}
+
+/**
+ * compose_msi_msg() - Populate address and data fields of an MSI message
+ * @hdata:	A data strucure with the message to populate
+ *
+ * Populate an MSI message to deliver an NMI interrupt. Fields are populated
+ * as in the MSI interrupt domain. This function does not populate the
+ * Destination ID.
+ *
+ * Returns: none
+ */
+static void compose_msi_msg(struct hpet_hld_data *hdata)
+{
+	struct msi_msg *msg = &hdata->msi_msg;
+
+	/*
+	 * The HPET FSB Interrupt Route register does not have an
+	 * address_hi part.
+	 */
+	msg->address_lo = MSI_ADDR_BASE_LO;
+
+	if (apic->irq_dest_mode == 0)
+		msg->address_lo |= MSI_ADDR_DEST_MODE_PHYSICAL;
+	else
+		msg->address_lo |= MSI_ADDR_DEST_MODE_LOGICAL;
+
+	msg->address_lo |= MSI_ADDR_REDIRECTION_CPU;
+
+	/*
+	 * On edge trigger, we don't care about assert level. Also,
+	 * since delivery mode is NMI, no irq vector is needed.
+	 */
+	msg->data = MSI_DATA_TRIGGER_EDGE | MSI_DATA_LEVEL_ASSERT |
+		    MSI_DATA_DELIVERY_NMI;
+}
+
+/** update_handling_cpu() - Update APIC destid of handling CPU
+ * @hdata:	A data strucure with the MSI message to update
+ *
+ * Update the APIC destid of the MSI message generated by the HPET timer
+ * on expiration.
+ */
+static int update_handling_cpu(struct hpet_hld_data *hdata)
+{
+	unsigned int destid;
+
+	hdata->msi_msg.address_lo &= ~MSI_ADDR_DEST_ID_MASK;
+	destid = apic->calc_dest_apicid(hdata->handling_cpu);
+	hdata->msi_msg.address_lo |= MSI_ADDR_DEST_ID(destid);
+
+	hpet_writel(hdata->msi_msg.address_lo, HPET_Tn_ROUTE(hdata->num) + 4);
+
+	return 0;
+}
+
+/**
+ * hardlockup_detector_nmi_handler() - NMI Interrupt handler
+ * @val:	Attribute associated with the NMI. Not used.
+ * @regs:	Register values as seen when the NMI was asserted
+ *
+ * When in NMI context, check if it was caused by the expiration of the
+ * HPET timer. If yes, create a CPU mask to issue an IPI to the rest
+ * of monitored CPUs. Upon receiving their own NMI, the other CPUs will
+ * check such mask to determine if they need to also look for lockups.
+ *
+ * Returns:
+ *
+ * NMI_DONE if the HPET timer did not cause the interrupt. NMI_HANDLED
+ * otherwise.
+ */
+static int hardlockup_detector_nmi_handler(unsigned int val,
+					   struct pt_regs *regs)
+{
+	struct hpet_hld_data *hdata = hld_data;
+	unsigned int cpu = smp_processor_id();
+
+	if (is_hpet_wdt_interrupt(hdata)) {
+		/* Get ready to check other CPUs for hardlockups. */
+		cpumask_copy(&hdata->cpu_monitored_mask,
+			     watchdog_get_allowed_cpumask());
+		cpumask_clear_cpu(smp_processor_id(),
+				  &hdata->cpu_monitored_mask);
+
+		apic->send_IPI_mask_allbutself(&hdata->cpu_monitored_mask,
+					       NMI_VECTOR);
+
+		kick_timer(hdata, !(hdata->flags & HPET_DEV_PERI_CAP));
+
+		inspect_for_hardlockups(regs);
+
+		return NMI_HANDLED;
+	}
+
+	if (cpumask_test_and_clear_cpu(cpu, &hdata->cpu_monitored_mask)) {
+		inspect_for_hardlockups(regs);
+		return NMI_HANDLED;
+	}
+
+	return NMI_DONE;
+}
+
+/**
+ * setup_irq_msi_mode() - Configure the timer to deliver an MSI interrupt
+ * @data:	Data associated with the instance of the HPET timer to configure
+ *
+ * Configure an instance of the HPET timer to deliver interrupts via the Front-
+ * Side Bus.
+ *
+ * Returns:
+ *
+ * 0 success. An error code in configuration was unsuccessful.
+ */
+static int setup_irq_msi_mode(struct hpet_hld_data *hdata)
+{
+	unsigned int v;
+
+	compose_msi_msg(hdata);
+	hpet_writel(hdata->msi_msg.data, HPET_Tn_ROUTE(hdata->num));
+	hpet_writel(hdata->msi_msg.address_lo, HPET_Tn_ROUTE(hdata->num) + 4);
+
+	/*
+	 * Since FSB interrupt delivery is used, configure as edge-triggered
+	 * interrupt.
+	 */
+	v = hpet_readl(HPET_Tn_CFG(hdata->num));
+	v &= ~HPET_TN_LEVEL;
+	v |= HPET_TN_FSB;
+
+	hpet_writel(v, HPET_Tn_CFG(hdata->num));
+
+	return 0;
+}
+
+/**
+ * setup_hpet_irq() - Configure the interrupt delivery of an HPET timer
+ * @data:	Data associated with the instance of the HPET timer to configure
+ *
+ * Configure the interrupt parameters of an HPET timer. If supported, configure
+ * interrupts to be delivered via the Front-Side Bus. Also, install an interrupt
+ * handler.
+ *
+ * Returns:
+ *
+ * 0 success. An error code in configuration was unsuccessful.
+ */
+static int setup_hpet_irq(struct hpet_hld_data *hdata)
+{
+	int ret;
+
+	ret = setup_irq_msi_mode(hdata);
+	if (ret)
+		return ret;
+
+	ret = register_nmi_handler(NMI_LOCAL, hardlockup_detector_nmi_handler,
+				   0, "hpet_hld");
+
+	return ret;
+}
+
+/**
+ * hardlockup_detector_hpet_enable() - Enable the hardlockup detector
+ *
+ * This function is called for each CPU that enables the lockup watchdog.
+ * Since the HPET timer only targets the handling CPU, configure the timer
+ * only in such case.
+ *
+ * Returns:
+ *
+ * None
+ */
+void hardlockup_detector_hpet_enable(void)
+{
+	struct cpumask *allowed = watchdog_get_allowed_cpumask();
+	unsigned int cpu = smp_processor_id();
+
+	if (!hld_data)
+		return;
+
+	hld_data->handling_cpu = cpumask_first(allowed);
+
+	if (cpu == hld_data->handling_cpu) {
+		update_handling_cpu(hld_data);
+		/* Force timer kick when detector is just enabled */
+		kick_timer(hld_data, true);
+		enable_timer(hld_data);
+	}
+}
+
+/**
+ * hardlockup_detector_hpet_disable() - Disable the hardlockup detector
+ *
+ * The hardlockup detector is disabled for the CPU that executes the
+ * function.
+ *
+ * None
+ */
+void hardlockup_detector_hpet_disable(void)
+{
+	struct cpumask *allowed = watchdog_get_allowed_cpumask();
+
+	if (!hld_data)
+		return;
+
+	/* Only disable the timer if there are no more CPUs to monitor. */
+	if (!cpumask_weight(allowed))
+		disable_timer(hld_data);
+}
+
+/**
+ * hardlockup_detector_hpet_stop() - Stop the NMI watchdog on all CPUs
+ *
+ * Returns:
+ *
+ * None
+ */
+void hardlockup_detector_hpet_stop(void)
+{
+	disable_timer(hld_data);
+}
+
+/**
+ * hardlockup_detector_hpet_init() - Initialize the hardlockup detector
+ *
+ * Only initialize and configure the detector if an HPET is available on the
+ * system.
+ *
+ * Returns:
+ *
+ * 0 success. An error code if initialization was unsuccessful.
+ */
+int __init hardlockup_detector_hpet_init(void)
+{
+	int ret;
+
+	if (!is_hpet_enabled())
+		return -ENODEV;
+
+	if (check_tsc_unstable())
+		return -ENODEV;
+
+	hld_data = hpet_hardlockup_detector_assign_timer();
+	if (!hld_data)
+		return -ENODEV;
+
+	disable_timer(hld_data);
+
+	set_periodic(hld_data);
+
+	ret = setup_hpet_irq(hld_data);
+	if (ret)
+		return -ENODEV;
+
+	return 0;
+}
-- 
2.17.1

