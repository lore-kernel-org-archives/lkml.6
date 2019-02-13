Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D643DC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30882086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393091AbfBMRfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:35:15 -0500
Received: from foss.arm.com ([217.140.101.70]:57910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732687AbfBMRfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:35:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94160A78;
        Wed, 13 Feb 2019 09:35:14 -0800 (PST)
Received: from [10.1.197.21] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF4CA3F675;
        Wed, 13 Feb 2019 09:35:12 -0800 (PST)
From:   Kristina Martsenko <kristina.martsenko@arm.com>
Subject: Re: [PATCH v5 3/5] arm64/kvm: context-switch ptrauth register
To:     James Morse <james.morse@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
References: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
 <1548658727-14271-4-git-send-email-amit.kachhap@arm.com>
 <d862316b-5b2e-8187-04e0-c0be350c1624@arm.com>
Message-ID: <9d4b5ac7-9d89-b6a0-cfa2-4eab81ff157a@arm.com>
Date:   Wed, 13 Feb 2019 17:35:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d862316b-5b2e-8187-04e0-c0be350c1624@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2019 16:25, James Morse wrote:
> Hi Amit,
> 
> On 28/01/2019 06:58, Amit Daniel Kachhap wrote:
>> When pointer authentication is supported, a guest may wish to use it.
>> This patch adds the necessary KVM infrastructure for this to work, with
>> a semi-lazy context switch of the pointer auth state.

[...]

>> +void __no_ptrauth __hyp_text __ptrauth_switch_to_guest(struct kvm_vcpu *vcpu,
>> +					  struct kvm_cpu_context *host_ctxt,
>> +					  struct kvm_cpu_context *guest_ctxt)
>> +{
>> +	if (!__ptrauth_is_enabled(vcpu))
>> +		return;
>> +
> 
>> +	ptrauth_keys_store((struct ptrauth_keys *) &host_ctxt->sys_regs[APIAKEYLO_EL1]);
> 
> We can't cast part of an array to a structure like this. What happens if the
> compiler inserts padding in struct-ptrauth_keys, or the struct randomization
> thing gets hold of it: https://lwn.net/Articles/722293/
> 
> If we want to use the helpers that take a struct-ptrauth_keys, we need to keep
> the keys in a struct-ptrauth_keys. To do this we'd need to provide accessors so
> that GET_ONE_REG() of APIAKEYLO_EL1 comes from the struct-ptrauth_keys, instead
> of the sys_reg array.

If I've understood correctly, the idea is to have a struct ptrauth_keys
in struct kvm_vcpu_arch, instead of having the keys in the
kvm_cpu_context->sys_regs array. This is to avoid having similar code in
__ptrauth_key_install/ptrauth_keys_switch and
__ptrauth_restore_key/__ptrauth_restore_state, and so that future
patches (that add pointer auth in the kernel) would only need to update
one place instead of two.

But it also means we'll have to special case pointer auth in
kvm_arm_sys_reg_set_reg/kvm_arm_sys_reg_get_reg and kvm_vcpu_arch. Is it
worth it? I'd prefer to keep the slight code duplication but avoid the
special casing.

> 
> 
> Wouldn't the host keys be available somewhere else? (they must get transfer to
> secondary CPUs somehow). Can we skip the save step when switching from the host?
> 
> 
>> +	ptrauth_keys_switch((struct ptrauth_keys *) &guest_ctxt->sys_regs[APIAKEYLO_EL1]);
>> +}
> 

[...]

> 
>> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
>> index 03b36f1..301d332 100644
>> --- a/arch/arm64/kvm/hyp/switch.c
>> +++ b/arch/arm64/kvm/hyp/switch.c
>> @@ -483,6 +483,8 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
>>  	sysreg_restore_guest_state_vhe(guest_ctxt);
>>  	__debug_switch_to_guest(vcpu);
>>  
>> +	__ptrauth_switch_to_guest(vcpu, host_ctxt, guest_ctxt);
>> +
>>  	__set_guest_arch_workaround_state(vcpu);
>>  
>>  	do {
>> @@ -494,6 +496,8 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
>>  
>>  	__set_host_arch_workaround_state(vcpu);
>>  
>> +	__ptrauth_switch_to_host(vcpu, host_ctxt, guest_ctxt);
>> +
>>  	sysreg_save_guest_state_vhe(guest_ctxt);
>>  
>>  	__deactivate_traps(vcpu);
> 
> ...This makes me nervous...
> 
> __guest_enter() is a function that (might) change the keys, then we change them
> again here. We can't have any signed return address between these two points. I
> don't trust the compiler not to generate any.
> 
> ~
> 
> I had a chat with some friendly compiler folk... because there are two identical
> sequences in kvm_vcpu_run_vhe() and __kvm_vcpu_run_nvhe(), the compiler could
> move the common code to a function it then calls. Apparently this is called
> 'function outlining'.
> 
> If the compiler does this, and the guest changes the keys, I think we would fail
> the return address check.
> 
> Painting the whole thing with no_prauth would solve this, but this code then
> becomes a target.
> Because the compiler can't anticipate the keys changing, we ought to treat them
> the same way we do the callee saved registers, stack-pointer etc, and
> save/restore them in the __guest_enter() assembly code.
> 
> (we can still keep the save/restore in C, but call it from assembly so we know
> nothing new is going on the stack).

I agree that this should be called from assembly if we were building the
kernel with pointer auth. But as we are not doing that yet in this
series, can't we keep the calls in kvm_vcpu_run_vhe for now?

In general I would prefer if the keys were switched in
kvm_arch_vcpu_load/put for now, since the keys are currently only used
in userspace. Once in-kernel pointer auth support comes along, it can
move the switch into kvm_vcpu_run_vhe or __guest_enter/__guest_exit as
required.

Thanks,
Kristina
