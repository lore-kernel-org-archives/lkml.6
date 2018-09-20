Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA9EECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166C7204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 12:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166C7204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbeITSQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:16:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:31999 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730984AbeITSQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:16:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 05:33:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="92212187"
Received: from unknown (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga001.jf.intel.com with ESMTP; 20 Sep 2018 05:33:30 -0700
Message-ID: <5BA394BC.1070804@intel.com>
Date:   Thu, 20 Sep 2018 20:38:20 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com
CC:     kan.liang@intel.com, peterz@infradead.org, mingo@redhat.com,
        rkrcmar@redhat.com, like.xu@intel.com, jannh@google.com,
        arei.gonglei@huawei.com
Subject: Re: [PATCH v3 3/5] KVM/x86: expose MSR_IA32_PERF_CAPABILITIES to
 the guest
References: <1537437959-8751-1-git-send-email-wei.w.wang@intel.com> <1537437959-8751-4-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1537437959-8751-4-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20/2018 06:05 PM, Wei Wang wrote:
> Bits [0, 5] of MSR_IA32_PERF_CAPABILITIES tell about the format of
> the addresses stored in the LBR stack. Expose those bits to the guest
> when the guest lbr feature is enabled.
>
> Signed-off-by: Like Xu <like.xu@intel.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> ---
>   arch/x86/include/asm/perf_event.h | 2 ++
>   arch/x86/kvm/cpuid.c              | 2 +-
>   arch/x86/kvm/vmx.c                | 7 +++++++
>   3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index 84cc8cb..e893a69 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -79,6 +79,8 @@
>   #define ARCH_PERFMON_BRANCH_MISSES_RETIRED		6
>   #define ARCH_PERFMON_EVENTS_COUNT			7
>   
> +#define PERF_CAP_MASK_LBR_FMT				0x3f
> +
>   /*
>    * Intel "Architectural Performance Monitoring" CPUID
>    * detection/enumeration details:
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 7bcfa61..3b8a57b 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -365,7 +365,7 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>   		F(XMM3) | F(PCLMULQDQ) | 0 /* DTES64, MONITOR */ |
>   		0 /* DS-CPL, VMX, SMX, EST */ |
>   		0 /* TM2 */ | F(SSSE3) | 0 /* CNXT-ID */ | 0 /* Reserved */ |
> -		F(FMA) | F(CX16) | 0 /* xTPR Update, PDCM */ |
> +		F(FMA) | F(CX16) | 0 /* xTPR Update*/ | F(PDCM) |
>   		F(PCID) | 0 /* Reserved, DCA */ | F(XMM4_1) |
>   		F(XMM4_2) | F(X2APIC) | F(MOVBE) | F(POPCNT) |
>   		0 /* Reserved*/ | F(AES) | F(XSAVE) | 0 /* OSXSAVE */ | F(AVX) |
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 533a327..92705b5 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -4134,6 +4134,13 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
>   			return 1;
>   		/* Otherwise falls through */
> +	case MSR_IA32_PERF_CAPABILITIES:
> +		if (!boot_cpu_has(X86_FEATURE_PDCM))
> +			return 1;
> +		msr_info->data = native_read_msr(MSR_IA32_PERF_CAPABILITIES);
> +		if (vcpu->kvm->arch.guest_lbr_enabled)
> +			msr_info->data &= PERF_CAP_MASK_LBR_FMT;
> +		break;

Sorry about a mistake here. Will move "case MSR_IA32_PERF_CAPABILITIES" 
one step above - above "case TSC_AUX".

Best,
Wei

