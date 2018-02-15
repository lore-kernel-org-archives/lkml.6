Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224LpJlMNJtzbeaBJerMaI/BxVpHKwT4raFTDK1FrMzVV8DrES7+2JyqkE7wyZm+GpjVAiBQ
ARC-Seal: i=1; a=rsa-sha256; t=1518709336; cv=none;
        d=google.com; s=arc-20160816;
        b=T6gnd1twy5+L3/m9WCTsJFmiFOePfybNmGYHRof1CpAAD9Nq8vlrzyxIl/uZvHEhTM
         B9NAw2l9KvUxF9gZnVseCqfPfi5XownNanPn31KSvrNyv3JC92Zw/xVWqJqXOxcZyU2E
         AleVwaD57fHRQlDb6AenPf58PtaTH2NE6V8o2PuWCuyefXUwFVsU0Hy2XpPQohz+k7iX
         SnJav/t2OzwsiiHyAdQtB20xv0dQq4K21Ip34wniwwx5QUmoO6ZXPu0nK20owAE327Xb
         72OESXK0v+6zxFmWgXIXL40auv1Me7Rny7wankGz1AM+JxCMy7zeUNkBo1ornDP99b/D
         LinA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HNUb+XYfylSnW2iXsV0WdUZ864ramp40kUNrzGqzlM0=;
        b=XmW8eQ9zIFZyEdNyS2eX+5ivz5ZDnhNVKnqaW5C9Jk7XtX9VJouU5cEz5dEfstWxkq
         yIBW6K/hNGymLv835TJardDTiXPDqnAC/b0GWEh8kpPeALzKJPUOF3O0f9bNzJSuRtXb
         zYUY2fnK0fyO6Zg7iSpLZY4pVcD+eMZpafe34Pp5x3wCFQYJcZs7wFpq5QU2EFgxyi0z
         mTjIjGGqQDAkn/kby6PvBl4TSnJ8X0KyQzZN6NKEEUNO7ijKLGUItZfN0LlWOM+21+44
         H+Fr6iojJGMSG3SrcOO4hP5igP1bl9FfBzku2ObOFDd3Ng/GDC1Q1I6Fo8igV5HI8Vz+
         7e6w==
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
Subject: [PATCH 4.15 080/202] [Variant 2/Spectre-v2] arm64: KVM: Report SMCCC_ARCH_WORKAROUND_1 BP hardening support
Date: Thu, 15 Feb 2018 16:16:20 +0100
Message-Id: <20180215151717.656570345@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481626485437494?=
X-GMAIL-MSGID: =?utf-8?q?1592482161014682001?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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

Conflicts:
	arch/arm/include/asm/kvm_host.h
	arch/arm64/include/asm/kvm_host.h
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/kvm_host.h   |    6 ++++++
 arch/arm64/include/asm/kvm_host.h |    5 +++++
 include/linux/arm-smccc.h         |    5 +++++
 virt/kvm/arm/psci.c               |    9 ++++++++-
 4 files changed, 24 insertions(+), 1 deletion(-)

--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -301,4 +301,10 @@ int kvm_arm_vcpu_arch_has_attr(struct kv
 /* All host FP/SIMD state is restored on guest exit, so nothing to save: */
 static inline void kvm_fpsimd_flush_cpu_state(void) {}
 
+static inline bool kvm_arm_harden_branch_predictor(void)
+{
+	/* No way to detect it yet, pretend it is not there. */
+	return false;
+}
+
 #endif /* __ARM_KVM_HOST_H__ */
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -396,4 +396,9 @@ static inline void kvm_fpsimd_flush_cpu_
 		sve_flush_cpu_state();
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
