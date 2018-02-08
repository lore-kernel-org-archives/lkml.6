Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbeBHNx6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:53:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751094AbeBHNx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:53:57 -0500
Subject: Re: [PATCH] x86/kvm/vmx: Don't halt vcpu when L1 is injecting events
 to L2
To: Liran Alon <liran.alon@oracle.com>
Cc: chao.gao@intel.com, mingo@redhat.com, x86@kernel.org,
        tglx@linutronix.de, rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, kvm@vger.kernel.org
References: <94d2625d-5055-4834-ba3c-b1a25117b762@default>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c2d277d-7e2c-838e-a207-1e107e832762@redhat.com>
Date: Thu, 8 Feb 2018 14:53:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <94d2625d-5055-4834-ba3c-b1a25117b762@default>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 13:09, Liran Alon wrote:
> ----- pbonzini@redhat.com wrote:
>> On 08/02/2018 06:13, Chao Gao wrote:
>>> Because virtual interrupt delivery may wake L2 vcpu, if VID is
>>> enabled, do the same thing -- don't halt L2.
>>
>> This second part seems wrong to me, or at least overly general. 
>> Perhaps you mean if RVI>0?
> 
> I would first recommend to split this commit.
> The first commit should handle only the case of vectoring VM entry.
> It should also specify in commit message it is based on Intel SDM 26.6.2 Activity State:
> ("If the VM entry is vectoring, the logical processor is in the active state after VM entry.")
> That part in code seems correct to me.

I agree.

> The second commit seems wrong to me as-well.
> (I would also mention here it is based on Intel SDM 26.6.5
> Interrupt-Window Exiting and Virtual-Interrupt Delivery:
> "These events wake the logical processor if it just entered the HLT state because of a VM entry")
> 
> Paolo, I think that your suggestion is not sufficient as well.
> Consider the case that APIC's TPR blocks interrupt specified in RVI.

That's true.  It should be RVI>PPR.

> Otherwise, kvm_vcpu_halt() will change mp_state to KVM_MP_STATE_HALTED.
> Eventually, vcpu_run() will call vcpu_block() which will reach kvm_vcpu_has_events().
> That function is responsible for checking if there is any pending interrupts.
> Including, pending interrupts as a result of VID enabled and RVI>0
> (While also taking into account the APIC's TPR).
> The logic that checks for pending interrupts is kvm_cpu_has_interrupt()
> which eventually reach apic_has_interrupt_for_ppr().
> If APICv is enabled, apic_has_interrupt_for_ppr() will call vmx_sync_pir_to_irr()
> which calls vmx_hwapic_irr_update().
> 
> However, max_irr returned to apic_has_interrupt_for_ppr() does not consider the interrupt
> pending in RVI. Which I think is the real bug to fix here.
> In the non-nested case, RVI can never be larger than max_irr because that is how L0 KVM manages RVI.
> However, in the nested case, L1 can set RVI in VMCS arbitrary
> (we just copy GUEST_INTR_STATUS from vmcs01 into vmcs02).
> 
> A possible patch to fix this is to change vmx_hwapic_irr_update() such that
> if is_guest_mode(vcpu)==true, we should return max(max_irr, rvi) and return
> that value into apic_has_interrupt_for_ppr().
> Need to verify that it doesn't break other flows but I think it makes sense.
> What do you think?

Yeah, I think it makes sense though I'd need to look a lot more at
arch/x86/kvm/lapic.c and arch/x86/kvm/vmx.c to turn that into a patch!

Paolo
