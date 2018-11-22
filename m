Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32872C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47C3206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47C3206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391888AbeKVNtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 08:49:39 -0500
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:35000
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732252AbeKVNtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 08:49:23 -0500
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id PfOPgMUqUThUePfOPghpQE; Wed, 21 Nov 2018 20:11:02 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1gPfOP-0004GK-OO; Wed, 21 Nov 2018 20:11:01 -0700
From:   kys@linuxonhyperv.com
To:     will.deacon@arm.com, catalin.marinas@armm.com,
        mark.rutland@arm.com, marc.zyngier@arm.com,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        olaf@aepfle.de, apw@canonical.com, jasowang@redhat.com,
        sthemmin@microsoft.com, Michael.H.Kelley@microsoft.com,
        vkuznets@redhat.com
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 2/4] arm64: hyperv: Add support for Hyper-V as a hypervisor
Date:   Thu, 22 Nov 2018 03:10:57 +0000
Message-Id: <20181122031059.16338-2-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122031059.16338-1-kys@linuxonhyperv.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
MIME-Version: 1.0
Reply-To: kys@microsoft.com
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOD/gu8IQ/SJ9537r95U31Kscvj1UN2zmSB37Z27u5ajKkSsunolZUMT1Pn5C16YgQeu+j9THToR2S5wrgXEiDnXodudPa9wgU1HnhBpRKBIbNE9n9VE
 VrVmlQr0R+tzvRyCBtAWPqgr2+BoweVaYUlUhB6PrmGy1VsrxvOMWlwq6vSdWGDDWhzy8ViMRfficma706ZfYudeGBC4epyYBzIYl8uJqtMSNLUlLcvSXy9r
 9UZui0lnpxzYisrmmUsWRZ4/I+MaS1bIijTOU9Y/9HcdqhiZO2LlFYC79pzZX01mCg9N3TprTIaNgOaxEyqg6OIyUSOheDV5GXAoG2oM5erVqMQxcaRIZSb+
 a+Sy9gcWZBtDNfQyiSnt8B11sd3EGV5F3Rx+Tt3KSvc1EzDF5xMij/XtRUYJjvoUfg+Pn6Zig2r1jvA1kf+oEmF1tXfsi31Ia3bU0dGP6YwyflenF3gbPOKS
 0Fw9sSvfGt2xN50TKakUqgO04NXsn8g9mR5VAWI1Jx5zABxRYe8Ht2laldtG9/L5S/pQy6VtAwNn76xXxVLTIREmt5arf1hPqe13qwTImlrmtjS3NcOV5rfL
 VGd5g2R4Eu3cAbiWftPTjcEjJOUhHaS0t5TWprZDLle2hUSiK0XLdpj2CKo8VewQ5hv3+58hHQ6wAJPBGP0JuRTTnt5SsAGElG/qlDe1sHTyTa0DeIYK0YTg
 b0hMn7r1pTfA2Y/OLx7Vyb0zayRjaWILNd/tu1FahbS7qvVvIXjglw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

Add ARM64-specific code to enable Hyper-V. This code includes:
* Detecting Hyper-V and initializing the guest/Hyper-V interface
* Setting up Hyper-V's synthetic clocks
* Making hypercalls using the HVC instruction
* Setting up VMbus and stimer0 interrupts
* Setting up kexec and crash handlers
This code is architecture dependent code and is mostly driven by
architecture independent code in the VMbus driver in drivers/hv/hv.c
and drivers/hv/vmbus_drv.c.

This code is built only when CONFIG_HYPERV is enabled.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 MAINTAINERS                  |   1 +
 arch/arm64/Makefile          |   1 +
 arch/arm64/hyperv/Makefile   |   2 +
 arch/arm64/hyperv/hv_hvc.S   |  54 +++++
 arch/arm64/hyperv/hv_init.c  | 441 +++++++++++++++++++++++++++++++++++
 arch/arm64/hyperv/mshyperv.c | 178 ++++++++++++++
 6 files changed, 677 insertions(+)
 create mode 100644 arch/arm64/hyperv/Makefile
 create mode 100644 arch/arm64/hyperv/hv_hvc.S
 create mode 100644 arch/arm64/hyperv/hv_init.c
 create mode 100644 arch/arm64/hyperv/mshyperv.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 72f19cef4c48..326eeb32a0cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6837,6 +6837,7 @@ F:	arch/x86/kernel/cpu/mshyperv.c
 F:	arch/x86/hyperv
 F:	arch/arm64/include/asm/hyperv-tlfs.h
 F:	arch/arm64/include/asm/mshyperv.h
