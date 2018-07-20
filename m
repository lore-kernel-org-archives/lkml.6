Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AA6ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F18206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F18206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389391AbeGTN0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:26:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46260 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388443AbeGTN0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:26:09 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 926D0C8A;
        Fri, 20 Jul 2018 12:35:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.14 91/92] arm64: KVM: Add ARCH_WORKAROUND_2 discovery through ARCH_FEATURES_FUNC_ID
Date:   Fri, 20 Jul 2018 14:14:35 +0200
Message-Id: <20180720121422.904134662@linuxfoundation.org>
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

commit 5d81f7dc9bca4f4963092433e27b508cbe524a32 upstream.

Now that all our infrastructure is in place, let's expose the
availability of ARCH_WORKAROUND_2 to guests. We take this opportunity
to tidy up a couple of SMCCC constants.

Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/kvm_host.h   |   12 ++++++++++++
 arch/arm64/include/asm/kvm_host.h |   23 +++++++++++++++++++++++
 arch/arm64/kvm/reset.c            |    4 ++++
 virt/kvm/arm/psci.c               |   18 ++++++++++++++++--
 4 files changed, 55 insertions(+), 2 deletions(-)

--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -302,4 +302,16 @@ static inline bool kvm_arm_harden_branch
 	return false;
 }
 
+#define KVM_SSBD_UNKNOWN		-1
+#define KVM_SSBD_FORCE_DISABLE		0
+#define KVM_SSBD_KERNEL		1
+#define KVM_SSBD_FORCE_ENABLE		2
+#define KVM_SSBD_MITIGATED		3
+
+static inline int kvm_arm_have_ssbd(void)
+{
+	/* No way to detect it yet, pretend it is not there. */
+	return KVM_SSBD_UNKNOWN;
+}
+
 #endif /* __ARM_KVM_HOST_H__ */
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -412,4 +412,27 @@ static inline bool kvm_arm_harden_branch
 	return cpus_have_const_cap(ARM64_HARDEN_BRANCH_PREDICTOR);
 }
 
+#define KVM_SSBD_UNKNOWN		-1
+#define KVM_SSBD_FORCE_DISABLE		0
+#define KVM_SSBD_KERNEL		1
+#define KVM_SSBD_FORCE_ENABLE		2
+#define KVM_SSBD_MITIGATED		3
+
+static inline int kvm_arm_have_ssbd(void)
+{
+	switch (arm64_get_ssbd_state()) {
+	case ARM64_SSBD_FORCE_DISABLE:
+		return KVM_SSBD_FORCE_DISABLE;
+	case ARM64_SSBD_KERNEL:
+		return KVM_SSBD_KERNEL;
+	case ARM64_SSBD_FORCE_ENABLE:
+		return KVM_SSBD_FORCE_ENABLE;
+	case ARM64_SSBD_MITIGATED:
+		return KVM_SSBD_MITIGATED;
+	case ARM64_SSBD_UNKNOWN:
+	default:
+		return KVM_SSBD_UNKNOWN;
+	}
+}
+
 #endif /* __ARM64_KVM_HOST_H__ */
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -122,6 +122,10 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu
 	/* Reset PMU */
 	kvm_pmu_vcpu_reset(vcpu);
 
+	/* Default workaround setup is enabled (if supported) */
+	if (kvm_arm_have_ssbd() == KVM_SSBD_KERNEL)
+		vcpu->arch.workaround_flags |= VCPU_WORKAROUND_2_FLAG;
+
 	/* Reset timer */
 	return kvm_timer_vcpu_reset(vcpu);
 }
--- a/virt/kvm/arm/psci.c
+++ b/virt/kvm/arm/psci.c
@@ -405,7 +405,7 @@ static int kvm_psci_call(struct kvm_vcpu
 int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 {
 	u32 func_id = smccc_get_function(vcpu);
-	u32 val = PSCI_RET_NOT_SUPPORTED;
+	u32 val = SMCCC_RET_NOT_SUPPORTED;
 	u32 feature;
 
 	switch (func_id) {
@@ -417,7 +417,21 @@ int kvm_hvc_call_handler(struct kvm_vcpu
 		switch(feature) {
 		case ARM_SMCCC_ARCH_WORKAROUND_1:
 			if (kvm_arm_harden_branch_predictor())
-				val = 0;
+				val = SMCCC_RET_SUCCESS;
+			break;
+		case ARM_SMCCC_ARCH_WORKAROUND_2:
+			switch (kvm_arm_have_ssbd()) {
+			case KVM_SSBD_FORCE_DISABLE:
+			case KVM_SSBD_UNKNOWN:
+				break;
+			case KVM_SSBD_KERNEL:
+				val = SMCCC_RET_SUCCESS;
+				break;
+			case KVM_SSBD_FORCE_ENABLE:
+			case KVM_SSBD_MITIGATED:
+				val = SMCCC_RET_NOT_REQUIRED;
+				break;
+			}
 			break;
 		}
 		break;


