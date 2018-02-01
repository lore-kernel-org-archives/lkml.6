Return-Path: <prvs=5630c6a94=karahmed@amazon.com>
X-Google-Smtp-Source: AH8x227j4pJ/i4rLlXFk0pxzlLq6DzU2dFfp7N18oGWrA4+El4pLqei1aQv6jj7WDa4Ocryg3uSE
ARC-Seal: i=1; a=rsa-sha256; t=1517522413; cv=none;
        d=google.com; s=arc-20160816;
        b=0RpuYEF9J3U87RmiiFRyZQcdo3jxRkcUbUHifXdqpT2AVszeiUCvMIYwF5R9z6szYT
         I+kvNRRkQrHO65IkJMZJ3h0kcomCeMiXjoRUO3j5o06LmmnksLLtlCuAZ1MrAnM1hRiQ
         XRWXClgb1/x5cuYjVE6U9cjP7O10y3qFbnuyD9kUACBXtIW7AnMKH3xH7zkPYTrc5ZAc
         yXzQUC+NNTS6H712sN0b2Q1NaKCN1LGoT5MRjpYFA4iZQx+cHmvjrYVEEVuUA94hd8nP
         /jGlkaf5rMERWfJ9lwfNjIcME4JTnBZrVXMGfBaY16YPMW/WztUN4X4EyCHmAZR8l2OX
         TYJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=rr3xxiqWxK3fY39F8ntKIhgel65VP5z4GgXsRxCa6Uc=;
        b=i5z8K3T6Q2+aTff2zdHvQQpEL+HSxQ89u8CIqHLyZRAAR0tvZMB7xjhGchYHsze5Ut
         HOomHZnXEh50IQ3qSrtp+z7VLk4LzmU/+aBqcQcMkG/b94tzUgGi91JPVFNw5noup7Om
         EmencGDPjwSnvB8Sj2jBaHo0+a5Zfdsti/B+7ncX0lGAaPRrZECiFcz9G/7kyBnwCvSR
         oiCd+sJpb9jy9wIgKkv3UGL1c6pWfSRuBuCkmYKTK2DxratrTus5pklO0AB1P1gOx1JJ
         TzMvtLuBfSbMGzV7N0V2djx0kxbgHN7TklQP9mVjEDiuoCUV6sAYYPzw7aMWJrivQU5t
         Aprg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amazon.de header.s=amazon201209 header.b=AdAqC73I;
       spf=pass (google.com: domain of prvs=5630c6a94=karahmed@amazon.com designates 52.95.49.90 as permitted sender) smtp.mailfrom=prvs=5630c6a94=karahmed@amazon.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.de
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amazon.de header.s=amazon201209 header.b=AdAqC73I;
       spf=pass (google.com: domain of prvs=5630c6a94=karahmed@amazon.com designates 52.95.49.90 as permitted sender) smtp.mailfrom=prvs=5630c6a94=karahmed@amazon.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.de
X-IronPort-AV: E=Sophos;i="5.46,444,1511827200";
   d="scan'208";a="330213004"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Ashok Raj <ashok.raj@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v6 3/5] KVM: VMX: Emulate MSR_IA32_ARCH_CAPABILITIES
Date: Thu,  1 Feb 2018 22:59:44 +0100
Message-Id: <1517522386-18410-4-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517522386-18410-1-git-send-email-karahmed@amazon.de>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237582262223506?=
X-GMAIL-MSGID: =?utf-8?q?1591237582262223506?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Intel processors use MSR_IA32_ARCH_CAPABILITIES MSR to indicate RDCL_NO
(bit 0) and IBRS_ALL (bit 1). This is a read-only MSR. By default the
contents will come directly from the hardware, but user-space can still
override it.

[dwmw2: The bit in kvm_cpuid_7_0_edx_x86_features can be unconditional]

Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jun Nakajima <jun.nakajima@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/cpuid.c |  2 +-
 arch/x86/kvm/vmx.c   | 15 +++++++++++++++
 arch/x86/kvm/x86.c   |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 033004d..1909635 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -394,7 +394,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 
 	/* cpuid 7.0.edx*/
 	const u32 kvm_cpuid_7_0_edx_x86_features =
-		F(AVX512_4VNNIW) | F(AVX512_4FMAPS);
+		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(ARCH_CAPABILITIES);
 
 	/* all calls to cpuid_count() should be made on the same cpu */
 	get_cpu();
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 263eb1f..b13314a 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -593,6 +593,8 @@ struct vcpu_vmx {
 	u64 		      msr_guest_kernel_gs_base;
 #endif
 
+	u64 		      arch_capabilities;
+
 	u32 vm_entry_controls_shadow;
 	u32 vm_exit_controls_shadow;
 	u32 secondary_exec_control;
@@ -3262,6 +3264,12 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_TSC:
 		msr_info->data = guest_read_tsc(vcpu);
 		break;
+	case MSR_IA32_ARCH_CAPABILITIES:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_ARCH_CAPABILITIES))
+			return 1;
+		msr_info->data = to_vmx(vcpu)->arch_capabilities;
+		break;
 	case MSR_IA32_SYSENTER_CS:
 		msr_info->data = vmcs_read32(GUEST_SYSENTER_CS);
 		break;
@@ -3397,6 +3405,11 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		vmx_disable_intercept_for_msr(vmx->vmcs01.msr_bitmap, MSR_IA32_PRED_CMD,
 					      MSR_TYPE_W);
 		break;
+	case MSR_IA32_ARCH_CAPABILITIES:
+		if (!msr_info->host_initiated)
+			return 1;
+		vmx->arch_capabilities = data;
+		break;
 	case MSR_IA32_CR_PAT:
 		if (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PAT) {
 			if (!kvm_mtrr_valid(vcpu, MSR_IA32_CR_PAT, data))
@@ -5659,6 +5672,8 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
 		++vmx->nmsrs;
 	}
 
+	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
+		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, vmx->arch_capabilities);
 
 	vm_exit_controls_init(vmx, vmcs_config.vmexit_ctrl);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c53298d..4ec142e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1009,6 +1009,7 @@ static u32 msrs_to_save[] = {
 #endif
 	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
 	MSR_IA32_FEATURE_CONTROL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
+	MSR_IA32_ARCH_CAPABILITIES
 };
 
 static unsigned num_msrs_to_save;
-- 
2.7.4
