Return-Path: <prvs=56548c19e=karahmed@amazon.com>
X-Google-Smtp-Source: AH8x22445JgLwBgOkCCqmnOA+bx2wpiW2NE1HH1/5maJrkB5ETSEOPojrrS+esyEd3baIm7470Gg
ARC-Seal: i=1; a=rsa-sha256; t=1517669808; cv=none;
        d=google.com; s=arc-20160816;
        b=k/rqCaoXmRa10P2LI2t1ywo+i+zSKc5coIbf70lqGCZigOht7f+iMnTlaMfx4CnWsZ
         p6FKwec6NsUbV5iuJ2I3RKHMEH3fUaiV4TI0f2Hgn4N5LemoYGVePfeCimk7EhswJ+Wh
         2N2vv54jw2lqefZywISuGKjuo26IDc0ZxD9xLf9k/2yvBiYF1+KLWnx9qCLTfWD0BZCg
         aCjG9DEiObwuvgteM4nr82vUJcWTR2d/TJcpFHuuOEbvLIc13Q0f1TdAr9z6jHOuAL75
         Ys9puwbnSP7sQ/qp4EajF9ywkGBeKlDxjkhZqadg1UhPrDbinSo/7myaTPAZe4F0nqwr
         0KxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=pu0s0JEkMnW51X+naLOlvQYMwM2aGRQhg9Uzg7K7HvY=;
        b=owDrthbonWNjPlx+aKKd160KF3sJ5/y7QHjE/43tkJWYXCm3lLSwTUdAVGsS/AR9gZ
         CIrdQIIN0gzGkAaiAXGxbWqor733UdTrEm+/aNmEnZE00T0jWXmW+DYGT1RfOFyme6lR
         Tmm2s9FwhpkdMl7ZmnSG0xbTnC/9Hqhgpyoho4UG3XUlwc5zD0yH9Pi25eVYkdIOxXgB
         ATx9jr9WWq8wBIpwjn08goKW/O4AdHPRSEoUV7NZhbz615A/gh6D7T4eWM6EoVQsQIYq
         T4Fu8lPh0VFZRPeMf4gIqYTbyG9/rzOWx92t7uhWmM3QAnNhkAHvEZ6yDlJB3kqFtA7n
         dD6A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amazon.de header.s=amazon201209 header.b=rQqrhJL4;
       spf=pass (google.com: domain of prvs=56548c19e=karahmed@amazon.com designates 207.171.184.29 as permitted sender) smtp.mailfrom=prvs=56548c19e=karahmed@amazon.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.de
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amazon.de header.s=amazon201209 header.b=rQqrhJL4;
       spf=pass (google.com: domain of prvs=56548c19e=karahmed@amazon.com designates 207.171.184.29 as permitted sender) smtp.mailfrom=prvs=56548c19e=karahmed@amazon.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=amazon.de
X-IronPort-AV: E=Sophos;i="5.46,454,1511827200";
   d="scan'208";a="592757908"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org
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
Subject: [PATCH v7] KVM: SVM: Allow direct access to MSR_IA32_SPEC_CTRL
Date: Sat,  3 Feb 2018 15:56:23 +0100
Message-Id: <1517669783-20732-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591392137027542607?=
X-GMAIL-MSGID: =?utf-8?q?1591392137027542607?=
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
v6:
- ditch save_spec_ctrl_on_exit in favor of msr_write_intercepted
v5:
- Add SPEC_CTRL to direct_access_msrs.
---
 arch/x86/kvm/svm.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 254eefb..4e3c795 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -184,6 +184,8 @@ struct vcpu_svm {
 		u64 gs_base;
 	} host;
 
+	u64 spec_ctrl;
+
 	u32 *msrpm;
 
 	ulong nmi_iret_rip;
@@ -249,6 +251,7 @@ static const struct svm_direct_access_msrs {
 	{ .index = MSR_CSTAR,				.always = true  },
 	{ .index = MSR_SYSCALL_MASK,			.always = true  },
 #endif
+	{ .index = MSR_IA32_SPEC_CTRL,			.always = false },
 	{ .index = MSR_IA32_PRED_CMD,			.always = false },
 	{ .index = MSR_IA32_LASTBRANCHFROMIP,		.always = false },
 	{ .index = MSR_IA32_LASTBRANCHTOIP,		.always = false },
@@ -882,6 +885,25 @@ static bool valid_msr_intercept(u32 index)
 	return false;
 }
 
+static bool msr_write_intercepted(struct kvm_vcpu *vcpu, unsigned msr)
+{
+	u8 bit_write;
+	unsigned long tmp;
+	u32 offset;
+	u32 *msrpm;
+
+	msrpm = is_guest_mode(vcpu) ? to_svm(vcpu)->nested.msrpm:
+				      to_svm(vcpu)->msrpm;
+
+	offset    = svm_msrpm_offset(msr);
+	bit_write = 2 * (msr & 0x0f) + 1;
+	tmp       = msrpm[offset];
+
+	BUG_ON(offset == MSR_INVALID);
+
+	return !!test_bit(bit_write,  &tmp);
+}
+
 static void set_msr_interception(u32 *msrpm, unsigned msr,
 				 int read, int write)
 {
@@ -1584,6 +1606,8 @@ static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	u32 dummy;
 	u32 eax = 1;
 
+	svm->spec_ctrl = 0;
+
 	if (!init_event) {
 		svm->vcpu.arch.apic_base = APIC_DEFAULT_PHYS_BASE |
 					   MSR_IA32_APICBASE_ENABLE;
@@ -3605,6 +3629,13 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
@@ -3696,6 +3727,33 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
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
+		if (!data)
+			break;
+
+		/*
+		 * For non-nested:
+		 * When it's written (to non-zero) for the first time, pass
+		 * it through.
+		 *
+		 * For nested:
+		 * The handling of the MSR bitmap for L2 guests is done in
+		 * nested_svm_vmrun_msrpm.
+		 * We update the L1 MSR bit as well since it will end up
+		 * touching the MSR anyway now.
+		 */
+		set_msr_interception(svm->msrpm, MSR_IA32_SPEC_CTRL, 1, 1);
+		break;
 	case MSR_IA32_PRED_CMD:
 		if (!msr->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_IBPB))
@@ -4964,6 +5022,15 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 
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
@@ -5056,6 +5123,27 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 #endif
 		);
 
+	/*
+	 * We do not use IBRS in the kernel. If this vCPU has used the
+	 * SPEC_CTRL MSR it may have left it on; save the value and
+	 * turn it off. This is much more efficient than blindly adding
+	 * it to the atomic save/restore list. Especially as the former
+	 * (Saving guest MSRs on vmexit) doesn't even exist in KVM.
+	 *
+	 * For non-nested case:
+	 * If the L01 MSR bitmap does not intercept the MSR, then we need to
+	 * save it.
+	 *
+	 * For nested case:
+	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
+	 * save it.
+	 */
+	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
+		rdmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
+
+	if (svm->spec_ctrl)
+		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
 
-- 
2.7.4
