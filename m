Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DAAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254F921934
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 01:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbfBOBtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 20:49:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:4355 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727639AbfBOBtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 20:49:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 17:49:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,371,1544515200"; 
   d="scan'208";a="147010929"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.239.196.87]) ([10.239.196.87])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2019 17:49:38 -0800
Subject: Re: [PATCH v5 10/12] KVM/x86/lbr: lazy save the guest lbr stack
To:     Wei Wang <wei.w.wang@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, pbonzini@redhat.com, ak@linux.intel.com,
        peterz@infradead.org
Cc:     kan.liang@intel.com, mingo@redhat.com, rkrcmar@redhat.com,
        like.xu@intel.com, jannh@google.com, arei.gonglei@huawei.com,
        jmattson@google.com
References: <1550135174-5423-1-git-send-email-wei.w.wang@intel.com>
 <1550135174-5423-11-git-send-email-wei.w.wang@intel.com>
From:   Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <fbf4e2ad-93f9-bb19-81f4-3b9d0b99cca8@linux.intel.com>
Date:   Fri, 15 Feb 2019 09:49:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1550135174-5423-11-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/14 17:06, Wei Wang wrote:
> When the vCPU is scheduled in:
> - if the lbr feature was used in the last vCPU time slice, set the lbr
>    stack to be interceptible, so that the host can capture whether the
>    lbr feature will be used in this time slice;
> - if the lbr feature wasn't used in the last vCPU time slice, disable
>    the vCPU support of the guest lbr switching.
> 
> Upon the first access to one of the lbr related MSRs (since the vCPU was
> scheduled in):
> - record that the guest has used the lbr;
> - create a host perf event to help save/restore the guest lbr stack;

Based on commit "15ad71460" and guest-use-lbr-only usage,
is this possible to create none of host perf event for vcpu
and simply reuse __intel_pmu_lbr_save/restore
in intel_pmu_sched_out/in and keep the lbr_stack sync with 
kvm_pmu->lbr_stack rather than task_ctx of perf_event ?

