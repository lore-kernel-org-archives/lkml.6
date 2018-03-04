Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752440AbeCEB6n (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 20:58:43 -0500
Received: from mga14.intel.com ([192.55.52.115]:39574 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752098AbeCEB5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 20:57:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,425,1515484800";
   d="scan'208";a="21986107"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        joro@8bytes.org, Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v5 08/11] KVM: x86: Introduce a function to initialize the PT configuration
Date: Sun,  4 Mar 2018 20:07:18 +0800
Message-Id: <1520165241-15819-9-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520165241-15819-1-git-send-email-luwei.kang@intel.com>
References: <1520165241-15819-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize the Intel PT configuration when cpuid update.
Include cpuid inforamtion, rtit_ctl bit mask and the number of
address ranges.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/kvm/vmx.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index dab020b..455a87e 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10092,6 +10092,71 @@ static void nested_vmx_cr_fixed1_bits_update(struct kvm_vcpu *vcpu)
 #undef cr4_fixed1_update
 }
 
+static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct kvm_cpuid_entry2 *best = NULL;
+	int i;
+
+	for (i = 0; i < PT_CPUID_LEAVES; i++) {
+		best = kvm_find_cpuid_entry(vcpu, 0x14, i);
+		if (!best)
+			return;
+		vmx->pt_desc.caps[CPUID_EAX + i*PT_CPUID_REGS_NUM] = best->eax;
+		vmx->pt_desc.caps[CPUID_EBX + i*PT_CPUID_REGS_NUM] = best->ebx;
+		vmx->pt_desc.caps[CPUID_ECX + i*PT_CPUID_REGS_NUM] = best->ecx;
+		vmx->pt_desc.caps[CPUID_EDX + i*PT_CPUID_REGS_NUM] = best->edx;
+	}
+
+	/* Get the number of configurable Address Ranges for filtering */
+	vmx->pt_desc.range_cnt = pt_cap_get_ex(vmx->pt_desc.caps,
+						PT_CAP_num_address_ranges);
+
+	/* Clear the no dependency bits */
+	vmx->pt_desc.ctl_bitmask = ~(RTIT_CTL_TRACEEN | RTIT_CTL_OS |
+			RTIT_CTL_USR | RTIT_CTL_TSC_EN | RTIT_CTL_DIS_RETC);
+
+	/* If CPUID.(EAX=14H,ECX=0):EBX[0]=1 CR3Filter can be set */
+	if (pt_cap_get_ex(vmx->pt_desc.caps, PT_CAP_cr3_filtering))
+		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_CR3_FILTER;
+
+	/*
+	 * If CPUID.(EAX=14H,ECX=0):EBX[1]=1 CYCEn, CycThresh and
+	 * PSBFreq can be set
+	 */
+	if (pt_cap_get_ex(vmx->pt_desc.caps, PT_CAP_psb_cyc))
+		vmx->pt_desc.ctl_bitmask &= ~(RTIT_CTL_CYC_EN |
+			RTIT_CTL_CYC_THRESH | RTIT_CTL_PSB_FREQ);
+
+	/*
+	 * If CPUID.(EAX=14H,ECX=0):EBX[3]=1 MTCEn BranchEn and
+	 * MTCFreq can be set
+	 */
+	if (pt_cap_get_ex(vmx->pt_desc.caps, PT_CAP_mtc))
+		vmx->pt_desc.ctl_bitmask &= ~(RTIT_CTL_MTC_EN |
+			RTIT_CTL_BRANCH_EN | RTIT_CTL_MTC_RANGE);
+
+	/* If CPUID.(EAX=14H,ECX=0):EBX[4]=1 FUPonPTW and PTWEn can be set */
+	if (pt_cap_get_ex(vmx->pt_desc.caps, PT_CAP_ptwrite))
+		vmx->pt_desc.ctl_bitmask &= ~(RTIT_CTL_FUP_ON_PTW |
+						RTIT_CTL_PTW_EN);
+
+	/* If CPUID.(EAX=14H,ECX=0):EBX[5]=1 PwrEvEn can be set */
+	if (pt_cap_get_ex(vmx->pt_desc.caps, PT_CAP_power_event_trace))
+		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_PWR_EVT_EN;
+
+	/* If CPUID.(EAX=14H,ECX=0):ECX[0]=1 ToPA can be set */
+	if (pt_cap_get_ex(vmx->pt_desc.caps, PT_CAP_topa_output))
+		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_TOPA;
+	/* If CPUID.(EAX=14H,ECX=0):ECX[3]=1 FabircEn can be set */
+	if (pt_cap_get_ex(vmx->pt_desc.caps, PT_CAP_output_subsys))
+		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_FABRIC_EN;
+
+	/* unmask address range configure area */
+	for (i = 0; i < vmx->pt_desc.range_cnt; i++)
+		vmx->pt_desc.ctl_bitmask &= ~(0xf << (32 + i*4));
+}
+
 static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -10110,6 +10175,10 @@ static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
 
 	if (nested_vmx_allowed(vcpu))
 		nested_vmx_cr_fixed1_bits_update(vcpu);
+
+	if (boot_cpu_has(X86_FEATURE_INTEL_PT) &&
+		guest_cpuid_has(vcpu, X86_FEATURE_INTEL_PT))
+		update_intel_pt_cfg(vcpu);
 }
 
 static void vmx_set_supported_cpuid(u32 func, struct kvm_cpuid_entry2 *entry)
-- 
1.8.3.1
