Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeECKTo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:19:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:65500 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752307AbeECKTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:19:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="36546571"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        joro@8bytes.org, peterz@infradead.org, chao.p.peng@linux.intel.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v7 11/13] KVM: x86: Implement Intel Processor Trace MSRs read/write
Date: Thu,  3 May 2018 20:13:26 +0800
Message-Id: <1525349608-10352-12-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1525349608-10352-1-git-send-email-luwei.kang@intel.com>
References: <1525349608-10352-1-git-send-email-luwei.kang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Peng <chao.p.peng@linux.intel.com>

Implement Intel Processor Trace MSRs read/write.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/include/asm/intel_pt.h |   8 ++
 arch/x86/kvm/vmx.c              | 163 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c              |  33 +++++++-
 3 files changed, 203 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/intel_pt.h b/arch/x86/include/asm/intel_pt.h
index 43ad260..dc0f3f0 100644
--- a/arch/x86/include/asm/intel_pt.h
+++ b/arch/x86/include/asm/intel_pt.h
@@ -5,6 +5,14 @@
 #define PT_CPUID_LEAVES		2
 #define PT_CPUID_REGS_NUM	4 /* number of regsters (eax, ebx, ecx, edx) */
 
+#define MSR_IA32_RTIT_STATUS_MASK (~(RTIT_STATUS_FILTEREN | \
+		RTIT_STATUS_CONTEXTEN | RTIT_STATUS_TRIGGEREN | \
+		RTIT_STATUS_ERROR | RTIT_STATUS_STOPPED | \
+		RTIT_STATUS_BYTECNT))
+
+#define MSR_IA32_RTIT_OUTPUT_BASE_MASK \
+	(~((1UL << cpuid_query_maxphyaddr(vcpu)) - 1) | 0x7f)
+
 enum pt_mode {
 	PT_MODE_SYSTEM = 0,
 	PT_MODE_HOST,
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 3ed02a8..2a29ab9 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2769,6 +2769,77 @@ static void vmx_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask)
 		vmcs_write32(GUEST_INTERRUPTIBILITY_INFO, interruptibility);
 }
 
