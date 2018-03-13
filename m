Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933299AbeCMLwj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:52:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36598 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752515AbeCMLwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:52:37 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will.deacon@arm.com, dave.martin@arm.com,
        catalin.marinas@arm.com, marc.zyngier@arm.com, mark.rutland@arm.com,
        ard.biesheuvel@linaro.org, jnair@caviumnetworks.com,
        ckadabi@codeaurora.org, robin.murphy@arm.com, shankerd@codeaurora.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 22/22] arm64: Add work around for Arm Cortex-A55 Erratum 1024718
Date: Tue, 13 Mar 2018 11:51:20 +0000
Message-Id: <20180313115120.17256-23-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313115120.17256-1-suzuki.poulose@arm.com>
References: <20180313115120.17256-1-suzuki.poulose@arm.com>
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
Cc: Dave Martin <dave.martin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/Kconfig                     | 14 ++++++++++++++
 arch/arm64/kernel/cpufeature.c         | 16 +++++++++++++++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index c1d520de6dfe..3b2f2dd82225 100644
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
index 0f350b80aa84..9331baf8135c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -465,6 +465,20 @@ config ARM64_ERRATUM_843419
 
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
index 4e73c610a409..0fc097e2b72e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -963,9 +963,23 @@ static inline void __cpu_enable_hw_dbm(void)
 	isb();
 }
 
+static bool cpu_has_broken_dbm(void)
+{
+	/* List of CPUs which have broken DBM support. */
+	static const struct midr_range cpus[] = {
+#ifdef CONFIG_ARM64_ERRATUM_1024718
+		MIDR_RANGE(MIDR_CORTEX_A55, 0, 0, 1, 0),  // A55 r0p0 -r1p0
+#endif
+		{},
+	};
+
+	return is_midr_in_range_list(read_cpuid_id(), cpus);
+}
+
 static bool cpu_can_use_dbm(const struct arm64_cpu_capabilities *cap)
 {
-	return has_cpuid_feature(cap, SCOPE_LOCAL_CPU);
+	return has_cpuid_feature(cap, SCOPE_LOCAL_CPU) &&
+	       !cpu_has_broken_dbm();
 }
 
 static void cpu_enable_hw_dbm(struct arm64_cpu_capabilities const *cap)
-- 
2.14.3
