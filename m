Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbeFDKp3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:45:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39106 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbeFDKp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:45:28 -0400
Date: Mon, 4 Jun 2018 12:45:25 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] x86/hyperv updates for 4.18
Message-ID: <alpine.DEB.2.21.1806041240060.2646@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-hyperv-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-hyperv-for-linus

A set of commits to enable APIC enlightenment when running as a guest on
Microsoft HyperV. This accelerates the APIC access with paravirtualization
techniques, which are called enligthenments on Hyper-V.

Thanks,

	tglx

------------------>
K. Y. Srinivasan (5):
      X86/Hyper-V: Enlighten APIC access
      X86/Hyper-V: Enable IPI enlightenments
      X86/Hyper-V: Enhanced IPI enlightenment
      X86/Hyper-V: Consolidate code for converting cpumask to vpset
      X86/Hyper-V: Consolidate the allocation of the hypercall input page

Thomas Gleixner (2):
      x86/Hyper-V/hv_apic: Include asm/apic.h
      x86/Hyper-V/hv_apic: Build the Hyper-V APIC conditionally


 arch/x86/hyperv/Makefile           |   3 +-
 arch/x86/hyperv/hv_apic.c          | 256 +++++++++++++++++++++++++++++++++++++
 arch/x86/hyperv/hv_init.c          |  32 ++++-
 arch/x86/hyperv/mmu.c              |  75 ++---------
 arch/x86/include/asm/hyperv-tlfs.h |  30 ++++-
 arch/x86/include/asm/mshyperv.h    |  44 ++++++-
 6 files changed, 368 insertions(+), 72 deletions(-)
 create mode 100644 arch/x86/hyperv/hv_apic.c

diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
index 367a8203cfcf..b173d404e3df 100644
--- a/arch/x86/hyperv/Makefile
+++ b/arch/x86/hyperv/Makefile
@@ -1 +1,2 @@
-obj-y		:= hv_init.o mmu.o
+obj-y			:= hv_init.o mmu.o
+obj-$(CONFIG_X86_64)	+= hv_apic.o
diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
new file mode 100644
index 000000000000..f68855499391
--- /dev/null
+++ b/arch/x86/hyperv/hv_apic.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Hyper-V specific APIC code.
+ *
+ * Copyright (C) 2018, Microsoft, Inc.
+ *
+ * Author : K. Y. Srinivasan <kys@microsoft.com>
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
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/version.h>
+#include <linux/vmalloc.h>
+#include <linux/mm.h>
+#include <linux/clockchips.h>
+#include <linux/hyperv.h>
+#include <linux/slab.h>
+#include <linux/cpuhotplug.h>
+#include <asm/hypervisor.h>
+#include <asm/mshyperv.h>
+#include <asm/apic.h>
+
+static struct apic orig_apic;
+
+static u64 hv_apic_icr_read(void)
+{
+	u64 reg_val;
+
+	rdmsrl(HV_X64_MSR_ICR, reg_val);
+	return reg_val;
+}
+
+static void hv_apic_icr_write(u32 low, u32 id)
+{
+	u64 reg_val;
+
+	reg_val = SET_APIC_DEST_FIELD(id);
+	reg_val = reg_val << 32;
+	reg_val |= low;
+
+	wrmsrl(HV_X64_MSR_ICR, reg_val);
+}
+
+static u32 hv_apic_read(u32 reg)
+{
+	u32 reg_val, hi;
+
+	switch (reg) {
+	case APIC_EOI:
+		rdmsr(HV_X64_MSR_EOI, reg_val, hi);
+		return reg_val;
+	case APIC_TASKPRI:
+		rdmsr(HV_X64_MSR_TPR, reg_val, hi);
+		return reg_val;
+
+	default:
+		return native_apic_mem_read(reg);
+	}
+}
+
+static void hv_apic_write(u32 reg, u32 val)
+{
+	switch (reg) {
+	case APIC_EOI:
+		wrmsr(HV_X64_MSR_EOI, val, 0);
+		break;
+	case APIC_TASKPRI:
+		wrmsr(HV_X64_MSR_TPR, val, 0);
+		break;
+	default:
+		native_apic_mem_write(reg, val);
+	}
+}
+
+static void hv_apic_eoi_write(u32 reg, u32 val)
+{
+	wrmsr(HV_X64_MSR_EOI, val, 0);
+}
+
+/*
+ * IPI implementation on Hyper-V.
+ */
+static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
+{
+	struct ipi_arg_ex **arg;
+	struct ipi_arg_ex *ipi_arg;
+	unsigned long flags;
+	int nr_bank = 0;
+	int ret = 1;
+
+	local_irq_save(flags);
+	arg = (struct ipi_arg_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	ipi_arg = *arg;
+	if (unlikely(!ipi_arg))
+		goto ipi_mask_ex_done;
+
+	ipi_arg->vector = vector;
+	ipi_arg->reserved = 0;
+	ipi_arg->vp_set.valid_bank_mask = 0;
+
+	if (!cpumask_equal(mask, cpu_present_mask)) {
+		ipi_arg->vp_set.format = HV_GENERIC_SET_SPARSE_4K;
+		nr_bank = cpumask_to_vpset(&(ipi_arg->vp_set), mask);
+	}
+	if (!nr_bank)
+		ipi_arg->vp_set.format = HV_GENERIC_SET_ALL;
+
+	ret = hv_do_rep_hypercall(HVCALL_SEND_IPI_EX, 0, nr_bank,
+			      ipi_arg, NULL);
+
+ipi_mask_ex_done:
+	local_irq_restore(flags);
+	return ((ret == 0) ? true : false);
+}
+
+static bool __send_ipi_mask(const struct cpumask *mask, int vector)
+{
+	int cur_cpu, vcpu;
+	struct ipi_arg_non_ex **arg;
+	struct ipi_arg_non_ex *ipi_arg;
+	int ret = 1;
+	unsigned long flags;
+
+	if (cpumask_empty(mask))
+		return true;
+
+	if (!hv_hypercall_pg)
+		return false;
+
+	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
+		return false;
+
+	if ((ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
+		return __send_ipi_mask_ex(mask, vector);
+
+	local_irq_save(flags);
+	arg = (struct ipi_arg_non_ex **)this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	ipi_arg = *arg;
+	if (unlikely(!ipi_arg))
+		goto ipi_mask_done;
+
+	ipi_arg->vector = vector;
+	ipi_arg->reserved = 0;
+	ipi_arg->cpu_mask = 0;
+
+	for_each_cpu(cur_cpu, mask) {
+		vcpu = hv_cpu_number_to_vp_number(cur_cpu);
+		/*
+		 * This particular version of the IPI hypercall can
+		 * only target upto 64 CPUs.
+		 */
+		if (vcpu >= 64)
+			goto ipi_mask_done;
+
+		__set_bit(vcpu, (unsigned long *)&ipi_arg->cpu_mask);
+	}
+
+	ret = hv_do_hypercall(HVCALL_SEND_IPI, ipi_arg, NULL);
+
+ipi_mask_done:
+	local_irq_restore(flags);
+	return ((ret == 0) ? true : false);
+}
+
+static bool __send_ipi_one(int cpu, int vector)
+{
+	struct cpumask mask = CPU_MASK_NONE;
+
+	cpumask_set_cpu(cpu, &mask);
+	return __send_ipi_mask(&mask, vector);
+}
+
+static void hv_send_ipi(int cpu, int vector)
+{
+	if (!__send_ipi_one(cpu, vector))
+		orig_apic.send_IPI(cpu, vector);
+}
+
+static void hv_send_ipi_mask(const struct cpumask *mask, int vector)
+{
+	if (!__send_ipi_mask(mask, vector))
+		orig_apic.send_IPI_mask(mask, vector);
+}
+
+static void hv_send_ipi_mask_allbutself(const struct cpumask *mask, int vector)
+{
+	unsigned int this_cpu = smp_processor_id();
+	struct cpumask new_mask;
+	const struct cpumask *local_mask;
+
+	cpumask_copy(&new_mask, mask);
+	cpumask_clear_cpu(this_cpu, &new_mask);
+	local_mask = &new_mask;
+	if (!__send_ipi_mask(local_mask, vector))
+		orig_apic.send_IPI_mask_allbutself(mask, vector);
+}
+
+static void hv_send_ipi_allbutself(int vector)
+{
+	hv_send_ipi_mask_allbutself(cpu_online_mask, vector);
+}
+
+static void hv_send_ipi_all(int vector)
+{
+	if (!__send_ipi_mask(cpu_online_mask, vector))
+		orig_apic.send_IPI_all(vector);
+}
+
+static void hv_send_ipi_self(int vector)
+{
+	if (!__send_ipi_one(smp_processor_id(), vector))
+		orig_apic.send_IPI_self(vector);
+}
+
+void __init hv_apic_init(void)
+{
+	if (ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) {
+		if ((ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
+			pr_info("Hyper-V: Using ext hypercalls for IPI\n");
+		else
+			pr_info("Hyper-V: Using IPI hypercalls\n");
+		/*
+		 * Set the IPI entry points.
+		 */
+		orig_apic = *apic;
+
+		apic->send_IPI = hv_send_ipi;
+		apic->send_IPI_mask = hv_send_ipi_mask;
+		apic->send_IPI_mask_allbutself = hv_send_ipi_mask_allbutself;
+		apic->send_IPI_allbutself = hv_send_ipi_allbutself;
+		apic->send_IPI_all = hv_send_ipi_all;
+		apic->send_IPI_self = hv_send_ipi_self;
+	}
+
+	if (ms_hyperv.hints & HV_X64_APIC_ACCESS_RECOMMENDED) {
+		pr_info("Hyper-V: Using MSR based APIC access\n");
+		apic_set_eoi_write(hv_apic_eoi_write);
+		apic->read      = hv_apic_read;
+		apic->write     = hv_apic_write;
+		apic->icr_write = hv_apic_icr_write;
+		apic->icr_read  = hv_apic_icr_read;
+	}
+}
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index cfecc2272f2d..4c431e1c1eff 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -91,12 +91,19 @@ EXPORT_SYMBOL_GPL(hv_vp_index);
 struct hv_vp_assist_page **hv_vp_assist_page;
 EXPORT_SYMBOL_GPL(hv_vp_assist_page);
 
+void  __percpu **hyperv_pcpu_input_arg;
+EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
+
 u32 hv_max_vp_index;
 
 static int hv_cpu_init(unsigned int cpu)
 {
 	u64 msr_vp_index;
 	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
+	void **input_arg;
+
+	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
+	*input_arg = page_address(alloc_page(GFP_KERNEL));
 
 	hv_get_vp_index(msr_vp_index);
 
@@ -217,6 +224,16 @@ static int hv_cpu_die(unsigned int cpu)
 {
 	struct hv_reenlightenment_control re_ctrl;
 	unsigned int new_cpu;
+	unsigned long flags;
+	void **input_arg;
+	void *input_pg = NULL;
+
+	local_irq_save(flags);
+	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
+	input_pg = *input_arg;
+	*input_arg = NULL;
+	local_irq_restore(flags);
+	free_page((unsigned long)input_pg);
 
 	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
 		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
@@ -242,8 +259,9 @@ static int hv_cpu_die(unsigned int cpu)
  *
  * 1. Setup the hypercall page.
  * 2. Register Hyper-V specific clocksource.
+ * 3. Setup Hyper-V specific APIC entry points.
  */
-void hyperv_init(void)
+void __init hyperv_init(void)
 {
 	u64 guest_id, required_msrs;
 	union hv_x64_msr_hypercall_contents hypercall_msr;
@@ -259,6 +277,16 @@ void hyperv_init(void)
 	if ((ms_hyperv.features & required_msrs) != required_msrs)
 		return;
 
+	/*
+	 * Allocate the per-CPU state for the hypercall input arg.
+	 * If this allocation fails, we will not be able to setup
+	 * (per-CPU) hypercall input page and thus this failure is
+	 * fatal on Hyper-V.
+	 */
+	hyperv_pcpu_input_arg = alloc_percpu(void  *);
+
+	BUG_ON(hyperv_pcpu_input_arg == NULL);
+
 	/* Allocate percpu VP index */
 	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
 				    GFP_KERNEL);
@@ -296,7 +324,7 @@ void hyperv_init(void)
 	hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
 	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 
-	hyper_alloc_mmu();
+	hv_apic_init();
 
 	/*
 	 * Register Hyper-V specific clocksource.
diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 56c9ebac946f..5f053d7d1bd9 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -25,20 +25,13 @@ struct hv_flush_pcpu {
 struct hv_flush_pcpu_ex {
 	u64 address_space;
 	u64 flags;
-	struct {
-		u64 format;
-		u64 valid_bank_mask;
-		u64 bank_contents[];
-	} hv_vp_set;
+	struct hv_vpset hv_vp_set;
 	u64 gva_list[];
 };
 
 /* Each gva in gva_list encodes up to 4096 pages to flush */
 #define HV_TLB_FLUSH_UNIT (4096 * PAGE_SIZE)
 
-static struct hv_flush_pcpu __percpu **pcpu_flush;
-
-static struct hv_flush_pcpu_ex __percpu **pcpu_flush_ex;
 
 /*
  * Fills in gva_list starting from offset. Returns the number of items added.
@@ -70,41 +63,6 @@ static inline int fill_gva_list(u64 gva_list[], int offset,
 	return gva_n - offset;
 }
 
-/* Return the number of banks in the resulting vp_set */
-static inline int cpumask_to_vp_set(struct hv_flush_pcpu_ex *flush,
-				    const struct cpumask *cpus)
-{
-	int cpu, vcpu, vcpu_bank, vcpu_offset, nr_bank = 1;
-
-	/* valid_bank_mask can represent up to 64 banks */
-	if (hv_max_vp_index / 64 >= 64)
-		return 0;
-
-	/*
-	 * Clear all banks up to the maximum possible bank as hv_flush_pcpu_ex
-	 * structs are not cleared between calls, we risk flushing unneeded
-	 * vCPUs otherwise.
-	 */
-	for (vcpu_bank = 0; vcpu_bank <= hv_max_vp_index / 64; vcpu_bank++)
-		flush->hv_vp_set.bank_contents[vcpu_bank] = 0;
-
-	/*
-	 * Some banks may end up being empty but this is acceptable.
-	 */
-	for_each_cpu(cpu, cpus) {
-		vcpu = hv_cpu_number_to_vp_number(cpu);
-		vcpu_bank = vcpu / 64;
-		vcpu_offset = vcpu % 64;
-		__set_bit(vcpu_offset, (unsigned long *)
-			  &flush->hv_vp_set.bank_contents[vcpu_bank]);
-		if (vcpu_bank >= nr_bank)
-			nr_bank = vcpu_bank + 1;
-	}
-	flush->hv_vp_set.valid_bank_mask = GENMASK_ULL(nr_bank - 1, 0);
-
-	return nr_bank;
-}
-
 static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 				    const struct flush_tlb_info *info)
 {
@@ -116,7 +74,7 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 
 	trace_hyperv_mmu_flush_tlb_others(cpus, info);
 
-	if (!pcpu_flush || !hv_hypercall_pg)
+	if (!hv_hypercall_pg)
 		goto do_native;
 
 	if (cpumask_empty(cpus))
@@ -124,10 +82,8 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 
 	local_irq_save(flags);
 
-	flush_pcpu = this_cpu_ptr(pcpu_flush);
-
-	if (unlikely(!*flush_pcpu))
-		*flush_pcpu = page_address(alloc_page(GFP_ATOMIC));
+	flush_pcpu = (struct hv_flush_pcpu **)
+		     this_cpu_ptr(hyperv_pcpu_input_arg);
 
 	flush = *flush_pcpu;
 
@@ -203,7 +159,7 @@ static void hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 
 	trace_hyperv_mmu_flush_tlb_others(cpus, info);
 
-	if (!pcpu_flush_ex || !hv_hypercall_pg)
+	if (!hv_hypercall_pg)
 		goto do_native;
 
 	if (cpumask_empty(cpus))
@@ -211,10 +167,8 @@ static void hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 
 	local_irq_save(flags);
 
-	flush_pcpu = this_cpu_ptr(pcpu_flush_ex);
-
-	if (unlikely(!*flush_pcpu))
-		*flush_pcpu = page_address(alloc_page(GFP_ATOMIC));
+	flush_pcpu = (struct hv_flush_pcpu_ex **)
+		     this_cpu_ptr(hyperv_pcpu_input_arg);
 
 	flush = *flush_pcpu;
 
@@ -239,8 +193,8 @@ static void hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 	flush->hv_vp_set.valid_bank_mask = 0;
 
 	if (!cpumask_equal(cpus, cpu_present_mask)) {
-		flush->hv_vp_set.format = HV_GENERIC_SET_SPARCE_4K;
-		nr_bank = cpumask_to_vp_set(flush, cpus);
+		flush->hv_vp_set.format = HV_GENERIC_SET_SPARSE_4K;
+		nr_bank = cpumask_to_vpset(&(flush->hv_vp_set), cpus);
 	}
 
 	if (!nr_bank) {
@@ -296,14 +250,3 @@ void hyperv_setup_mmu_ops(void)
 		pv_mmu_ops.flush_tlb_others = hyperv_flush_tlb_others_ex;
 	}
 }
-
-void hyper_alloc_mmu(void)
-{
-	if (!(ms_hyperv.hints & HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED))
-		return;
-
-	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
-		pcpu_flush = alloc_percpu(struct hv_flush_pcpu *);
-	else
-		pcpu_flush_ex = alloc_percpu(struct hv_flush_pcpu_ex *);
-}
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 416cb0e0c496..3bfa92c2793c 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -164,6 +164,11 @@
  */
 #define HV_X64_DEPRECATING_AEOI_RECOMMENDED	(1 << 9)
 
+/*
+ * Recommend using cluster IPI hypercalls.
+ */
+#define HV_X64_CLUSTER_IPI_RECOMMENDED         (1 << 10)
+
 /* Recommend using the newer ExProcessorMasks interface */
 #define HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED	(1 << 11)
 
@@ -329,12 +334,17 @@ struct hv_tsc_emulation_status {
 #define HV_X64_MSR_HYPERCALL_PAGE_ADDRESS_MASK	\
 		(~((1ull << HV_X64_MSR_HYPERCALL_PAGE_ADDRESS_SHIFT) - 1))
 
+#define HV_IPI_LOW_VECTOR	0x10
+#define HV_IPI_HIGH_VECTOR	0xff
+
 /* Declare the various hypercall operations. */
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE	0x0002
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST	0x0003
 #define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
+#define HVCALL_SEND_IPI				0x000b
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX  0x0013
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX   0x0014
+#define HVCALL_SEND_IPI_EX			0x0015
 #define HVCALL_POST_MESSAGE			0x005c
 #define HVCALL_SIGNAL_EVENT			0x005d
 
@@ -360,7 +370,7 @@ struct hv_tsc_emulation_status {
 #define HV_FLUSH_USE_EXTENDED_RANGE_FORMAT	BIT(3)
 
 enum HV_GENERIC_SET_FORMAT {
-	HV_GENERIC_SET_SPARCE_4K,
+	HV_GENERIC_SET_SPARSE_4K,
 	HV_GENERIC_SET_ALL,
 };
 
@@ -706,4 +716,22 @@ struct hv_enlightened_vmcs {
 #define HV_STIMER_AUTOENABLE		(1ULL << 3)
 #define HV_STIMER_SINT(config)		(__u8)(((config) >> 16) & 0x0F)
 
+struct ipi_arg_non_ex {
+	u32 vector;
+	u32 reserved;
+	u64 cpu_mask;
+};
+
+struct hv_vpset {
+	u64 format;
+	u64 valid_bank_mask;
+	u64 bank_contents[];
+};
+
+struct ipi_arg_ex {
+	u32 vector;
+	u32 reserved;
+	struct hv_vpset vp_set;
+};
+
 #endif
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index b90e79610cf7..997192131b7b 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -122,6 +122,7 @@ static inline void hv_disable_stimer0_percpu_irq(int irq) {}
 #if IS_ENABLED(CONFIG_HYPERV)
 extern struct clocksource *hyperv_cs;
 extern void *hv_hypercall_pg;
+extern void  __percpu  **hyperv_pcpu_input_arg;
 
 static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 {
@@ -258,9 +259,41 @@ static inline int hv_cpu_number_to_vp_number(int cpu_number)
 	return hv_vp_index[cpu_number];
 }
 
-void hyperv_init(void);
+static inline int cpumask_to_vpset(struct hv_vpset *vpset,
+				    const struct cpumask *cpus)
+{
+	int cpu, vcpu, vcpu_bank, vcpu_offset, nr_bank = 1;
+
+	/* valid_bank_mask can represent up to 64 banks */
+	if (hv_max_vp_index / 64 >= 64)
+		return 0;
+
+	/*
+	 * Clear all banks up to the maximum possible bank as hv_flush_pcpu_ex
+	 * structs are not cleared between calls, we risk flushing unneeded
+	 * vCPUs otherwise.
+	 */
+	for (vcpu_bank = 0; vcpu_bank <= hv_max_vp_index / 64; vcpu_bank++)
+		vpset->bank_contents[vcpu_bank] = 0;
+
+	/*
+	 * Some banks may end up being empty but this is acceptable.
+	 */
+	for_each_cpu(cpu, cpus) {
+		vcpu = hv_cpu_number_to_vp_number(cpu);
+		vcpu_bank = vcpu / 64;
+		vcpu_offset = vcpu % 64;
+		__set_bit(vcpu_offset, (unsigned long *)
+			  &vpset->bank_contents[vcpu_bank]);
+		if (vcpu_bank >= nr_bank)
+			nr_bank = vcpu_bank + 1;
+	}
+	vpset->valid_bank_mask = GENMASK_ULL(nr_bank - 1, 0);
+	return nr_bank;
+}
+
+void __init hyperv_init(void);
 void hyperv_setup_mmu_ops(void);
-void hyper_alloc_mmu(void);
 void hyperv_report_panic(struct pt_regs *regs, long err);
 bool hv_is_hyperv_initialized(void);
 void hyperv_cleanup(void);
@@ -269,6 +302,13 @@ void hyperv_reenlightenment_intr(struct pt_regs *regs);
 void set_hv_tscchange_cb(void (*cb)(void));
 void clear_hv_tscchange_cb(void);
 void hyperv_stop_tsc_emulation(void);
+
+#ifdef CONFIG_X86_64
+void hv_apic_init(void);
+#else
+static inline void hv_apic_init(void) {}
+#endif
+
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
 static inline bool hv_is_hyperv_initialized(void) { return false; }
