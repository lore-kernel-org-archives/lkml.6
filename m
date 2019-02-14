Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FC8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB0C222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406735AbfBNKsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:48:14 -0500
Received: from foss.arm.com ([217.140.101.70]:41168 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395351AbfBNKsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:48:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB62DEBD;
        Thu, 14 Feb 2019 02:48:02 -0800 (PST)
Received: from [10.162.0.144] (a075553-lin.blr.arm.com [10.162.0.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 207BC3F575;
        Thu, 14 Feb 2019 02:47:59 -0800 (PST)
Subject: Re: [PATCH v5 4/5] arm64/kvm: add a userspace option to enable
 pointer authentication
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
 <1548658727-14271-5-git-send-email-amit.kachhap@arm.com>
 <1e3f2a9a-e3f7-bb06-495a-24f77a73cae0@arm.com>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Message-ID: <b462c85b-8312-f1f3-e0b1-d9dcc0f616b4@arm.com>
Date:   Thu, 14 Feb 2019 16:17:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1e3f2a9a-e3f7-bb06-495a-24f77a73cae0@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
On 1/31/19 9:57 PM, James Morse wrote:
> Hi Amit,
> 
> On 28/01/2019 06:58, Amit Daniel Kachhap wrote:
>> This feature will allow the KVM guest to allow the handling of
>> pointer authentication instructions or to treat them as undefined
>> if not set. It uses the existing vcpu API KVM_ARM_VCPU_INIT to
>> supply this parameter instead of creating a new API.
>>
>> A new register is not created to pass this parameter via
>> SET/GET_ONE_REG interface as just a flag (KVM_ARM_VCPU_PTRAUTH)
>> supplied is enough to enable this feature.
> 
> 
>> diff --git a/Documentation/arm64/pointer-authentication.txt
> b/Documentation/arm64/pointer-authentication.txt
>> index a25cd21..0529a7d 100644
>> --- a/Documentation/arm64/pointer-authentication.txt
>> +++ b/Documentation/arm64/pointer-authentication.txt
>> @@ -82,7 +82,8 @@ pointers).
>>   Virtualization
>>   --------------
>>
>> -Pointer authentication is not currently supported in KVM guests. KVM
>> -will mask the feature bits from ID_AA64ISAR1_EL1, and attempted use of
>> -the feature will result in an UNDEFINED exception being injected into
>> -the guest.
>> +Pointer authentication is enabled in KVM guest when virtual machine is
>> +created by passing a flag (KVM_ARM_VCPU_PTRAUTH)
> 
> Isn't that a VCPU flag? Shouldn't this be when each VCPU is created?
Yes it is a VCPU flag.
> 
> 
>> requesting this feature
>> +to be enabled. Without this flag, pointer authentication is not enabled
>> +in KVM guests and attempted use of the feature will result in an UNDEFINED
>> +exception being injected into the guest.
> 
> ... what happens if KVM's user-space enables ptrauth on some vcpus, but not on
> others?
Yes seems to be issue. Let me check more on this if there are other ways 
of passing the userspace parameter such as in CREATE_VM type ioctl.
> 
> You removed the id-register suppression in the previous patch, but it doesn't
> get hooked up to kvm_arm_vcpu_ptrauth_allowed() here. (you could add
> kvm_arm_vcpu_ptrauth_allowed() earlier, and default it to true to make it easier).
> 
> Doesn't this mean that if the CPU supports pointer auth, but user-space doesn't
> specify this flag, the guest gets mysterious undef's whenever it tries to use
> the advertised feature?
Agree, ID registers should be masked  when userspace disables it.
> 
> (whether we support big/little virtual-machines is probably a separate issue,
> but the id registers need to be consistent with our trap-and-undef behaviour)
> 
> 
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index c798d0c..4a6ec40 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -453,14 +453,15 @@ static inline bool kvm_arch_requires_vhe(void)
>>   
>>   void kvm_arm_vcpu_ptrauth_enable(struct kvm_vcpu *vcpu);
>>   void kvm_arm_vcpu_ptrauth_disable(struct kvm_vcpu *vcpu);
>> +bool kvm_arm_vcpu_ptrauth_allowed(struct kvm_vcpu *vcpu);
>>   
>>   static inline void kvm_arm_vcpu_ptrauth_reset(struct kvm_vcpu *vcpu)
>>   {
>>   	/* Disable ptrauth and use it in a lazy context via traps */
>> -	if (has_vhe() && kvm_supports_ptrauth())
>> +	if (has_vhe() && kvm_supports_ptrauth()
>> +			&& kvm_arm_vcpu_ptrauth_allowed(vcpu))
>>   		kvm_arm_vcpu_ptrauth_disable(vcpu);
>>   }
>> -
>>   void kvm_arm_vcpu_ptrauth_trap(struct kvm_vcpu *vcpu);
>>   
> 
>> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
>> index 5b980e7..c0e5dcd 100644
>> --- a/arch/arm64/kvm/handle_exit.c
>> +++ b/arch/arm64/kvm/handle_exit.c
>> @@ -179,7 +179,8 @@ static int handle_sve(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>    */
>>   void kvm_arm_vcpu_ptrauth_trap(struct kvm_vcpu *vcpu)
>>   {
>> -	if (has_vhe() && kvm_supports_ptrauth())
>> +	if (has_vhe() && kvm_supports_ptrauth()
>> +			&& kvm_arm_vcpu_ptrauth_allowed(vcpu))
> 
> Duplication. If has_vhe() moved into kvm_supports_ptrauth(), and
> kvm_supports_ptrauth() was called from kvm_arm_vcpu_ptrauth_allowed() it would
> be clearer that use of this feature was becoming user-controlled policy.
> 
> (We don't need to list the dependencies at every call site)
ok.
> 
> 
>> diff --git a/arch/arm64/kvm/hyp/ptrauth-sr.c b/arch/arm64/kvm/hyp/ptrauth-sr.c
>> index 0576c01..369624f 100644
>> --- a/arch/arm64/kvm/hyp/ptrauth-sr.c
>> +++ b/arch/arm64/kvm/hyp/ptrauth-sr.c
>> @@ -42,3 +42,16 @@ void __no_ptrauth __hyp_text __ptrauth_switch_to_host(struct kvm_vcpu *vcpu,
>>   	ptrauth_keys_store((struct ptrauth_keys *) &guest_ctxt->sys_regs[APIAKEYLO_EL1]);
>>   	ptrauth_keys_switch((struct ptrauth_keys *) &host_ctxt->sys_regs[APIAKEYLO_EL1]);
>>   }
>> +
>> +/**
>> + * kvm_arm_vcpu_ptrauth_allowed - checks if ptrauth feature is present in vcpu
> 
> ('enabled by KVM's user-space' may be clearer. 'Present in vcpu' could be down
> to a cpufeature thing)
ok.
> 
> 
>> + *
>> + * @vcpu: The VCPU pointer
>> + *
>> + * This function will be used to enable/disable ptrauth in guest as configured
> 
> ... but it just tests the bit ...
> 
>> + * by the KVM userspace API.
>> + */
>> +bool kvm_arm_vcpu_ptrauth_allowed(struct kvm_vcpu *vcpu)
>> +{
>> +	return test_bit(KVM_ARM_VCPU_PTRAUTH, vcpu->arch.features);
>> +}
> 
> 
> Thanks,
> 
> James
> 
//Amit
