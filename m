Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752469AbeENS4L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:56:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:55031 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751855AbeENSw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:52:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="39244621"
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        "Arjan van de Ven" <arjan@infradead.org>,
        "Alan Cox" <alan@linux.intel.com>
Cc: "x86" <x86@kernel.org>, "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 01/15] x86/split_lock: Add CONFIG and enumerate #AC exception for split locked access feature
Date: Mon, 14 May 2018 11:52:11 -0700
Message-Id: <1526323945-211107-2-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
References: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CONFIG_SPLIT_LOCK_AC (default: y, dependent on X86 and CPU_SUP_INTEL)
to control inclusion of the feature.

Bit 29 in MSR TEST_CTL 0x33 can only be set on processors that support
the feature. On processors not supporting the feature, the bit is reserved
i.e. can not be set as one) or the MSR doesn't exist.

To detect the feature, attempt to set the bit in the MSR. If the writing
succeeds, the feature is available. Otherwise, the feature is not
supported on this platform.

And the enumeration happens before SMP so all processors can use
enumerated result when SMP boots.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/Kconfig                 | 12 ++++++++
 arch/x86/include/asm/cpu.h       |  5 ++++
 arch/x86/include/asm/msr-index.h |  5 ++++
 arch/x86/kernel/cpu/Makefile     |  1 +
 arch/x86/kernel/cpu/common.c     |  1 +
 arch/x86/kernel/cpu/split_lock.c | 62 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 86 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/split_lock.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c07f492b871a..38baf5fb8556 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -448,6 +448,18 @@ config INTEL_RDT
 
 	  Say N if unsure.
 
+config SPLIT_LOCK_AC
+	bool "#AC exception for split locked accesses support"
+	default y
+	depends on X86 && CPU_SUP_INTEL
+	help
+	  Select to support #AC exception for split locked accesses. More
+	  detailed information about the feature can be found in
+	  Intel Architecture Instruction Set Extensions and Future Feature
+	  Programming Reference.
+
+	  Say N if unsure.
+
 if X86_32
 config X86_BIGSMP
 	bool "Support for big SMP systems with more than 8 CPUs"
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index adc6cc86b062..c73b6d369047 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -40,4 +40,9 @@ int mwait_usable(const struct cpuinfo_x86 *);
 unsigned int x86_family(unsigned int sig);
 unsigned int x86_model(unsigned int sig);
 unsigned int x86_stepping(unsigned int sig);
+#ifdef CONFIG_SPLIT_LOCK_AC
+int __init enumerate_split_lock(void);
+#else /* CONFIG_SPLIT_LOCK_AC */
+static inline int enumerate_split_lock(void) { return 0; }
+#endif /* CONFIG_SPLIT_LOCK_AC */
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 53d5b1b9255e..c791190c8c71 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -39,6 +39,11 @@
 
 /* Intel MSRs. Some also available on other CPUs */
 
+#define MSR_TEST_CTL					0x00000033
+#define MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK_SHIFT		29
+#define MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK		BIT(29)
+#define MSR_TEST_CTL_DISABLE_LOCK_ASSERT_SPLIT_LOCK	BIT(31)
+
 #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
 #define SPEC_CTRL_IBRS			(1 << 0)   /* Indirect Branch Restricted Speculation */
 #define SPEC_CTRL_STIBP			(1 << 1)   /* Single Thread Indirect Branch Predictors */
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index a66229f51b12..1b633450e372 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_MICROCODE)			+= microcode/
 obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr-watchdog.o
 
 obj-$(CONFIG_HYPERVISOR_GUEST)		+= vmware.o hypervisor.o mshyperv.o
+obj-$(CONFIG_SPLIT_LOCK_AC)		+= split_lock.o
 
 ifdef CONFIG_X86_FEATURE_NAMES
 quiet_cmd_mkcapflags = MKCAP   $@
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ce243f7d2d4e..7684e82e254f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1008,6 +1008,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 	 */
 	setup_clear_cpu_cap(X86_FEATURE_PCID);
 #endif
+	enumerate_split_lock();
 }
 
 void __init early_cpu_init(void)
diff --git a/arch/x86/kernel/cpu/split_lock.c b/arch/x86/kernel/cpu/split_lock.c
new file mode 100644
index 000000000000..2ab28419e080
--- /dev/null
+++ b/arch/x86/kernel/cpu/split_lock.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Enable #AC exception for split locked accesses
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Author:
+ *	Fenghua Yu <fenghua.yu@intel.com>
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/printk.h>
+#include <asm/msr.h>
+
+static bool split_lock_ac_supported;
+
+/*
+ * On processors not supporting #AC exception for split lock feature,
+ * MSR_TEST_CTL may not exist or MSR_TEST_CTL exists but the bit 29 is
+ * reserved.
+ *
+ * MSR_TEST_CTL exists and the bit 29 can be set as one only on processors
+ * that support the feature.
+ *
+ * To enumerate #AC exception for split lock feature, try to set bit 29 as
+ * one in MSR_TEST_CTL. If the bit is successfully set as 1, the feature
+ * is supported and the variable split_lock_ac_supported is set as true.
+ * Otherwise, the feature is not available.
+ */
+void __init enumerate_split_lock(void)
+{
+	u32 l, h, l_orig;
+	int ret;
+
+	/* Attempt to read the MSR. If the MSR doesn't exist, reading fails. */
+	ret = rdmsr_safe(MSR_TEST_CTL, &l, &h);
+	if (ret)
+		return;
+
+	l_orig = l;
+
+	/* Turn on the split lock bit */
+	l |= MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK;
+
+	/* Set the bit in the MSR */
+	ret = wrmsr_safe(MSR_TEST_CTL, l, h);
+	if (ret)
+		return;
+
+	/* When coming to here, the feature is supported on this platform. */
+	split_lock_ac_supported = true;
+
+	/*
+	 *
+	 * Need to restore split lock setting to original BIOS setting before
+	 * leaving.
+	 */
+	wrmsr(MSR_TEST_CTL, l_orig, h);
+
+	pr_info("#AC exception for split locked accesses is supported\n");
+}
-- 
2.5.0
