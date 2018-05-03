Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752398AbeECKUg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:20:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:65500 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752286AbeECKT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:19:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="36546565"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        joro@8bytes.org, peterz@infradead.org, chao.p.peng@linux.intel.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v7 10/13] KVM: x86: Introduce a function to initialize the PT configuration
Date: Thu,  3 May 2018 20:13:25 +0800
Message-Id: <1525349608-10352-11-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1525349608-10352-1-git-send-email-luwei.kang@intel.com>
References: <1525349608-10352-1-git-send-email-luwei.kang@intel.com>
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
index a08c61b..3ed02a8 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10371,6 +10371,71 @@ static void nested_vmx_cr_fixed1_bits_update(struct kvm_vcpu *vcpu)
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
+	vmx->pt_desc.range_cnt = __pt_cap_get(vmx->pt_desc.caps,
+						PT_CAP_num_address_ranges);
+
+	/* Clear the no dependency bits */
+	vmx->pt_desc.ctl_bitmask = ~(RTIT_CTL_TRACEEN | RTIT_CTL_OS |
+			RTIT_CTL_USR | RTIT_CTL_TSC_EN | RTIT_CTL_DISRETC);
+
+	/* If CPUID.(EAX=14H,ECX=0):EBX[0]=1 CR3Filter can be set */
+	if (__pt_cap_get(vmx->pt_desc.caps, PT_CAP_cr3_filtering))
+		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_CR3EN;
+
+	/*
+	 * If CPUID.(EAX=14H,ECX=0):EBX[1]=1 CYCEn, CycThresh and
+	 * PSBFreq can be set
+	 */
+	if (__pt_cap_get(vmx->pt_desc.caps, PT_CAP_psb_cyc))
+		vmx->pt_desc.ctl_bitmask &= ~(RTIT_CTL_CYCLEACC |
+			RTIT_CTL_CYC_THRESH | RTIT_CTL_PSB_FREQ);
+
+	/*
+	 * If CPUID.(EAX=14H,ECX=0):EBX[3]=1 MTCEn BranchEn and
+	 * MTCFreq can be set
+	 */
+	if (__pt_cap_get(vmx->pt_desc.caps, PT_CAP_mtc))
+		vmx->pt_desc.ctl_bitmask &= ~(RTIT_CTL_MTC_EN |
+			RTIT_CTL_BRANCH_EN | RTIT_CTL_MTC_RANGE);
+
+	/* If CPUID.(EAX=14H,ECX=0):EBX[4]=1 FUPonPTW and PTWEn can be set */
+	if (__pt_cap_get(vmx->pt_desc.caps, PT_CAP_ptwrite))
+		vmx->pt_desc.ctl_bitmask &= ~(RTIT_CTL_FUP_ON_PTW |
+						RTIT_CTL_PTW_EN);
+
+	/* If CPUID.(EAX=14H,ECX=0):EBX[5]=1 PwrEvEn can be set */
+	if (__pt_cap_get(vmx->pt_desc.caps, PT_CAP_power_event_trace))
+		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_PWR_EVT_EN;
+
+	/* If CPUID.(EAX=14H,ECX=0):ECX[0]=1 ToPA can be set */
+	if (__pt_cap_get(vmx->pt_desc.caps, PT_CAP_topa_output))
+		vmx->pt_desc.ctl_bitmask &= ~RTIT_CTL_TOPA;
+	/* If CPUID.(EAX=14H,ECX=0):ECX[3]=1 FabircEn can be set */
+	if (__pt_cap_get(vmx->pt_desc.caps, PT_CAP_output_subsys))
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
@@ -10389,6 +10454,10 @@ static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
 
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
