Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2248mbJo48xMyoTNeUxMOJqoC9lkg5qj2yGfOvPVzYkPglc2muBKrsOD9wvt7DJkuHx2MwV5
ARC-Seal: i=1; a=rsa-sha256; t=1518708799; cv=none;
        d=google.com; s=arc-20160816;
        b=gZGuUK0NfiLA/OHS/XDgObN3PIhO1ZpwJhvEJSD++sYXrB7vnHvcDdJorgS2APDcRm
         mj+sLeZYuOQIvKBhHn8YYxWBzCsBlxA41LVFISSQFa07darKx4M5oq51u3jAcs0xHBdi
         cXPvCW2vFv9xPiT9G+np3h0Za1hFkSHVRzdIASsxY4HIiPyi4DIIRYb/P6yiJD0DSPAs
         h2p2w1Oq/yb1aVd5Nw8WVPX7+embuQjp0G3aUK3cNMpD/nuQ5LzuYKLalGa20gI20hz9
         rlsrEXtEuDZkIFQ97ZwL9dbm8bd3NajiqUbDyw44Nl+csQqk/iaIhiQdjvpXUWaHvv1Z
         4SuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3fEbLEkoNZCk5ujMyexC+Tb4AQSlEnzFjzeEBiT9zR4=;
        b=daXU5g5Ar4Gisb4qqqfpQbpH083c+9rY4CqTDeNJtk+Rp8lNNNTOIm4JWmJeahHYUf
         uQeCe61tDT4qVhsq8iqRZw4HDq2bexIC8wpWwQu9ueiRLrF7awrwIDLchCxZe1ERcpna
         1uIgUNUXJ3anX4Ya4I9/MaWNfAwylCDLjVzkf05IYT7jy58oA/qyjRMNbMwQU7nWsCen
         CC4S+RKoRDciQkGlkxSxLEs3avyPYex+DEkQGSmJUNDMJd9dj0Sfp0Raq6OwkXe52Kuv
         ml4wc5b4Hb5Ogz1sxkiXYbhSZ6FSPvVFxAGl1TAjN9EdiVvoMlYptklJsWwqo0jcUI1H
         4OLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christoffer Dall <christoffer.dall@linaro.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.14 083/195] [Variant 2/Spectre-v2] arm/arm64: KVM: Implement PSCI 1.0 support
Date: Thu, 15 Feb 2018 16:16:14 +0100
Message-Id: <20180215151709.855940567@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481598015215569?=
X-GMAIL-MSGID: =?utf-8?q?1592481598015215569?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


Commit 58e0b2239a4d upstream.

PSCI 1.0 can be trivially implemented by providing the FEATURES
call on top of PSCI 0.2 and returning 1.0 as the PSCI version.

We happily ignore everything else, as they are either optional or
are clarifications that do not require any additional change.

PSCI 1.0 is now the default until we decide to add a userspace
selection API.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/kvm/arm_psci.h |    3 +++
 virt/kvm/arm/psci.c    |   45 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

--- a/include/kvm/arm_psci.h
+++ b/include/kvm/arm_psci.h
@@ -22,6 +22,9 @@
 
 #define KVM_ARM_PSCI_0_1	PSCI_VERSION(0, 1)
 #define KVM_ARM_PSCI_0_2	PSCI_VERSION(0, 2)
+#define KVM_ARM_PSCI_1_0	PSCI_VERSION(1, 0)
+
+#define KVM_ARM_PSCI_LATEST	KVM_ARM_PSCI_1_0
 
 int kvm_psci_version(struct kvm_vcpu *vcpu);
 int kvm_psci_call(struct kvm_vcpu *vcpu);
--- a/virt/kvm/arm/psci.c
+++ b/virt/kvm/arm/psci.c
@@ -234,7 +234,7 @@ static void kvm_psci_system_reset(struct
 int kvm_psci_version(struct kvm_vcpu *vcpu)
 {
 	if (test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features))
-		return KVM_ARM_PSCI_0_2;
+		return KVM_ARM_PSCI_LATEST;
 
 	return KVM_ARM_PSCI_0_1;
 }
@@ -313,6 +313,47 @@ static int kvm_psci_0_2_call(struct kvm_
 	return ret;
 }
 
+static int kvm_psci_1_0_call(struct kvm_vcpu *vcpu)
+{
+	u32 psci_fn = smccc_get_function(vcpu);
+	u32 feature;
+	unsigned long val;
+	int ret = 1;
+
+	switch(psci_fn) {
+	case PSCI_0_2_FN_PSCI_VERSION:
+		val = KVM_ARM_PSCI_1_0;
+		break;
+	case PSCI_1_0_FN_PSCI_FEATURES:
+		feature = smccc_get_arg1(vcpu);
+		switch(feature) {
+		case PSCI_0_2_FN_PSCI_VERSION:
+		case PSCI_0_2_FN_CPU_SUSPEND:
+		case PSCI_0_2_FN64_CPU_SUSPEND:
+		case PSCI_0_2_FN_CPU_OFF:
+		case PSCI_0_2_FN_CPU_ON:
+		case PSCI_0_2_FN64_CPU_ON:
+		case PSCI_0_2_FN_AFFINITY_INFO:
+		case PSCI_0_2_FN64_AFFINITY_INFO:
+		case PSCI_0_2_FN_MIGRATE_INFO_TYPE:
+		case PSCI_0_2_FN_SYSTEM_OFF:
+		case PSCI_0_2_FN_SYSTEM_RESET:
+		case PSCI_1_0_FN_PSCI_FEATURES:
+			val = 0;
+			break;
+		default:
+			val = PSCI_RET_NOT_SUPPORTED;
+			break;
+		}
+		break;
+	default:
+		return kvm_psci_0_2_call(vcpu);
+	}
+
+	smccc_set_retval(vcpu, val, 0, 0, 0);
+	return ret;
+}
+
 static int kvm_psci_0_1_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
@@ -355,6 +396,8 @@ static int kvm_psci_0_1_call(struct kvm_
 int kvm_psci_call(struct kvm_vcpu *vcpu)
 {
 	switch (kvm_psci_version(vcpu)) {
+	case KVM_ARM_PSCI_1_0:
+		return kvm_psci_1_0_call(vcpu);
 	case KVM_ARM_PSCI_0_2:
 		return kvm_psci_0_2_call(vcpu);
 	case KVM_ARM_PSCI_0_1:
