Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbeCLMW4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:22:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60993 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbeCLMWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:22:54 -0400
Date: Mon, 12 Mar 2018 05:22:31 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-be7825c19b4866ddc7b1431740b69ede2eeb93c1@git.kernel.org>
Cc: kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, dave.hansen@intel.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, mingo@kernel.org, peterz@infradead.org,
        kai.huang@linux.intel.com, thomas.lendacky@amd.com
Reply-To: thomas.lendacky@amd.com, mingo@kernel.org,
        torvalds@linux-foundation.org, kai.huang@linux.intel.com,
        peterz@infradead.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hpa@zytor.com, kirill.shutemov@linux.intel.com, dave.hansen@intel.com
In-Reply-To: <20180305162610.37510-5-kirill.shutemov@linux.intel.com>
References: <20180305162610.37510-5-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/pconfig: Detect PCONFIG targets
Git-Commit-ID: be7825c19b4866ddc7b1431740b69ede2eeb93c1
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

Commit-ID:  be7825c19b4866ddc7b1431740b69ede2eeb93c1
Gitweb:     https://git.kernel.org/tip/be7825c19b4866ddc7b1431740b69ede2eeb93c1
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Mon, 5 Mar 2018 19:25:52 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 12:10:54 +0100

x86/pconfig: Detect PCONFIG targets

Intel PCONFIG targets are enumerated via new CPUID leaf 0x1b. This patch
detects all supported targets of PCONFIG and implements helper to check
if the target is supported.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kai Huang <kai.huang@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180305162610.37510-5-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/intel_pconfig.h | 15 +++++++
 arch/x86/kernel/cpu/Makefile         |  2 +-
 arch/x86/kernel/cpu/intel_pconfig.c  | 82 ++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+), 1 deletion(-)

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
