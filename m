Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935481AbeBMOil (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:38:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935246AbeBMOik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:38:40 -0500
Subject: Re: [PATCH v3] KVM: VMX: Don't halt vcpu when L1 is injecting events
 to L2
To: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>
References: <1518314790-31774-1-git-send-email-chao.gao@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6164ecd6-cf6e-dfc9-812a-b99706468f8b@redhat.com>
Date: Tue, 13 Feb 2018 15:38:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1518314790-31774-1-git-send-email-chao.gao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2018 03:06, Chao Gao wrote:
> Although L2 is in halt state, it will be in the active state after
> VM entry if the VM entry is vectoring according to SDM 26.6.2 Activity
> State. Halting the vcpu here means the event won't be injected to L2
> and this decision isn't reported to L1. Thus L0 drops an event that
> should be injected to L2.
> 
> Cc: Liran Alon <liran.alon@oracle.com>
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> ---
> changes in v3:
>  - s/VECTORING_INFO_VALID_MASK/INTR_INFO_VALID_MASK
>  - Changes of subject, comments.
> 
> Changes in v2:
>  - Remove VID stuff. Only handle event injection in this patch.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> ---
>  arch/x86/kvm/vmx.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index bb5b488..cf7c2fc 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -10985,7 +10985,12 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
>  	if (ret)
>  		return ret;
>  
> -	if (vmcs12->guest_activity_state == GUEST_ACTIVITY_HLT)
> +	/*
> +	 * If we're entering a halted L2 vcpu and the L2 vcpu won't be woken
> +	 * by event injection, halt vcpu.
> +	 */
> +	if ((vmcs12->guest_activity_state == GUEST_ACTIVITY_HLT) &&
> +	    !(vmcs12->vm_entry_intr_info_field & INTR_INFO_VALID_MASK))
>  		return kvm_vcpu_halt(vcpu);
>  
>  	vmx->nested.nested_run_pending = 1;
> 

Queued, thanks (haven't yet tried the new test).

Paolo
