Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227gUkGexSKHyfnAYciOBLrB7VmprpwxvuLz4+Hk8Wvlt4DXqLW9wPFhQeO0fttvyCBdWmh4
ARC-Seal: i=1; a=rsa-sha256; t=1518709333; cv=none;
        d=google.com; s=arc-20160816;
        b=ArU8nvn7MmErXBsbifbIo9L/kcuGmMdBOK673Lc78qy2DQ8HC2Lx0EBE+gxLiSFr/v
         Lyc/WPLkLpnhbnSYSLWQMOHY4PGpfrAipQrIvuxchwG4e3hQwBzDh05FBGpz2BEbnsY2
         H6vkpj8sNFiFXDEd2T+vTCzLXFXu2zRlopop2xSUwKggbj4VA83yhEYElu8Xgcrii0Vd
         +3YEVsHzOvi8Sh5K9a9M1YaGz8a5kLagmJDqGec4Gn2IyjsIoeGSiGNTxySdXYX9qRXZ
         PnuUVphr4LA28F3IWPMNXO2sskza33k6sDa4HnvJM000ayanIb9IDQsWskqdt7eDk4+l
         ESzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uS7JCfoMtvLLIyfp9f8UKczGOW5oaB45Mtdjpq9XAUE=;
        b=sR2TzJ7lSqICii/VkOKv35sC0u0bvGAdHGZyjpl6ae4jNMLXLwiFgM4POrs7kAM8z0
         1eCPbl8dxNdkQAs/b4cQn64/hdBzpj4Ye8nVuoIOdMY7qU9LvvCK94EOt+LP/dOrcjT3
         Cz3c9lQGJZiB6LpW56oZTUyEDrda+ozs896wdwkZI93VbJ6EXFtrcCON+PRdenxYWbr8
         6+cvOFHXeYzeaLiwjEn93q/MHW2C4Vn0i/LbXJmg1LfYqtYwECb9K9I6mI53GrsBB0yD
         B3Ug9wJuTV+DyLlp8dFLaW/FI6u4Qp79fE/Hc/7kOmJjpk0QyKv/oHIBclEMtYrXwSps
         wkiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Christoffer Dall <christoffer.dall@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.15 079/202] [Variant 2/Spectre-v2] arm/arm64: KVM: Turn kvm_psci_version into a static inline
Date: Thu, 15 Feb 2018 16:16:19 +0100
Message-Id: <20180215151717.605282124@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481728071968329?=
X-GMAIL-MSGID: =?utf-8?q?1592482157904162296?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


Commit a4097b351118 upstream.

We're about to need kvm_psci_version in HYP too. So let's turn it
into a static inline, and pass the kvm structure as a second
parameter (so that HYP can do a kern_hyp_va on it).

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/hyp/switch.c |   18 +++++++++++-------
 include/kvm/arm_psci.h      |   21 ++++++++++++++++++++-
 virt/kvm/arm/psci.c         |   12 ++----------
 3 files changed, 33 insertions(+), 18 deletions(-)

--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -19,6 +19,8 @@
 #include <linux/jump_label.h>
 #include <uapi/linux/psci.h>
 
+#include <kvm/arm_psci.h>
+
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_hyp.h>
@@ -344,14 +346,16 @@ again:
 
 	if (exit_code == ARM_EXCEPTION_TRAP &&
 	    (kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_HVC64 ||
-	     kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_HVC32) &&
-	    vcpu_get_reg(vcpu, 0) == PSCI_0_2_FN_PSCI_VERSION) {
-		u64 val = PSCI_RET_NOT_SUPPORTED;
-		if (test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features))
-			val = 2;
+	     kvm_vcpu_trap_get_class(vcpu) == ESR_ELx_EC_HVC32)) {
+		u32 val = vcpu_get_reg(vcpu, 0);
 
-		vcpu_set_reg(vcpu, 0, val);
-		goto again;
+		if (val == PSCI_0_2_FN_PSCI_VERSION) {
+			val = kvm_psci_version(vcpu, kern_hyp_va(vcpu->kvm));
+			if (unlikely(val == KVM_ARM_PSCI_0_1))
+				val = PSCI_RET_NOT_SUPPORTED;
+			vcpu_set_reg(vcpu, 0, val);
+			goto again;
+		}
 	}
 
 	if (static_branch_unlikely(&vgic_v2_cpuif_trap) &&
--- a/include/kvm/arm_psci.h
+++ b/include/kvm/arm_psci.h
@@ -18,6 +18,7 @@
 #ifndef __KVM_ARM_PSCI_H__
 #define __KVM_ARM_PSCI_H__
 
+#include <linux/kvm_host.h>
 #include <uapi/linux/psci.h>
 
 #define KVM_ARM_PSCI_0_1	PSCI_VERSION(0, 1)
@@ -26,7 +27,25 @@
 
 #define KVM_ARM_PSCI_LATEST	KVM_ARM_PSCI_1_0
 
-int kvm_psci_version(struct kvm_vcpu *vcpu);
+/*
+ * We need the KVM pointer independently from the vcpu as we can call
+ * this from HYP, and need to apply kern_hyp_va on it...
+ */
+static inline int kvm_psci_version(struct kvm_vcpu *vcpu, struct kvm *kvm)
+{
+	/*
+	 * Our PSCI implementation stays the same across versions from
+	 * v0.2 onward, only adding the few mandatory functions (such
+	 * as FEATURES with 1.0) that are required by newer
+	 * revisions. It is thus safe to return the latest.
+	 */
+	if (test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features))
+		return KVM_ARM_PSCI_LATEST;
+
+	return KVM_ARM_PSCI_0_1;
+}
+
+
 int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
 
 #endif /* __KVM_ARM_PSCI_H__ */
--- a/virt/kvm/arm/psci.c
+++ b/virt/kvm/arm/psci.c
@@ -123,7 +123,7 @@ static unsigned long kvm_psci_vcpu_on(st
 	if (!vcpu)
 		return PSCI_RET_INVALID_PARAMS;
 	if (!vcpu->arch.power_off) {
-		if (kvm_psci_version(source_vcpu) != KVM_ARM_PSCI_0_1)
+		if (kvm_psci_version(source_vcpu, kvm) != KVM_ARM_PSCI_0_1)
 			return PSCI_RET_ALREADY_ON;
 		else
 			return PSCI_RET_INVALID_PARAMS;
@@ -232,14 +232,6 @@ static void kvm_psci_system_reset(struct
 	kvm_prepare_system_event(vcpu, KVM_SYSTEM_EVENT_RESET);
 }
 
-int kvm_psci_version(struct kvm_vcpu *vcpu)
-{
-	if (test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features))
-		return KVM_ARM_PSCI_LATEST;
-
-	return KVM_ARM_PSCI_0_1;
-}
-
 static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
@@ -397,7 +389,7 @@ static int kvm_psci_0_1_call(struct kvm_
  */
 static int kvm_psci_call(struct kvm_vcpu *vcpu)
 {
-	switch (kvm_psci_version(vcpu)) {
+	switch (kvm_psci_version(vcpu, vcpu->kvm)) {
 	case KVM_ARM_PSCI_1_0:
 		return kvm_psci_1_0_call(vcpu);
 	case KVM_ARM_PSCI_0_2:
