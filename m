Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbeBHNQX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:16:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:12941 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750806AbeBHNQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:16:22 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,478,1511856000";
   d="scan'208";a="199659509"
Date: Thu, 8 Feb 2018 20:04:43 +0800
From: Chao Gao <chao.gao@intel.com>
To: Liran Alon <liran.alon@oracle.com>
Cc: pbonzini@redhat.com, mingo@redhat.com, x86@kernel.org,
        tglx@linutronix.de, rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, kvm@vger.kernel.org
Subject: Re: [PATCH] x86/kvm/vmx: Don't halt vcpu when L1 is injecting events
 to L2
Message-ID: <20180208120441.GA118540@skl-4s-chao.sh.intel.com>
References: <94d2625d-5055-4834-ba3c-b1a25117b762@default>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94d2625d-5055-4834-ba3c-b1a25117b762@default>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 04:09:36AM -0800, Liran Alon wrote:
>
>----- pbonzini@redhat.com wrote:
>
>> On 08/02/2018 06:13, Chao Gao wrote:
>> > Although L2 is in halt state, it will be in the active state after
>> > VM entry if the VM entry is vectoring. Halting the vcpu here means
>> > the event won't be injected to L2 and this decision isn't reported
>> > to L1. Thus L0 drops an event that should be injected to L2.
>> > 
>> > Because virtual interrupt delivery may wake L2 vcpu, if VID is
>> enabled,
>> > do the same thing -- don't halt L2.
>> 
>> This second part seems wrong to me, or at least overly general. 
>> Perhaps
>> you mean if RVI>0?
>> 
>> Thanks,
>> 
>> Paolo
>
>I would first recommend to split this commit.
>The first commit should handle only the case of vectoring VM entry.
>It should also specify in commit message it is based on Intel SDM 26.6.2 Activity State:
>("If the VM entry is vectoring, the logical processor is in the active state after VM entry.")
>That part in code seems correct to me.
>
>The second commit seems wrong to me as-well.
>(I would also mention here it is based on Intel SDM 26.6.5
>Interrupt-Window Exiting and Virtual-Interrupt Delivery:
>"These events wake the logical processor if it just entered the HLT state because of a VM entry")
>
>Paolo, I think that your suggestion is not sufficient as well.
>Consider the case that APIC's TPR blocks interrupt specified in RVI.
>
>I think that we should just remove the check for VID from commit,
>and instead fix another bug which I describe below.
>
>If lapic_in_kernel()==false, then APICv is not active and VID is not exposed to L1
>(In current KVM code. Jim already criticize that this is wrong.).
>
>Otherwise, kvm_vcpu_halt() will change mp_state to KVM_MP_STATE_HALTED.
>Eventually, vcpu_run() will call vcpu_block() which will reach kvm_vcpu_has_events().
>That function is responsible for checking if there is any pending interrupts.
>Including, pending interrupts as a result of VID enabled and RVI>0

The difference between checking VID and RVI here and in vcpu_run() is
"nested_run_pending" is set for the former. Would it cause any problem
if we don't set it?

Thanks
Chao

>(While also taking into account the APIC's TPR).
>The logic that checks for pending interrupts is kvm_cpu_has_interrupt()
>which eventually reach apic_has_interrupt_for_ppr().
>If APICv is enabled, apic_has_interrupt_for_ppr() will call vmx_sync_pir_to_irr()
>which calls vmx_hwapic_irr_update().
>
>However, max_irr returned to apic_has_interrupt_for_ppr() does not consider the interrupt
>pending in RVI. Which I think is the real bug to fix here.
>In the non-nested case, RVI can never be larger than max_irr because that is how L0 KVM manages RVI.
>However, in the nested case, L1 can set RVI in VMCS arbitrary
>(we just copy GUEST_INTR_STATUS from vmcs01 into vmcs02).
>
>A possible patch to fix this is to change vmx_hwapic_irr_update() such that
>if is_guest_mode(vcpu)==true, we should return max(max_irr, rvi) and return
>that value into apic_has_interrupt_for_ppr().
>Need to verify that it doesn't break other flows but I think it makes sense.
>What do you think?
>
>Regards,
>-Liran
>
>> 
>> > Signed-off-by: Chao Gao <chao.gao@intel.com>
>> > ---
>> >  arch/x86/kvm/vmx.c | 10 ++++++++--
>> >  1 file changed, 8 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> > index bb5b488..e1fe4e4 100644
>> > --- a/arch/x86/kvm/vmx.c
>> > +++ b/arch/x86/kvm/vmx.c
>> > @@ -10985,8 +10985,14 @@ static int nested_vmx_run(struct kvm_vcpu
>> *vcpu, bool launch)
>> >  	if (ret)
>> >  		return ret;
>> >  
>> > -	if (vmcs12->guest_activity_state == GUEST_ACTIVITY_HLT)
>> > -		return kvm_vcpu_halt(vcpu);
>> > +	if (vmcs12->guest_activity_state == GUEST_ACTIVITY_HLT) {
>> > +		u32 intr_info = vmcs_read32(VM_ENTRY_INTR_INFO_FIELD);
>> > +		u32 exec_control = vmcs_read32(SECONDARY_VM_EXEC_CONTROL);
>> > +
>> > +		if (!(intr_info & VECTORING_INFO_VALID_MASK) &&
>> > +			!(exec_control & SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY))
>> > +			return kvm_vcpu_halt(vcpu);
>> > +	}
>> 
>> >  	vmx->nested.nested_run_pending = 1;
>> >  
>> >
