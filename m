Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbeDILAW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:00:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751738AbeDILAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 07:00:21 -0400
Subject: Re: [PATCH] KVM: vmx: unify adjacent #ifdefs
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1522861162-47491-1-git-send-email-pbonzini@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <99fdeb91-a57b-86bb-7103-3f0a6ac65ccd@redhat.com>
Date: Mon, 9 Apr 2018 13:00:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1522861162-47491-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.04.2018 18:59, Paolo Bonzini wrote:
> vmx_save_host_state has multiple ifdefs for CONFIG_X86_64 that have
> no other code between them.  Simplify by reducing them to a single
> conditional.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/vmx.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 939c8724feb4..a1572461786e 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -2392,20 +2392,16 @@ static void vmx_save_host_state(struct kvm_vcpu *vcpu)
>  #ifdef CONFIG_X86_64
>  	savesegment(ds, vmx->host_state.ds_sel);
>  	savesegment(es, vmx->host_state.es_sel);
> -#endif
>  
> -#ifdef CONFIG_X86_64
>  	vmcs_writel(HOST_FS_BASE, current->thread.fsbase);
>  	vmcs_writel(HOST_GS_BASE, cpu_kernelmode_gs_base(cpu));
> -#else
> -	vmcs_writel(HOST_FS_BASE, segment_base(vmx->host_state.fs_sel));
> -	vmcs_writel(HOST_GS_BASE, segment_base(vmx->host_state.gs_sel));
> -#endif
>  
> -#ifdef CONFIG_X86_64
>  	vmx->msr_host_kernel_gs_base = current->thread.gsbase;
>  	if (is_long_mode(&vmx->vcpu))
>  		wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
> +#else
> +	vmcs_writel(HOST_FS_BASE, segment_base(vmx->host_state.fs_sel));
> +	vmcs_writel(HOST_GS_BASE, segment_base(vmx->host_state.gs_sel));
>  #endif
>  	if (boot_cpu_has(X86_FEATURE_MPX))
>  		rdmsrl(MSR_IA32_BNDCFGS, vmx->host_state.msr_host_bndcfgs);
> 

Much better indeed :)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
