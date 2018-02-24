Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752398AbeBXAj0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 19:39:26 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50908 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751547AbeBXAjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 19:39:24 -0500
MIME-Version: 1.0
Message-ID: <764f4da9-2d0c-41cf-a4a4-d9b3bf3447c2@default>
Date: Fri, 23 Feb 2018 16:39:21 -0800 (PST)
From: Liran Alon <liran.alon@oracle.com>
To: <pbonzini@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86: move LAPIC initialization after VMCS creation
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8813 signatures=668678
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802240006
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1O0dW82016771


----- pbonzini@redhat.com wrote:

> The initial reset of the local APIC is performed before the VMCS has
> been
> created, but it tries to do a vmwrite:
> 
>  vmwrite error: reg 810 value 4a00 (err 18944)
>  CPU: 54 PID: 38652 Comm: qemu-kvm Tainted: G        W I     
> 4.16.0-0.rc2.git0.1.fc28.x86_64 #1
>  Hardware name: Intel Corporation S2600CW/S2600CW, BIOS
> SE5C610.86B.01.01.0003.090520141303 09/05/2014
>  Call Trace:
>   vmx_set_rvi [kvm_intel]
>   vmx_hwapic_irr_update [kvm_intel]
>   kvm_lapic_reset [kvm]
>   kvm_create_lapic [kvm]
>   kvm_arch_vcpu_init [kvm]
>   kvm_vcpu_init [kvm]
>   vmx_create_vcpu [kvm_intel]
>   kvm_vm_ioctl [kvm]
> 
> Move it later, after the VMCS has been created.
> 
> Fixes: 851c1a18c5412fd321e387cfe60739387cdbf37d
> Cc: Liran Alon <liran.alon@oracle.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/lapic.c | 1 -
>  arch/x86/kvm/x86.c   | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 924ac8ce9d50..cc5fe7a50dde 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2165,7 +2165,6 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu)
>  	 */
>  	vcpu->arch.apic_base = MSR_IA32_APICBASE_ENABLE;
>  	static_key_slow_inc(&apic_sw_disabled.key); /* sw disabled at reset
> */
> -	kvm_lapic_reset(vcpu, false);
>  	kvm_iodevice_init(&apic->dev, &apic_mmio_ops);
>  
>  	return 0;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c8a0b545ac20..ca90d9515137 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7975,6 +7975,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
>  	kvm_vcpu_mtrr_init(vcpu);
>  	vcpu_load(vcpu);
>  	kvm_vcpu_reset(vcpu, false);
> +	kvm_lapic_reset(vcpu, false);
>  	kvm_mmu_setup(vcpu);
>  	vcpu_put(vcpu);
>  	return 0;
> -- 
> 1.8.3.1

I agree with the bug and the fix.
It makes sense to reset LAPIC in the same place other components are reset
rather than in it's creation.

However, I failed to understand why you mention it fixes commit:
851c1a18c541 ("KVM: nVMX: Fix injection to L2 when L1 don't intercept external-interrupts")

Before and after that commit, vmx_hwapic_irr_update() did exactly the same
because is_guest_mode(vcpu)==false at this point.
Therefore, vmx_hwapic_irr_update() has always just called vmx_set_rvi()
which has not changed in that commit.

It seems to me that the commit which introduced this issue is actually:
4191db26b714 ("KVM: x86: Update APICv on APIC reset")

What am I missing?

-Liran
