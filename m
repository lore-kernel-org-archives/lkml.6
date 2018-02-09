Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753469AbeBIOIN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 09:08:13 -0500
Received: from mga12.intel.com ([192.55.52.136]:17069 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753141AbeBIOIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:08:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,483,1511856000";
   d="scan'208";a="16764947"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 4/5] x86/pconfig: Detect PCONFIG targets
Date: Fri,  9 Feb 2018 17:07:53 +0300
Message-Id: <20180209140754.17062-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180209140754.17062-1-kirill.shutemov@linux.intel.com>
References: <20180209140754.17062-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel PCONFIG targets are enumerated via new CPUID leaf 0x1b. This patch
detects all supported targets of PCONFIG and implements helper to check
if the target is supported.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/intel_pconfig.h | 15 +++++++
 arch/x86/kernel/cpu/Makefile         |  2 +-
 arch/x86/kernel/cpu/intel_pconfig.c  | 82 ++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/include/asm/intel_pconfig.h
 create mode 100644 arch/x86/kernel/cpu/intel_pconfig.c

diff --git a/arch/x86/include/asm/intel_pconfig.h b/arch/x86/include/asm/intel_pconfig.h
new file mode 100644
index 000000000000..fb7a37c3798b
--- /dev/null
+++ b/arch/x86/include/asm/intel_pconfig.h
@@ -0,0 +1,15 @@
+#ifndef	_ASM_X86_INTEL_PCONFIG_H
+#define	_ASM_X86_INTEL_PCONFIG_H
+
+#include <asm/asm.h>
+#include <asm/processor.h>
+
+enum pconfig_target {
+	INVALID_TARGET	= 0,
+	MKTME_TARGET	= 1,
+	PCONFIG_TARGET_NR
+};
+
+int pconfig_target_supported(enum pconfig_target target);
+
+#endif	/* _ASM_X86_INTEL_PCONFIG_H */
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 570e8bb1f386..a66229f51b12 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -28,7 +28,7 @@ obj-y			+= cpuid-deps.o
 obj-$(CONFIG_PROC_FS)	+= proc.o
 obj-$(CONFIG_X86_FEATURE_NAMES) += capflags.o powerflags.o
 
-obj-$(CONFIG_CPU_SUP_INTEL)		+= intel.o
+obj-$(CONFIG_CPU_SUP_INTEL)		+= intel.o intel_pconfig.o
 obj-$(CONFIG_CPU_SUP_AMD)		+= amd.o
 obj-$(CONFIG_CPU_SUP_CYRIX_32)		+= cyrix.o
 obj-$(CONFIG_CPU_SUP_CENTAUR)		+= centaur.o
diff --git a/arch/x86/kernel/cpu/intel_pconfig.c b/arch/x86/kernel/cpu/intel_pconfig.c
new file mode 100644
index 000000000000..0771a905b286
--- /dev/null
+++ b/arch/x86/kernel/cpu/intel_pconfig.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel PCONFIG instruction support.
+ *
+ * Copyright (C) 2017 Intel Corporation
+ *
+ * Author:
+ *	Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
+ */
+
+#include <asm/cpufeature.h>
+#include <asm/intel_pconfig.h>
+
+#define	PCONFIG_CPUID			0x1b
+
+#define PCONFIG_CPUID_SUBLEAF_MASK	((1 << 12) - 1)
+
+/* Subleaf type (EAX) for PCONFIG CPUID leaf (0x1B) */
+enum {
+	PCONFIG_CPUID_SUBLEAF_INVALID	= 0,
+	PCONFIG_CPUID_SUBLEAF_TARGETID	= 1,
+};
+
+/* Bitmask of supported targets */
+static u64 targets_supported __read_mostly;
+
+int pconfig_target_supported(enum pconfig_target target)
+{
+	/*
+	 * We would need to re-think the implementation once we get > 64
+	 * PCONFIG targets. Spec allows up to 2^32 targets.
+	 */
+	BUILD_BUG_ON(PCONFIG_TARGET_NR >= 64);
+
+	if (WARN_ON_ONCE(target >= 64))
+		return 0;
+	return targets_supported & (1ULL << target);
+}
+
+static int __init intel_pconfig_init(void)
+{
+	int subleaf;
+
+	if (!boot_cpu_has(X86_FEATURE_PCONFIG))
+		return 0;
+
+	/*
+	 * Scan subleafs of PCONFIG CPUID leaf.
+	 *
+	 * Subleafs of the same type need not to be consecutive.
+	 *
+	 * Stop on the first invalid subleaf type. All subleafs after the first
+	 * invalid are invalid too.
+	 */
+	for (subleaf = 0; subleaf < INT_MAX; subleaf++) {
+		struct cpuid_regs regs;
+
+		cpuid_count(PCONFIG_CPUID, subleaf,
+				&regs.eax, &regs.ebx, &regs.ecx, &regs.edx);
+
+		switch (regs.eax & PCONFIG_CPUID_SUBLEAF_MASK) {
+		case PCONFIG_CPUID_SUBLEAF_INVALID:
+			/* Stop on the first invalid subleaf */
+			goto out;
+		case PCONFIG_CPUID_SUBLEAF_TARGETID:
+			/* Mark supported PCONFIG targets */
+			if (regs.ebx < 64)
+				targets_supported |= (1ULL << regs.ebx);
+			if (regs.ecx < 64)
+				targets_supported |= (1ULL << regs.ecx);
+			if (regs.edx < 64)
+				targets_supported |= (1ULL << regs.edx);
+			break;
+		default:
+			/* Unknown CPUID.PCONFIG subleaf: ignore */
+			break;
+		}
+	}
+out:
+	return 0;
+}
+arch_initcall(intel_pconfig_init);
-- 
2.15.1