+F:	arch/arm64/hyperv
 F:	drivers/hid/hid-hyperv.c
 F:	drivers/hv/
 F:	drivers/input/serio/hyperv-keyboard.c
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 6cb9fc7e9382..ad9ec0579553 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -106,6 +106,7 @@ core-y		+= arch/arm64/kernel/ arch/arm64/mm/
 core-$(CONFIG_NET) += arch/arm64/net/
 core-$(CONFIG_KVM) += arch/arm64/kvm/
 core-$(CONFIG_XEN) += arch/arm64/xen/
+core-$(CONFIG_HYPERV) += arch/arm64/hyperv/
 core-$(CONFIG_CRYPTO) += arch/arm64/crypto/
 libs-y		:= arch/arm64/lib/ $(libs-y)
 core-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
new file mode 100644
index 000000000000..988eda55330c
--- /dev/null
+++ b/arch/arm64/hyperv/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y		:= hv_init.o hv_hvc.o mshyperv.o
diff --git a/arch/arm64/hyperv/hv_hvc.S b/arch/arm64/hyperv/hv_hvc.S
new file mode 100644
index 000000000000..82636969b4f2
--- /dev/null
+++ b/arch/arm64/hyperv/hv_hvc.S
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Microsoft Hyper-V hypervisor invocation routines
+ *
+ * Copyright (C) 2018, Microsoft, Inc.
+ *
+ * Author : Michael Kelley <mikelley@microsoft.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ */
+
+#include <linux/linkage.h>
+
+	.text
+/*
+ * Do the HVC instruction.  For Hyper-V the argument is always 1.
+ * x0 contains the hypercall control value, while additional registers
+ * vary depending on the hypercall, and whether the hypercall arguments
+ * are in memory or in registers (a "fast" hypercall per the Hyper-V
+ * TLFS).  When the arguments are in memory x1 is the guest physical
+ * address of the input arguments, and x2 is the guest physical
+ * address of the output arguments.  When the arguments are in
+ * registers, the register values depends on the hypercall.  Note
+ * that this version cannot return any values in registers.
+ */
+ENTRY(hv_do_hvc)
+	hvc #1
+	ret
+ENDPROC(hv_do_hvc)
+
+/*
+ * This variant of HVC invocation is for hv_get_vpreg and
+ * hv_get_vpreg_128. The input parameters are passed in registers
+ * along with a pointer in x4 to where the output result should
+ * be stored. The output is returned in x15 and x16.  x18 is used as
+ * scratch space to avoid buildng a stack frame, as Hyper-V does
+ * not preserve registers x0-x17.
+ */
+ENTRY(hv_do_hvc_fast_get)
+	mov x18, x4
+	hvc #1
+	str x15,[x18]
+	str x16,[x18,#8]
+	ret
+ENDPROC(hv_do_hvc_fast_get)
diff --git a/arch/arm64/hyperv/hv_init.c b/arch/arm64/hyperv/hv_init.c
new file mode 100644
index 000000000000..aa1a8c09d989
--- /dev/null
+++ b/arch/arm64/hyperv/hv_init.c
@@ -0,0 +1,441 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Initialization of the interface with Microsoft's Hyper-V hypervisor,
+ * and various low level utility routines for interacting with Hyper-V.
+ *
+ * Copyright (C) 2018, Microsoft, Inc.
+ *
+ * Author : Michael Kelley <mikelley@microsoft.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ */
+
+
+#include <linux/types.h>
+#include <linux/version.h>
+#include <linux/export.h>
+#include <linux/vmalloc.h>
+#include <linux/mm.h>
+#include <linux/clocksource.h>
+#include <linux/sched_clock.h>
+#include <linux/acpi.h>
+#include <linux/module.h>
+#include <linux/hyperv.h>
+#include <linux/slab.h>
+#include <linux/cpuhotplug.h>
+#include <linux/psci.h>
+#include <asm-generic/bug.h>
+#include <asm/hypervisor.h>
+#include <asm/hyperv-tlfs.h>
+#include <asm/mshyperv.h>
+#include <asm/sysreg.h>
+#include <clocksource/arm_arch_timer.h>
+
+static bool	hyperv_initialized;
+struct		ms_hyperv_info ms_hyperv;
+EXPORT_SYMBOL_GPL(ms_hyperv);
+
+static struct ms_hyperv_tsc_page *tsc_pg;
+
+struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
+{
+	return tsc_pg;
+}
+EXPORT_SYMBOL_GPL(hv_get_tsc_page);
+
+static u64 read_hv_sched_clock_tsc(void)
+{
+	u64 current_tick = hv_read_tsc_page(tsc_pg);
+
+	if (current_tick == U64_MAX)
+		current_tick = hv_get_vpreg(HV_REGISTER_TIME_REFCOUNT);
+
+	return current_tick;
+}
+
+static u64 read_hv_clock_tsc(struct clocksource *arg)
+{
+	u64 current_tick = hv_read_tsc_page(tsc_pg);
+
+	if (current_tick == U64_MAX)
+		current_tick = hv_get_vpreg(HV_REGISTER_TIME_REFCOUNT);
+
+	return current_tick;
+}
+
+static struct clocksource hyperv_cs_tsc = {
+		.name		= "hyperv_clocksource_tsc_page",
+		.rating		= 400,
+		.read		= read_hv_clock_tsc,
+		.mask		= CLOCKSOURCE_MASK(64),
+		.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static u64 read_hv_sched_clock_msr(void)
+{
+	return hv_get_vpreg(HV_REGISTER_TIME_REFCOUNT);
+}
+
+static u64 read_hv_clock_msr(struct clocksource *arg)
+{
+	return hv_get_vpreg(HV_REGISTER_TIME_REFCOUNT);
+}
+
+static struct clocksource hyperv_cs_msr = {
+	.name		= "hyperv_clocksource_msr",
+	.rating		= 400,
+	.read		= read_hv_clock_msr,
+	.mask		= CLOCKSOURCE_MASK(64),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+struct clocksource *hyperv_cs;
+EXPORT_SYMBOL_GPL(hyperv_cs);
+
+u32 *hv_vp_index;
+EXPORT_SYMBOL_GPL(hv_vp_index);
+
+u32 hv_max_vp_index;
+
+static int hv_cpu_init(unsigned int cpu)
+{
+	u64 msr_vp_index;
+
+	hv_get_vp_index(msr_vp_index);
+
+	hv_vp_index[smp_processor_id()] = msr_vp_index;
+
+	if (msr_vp_index > hv_max_vp_index)
+		hv_max_vp_index = msr_vp_index;
+
+	return 0;
+}
+
+/*
+ * This function is invoked via the ACPI clocksource probe mechanism. We
+ * don't actually use any values from the ACPI GTDT table, but we set up
+ * the Hyper-V synthetic clocksource and do other initialization for
+ * interacting with Hyper-V the first time.  Using early_initcall to invoke
+ * this function is too late because interrupts are already enabled at that
+ * point, and sched_clock_register must run before interrupts are enabled.
+ *
+ * 1. Setup the guest ID.
+ * 2. Get features and hints info from Hyper-V
+ * 3. Setup per-cpu VP indices.
+ * 4. Register Hyper-V specific clocksource.
+ * 5. Register the scheduler clock.
+ */
+
+static int __init hyperv_init(struct acpi_table_header *table)
+{
+	struct hv_get_vp_register_output result;
+	u32	a, b, c, d;
+	u64	guest_id;
+	int	i;
+
+	/*
+	 * If we're in a VM on Hyper-V, the ACPI hypervisor_id field will
+	 * have the string "MsHyperV".
+	 */
+	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
+		return 1;
+
+	/* Setup the guest ID */
+	guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
+	hv_set_vpreg(HV_REGISTER_GUEST_OSID, guest_id);
+
+	/* Get the features and hints from Hyper-V */
+	hv_get_vpreg_128(HV_REGISTER_PRIVILEGES_AND_FEATURES, &result);
+	ms_hyperv.features = lower_32_bits(result.registervaluelow);
+	ms_hyperv.misc_features = upper_32_bits(result.registervaluehigh);
+
+	hv_get_vpreg_128(HV_REGISTER_FEATURES, &result);
+	ms_hyperv.hints = lower_32_bits(result.registervaluelow);
+
+	pr_info("Hyper-V: Features 0x%x, hints 0x%x\n",
+		ms_hyperv.features, ms_hyperv.hints);
+
+	/*
+	 * Direct mode is the only option for STIMERs provided Hyper-V
+	 * on ARM64, so Hyper-V doesn't actually set the flag.  But add the
+	 * flag so the architecture independent code in drivers/hv/hv.c
+	 * will correctly use that mode.
+	 */
+	ms_hyperv.misc_features |= HV_STIMER_DIRECT_MODE_AVAILABLE;
+
+	/*
+	 * Hyper-V on ARM64 doesn't support AutoEOI.  Add the hint
+	 * that tells architecture independent code not to use this
+	 * feature.
+	 */
+	ms_hyperv.hints |= HV_DEPRECATING_AEOI_RECOMMENDED;
+
+	/* Get information about the Hyper-V host version */
+	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION, &result);
+	a = lower_32_bits(result.registervaluelow);
+	b = upper_32_bits(result.registervaluelow);
+	c = lower_32_bits(result.registervaluehigh);
+	d = upper_32_bits(result.registervaluehigh);
+	pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
+		b >> 16, b & 0xFFFF, a, d & 0xFFFFFF, c, d >> 24);
+
+	/* Allocate percpu VP index */
+	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
+				    GFP_KERNEL);
+	if (!hv_vp_index)
+		return 1;
+
+	for (i = 0; i < num_possible_cpus(); i++)
+		hv_vp_index[i] = VP_INVAL;
+
+	if (cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm64/hyperv_init:online",
+			      hv_cpu_init, NULL) < 0)
+		goto free_vp_index;
+
+	/*
+	 * Try to set up what Hyper-V calls the "TSC reference page", which
+	 * uses the ARM Generic Timer virtual counter with some scaling
+	 * information to provide a fast and stable guest VM clocksource.
+	 * If the TSC reference page can't be set up, fall back to reading
+	 * the guest clock provided by Hyper-V's synthetic reference time
+	 * register.
+	 */
+	if (ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE) {
+
+		u64		tsc_msr;
+		phys_addr_t	phys_addr;
+
+		tsc_pg = __vmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL);
+		if (tsc_pg) {
+			phys_addr = page_to_phys(vmalloc_to_page(tsc_pg));
+			tsc_msr = hv_get_vpreg(HV_REGISTER_REFERENCE_TSC);
+			tsc_msr &= GENMASK_ULL(11, 0);
+			tsc_msr = tsc_msr | 0x1 | (u64)phys_addr;
+			hv_set_vpreg(HV_REGISTER_REFERENCE_TSC, tsc_msr);
+			hyperv_cs = &hyperv_cs_tsc;
+			sched_clock_register(read_hv_sched_clock_tsc,
+						64, HV_CLOCK_HZ);
+		}
+	}
+
+	if (!hyperv_cs &&
+	    (ms_hyperv.features & HV_MSR_TIME_REF_COUNT_AVAILABLE)) {
+		hyperv_cs = &hyperv_cs_msr;
+		sched_clock_register(read_hv_sched_clock_msr,
+						64, HV_CLOCK_HZ);
+	}
+
+	if (hyperv_cs) {
+		hyperv_cs->archdata.vdso_direct = false;
+		clocksource_register_hz(hyperv_cs, HV_CLOCK_HZ);
+	}
+
+	hyperv_initialized = true;
+	return 0;
+
+free_vp_index:
+	kfree(hv_vp_index);
+	hv_vp_index = NULL;
+	return 1;
+}
+TIMER_ACPI_DECLARE(hyperv, ACPI_SIG_GTDT, hyperv_init);
+
+/*
+ * This routine is called before kexec/kdump, it does the required cleanup.
+ */
+void hyperv_cleanup(void)
+{
+	/* Reset our OS id */
+	hv_set_vpreg(HV_REGISTER_GUEST_OSID, 0);
+
+}
+EXPORT_SYMBOL_GPL(hyperv_cleanup);
+
+/*
+ * hv_do_hypercall- Invoke the specified hypercall
+ */
+u64 hv_do_hypercall(u64 control, void *input, void *output)
+{
+	u64 input_address;
+	u64 output_address;
+
+	input_address = input ? virt_to_phys(input) : 0;
+	output_address = output ? virt_to_phys(output) : 0;
+	return hv_do_hvc(control, input_address, output_address);
+}
+EXPORT_SYMBOL_GPL(hv_do_hypercall);
+
+/*
+ * hv_do_fast_hypercall8 -- Invoke the specified hypercall
+ * with arguments in registers instead of physical memory.
+ * Avoids the overhead of virt_to_phys for simple hypercalls.
+ */
+
+u64 hv_do_fast_hypercall8(u16 code, u64 input)
+{
+	u64 control;
+
+	control = (u64)code | HV_HYPERCALL_FAST_BIT;
+	return hv_do_hvc(control, input);
+}
+EXPORT_SYMBOL_GPL(hv_do_fast_hypercall8);
+
+
+/*
+ * Set a single VP register to a 64-bit value.
+ */
+void hv_set_vpreg(u32 msr, u64 value)
+{
+	union hv_hypercall_status status;
+
+	status.as_uint64 = hv_do_hvc(
+		HVCALL_SET_VP_REGISTERS | HV_HYPERCALL_FAST_BIT |
+			HV_HYPERCALL_REP_COUNT_1,
+		HV_PARTITION_ID_SELF,
+		HV_VP_INDEX_SELF,
+		msr,
+		0,
+		value,
+		0);
+
+	/*
+	 * Something is fundamentally broken in the hypervisor if
+	 * setting a VP register fails. There's really no way to
+	 * continue as a guest VM, so panic.
+	 */
+	BUG_ON(status.status != HV_STATUS_SUCCESS);
+}
+EXPORT_SYMBOL_GPL(hv_set_vpreg);
+
+
+/*
+ * Get the value of a single VP register, and only the low order 64 bits.
+ */
+u64 hv_get_vpreg(u32 msr)
+{
+	union hv_hypercall_status status;
+	struct hv_get_vp_register_output output;
+
+	status.as_uint64 = hv_do_hvc_fast_get(
+		HVCALL_GET_VP_REGISTERS | HV_HYPERCALL_FAST_BIT |
+			HV_HYPERCALL_REP_COUNT_1,
+		HV_PARTITION_ID_SELF,
+		HV_VP_INDEX_SELF,
+		msr,
+		&output);
+
+	/*
+	 * Something is fundamentally broken in the hypervisor if
+	 * getting a VP register fails. There's really no way to
+	 * continue as a guest VM, so panic.
+	 */
+	BUG_ON(status.status != HV_STATUS_SUCCESS);
+
+	return output.registervaluelow;
+}
+EXPORT_SYMBOL_GPL(hv_get_vpreg);
+
+/*
+ * Get the value of a single VP register that is 128 bits in size.  This is a
+ * separate call in order to avoid complicating the calling sequence for
+ * the much more frequently used 64-bit version.
+ */
+void hv_get_vpreg_128(u32 msr, struct hv_get_vp_register_output *result)
+{
+	union hv_hypercall_status status;
+
+	status.as_uint64 = hv_do_hvc_fast_get(
+		HVCALL_GET_VP_REGISTERS | HV_HYPERCALL_FAST_BIT |
+			HV_HYPERCALL_REP_COUNT_1,
+		HV_PARTITION_ID_SELF,
+		HV_VP_INDEX_SELF,
+		msr,
+		result);
+
+	/*
+	 * Something is fundamentally broken in the hypervisor if
+	 * getting a VP register fails. There's really no way to
+	 * continue as a guest VM, so panic.
+	 */
+	BUG_ON(status.status != HV_STATUS_SUCCESS);
+
+	return;
+
+}
+EXPORT_SYMBOL_GPL(hv_get_vpreg_128);
+
+void hyperv_report_panic(struct pt_regs *regs, long err)
+{
+	static bool panic_reported;
+	u64 guest_id;
+
+	/*
+	 * We prefer to report panic on 'die' chain as we have proper
+	 * registers to report, but if we miss it (e.g. on BUG()) we need
+	 * to report it on 'panic'.
+	 */
+	if (panic_reported)
+		return;
+	panic_reported = true;
+
+	guest_id = hv_get_vpreg(HV_REGISTER_GUEST_OSID);
+
+	/*
+	 * Hyper-V provides the ability to store only 5 values.
+	 * Pick the passed in error value, the guest_id, and the PC.
+	 * The first two general registers are added arbitrarily.
+	 */
+	hv_set_vpreg(HV_REGISTER_CRASH_P0, err);
+	hv_set_vpreg(HV_REGISTER_CRASH_P1, guest_id);
+	hv_set_vpreg(HV_REGISTER_CRASH_P2, regs->pc);
+	hv_set_vpreg(HV_REGISTER_CRASH_P3, regs->regs[0]);
+	hv_set_vpreg(HV_REGISTER_CRASH_P4, regs->regs[1]);
+
+	/*
+	 * Let Hyper-V know there is crash data available
+	 */
+	hv_set_vpreg(HV_REGISTER_CRASH_CTL, HV_CRASH_CTL_CRASH_NOTIFY);
+}
+EXPORT_SYMBOL_GPL(hyperv_report_panic);
+
+/*
+ * hyperv_report_panic_msg - report panic message to Hyper-V
+ * @pa: physical address of the panic page containing the message
+ * @size: size of the message in the page
+ */
+void hyperv_report_panic_msg(phys_addr_t pa, size_t size)
+{
+	/*
+	 * P3 to contain the physical address of the panic page & P4 to
+	 * contain the size of the panic data in that page. Rest of the
+	 * registers are no-op when the NOTIFY_MSG flag is set.
+	 */
+	hv_set_vpreg(HV_REGISTER_CRASH_P0, 0);
+	hv_set_vpreg(HV_REGISTER_CRASH_P1, 0);
+	hv_set_vpreg(HV_REGISTER_CRASH_P2, 0);
+	hv_set_vpreg(HV_REGISTER_CRASH_P3, pa);
+	hv_set_vpreg(HV_REGISTER_CRASH_P4, size);
+
+	/*
+	 * Let Hyper-V know there is crash data available along with
+	 * the panic message.
+	 */
+	hv_set_vpreg(HV_REGISTER_CRASH_CTL,
+	       (HV_CRASH_CTL_CRASH_NOTIFY | HV_CRASH_CTL_CRASH_NOTIFY_MSG));
+}
+EXPORT_SYMBOL_GPL(hyperv_report_panic_msg);
+
+bool hv_is_hyperv_initialized(void)
+{
+	return hyperv_initialized;
+}
+EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
new file mode 100644
index 000000000000..3ef055599412
--- /dev/null
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Core routines for interacting with Microsoft's Hyper-V hypervisor,
+ * including setting up VMbus and STIMER interrupts, and handling
+ * crashes and kexecs. These interactions are through a set of
+ * static "handler" variables set by the architecture independent
+ * VMbus and STIMER drivers.  This design is used to meet x86/x64
+ * requirements for avoiding direct linkages and allowing the VMbus
+ * and STIMER drivers to be unloaded and reloaded.
+ *
+ * Copyright (C) 2018, Microsoft, Inc.
+ *
+ * Author : Michael Kelley <mikelley@microsoft.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ */
+
+#include <linux/types.h>
+#include <linux/export.h>
+#include <linux/interrupt.h>
+#include <linux/kexec.h>
+#include <linux/acpi.h>
+#include <linux/ptrace.h>
+#include <asm/hyperv-tlfs.h>
+#include <asm/mshyperv.h>
+
+static void (*vmbus_handler)(void);
+static void (*hv_stimer0_handler)(void);
+static void (*hv_kexec_handler)(void);
+static void (*hv_crash_handler)(struct pt_regs *regs);
+
+static int vmbus_irq;
+static long __percpu *vmbus_evt;
+static long __percpu *stimer0_evt;
+
+irqreturn_t hyperv_vector_handler(int irq, void *dev_id)
+{
+	if (vmbus_handler)
+		vmbus_handler();
+	return IRQ_HANDLED;
+}
+
+/* Must be done just once */
+void hv_setup_vmbus_irq(void (*handler)(void))
+{
+	int result;
+
+	vmbus_handler = handler;
+	vmbus_irq = acpi_register_gsi(NULL, HYPERVISOR_CALLBACK_VECTOR,
+				 ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
+	if (vmbus_irq <= 0) {
+		pr_err("Can't register Hyper-V VMBus GSI. Error %d",
+			vmbus_irq);
+		vmbus_irq = 0;
+		return;
+	}
+	vmbus_evt = alloc_percpu(long);
+	result = request_percpu_irq(vmbus_irq, hyperv_vector_handler,
+			"Hyper-V VMbus", vmbus_evt);
+	if (result) {
+		pr_err("Can't request Hyper-V VMBus IRQ %d. Error %d",
+			vmbus_irq, result);
+		free_percpu(vmbus_evt);
+		acpi_unregister_gsi(vmbus_irq);
+		vmbus_irq = 0;
+	}
+}
+EXPORT_SYMBOL_GPL(hv_setup_vmbus_irq);
+
+/* Must be done just once */
+void hv_remove_vmbus_irq(void)
+{
+	if (vmbus_irq) {
+		free_percpu_irq(vmbus_irq, vmbus_evt);
+		free_percpu(vmbus_evt);
+		acpi_unregister_gsi(vmbus_irq);
+	}
+}
+EXPORT_SYMBOL_GPL(hv_remove_vmbus_irq);
+
+/* Must be done by each CPU */
+void hv_enable_vmbus_irq(void)
+{
+	enable_percpu_irq(vmbus_irq, 0);
+}
+EXPORT_SYMBOL_GPL(hv_enable_vmbus_irq);
+
+/* Must be done by each CPU */
+void hv_disable_vmbus_irq(void)
+{
+	disable_percpu_irq(vmbus_irq);
+}
+EXPORT_SYMBOL_GPL(hv_disable_vmbus_irq);
+
+/* Routines to do per-architecture handling of STIMER0 when in Direct Mode */
+
+static irqreturn_t hv_stimer0_vector_handler(int irq, void *dev_id)
+{
+	if (hv_stimer0_handler)
+		hv_stimer0_handler();
+	return IRQ_HANDLED;
+}
+
+int hv_setup_stimer0_irq(int *irq, int *vector, void (*handler)(void))
+{
+	int localirq;
+	int result;
+
+	localirq = acpi_register_gsi(NULL, HV_STIMER0_IRQNR,
+			ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
+	if (localirq <= 0) {
+		pr_err("Can't register Hyper-V stimer0 GSI. Error %d",
+			localirq);
+		*irq = 0;
+		return -1;
+	}
+	stimer0_evt = alloc_percpu(long);
+	result = request_percpu_irq(localirq, hv_stimer0_vector_handler,
+					 "Hyper-V stimer0", stimer0_evt);
+	if (result) {
+		pr_err("Can't request Hyper-V stimer0 IRQ %d. Error %d",
+			localirq, result);
+		free_percpu(stimer0_evt);
+		acpi_unregister_gsi(localirq);
+		*irq = 0;
+		return -1;
+	}
+
+	hv_stimer0_handler = handler;
+	*vector = HV_STIMER0_IRQNR;
+	*irq = localirq;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hv_setup_stimer0_irq);
+
+void hv_remove_stimer0_irq(int irq)
+{
+	hv_stimer0_handler = NULL;
+	if (irq) {
+		free_percpu_irq(irq, stimer0_evt);
+		free_percpu(stimer0_evt);
+		acpi_unregister_gsi(irq);
+	}
+}
+EXPORT_SYMBOL_GPL(hv_remove_stimer0_irq);
+
+void hv_setup_kexec_handler(void (*handler)(void))
+{
+	hv_kexec_handler = handler;
+}
+EXPORT_SYMBOL_GPL(hv_setup_kexec_handler);
+
+void hv_remove_kexec_handler(void)
+{
+	hv_kexec_handler = NULL;
+}
+EXPORT_SYMBOL_GPL(hv_remove_kexec_handler);
+
+void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs))
+{
+	hv_crash_handler = handler;
+}
+EXPORT_SYMBOL_GPL(hv_setup_crash_handler);
+
+void hv_remove_crash_handler(void)
+{
+	hv_crash_handler = NULL;
+}
+EXPORT_SYMBOL_GPL(hv_remove_crash_handler);
-- 
2.19.1