+static int vmx_rtit_ctl_check(struct kvm_vcpu *vcpu, u64 data)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	unsigned long value;
+
+	/*
+	 * Any MSR write that attempts to change bits marked reserved will
+	 * case a #GP fault.
+	 */
+	if (data & vmx->pt_desc.ctl_bitmask)
+		return 1;
+
+	/*
+	 * Any attempt to modify IA32_RTIT_CTL while TraceEn is set will
+	 * result in a #GP unless the same write also clears TraceEn.
+	 */
+	if ((vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) &&
+		((vmx->pt_desc.guest.ctl ^ data) & ~RTIT_CTL_TRACEEN))
+		return 1;
+
+	/*
+	 * WRMSR to IA32_RTIT_CTL that sets TraceEn but clears this bit
+	 * and FabricEn would cause #GP, if
+	 * CPUID.(EAX=14H, ECX=0):ECX.SNGLRGNOUT[bit 2] = 0
+	 */
+	if ((data & RTIT_CTL_TRACEEN) && !(data & RTIT_CTL_TOPA) &&
+		!(data & RTIT_CTL_FABRIC_EN) &&
+		!__pt_cap_get(vmx->pt_desc.caps, PT_CAP_single_range_output))
+		return 1;
+
+	/*
+	 * MTCFreq, CycThresh and PSBFreq encodings check, any MSR write that
+	 * utilize encodings marked reserved will casue a #GP fault.
+	 */
+	value = __pt_cap_get(vmx->pt_desc.caps, PT_CAP_mtc_periods);
+	if (__pt_cap_get(vmx->pt_desc.caps, PT_CAP_mtc) &&
+			!test_bit((data & RTIT_CTL_MTC_RANGE) >>
+			RTIT_CTL_MTC_RANGE_OFFSET, &value))
+		return 1;
+	value = __pt_cap_get(vmx->pt_desc.caps, PT_CAP_cycle_thresholds);
+	if (__pt_cap_get(vmx->pt_desc.caps, PT_CAP_psb_cyc) &&
+			!test_bit((data & RTIT_CTL_CYC_THRESH) >>
+			RTIT_CTL_CYC_THRESH_OFFSET, &value))
+		return 1;
+	value = __pt_cap_get(vmx->pt_desc.caps, PT_CAP_psb_periods);
+	if (__pt_cap_get(vmx->pt_desc.caps, PT_CAP_psb_cyc) &&
+			!test_bit((data & RTIT_CTL_PSB_FREQ) >>
+			RTIT_CTL_PSB_FREQ_OFFSET, &value))
+		return 1;
+
+	/*
+	 * If ADDRx_CFG is reserved or the encodings is >2 will
+	 * cause a #GP fault.
+	 */
+	value = (data & RTIT_CTL_ADDR0) >> RTIT_CTL_ADDR0_OFFSET;
+	if ((value && (vmx->pt_desc.range_cnt < 1)) || (value > 2))
+		return 1;
+	value = (data & RTIT_CTL_ADDR1) >> RTIT_CTL_ADDR1_OFFSET;
+	if ((value && (vmx->pt_desc.range_cnt < 2)) || (value > 2))
+		return 1;
+	value = (data & RTIT_CTL_ADDR2) >> RTIT_CTL_ADDR2_OFFSET;
+	if ((value && (vmx->pt_desc.range_cnt < 3)) || (value > 2))
+		return 1;
+	value = (data & RTIT_CTL_ADDR3) >> RTIT_CTL_ADDR3_OFFSET;
+	if ((value && (vmx->pt_desc.range_cnt < 4)) || (value > 2))
+		return 1;
+
+	return 0;
+}
+
+
 static void skip_emulated_instruction(struct kvm_vcpu *vcpu)
 {
 	unsigned long rip;
@@ -3651,6 +3722,48 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		msr_info->data = vcpu->arch.ia32_xss;
 		break;
+	case MSR_IA32_RTIT_CTL:
+		if (pt_mode != PT_MODE_HOST_GUEST)
+			return 1;
+		msr_info->data = vmx->pt_desc.guest.ctl;
+		break;
+	case MSR_IA32_RTIT_STATUS:
+		if (pt_mode != PT_MODE_HOST_GUEST)
+			return 1;
+		msr_info->data = vmx->pt_desc.guest.status;
+		break;
+	case MSR_IA32_RTIT_CR3_MATCH:
+		if ((pt_mode != PT_MODE_HOST_GUEST) ||
+			!__pt_cap_get(vmx->pt_desc.caps, PT_CAP_cr3_filtering))
+			return 1;
+		msr_info->data = vmx->pt_desc.guest.cr3_match;
+		break;
+	case MSR_IA32_RTIT_OUTPUT_BASE:
+		if ((pt_mode != PT_MODE_HOST_GUEST) ||
+			(!__pt_cap_get(vmx->pt_desc.caps, PT_CAP_topa_output) &&
+			 !__pt_cap_get(vmx->pt_desc.caps,
+					PT_CAP_single_range_output)))
+			return 1;
+		msr_info->data = vmx->pt_desc.guest.output_base;
+		break;
+	case MSR_IA32_RTIT_OUTPUT_MASK:
+		if ((pt_mode != PT_MODE_HOST_GUEST) ||
+			(!__pt_cap_get(vmx->pt_desc.caps, PT_CAP_topa_output) &&
+			 !__pt_cap_get(vmx->pt_desc.caps,
+					PT_CAP_single_range_output)))
+			return 1;
+		msr_info->data = vmx->pt_desc.guest.output_mask;
+		break;
+	case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B:
+		if ((pt_mode != PT_MODE_HOST_GUEST) ||
+			(msr_info->index - MSR_IA32_RTIT_ADDR0_A >=
+				2 * __pt_cap_get(vmx->pt_desc.caps,
+					PT_CAP_num_address_ranges)))
+			return 1;
+		msr_info->data =
+			vmx->pt_desc.guest.addrs[msr_info->index -
+						MSR_IA32_RTIT_ADDR0_A];
+		break;
 	case MSR_TSC_AUX:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
@@ -3836,6 +3949,56 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		else
 			clear_atomic_switch_msr(vmx, MSR_IA32_XSS);
 		break;
+	case MSR_IA32_RTIT_CTL:
+		if ((pt_mode != PT_MODE_HOST_GUEST) ||
+			vmx_rtit_ctl_check(vcpu, data))
+			return 1;
+		vmcs_write64(GUEST_IA32_RTIT_CTL, data);
+		vmx->pt_desc.guest.ctl = data;
+		break;
+	case MSR_IA32_RTIT_STATUS:
+		if ((pt_mode != PT_MODE_HOST_GUEST) ||
+			(vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) ||
+			(data & MSR_IA32_RTIT_STATUS_MASK))
+			return 1;
+		vmx->pt_desc.guest.status = data;
+		break;
+	case MSR_IA32_RTIT_CR3_MATCH:
+		if ((pt_mode != PT_MODE_HOST_GUEST) ||
+			(vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) ||
+			!__pt_cap_get(vmx->pt_desc.caps, PT_CAP_cr3_filtering))
+			return 1;
+		vmx->pt_desc.guest.cr3_match = data;
+		break;
+	case MSR_IA32_RTIT_OUTPUT_BASE:
+		if ((pt_mode != PT_MODE_HOST_GUEST) ||
+			(vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) ||
+			(!__pt_cap_get(vmx->pt_desc.caps, PT_CAP_topa_output) &&
+			 !__pt_cap_get(vmx->pt_desc.caps,
+					PT_CAP_single_range_output)) ||
+			(data & MSR_IA32_RTIT_OUTPUT_BASE_MASK))
+			return 1;
+		vmx->pt_desc.guest.output_base = data;
+		break;
+	case MSR_IA32_RTIT_OUTPUT_MASK:
+		if ((pt_mode != PT_MODE_HOST_GUEST) ||
+			(vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) ||
+			(!__pt_cap_get(vmx->pt_desc.caps, PT_CAP_topa_output) &&
+			 !__pt_cap_get(vmx->pt_desc.caps,
+					PT_CAP_single_range_output)))
+			return 1;
+		vmx->pt_desc.guest.output_mask = data;
+		break;
+	case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B:
+		if ((pt_mode != PT_MODE_HOST_GUEST) ||
+			(vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) ||
+			(msr_info->index - MSR_IA32_RTIT_ADDR0_A >=
+				2 * __pt_cap_get(vmx->pt_desc.caps,
+					PT_CAP_num_address_ranges)))
+			return 1;
+		vmx->pt_desc.guest.addrs[msr_info->index -
+				MSR_IA32_RTIT_ADDR0_A] = data;
+		break;
 	case MSR_TSC_AUX:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 51ecd38..cea0ee2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -69,6 +69,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/mshyperv.h>
 #include <asm/hypervisor.h>
+#include <asm/intel_pt.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -1023,7 +1024,13 @@ bool kvm_rdpmc(struct kvm_vcpu *vcpu)
 #endif
 	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
 	MSR_IA32_FEATURE_CONTROL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
-	MSR_IA32_SPEC_CTRL, MSR_IA32_ARCH_CAPABILITIES
+	MSR_IA32_SPEC_CTRL, MSR_IA32_ARCH_CAPABILITIES,
+	MSR_IA32_RTIT_CTL, MSR_IA32_RTIT_STATUS, MSR_IA32_RTIT_CR3_MATCH,
+	MSR_IA32_RTIT_OUTPUT_BASE, MSR_IA32_RTIT_OUTPUT_MASK,
+	MSR_IA32_RTIT_ADDR0_A, MSR_IA32_RTIT_ADDR0_B,
+	MSR_IA32_RTIT_ADDR1_A, MSR_IA32_RTIT_ADDR1_B,
+	MSR_IA32_RTIT_ADDR2_A, MSR_IA32_RTIT_ADDR2_B,
+	MSR_IA32_RTIT_ADDR3_A, MSR_IA32_RTIT_ADDR3_B,
 };
 
 static unsigned num_msrs_to_save;
