Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225/mIO0OqSM43d03FQhWfZxa5W/AHpxef+n/b342yauWM646vnLeFH8kvDDD3Kl0XhD8LsB
ARC-Seal: i=1; a=rsa-sha256; t=1517855077; cv=none;
        d=google.com; s=arc-20160816;
        b=WUOVvK4HI1h5g/JuRFKvmEeXDD9YAyTN7/1YPd3kBJ12lAINBHlIeyS1GDFsZ8g+bL
         SkpVKiTgUXdwoa2F87HZpK6/kKW7uCCwoZDcp00sw3jIpBU3WtcjANn+QYAymcpHIe+Q
         mljHDN1VkD4dytzGx6meAylSCp/Y7k9HzM5yUHLlSgNJbXHg+XGlWjcgTJNKrYpCXx+R
         wS8Fn1LeSHCuBE/oKfrHfxnDHD7/5ZgHFnW0j6XOK/Vd3dTIBNWXwE1zkzQ1tX1NjRsj
         TwjBLIo8sxPxfhbzbkdki4xpyqlClzNSlwXIkymXx3OakvY0OvM7Fr1iK7NiaDeIog9a
         cbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ActlnlEvKD3legRWIdnaUvV8QSebXYqP+C7yhZPi1cs=;
        b=PGCGwXEeP4J4sQOkP+EFn8+zZvH8498o0naUuy+jQXwA1nsnNIHR3oeklPEPkG11/J
         F6wIO+T8dNaVTjQ+DM3hWOBh2GbJBHVnYg/Zi0gh/085bAyRiiFNU0oVH+g6yjY5etwZ
         aV+eL0E9zNZB530qkyoU0gamuE7YNPAjUedfieyJwsC7FCow/Arab/gEQ4aYmTQm0uGb
         +PfhRiTmTNW+p/4qQ73brGPlU1qzRIxB5OnakUazwotRTzBg/sd4BugJbKPoNkpfvYCT
         IZYmni/BURVcoY8tXLqfVfD06XcuBj1GZOWoHUuXsvZMtrHCQlFv5No+HOnIkiIwBu41
         O6tw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	KarimAllah Ahmed <karahmed@amazon.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Darren Kenny <darren.kenny@oracle.com>,
	Jim Mattson <jmattson@google.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andi Kleen <ak@linux.intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Asit Mallick <asit.k.mallick@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH 4.14 60/64] KVM/VMX: Emulate MSR_IA32_ARCH_CAPABILITIES
Date: Mon,  5 Feb 2018 10:23:19 -0800
Message-Id: <20180205182141.047844255@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586405280602404?=
X-GMAIL-MSGID: =?utf-8?q?1591586405280602404?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: KarimAllah Ahmed karahmed@amazon.de

commit 28c1c9fabf48d6ad596273a11c46e0d0da3e14cd

Intel processors use MSR_IA32_ARCH_CAPABILITIES MSR to indicate RDCL_NO
(bit 0) and IBRS_ALL (bit 1). This is a read-only MSR. By default the
contents will come directly from the hardware, but user-space can still
override it.

[dwmw2: The bit in kvm_cpuid_7_0_edx_x86_features can be unconditional]

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jun Nakajima <jun.nakajima@intel.com>
Cc: kvm@vger.kernel.org
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Link: https://lkml.kernel.org/r/1517522386-18410-4-git-send-email-karahmed@amazon.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/kvm/cpuid.c |    2 +-
 arch/x86/kvm/vmx.c   |   15 +++++++++++++++
 arch/x86/kvm/x86.c   |    1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -394,7 +394,7 @@ static inline int __do_cpuid_ent(struct
 
 	/* cpuid 7.0.edx*/
 	const u32 kvm_cpuid_7_0_edx_x86_features =
-		F(AVX512_4VNNIW) | F(AVX512_4FMAPS);
+		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(ARCH_CAPABILITIES);
 
 	/* all calls to cpuid_count() should be made on the same cpu */
 	get_cpu();
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -583,6 +583,8 @@ struct vcpu_vmx {
 	u64 		      msr_guest_kernel_gs_base;
 #endif
 
+	u64 		      arch_capabilities;
+
 	u32 vm_entry_controls_shadow;
 	u32 vm_exit_controls_shadow;
 	u32 secondary_exec_control;
@@ -3257,6 +3259,12 @@ static int vmx_get_msr(struct kvm_vcpu *
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
@@ -3392,6 +3400,11 @@ static int vmx_set_msr(struct kvm_vcpu *
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
@@ -5652,6 +5665,8 @@ static int vmx_vcpu_setup(struct vcpu_vm
 		++vmx->nmsrs;
 	}
 
+	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
+		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, vmx->arch_capabilities);
 
 	vm_exit_controls_init(vmx, vmcs_config.vmexit_ctrl);
 
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1006,6 +1006,7 @@ static u32 msrs_to_save[] = {
 #endif
 	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
 	MSR_IA32_FEATURE_CONTROL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
+	MSR_IA32_ARCH_CAPABILITIES
 };
 
 static unsigned num_msrs_to_save;
