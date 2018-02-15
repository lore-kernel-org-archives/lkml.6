Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224CENakIwuwCJWAnR+LUfo6lC4YsKwM4oaKKFWUkcNl29zJH2icyt5NeQPmBJU83R6kisfU
ARC-Seal: i=1; a=rsa-sha256; t=1518709327; cv=none;
        d=google.com; s=arc-20160816;
        b=g82W2yPVd4EEV4MGx1o4PGX4Kg7daZJu177ea+CHwMEJUj6nZ7lnHQ77Zv+DBKrHBL
         SRygKpvVX38G06FspH3CyvcizDCvDeNKqlhy5p2fhoHHFhEpWNB3kUUQI268bSUiZgzp
         1U+rLgWLuWskdAF5LfPiCRxLlx/CCaun55D8LTeKY6VSVoYW8ERdidFzr+FxV69lsIsf
         wa/uKeJYm+gvaAZeuygVtXC4K0QFivby1Qt8o43472JlCFx7sOmgrGqZc2GgfaBcdjUn
         DCxuLyARekCMyTld8DZPPXC16KmKGOf7nklF63jRCx4nI8lJXsGy2JlW8+xqCF/D/1/d
         Kutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=K/HpEwUZe9LbwW2CsZ1rvchg9uVrSDKvTsWOf1BDpQ4=;
        b=upUVdQjXi3deA56zrTA5KJxjI4cma12x1wZALBlnpwoCon1Z15khZFfHoy25p5E0NW
         QeRH4/ktbSRd8DtAJhHmk0aTp+1Nirqr6sMqqJMqaFnMlVlpZFzS25MCfvgO0GTgtuLz
         sriWAHOTuEJWJOfROi053fv4TaBi1bbJrzudy2gm/JkYLiRkNCxhudrudd5ZpzID/Mm/
         f8aQmUg9l05YdD5KWfW6nc0WPwEL73YVNIjg9GufxunYjR1nrx93evw8QgWbh8um6W3L
         NoDx6OMdNXAGXr6N2KJWPOaf8wXaIgsTnGmg5MDL+6vu6GRG+IXoxoxWTZ6a+dqedcS2
         V/rQ==
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
Subject: [PATCH 4.15 077/202] [Variant 2/Spectre-v2] arm/arm64: KVM: Advertise SMCCC v1.1
Date: Thu, 15 Feb 2018 16:16:17 +0100
Message-Id: <20180215151717.515172036@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481601047585498?=
X-GMAIL-MSGID: =?utf-8?q?1592482151710464830?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


Commit 09e6be12effd upstream.

The new SMC Calling Convention (v1.1) allows for a reduced overhead
when calling into the firmware, and provides a new feature discovery
mechanism.

Make it visible to KVM guests.

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/kvm/handle_exit.c   |    2 +-
 arch/arm64/kvm/handle_exit.c |    2 +-
 include/kvm/arm_psci.h       |    2 +-
 include/linux/arm-smccc.h    |   13 +++++++++++++
 virt/kvm/arm/psci.c          |   24 +++++++++++++++++++++++-
 5 files changed, 39 insertions(+), 4 deletions(-)

--- a/arch/arm/kvm/handle_exit.c
+++ b/arch/arm/kvm/handle_exit.c
@@ -36,7 +36,7 @@ static int handle_hvc(struct kvm_vcpu *v
 		      kvm_vcpu_hvc_get_imm(vcpu));
 	vcpu->stat.hvc_exit_stat++;
 
-	ret = kvm_psci_call(vcpu);
+	ret = kvm_hvc_call_handler(vcpu);
 	if (ret < 0) {
 		kvm_inject_undefined(vcpu);
 		return 1;
--- a/arch/arm64/kvm/handle_exit.c
+++ b/arch/arm64/kvm/handle_exit.c
@@ -44,7 +44,7 @@ static int handle_hvc(struct kvm_vcpu *v
 			    kvm_vcpu_hvc_get_imm(vcpu));
 	vcpu->stat.hvc_exit_stat++;
 
-	ret = kvm_psci_call(vcpu);
+	ret = kvm_hvc_call_handler(vcpu);
 	if (ret < 0) {
 		vcpu_set_reg(vcpu, 0, ~0UL);
 		return 1;
--- a/include/kvm/arm_psci.h
+++ b/include/kvm/arm_psci.h
@@ -27,6 +27,6 @@
 #define KVM_ARM_PSCI_LATEST	KVM_ARM_PSCI_1_0
 
 int kvm_psci_version(struct kvm_vcpu *vcpu);
-int kvm_psci_call(struct kvm_vcpu *vcpu);
+int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
 
 #endif /* __KVM_ARM_PSCI_H__ */
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -60,6 +60,19 @@
 #define ARM_SMCCC_QUIRK_NONE		0
 #define ARM_SMCCC_QUIRK_QCOM_A6		1 /* Save/restore register a6 */
 
+#define ARM_SMCCC_VERSION_1_0		0x10000
+#define ARM_SMCCC_VERSION_1_1		0x10001
+
+#define ARM_SMCCC_VERSION_FUNC_ID					\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   0, 0)
+
+#define ARM_SMCCC_ARCH_FEATURES_FUNC_ID					\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   0, 1)
+
 #ifndef __ASSEMBLY__
 
 #include <linux/linkage.h>
--- a/virt/kvm/arm/psci.c
+++ b/virt/kvm/arm/psci.c
@@ -15,6 +15,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/preempt.h>
 #include <linux/kvm_host.h>
 #include <linux/wait.h>
@@ -339,6 +340,7 @@ static int kvm_psci_1_0_call(struct kvm_
 		case PSCI_0_2_FN_SYSTEM_OFF:
 		case PSCI_0_2_FN_SYSTEM_RESET:
 		case PSCI_1_0_FN_PSCI_FEATURES:
+		case ARM_SMCCC_VERSION_FUNC_ID:
 			val = 0;
 			break;
 		default:
@@ -393,7 +395,7 @@ static int kvm_psci_0_1_call(struct kvm_
  * Errors:
  * -EINVAL: Unrecognized PSCI function
  */
-int kvm_psci_call(struct kvm_vcpu *vcpu)
+static int kvm_psci_call(struct kvm_vcpu *vcpu)
 {
 	switch (kvm_psci_version(vcpu)) {
 	case KVM_ARM_PSCI_1_0:
@@ -406,3 +408,23 @@ int kvm_psci_call(struct kvm_vcpu *vcpu)
 		return -EINVAL;
 	};
 }
+
+int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
+{
+	u32 func_id = smccc_get_function(vcpu);
+	u32 val = PSCI_RET_NOT_SUPPORTED;
+
+	switch (func_id) {
+	case ARM_SMCCC_VERSION_FUNC_ID:
+		val = ARM_SMCCC_VERSION_1_1;
+		break;
+	case ARM_SMCCC_ARCH_FEATURES_FUNC_ID:
+		/* Nothing supported yet */
+		break;
+	default:
+		return kvm_psci_call(vcpu);
+	}
+
+	smccc_set_retval(vcpu, val, 0, 0, 0);
+	return 1;
+}
