Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbeDETnf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 15:43:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34490 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752641AbeDETnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 15:43:33 -0400
Subject: Re: [PATCH] KVM: vmx: unify adjacent #ifdefs
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1522861162-47491-1-git-send-email-pbonzini@redhat.com>
From: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Message-ID: <94589381-e93e-1a72-e4c1-c15359e6ad8a@oracle.com>
Date: Thu, 5 Apr 2018 12:43:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <1522861162-47491-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8854 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=990
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804050194
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/04/2018 09:59 AM, Paolo Bonzini wrote:
> vmx_save_host_state has multiple ifdefs for CONFIG_X86_64 that have
> no other code between them.  Simplify by reducing them to a single
> conditional.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   arch/x86/kvm/vmx.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 939c8724feb4..a1572461786e 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -2392,20 +2392,16 @@ static void vmx_save_host_state(struct kvm_vcpu *vcpu)
>   #ifdef CONFIG_X86_64
>   	savesegment(ds, vmx->host_state.ds_sel);
>   	savesegment(es, vmx->host_state.es_sel);
> -#endif
>   
> -#ifdef CONFIG_X86_64
>   	vmcs_writel(HOST_FS_BASE, current->thread.fsbase);
>   	vmcs_writel(HOST_GS_BASE, cpu_kernelmode_gs_base(cpu));
> -#else
> -	vmcs_writel(HOST_FS_BASE, segment_base(vmx->host_state.fs_sel));
> -	vmcs_writel(HOST_GS_BASE, segment_base(vmx->host_state.gs_sel));
> -#endif
>   
> -#ifdef CONFIG_X86_64
>   	vmx->msr_host_kernel_gs_base = current->thread.gsbase;
>   	if (is_long_mode(&vmx->vcpu))
>   		wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
> +#else
> +	vmcs_writel(HOST_FS_BASE, segment_base(vmx->host_state.fs_sel));
> +	vmcs_writel(HOST_GS_BASE, segment_base(vmx->host_state.gs_sel));
>   #endif
>   	if (boot_cpu_has(X86_FEATURE_MPX))
>   		rdmsrl(MSR_IA32_BNDCFGS, vmx->host_state.msr_host_bndcfgs);
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
