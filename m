Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227xovSubvAbQNIloaSOF5GEN/pssWnQGtyrjObItjXeJOYAsZ31POvSBuOHiChTxgiYT/vI
ARC-Seal: i=1; a=rsa-sha256; t=1518708826; cv=none;
        d=google.com; s=arc-20160816;
        b=zk3N/cg6otJOxWetu79J7WY9gdFx5ene0ASTNl1bZy2BDMzXCcJ1cuA3IlZ0ccWaPu
         O1WiqOlRf/yYYstCRv/9cAtxqJI8O1HKn0J6T/Xh9su5qZ0GwvLpkj3ujls0OPuP4KbH
         euzYl3WqhBqzdYB8VAyJGbs/dClEhJWbtfIXa1LgghzCFEQ47DrS9RtNB5WWr6hmDV/X
         2xlaICQpu3Qa0AYSlojmzGdgpWXs5HxGKNhtyTbM8vc2ofxlEwgZl5KHFVbjoSMKNPUt
         kzxL86OorP230WkVHzBVZxLSkUAFkGe02c/Jx4cYuc8Hbq+XFxcyVZLNV8m+O+c2Ksy7
         CLHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=G6EJt0qy/a07IGxYhLMMsISxga/OXqYcpgLHlxmFt2U=;
        b=FE6uCMntgFDbLlfhcLz9BB9ngzOA7rc1w/xoyNVx5QdVeWmCAB9W0XCdZLxYr2HOtd
         bH/gkv88zqWR7q8NqdNdfbEr9O3h4/JPgzDMsAA56noXYIchrVHV3SnqbXtYLr6n3bfx
         12/+I2P7ebhCkzofJ9bgQ4sIrd632H2W5mgmkrPuqAoA65bCyzC8D6QutbZfSJhXQzxQ
         /RP7PqyS7xCm5pcaH5wgODpB6Z9uX+7IdMmDTE1WvA6V1u6lMJcYHw4dI+Y4I+/zlLCI
         Jk+Mu2tZrZ4ZS2GwdJibvMVCGzGd9oQGQonpYvSG4KPgKhsvTloeqItmC3ZiHV+ho0YH
         RhUw==
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
Subject: [PATCH 4.14 087/195] [Variant 2/Spectre-v2] arm64: KVM: Report SMCCC_ARCH_WORKAROUND_1 BP hardening support
Date: Thu, 15 Feb 2018 16:16:18 +0100
Message-Id: <20180215151710.061008529@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481626485437494?=
X-GMAIL-MSGID: =?utf-8?q?1592481626485437494?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>


Commit 6167ec5c9145 upstream.

A new feature of SMCCC 1.1 is that it offers firmware-based CPU
workarounds. In particular, SMCCC_ARCH_WORKAROUND_1 provides
BP hardening for CVE-2017-5715.

If the host has some mitigation for this issue, report that
we deal with it using SMCCC_ARCH_WORKAROUND_1, as we apply the
host workaround on every guest exit.

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/kvm_host.h   |    6 ++++++
 arch/arm64/include/asm/kvm_host.h |    5 +++++
 include/linux/arm-smccc.h         |    5 +++++
 virt/kvm/arm/psci.c               |    9 ++++++++-
 4 files changed, 24 insertions(+), 1 deletion(-)

--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -293,4 +293,10 @@ int kvm_arm_vcpu_arch_get_attr(struct kv
 int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
 			       struct kvm_device_attr *attr);
 
+static inline bool kvm_arm_harden_branch_predictor(void)
+{
+	/* No way to detect it yet, pretend it is not there. */
+	return false;
+}
+
 #endif /* __ARM_KVM_HOST_H__ */
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -384,4 +384,9 @@ static inline void __cpu_init_stage2(voi
 		  "PARange is %d bits, unsupported configuration!", parange);
 }
 
+static inline bool kvm_arm_harden_branch_predictor(void)
+{
+	return cpus_have_const_cap(ARM64_HARDEN_BRANCH_PREDICTOR);
+}
+
 #endif /* __ARM64_KVM_HOST_H__ */
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -73,6 +73,11 @@
 			   ARM_SMCCC_SMC_32,				\
 			   0, 1)
 
+#define ARM_SMCCC_ARCH_WORKAROUND_1					\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
+			   ARM_SMCCC_SMC_32,				\
+			   0, 0x8000)
+
 #ifndef __ASSEMBLY__
 
 #include <linux/linkage.h>
--- a/virt/kvm/arm/psci.c
+++ b/virt/kvm/arm/psci.c
@@ -405,13 +405,20 @@ int kvm_hvc_call_handler(struct kvm_vcpu
 {
 	u32 func_id = smccc_get_function(vcpu);
 	u32 val = PSCI_RET_NOT_SUPPORTED;
+	u32 feature;
 
 	switch (func_id) {
 	case ARM_SMCCC_VERSION_FUNC_ID:
 		val = ARM_SMCCC_VERSION_1_1;
 		break;
 	case ARM_SMCCC_ARCH_FEATURES_FUNC_ID:
-		/* Nothing supported yet */
+		feature = smccc_get_arg1(vcpu);
+		switch(feature) {
+		case ARM_SMCCC_ARCH_WORKAROUND_1:
+			if (kvm_arm_harden_branch_predictor())
+				val = 0;
+			break;
+		}
 		break;
 	default:
 		return kvm_psci_call(vcpu);
