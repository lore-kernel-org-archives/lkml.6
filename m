Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932422AbeBLBQh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 20:16:37 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39444 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932311AbeBLBQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 20:16:36 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF5B8608BF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=shankerd@codeaurora.org
From: Shanker Donthineni <shankerd@codeaurora.org>
To: Will Deacon <will.deacon@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vikram Sethi <vikrams@codeaurora.org>,
        Sean Campbell <scampbel@codeaurora.org>,
        Thomas Speier <tspeier@codeaurora.org>,
        Shanker Donthineni <shankerd@codeaurora.org>
Subject: [PATCH] arm64: Add missing Falkor part number for branch predictor hardening
Date: Sun, 11 Feb 2018 19:16:15 -0600
Message-Id: <1518398175-28378-1-git-send-email-shankerd@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

References to CPU part number MIDR_QCOM_FALKOR were dropped from the
mailing list patch due to mainline/arm64 branch dependency. So this
patch adds the missing part number.

Fixes: ec82b567a74f ("arm64: Implement branch predictor hardening for Falkor")
Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
 arch/arm64/kernel/cpu_errata.c | 9 +++++++++
 arch/arm64/kvm/hyp/switch.c    | 4 +++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 0782359..52f15cd 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -408,6 +408,15 @@ static int qcom_enable_link_stack_sanitization(void *data)
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
+		MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR),
+		.enable = qcom_enable_link_stack_sanitization,
+	},
+	{
+		.capability = ARM64_HARDEN_BP_POST_GUEST_EXIT,
+		MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR),
+	},
+	{
+		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
 		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
 		.enable = enable_smccc_arch_workaround_1,
 	},
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 116252a8..870f4b1 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -407,8 +407,10 @@ int __hyp_text __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 		u32 midr = read_cpuid_id();
 
 		/* Apply BTAC predictors mitigation to all Falkor chips */
-		if ((midr & MIDR_CPU_MODEL_MASK) == MIDR_QCOM_FALKOR_V1)
+		if (((midr & MIDR_CPU_MODEL_MASK) == MIDR_QCOM_FALKOR) ||
+		    ((midr & MIDR_CPU_MODEL_MASK) == MIDR_QCOM_FALKOR_V1)) {
 			__qcom_hyp_sanitize_btac_predictors();
+		}
 	}
 
 	fp_enabled = __fpsimd_enabled();
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
