Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752717AbeERKgI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:36:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:20875 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752802AbeERKfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:35:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,414,1520924400";
   d="scan'208";a="200460090"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 5/7] x86/cpu: Move early cpu initialization into a separate translation unit
Date: Fri, 18 May 2018 13:35:26 +0300
Message-Id: <20180518103528.59260-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518103528.59260-1-kirill.shutemov@linux.intel.com>
References: <20180518103528.59260-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__pgtable_l5_enabled shouldn't be needed after system has booted, we can
mark it as __initdata, but it requires preparation.

This patch moves early cpu initialization into a separate translation
unit. This limits effect of USE_EARLY_PGTABLE_L5 to less code.

Without the change cpu_init() uses __pgtable_l5_enabled. cpu_init() is
not __init function and it leads to section mismatch.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/cpu/Makefile |   1 +
 arch/x86/kernel/cpu/common.c | 194 ++++-------------------------------
 arch/x86/kernel/cpu/cpu.h    |   7 ++
 arch/x86/kernel/cpu/early.c  | 159 ++++++++++++++++++++++++++++
 4 files changed, 189 insertions(+), 172 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/early.c

diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index a66229f51b12..6d88889706a8 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -19,6 +19,7 @@ CFLAGS_common.o		:= $(nostackp)
 
 obj-y			:= intel_cacheinfo.o scattered.o topology.o
 obj-y			+= common.o
+obj-y			+= early.o
 obj-y			+= rdrand.o
 obj-y			+= match.o
 obj-y			+= bugs.o
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a32f3c02327f..381675c7e485 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -47,7 +47,6 @@
 #include <asm/pat.h>
 #include <asm/microcode.h>
 #include <asm/microcode_intel.h>
-#include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -98,7 +97,7 @@ static const struct cpu_dev default_cpu = {
 	.c_x86_vendor	= X86_VENDOR_UNKNOWN,
 };
 