> - pass the stack through to the guest.
> 
> Suggested-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>   arch/x86/include/asm/kvm_host.h |   2 +
>   arch/x86/kvm/pmu.c              |   6 ++
>   arch/x86/kvm/pmu.h              |   2 +
>   arch/x86/kvm/vmx/pmu_intel.c    | 146 ++++++++++++++++++++++++++++++++++++++++
>   arch/x86/kvm/vmx/vmx.c          |   4 +-
>   arch/x86/kvm/vmx/vmx.h          |   2 +
>   arch/x86/kvm/x86.c              |   2 +
>   7 files changed, 162 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 2b75c63..22b56d3 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -469,6 +469,8 @@ struct kvm_pmu {
>   	u64 counter_bitmask[2];
>   	u64 global_ctrl_mask;
>   	u64 reserved_bits;
> +	/* Indicate if the lbr msrs were accessed in this vCPU time slice */
> +	bool lbr_used;
>   	u8 version;
>   	struct kvm_pmc gp_counters[INTEL_PMC_MAX_GENERIC];
>   	struct kvm_pmc fixed_counters[INTEL_PMC_MAX_FIXED];
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 57e0df3..51e8cb8 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -328,6 +328,12 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   	return kvm_x86_ops->pmu_ops->set_msr(vcpu, msr_info);
>   }
>   
> +void kvm_pmu_sched_in(struct kvm_vcpu *vcpu, int cpu)
> +{
> +	if (kvm_x86_ops->pmu_ops->sched_in)
> +		kvm_x86_ops->pmu_ops->sched_in(vcpu, cpu);
> +}
> +
>   /* refresh PMU settings. This function generally is called when underlying
>    * settings are changed (such as changes of PMU CPUID by guest VMs), which
>    * should rarely happen.
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 009be7a..34fb5bf 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -31,6 +31,7 @@ struct kvm_pmu_ops {
>   	bool (*lbr_enable)(struct kvm_vcpu *vcpu);
>   	int (*get_msr)(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
>   	int (*set_msr)(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
> +	void (*sched_in)(struct kvm_vcpu *vcpu, int cpu);
>   	void (*refresh)(struct kvm_vcpu *vcpu);
>   	void (*init)(struct kvm_vcpu *vcpu);
>   	void (*reset)(struct kvm_vcpu *vcpu);
> @@ -115,6 +116,7 @@ int kvm_pmu_is_valid_msr_idx(struct kvm_vcpu *vcpu, unsigned idx);
>   bool kvm_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr);
>   int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
>   int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
> +void kvm_pmu_sched_in(struct kvm_vcpu *vcpu, int cpu);
>   void kvm_pmu_refresh(struct kvm_vcpu *vcpu);
>   void kvm_pmu_reset(struct kvm_vcpu *vcpu);
>   void kvm_pmu_init(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index b00f094..bf40941 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -16,10 +16,12 @@
>   #include <linux/perf_event.h>
>   #include <asm/perf_event.h>
>   #include <asm/intel-family.h>
> +#include <asm/vmx.h>
>   #include "x86.h"
>   #include "cpuid.h"
>   #include "lapic.h"
>   #include "pmu.h"
> +#include "vmx.h"
>   
>   static struct kvm_event_hw_type_mapping intel_arch_events[] = {
>   	/* Index must match CPUID 0x0A.EBX bit vector */
> @@ -143,6 +145,17 @@ static struct kvm_pmc *intel_msr_idx_to_pmc(struct kvm_vcpu *vcpu,
>   	return &counters[idx];
>   }
>   
> +static inline bool msr_is_lbr_stack(struct kvm_vcpu *vcpu, u32 index)
> +{
> +	struct x86_perf_lbr_stack *stack = &vcpu->kvm->arch.lbr_stack;
> +	int nr = stack->nr;
> +
> +	return !!(index == stack->tos ||
> +		 (index >= stack->from && index < stack->from + nr) ||
> +		 (index >= stack->to && index < stack->to + nr) ||
> +		 (index >= stack->info && index < stack->info));
> +}
> +
>   static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>   {
>   	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> @@ -154,9 +167,13 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>   	case MSR_CORE_PERF_GLOBAL_CTRL:
>   	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
>   	case MSR_IA32_PERF_CAPABILITIES:
> +	case MSR_IA32_DEBUGCTLMSR:
> +	case MSR_LBR_SELECT:
>   		ret = pmu->version > 1;
>   		break;
>   	default:
> +		if (msr_is_lbr_stack(vcpu, msr))
> +			return pmu->version > 1;
>   		ret = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0) ||
>   			get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0) ||
>   			get_fixed_pmc(pmu, msr);
> @@ -300,6 +317,109 @@ static bool intel_pmu_lbr_enable(struct kvm_vcpu *vcpu)
>   	return true;
>   }
>   
> +static void intel_pmu_set_intercept_for_lbr_msrs(struct kvm_vcpu *vcpu,
> +						 bool set)
> +{
> +	unsigned long *msr_bitmap = to_vmx(vcpu)->vmcs01.msr_bitmap;
> +	struct x86_perf_lbr_stack *stack = &vcpu->kvm->arch.lbr_stack;
> +	int nr = stack->nr;
> +	int i;
> +
> +	vmx_set_intercept_for_msr(msr_bitmap, stack->tos, MSR_TYPE_RW, set);
> +	for (i = 0; i < nr; i++) {
> +		vmx_set_intercept_for_msr(msr_bitmap, stack->from + i,
> +					  MSR_TYPE_RW, set);
> +		vmx_set_intercept_for_msr(msr_bitmap, stack->to + i,
> +					  MSR_TYPE_RW, set);
> +		if (stack->info)
> +			vmx_set_intercept_for_msr(msr_bitmap, stack->info + i,
> +						  MSR_TYPE_RW, set);
> +	}
> +}
> +
> +static bool intel_pmu_get_lbr_msr(struct kvm_vcpu *vcpu,
> +			      struct msr_data *msr_info)
> +{
> +	u32 index = msr_info->index;
> +	bool ret = false;
> +
> +	switch (index) {
> +	case MSR_IA32_DEBUGCTLMSR:
> +		msr_info->data = vmcs_read64(GUEST_IA32_DEBUGCTL);
> +		ret = true;
> +		break;
> +	case MSR_LBR_SELECT:
> +		ret = true;
> +		rdmsrl(index, msr_info->data);
> +		break;
> +	default:
> +		if (msr_is_lbr_stack(vcpu, index)) {
> +			ret = true;
> +			rdmsrl(index, msr_info->data);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static bool intel_pmu_set_lbr_msr(struct kvm_vcpu *vcpu,
> +				  struct msr_data *msr_info)
> +{
> +	u32 index = msr_info->index;
> +	u64 data = msr_info->data;
> +	bool ret = false;
> +
> +	switch (index) {
> +	case MSR_IA32_DEBUGCTLMSR:
> +		ret = true;
> +		/*
> +		 * Currently, only FREEZE_LBRS_ON_PMI and DEBUGCTLMSR_LBR are
> +		 * supported.
> +		 */
> +		data &= (DEBUGCTLMSR_FREEZE_LBRS_ON_PMI | DEBUGCTLMSR_LBR);
> +		vmcs_write64(GUEST_IA32_DEBUGCTL, data);
> +		break;
> +	case MSR_LBR_SELECT:
> +		ret = true;
> +		wrmsrl(index, data);
> +		break;
> +	default:
> +		if (msr_is_lbr_stack(vcpu, index)) {
> +			ret = true;
> +			wrmsrl(index, data);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static bool intel_pmu_access_lbr_msr(struct kvm_vcpu *vcpu,
> +				 struct msr_data *msr_info,
> +				 bool set)
> +{
> +	bool ret = false;
> +
> +	/*
> +	 * Some userspace implementations (e.g. QEMU) expects the msrs to be
> +	 * always accesible.
> +	 */
> +	if (!msr_info->host_initiated && !vcpu->kvm->arch.lbr_in_guest)
> +		return false;
> +
> +	if (set)
> +		ret = intel_pmu_set_lbr_msr(vcpu, msr_info);
> +	else
> +		ret = intel_pmu_get_lbr_msr(vcpu, msr_info);
> +
> +	if (ret && !vcpu->arch.pmu.lbr_used) {
> +		vcpu->arch.pmu.lbr_used = true;
> +		intel_pmu_set_intercept_for_lbr_msrs(vcpu, false);
> +		intel_pmu_enable_save_guest_lbr(vcpu);
> +	}
> +
> +	return ret;
> +}
> +
>   static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   {
>   	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> @@ -340,6 +460,8 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   		} else if ((pmc = get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0))) {
>   			msr_info->data = pmc->eventsel;
>   			return 0;
> +		} else if (intel_pmu_access_lbr_msr(vcpu, msr_info, false)) {
> +			return 0;
>   		}
>   	}
>   
> @@ -400,12 +522,33 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   				reprogram_gp_counter(pmc, data);
>   				return 0;
>   			}
> +		} else if (intel_pmu_access_lbr_msr(vcpu, msr_info, true)) {
> +			return 0;
>   		}
>   	}
>   
>   	return 1;
>   }
>   
> +static void intel_pmu_sched_in(struct kvm_vcpu *vcpu, int cpu)
> +{
> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +	u64 guest_debugctl;
> +
> +	if (pmu->lbr_used) {
> +		pmu->lbr_used = false;
> +		intel_pmu_set_intercept_for_lbr_msrs(vcpu, true);
> +	} else if (pmu->vcpu_lbr_event) {
> +		/*
> +		 * The lbr feature wasn't used during that last vCPU time
> +		 * slice, so it's time to disable the vCPU side save/restore.
> +		 */
> +		guest_debugctl = vmcs_read64(GUEST_IA32_DEBUGCTL);
> +		if (!(guest_debugctl & DEBUGCTLMSR_LBR))
> +			intel_pmu_disable_save_guest_lbr(vcpu);
> +	}
> +}
> +
>   static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>   {
>   	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> @@ -492,6 +635,8 @@ static void intel_pmu_reset(struct kvm_vcpu *vcpu)
>   
>   	pmu->fixed_ctr_ctrl = pmu->global_ctrl = pmu->global_status =
>   		pmu->global_ovf_ctrl = 0;
> +
> +	intel_pmu_disable_save_guest_lbr(vcpu);
>   }
>   
>   int intel_pmu_enable_save_guest_lbr(struct kvm_vcpu *vcpu)
> @@ -571,6 +716,7 @@ struct kvm_pmu_ops intel_pmu_ops = {
>   	.lbr_enable = intel_pmu_lbr_enable,
>   	.get_msr = intel_pmu_get_msr,
>   	.set_msr = intel_pmu_set_msr,
> +	.sched_in = intel_pmu_sched_in,
>   	.refresh = intel_pmu_refresh,
>   	.init = intel_pmu_init,
>   	.reset = intel_pmu_reset,
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 4341175..dabf6ca 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -3526,8 +3526,8 @@ static __always_inline void vmx_enable_intercept_for_msr(unsigned long *msr_bitm
>   	}
>   }
>   
> -static __always_inline void vmx_set_intercept_for_msr(unsigned long *msr_bitmap,
> -			     			      u32 msr, int type, bool value)
> +void vmx_set_intercept_for_msr(unsigned long *msr_bitmap, u32 msr, int type,
> +			       bool value)
>   {
>   	if (value)
>   		vmx_enable_intercept_for_msr(msr_bitmap, msr, type);
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 9932895..f4b904e 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -314,6 +314,8 @@ void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu);
>   bool vmx_get_nmi_mask(struct kvm_vcpu *vcpu);
>   void vmx_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked);
>   void vmx_set_virtual_apic_mode(struct kvm_vcpu *vcpu);
> +void vmx_set_intercept_for_msr(unsigned long *msr_bitmap, u32 msr, int type,
> +			       bool value);
>   struct shared_msr_entry *find_msr_entry(struct vcpu_vmx *vmx, u32 msr);
>   void pt_update_intercept_for_msr(struct vcpu_vmx *vmx);
>   
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c8f32e7..8e663c1 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9101,6 +9101,8 @@ void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu)
>   void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu)
>   {
>   	vcpu->arch.l1tf_flush_l1d = true;
> +
> +	kvm_pmu_sched_in(vcpu, cpu);
>   	kvm_x86_ops->sched_in(vcpu, cpu);
>   }
>   
> 

