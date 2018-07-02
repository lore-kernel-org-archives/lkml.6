Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6B3C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AADD252EF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AADD252EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754529AbeGBJOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:14:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50983 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753281AbeGBJN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:13:56 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3A120D238697D;
        Mon,  2 Jul 2018 17:13:51 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.382.0; Mon, 2 Jul 2018
 17:13:47 +0800
Subject: Re: [PATCH v5 1/2] arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS
To:     James Morse <james.morse@arm.com>
CC:     <rkrcmar@redhat.com>, <corbet@lwn.net>, <christoffer.dall@arm.com>,
        <marc.zyngier@arm.com>, <linux@armlinux.org.uk>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
References: <1529960309-2513-1-git-send-email-gengdongjiu@huawei.com>
 <1529960309-2513-2-git-send-email-gengdongjiu@huawei.com>
 <ec201845-fd1e-fd0a-7dfe-bacf23bb44a2@arm.com>
From:   gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <606b9734-7f1f-5fc6-69e0-8f2c72f9fc55@huawei.com>
Date:   Mon, 2 Jul 2018 17:13:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ec201845-fd1e-fd0a-7dfe-bacf23bb44a2@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2018/6/29 23:59, James Morse wrote:
> Hi Dongjiu Geng,
> 
> On 25/06/18 21:58, Dongjiu Geng wrote:
>> For the migrating VMs, user space may need to know the exception
>> state. For example, in the machine A, KVM make an SError pending,
>> when migrate to B, KVM also needs to pend an SError.
>>
>> This new IOCTL exports user-invisible states related to SError.
>> Together with appropriate user space changes, user space can get/set
>> the SError exception state to do migrate/snapshot/suspend.
> 
> 
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 469de8a..357304a 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -335,6 +335,11 @@ unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
>>  int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
>>  int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
>>  int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
>> +int kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
>> +			struct kvm_vcpu_events *events);
>> +
>> +int kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
>> +			struct kvm_vcpu_events *events);
>>  
> 
> (Nit: funny indentation)

The indentation is in order to not over 80 characters, I will change it as below to make it more reasonable

 +int kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
 +			      struct kvm_vcpu_events *events);
 +
 +int kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 +			      struct kvm_vcpu_events *events);

> 
> 
>> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
>> index 56a0260..8be14cc 100644
>> --- a/arch/arm64/kvm/guest.c
>> +++ b/arch/arm64/kvm/guest.c
>> @@ -289,6 +289,49 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
> 
>> +int kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
>> +			struct kvm_vcpu_events *events)
>> +{
>> +	int i;
>> +	bool serror_pending = events->exception.serror_pending;
>> +	bool has_esr = events->exception.serror_has_esr;
>> +
>> +	/* check whether the reserved field is zero */
>> +	for (i = 0; i < ARRAY_SIZE(events->reserved); i++)
>> +		if (events->reserved[i])
>> +			return -EINVAL;
>> +
>> +	/* check whether the pad field is zero */
>> +	for (i = 0; i < ARRAY_SIZE(events->exception.pad); i++)
>> +		if (events->exception.pad[i])
>> +			return -EINVAL;
>> +
>> +	if (serror_pending && has_esr) {
>> +		if (!cpus_have_const_cap(ARM64_HAS_RAS_EXTN))
>> +			return -EINVAL;
>> +
> 
>> +		kvm_set_sei_esr(vcpu, events->exception.serror_esr);
> 
> This silently discards all but the bottom 24 bits of serror_esr.
> 
> It makes sense that this field is 64 bit, because the register is 64 bit, and it
> would let us use this API to migrate any new state that appears in the higher
> bits... But those bits will come with an ID/feature field, we shouldn't accept
> an attempt to restore them on a CPU that doesn't support the feature. If that
> happens here, it silently succeeds, but the kernel just threw the extra bits away.
> 
> You added documentation that only the bottom 24bits can be set, can we add
> checks to enforce this, so the bits can be used later.
yes, sure! I will check it. thanks for the suggestion.


> 
> 
>> +	} else if (serror_pending) {
>> +		kvm_inject_vabt(vcpu);
>> +	}
>> +
>> +	return 0;
>> +}
> 
>> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
>> index a4c1b76..4e6f366 100644
>> --- a/virt/kvm/arm/arm.c
>> +++ b/virt/kvm/arm/arm.c
>> @@ -1107,6 +1107,27 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>>  		r = kvm_arm_vcpu_has_attr(vcpu, &attr);
>>  		break;
>>  	}
>> +#ifdef __KVM_HAVE_VCPU_EVENTS
> 
> So its this #ifdef, or a uapi struct for a feature 32bit doesn't support.
> I think the right thing to do is wire this up for 32bit, it also calls
> kvm_inject_vabt() in handle_exit.c, so must have the same migration problems.
> 
> I'll post a patch to do this as I've got something I can test it on.
Ok, so here I will temporarily use "#ifdef __KVM_HAVE_VCPU_EVENTS" to avoid the 32bit platform build errors,
when you post a new patch, you can remove the "#ifdef". thanks.


> 
> 
>> +	case KVM_GET_VCPU_EVENTS: {
>> +		struct kvm_vcpu_events events;
>> +
>> +		if (kvm_arm_vcpu_get_events(vcpu, &events))
>> +			return -EINVAL;
>> +
>> +		if (copy_to_user(argp, &events, sizeof(events)))
>> +			return -EFAULT;
>> +
>> +		return 0;
>> +	}
>> +	case KVM_SET_VCPU_EVENTS: {
>> +		struct kvm_vcpu_events events;
>> +
>> +		if (copy_from_user(&events, argp, sizeof(events)))
>> +			return -EFAULT;
>> +
>> +		return kvm_arm_vcpu_set_events(vcpu, &events);
>> +	}
>> +#endif
> 
> (It bugs me that the architecture has some rules about merging multiple
> architected ESR values, that we neither enforce, nor document as user-space's
> problem. It doesn't matter for RAS, but might for any future ESR encodings. But
> I guess user-space wouldn't be aware of them anyway, and it can already put
> bogus values in SPSR/ESR/ELR etc.)
> 
> 
> With a check against the top bits of ESR:
> Reviewed-by: James Morse <james.morse@arm.com>
Thanks for this "Reviewed-by", I will check against the top bits of ESR

> 
> 
> Thanks,
> 
> James
> 
> .
> 

