Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518709310-2-7624862098509103865
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518709309; b=LNz5vmAhxr63tmMEpky0ieMKATDmG7y8zFPEnGUdtO1zf5B
    s31k3v/udxb3g0hNeWVJmD3kDvg/BBMarCj9nDtVXfezU8OC+OWfdhGK5/rWsSL7
    nWruMHd8aCP7WZpxn2XrSGczkO4g+xcbineOz5MUSz6NU6ygiFU+yXdTJMePZ9Iu
    A8ubQ8srxdatclXT6rRMpCWSr7H16cZg/BRR5QefCBKXrbHQlTmfNxdaytiYA1fd
    Nq8tFAvMXNjvE89mxF958ey4dPtPifZsuSwo1upxAjKVuhj+fjs7Zu4THfd/0ZP5
    7+QqqzHzmO4MRY21+gwbuAUAXyXxHYY2eyPeXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518709309; bh=PY0kj7kARfxz43AooH+Ic45VIr
    AZiyGSYWV27uo1BZI=; b=JFTCMmcq9oZFeZJQd2m8DJMCoWWy2d7OYtSn14rgZp
    eZdjRQ1/KVsCEjsKJ/xFKUiBgjcdRGHO35TpdPiAq5RXbiDmEKoyvIUmtiuFyM/d
    wfBFLgTN0W/1p9n4iGUlEKUfIPQonoWA4CtNS3bu/26gp9P+G180iy2+1eF/snog
    F3J45dQsnghTw/hDJzRqgSYNapiWryXNKyR+VBlgsQoGj3WqagreAyCMjqEKqkip
    SH2sYeDHS86jOTIBd7GIRo5s7RvEbTSwSww5W/5eqwCD71E5HegMlkKuhuspGKCR
    NMw++2xSWwNe4F654uvppljmIO+A4tNWkap3vd0qdDtw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424014AbeBOPlq (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:41:46 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:32806 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423986AbeBOPlp (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:41:45 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 070/202] [Variant 2/Spectre-v2] arm64: Implement branch predictor hardening for Falkor
Date: Thu, 15 Feb 2018 16:16:10 +0100
Message-Id: <20180215151717.154641972@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -43,7 +43,8 @@
 #define ARM64_SVE				22
 #define ARM64_UNMAP_KERNEL_AT_EL0		23
 #define ARM64_HARDEN_BRANCH_PREDICTOR		24
+#define ARM64_HARDEN_BP_POST_GUEST_EXIT		25
 
-#define ARM64_NCAPS				25
+#define ARM64_NCAPS				26
 
 #endif /* __ASM_CPUCAPS_H */
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -68,6 +68,8 @@ extern u32 __kvm_get_mdcr_el2(void);
 
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
@@ -393,6 +393,14 @@ again:
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
