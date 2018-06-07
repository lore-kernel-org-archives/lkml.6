Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 57NXIklQGVv1BQAAmS7hNA
	; Thu, 07 Jun 2018 15:33:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 443A36074D; Thu,  7 Jun 2018 15:33:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4B49060590;
	Thu,  7 Jun 2018 15:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B49060590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935333AbeFGPdn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:33:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40664 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934096AbeFGOnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:43:05 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbw-0005Zi-VJ; Thu, 07 Jun 2018 15:09:57 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvaz-0002ki-Bn; Thu, 07 Jun 2018 15:08:57 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David Woodhouse" <dwmw@amazon.co.uk>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Jim Mattson" <jmattson@google.com>,
        "Jun Nakajima" <jun.nakajima@intel.com>,
        "Tim Chen" <tim.c.chen@linux.intel.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Asit Mallick" <asit.k.mallick@intel.com>,
        "Greg KH" <gregkh@linuxfoundation.org>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>, kvm@vger.kernel.org,
        "KarimAllah Ahmed" <karahmed@amazon.de>,
        "Darren Kenny" <darren.kenny@oracle.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Arjan Van De Ven" <arjan.van.de.ven@intel.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Andi Kleen" <ak@linux.intel.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.64345300@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 057/410] KVM/VMX: Allow direct access to
 MSR_IA32_SPEC_CTRL
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: KarimAllah Ahmed <karahmed@amazon.de>

commit d28b387fb74da95d69d2615732f50cceb38e9a4d upstream.

[ Based on a patch from Ashok Raj <ashok.raj@intel.com> ]

Add direct access to MSR_IA32_SPEC_CTRL for guests. This is needed for
guests that will only mitigate Spectre V2 through IBRS+IBPB and will not
be using a retpoline+IBPB based approach.

To avoid the overhead of saving and restoring the MSR_IA32_SPEC_CTRL for
guests that do not actually use the MSR, only start saving and restoring
when a non-zero is written to it.

No attempt is made to handle STIBP here, intentionally. Filtering STIBP
may be added in a future patch, which may require trapping all writes
if we don't want to pass it through directly to the guest.

[dwmw2: Clean up CPUID bits, save/restore manually, handle reset]

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
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
Link: https://lkml.kernel.org/r/1517522386-18410-5-git-send-email-karahmed@amazon.de
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16:
 - No support for nested MSR bitmaps
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/cpuid.c |  8 +++---
 arch/x86/kvm/cpuid.h | 11 ++++++++
 arch/x86/kvm/vmx.c   | 64 ++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c   |  2 +-
 4 files changed, 81 insertions(+), 4 deletions(-)