-static const struct cpu_dev *this_cpu = &default_cpu;
+const struct cpu_dev *this_cpu_dev = &default_cpu;
 
 DEFINE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page) = { .gdt = {
 #ifdef CONFIG_X86_64
@@ -419,7 +418,7 @@ cpuid_dependent_features[] = {
 	{ 0, 0 }
 };
 
-static void filter_cpuid_features(struct cpuinfo_x86 *c, bool warn)
+void filter_cpuid_features(struct cpuinfo_x86 *c, bool warn)
 {
 	const struct cpuid_dependent_feature *df;
 
@@ -464,10 +463,10 @@ static const char *table_lookup_model(struct cpuinfo_x86 *c)
 	if (c->x86_model >= 16)
 		return NULL;	/* Range check */
 
-	if (!this_cpu)
+	if (!this_cpu_dev)
 		return NULL;
 
-	info = this_cpu->legacy_models;
+	info = this_cpu_dev->legacy_models;
 
 	while (info->family) {
 		if (info->family == c->x86)
@@ -544,7 +543,7 @@ void switch_to_new_gdt(int cpu)
 	load_percpu_segment(cpu);
 }
 
-static const struct cpu_dev *cpu_devs[X86_VENDOR_NUM] = {};
+const struct cpu_dev *cpu_devs[X86_VENDOR_NUM] = {};
 
 static void get_model_name(struct cpuinfo_x86 *c)
 {
@@ -602,8 +601,8 @@ void cpu_detect_cache_sizes(struct cpuinfo_x86 *c)
 	c->x86_tlbsize += ((ebx >> 16) & 0xfff) + (ebx & 0xfff);
 #else
 	/* do processor-specific cache resizing */
-	if (this_cpu->legacy_cache_size)
-		l2size = this_cpu->legacy_cache_size(c, l2size);
+	if (this_cpu_dev->legacy_cache_size)
+		l2size = this_cpu_dev->legacy_cache_size(c, l2size);
 
 	/* Allow user to override all this if necessary. */
 	if (cachesize_override != -1)
@@ -626,8 +625,8 @@ u16 __read_mostly tlb_lld_1g[NR_INFO];
 
 static void cpu_detect_tlb(struct cpuinfo_x86 *c)
 {
-	if (this_cpu->c_detect_tlb)
-		this_cpu->c_detect_tlb(c);
+	if (this_cpu_dev->c_detect_tlb)
+		this_cpu_dev->c_detect_tlb(c);
 
 	pr_info("Last level iTLB entries: 4KB %d, 2MB %d, 4MB %d\n",
 		tlb_lli_4k[ENTRIES], tlb_lli_2m[ENTRIES],
@@ -689,7 +688,7 @@ void detect_ht(struct cpuinfo_x86 *c)
 #endif
 }
 
-static void get_cpu_vendor(struct cpuinfo_x86 *c)
+void get_cpu_vendor(struct cpuinfo_x86 *c)
 {
 	char *v = c->x86_vendor_id;
 	int i;
@@ -702,8 +701,8 @@ static void get_cpu_vendor(struct cpuinfo_x86 *c)
 		    (cpu_devs[i]->c_ident[1] &&
 		     !strcmp(v, cpu_devs[i]->c_ident[1]))) {
 
-			this_cpu = cpu_devs[i];
-			c->x86_vendor = this_cpu->c_x86_vendor;
+			this_cpu_dev = cpu_devs[i];
+			c->x86_vendor = this_cpu_dev->c_x86_vendor;
 			return;
 		}
 	}
@@ -712,7 +711,7 @@ static void get_cpu_vendor(struct cpuinfo_x86 *c)
 		    "CPU: Your system may be unstable.\n", v);
 
 	c->x86_vendor = X86_VENDOR_UNKNOWN;
-	this_cpu = &default_cpu;
+	this_cpu_dev = &default_cpu;
 }
 
 void cpu_detect(struct cpuinfo_x86 *c)
@@ -867,7 +866,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 	apply_forced_caps(c);
 }
 
-static void get_cpu_address_sizes(struct cpuinfo_x86 *c)
+void get_cpu_address_sizes(struct cpuinfo_x86 *c)
 {
 	u32 eax, ebx, ecx, edx;
 
@@ -883,7 +882,7 @@ static void get_cpu_address_sizes(struct cpuinfo_x86 *c)
 #endif
 }
 
-static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
+void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_X86_32
 	int i;
@@ -909,155 +908,6 @@ static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
 #endif
 }
 
