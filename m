Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224bWqDv2QD+Th1WVOhVUoIjES1bjN8VvIRWhboSAaHbgQcuR9bAO4Y9ccHp/Thm14D3g9q8
ARC-Seal: i=1; a=rsa-sha256; t=1518708782; cv=none;
        d=google.com; s=arc-20160816;
        b=ZZTozs39F9pGQt86+AB3D+mU1Axnv4+chRjBlA0iIHybaUynhqvfpn66Qczm0AgmZh
         eR8ufZfPJMMOZjHW+f5t1FqX9uxfn4M2ki5p0T6FYWFP0SAiLTQ0WZ8a5D7PrprMPsIw
         Fr6KaZOWUa8Y2Q3EZAYAMivBdajA3dVOMf3pITX4+fxC7+lqYc14ZT6dAwI5J4vbv6cu
         KJYgbF6B1QMnm+5yi1c7S7w+2eHwn/lnE3yug3f/1c5xyAaEOvMvuX4PZkjkmPBFpyn/
         aCT9eMaKP6l4emMgCkBYksahfGaPZmcdDxz5raMZFn9wlQoQLsy1lwfipe+i1rBc2H95
         Oufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0trI2IWoNi3zJ44g+WK+LucjakrcmP38MsAPumLgPcc=;
        b=V2oL5G6XeYC3OfznrpQUe8jD8gM7P5F57DtjOrpAoQHC2PLgQHjo7Q4qx2NHHKHWqa
         hQ5DruN3MzQdQzYbj03Q4dChIkMCnQSt+ct2tdRLn2MMYXlklcK/cK+rl/VyBdwp/VWk
         CwzshhltvIPSLMXfTjjNqcr/8PcBv8c3KEkSlkpJMfCVFEDFzjZSjph0IwgCgEu9gKHs
         Kd/rAbGmOd2b07zc2jJRyr0fSpXehsmiiabHHHIwcqt5H/eiisII5/7Knkc7Enh46wXQ
         wKzmnmjtoTiFpo949ZT5lPxUIuW4bVN1GV1MnP3Ds2qP2CQyLc6TqKgwWaLd/AhcWrfN
         z8Vg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 077/195] [Variant 2/Spectre-v2] arm64: Implement branch predictor hardening for Falkor
Date: Thu, 15 Feb 2018 16:16:08 +0100
Message-Id: <20180215151709.547558855@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481579919117026?=
X-GMAIL-MSGID: =?utf-8?q?1592481579919117026?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shanker Donthineni <shankerd@codeaurora.org>


Commit ec82b567a74f upstream.

Falkor is susceptible to branch predictor aliasing and can
theoretically be attacked by malicious code. This patch
implements a mitigation for these attacks, preventing any
malicious entries from affecting other victim contexts.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
[will: fix label name when !CONFIG_KVM and remove references to MIDR_FALKOR]
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/cpucaps.h |    3 +-
 arch/arm64/include/asm/kvm_asm.h |    2 +
 arch/arm64/kernel/bpi.S          |    8 +++++++
 arch/arm64/kernel/cpu_errata.c   |   40 +++++++++++++++++++++++++++++++++++++--
 arch/arm64/kvm/hyp/entry.S       |   12 +++++++++++
 arch/arm64/kvm/hyp/switch.c      |    8 +++++++
 6 files changed, 70 insertions(+), 3 deletions(-)

--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -42,7 +42,8 @@
 #define ARM64_HAS_DCPOP				21
 #define ARM64_UNMAP_KERNEL_AT_EL0		23
 #define ARM64_HARDEN_BRANCH_PREDICTOR		24
+#define ARM64_HARDEN_BP_POST_GUEST_EXIT		25
 
-#define ARM64_NCAPS				25
+#define ARM64_NCAPS				26
 
 #endif /* __ASM_CPUCAPS_H */
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -66,6 +66,8 @@ extern u32 __kvm_get_mdcr_el2(void);
 
 extern u32 __init_stage2_translation(void);
 
+extern void __qcom_hyp_sanitize_btac_predictors(void);
+
 #endif
 
 #endif /* __ARM_KVM_ASM_H__ */
