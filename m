Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752725AbeEVPMJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:12:09 -0400
Received: from foss.arm.com ([217.140.101.70]:39346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751527AbeEVPHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:07:23 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Cc: Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoffer Dall <christoffer.dall@arm.com>
Subject: [PATCH 04/14] arm64: Add ARCH_WORKAROUND_2 probing
Date: Tue, 22 May 2018 16:06:38 +0100
Message-Id: <20180522150648.28297-5-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180522150648.28297-1-marc.zyngier@arm.com>
References: <20180522150648.28297-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As for Spectre variant-2, we rely on SMCCC 1.1 to provide the
discovery mechanism for detecting the SSBD mitigation.

A new capability is also allocated for that purpose, and a
config option.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/Kconfig               |  9 ++++++
 arch/arm64/include/asm/cpucaps.h |  3 +-
 arch/arm64/kernel/cpu_errata.c   | 69 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index eb2cf4938f6d..b2103b4df467 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -938,6 +938,15 @@ config HARDEN_EL2_VECTORS
 
 	  If unsure, say Y.
 
+config ARM64_SSBD
+	bool "Speculative Store Bypass Disable" if EXPERT
+	default y
+	help
+	  This enables mitigation of the bypassing of previous stores
+	  by speculative loads.
+
+	  If unsure, say Y.
+
 menuconfig ARMV8_DEPRECATED
 	bool "Emulate deprecated/obsolete ARMv8 instructions"
 	depends on COMPAT
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index bc51b72fafd4..5b2facf786ba 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -48,7 +48,8 @@
 #define ARM64_HAS_CACHE_IDC			27
 #define ARM64_HAS_CACHE_DIC			28
 #define ARM64_HW_DBM				29
+#define ARM64_SSBD			30
 
-#define ARM64_NCAPS				30
+#define ARM64_NCAPS				31
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 0288d6cf560e..7fd6d5b001f5 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -250,6 +250,67 @@ void __init arm64_update_smccc_conduit(struct alt_instr *alt,
 
 	*updptr = cpu_to_le32(insn);
 }
+
+static void do_ssbd(bool state)
+{
+	switch (psci_ops.conduit) {
+	case PSCI_CONDUIT_HVC:
+		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_WORKAROUND_2, state, NULL);
+		break;
+
+	case PSCI_CONDUIT_SMC:
+		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_WORKAROUND_2, state, NULL);
+		break;
+
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
+}
+
+static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
+				    int scope)
+{
+	struct arm_smccc_res res;
+	bool supported = true;
+
+	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
+
+	if (psci_ops.smccc_version == SMCCC_VERSION_1_0)
+		return false;
+
+	/*
+	 * The probe function return value is either negative
+	 * (unsupported or mitigated), positive (unaffected), or zero
+	 * (requires mitigation). We only need to do anything in the
+	 * last case.
+	 */
+	switch (psci_ops.conduit) {
+	case PSCI_CONDUIT_HVC:
+		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+				  ARM_SMCCC_ARCH_WORKAROUND_2, &res);
+		if ((int)res.a0 != 0)
+			supported = false;
+		break;
+
+	case PSCI_CONDUIT_SMC:
+		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+				  ARM_SMCCC_ARCH_WORKAROUND_2, &res);
+		if ((int)res.a0 != 0)
+			supported = false;
+		break;
+
+	default:
+		supported = false;
+	}
+
+	if (supported) {
+		__this_cpu_write(arm64_ssbd_callback_required, 1);
+		do_ssbd(true);
+	}
+
+	return supported;
+}
 #endif	/* CONFIG_ARM64_SSBD */
 
 #define CAP_MIDR_RANGE(model, v_min, r_min, v_max, r_max)	\
@@ -506,6 +567,14 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 		ERRATA_MIDR_RANGE_LIST(arm64_harden_el2_vectors),
 	},
+#endif
+#ifdef CONFIG_ARM64_SSBD
+	{
+		.desc = "Speculative Store Bypass Disable",
+		.capability = ARM64_SSBD,
+		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
+		.matches = has_ssbd_mitigation,
+	},
 #endif
 	{
 	}
-- 
2.14.2
