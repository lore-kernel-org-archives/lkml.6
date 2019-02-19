Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00588C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02E521903
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfBSGi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 01:38:58 -0500
Received: from mga01.intel.com ([192.55.52.88]:18823 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbfBSGi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 01:38:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2019 22:38:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,387,1544515200"; 
   d="scan'208";a="145384731"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.239.196.155]) ([10.239.196.155])
  by fmsmga004.fm.intel.com with ESMTP; 18 Feb 2019 22:38:55 -0800
Subject: Re: [PATCH] KVM: Ignore LBR MSRs with no effect
To:     Anton Kuchin <antonkuchin@yandex-team.ru>, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Evgeny Yakovlev <wrfsh@yandex-team.ru>
References: <20190128174322.8529-1-antonkuchin@yandex-team.ru>
From:   Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <ccdb6e15-7cdf-7e96-19aa-b02c7d5b5b3e@linux.intel.com>
Date:   Tue, 19 Feb 2019 14:38:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190128174322.8529-1-antonkuchin@yandex-team.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/1/29 1:43, Anton Kuchin wrote:
> Win10 attempts to save these registers during KiSaveDebugRegisterState
> if LBR or BTF bits are set in MSR_IA32_DEBUGCTLMSR. It uses DR7 GE and LE
> flags for per-thread switching of these these features so zero value that
> is returned for MSR_IA32_DEBUGCTLMSR has no effect.
> 
> These registers are used for debugging and shouldn't cause #GP and
> guest crash so just return zeroes just like we do for common x86 LBR
> MSRs (DEBUGCTLMSR, LAST[BRANCH|INT][TO|FROM]IP).
> 
> Signed-off-by: Anton Kuchin <antonkuchin@yandex-team.ru>
> ---
>   arch/x86/kvm/vmx/vmx.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index f6915f10e584..8bc56cf027ed 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1769,6 +1769,13 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   		else
>   			msr_info->data = vmx->pt_desc.guest.addr_a[index / 2];
>   		break;
> +	case MSR_LBR_TOS:
> +	case MSR_LBR_NHM_FROM ... MSR_LBR_NHM_FROM + 31:
> +	case MSR_LBR_NHM_TO ... MSR_LBR_NHM_TO + 31:
> +	case MSR_LBR_CORE_FROM ... MSR_LBR_CORE_FROM + 7:
> +	case MSR_LBR_CORE_TO ... MSR_LBR_CORE_TO + 7:
> +		msr_info->data = 0;
> +		break;

It's better to move LBR stack MSRs set-up to 
vmx/pmu_intel.c:intel_pmu_get_msr and using specified sizes (31 or 7) is 
not a good practice.

vLBR is still in an unenabled state and
please check https://lkml.org/lkml/2018/12/26/82 for dependency check.

>   	case MSR_TSC_AUX:
>   		if (!msr_info->host_initiated &&
>   		    !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))
> 

