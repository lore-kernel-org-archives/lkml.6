Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbeDDLvS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 07:51:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751179AbeDDLvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 07:51:17 -0400
Subject: Re: [PATCH] x86: kvm: hide the unused 'cpu' variable
To: Arnd Bergmann <arnd@arndb.de>, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180404104449.113197-1-arnd@arndb.de>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <9fb67f72-6bb9-d5e5-120a-1abf51449734@redhat.com>
Date: Wed, 4 Apr 2018 13:51:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180404104449.113197-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.04.2018 12:44, Arnd Bergmann wrote:
> The local variable was newly introduced but is only accessed in one
> place on x86_64, but not on 32-bit:
> 
> arch/x86/kvm/vmx.c: In function 'vmx_save_host_state':
> arch/x86/kvm/vmx.c:2175:6: error: unused variable 'cpu' [-Werror=unused-variable]
> 
> This puts it into another #ifdef.
> 
> Fixes: 35060ed6a1ff ("x86/kvm/vmx: avoid expensive rdmsr for MSR_GS_BASE")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/x86/kvm/vmx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 8307f625ea99..7399a4a17f78 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -2357,7 +2357,9 @@ static unsigned long segment_base(u16 selector)
>  static void vmx_save_host_state(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +#ifdef CONFIG_X86_64
>  	int cpu = raw_smp_processor_id();
> +#endif
>  	int i;
>  
>  	if (vmx->host_state.loaded)
> 

Can't we get rid of the variable and just do it inline?

Anyhow, fixes the problem

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
