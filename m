Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAB9ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7392088F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7392088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbeIRG3I convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:29:08 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:6039 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726987AbeIRG3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:29:08 -0400
Received: from DGGEML403-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id CB7674873A3D1;
        Tue, 18 Sep 2018 08:59:07 +0800 (CST)
Received: from DGGEML422-HUB.china.huawei.com (10.1.199.39) by
 DGGEML403-HUB.china.huawei.com (10.3.17.33) with Microsoft SMTP Server (TLS)
 id 14.3.399.0; Tue, 18 Sep 2018 08:58:53 +0800
Received: from DGGEML511-MBX.china.huawei.com ([169.254.1.77]) by
 dggeml422-hub.china.huawei.com ([10.1.199.39]) with mapi id 14.03.0399.000;
 Tue, 18 Sep 2018 08:58:48 +0800
From:   "Gonglei (Arei)" <arei.gonglei@huawei.com>
To:     Wei Wang <wei.w.wang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>
CC:     "kan.liang@intel.com" <kan.liang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "like.xu@intel.com" <like.xu@intel.com>
Subject: RE: [PATCH v2 7/8] KVM: PMU: support to save/restore the guest lbr
 stack on vCPU switching
Thread-Topic: [PATCH v2 7/8] KVM: PMU: support to save/restore the guest lbr
 stack on vCPU switching
Thread-Index: AQHURdllAmT0QJhl2U6encrmkRxO26T1SRnA
Date:   Tue, 18 Sep 2018 00:58:48 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DB0F1D5F@dggeml511-mbx.china.huawei.com>
References: <1536233456-12173-1-git-send-email-wei.w.wang@intel.com>
 <1536233456-12173-8-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1536233456-12173-8-git-send-email-wei.w.wang@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.18.62]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: kvm-owner@vger.kernel.org [mailto:kvm-owner@vger.kernel.org] On
> Behalf Of Wei Wang
> Sent: Thursday, September 06, 2018 7:31 PM
> To: linux-kernel@vger.kernel.org; kvm@vger.kernel.org; pbonzini@redhat.com;
> ak@linux.intel.com
> Cc: kan.liang@intel.com; peterz@infradead.org; mingo@redhat.com;
> rkrcmar@redhat.com; like.xu@intel.com; wei.w.wang@intel.com
> Subject: [PATCH v2 7/8] KVM: PMU: support to save/restore the guest lbr stack
> on vCPU switching
> 
> From: Like Xu <like.xu@intel.com>
> 
> This patch adds support to KVM to save/restore the lbr stack on vCPU
> context switching.
> 
> When the guest sets the ACTIVE bit of MSR_KVM_PV_LBR_CTRL, a perf event
> is created on the host for the related vCPU. This perf event ensures the
> LBR stack to be saved/restored when the vCPU thread is scheduled out/in.
> The perf event is removed and freed when the guest clears the ACTIVE
> bit.
> 

What about live migration? Does LBR stack need to be saved on the source side and
restored on the dest side with the passthrough mode?

Thanks,
-Gonglei

