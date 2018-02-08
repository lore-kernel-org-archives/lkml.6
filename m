Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbeBHKaE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 05:30:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751014AbeBHKaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 05:30:03 -0500
Subject: Re: [PATCH] x86/kvm/vmx: Don't halt vcpu when L1 is injecting events
 to L2
To: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>
References: <1518066816-7197-1-git-send-email-chao.gao@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7de4e758-08cc-2c45-b0aa-dfe28dfef398@redhat.com>
Date: Thu, 8 Feb 2018 11:29:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1518066816-7197-1-git-send-email-chao.gao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 06:13, Chao Gao wrote:
> Although L2 is in halt state, it will be in the active state after
> VM entry if the VM entry is vectoring. Halting the vcpu here means
> the event won't be injected to L2 and this decision isn't reported
> to L1. Thus L0 drops an event that should be injected to L2.
> 
> Because virtual interrupt delivery may wake L2 vcpu, if VID is enabled,
> do the same thing -- don't halt L2.

This second part seems wrong to me, or at least overly general.  Perhaps
you mean if RVI>0?

Thanks,

Paolo

> Signed-off-by: Chao Gao <chao.gao@intel.com>
> ---
>  arch/x86/kvm/vmx.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index bb5b488..e1fe4e4 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -10985,8 +10985,14 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
>  	if (ret)
>  		return ret;
>  
> -	if (vmcs12->guest_activity_state == GUEST_ACTIVITY_HLT)
> -		return kvm_vcpu_halt(vcpu);
> +	if (vmcs12->guest_activity_state == GUEST_ACTIVITY_HLT) {
> +		u32 intr_info = vmcs_read32(VM_ENTRY_INTR_INFO_FIELD);
> +		u32 exec_control = vmcs_read32(SECONDARY_VM_EXEC_CONTROL);
> +
> +		if (!(intr_info & VECTORING_INFO_VALID_MASK) &&
> +			!(exec_control & SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY))
> +			return kvm_vcpu_halt(vcpu);
> +	}

>  	vmx->nested.nested_run_pending = 1;
>  
> 
