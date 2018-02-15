Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224gxYi8HI1x7bS6jYnqmF6cX30w20c/eeQgE2l6zG6R63t0BmFW+AuEaVp6To2BTr+xmCjc
ARC-Seal: i=1; a=rsa-sha256; t=1518708796; cv=none;
        d=google.com; s=arc-20160816;
        b=wXrykcVADZBVc8sBXpHuc60mJ2X29+0v4MiCRrqySvp5t57Oxpc35Prhxq4+DhLwYQ
         WWAVdD7u+o76m6toO7XQX8hzzsoiuLMEp3vsW8mTKVUYWNa7uaYIrb/N7XoEsMHIPDb3
         GwkhqBuwdNeU9DJAlmgbzGAqyeNjoS3OdP/wJ00t7a3aeDuqzoaLjkQXJu7NvpELYckL
         hSgGKp8tPZ8vB299mmg4Eo1eaaxEOYGguTM+CfJU9lwcBEf6Gxm7AU14bwzeQ/c143fc
         kc0a80sxAe2Scbzhvj/cfOmmBuyOW3HaG+7XRUMUaD+ivZrOm4q+QWBvd4DHLqx26lYM
         kKvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=U60GRzeBg6JAEyUd27W40PPbbr9Crt8JbCZI1YtIjjA=;
        b=Dx1H93lPb6iKv1jD8WYHgwvdGcggtfiTHBiNA7RRVA1xuRz1eNRsdVCq8Qxhn4grpC
         fg/V5bQXJY5a/Nq+a2nCdmJxSpK+ARGH9CTHeipBqZOBPoal6sRWlKUSnZ+AJ0MIUK7x
         JK5SZb6XNmEcvWfAU/8qx+mtlYhGIDs50J+WTPKhQg7Qp0jk3F062CQffq35Lm6JBnTi
         XrkTLplOQm+mgUrb4qMc0Ra44Bop2s3YZY3fqm2/1unLZvyFU0Bj1ZdehTH5I7JLggmV
         r9TBRtMSkMexoqxtvfBWtBnb8Uf2lQk38AN2TviuObc0TgSUudt/mF9ZEG4PH43tRXRQ
         VNCA==
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
Subject: [PATCH 4.14 082/195] [Variant 2/Spectre-v2] arm/arm64: KVM: Add smccc accessors to PSCI code
Date: Thu, 15 Feb 2018 16:16:13 +0100
Message-Id: <20180215151709.790275706@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481594942560702?=
X-GMAIL-MSGID: =?utf-8?q?1592481594942560702?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


Commit 84684fecd7ea upstream.

Instead of open coding the accesses to the various registers,
let's add explicit SMCCC accessors.

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 virt/kvm/arm/psci.c |   52 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 10 deletions(-)

--- a/virt/kvm/arm/psci.c
+++ b/virt/kvm/arm/psci.c
@@ -32,6 +32,38 @@
 
 #define AFFINITY_MASK(level)	~((0x1UL << ((level) * MPIDR_LEVEL_BITS)) - 1)
 
+static u32 smccc_get_function(struct kvm_vcpu *vcpu)
+{
+	return vcpu_get_reg(vcpu, 0);
+}
+
+static unsigned long smccc_get_arg1(struct kvm_vcpu *vcpu)
+{
+	return vcpu_get_reg(vcpu, 1);
+}
+
+static unsigned long smccc_get_arg2(struct kvm_vcpu *vcpu)
+{
+	return vcpu_get_reg(vcpu, 2);
+}
+
+static unsigned long smccc_get_arg3(struct kvm_vcpu *vcpu)
+{
+	return vcpu_get_reg(vcpu, 3);
+}
+
+static void smccc_set_retval(struct kvm_vcpu *vcpu,
+			     unsigned long a0,
+			     unsigned long a1,
+			     unsigned long a2,
+			     unsigned long a3)
+{
+	vcpu_set_reg(vcpu, 0, a0);
+	vcpu_set_reg(vcpu, 1, a1);
+	vcpu_set_reg(vcpu, 2, a2);
+	vcpu_set_reg(vcpu, 3, a3);
+}
+
 static unsigned long psci_affinity_mask(unsigned long affinity_level)
 {
 	if (affinity_level <= 3)
@@ -77,7 +109,7 @@ static unsigned long kvm_psci_vcpu_on(st
 	unsigned long context_id;
 	phys_addr_t target_pc;
 
-	cpu_id = vcpu_get_reg(source_vcpu, 1) & MPIDR_HWID_BITMASK;
+	cpu_id = smccc_get_arg1(source_vcpu) & MPIDR_HWID_BITMASK;
 	if (vcpu_mode_is_32bit(source_vcpu))
 		cpu_id &= ~((u32) 0);
 
@@ -96,8 +128,8 @@ static unsigned long kvm_psci_vcpu_on(st
 			return PSCI_RET_INVALID_PARAMS;
 	}
 
-	target_pc = vcpu_get_reg(source_vcpu, 2);
-	context_id = vcpu_get_reg(source_vcpu, 3);
+	target_pc = smccc_get_arg2(source_vcpu);
+	context_id = smccc_get_arg3(source_vcpu);
 
 	kvm_reset_vcpu(vcpu);
 
@@ -116,7 +148,7 @@ static unsigned long kvm_psci_vcpu_on(st
 	 * NOTE: We always update r0 (or x0) because for PSCI v0.1
 	 * the general puspose registers are undefined upon CPU_ON.
 	 */
-	vcpu_set_reg(vcpu, 0, context_id);
+	smccc_set_retval(vcpu, context_id, 0, 0, 0);
 	vcpu->arch.power_off = false;
 	smp_mb();		/* Make sure the above is visible */
 
@@ -136,8 +168,8 @@ static unsigned long kvm_psci_vcpu_affin
 	struct kvm *kvm = vcpu->kvm;
 	struct kvm_vcpu *tmp;
 
-	target_affinity = vcpu_get_reg(vcpu, 1);
-	lowest_affinity_level = vcpu_get_reg(vcpu, 2);
+	target_affinity = smccc_get_arg1(vcpu);
+	lowest_affinity_level = smccc_get_arg2(vcpu);
 
 	/* Determine target affinity mask */
 	target_affinity_mask = psci_affinity_mask(lowest_affinity_level);
@@ -210,7 +242,7 @@ int kvm_psci_version(struct kvm_vcpu *vc
 static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
-	unsigned long psci_fn = vcpu_get_reg(vcpu, 0) & ~((u32) 0);
+	u32 psci_fn = smccc_get_function(vcpu);
 	unsigned long val;
 	int ret = 1;
 
@@ -277,14 +309,14 @@ static int kvm_psci_0_2_call(struct kvm_
 		break;
 	}
 
-	vcpu_set_reg(vcpu, 0, val);
+	smccc_set_retval(vcpu, val, 0, 0, 0);
 	return ret;
 }
 
 static int kvm_psci_0_1_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
-	unsigned long psci_fn = vcpu_get_reg(vcpu, 0) & ~((u32) 0);
+	u32 psci_fn = smccc_get_function(vcpu);
 	unsigned long val;
 
 	switch (psci_fn) {
@@ -302,7 +334,7 @@ static int kvm_psci_0_1_call(struct kvm_
 		break;
 	}
 
-	vcpu_set_reg(vcpu, 0, val);
+	smccc_set_retval(vcpu, val, 0, 0, 0);
 	return 1;
 }
 