@@ -4592,6 +4599,30 @@ static void kvm_init_msr_list(void)
 			if (!kvm_x86_ops->rdtscp_supported())
 				continue;
 			break;
+		case MSR_IA32_RTIT_CTL:
+		case MSR_IA32_RTIT_STATUS:
+			if (!kvm_x86_ops->pt_supported())
+				continue;
+			break;
+		case MSR_IA32_RTIT_CR3_MATCH:
+			if (!kvm_x86_ops->pt_supported() ||
+					!pt_cap_get(PT_CAP_cr3_filtering))
+				continue;
+			break;
+		case MSR_IA32_RTIT_OUTPUT_BASE:
+		case MSR_IA32_RTIT_OUTPUT_MASK:
+			if (!kvm_x86_ops->pt_supported() ||
+				(!pt_cap_get(PT_CAP_topa_output) &&
+				 !pt_cap_get(PT_CAP_single_range_output)))
+				continue;
+			break;
+		case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B: {
+			if (!kvm_x86_ops->pt_supported() ||
+				msrs_to_save[i] - MSR_IA32_RTIT_ADDR0_A >=
+				2 * pt_cap_get(PT_CAP_num_address_ranges))
+				continue;
+			break;
+		}
 		default:
 			break;
 		}
-- 
1.8.3.1
