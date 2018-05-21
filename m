Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpqc1XJ8QVF8jZc/3ilE837lvADJ01IxKL810cdzDdCHRPjiASIKKPmSeQQ+tnkNchQChLR
ARC-Seal: i=1; a=rsa-sha256; t=1526938011; cv=none;
        d=google.com; s=arc-20160816;
        b=N1stYoWB5SHxbdTSj48sE2xXZ2jdYR9LwzrbY7k8ro6NnyEw6cCR/dh0KoOKwiO8Mo
         aIrbGVWfzTcrDP/1zXDrubQRjUQVwAgq7SoMFA1p94TfDAz3a5iqT4fxBhyY2mZzvSBo
         vSlGXTWznOYiLRjcI1/LYWF2ESrlE4Jay9A0iBgRgrLsHm2nYxjBxVmRIctrAmY5bmkv
         vL7tDm93UnoVQ6t7EDResHm4WBmFLbG4IU+D82b4nvjpUNqmO1F7f+GMNLLMolf0A09+
         4fX3OpD+9YCPxlCA/2pVH5cxioOZ0uU894c6xrnoq1PETBD2ZCqDBr4orIyvKpKLzZ5K
         MJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=/bqyO57jCB4JhaMl9GpYvEoL/jiQpPCFdHpYlSgqnoE=;
        b=yRKI6JqPtRhEWUdX5lYynhWwe4qXRG1LXCh4GMkKaN6FSRorQYg9DdrfJg7dTodUUY
         g2nhj2XJ2amO2EJcGE4ZYUXByilywC35VOeoPkm6kdVKePGffvFIoNJmx28wshLqQwKI
         lZbtcOXbQ6l57alkgWUoNANbgTfuhzIDtan+IJB1pQ1yn3iK5p4DzzJ0jSrugfuphTgw
         Q5agXGYop7YfYx0BCORAdtgAvkKdAZuMudeuqRgPfnOz4Lrl32+3e9c0Ew8x0jrb/xqd
         iEo1Ehc3TobvbdUGq28l4qPu4blIkbFFzhRTmJHl/fir9J8cVAmE3gabmADgfpVtBXY7
         FCJg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=HiSuqo+s;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=HiSuqo+s;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.16 108/110] KVM: SVM: Implement VIRT_SPEC_CTRL support for SSBD
Date: Mon, 21 May 2018 23:12:45 +0200
Message-Id: <20180521210515.061159078@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109967439224188?=
X-GMAIL-MSGID: =?utf-8?q?1601110552244201410?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Lendacky <thomas.lendacky@amd.com>

commit bc226f07dcd3c9ef0b7f6236fe356ea4a9cb4769 upstream

Expose the new virtualized architectural mechanism, VIRT_SSBD, for using
speculative store bypass disable (SSBD) under SVM.  This will allow guests
to use SSBD on hardware that uses non-architectural mechanisms for enabling
SSBD.

