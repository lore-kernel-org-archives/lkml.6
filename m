Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83757C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EABF21508
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789717;
	bh=7RSd603MAgOqz3+Q+tA4AtQmJPTb3MISVSqmlVl711o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yrTTJfLGPQqhy3pc5Tfx2+8mcoSb9jA4XLYqKVDb/E/uAM76Qt2aDjKMuT3HAUwqn
	 ZqE3QzT+1RspJy/1rhve4e87mngxmqlLiCZPUSi8Ve+o2iIJG1YnkAHgRIs5CiwWZ6
	 mvJwpRbI4fspfj7XzirX98mlI4vge9hPVyGToQrk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EABF21508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732514AbeLNMPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:15:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731243AbeLNMPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:15:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44846214F1;
        Fri, 14 Dec 2018 12:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789709;
        bh=7RSd603MAgOqz3+Q+tA4AtQmJPTb3MISVSqmlVl711o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rz7K+tgQaKpP0J3rEc+9Fo6JTPAroy9j+2NotTXwaok9vtHC1oLWniEbYClSYPuad
         xv4rp3B/upJVfoRGJWRfwg5wN79GPr1EXMFuVpnOoJEExaNDmbWnD/YlB6vrLofbmN
         KPgXUwdYCVApR8AaC1nuOxSqJfa+B8LThRq86S9c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, KarimAllah Ahmed <karahmed@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Jim Mattson <jmattson@google.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>, kvm@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 47/88] KVM/VMX: Emulate MSR_IA32_ARCH_CAPABILITIES
Date:   Fri, 14 Dec 2018 13:00:21 +0100
Message-Id: <20181214115706.131377044@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: KarimAllah Ahmed <karahmed@amazon.de>

commit 28c1c9fabf48d6ad596273a11c46e0d0da3e14cd upstream.

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
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 4.4: adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/cpuid.c |   11 +++++++++--
 arch/x86/kvm/cpuid.h |    8 ++++++++
 arch/x86/kvm/vmx.c   |   15 +++++++++++++++
 arch/x86/kvm/x86.c   |    1 +
 4 files changed, 33 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -362,6 +362,10 @@ static inline int __do_cpuid_ent(struct
 	const u32 kvm_supported_word10_x86_features =
 		F(XSAVEOPT) | F(XSAVEC) | F(XGETBV1) | f_xsaves;
 
+	/* cpuid 7.0.edx*/
+	const u32 kvm_cpuid_7_0_edx_x86_features =
+		F(ARCH_CAPABILITIES);
+
 	/* all calls to cpuid_count() should be made on the same cpu */
 	get_cpu();
 
@@ -439,11 +443,14 @@ static inline int __do_cpuid_ent(struct
 			cpuid_mask(&entry->ebx, 9);
 			// TSC_ADJUST is emulated
 			entry->ebx |= F(TSC_ADJUST);
-		} else
+			entry->edx &= kvm_cpuid_7_0_edx_x86_features;
+			cpuid_mask(&entry->edx, CPUID_7_EDX);
+		} else {
 			entry->ebx = 0;
+			entry->edx = 0;
+		}
 		entry->eax = 0;
 		entry->ecx = 0;
-		entry->edx = 0;
 		break;
 	}
 	case 9:
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -170,6 +170,14 @@ static inline bool guest_cpuid_has_ibpb(
 	return best && (best->edx & bit(X86_FEATURE_SPEC_CTRL));
 }
 
+static inline bool guest_cpuid_has_arch_capabilities(struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpuid_entry2 *best;
+
+	best = kvm_find_cpuid_entry(vcpu, 7, 0);
+	return best && (best->edx & bit(X86_FEATURE_ARCH_CAPABILITIES));
+}
+
 
 /*
  * NRIPS is provided through cpuidfn 0x8000000a.edx bit 3
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -545,6 +545,8 @@ struct vcpu_vmx {
 	u64 		      msr_guest_kernel_gs_base;
 #endif
 
+	u64 		      arch_capabilities;
+
 	u32 vm_entry_controls_shadow;
 	u32 vm_exit_controls_shadow;
 	/*
@@ -2832,6 +2834,12 @@ static int vmx_get_msr(struct kvm_vcpu *
 	case MSR_IA32_TSC:
 		msr_info->data = guest_read_tsc(vcpu);
 		break;
+	case MSR_IA32_ARCH_CAPABILITIES:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has_arch_capabilities(vcpu))
+			return 1;
+		msr_info->data = to_vmx(vcpu)->arch_capabilities;
+		break;
 	case MSR_IA32_SYSENTER_CS:
 		msr_info->data = vmcs_read32(GUEST_SYSENTER_CS);
 		break;
@@ -2958,6 +2966,11 @@ static int vmx_set_msr(struct kvm_vcpu *
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
@@ -5002,6 +5015,8 @@ static int vmx_vcpu_setup(struct vcpu_vm
 		++vmx->nmsrs;
 	}
 
+	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
+		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, vmx->arch_capabilities);
 
 	vm_exit_controls_init(vmx, vmcs_config.vmexit_ctrl);
 
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -961,6 +961,7 @@ static u32 msrs_to_save[] = {
 #endif
 	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
 	MSR_IA32_FEATURE_CONTROL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
+	MSR_IA32_ARCH_CAPABILITIES
 };
 
 static unsigned num_msrs_to_save;