> Signed-off-by: Like Xu <like.xu@intel.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  2 ++
>  arch/x86/kvm/cpuid.c            |  3 +-
>  arch/x86/kvm/pmu_intel.c        | 71
> ++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 74 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h
> b/arch/x86/include/asm/kvm_host.h
> index 5db5ba3..cfbe90f 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -432,6 +432,8 @@ struct kvm_pmu {
>  	struct kvm_pmc fixed_counters[INTEL_PMC_MAX_FIXED];
>  	struct irq_work irq_work;
>  	u64 reprogram_pmi;
> +	u64 kvm_pv_lbr_ctrl;
> +	struct perf_event *guest_lbr_event;
>  };
> 
>  struct kvm_pmu_ops;
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 3b8a57b..8550eee 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -622,7 +622,8 @@ static inline int __do_cpuid_ent(struct
> kvm_cpuid_entry2 *entry, u32 function,
>  			     (1 << KVM_FEATURE_PV_UNHALT) |
>  			     (1 << KVM_FEATURE_PV_TLB_FLUSH) |
>  			     (1 << KVM_FEATURE_ASYNC_PF_VMEXIT) |
> -			     (1 << KVM_FEATURE_PV_SEND_IPI);
> +			     (1 << KVM_FEATURE_PV_SEND_IPI) |
> +			     (1 << KVM_FEATURE_PV_LBR_CTRL);
> 
>  		if (sched_info_on())
>  			entry->eax |= (1 << KVM_FEATURE_STEAL_TIME);
> diff --git a/arch/x86/kvm/pmu_intel.c b/arch/x86/kvm/pmu_intel.c
> index 5ab4a36..27c028d 100644
> --- a/arch/x86/kvm/pmu_intel.c
> +++ b/arch/x86/kvm/pmu_intel.c
> @@ -67,6 +67,62 @@ static void global_ctrl_changed(struct kvm_pmu *pmu,
> u64 data)
>  		reprogram_counter(pmu, bit);
>  }
> 
> +static void guest_lbr_event_create(struct kvm_pmu *pmu)
> +{
> +	struct perf_event *event;
> +	struct perf_event_attr attr = {
> +		.type = PERF_TYPE_RAW,
> +		.size = sizeof(attr),
> +		.pinned = true,
> +		.exclude_host = true,
> +		.sample_type = PERF_SAMPLE_BRANCH_STACK,
> +		.branch_sample_type = PERF_SAMPLE_BRANCH_CALL_STACK |
> +				      PERF_SAMPLE_BRANCH_USER |
> +				      PERF_SAMPLE_BRANCH_KERNEL,
> +	};
> +
> +	if (unlikely(pmu->guest_lbr_event)) {
> +		pr_err("%s: guest_lbr_event already created\n", __func__);
> +		return;
> +	}
> +
> +	event = perf_event_create_kernel_counter(&attr, -1, current, NULL,
> +						 NULL);
> +	if (IS_ERR(event)) {
> +		pr_err("%s: failed %ld\n", __func__, PTR_ERR(event));
> +		return;
> +	}
> +	pmu->guest_lbr_event = event;
> +}
> +
> +void guest_lbr_event_release(struct kvm_pmu *pmu)
> +{
> +	struct perf_event *event = pmu->guest_lbr_event;
> +
> +	if (unlikely(!pmu->guest_lbr_event)) {
> +		pr_err("%s: guest_lbr_event already freed\n", __func__);
> +		return;
> +	}
> +
> +	if (event) {
> +		event->pmu->stop(event, PERF_EF_UPDATE);
> +		perf_event_release_kernel(event);
> +	}
> +	pmu->guest_lbr_event = NULL;
> +}
> +
> +static void kvm_pv_lbr_ctrl_changed(struct kvm_pmu *pmu, u64 data)
> +{
> +	bool guest_lbr_active = data & KVM_PV_LBR_CTRL_ACTIVE;
> +
> +	if (guest_lbr_active)
> +		guest_lbr_event_create(pmu);
> +	else
> +		guest_lbr_event_release(pmu);
> +
> +	pmu->kvm_pv_lbr_ctrl = data;
> +}
> +
>  static unsigned intel_find_arch_event(struct kvm_pmu *pmu,
>  				      u8 event_select,
>  				      u8 unit_mask)
> @@ -145,7 +201,7 @@ static struct kvm_pmc *intel_msr_idx_to_pmc(struct
> kvm_vcpu *vcpu,
>  static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> -	int ret;
> +	int ret = 0;
> 
>  	switch (msr) {
>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
> @@ -154,6 +210,10 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu,
> u32 msr)
>  	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
>  		ret = pmu->version > 1;
>  		break;
> +	case MSR_KVM_PV_LBR_CTRL:
> +		if (vcpu->kvm->arch.guest_lbr)
> +			ret = 1;
> +		break;
>  	default:
>  		ret = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0) ||
>  			get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0) ||
> @@ -182,6 +242,9 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu,
> u32 msr, u64 *data)
>  	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
>  		*data = pmu->global_ovf_ctrl;
>  		return 0;
> +	case MSR_KVM_PV_LBR_CTRL:
> +		*data = pmu->kvm_pv_lbr_ctrl;
> +		return 0;
>  	default:
>  		if ((pmc = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0)) ||
>  		    (pmc = get_fixed_pmc(pmu, msr))) {
> @@ -234,6 +297,11 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu,
> struct msr_data *msr_info)
>  			return 0;
>  		}
>  		break;
> +	case MSR_KVM_PV_LBR_CTRL:
> +		if (pmu->kvm_pv_lbr_ctrl == data)
> +			return 0;
> +		kvm_pv_lbr_ctrl_changed(pmu, data);
> +		return 0;
>  	default:
>  		if ((pmc = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0)) ||
>  		    (pmc = get_fixed_pmc(pmu, msr))) {
> @@ -340,6 +408,7 @@ static void intel_pmu_reset(struct kvm_vcpu *vcpu)
> 
>  	pmu->fixed_ctr_ctrl = pmu->global_ctrl = pmu->global_status =
>  		pmu->global_ovf_ctrl = 0;
> +	pmu->kvm_pv_lbr_ctrl = 0;
>  }
> 
>  struct kvm_pmu_ops intel_pmu_ops = {
> --
> 2.7.4

