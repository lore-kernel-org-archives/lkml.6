Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+fx7IEh9BCCBxRee26fe2RSMTup84CCcYVT5p9MGlLhEJerjftOvh8IgWpYSNlMMzUJ7lV
ARC-Seal: i=1; a=rsa-sha256; t=1523981373; cv=none;
        d=google.com; s=arc-20160816;
        b=SCGjcnTxV/QqGEIrG8nhsgyzEI6Fj3Q8aqQDvZa+vx3HJ4U9CKTSyvYtV3KkSvqfnq
         gpYdLiIMXs7ypjYd8QMGlPoAvRBvyEsPd0Da6zZia74/CpV5pdnV8SBnfMCff4MbqQKd
         FeOBa2557niG2tJQgM8Oq78uORiN6X6IH7sVUAB0U4ykfEoaySXsrt37Y/0WZxHCWYEc
         nWwmlfHbaz0okr+pJw3ukknzWsl3j/olgByNxPf4+H6uIFLD1lZgwuhLHVPCZnnE4bj/
         mxdFXHiqn3WYRoU4fl0pLnK/RxyCvCpPgQfwZXMpeZAWSYPSmPKwcS7GaHxZPBZ2jP8Y
         kUjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8Mmf/6dXsb7yDm9Vdvlv82MhvceJnp6jA5unaTrvhmI=;
        b=IZv8upCJlfatiH2/Fe/gNTT8iBgci4XVjv2p3gibzczrOYdgijZe5gOQ8VCEHDL4DT
         vhNLnrO4Yup45jSINjEE8Sl0jnmWdvvqHg+ClsCZuU2/BaavFZdvlYgahzU+jqQeA4dm
         pZBzYx/xtTT9B/o3fvvQuq5G6KHZhTlIi08E1N/CV0/umK5pgNaxyndq5DDsOm1SflUj
         7xKeMX6x5VZqsVHS4+6sQITgEb6ON1LR7Wh31Twipw2OBBFdtgbsZ0Bgtxx4s66YD22C
         YT7JFP8lmPDPucNeaWrFaHgdQZqxqaxjhRIJQkvb12iJw3o/knAP42Nhlh2lpsLqU9mv
         tN9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Christoffer Dall <christoffer.dall@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 42/66] arm/arm64: KVM: Turn kvm_psci_version into a static inline
Date: Tue, 17 Apr 2018 17:59:15 +0200
Message-Id: <20180417155647.699709330@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010292748360385?=
X-GMAIL-MSGID: =?utf-8?q?1598010292748360385?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Marc Zyngier <marc.zyngier@arm.com>

commit a4097b351118e821841941a79ec77d3ce3f1c5d9 upstream.

We're about to need kvm_psci_version in HYP too. So let's turn it
into a static inline, and pass the kvm structure as a second
parameter (so that HYP can do a kern_hyp_va on it).

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[v4.9: account for files moved to virt/ upstream]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/kvm/psci.c         |   12 ++----------
 arch/arm64/kvm/hyp/switch.c |   18 +++++++++++-------
 include/kvm/arm_psci.h      |   21 ++++++++++++++++++++-
 3 files changed, 33 insertions(+), 18 deletions(-)

--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -120,7 +120,7 @@ static unsigned long kvm_psci_vcpu_on(st
 	if (!vcpu)
 		return PSCI_RET_INVALID_PARAMS;
 	if (!vcpu->arch.power_off) {
-		if (kvm_psci_version(source_vcpu) != KVM_ARM_PSCI_0_1)
+		if (kvm_psci_version(source_vcpu, kvm) != KVM_ARM_PSCI_0_1)
 			return PSCI_RET_ALREADY_ON;
 		else
 			return PSCI_RET_INVALID_PARAMS;
@@ -230,14 +230,6 @@ static void kvm_psci_system_reset(struct
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
@@ -395,7 +387,7 @@ static int kvm_psci_0_1_call(struct kvm_
  */
 static int kvm_psci_call(struct kvm_vcpu *vcpu)
 {
-	switch (kvm_psci_version(vcpu)) {
+	switch (kvm_psci_version(vcpu, vcpu->kvm)) {
 	case KVM_ARM_PSCI_1_0:
 		return kvm_psci_1_0_call(vcpu);
 	case KVM_ARM_PSCI_0_2:
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
@@ -311,14 +313,16 @@ again:
 
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
