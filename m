Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224pc27Y7gjLyD1lfDwudg4mw2TDkDJ6fC+lR+8VcKKAjpakB52CcKQE+0viCVdMSpGeMcT5
ARC-Seal: i=1; a=rsa-sha256; t=1518708917; cv=none;
        d=google.com; s=arc-20160816;
        b=uTQTAxxY7vBrN4gUJh8uu73dfuy+ojH8sUnYBvz+JENNyxQsascjXla2kQ5K/aXz15
         ve+fCDhiS5x160/NimVJEX8Ys5cWV3QMAZ/JjNqIuAfbOmSS48NZNz1Pv9dSnizhWci7
         2xLPdj7tDzQmfWwMTNScW1gF7ftBOqDLiF1LYotgx3OrN5IKbm2li91MyLdo5yw2fsRA
         tQiQ0Z1vE2kBvKyNLpxLtaAf4h2DobDDnU5iPTcPOSFCXxGClZ+sYHvLRsne0PCvGSxG
         nrypY3CLiF7scTPpNSXBmlXHtSbFlR7VR16blBt82BMpGGYZGcbMlCN8R2VPt3+wCQsD
         dO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ajfI16YchmH73t/JvYPQoDe1RyR3bw8hcqBBZW3iKfM=;
        b=g76ZjbNwFDavn/sb98ui7ARoZ5Md/XjOG8ZZdy0dYCMsy0RI+cuIII92n0JzeUfPTV
         uClDB2GK+9ZRdYxu94auQwY0b7BKFsTNWPwiU70K18R8xSAC7FM1nazQS+DAjMgDuuPa
         u/W3vOIrVX48MX8ObmNMJ3oG5i8vKmHDbQaltSQJ9i6cNmIsAN0Qn5jgfEHv98NUQaU/
         swUdBMW+uOMfiVhu+GplXLUH7YvoLk6g2k1XqwvCbpdXn+Wp1/OJqE2IX5AWZXH5ITxf
         5vxrHzsbwy8atff5SVlGrayeegMn36UDxzwq7LkvyiWnjO6O7IFelGJ/T9MbQliPh0ov
         Lv4g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.14 094/195] [Variant 2/Spectre-v2] arm64: Kill PSCI_GET_VERSION as a variant-2 workaround
Date: Thu, 15 Feb 2018 16:16:25 +0100
Message-Id: <20180215151710.395822109@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481721834542235?=
X-GMAIL-MSGID: =?utf-8?q?1592481721834542235?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


Commit 3a0a397ff5ff upstream.

Now that we've standardised on SMCCC v1.1 to perform the branch
prediction invalidation, let's drop the previous band-aid.
If vendors haven't updated their firmware to do SMCCC 1.1, they
haven't updated PSCI either, so we don't loose anything.

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/bpi.S        |   24 ---------------------
 arch/arm64/kernel/cpu_errata.c |   45 +++++++++++------------------------------
 arch/arm64/kvm/hyp/switch.c    |   14 ------------
 3 files changed, 13 insertions(+), 70 deletions(-)

--- a/arch/arm64/kernel/bpi.S
+++ b/arch/arm64/kernel/bpi.S
@@ -54,30 +54,6 @@ ENTRY(__bp_harden_hyp_vecs_start)
 	vectors __kvm_hyp_vector
 	.endr
 ENTRY(__bp_harden_hyp_vecs_end)