-static const __initconst struct x86_cpu_id cpu_no_speculation[] = {
-	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_CEDARVIEW,	X86_FEATURE_ANY },
-	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_CLOVERVIEW,	X86_FEATURE_ANY },
-	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_LINCROFT,	X86_FEATURE_ANY },
-	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_PENWELL,	X86_FEATURE_ANY },
-	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_PINEVIEW,	X86_FEATURE_ANY },
-	{ X86_VENDOR_CENTAUR,	5 },
-	{ X86_VENDOR_INTEL,	5 },
-	{ X86_VENDOR_NSC,	5 },
-	{ X86_VENDOR_ANY,	4 },
-	{}
-};
-
-static const __initconst struct x86_cpu_id cpu_no_meltdown[] = {
-	{ X86_VENDOR_AMD },
-	{}
-};
-
-static bool __init cpu_vulnerable_to_meltdown(struct cpuinfo_x86 *c)
-{
-	u64 ia32_cap = 0;
-
-	if (x86_match_cpu(cpu_no_meltdown))
-		return false;
-
-	if (cpu_has(c, X86_FEATURE_ARCH_CAPABILITIES))
-		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
-
-	/* Rogue Data Cache Load? No! */
-	if (ia32_cap & ARCH_CAP_RDCL_NO)
-		return false;
-
-	return true;
-}
-
-/*
- * Do minimum CPU detection early.
- * Fields really needed: vendor, cpuid_level, family, model, mask,
- * cache alignment.
- * The others are not touched to avoid unwanted side effects.
- *
- * WARNING: this function is only called on the boot CPU.  Don't add code
- * here that is supposed to run on all CPUs.
- */
-static void __init early_identify_cpu(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_X86_64
-	c->x86_clflush_size = 64;
-	c->x86_phys_bits = 36;
-	c->x86_virt_bits = 48;
-#else
-	c->x86_clflush_size = 32;
-	c->x86_phys_bits = 32;
-	c->x86_virt_bits = 32;
-#endif
-	c->x86_cache_alignment = c->x86_clflush_size;
-
-	memset(&c->x86_capability, 0, sizeof c->x86_capability);
-	c->extended_cpuid_level = 0;
-
-	/* cyrix could have cpuid enabled via c_identify()*/
-	if (have_cpuid_p()) {
-		cpu_detect(c);
-		get_cpu_vendor(c);
-		get_cpu_cap(c);
-		get_cpu_address_sizes(c);
-		setup_force_cpu_cap(X86_FEATURE_CPUID);
-
-		if (this_cpu->c_early_init)
-			this_cpu->c_early_init(c);
-
-		c->cpu_index = 0;
-		filter_cpuid_features(c, false);
-
-		if (this_cpu->c_bsp_init)
-			this_cpu->c_bsp_init(c);
-	} else {
-		identify_cpu_without_cpuid(c);
-		setup_clear_cpu_cap(X86_FEATURE_CPUID);
-	}
-
-	setup_force_cpu_cap(X86_FEATURE_ALWAYS);
-
-	if (!x86_match_cpu(cpu_no_speculation)) {
-		if (cpu_vulnerable_to_meltdown(c))
-			setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);
-		setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
-		setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
-	}
-
-	fpu__init_system(c);
-
-#ifdef CONFIG_X86_32
-	/*
-	 * Regardless of whether PCID is enumerated, the SDM says
-	 * that it can't be enabled in 32-bit mode.
-	 */
-	setup_clear_cpu_cap(X86_FEATURE_PCID);
-#endif
-
-	/*
-	 * Later in the boot process pgtable_l5_enabled() relies on
-	 * cpu_feature_enabled(X86_FEATURE_LA57). If 5-level paging is not
-	 * enabled by this point we need to clear the feature bit to avoid
-	 * false-positives at the later stage.
-	 *
-	 * pgtable_l5_enabled() can be false here for several reasons:
-	 *  - 5-level paging is disabled compile-time;
-	 *  - it's 32-bit kernel;
-	 *  - machine doesn't support 5-level paging;
-	 *  - user specified 'no5lvl' in kernel command line.
-	 */
-	if (!pgtable_l5_enabled())
-		setup_clear_cpu_cap(X86_FEATURE_LA57);
-}
-
-void __init early_cpu_init(void)
-{
-	const struct cpu_dev *const *cdev;
-	int count = 0;
-
-#ifdef CONFIG_PROCESSOR_SELECT
-	pr_info("KERNEL supported cpus:\n");
-#endif
-
-	for (cdev = __x86_cpu_dev_start; cdev < __x86_cpu_dev_end; cdev++) {
-		const struct cpu_dev *cpudev = *cdev;
-
-		if (count >= X86_VENDOR_NUM)
-			break;
-		cpu_devs[count] = cpudev;
-		count++;
-
-#ifdef CONFIG_PROCESSOR_SELECT
-		{
-			unsigned int j;
-
-			for (j = 0; j < 2; j++) {
-				if (!cpudev->c_ident[j])
-					continue;
-				pr_info("  %s %s\n", cpudev->c_vendor,
-					cpudev->c_ident[j]);
-			}
-		}
-#endif
-	}
-	early_identify_cpu(&boot_cpu_data);
-}
-
 /*
  * The NOPL instruction is supposed to exist on all CPUs of family >= 6;
  * unfortunately, that's not true in practice because of early VIA
@@ -1234,8 +1084,8 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 
 	generic_identify(c);
 
-	if (this_cpu->c_identify)
-		this_cpu->c_identify(c);
+	if (this_cpu_dev->c_identify)
+		this_cpu_dev->c_identify(c);
 
 	/* Clear/Set all flags overridden by options, after probe */
 	apply_forced_caps(c);
