Return-Path: <prvs=5630c6a94=karahmed@amazon.com>
X-Google-Smtp-Source: AH8x226skkaIx0ch+L7k2HaoWhEgavWt5McXwm3eKRsjQuH5H6XjZh6Jhyjv0f1s7N4ni9B5ionU
ARC-Seal: i=1; a=rsa-sha256; t=1517522415; cv=none;
        d=google.com; s=arc-20160816;
        b=QwcJjBJhXP7eCXtPfF6PFgLBzUnpfuHRdY3fzmoC8ZRTakuWp5bBYTszd2Dm6LoTLE
         9nKvt2AKfiDci/rrq76w9wtEfu51thMYuYamaYZjNsKItEl5BHIh4evw/Tb4q6/fx2n4
         ap0AbVkB1bxentSRH7nKLPDTdm7jLMOTDxDTEobRiF1urCOOLugSJK0bXSEUBg49iAyv
         GlpZleh9Tt4UUyeekv39HpqWKhzaZykMgRwgin2EBe+uf8XF5xGGpzVZdiz3GcDzTt/A
         BOYQbGsaGQZSV0eHbcZ2gpLzNpFUzbTl7TbmIhMLfb1zBgZBmr2Vs8x49IQ+6kB+Xn9S
         p+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=M5hriYyhwaeksx3TUXizX4JeWsT0p8002dapVFWbgl8=;
        b=BeHz7wmNSjnknIq8uvogzsIBifegh5UyOpkjWwK4FItErBssCK9Cs0tLOTnIGGKXlD
         E/bJeOITrx39TvTGEeamFXLu/gMEdQdh7+IKaE3p/75dIUvYUyDte4QOPRw3w4Hi74Md
         kVgQ6YPOVBMngyv7qu2BwNVEFWp+E2ivaOutDLLap5puN9JjEMVPwRgkBirjLQaQ/78u
         XJZoVe7HUPZCyDiffIowtuMnkMEJUjTOlHtc0TQFNa0JHBulhrz8ues/rf5/5oxyCT4Z
         ZDNVqbM/kIA/LzrdER73KuDNGdkBZIoF511jPJeozATtGoSrn03p8K5ItEYAoEFtu8aO
         L+zw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amazon.de header.s=amazon201209 header.b=HekTaejj;
       spf=pass (google.com: domain of prvs=5630c6a94=karahmed@amazon.com designates 52.95.49.90 as permitted sender) smtp.mailfrom=prvs=5630c6a94=karahmed@amazon.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.de
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amazon.de header.s=amazon201209 header.b=HekTaejj;
       spf=pass (google.com: domain of prvs=5630c6a94=karahmed@amazon.com designates 52.95.49.90 as permitted sender) smtp.mailfrom=prvs=5630c6a94=karahmed@amazon.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.de
X-IronPort-AV: E=Sophos;i="5.46,444,1511827200";
   d="scan'208";a="330213009"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>, Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v6 5/5] KVM: SVM: Allow direct access to MSR_IA32_SPEC_CTRL
Date: Thu,  1 Feb 2018 22:59:46 +0100
Message-Id: <1517522386-18410-6-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517522386-18410-1-git-send-email-karahmed@amazon.de>
References: <1517522386-18410-1-git-send-email-karahmed@amazon.de>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591237584685742413?=
X-GMAIL-MSGID: =?utf-8?q?1591237584685742413?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[ Based on a patch from Paolo Bonzini <pbonzini@redhat.com> ]

... basically doing exactly what we do for VMX:

- Passthrough SPEC_CTRL to guests (if enabled in guest CPUID)
- Save and restore SPEC_CTRL around VMExit and VMEntry only if the guest
  actually used it.

Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jun Nakajima <jun.nakajima@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
v5:
- Add SPEC_CTRL to direct_access_msrs.
---
 arch/x86/kvm/svm.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 254eefb..c6ab343 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -184,6 +184,9 @@ struct vcpu_svm {
 		u64 gs_base;
 	} host;
 
+	u64 spec_ctrl;
+	bool save_spec_ctrl_on_exit;
+
 	u32 *msrpm;
 
 	ulong nmi_iret_rip;
@@ -249,6 +252,7 @@ static const struct svm_direct_access_msrs {
 	{ .index = MSR_CSTAR,				.always = true  },
 	{ .index = MSR_SYSCALL_MASK,			.always = true  },
 #endif
+	{ .index = MSR_IA32_SPEC_CTRL,			.always = false },
 	{ .index = MSR_IA32_PRED_CMD,			.always = false },
 	{ .index = MSR_IA32_LASTBRANCHFROMIP,		.always = false },
 	{ .index = MSR_IA32_LASTBRANCHTOIP,		.always = false },
@@ -1584,6 +1588,8 @@ static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	u32 dummy;
 	u32 eax = 1;
 
+	svm->spec_ctrl = 0;
+
 	if (!init_event) {
 		svm->vcpu.arch.apic_base = APIC_DEFAULT_PHYS_BASE |
 					   MSR_IA32_APICBASE_ENABLE;
@@ -3605,6 +3611,13 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_VM_CR:
 		msr_info->data = svm->nested.vm_cr_msr;
 		break;
+	case MSR_IA32_SPEC_CTRL:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS))
+			return 1;
+
+		msr_info->data = svm->spec_ctrl;
+		break;
 	case MSR_IA32_UCODE_REV:
 		msr_info->data = 0x01000065;
 		break;
@@ -3696,6 +3709,30 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 	case MSR_IA32_TSC:
 		kvm_write_tsc(vcpu, msr);
 		break;
+	case MSR_IA32_SPEC_CTRL:
+		if (!msr->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS))
+			return 1;
+
+		/* The STIBP bit doesn't fault even if it's not advertised */
+		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP))
+			return 1;
+
+		svm->spec_ctrl = data;
+
+		/*
+		 * When it's written (to non-zero) for the first time, pass
+		 * it through. This means we don't have to take the perf
+		 * hit of saving it on vmexit for the common case of guests
+		 * that don't use it.
+		 */
+		if (data && !svm->save_spec_ctrl_on_exit) {
+			svm->save_spec_ctrl_on_exit = true;
+			if (is_guest_mode(vcpu))
+				break;
+			set_msr_interception(svm->msrpm, MSR_IA32_SPEC_CTRL, 1, 1);
+		}
+		break;
 	case MSR_IA32_PRED_CMD:
 		if (!msr->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_IBPB))
@@ -4964,6 +5001,15 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 
 	local_irq_enable();
 
+	/*
+	 * If this vCPU has touched SPEC_CTRL, restore the guest's value if
+	 * it's non-zero. Since vmentry is serialising on affected CPUs, there
+	 * is no need to worry about the conditional branch over the wrmsr
+	 * being speculatively taken.
+	 */
+	if (svm->spec_ctrl)
+		wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
+
 	asm volatile (
 		"push %%" _ASM_BP "; \n\t"
 		"mov %c[rbx](%[svm]), %%" _ASM_BX " \n\t"
@@ -5056,6 +5102,19 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 #endif
 		);
 
+	/*
+	 * We do not use IBRS in the kernel. If this vCPU has used the
+	 * SPEC_CTRL MSR it may have left it on; save the value and
+	 * turn it off. This is much more efficient than blindly adding
+	 * it to the atomic save/restore list. Especially as the former
+	 * (Saving guest MSRs on vmexit) doesn't even exist in KVM.
+	 */
+	if (svm->save_spec_ctrl_on_exit)
+		rdmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
+
+	if (svm->spec_ctrl)
+		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
 
-- 
2.7.4
