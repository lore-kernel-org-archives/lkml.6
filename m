Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5766DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2747E2073D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbfBOEtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 23:49:45 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54568 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbfBOEto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 23:49:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA741A78;
        Thu, 14 Feb 2019 20:49:43 -0800 (PST)
Received: from [10.162.0.144] (a075553-lin.blr.arm.com [10.162.0.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9513D3F589;
        Thu, 14 Feb 2019 20:49:40 -0800 (PST)
Subject: Re: [PATCH v5 4/5] arm64/kvm: add a userspace option to enable
 pointer authentication
To:     Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
References: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
 <1548658727-14271-5-git-send-email-amit.kachhap@arm.com>
 <a9b22dcf-2238-344f-0b7b-b4a9de7c562c@arm.com>
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
Message-ID: <6f341bd4-299b-8cc5-2509-f3598a78e4c6@arm.com>
Date:   Fri, 15 Feb 2019 10:19:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a9b22dcf-2238-344f-0b7b-b4a9de7c562c@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/13/19 11:05 PM, Kristina Martsenko wrote:
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
> [...]
> 
>> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
>> index b200c14..b6950df 100644
>> --- a/arch/arm/include/asm/kvm_host.h
>> +++ b/arch/arm/include/asm/kvm_host.h
>> @@ -346,6 +346,10 @@ static inline int kvm_arm_have_ssbd(void)
>>   static inline void kvm_vcpu_load_sysregs(struct kvm_vcpu *vcpu) {}
>>   static inline void kvm_vcpu_put_sysregs(struct kvm_vcpu *vcpu) {}
>>   static inline void kvm_arm_vcpu_ptrauth_reset(struct kvm_vcpu *vcpu) {}
>> +static inline bool kvm_arm_vcpu_ptrauth_allowed(struct kvm_vcpu *vcpu)
>> +{
>> +	return false;
>> +}
> 
> It seems like this is only ever called from arm64 code, so do we need an
> arch/arm/ definition?
Yes not required. Nice catch.
> 
>> +/**
>> + * kvm_arm_vcpu_ptrauth_allowed - checks if ptrauth feature is present in vcpu
>> + *
>> + * @vcpu: The VCPU pointer
>> + *
>> + * This function will be used to enable/disable ptrauth in guest as configured
>> + * by the KVM userspace API.
>> + */
>> +bool kvm_arm_vcpu_ptrauth_allowed(struct kvm_vcpu *vcpu)
>> +{
>> +	return test_bit(KVM_ARM_VCPU_PTRAUTH, vcpu->arch.features);
>> +}
> 
> I'm not sure, but should there also be something like
> 
> if (test_bit(KVM_ARM_VCPU_PTRAUTH, vcpu->arch.features) &&
>      !kvm_supports_ptrauth())
> 	return -EINVAL;
> 
> in kvm_reset_vcpu?
Yes makes sense. I missed it and with Dave martin patch this may be done 
cleanly.

Thanks,
Amit D

> 
> Thanks,
> Kristina
> 
