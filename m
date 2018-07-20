Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7283ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6911320652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6911320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389565AbeGTNad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:30:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52444 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731695AbeGTNac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:30:32 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 69041CDE;
        Fri, 20 Jul 2018 12:39:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julien Grall <julien.grall@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.17 088/101] arm64: Add ARCH_WORKAROUND_2 probing
Date:   Fri, 20 Jul 2018 14:14:34 +0200
Message-Id: <20180720121426.972844770@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit a725e3dda1813ed306734823ac4c65ca04e38500 upstream.

As for Spectre variant-2, we rely on SMCCC 1.1 to provide the
discovery mechanism for detecting the SSBD mitigation.

A new capability is also allocated for that purpose, and a
config option.

Reviewed-by: Julien Grall <julien.grall@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/Kconfig               |    9 +++++
 arch/arm64/include/asm/cpucaps.h |    3 +
 arch/arm64/kernel/cpu_errata.c   |   69 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 1 deletion(-)

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
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -48,7 +48,8 @@
 #define ARM64_HAS_CACHE_IDC			27
 #define ARM64_HAS_CACHE_DIC			28
 #define ARM64_HW_DBM				29
+#define ARM64_SSBD				30
 
-#define ARM64_NCAPS				30
+#define ARM64_NCAPS				31
 
 #endif /* __ASM_CPUCAPS_H */
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -256,6 +256,67 @@ void __init arm64_update_smccc_conduit(s
 
 	*updptr = cpu_to_le32(insn);
 }
+
+static void arm64_set_ssbd_mitigation(bool state)
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
+		arm64_set_ssbd_mitigation(true);
+	}
+
+	return supported;
+}
 #endif	/* CONFIG_ARM64_SSBD */
 
 #define CAP_MIDR_RANGE(model, v_min, r_min, v_max, r_max)	\
@@ -514,6 +575,14 @@ const struct arm64_cpu_capabilities arm6
 		ERRATA_MIDR_RANGE_LIST(arm64_harden_el2_vectors),
 	},
 #endif
+#ifdef CONFIG_ARM64_SSBD
+	{
+		.desc = "Speculative Store Bypass Disable",
+		.capability = ARM64_SSBD,
+		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
+		.matches = has_ssbd_mitigation,
+	},
+#endif
 	{
 	}
 };