[ tglx: Folded the migration fixup from Paolo Bonzini ]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/kvm_host.h |    2 +-
 arch/x86/kernel/cpu/common.c    |    3 ++-
 arch/x86/kvm/cpuid.c            |   11 +++++++++--
 arch/x86/kvm/svm.c              |   21 +++++++++++++++++++--
 arch/x86/kvm/vmx.c              |   18 +++++++++++++++---
 arch/x86/kvm/x86.c              |   13 ++++---------
 6 files changed, 50 insertions(+), 18 deletions(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -933,7 +933,7 @@ struct kvm_x86_ops {
 	int (*hardware_setup)(void);               /* __init */
 	void (*hardware_unsetup)(void);            /* __exit */
 	bool (*cpu_has_accelerated_tpr)(void);
-	bool (*cpu_has_high_real_mode_segbase)(void);
+	bool (*has_emulated_msr)(int index);
 	void (*cpuid_update)(struct kvm_vcpu *vcpu);
 
 	int (*vm_init)(struct kvm *kvm);
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -767,7 +767,8 @@ static void init_speculation_control(str
 	if (cpu_has(c, X86_FEATURE_INTEL_STIBP))
 		set_cpu_cap(c, X86_FEATURE_STIBP);
 
-	if (cpu_has(c, X86_FEATURE_SPEC_CTRL_SSBD))
+	if (cpu_has(c, X86_FEATURE_SPEC_CTRL_SSBD) ||
+	    cpu_has(c, X86_FEATURE_VIRT_SSBD))
 		set_cpu_cap(c, X86_FEATURE_SSBD);
 
 	if (cpu_has(c, X86_FEATURE_AMD_IBRS)) {
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -374,7 +374,7 @@ static inline int __do_cpuid_ent(struct
 
 	/* cpuid 0x80000008.ebx */
 	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
-		F(AMD_IBPB) | F(AMD_IBRS);
+		F(AMD_IBPB) | F(AMD_IBRS) | F(VIRT_SSBD);
 
 	/* cpuid 0xC0000001.edx */
 	const u32 kvm_cpuid_C000_0001_edx_x86_features =
@@ -642,13 +642,20 @@ static inline int __do_cpuid_ent(struct
 			g_phys_as = phys_as;
 		entry->eax = g_phys_as | (virt_as << 8);
 		entry->edx = 0;
-		/* IBRS and IBPB aren't necessarily present in hardware cpuid */
+		/*
+		 * IBRS, IBPB and VIRT_SSBD aren't necessarily present in
+		 * hardware cpuid
+		 */
 		if (boot_cpu_has(X86_FEATURE_AMD_IBPB))
 			entry->ebx |= F(AMD_IBPB);
 		if (boot_cpu_has(X86_FEATURE_AMD_IBRS))
 			entry->ebx |= F(AMD_IBRS);
+		if (boot_cpu_has(X86_FEATURE_VIRT_SSBD))
+			entry->ebx |= F(VIRT_SSBD);
 		entry->ebx &= kvm_cpuid_8000_0008_ebx_x86_features;
 		cpuid_mask(&entry->ebx, CPUID_8000_0008_EBX);
+		if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD))
+			entry->ebx |= F(VIRT_SSBD);
 		break;
 	}
 	case 0x80000019:
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3971,6 +3971,13 @@ static int svm_get_msr(struct kvm_vcpu *
 
 		msr_info->data = svm->spec_ctrl;
 		break;
+	case MSR_AMD64_VIRT_SPEC_CTRL:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_VIRT_SSBD))
+			return 1;
+
+		msr_info->data = svm->virt_spec_ctrl;
+		break;
 	case MSR_F15H_IC_CFG: {
 
 		int family, model;
@@ -4105,6 +4112,16 @@ static int svm_set_msr(struct kvm_vcpu *
 			break;
 		set_msr_interception(svm->msrpm, MSR_IA32_PRED_CMD, 0, 1);
 		break;
+	case MSR_AMD64_VIRT_SPEC_CTRL:
+		if (!msr->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_VIRT_SSBD))
+			return 1;
+
+		if (data & ~SPEC_CTRL_SSBD)
+			return 1;
+
+		svm->virt_spec_ctrl = data;
+		break;
 	case MSR_STAR:
 		svm->vmcb->save.star = data;
 		break;
@@ -5635,7 +5652,7 @@ static bool svm_cpu_has_accelerated_tpr(
 	return false;
 }
 
-static bool svm_has_high_real_mode_segbase(void)
+static bool svm_has_emulated_msr(int index)
 {
 	return true;
 }
@@ -6859,7 +6876,7 @@ static struct kvm_x86_ops svm_x86_ops __
 	.hardware_enable = svm_hardware_enable,
 	.hardware_disable = svm_hardware_disable,
 	.cpu_has_accelerated_tpr = svm_cpu_has_accelerated_tpr,
-	.cpu_has_high_real_mode_segbase = svm_has_high_real_mode_segbase,
+	.has_emulated_msr = svm_has_emulated_msr,
 
 	.vcpu_create = svm_create_vcpu,
 	.vcpu_free = svm_free_vcpu,
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9231,9 +9231,21 @@ static void vmx_handle_external_intr(str
 }
 STACK_FRAME_NON_STANDARD(vmx_handle_external_intr);
 
-static bool vmx_has_high_real_mode_segbase(void)
+static bool vmx_has_emulated_msr(int index)
 {
-	return enable_unrestricted_guest || emulate_invalid_guest_state;
+	switch (index) {
+	case MSR_IA32_SMBASE:
+		/*
+		 * We cannot do SMM unless we can run the guest in big
+		 * real mode.
+		 */
+		return enable_unrestricted_guest || emulate_invalid_guest_state;
+	case MSR_AMD64_VIRT_SPEC_CTRL:
+		/* This is AMD only.  */
+		return false;
+	default:
+		return true;
+	}
 }
 
 static bool vmx_mpx_supported(void)
@@ -12297,7 +12309,7 @@ static struct kvm_x86_ops vmx_x86_ops __
 	.hardware_enable = hardware_enable,
 	.hardware_disable = hardware_disable,
 	.cpu_has_accelerated_tpr = report_flexpriority,
-	.cpu_has_high_real_mode_segbase = vmx_has_high_real_mode_segbase,
+	.has_emulated_msr = vmx_has_emulated_msr,
 
 	.vcpu_create = vmx_create_vcpu,
 	.vcpu_free = vmx_free_vcpu,
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1045,6 +1045,7 @@ static u32 emulated_msrs[] = {
 	MSR_SMI_COUNT,
 	MSR_PLATFORM_INFO,
 	MSR_MISC_FEATURES_ENABLES,
+	MSR_AMD64_VIRT_SPEC_CTRL,
 };
 
 static unsigned num_emulated_msrs;
@@ -2843,7 +2844,7 @@ int kvm_vm_ioctl_check_extension(struct
 		 * fringe case that is not enabled except via specific settings
 		 * of the module parameters.
 		 */
-		r = kvm_x86_ops->cpu_has_high_real_mode_segbase();
+		r = kvm_x86_ops->has_emulated_msr(MSR_IA32_SMBASE);
 		break;
 	case KVM_CAP_VAPIC:
 		r = !kvm_x86_ops->cpu_has_accelerated_tpr();
@@ -4522,14 +4523,8 @@ static void kvm_init_msr_list(void)
 	num_msrs_to_save = j;
 
 	for (i = j = 0; i < ARRAY_SIZE(emulated_msrs); i++) {
-		switch (emulated_msrs[i]) {
-		case MSR_IA32_SMBASE:
-			if (!kvm_x86_ops->cpu_has_high_real_mode_segbase())
-				continue;
-			break;
-		default:
-			break;
-		}
+		if (!kvm_x86_ops->has_emulated_msr(emulated_msrs[i]))
+			continue;
 
 		if (j < i)
 			emulated_msrs[j] = emulated_msrs[i];
