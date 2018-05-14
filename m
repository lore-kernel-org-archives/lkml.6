Return-Path: <luwei.kang@intel.com>
X-Google-Smtp-Source: AB8JxZr232gy/I3oOnXGTwDBvPpwWZg+dOdBIzwUCiNB8gaXPFn/hFnYhVnUJWC7+4udmHBu4OLD
ARC-Seal: i=1; a=rsa-sha256; t=1526288619; cv=none;
        d=google.com; s=arc-20160816;
        b=OeOofiticTo9yfXybpMIx4m/xlwM2qOoeD72Ry/K5KpJc/oN+aV3gg9gx6KWjEe5uh
         SGf4LoxxmU8/fyfYtE3EqM+TToqkr+eO9DFESdpT2BtMS6QDg1u7jXC36Pga8dOT9Maq
         +04GwnEgm0hSLMOEZvWzi+DGe3z93BKu3UutxH44AYXMMv0RFIysDQ90FNeKUIL3tK/U
         Dak+tiViMWjDnTclTPbR+lj9DfxKjVpP/vCfjGVvSi176SvbX0FcBONMtK6e+dEoi9hz
         HwyXHtQsEpCuI5qo2wa+Tc2MioeZJ7YwfchR4qMSBocSrMis4dxjwdxoQ5Vrqutti5UM
         JrdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=SIHHqZZjb4vc5dAz7dX2199F1dvw6nwKP3S3Ozq+RTc=;
        b=ry5DORp5CU2guB6H9z7UCyXlqiT7sAEE1nIiwyGPBHg8M7AliVCF7JUGIUFKD6AXNr
         YXHZUBTVl5ywpZXCqi10tTSYdFo8cGp9fQMdZa5GXPbcd6tOV3U252kaaW6iSF8z2hEl
         5jX5mA3SaXEFNUfxOI3rkXCNwhJY5lV0eUIjeRf77XQ3wk0HbDMCpIXGI3J4bOR74/oz
         CR56ATyTBN1UVx22Ry7lAwPj7UREAQx8Igz1pM8SGnnMhZM5tQVpqtu1KbbnLLiH4m78
         VWBW6jID5NlBYodUc7aCXHHC+w9QJB8HJEBmJRKQv9F7nItQKxOg5QnAUMDYtBU+hJJH
         CFxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=luwei.kang@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=luwei.kang@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="39701972"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	hpa@zytor.com,
	x86@kernel.org,
	chao.p.peng@linux.intel.com,
	thomas.lendacky@amd.com,
	bp@suse.de,
	Kan.liang@intel.com,
	Janakarajan.Natarajan@amd.com,
	dwmw@amazon.co.uk,
	linux-kernel@vger.kernel.org,
	alexander.shishkin@linux.intel.com,
	peterz@infradead.org,
	mathieu.poirier@linaro.org,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	pbonzini@redhat.com,
	rkrcmar@redhat.com,
	david@redhat.com,
	bsd@redhat.com,
	yu.c.zhang@linux.intel.com,
	joro@8bytes.org,
	Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v8 10/12] KVM: x86: Implement Intel Processor Trace MSRs read/write emulation
Date: Mon, 14 May 2018 18:57:10 +0800
Message-Id: <1526295432-20640-11-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526295432-20640-1-git-send-email-luwei.kang@intel.com>
References: <1526295432-20640-1-git-send-email-luwei.kang@intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600429615559765453?=
X-GMAIL-MSGID: =?utf-8?q?1600429615559765453?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chao Peng <chao.p.peng@linux.intel.com>

This patch implement Intel Processor Trace MSRs read/write
emulation.
Intel PT MSRs read/write need to be emulated when Intel PT
MSRs is intercepted in guest and during live migration.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/include/asm/intel_pt.h |   8 ++
 arch/x86/kvm/vmx.c              | 172 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c              |  33 +++++++-
 3 files changed, 212 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/intel_pt.h b/arch/x86/include/asm/intel_pt.h
