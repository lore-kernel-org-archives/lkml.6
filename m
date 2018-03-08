Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbeCHUlM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:41:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751157AbeCHUlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 15:41:10 -0500
Date: Thu, 8 Mar 2018 21:40:29 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/3] KVM: X86: Provides userspace with a capability to
 not intercept HLT
Message-ID: <20180308204029.GK12290@flask>
References: <1519897782-8124-1-git-send-email-wanpengli@tencent.com>
 <1519897782-8124-2-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1519897782-8124-2-git-send-email-wanpengli@tencent.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-01 17:49+0800, Wanpeng Li:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> If host CPUs are dedicated to a VM, we can avoid VM exits on HLT.
> This patch adds the per-VM non-HLT-exiting capability.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index dff3a5d..fcf8339 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -1394,6 +1394,9 @@ static void init_vmcb(struct vcpu_svm *svm)
>  		set_intercept(svm, INTERCEPT_MWAIT);
>  	}
>  
> +	if (!kvm_hlt_in_guest(svm->vcpu.kvm))
> +		set_intercept(svm, INTERCEPT_HLT);

We unconditionally set INTERCEPT_HLT just above, so that line has to be
removed.

> +
>  	control->iopm_base_pa = __sme_set(iopm_base);
>  	control->msrpm_base_pa = __sme_set(__pa(svm->msrpm));
>  	control->int_ctl = V_INTR_MASKING_MASK;
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> @@ -2525,6 +2525,19 @@ static int nested_vmx_check_exception(struct kvm_vcpu *vcpu, unsigned long *exit
>  	return 0;
>  }
>  
> +static void vmx_clear_hlt(struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * Ensure that we clear the HLT state in the VMCS.  We don't need to
> +	 * explicitly skip the instruction because if the HLT state is set,
> +	 * then the instruction is already executing and RIP has already been
> +	 * advanced.
> +	 */
> +	if (kvm_hlt_in_guest(vcpu->kvm) &&
> +			vmcs_read32(GUEST_ACTIVITY_STATE) == GUEST_ACTIVITY_HLT)
> +		vmcs_write32(GUEST_ACTIVITY_STATE, GUEST_ACTIVITY_ACTIVE);
> +}

The clearing seems to be still missing around SMM -- I think you need to
call vmx_clear_hlt() from pre_enter_smm().

Thanks.
