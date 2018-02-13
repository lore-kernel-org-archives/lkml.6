Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934860AbeBMQWb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:22:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60352 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934472AbeBMQW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:22:29 -0500
Subject: Re: [RFC PATCH 2/2] KVM: SVM: Add MSR feature support for serializing
 LFENCE
To: Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20180208225833.22074.25995.stgit@tlendack-t1.amdoffice.net>
 <20180208225856.22074.98252.stgit@tlendack-t1.amdoffice.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <584e51cc-1a79-4e5d-45ef-1850bb6c155e@redhat.com>
Date: Tue, 13 Feb 2018 17:22:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180208225856.22074.98252.stgit@tlendack-t1.amdoffice.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 23:58, Tom Lendacky wrote:
> Create an entry in the new MSR as a feature framework to allow a guest to
> recognize LFENCE as a serializing instruction on AMD processors.  The MSR
> can only be set by the host, any write by the guest will be ignored.  A
> read by the guest will return the value as set by the host.  In this way,
> the support to expose the feature to the guest is controlled by the
> hypervisor.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/kvm/svm.c |   16 ++++++++++++++++
>  arch/x86/kvm/x86.c |    6 ++++++
>  2 files changed, 22 insertions(+)
> 
> @@ -4047,6 +4052,17 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>  	case MSR_VM_IGNNE:
>  		vcpu_unimpl(vcpu, "unimplemented wrmsr: 0x%x data 0x%llx\n", ecx, data);
>  		break;
> +	case MSR_F10H_DECFG:
> +		/* Only the host can set this MSR, silently ignore */
> +		if (!msr->host_initiated)
> +			break;

Just one thing I'm wondering, should we #GP if the guest attempts to
clear MSR_F10H_DECFG_LFENCE_SERIALIZE?

Thanks,

Paolo

> +
> +		/* Check the supported bits */
> +		if (!kvm_valid_msr_feature(MSR_F10H_DECFG, data))
> +			return 1;
> +
> +		svm->msr_decfg = data;
> +		break;
>  	case MSR_IA32_APICBASE:
>  		if (kvm_vcpu_apicv_active(vcpu))
>  			avic_update_vapic_bar(to_svm(vcpu), data);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 4251c34..21ec73b 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1060,7 +1060,13 @@ struct kvm_msr_based_features {
>  	u64 value;			/* MSR value */
>  };
>  
> +static const struct x86_cpu_id msr_decfg_match[] = {
> +	{ X86_VENDOR_AMD, X86_FAMILY_ANY, X86_MODEL_ANY, X86_FEATURE_LFENCE_RDTSC },
> +	{}
> +};
> +
>  static struct kvm_msr_based_features msr_based_features[] = {
> +	{ MSR_F10H_DECFG, MSR_F10H_DECFG_LFENCE_SERIALIZE, msr_decfg_match },
>  	{}
>  };
>  
> 
