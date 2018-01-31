Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeAaS33 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:29:29 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41680 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752079AbeAaS3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:29:25 -0500
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
        will.deacon@arm.com, mark.rutland@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, ckadabi@codeaurora.org, dave.martin@arm.com,
        jnair@caviumnetworks.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 20/20] arm64: Add work around for Arm Cortex-A55 Erratum 1024718
Date: Wed, 31 Jan 2018 18:28:07 +0000
Message-Id: <20180131182807.32134-21-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131182807.32134-1-suzuki.poulose@arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some variants of the Arm Cortex-55 cores (r0p0, r0p1, r1p0) suffer
from an erratum 1024718, which causes incorrect updates when DBM/AP
bits in a page table entry is modified without a break-before-make
sequence. The work around is to skip enabling the hardware DBM feature
on the affected cores. The hardware Access Flag management features
is not affected. There are some other cores suffering from this
errata, which could be added to the midr_list to trigger the work
around.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: ckadabi@codeaurora.org
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/Kconfig                     | 14 ++++++++++++++
 arch/arm64/kernel/cpufeature.c         | 14 +++++++++++++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index b9d93e981a05..5203e71c113d 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -55,6 +55,7 @@ stable kernels.
 | ARM            | Cortex-A57      | #834220         | ARM64_ERRATUM_834220        |
 | ARM            | Cortex-A72      | #853709         | N/A                         |
 | ARM            | Cortex-A73      | #858921         | ARM64_ERRATUM_858921        |
+| ARM            | Cortex-A55      | #1024718        | ARM64_ERRATUM_1024718       |
 | ARM            | MMU-500         | #841119,#826419 | N/A                         |
 |                |                 |                 |                             |
 | Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375        |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1d51c8edf34b..070efe1f7ec3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -461,6 +461,20 @@ config ARM64_ERRATUM_843419
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_1024718
+	bool "Cortex-A55: 1024718: Update of DBM/AP bits without break before make might result in incorrect update"
+	default y
+	help
+	  This option adds work around for Arm Cortex-A55 Erratum 1024718.
+
+	  Affected Cortex-A55 cores (r0p0, r0p1, r1p0) could cause incorrect
+	  update of the hardware dirty bit when the DBM/AP bits are updated
+	  without a break-before-make. The work around is to disable the usage
+	  of hardware DBM locally on the affected cores. CPUs not affected by
+	  erratum will continue to use the feature.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 1f695a998eed..410fbddec129 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -923,9 +923,21 @@ static inline void __cpu_enable_hw_dbm(void)
 	isb();
 }
 
+static bool cpu_has_erratum_1024718(void)
+{
+	static const struct midr_range cpus[] = {
+		MIDR_RANGE(MIDR_CORTEX_A55, 0, 0, 1, 0),  // A55 r0p0 -r1p0
+		{},
+	};
+
+	return IS_ENABLED(CONFIG_ARM64_ERRATUM_1024718) &&
+	       is_midr_in_range_list(read_cpuid_id(), cpus);
+}
+
 static void cpu_enable_hw_dbm(struct arm64_cpu_capabilities const *cap)
 {
-	if (has_cpuid_feature(cap, SCOPE_LOCAL_CPU))
+	if (has_cpuid_feature(cap, SCOPE_LOCAL_CPU) &&
+	    !cpu_has_erratum_1024718())
 		__cpu_enable_hw_dbm();
 }
 #endif
-- 
2.14.3
