Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71995ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3648E206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3648E206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389172AbeGTNYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:24:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44748 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387847AbeGTNYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:24:55 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 162D4D08;
        Fri, 20 Jul 2018 12:34:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julien Grall <julien.grall@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.14 82/92] arm64: Add ssbd command-line option
Date:   Fri, 20 Jul 2018 14:14:26 +0200
Message-Id: <20180720121422.421465117@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121417.206337808@linuxfoundation.org>
References: <20180720121417.206337808@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit a43ae4dfe56a01f5b98ba0cb2f784b6a43bafcc6 upstream.

On a system where the firmware implements ARCH_WORKAROUND_2,
it may be useful to either permanently enable or disable the
workaround for cases where the user decides that they'd rather
not get a trap overhead, and keep the mitigation permanently
on or off instead of switching it on exception entry/exit.

In any case, default to the mitigation being enabled.

Reviewed-by: Julien Grall <julien.grall@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/kernel-parameters.txt |   17 +++
 arch/arm64/include/asm/cpufeature.h             |    6 +
 arch/arm64/kernel/cpu_errata.c                  |  103 ++++++++++++++++++++----
 3 files changed, 110 insertions(+), 16 deletions(-)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3997,6 +3997,23 @@
 			expediting.  Set to zero to disable automatic
 			expediting.
 
+	ssbd=		[ARM64,HW]
+			Speculative Store Bypass Disable control
+
+			On CPUs that are vulnerable to the Speculative
+			Store Bypass vulnerability and offer a
+			firmware based mitigation, this parameter
+			indicates how the mitigation should be used:
+
+			force-on:  Unconditionally enable mitigation for
+				   for both kernel and userspace
+			force-off: Unconditionally disable mitigation for
+				   for both kernel and userspace
+			kernel:    Always enable mitigation in the
+				   kernel, and offer a prctl interface
+				   to allow userspace to register its
+				   interest in being mitigated too.
+
 	stack_guard_gap=	[MM]
 			override the default stack gap protection. The value
 			is in page units and it defines how many pages prior
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -262,6 +262,12 @@ static inline bool system_uses_ttbr0_pan
 		!cpus_have_const_cap(ARM64_HAS_PAN);
 }
 
+#define ARM64_SSBD_UNKNOWN		-1
+#define ARM64_SSBD_FORCE_DISABLE	0
+#define ARM64_SSBD_KERNEL		1
+#define ARM64_SSBD_FORCE_ENABLE		2
+#define ARM64_SSBD_MITIGATED		3
+
 #endif /* __ASSEMBLY__ */
 
 #endif
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -231,6 +231,38 @@ static int qcom_enable_link_stack_saniti
 #ifdef CONFIG_ARM64_SSBD
 DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
 
+int ssbd_state __read_mostly = ARM64_SSBD_KERNEL;
+
+static const struct ssbd_options {
+	const char	*str;
+	int		state;
+} ssbd_options[] = {
+	{ "force-on",	ARM64_SSBD_FORCE_ENABLE, },
+	{ "force-off",	ARM64_SSBD_FORCE_DISABLE, },
+	{ "kernel",	ARM64_SSBD_KERNEL, },
+};
+
+static int __init ssbd_cfg(char *buf)
+{
+	int i;
+
+	if (!buf || !buf[0])
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(ssbd_options); i++) {
+		int len = strlen(ssbd_options[i].str);
+
+		if (strncmp(buf, ssbd_options[i].str, len))
+			continue;
+
+		ssbd_state = ssbd_options[i].state;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+early_param("ssbd", ssbd_cfg);
+
 void __init arm64_update_smccc_conduit(struct alt_instr *alt,
 				       __le32 *origptr, __le32 *updptr,
 				       int nr_inst)
@@ -274,44 +306,83 @@ static bool has_ssbd_mitigation(const st
 				    int scope)
 {
 	struct arm_smccc_res res;
-	bool supported = true;
+	bool required = true;
+	s32 val;
 
 	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
 
-	if (psci_ops.smccc_version == SMCCC_VERSION_1_0)
+	if (psci_ops.smccc_version == SMCCC_VERSION_1_0) {
+		ssbd_state = ARM64_SSBD_UNKNOWN;
 		return false;
+	}
 
-	/*
-	 * The probe function return value is either negative
-	 * (unsupported or mitigated), positive (unaffected), or zero
-	 * (requires mitigation). We only need to do anything in the
-	 * last case.
-	 */
 	switch (psci_ops.conduit) {
 	case PSCI_CONDUIT_HVC:
 		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_2, &res);
-		if ((int)res.a0 != 0)
-			supported = false;
 		break;
 
 	case PSCI_CONDUIT_SMC:
 		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_2, &res);
-		if ((int)res.a0 != 0)
-			supported = false;
 		break;
 
 	default:
-		supported = false;
+		ssbd_state = ARM64_SSBD_UNKNOWN;
+		return false;
+	}
+
+	val = (s32)res.a0;
+
+	switch (val) {
+	case SMCCC_RET_NOT_SUPPORTED:
+		ssbd_state = ARM64_SSBD_UNKNOWN;
+		return false;
+
+	case SMCCC_RET_NOT_REQUIRED:
+		pr_info_once("%s mitigation not required\n", entry->desc);
+		ssbd_state = ARM64_SSBD_MITIGATED;
+		return false;
+
+	case SMCCC_RET_SUCCESS:
+		required = true;
+		break;
+
+	case 1:	/* Mitigation not required on this CPU */
+		required = false;
+		break;
+
+	default:
+		WARN_ON(1);
+		return false;
 	}
 
-	if (supported) {
-		__this_cpu_write(arm64_ssbd_callback_required, 1);
+	switch (ssbd_state) {
+	case ARM64_SSBD_FORCE_DISABLE:
+		pr_info_once("%s disabled from command-line\n", entry->desc);
+		arm64_set_ssbd_mitigation(false);
+		required = false;
+		break;
+
+	case ARM64_SSBD_KERNEL:
+		if (required) {
+			__this_cpu_write(arm64_ssbd_callback_required, 1);
+			arm64_set_ssbd_mitigation(true);
+		}
+		break;
+
+	case ARM64_SSBD_FORCE_ENABLE:
+		pr_info_once("%s forced from command-line\n", entry->desc);
 		arm64_set_ssbd_mitigation(true);
+		required = true;
+		break;
+
+	default:
+		WARN_ON(1);
+		break;
 	}
 
-	return supported;
+	return required;
 }
 #endif	/* CONFIG_ARM64_SSBD */
 