--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -302,7 +302,7 @@ static inline int __do_cpuid_ent(struct
 
 	/* cpuid 0x80000008.ebx */
 	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
-		F(IBPB);
+		F(IBPB) | F(IBRS);
 
 	/* cpuid 0xC0000001.edx */
 	const u32 kvm_supported_word5_x86_features =
@@ -318,7 +318,7 @@ static inline int __do_cpuid_ent(struct
 
 	/* cpuid 7.0.edx*/
 	const u32 kvm_cpuid_7_0_edx_x86_features =
-		F(ARCH_CAPABILITIES);
+		F(SPEC_CTRL) | F(ARCH_CAPABILITIES);
 
 	/* all calls to cpuid_count() should be made on the same cpu */
 	get_cpu();
@@ -524,9 +524,11 @@ static inline int __do_cpuid_ent(struct
 			g_phys_as = phys_as;
 		entry->eax = g_phys_as | (virt_as << 8);
 		entry->edx = 0;
-		/* IBPB isn't necessarily present in hardware cpuid */
+		/* IBRS and IBPB aren't necessarily present in hardware cpuid */
 		if (boot_cpu_has(X86_FEATURE_IBPB))
 			entry->ebx |= F(IBPB);
+		if (boot_cpu_has(X86_FEATURE_IBRS))
+			entry->ebx |= F(IBRS);
 		entry->ebx &= kvm_cpuid_8000_0008_ebx_x86_features;
 		cpuid_mask(&entry->ebx, 11);
 		break;
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -115,6 +115,17 @@ static inline bool guest_cpuid_has_ibpb(
 	return best && (best->edx & bit(X86_FEATURE_SPEC_CTRL));
 }
 
+static inline bool guest_cpuid_has_ibrs(struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpuid_entry2 *best;
+
+	best = kvm_find_cpuid_entry(vcpu, 0x80000008, 0);
+	if (best && (best->ebx & bit(X86_FEATURE_IBRS)))
+		return true;
+	best = kvm_find_cpuid_entry(vcpu, 7, 0);
+	return best && (best->edx & bit(X86_FEATURE_SPEC_CTRL));
+}
+
 static inline bool guest_cpuid_has_arch_capabilities(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpuid_entry2 *best;
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -433,6 +433,7 @@ struct vcpu_vmx {
 #endif
 
 	u64 		      arch_capabilities;
+	u64 		      spec_ctrl;
 
 	u32 vm_entry_controls_shadow;
 	u32 vm_exit_controls_shadow;
@@ -2524,6 +2525,13 @@ static int vmx_get_msr(struct kvm_vcpu *
 	case MSR_IA32_TSC:
 		msr_info->data = guest_read_tsc();
 		break;
+	case MSR_IA32_SPEC_CTRL:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has_ibrs(vcpu))
+			return 1;
+
+		msr_info->data = to_vmx(vcpu)->spec_ctrl;
+		break;
 	case MSR_IA32_ARCH_CAPABILITIES:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has_arch_capabilities(vcpu))
@@ -2622,6 +2630,36 @@ static int vmx_set_msr(struct kvm_vcpu *
 	case MSR_IA32_TSC:
 		kvm_write_tsc(vcpu, msr_info);
 		break;
+	case MSR_IA32_SPEC_CTRL:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has_ibrs(vcpu))
+			return 1;
+
+		/* The STIBP bit doesn't fault even if it's not advertised */
+		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP))
+			return 1;
+
+		vmx->spec_ctrl = data;
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
+		 * nested_vmx_merge_msr_bitmap. We should not touch the
+		 * vmcs02.msr_bitmap here since it gets completely overwritten
+		 * in the merging. We update the vmcs01 here for L1 as well
+		 * since it will end up touching the MSR anyway now.
+		 */
+		vmx_disable_intercept_for_msr(vmx->vmcs01.msr_bitmap,
+					      MSR_IA32_SPEC_CTRL,
+					      MSR_TYPE_RW);
+		break;
 	case MSR_IA32_PRED_CMD:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has_ibpb(vcpu))
@@ -4617,6 +4655,7 @@ static void vmx_vcpu_reset(struct kvm_vc
 	struct msr_data apic_base_msr;
 
 	vmx->rmode.vm86_active = 0;
+	vmx->spec_ctrl = 0;
 
 	vmx->soft_vnmi_blocked = 0;
 
@@ -7496,6 +7535,15 @@ static void __noclone vmx_vcpu_run(struc
 	atomic_switch_perf_msrs(vmx);
 	debugctlmsr = get_debugctlmsr();
 
+	/*
+	 * If this vCPU has touched SPEC_CTRL, restore the guest's value if
+	 * it's non-zero. Since vmentry is serialising on affected CPUs, there
+	 * is no need to worry about the conditional branch over the wrmsr
+	 * being speculatively taken.
+	 */
+	if (vmx->spec_ctrl)
+		wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
+
 	vmx->__launched = vmx->loaded_vmcs->launched;
 	asm(
 		/* Store host registers */
@@ -7614,6 +7662,22 @@ static void __noclone vmx_vcpu_run(struc
 #endif
 	      );
 
+	/*
+	 * We do not use IBRS in the kernel. If this vCPU has used the
+	 * SPEC_CTRL MSR it may have left it on; save the value and
+	 * turn it off. This is much more efficient than blindly adding
+	 * it to the atomic save/restore list. Especially as the former
+	 * (Saving guest MSRs on vmexit) doesn't even exist in KVM.
+	 *
+	 * If the L01 MSR bitmap does not intercept the MSR, then we need to
+	 * save it.
+	 */
+	if (!msr_write_intercepted_l01(vcpu, MSR_IA32_SPEC_CTRL))
+		rdmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
+
+	if (vmx->spec_ctrl)
+		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
 
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -894,7 +894,7 @@ static u32 msrs_to_save[] = {
 #endif
 	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
 	MSR_IA32_FEATURE_CONTROL, MSR_IA32_BNDCFGS,
-	MSR_IA32_ARCH_CAPABILITIES
+	MSR_IA32_SPEC_CTRL, MSR_IA32_ARCH_CAPABILITIES
 };
 
 static unsigned num_msrs_to_save;
