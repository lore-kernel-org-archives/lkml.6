Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032834AbeE0PqW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 11:46:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:28381 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032707AbeE0PqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 11:46:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,448,1520924400";
   d="scan'208";a="227741061"
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>
Cc: "Ashok Raj" <ashok.raj@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, "Alan Cox" <alan@linux.intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Arjan van de Ven" <arjan@infradead.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>, "x86" <x86@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [RFC PATCH 01/16] x86/split_lock: Add CONFIG and enumerate #AC exception for split locked access feature
Date: Sun, 27 May 2018 08:45:50 -0700
Message-Id: <1527435965-202085-2-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#AC for split lock is supported on Tremont and future processors. We
need to enumerate the feature on processors.

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

test_ctl.c is created to contain majority of split lock code. Hopefully
more features related to MSR_TEST_CTL will be added to the file and
share some code with split lock in future.

More information on the bit 29 and MSR TEST_CTL can be found in the latest
Intel Architecture Instruction Set Extensions and Future Features
Programming Reference.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/Kconfig                   | 12 ++++++++++
 arch/x86/include/asm/cpu.h         |  5 ++++
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/msr-index.h   |  4 ++++
 arch/x86/kernel/cpu/Makefile       |  1 +
 arch/x86/kernel/cpu/test_ctl.c     | 49 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/setup.c            |  2 ++
 7 files changed, 74 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/test_ctl.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6ca22706cd64..043cde9a9b08 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -449,6 +449,18 @@ config INTEL_RDT
 
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
index adc6cc86b062..8e224956e3e2 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -40,4 +40,9 @@ int mwait_usable(const struct cpuinfo_x86 *);
 unsigned int x86_family(unsigned int sig);
 unsigned int x86_model(unsigned int sig);
 unsigned int x86_stepping(unsigned int sig);
+#ifdef CONFIG_SPLIT_LOCK_AC
+void detect_split_lock_ac(void);
+#else /* CONFIG_SPLIT_LOCK_AC */
+static inline void detect_split_lock_ac(void) {}
+#endif /* CONFIG_SPLIT_LOCK_AC */
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index fb00a2fca990..8278d2ced4ea 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -219,6 +219,7 @@
 #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 (Zen) */
+#define X86_FEATURE_SPLIT_LOCK_AC	( 7*32+29) /* #AC exception for split locked access */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index fda2114197b3..3b0fe0f55a61 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -39,6 +39,10 @@
 
 /* Intel MSRs. Some also available on other CPUs */
 
+#define MSR_TEST_CTL					0x00000033
+#define MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK_SHIFT	29
+#define MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK		BIT(29)
+
 #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
 #define SPEC_CTRL_IBRS			(1 << 0)   /* Indirect Branch Restricted Speculation */
 #define SPEC_CTRL_STIBP			(1 << 1)   /* Single Thread Indirect Branch Predictors */
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 7a40196967cb..228654485b3f 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_MICROCODE)			+= microcode/
 obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr-watchdog.o
 
 obj-$(CONFIG_HYPERVISOR_GUEST)		+= vmware.o hypervisor.o mshyperv.o
+obj-$(CONFIG_SPLIT_LOCK_AC)		+= test_ctl.o
 
 ifdef CONFIG_X86_FEATURE_NAMES
 quiet_cmd_mkcapflags = MKCAP   $@
diff --git a/arch/x86/kernel/cpu/test_ctl.c b/arch/x86/kernel/cpu/test_ctl.c
new file mode 100644
index 000000000000..46fa8e21f9f6
--- /dev/null
+++ b/arch/x86/kernel/cpu/test_ctl.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Enable #AC exception for split locked accesses in TEST_CTL MSR
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
+#include <linux/cpufeature.h>
+#include <asm/msr.h>
+
+/* Detete feature of #AC for split lock by probing bit 29 in MSR_TEST_CTL. */
+void detect_split_lock_ac(void)
+{
+	u64 val, orig_val;
+	int ret;
+
+	/* Attempt to read the MSR. If the MSR doesn't exist, reading fails. */
+	ret = rdmsrl_safe(MSR_TEST_CTL, &val);
+	if (ret)
+		return;
+
+	orig_val = val;
+
+	/* Turn on the split lock bit */
+	val |= MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK;
+
+	/*
+	 * Attempt to set bit 29 in the MSR. The bit is set successfully
+	 * only on processors that support #AC for split lock.
+	 */
+	ret = wrmsrl_safe(MSR_TEST_CTL, val);
+	if (ret)
+		return;
+
+	/* The feature is supported on CPU. */
+	setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_AC);
+
+	/*
+	 * Need to restore split lock setting to original firmware setting
+	 * before leaving.
+	 */
+	wrmsrl(MSR_TEST_CTL, orig_val);
+}
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 5c623dfe39d1..4deb1ad5b442 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1272,6 +1272,8 @@ void __init setup_arch(char **cmdline_p)
 
 	mcheck_init();
 
+	detect_split_lock_ac();
+
 	arch_init_ideal_nops();
 
 	register_refined_jiffies(CLOCK_TICK_RATE);
-- 
2.5.0
