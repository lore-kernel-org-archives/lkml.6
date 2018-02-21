Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933615AbeBULmM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 06:42:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932556AbeBULmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 06:42:10 -0500
Subject: Re: [PATCH v2 2/2] KVM: SVM: Add MSR-based feature support for
 serializing LFENCE
To: Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20180215231156.31016.79657.stgit@tlendack-t1.amdoffice.net>
 <20180215231216.31016.18777.stgit@tlendack-t1.amdoffice.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <230e21ac-3efa-f0ad-4878-fce0e68fd0da@redhat.com>
Date: Wed, 21 Feb 2018 12:42:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215231216.31016.18777.stgit@tlendack-t1.amdoffice.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2018 00:12, Tom Lendacky wrote:
> In order to determine if LFENCE is a serializing instruction on AMD
> processors, MSR 0xc0011029 (MSR_F10H_DECFG) must be read and the state
> of bit 1 checked.  This patch will add support to allow a guest to
> properly make this determination.
> 
> Add the MSR feature callback operation to svm.c and add MSR 0xc0011029
> to the list of MSR-based features.  If LFENCE is serializing, then the
> feature is supported, allowing the hypervisor to set the value of the
> MSR that guest will see.  Support is also added to write (hypervisor only)
> and read the MSR value for the guest.  A write by the guest will result in
> a #GP.  A read by the guest will return the value as set by the host.  In
> this way, the support to expose the feature to the guest is controlled by
> the hypervisor.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/kvm/svm.c |   43 +++++++++++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/x86.c |    1 +
>  2 files changed, 44 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index b3e488a..2b40885 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -178,6 +178,8 @@ struct vcpu_svm {
>  	uint64_t sysenter_eip;
>  	uint64_t tsc_aux;
>  
> +	u64 msr_decfg;
> +
>  	u64 next_rip;
>  
>  	u64 host_user_msrs[NR_HOST_SAVE_USER_MSRS];
> @@ -3860,6 +3862,24 @@ static int cr8_write_interception(struct vcpu_svm *svm)
>  	return 0;
>  }
>  
> +static int svm_msr_feature(struct kvm_msr_entry *msr)
> +{
> +	int ret = 0;
> +
> +	msr->data = 0;
> +
> +	switch (msr->index) {
> +	case MSR_F10H_DECFG:
> +		if (boot_cpu_has(X86_FEATURE_LFENCE_RDTSC))
> +			msr->data |= MSR_F10H_DECFG_LFENCE_SERIALIZE;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
>  static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
> @@ -3955,6 +3975,9 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  			msr_info->data = 0x1E;
>  		}
>  		break;
> +	case MSR_F10H_DECFG:
> +		msr_info->data = svm->msr_decfg;
> +		break;
>  	default:
>  		return kvm_get_msr_common(vcpu, msr_info);
>  	}
> @@ -4133,6 +4156,24 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>  	case MSR_VM_IGNNE:
>  		vcpu_unimpl(vcpu, "unimplemented wrmsr: 0x%x data 0x%llx\n", ecx, data);
>  		break;
> +	case MSR_F10H_DECFG: {
> +		struct kvm_msr_entry msr_entry;
> +
> +		msr_entry.index = msr->index;
> +		if (svm_msr_feature(&msr_entry))
> +			return 1;
> +
> +		/* Check the supported bits */
> +		if (data & ~msr_entry.data)
> +			return 1;
> +
> +		/* Don't allow the guest to change a bit, #GP */
> +		if (!msr->host_initiated && (data ^ msr_entry.data))
> +			return 1;
> +
> +		svm->msr_decfg = data;
> +		break;
> +	}
>  	case MSR_IA32_APICBASE:
>  		if (kvm_vcpu_apicv_active(vcpu))
>  			avic_update_vapic_bar(to_svm(vcpu), data);
> @@ -6917,6 +6958,8 @@ static int svm_unregister_enc_region(struct kvm *kvm,
>  	.mem_enc_op = svm_mem_enc_op,
>  	.mem_enc_reg_region = svm_register_enc_region,
>  	.mem_enc_unreg_region = svm_unregister_enc_region,
> +
> +	.msr_feature = svm_msr_feature,
>  };
>  
>  static int __init svm_init(void)
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0219c5c..42fbbf4 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1054,6 +1054,7 @@ bool kvm_rdpmc(struct kvm_vcpu *vcpu)
>   * can be used by a hypervisor to validate requested CPU features.
>   */
>  static u32 msr_based_features[] = {
> +	MSR_F10H_DECFG,
>  };
>  
>  static unsigned int num_msr_based_features = ARRAY_SIZE(msr_based_features);
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
