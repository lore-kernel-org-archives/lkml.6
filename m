Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225Ea2+B7uZkts4tyJaNyGRCa1NInrd1v8jA7cAxbtKAJ0SjKh2QS/0AdAe30FVnidi5SYwS
ARC-Seal: i=1; a=rsa-sha256; t=1517855169; cv=none;
        d=google.com; s=arc-20160816;
        b=WlLxI9mjj9id1FiZXborcINM4yQv2puocdOYLfXEJNp9hJUTVv5+0N8awxZ77/yI/O
         Ls3Lzf0ZRYH4M+SJRBtMqd4XMfV9tjruI5esf4msqFJJBGYVAxvSvZwe9uwkKFfL3idM
         nvtENDtd2KRd2f+IeZ3SsM9m428h1vNZCk1m0pKSNt5SZi9SqUOc2jrIUj8fn/Nxo+MW
         3mbx5YuzE6x1NrBeiB9I5nbzA3TJTPUJGUKHXW6mFVEEfTKsNp+AelcR044PogKp7Ca0
         h5gsVLulGhCmoCdIgpvryu4BYNslFBVjXRlIVPy0pNsSKQ0RPmxHlyiUUOhyv6JRRqNu
         2fww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=s8EDqynYs3dyj5O7V3juph/i9pKF5t3t2Lv4GBFnhUE=;
        b=PA9gUvGBrKyxP09Aowhkf0JrTRx1fiq81iSJ13h2lL7Hvju4qqJPrC9SjzPSpUQFH3
         oavwe3o5AUuXLc8odRlhj+egjAUAhFlIJUObfeQuc/4tL0NQB0wg6tlMDAiykgWcxFMC
         caNhLtvtXVkU9Hlyr2x3f4W97U6g18acxXjEmUADSW3z7zFe3Ck72l4qeIV/ASa0klYZ
         sxYNtIXrE3v5jU8G/WlUPv3E7EIkdP52xMNHDmVgQj1yXuYT5g3LpITpiLKnH8a1EU5D
         eZmdu+cnmgvfvugd6Cs9EPg4vtTMVACJ85SsikiZC+DE4ZOmEMCLdhsMCCggTzPR/9xH
         PL3Q==
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
	Darren Kenny <darren.kenny@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andi Kleen <ak@linux.intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Asit Mallick <asit.k.mallick@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH 4.15 58/60] KVM/SVM: Allow direct access to MSR_IA32_SPEC_CTRL
Date: Mon,  5 Feb 2018 10:23:31 -0800
Message-Id: <20180205182216.992922887@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586407289517446?=
X-GMAIL-MSGID: =?utf-8?q?1591586502737320554?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: KarimAllah Ahmed karahmed@amazon.de

commit b2ac58f90540e39324e7a29a7ad471407ae0bf48

[ Based on a patch from Paolo Bonzini <pbonzini@redhat.com> ]

... basically doing exactly what we do for VMX:

- Passthrough SPEC_CTRL to guests (if enabled in guest CPUID)
- Save and restore SPEC_CTRL around VMExit and VMEntry only if the guest
  actually used it.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jun Nakajima <jun.nakajima@intel.com>
Cc: kvm@vger.kernel.org
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Asit Mallick <asit.k.mallick@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Link: https://lkml.kernel.org/r/1517669783-20732-1-git-send-email-karahmed@amazon.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/kvm/svm.c |   88 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -184,6 +184,8 @@ struct vcpu_svm {
 		u64 gs_base;
 	} host;
 
+	u64 spec_ctrl;
+
 	u32 *msrpm;
 
 	ulong nmi_iret_rip;
@@ -249,6 +251,7 @@ static const struct svm_direct_access_ms
 	{ .index = MSR_CSTAR,				.always = true  },
 	{ .index = MSR_SYSCALL_MASK,			.always = true  },
 #endif
+	{ .index = MSR_IA32_SPEC_CTRL,			.always = false },
 	{ .index = MSR_IA32_PRED_CMD,			.always = false },
 	{ .index = MSR_IA32_LASTBRANCHFROMIP,		.always = false },
 	{ .index = MSR_IA32_LASTBRANCHTOIP,		.always = false },
@@ -882,6 +885,25 @@ static bool valid_msr_intercept(u32 inde
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
@@ -1584,6 +1606,8 @@ static void svm_vcpu_reset(struct kvm_vc
 	u32 dummy;
 	u32 eax = 1;
 
+	svm->spec_ctrl = 0;
+
 	if (!init_event) {
 		svm->vcpu.arch.apic_base = APIC_DEFAULT_PHYS_BASE |
 					   MSR_IA32_APICBASE_ENABLE;
@@ -3605,6 +3629,13 @@ static int svm_get_msr(struct kvm_vcpu *
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
@@ -3696,6 +3727,33 @@ static int svm_set_msr(struct kvm_vcpu *
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
@@ -4964,6 +5022,15 @@ static void svm_vcpu_run(struct kvm_vcpu
 
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
@@ -5056,6 +5123,27 @@ static void svm_vcpu_run(struct kvm_vcpu
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
 