--- a/arch/arm64/kernel/bpi.S
+++ b/arch/arm64/kernel/bpi.S
@@ -77,3 +77,11 @@ ENTRY(__psci_hyp_bp_inval_start)
 	ldp	x0, x1, [sp, #(16 * 8)]
 	add	sp, sp, #(8 * 18)
 ENTRY(__psci_hyp_bp_inval_end)
+
+ENTRY(__qcom_hyp_sanitize_link_stack_start)
+	stp     x29, x30, [sp, #-16]!
+	.rept	16
+	bl	. + 4
+	.endr
+	ldp	x29, x30, [sp], #16
+ENTRY(__qcom_hyp_sanitize_link_stack_end)
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -68,6 +68,8 @@ DEFINE_PER_CPU_READ_MOSTLY(struct bp_har
 
 #ifdef CONFIG_KVM
 extern char __psci_hyp_bp_inval_start[], __psci_hyp_bp_inval_end[];
+extern char __qcom_hyp_sanitize_link_stack_start[];
+extern char __qcom_hyp_sanitize_link_stack_end[];
 
 static void __copy_hyp_vect_bpi(int slot, const char *hyp_vecs_start,
 				const char *hyp_vecs_end)
@@ -110,8 +112,10 @@ static void __install_bp_hardening_cb(bp
 	spin_unlock(&bp_lock);
 }
 #else
-#define __psci_hyp_bp_inval_start	NULL
-#define __psci_hyp_bp_inval_end		NULL
+#define __psci_hyp_bp_inval_start		NULL
+#define __psci_hyp_bp_inval_end			NULL
+#define __qcom_hyp_sanitize_link_stack_start	NULL
+#define __qcom_hyp_sanitize_link_stack_end	NULL
 
 static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
 				      const char *hyp_vecs_start,
@@ -152,6 +156,29 @@ static int enable_psci_bp_hardening(void
 
 	return 0;
 }
+
+static void qcom_link_stack_sanitization(void)
+{
+	u64 tmp;
+
+	asm volatile("mov	%0, x30		\n"
+		     ".rept	16		\n"
+		     "bl	. + 4		\n"
+		     ".endr			\n"
+		     "mov	x30, %0		\n"
+		     : "=&r" (tmp));
+}
+
+static int qcom_enable_link_stack_sanitization(void *data)
+{
+	const struct arm64_cpu_capabilities *entry = data;
+
+	install_bp_hardening_cb(entry, qcom_link_stack_sanitization,
+				__qcom_hyp_sanitize_link_stack_start,
+				__qcom_hyp_sanitize_link_stack_end);
+
+	return 0;
+}
 #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
 
 #define MIDR_RANGE(model, min, max) \
@@ -323,6 +350,15 @@ const struct arm64_cpu_capabilities arm6
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
 		.enable = enable_psci_bp_hardening,
 	},
+	{
+		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
+		MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
+		.enable = qcom_enable_link_stack_sanitization,
+	},
+	{
+		.capability = ARM64_HARDEN_BP_POST_GUEST_EXIT,
+		MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
+	},
 #endif
 	{
 	}
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -196,3 +196,15 @@ alternative_endif
 
 	eret
 ENDPROC(__fpsimd_guest_restore)
+
+ENTRY(__qcom_hyp_sanitize_btac_predictors)
+	/**
+	 * Call SMC64 with Silicon provider serviceID 23<<8 (0xc2001700)
+	 * 0xC2000000-0xC200FFFF: assigned to SiP Service Calls
+	 * b15-b0: contains SiP functionID
+	 */
+	movz    x0, #0x1700
+	movk    x0, #0xc200, lsl #16
+	smc     #0
+	ret
+ENDPROC(__qcom_hyp_sanitize_btac_predictors)
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -364,6 +364,14 @@ again:
 		/* 0 falls through to be handled out of EL2 */
 	}
 
+	if (cpus_have_const_cap(ARM64_HARDEN_BP_POST_GUEST_EXIT)) {
+		u32 midr = read_cpuid_id();
+
+		/* Apply BTAC predictors mitigation to all Falkor chips */
+		if ((midr & MIDR_CPU_MODEL_MASK) == MIDR_QCOM_FALKOR_V1)
+			__qcom_hyp_sanitize_btac_predictors();
+	}
+
 	fp_enabled = __fpsimd_enabled();
 
 	__sysreg_save_guest_state(guest_ctxt);
