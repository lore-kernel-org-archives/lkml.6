Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751787AbeDDLyi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 07:54:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751698AbeDDLyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 07:54:36 -0400
Subject: Re: [PATCH v5 1/2] KVM: X86: Introduce handle_ud()
To: Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Liran Alon <liran.alon@oracle.com>
References: <1522798129-14588-1-git-send-email-wanpengli@tencent.com>
 <1522798129-14588-2-git-send-email-wanpengli@tencent.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <9d68b1b4-04e6-46d6-70b4-6ebcb0a0c4aa@redhat.com>
Date: Wed, 4 Apr 2018 13:54:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1522798129-14588-2-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.04.2018 01:28, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Introduce handle_ud() to handle invalid opcode, this function will be
> used by later patches.
> 
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Reviewed-by: Liran Alon <liran.alon@oracle.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Liran Alon <liran.alon@oracle.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/svm.c |  9 +--------
>  arch/x86/kvm/vmx.c | 10 ++--------
>  arch/x86/kvm/x86.c | 13 +++++++++++++
>  arch/x86/kvm/x86.h |  2 ++
>  4 files changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index f66fc2e..e0a3f56 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -2676,14 +2676,7 @@ static int bp_interception(struct vcpu_svm *svm)
>  
>  static int ud_interception(struct vcpu_svm *svm)
>  {
> -	int er;
> -
> -	er = emulate_instruction(&svm->vcpu, EMULTYPE_TRAP_UD);
> -	if (er == EMULATE_USER_EXIT)
> -		return 0;
> -	if (er != EMULATE_DONE)
> -		kvm_queue_exception(&svm->vcpu, UD_VECTOR);
> -	return 1;
> +	return handle_ud(&svm->vcpu);
>  }
>  
>  static int ac_interception(struct vcpu_svm *svm)
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index b2f8a70..0f11243 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -6436,14 +6436,8 @@ static int handle_exception(struct kvm_vcpu *vcpu)
>  	if (is_nmi(intr_info))
>  		return 1;  /* already handled by vmx_vcpu_run() */
>  
> -	if (is_invalid_opcode(intr_info)) {
> -		er = emulate_instruction(vcpu, EMULTYPE_TRAP_UD);
> -		if (er == EMULATE_USER_EXIT)
> -			return 0;
> -		if (er != EMULATE_DONE)
> -			kvm_queue_exception(vcpu, UD_VECTOR);
> -		return 1;
> -	}
> +	if (is_invalid_opcode(intr_info))
> +		return handle_ud(vcpu);

(maybe different on this branch) isn't "er" now unused?

>  
>  	error_code = 0;
>  	if (intr_info & INTR_INFO_DELIVER_CODE_MASK)
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 7d9a444..1eb495e 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4840,6 +4840,19 @@ int kvm_write_guest_virt_system(struct x86_emulate_ctxt *ctxt,
>  }
>  EXPORT_SYMBOL_GPL(kvm_write_guest_virt_system);
>  
> +int handle_ud(struct kvm_vcpu *vcpu)
> +{
> +	enum emulation_result er;
> +
> +	er = emulate_instruction(vcpu, EMULTYPE_TRAP_UD);
> +	if (er == EMULATE_USER_EXIT)
> +		return 0;
> +	if (er != EMULATE_DONE)
> +		kvm_queue_exception(vcpu, UD_VECTOR);
> +	return 1;

I would now actually prefer

if (er == EMULATE_DONE)
	return 1 ...


Anyhow,

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 

Thanks,

David / dhildenb