-ENTRY(__psci_hyp_bp_inval_start)
-	sub	sp, sp, #(8 * 18)
-	stp	x16, x17, [sp, #(16 * 0)]
-	stp	x14, x15, [sp, #(16 * 1)]
-	stp	x12, x13, [sp, #(16 * 2)]
-	stp	x10, x11, [sp, #(16 * 3)]
-	stp	x8, x9, [sp, #(16 * 4)]
-	stp	x6, x7, [sp, #(16 * 5)]
-	stp	x4, x5, [sp, #(16 * 6)]
-	stp	x2, x3, [sp, #(16 * 7)]
-	stp	x0, x1, [sp, #(16 * 8)]
-	mov	x0, #0x84000000
-	smc	#0
-	ldp	x16, x17, [sp, #(16 * 0)]
-	ldp	x14, x15, [sp, #(16 * 1)]
-	ldp	x12, x13, [sp, #(16 * 2)]
-	ldp	x10, x11, [sp, #(16 * 3)]
-	ldp	x8, x9, [sp, #(16 * 4)]
-	ldp	x6, x7, [sp, #(16 * 5)]
-	ldp	x4, x5, [sp, #(16 * 6)]
-	ldp	x2, x3, [sp, #(16 * 7)]
-	ldp	x0, x1, [sp, #(16 * 8)]
-	add	sp, sp, #(8 * 18)
-ENTRY(__psci_hyp_bp_inval_end)
 
 ENTRY(__qcom_hyp_sanitize_link_stack_start)
 	stp     x29, x30, [sp, #-16]!
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -67,7 +67,6 @@ static int cpu_enable_trap_ctr_access(vo
 DEFINE_PER_CPU_READ_MOSTLY(struct bp_hardening_data, bp_hardening_data);
 
 #ifdef CONFIG_KVM
-extern char __psci_hyp_bp_inval_start[], __psci_hyp_bp_inval_end[];
 extern char __qcom_hyp_sanitize_link_stack_start[];
 extern char __qcom_hyp_sanitize_link_stack_end[];
 extern char __smccc_workaround_1_smc_start[];
@@ -116,8 +115,6 @@ static void __install_bp_hardening_cb(bp
 	spin_unlock(&bp_lock);
 }
 #else
-#define __psci_hyp_bp_inval_start		NULL
-#define __psci_hyp_bp_inval_end			NULL
 #define __qcom_hyp_sanitize_link_stack_start	NULL
 #define __qcom_hyp_sanitize_link_stack_end	NULL
 #define __smccc_workaround_1_smc_start		NULL
@@ -164,24 +161,25 @@ static void call_hvc_arch_workaround_1(v
 	arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
 }
 
-static bool check_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
+static int enable_smccc_arch_workaround_1(void *data)
 {
+	const struct arm64_cpu_capabilities *entry = data;
 	bp_hardening_cb_t cb;
 	void *smccc_start, *smccc_end;
 	struct arm_smccc_res res;
 
 	if (!entry->matches(entry, SCOPE_LOCAL_CPU))
-		return false;
+		return 0;
 
 	if (psci_ops.smccc_version == SMCCC_VERSION_1_0)
-		return false;
+		return 0;
 
 	switch (psci_ops.conduit) {
 	case PSCI_CONDUIT_HVC:
 		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
 		if (res.a0)
-			return false;
+			return 0;
 		cb = call_hvc_arch_workaround_1;
 		smccc_start = __smccc_workaround_1_hvc_start;
 		smccc_end = __smccc_workaround_1_hvc_end;
@@ -191,35 +189,18 @@ static bool check_smccc_arch_workaround_
 		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
 		if (res.a0)
-			return false;
+			return 0;
 		cb = call_smc_arch_workaround_1;
 		smccc_start = __smccc_workaround_1_smc_start;
 		smccc_end = __smccc_workaround_1_smc_end;
 		break;
 
 	default:
-		return false;
+		return 0;
 	}
 
 	install_bp_hardening_cb(entry, cb, smccc_start, smccc_end);
 
-	return true;
-}
-
-static int enable_psci_bp_hardening(void *data)
-{
-	const struct arm64_cpu_capabilities *entry = data;
-
-	if (psci_ops.get_version) {
-		if (check_smccc_arch_workaround_1(entry))
-			return 0;
-
-		install_bp_hardening_cb(entry,
-				       (bp_hardening_cb_t)psci_ops.get_version,
-				       __psci_hyp_bp_inval_start,
-				       __psci_hyp_bp_inval_end);
-	}
-
 	return 0;
 }
 
@@ -399,22 +380,22 @@ const struct arm64_cpu_capabilities arm6
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
-		.enable = enable_psci_bp_hardening,
+		.enable = enable_smccc_arch_workaround_1,
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
-		.enable = enable_psci_bp_hardening,
+		.enable = enable_smccc_arch_workaround_1,
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
-		.enable = enable_psci_bp_hardening,
+		.enable = enable_smccc_arch_workaround_1,
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
-		.enable = enable_psci_bp_hardening,
+		.enable = enable_smccc_arch_workaround_1,
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
@@ -428,12 +409,12 @@ const struct arm64_cpu_capabilities arm6
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
 		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
-		.enable = enable_psci_bp_hardening,
+		.enable = enable_smccc_arch_workaround_1,
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
 		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
-		.enable = enable_psci_bp_hardening,
+		.enable = enable_smccc_arch_workaround_1,
 	},
 #endif
 	{
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -325,20 +325,6 @@ again:
 	if (exit_code == ARM_EXCEPTION_TRAP && !__populate_fault_info(vcpu))
 		goto again;
 
-	if (exit_code == ARM_EXCEPTION_TRAP &&
-	    (kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_HVC64 ||
-	     kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_HVC32)) {
-		u32 val = vcpu_get_reg(vcpu, 0);
-
-		if (val == PSCI_0_2_FN_PSCI_VERSION) {
-			val = kvm_psci_version(vcpu, kern_hyp_va(vcpu->kvm));
-			if (unlikely(val == KVM_ARM_PSCI_0_1))
-				val = PSCI_RET_NOT_SUPPORTED;
-			vcpu_set_reg(vcpu, 0, val);
-			goto again;
-		}
-	}
-
 	if (static_branch_unlikely(&vgic_v2_cpuif_trap) &&
 	    exit_code == ARM_EXCEPTION_TRAP) {
 		bool valid;
