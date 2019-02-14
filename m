Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1265DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE316222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405981AbfBNJuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:50:20 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39784 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403789AbfBNJuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:50:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E8B1EBD;
        Thu, 14 Feb 2019 01:50:19 -0800 (PST)
Received: from [10.162.0.144] (a075553-lin.blr.arm.com [10.162.0.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C24393F575;
        Thu, 14 Feb 2019 01:50:16 -0800 (PST)
Subject: Re: [PATCH v5 2/5] arm64/kvm: preserve host HCR_EL2/MDCR_EL2 value
To:     James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
References: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
 <1548658727-14271-3-git-send-email-amit.kachhap@arm.com>
 <e773a26d-98d1-fc01-5c04-cd5a258d85ec@arm.com>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Message-ID: <89da2a5f-a41b-8847-87be-91b411075677@arm.com>
Date:   Thu, 14 Feb 2019 15:19:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e773a26d-98d1-fc01-5c04-cd5a258d85ec@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi James,

Little late in replying as some issue in my mail settings.
On 1/31/19 9:52 PM, James Morse wrote:
> Hi Amit,
> 
> On 28/01/2019 06:58, Amit Daniel Kachhap wrote:
>> When restoring HCR_EL2 for the host, KVM uses HCR_HOST_VHE_FLAGS, which
>> is a constant value. This works today, as the host HCR_EL2 value is
>> always the same, but this will get in the way of supporting extensions
>> that require HCR_EL2 bits to be set conditionally for the host.
>>
>> To allow such features to work without KVM having to explicitly handle
>> every possible host feature combination, this patch has KVM save/restore
>> the host HCR when switching to/from a guest HCR. The saving of the
>> register is done once during cpu hypervisor initialization state and is
>> just restored after switch from guest.
>>
>> For fetching HCR_EL2 during kvm initialisation, a hyp call is made using
>> kvm_call_hyp and is helpful in NHVE case.
> 
>> For the hyp TLB maintenance code, __tlb_switch_to_host_vhe() is updated
>> to toggle the TGE bit with a RMW sequence, as we already do in
>> __tlb_switch_to_guest_vhe().
> 
> 
>> While at it, host MDCR_EL2 value is fetched in a similar way and restored
>> after every switch from host to guest. There should not be any change in
>> functionality due to this.
> 
> Could this step be done as a separate subsequent patch? It would make review
> easier! The MDCR stuff would be a simplification if done second, done in one go
> like this its pretty noisy.
Ok, agree.
> 
> There ought to be some justification for moving hcr/mdcr into the cpu_context in
> the commit message.
ohh I missed adding in commit. Just added in cover letter.
> 
> 
> If you're keeping Mark's 'Signed-off-by' its would be normal to keep Mark as the
> author in git. This shows up a an extra 'From:' when you post the patch, and
> gets picked up when the maintainer runs git-am.
> 
> This patch has changed substantially from Mark's version:
> https://lkml.org/lkml/2017/11/27/675
> 
> If you keep the signed-off-by, could you add a [note] in the signed-off area
> with a terse summary. Something like:
>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> [ Move hcr to cpu_context, added __cpu_copy_hyp_conf()]
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> 
> (9c06602b1b92 is a good picked-at-random example for both of these)
Thanks for the information.
> 
> 
>> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
>> index f5b79e9..2da6e43 100644
>> --- a/arch/arm64/include/asm/kvm_asm.h
>> +++ b/arch/arm64/include/asm/kvm_asm.h
>> @@ -80,6 +80,8 @@ extern void __vgic_v3_init_lrs(void);
>>   
>>   extern u32 __kvm_get_mdcr_el2(void);
>>   
>> +extern u64 __kvm_get_hcr_el2(void);
> 
> Do we need these in separate helpers? For non-vhe this means two separate trips
> to EL2. Something like kvm_populate_host_context(void), and an __ version for
> the bit at EL2?
yes one wrapper for each of them will do.
> 
> We don't need to pass the host-context to EL2 as once kvm is loaded we can
> access host per-cpu variables at EL2 using __hyp_this_cpu_read(). This will save
> passing the vcpu around.
> 
> 
>> @@ -458,6 +457,25 @@ int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
>>   
>>   static inline void __cpu_init_stage2(void) {}
>>   
>> +/**
>> + * __cpu_copy_hyp_conf - copy the boot hyp configuration registers
>> + *
>> + * It is called once per-cpu during CPU hyp initialisation.
>> + */
>> +static inline void __cpu_copy_hyp_conf(void)
>> +{
>> +	kvm_cpu_context_t *host_cxt = this_cpu_ptr(&kvm_host_cpu_state);
>> +
>> +	host_cxt->hcr_el2 = kvm_call_hyp(__kvm_get_hcr_el2);
>> +
>> +	/*
>> +	 * Retrieve the initial value of mdcr_el2 so we can preserve
>> +	 * MDCR_EL2.HPMN which has presumably been set-up by some
>> +	 * knowledgeable bootcode.
>> +	 */
>> +	host_cxt->mdcr_el2 = kvm_call_hyp(__kvm_get_mdcr_el2);
>> +}
> 
> Its strange to make this an inline in a header. kvm_arm_init_debug() is a
> static-inline for arch/arm, but a regular C function for arch/arm64. Can't we do
> the same?
> 
> 
>> diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
>> index 68d6f7c..22c854a 100644
>> --- a/arch/arm64/kvm/hyp/sysreg-sr.c
>> +++ b/arch/arm64/kvm/hyp/sysreg-sr.c
>> @@ -316,3 +316,14 @@ void __hyp_text __kvm_enable_ssbs(void)
>>   	"msr	sctlr_el2, %0"
>>   	: "=&r" (tmp) : "L" (SCTLR_ELx_DSSBS));
>>   }
>> +
>> +/**
>> + * __read_hyp_hcr_el2 - Returns hcr_el2 register value
>> + *
>> + * This function acts as a function handler parameter for kvm_call_hyp and
>> + * may be called from EL1 exception level to fetch the register value.
>> + */
>> +u64 __hyp_text __kvm_get_hcr_el2(void)
>> +{
>> +	return read_sysreg(hcr_el2);
>> +}
> 
> While I'm all in favour of kernel-doc comments for functions, it may be
> over-kill in this case!
> 
> 
>> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
>> index 9e350fd3..2d65ada 100644
>> --- a/virt/kvm/arm/arm.c
>> +++ b/virt/kvm/arm/arm.c
>> @@ -1327,10 +1327,10 @@ static void cpu_hyp_reinit(void)
>>   	else
>>   		cpu_init_hyp_mode(NULL);
>>   
>> -	kvm_arm_init_debug();
>> -
>>   	if (vgic_present)
>>   		kvm_vgic_init_cpu_hardware();
>> +
>> +	__cpu_copy_hyp_conf();
>>   }
> 
> Was there a reason to make this call later than it originally was?
> (kvm_vgic_init_cpu_hardware() doesn't use any of those values, so its fine, just
> curious!)
Yes. Can be moved before.

//Amit D
> 
> 
> Thanks,
> 
> James
> 