index 5748205..3da4cdb 100644
--- a/arch/x86/include/asm/intel_pt.h
+++ b/arch/x86/include/asm/intel_pt.h
@@ -8,6 +8,14 @@
 #define PT_MODE_SYSTEM		0
 #define PT_MODE_HOST_GUEST	1
 
+#define MSR_IA32_RTIT_STATUS_MASK (~(RTIT_STATUS_FILTEREN | \
+		RTIT_STATUS_CONTEXTEN | RTIT_STATUS_TRIGGEREN | \
+		RTIT_STATUS_ERROR | RTIT_STATUS_STOPPED | \
+		RTIT_STATUS_BYTECNT))
+
+#define MSR_IA32_RTIT_OUTPUT_BASE_MASK \
+		(~((1UL << cpuid_query_maxphyaddr(vcpu)) - 1) | 0x7f)
+
 enum pt_capabilities {
 	PT_CAP_max_subleaf = 0,
 	PT_CAP_cr3_filtering,
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 5c321cd..d04b235 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2808,6 +2808,77 @@ static void vmx_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask)
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
+		!pt_cap_decode(vmx->pt_desc.caps, PT_CAP_single_range_output))
+		return 1;
+
+	/*
+	 * MTCFreq, CycThresh and PSBFreq encodings check, any MSR write that
+	 * utilize encodings marked reserved will casue a #GP fault.
+	 */
+	value = pt_cap_decode(vmx->pt_desc.caps, PT_CAP_mtc_periods);
+	if (pt_cap_decode(vmx->pt_desc.caps, PT_CAP_mtc) &&
+			!test_bit((data & RTIT_CTL_MTC_RANGE) >>
+			RTIT_CTL_MTC_RANGE_OFFSET, &value))
+		return 1;
+	value = pt_cap_decode(vmx->pt_desc.caps, PT_CAP_cycle_thresholds);
+	if (pt_cap_decode(vmx->pt_desc.caps, PT_CAP_psb_cyc) &&
+			!test_bit((data & RTIT_CTL_CYC_THRESH) >>
+			RTIT_CTL_CYC_THRESH_OFFSET, &value))
+		return 1;
+	value = pt_cap_decode(vmx->pt_desc.caps, PT_CAP_psb_periods);
+	if (pt_cap_decode(vmx->pt_desc.caps, PT_CAP_psb_cyc) &&
+			!test_bit((data & RTIT_CTL_PSB_FREQ) >>
+			RTIT_CTL_PSB_FREQ_OFFSET, &value))
+		return 1;
+
+	/*
+	 * If ADDRx_CFG is reserved or the encodings is >2 will
+	 * cause a #GP fault.
+	 */
+	value = (data & RTIT_CTL_ADDR0) >> RTIT_CTL_ADDR0_OFFSET;
+	if ((value && (vmx->pt_desc.addr_range < 1)) || (value > 2))
+		return 1;
+	value = (data & RTIT_CTL_ADDR1) >> RTIT_CTL_ADDR1_OFFSET;
+	if ((value && (vmx->pt_desc.addr_range < 2)) || (value > 2))
+		return 1;
+	value = (data & RTIT_CTL_ADDR2) >> RTIT_CTL_ADDR2_OFFSET;
+	if ((value && (vmx->pt_desc.addr_range < 3)) || (value > 2))
+		return 1;
+	value = (data & RTIT_CTL_ADDR3) >> RTIT_CTL_ADDR3_OFFSET;
+	if ((value && (vmx->pt_desc.addr_range < 4)) || (value > 2))
+		return 1;
+
+	return 0;
+}
+
+
 static void skip_emulated_instruction(struct kvm_vcpu *vcpu)
 {
 	unsigned long rip;
@@ -3624,6 +3695,7 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct shared_msr_entry *msr;
+	u32 index;
 
 	switch (msr_info->index) {
 #ifdef CONFIG_X86_64
@@ -3690,6 +3762,51 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
+			!pt_cap_decode(vmx->pt_desc.caps, PT_CAP_cr3_filtering))
+			return 1;
+		msr_info->data = vmx->pt_desc.guest.cr3_match;
+		break;
+	case MSR_IA32_RTIT_OUTPUT_BASE:
+		if ((pt_mode != PT_MODE_HOST_GUEST) ||
+			(!pt_cap_decode(vmx->pt_desc.caps,
+					PT_CAP_topa_output) &&
+			 !pt_cap_decode(vmx->pt_desc.caps,
+					PT_CAP_single_range_output)))
+			return 1;
+		msr_info->data = vmx->pt_desc.guest.output_base;
+		break;
+	case MSR_IA32_RTIT_OUTPUT_MASK:
+		if ((pt_mode != PT_MODE_HOST_GUEST) ||
+			(!pt_cap_decode(vmx->pt_desc.caps,
+					PT_CAP_topa_output) &&
+			 !pt_cap_decode(vmx->pt_desc.caps,
+					PT_CAP_single_range_output)))
+			return 1;
+		msr_info->data = vmx->pt_desc.guest.output_mask;
+		break;
+	case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B:
+		index = msr_info->index - MSR_IA32_RTIT_ADDR0_A;
+		if ((pt_mode != PT_MODE_HOST_GUEST) ||
+			(index >= 2 * pt_cap_decode(vmx->pt_desc.caps,
+					PT_CAP_num_address_ranges)))
+			return 1;
+		if (index % 2)
+			msr_info->data = vmx->pt_desc.guest.addr_b[index / 2];
+		else
+			msr_info->data = vmx->pt_desc.guest.addr_a[index / 2];
+		break;
 	case MSR_TSC_AUX:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
@@ -3721,6 +3838,7 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	int ret = 0;
 	u32 msr_index = msr_info->index;
 	u64 data = msr_info->data;
+	u32 index;
 
 	switch (msr_index) {
 	case MSR_EFER:
@@ -3875,6 +3993,60 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
+			!pt_cap_decode(vmx->pt_desc.caps, PT_CAP_cr3_filtering))
+			return 1;
+		vmx->pt_desc.guest.cr3_match = data;
+		break;
+	case MSR_IA32_RTIT_OUTPUT_BASE:
+		if ((pt_mode != PT_MODE_HOST_GUEST) ||
+			(vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) ||
+			(!pt_cap_decode(vmx->pt_desc.caps,
+					PT_CAP_topa_output) &&
+			 !pt_cap_decode(vmx->pt_desc.caps,
+					PT_CAP_single_range_output)) ||
+			(data & MSR_IA32_RTIT_OUTPUT_BASE_MASK))
+			return 1;
+		vmx->pt_desc.guest.output_base = data;
+		break;
+	case MSR_IA32_RTIT_OUTPUT_MASK:
+		if ((pt_mode != PT_MODE_HOST_GUEST) ||
+			(vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) ||
+			(!pt_cap_decode(vmx->pt_desc.caps,
+					PT_CAP_topa_output) &&
+			 !pt_cap_decode(vmx->pt_desc.caps,
+					PT_CAP_single_range_output)))
+			return 1;
+		vmx->pt_desc.guest.output_mask = data;
+		break;
+	case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B:
+		index = msr_info->index - MSR_IA32_RTIT_ADDR0_A;
+		if ((pt_mode != PT_MODE_HOST_GUEST) ||
+			(vmx->pt_desc.guest.ctl & RTIT_CTL_TRACEEN) ||
+			(index >= 2 * pt_cap_decode(vmx->pt_desc.caps,
+					PT_CAP_num_address_ranges)))
+			return 1;
+		if (index % 2)
+			vmx->pt_desc.guest.addr_b[index / 2] = data;
+		else
+			vmx->pt_desc.guest.addr_a[index / 2] = data;
+		break;
 	case MSR_TSC_AUX:
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 87e4805..583a7b9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -69,6 +69,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/mshyperv.h>
 #include <asm/hypervisor.h>
+#include <asm/intel_pt.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -1033,7 +1034,13 @@ bool kvm_rdpmc(struct kvm_vcpu *vcpu)
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
@@ -4602,6 +4609,30 @@ static void kvm_init_msr_list(void)
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