@@ -1254,8 +1104,8 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	 * At the end of this section, c->x86_capability better
 	 * indicate the features this CPU genuinely supports!
 	 */
-	if (this_cpu->c_init)
-		this_cpu->c_init(c);
+	if (this_cpu_dev->c_init)
+		this_cpu_dev->c_init(c);
 
 	/* Disable the PN if appropriate */
 	squash_the_stupid_serial_number(c);
@@ -1389,7 +1239,7 @@ void print_cpu_info(struct cpuinfo_x86 *c)
 	const char *vendor = NULL;
 
 	if (c->x86_vendor < X86_VENDOR_NUM) {
-		vendor = this_cpu->c_vendor;
+		vendor = this_cpu_dev->c_vendor;
 	} else {
 		if (c->cpuid_level >= 0)
 			vendor = c->x86_vendor_id;
@@ -1763,8 +1613,8 @@ void cpu_init(void)
 
 static void bsp_resume(void)
 {
-	if (this_cpu->c_bsp_resume)
-		this_cpu->c_bsp_resume(&boot_cpu_data);
+	if (this_cpu_dev->c_bsp_resume)
+		this_cpu_dev->c_bsp_resume(&boot_cpu_data);
 }
 
 static struct syscore_ops cpu_syscore_ops = {
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index e806b11a99af..d633835b59ee 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -45,8 +45,15 @@ struct _tlb_table {
 extern const struct cpu_dev *const __x86_cpu_dev_start[],
 			    *const __x86_cpu_dev_end[];
 
+extern const struct cpu_dev *cpu_devs[];
+extern const struct cpu_dev *this_cpu_dev;
+
 extern void get_cpu_cap(struct cpuinfo_x86 *c);
+extern void get_cpu_vendor(struct cpuinfo_x86 *c);
+extern void get_cpu_address_sizes(struct cpuinfo_x86 *c);
 extern void cpu_detect_cache_sizes(struct cpuinfo_x86 *c);
+extern void identify_cpu_without_cpuid(struct cpuinfo_x86 *c);
+extern void filter_cpuid_features(struct cpuinfo_x86 *c, bool warn);
 
 unsigned int aperfmperf_get_khz(int cpu);
 
diff --git a/arch/x86/kernel/cpu/early.c b/arch/x86/kernel/cpu/early.c
new file mode 100644
index 000000000000..cb42c1d909f6
--- /dev/null
+++ b/arch/x86/kernel/cpu/early.c
@@ -0,0 +1,159 @@
+#include <linux/linkage.h>
+#include <linux/kernel.h>
+
+#include <asm/processor.h>
+#include <asm/cpu.h>
+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
+#include <asm/fpu/internal.h>
+
+#include "cpu.h"
+
+static const __initconst struct x86_cpu_id cpu_no_speculation[] = {
+	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_CEDARVIEW,	X86_FEATURE_ANY },
+	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_CLOVERVIEW,	X86_FEATURE_ANY },
+	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_LINCROFT,	X86_FEATURE_ANY },
+	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_PENWELL,	X86_FEATURE_ANY },
+	{ X86_VENDOR_INTEL,	6, INTEL_FAM6_ATOM_PINEVIEW,	X86_FEATURE_ANY },
+	{ X86_VENDOR_CENTAUR,	5 },
+	{ X86_VENDOR_INTEL,	5 },
+	{ X86_VENDOR_NSC,	5 },
+	{ X86_VENDOR_ANY,	4 },
+	{}
+};
+
+static const __initconst struct x86_cpu_id cpu_no_meltdown[] = {
+	{ X86_VENDOR_AMD },
+	{}
+};
+
+static bool __init cpu_vulnerable_to_meltdown(struct cpuinfo_x86 *c)
+{
+	u64 ia32_cap = 0;
+
+	if (x86_match_cpu(cpu_no_meltdown))
+		return false;
+
+	if (cpu_has(c, X86_FEATURE_ARCH_CAPABILITIES))
+		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
+
+	/* Rogue Data Cache Load? No! */
+	if (ia32_cap & ARCH_CAP_RDCL_NO)
+		return false;
+
+	return true;
+}
+
+/*
+ * Do minimum CPU detection early.
+ * Fields really needed: vendor, cpuid_level, family, model, mask,
+ * cache alignment.
+ * The others are not touched to avoid unwanted side effects.
+ *
+ * WARNING: this function is only called on the boot CPU.  Don't add code
+ * here that is supposed to run on all CPUs.
+ */
+static void __init early_identify_cpu(struct cpuinfo_x86 *c)
+{
+#ifdef CONFIG_X86_64
+	c->x86_clflush_size = 64;
+	c->x86_phys_bits = 36;
+	c->x86_virt_bits = 48;
+#else
+	c->x86_clflush_size = 32;
+	c->x86_phys_bits = 32;
+	c->x86_virt_bits = 32;
+#endif
+	c->x86_cache_alignment = c->x86_clflush_size;
+
+	memset(&c->x86_capability, 0, sizeof c->x86_capability);
+	c->extended_cpuid_level = 0;
+
+	/* cyrix could have cpuid enabled via c_identify()*/
+	if (have_cpuid_p()) {
+		cpu_detect(c);
+		get_cpu_vendor(c);
+		get_cpu_cap(c);
+		get_cpu_address_sizes(c);
+		setup_force_cpu_cap(X86_FEATURE_CPUID);
+
+		if (this_cpu_dev->c_early_init)
+			this_cpu_dev->c_early_init(c);
+
+		c->cpu_index = 0;
+		filter_cpuid_features(c, false);
+
+		if (this_cpu_dev->c_bsp_init)
+			this_cpu_dev->c_bsp_init(c);
+	} else {
+		identify_cpu_without_cpuid(c);
+		setup_clear_cpu_cap(X86_FEATURE_CPUID);
+	}
+
+	setup_force_cpu_cap(X86_FEATURE_ALWAYS);
+
+	if (!x86_match_cpu(cpu_no_speculation)) {
+		if (cpu_vulnerable_to_meltdown(c))
+			setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);
+		setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
+		setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
+	}
+
+	fpu__init_system(c);
+
+#ifdef CONFIG_X86_32
+	/*
+	 * Regardless of whether PCID is enumerated, the SDM says
+	 * that it can't be enabled in 32-bit mode.
+	 */
+	setup_clear_cpu_cap(X86_FEATURE_PCID);
+#endif
+
+	/*
+	 * Later in the boot process pgtable_l5_enabled() relies on
+	 * cpu_feature_enabled(X86_FEATURE_LA57). If 5-level paging is not
+	 * enabled by this point we need to clear the feature bit to avoid
+	 * false-positives at the later stage.
+	 *
+	 * pgtable_l5_enabled() can be false here for several reasons:
+	 *  - 5-level paging is disabled compile-time;
+	 *  - it's 32-bit kernel;
+	 *  - machine doesn't support 5-level paging;
+	 *  - user specified 'no5lvl' in kernel command line.
+	 */
+	if (!pgtable_l5_enabled())
+		setup_clear_cpu_cap(X86_FEATURE_LA57);
+}
+
+void __init early_cpu_init(void)
+{
+	const struct cpu_dev *const *cdev;
+	int count = 0;
+
+#ifdef CONFIG_PROCESSOR_SELECT
+	pr_info("KERNEL supported cpus:\n");
+#endif
+
+	for (cdev = __x86_cpu_dev_start; cdev < __x86_cpu_dev_end; cdev++) {
+		const struct cpu_dev *cpudev = *cdev;
+
+		if (count >= X86_VENDOR_NUM)
+			break;
+		cpu_devs[count] = cpudev;
+		count++;
+
+#ifdef CONFIG_PROCESSOR_SELECT
+		{
+			unsigned int j;
+
+			for (j = 0; j < 2; j++) {
+				if (!cpudev->c_ident[j])
+					continue;
+				pr_info("  %s %s\n", cpudev->c_vendor,
+					cpudev->c_ident[j]);
+			}
+		}
+#endif
+	}
+	early_identify_cpu(&boot_cpu_data);
+}
-- 
2.17.0
