Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305DAC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85182087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85182087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbeI3EVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:21:16 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52049 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728772AbeI3ESf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:35 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6E-0000H3-TO; Sat, 29 Sep 2018 22:48:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5w-0006sY-N1; Sat, 29 Sep 2018 22:48:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "David Woodhouse" <dwmw@amazon.co.uk>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.583155565@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 046/131] KVM: SVM: Implement VIRT_SPEC_CTRL support
 for SSBD
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Lendacky <thomas.lendacky@amd.com>

commit bc226f07dcd3c9ef0b7f6236fe356ea4a9cb4769 upstream.

Expose the new virtualized architectural mechanism, VIRT_SSBD, for using
speculative store bypass disable (SSBD) under SVM.  This will allow guests
to use SSBD on hardware that uses non-architectural mechanisms for enabling
SSBD.

[ tglx: Folded the migration fixup from Paolo Bonzini ]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16:
 - There is no SMM support or cpu_has_high_real_mode_segbase operation
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kernel/cpu/common.c    |  3 ++-
 arch/x86/kvm/cpuid.c            | 11 +++++++++--
 arch/x86/kvm/cpuid.h            |  8 ++++++++
 arch/x86/kvm/svm.c              | 23 +++++++++++++++++++++++
 arch/x86/kvm/vmx.c              | 12 ++++++++++++
 arch/x86/kvm/x86.c              |  7 +++----
 7 files changed, 58 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -671,6 +671,7 @@ struct kvm_x86_ops {
 	int (*hardware_setup)(void);               /* __init */
 	void (*hardware_unsetup)(void);            /* __exit */
 	bool (*cpu_has_accelerated_tpr)(void);
+	bool (*has_emulated_msr)(int index);
 	void (*cpuid_update)(struct kvm_vcpu *vcpu);
 
 	/* Create, but do not attach this VCPU */
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -700,7 +700,8 @@ static void init_speculation_control(str
 	if (cpu_has(c, X86_FEATURE_INTEL_STIBP))
 		set_cpu_cap(c, X86_FEATURE_STIBP);
 
-	if (cpu_has(c, X86_FEATURE_SPEC_CTRL_SSBD))
+	if (cpu_has(c, X86_FEATURE_SPEC_CTRL_SSBD) ||
+	    cpu_has(c, X86_FEATURE_VIRT_SSBD))
 		set_cpu_cap(c, X86_FEATURE_SSBD);
 
 	if (cpu_has(c, X86_FEATURE_AMD_IBRS)) {
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -302,7 +302,7 @@ static inline int __do_cpuid_ent(struct
 
 	/* cpuid 0x80000008.ebx */
 	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
-		F(AMD_IBPB) | F(AMD_IBRS);
+		F(AMD_IBPB) | F(AMD_IBRS) | F(VIRT_SSBD);
 
 	/* cpuid 0xC0000001.edx */
 	const u32 kvm_supported_word5_x86_features =
@@ -524,13 +524,20 @@ static inline int __do_cpuid_ent(struct
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
 		cpuid_mask(&entry->ebx, 11);
+		if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD))
+			entry->ebx |= F(VIRT_SSBD);
 		break;
 	}
 	case 0x80000019:
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -134,5 +134,13 @@ static inline bool guest_cpuid_has_arch_
 	return best && (best->edx & bit(X86_FEATURE_ARCH_CAPABILITIES));
 }
 
+static inline bool guest_cpuid_has_virt_ssbd(struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpuid_entry2 *best;
+
+	best = kvm_find_cpuid_entry(vcpu, 0x80000008, 0);
+	return best && (best->ebx & bit(X86_FEATURE_VIRT_SSBD));
+}
+
 
 #endif
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3151,6 +3151,13 @@ static int svm_get_msr(struct kvm_vcpu *
 
 		msr_info->data = svm->spec_ctrl;
 		break;
+	case MSR_AMD64_VIRT_SPEC_CTRL:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has_virt_ssbd(vcpu))
+			return 1;
+
+		msr_info->data = svm->virt_spec_ctrl;
+		break;
 	case MSR_IA32_UCODE_REV:
 		msr_info->data = 0x01000065;
 		break;
@@ -3266,6 +3273,16 @@ static int svm_set_msr(struct kvm_vcpu *
 			break;
 		set_msr_interception(svm->msrpm, MSR_IA32_PRED_CMD, 0, 1);
 		break;
+	case MSR_AMD64_VIRT_SPEC_CTRL:
+		if (!msr->host_initiated &&
+		    !guest_cpuid_has_virt_ssbd(vcpu))
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
@@ -4202,6 +4219,11 @@ static bool svm_cpu_has_accelerated_tpr(
 	return false;
 }
 
+static bool svm_has_emulated_msr(int index)
+{
+	return true;
+}
+
 static u64 svm_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
 {
 	return 0;
@@ -4468,6 +4490,7 @@ static struct kvm_x86_ops svm_x86_ops =
 	.hardware_enable = svm_hardware_enable,
 	.hardware_disable = svm_hardware_disable,
 	.cpu_has_accelerated_tpr = svm_cpu_has_accelerated_tpr,
+	.has_emulated_msr = svm_has_emulated_msr,
 
 	.vcpu_create = svm_create_vcpu,
 	.vcpu_free = svm_free_vcpu,
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -7356,6 +7356,17 @@ static void vmx_handle_external_intr(str
 		local_irq_enable();
 }
 
+static bool vmx_has_emulated_msr(int index)
+{
+	switch (index) {
+	case MSR_AMD64_VIRT_SPEC_CTRL:
+		/* This is AMD only.  */
+		return false;
+	default:
+		return true;
+	}
+}
+
 static bool vmx_mpx_supported(void)
 {
 	return (vmcs_config.vmexit_ctrl & VM_EXIT_CLEAR_BNDCFGS) &&
@@ -9034,6 +9045,7 @@ static struct kvm_x86_ops vmx_x86_ops =
 	.hardware_enable = hardware_enable,
 	.hardware_disable = hardware_disable,
 	.cpu_has_accelerated_tpr = report_flexpriority,
+	.has_emulated_msr = vmx_has_emulated_msr,
 
 	.vcpu_create = vmx_create_vcpu,
 	.vcpu_free = vmx_free_vcpu,
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -906,6 +906,7 @@ static u32 emulated_msrs[] = {
 	MSR_IA32_MISC_ENABLE,
 	MSR_IA32_MCG_STATUS,
 	MSR_IA32_MCG_CTL,
+	MSR_AMD64_VIRT_SPEC_CTRL,
 };
 
 static unsigned num_emulated_msrs;
@@ -4039,10 +4040,8 @@ static void kvm_init_msr_list(void)
 	num_msrs_to_save = j;
 
 	for (i = j = 0; i < ARRAY_SIZE(emulated_msrs); i++) {
-		switch (emulated_msrs[i]) {
-		default:
-			break;
-		}
+		if (!kvm_x86_ops->has_emulated_msr(emulated_msrs[i]))
+			continue;
 
 		if (j < i)
 			emulated_msrs[j] = emulated_msrs[i];

