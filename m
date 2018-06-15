Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 81260C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3DE208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3DE208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965974AbeFOP5z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 11:57:55 -0400
Received: from foss.arm.com ([217.140.101.70]:43846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965593AbeFOP5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 11:57:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AB271529;
        Fri, 15 Jun 2018 08:57:53 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADBE43F557;
        Fri, 15 Jun 2018 08:57:50 -0700 (PDT)
Subject: Re: [PATCH RESEND v4 2/2] arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS
To:     gengdongjiu <gengdongjiu@huawei.com>
Cc:     rkrcmar@redhat.com, corbet@lwn.net, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <1528487320-2873-1-git-send-email-gengdongjiu@huawei.com>
 <1528487320-2873-3-git-send-email-gengdongjiu@huawei.com>
 <45e94aae-ed9f-1fb7-f10e-d95c2f969ddd@arm.com>
 <f7f59176-16a1-3b24-5acc-87bf1b4c1490@huawei.com>
 <6887237f-d252-5b9e-02cb-5a44fef27080@arm.com>
 <2455dc33-ae8d-79e6-e915-4181050e1e65@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <9e5be3fe-e6df-ca56-5eab-9ab7e18d9a99@arm.com>
Date:   Fri, 15 Jun 2018 16:57:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <2455dc33-ae8d-79e6-e915-4181050e1e65@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi gengdongjiu,

On 12/06/18 16:48, gengdongjiu wrote:
> On 2018/6/12 23:29, James Morse wrote:
>> On 12/06/18 15:50, gengdongjiu wrote:
>>> On 2018/6/11 21:36, James Morse wrote:
>>>> On 08/06/18 20:48, Dongjiu Geng wrote:
>>>>> diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
>>>>> index caae484..c3e6975 100644
>>>>> --- a/arch/arm/include/uapi/asm/kvm.h
>>>>> +++ b/arch/arm/include/uapi/asm/kvm.h
>>>>> @@ -124,6 +124,18 @@ struct kvm_sync_regs {
>>>>>  struct kvm_arch_memory_slot {
>>>>>  };
>>>>>  
>>>>> +/* for KVM_GET/SET_VCPU_EVENTS */
>>>>> +struct kvm_vcpu_events {
>>>>> +	struct {
>>>>> +		__u8 serror_pending;
>>>>> +		__u8 serror_has_esr;
>>>>> +		/* Align it to 8 bytes */
>>>>> +		__u8 pad[6];
>>>>> +		__u64 serror_esr;
>>>>> +	} exception;
>>>>> +	__u32 reserved[12];
>>>>> +};
>>>>> +
>>>>
>>>> You haven't defined __KVM_HAVE_VCPU_EVENTS for 32bit, so presumably this struct
>>>> will never be used. Why is it here?
>>
>>>   if not add it for 32 bits. the 32 arm platform will build Fail, whether you have good
>>>    idea to avoid this Failure if not add this struct for the 32 bit?
>>
>> How does this 32bit code build without this patch?
>> If do you provide the struct, how will that code build with older headers?
>>
>> As far as I can see, this is what the __KVM_HAVE_VCPU_EVENTS define is for.
>>
>> This should be both, or neither. Having just the struct is useless.
> It because the caller of kvm_arm_vcpu_get/set_events() is in "virt/kvm/arm/arm.c".
> the virt/kvm/arm/arm.c will used by both arm64 and arm.
> so It needs to add kvm_arm_vcpu_get/set_events() for the 32 bits, however, kvm_arm_vcpu_get/set_events() will directly return,

So you are adding a uapi struct that user-space can't actually use, to avoid a
kernel build-error. Fine, it just looks really strange.

32bit user-space shouldn't try to call this as check-extension reports it as not
present. If it does, it gets -EINVAL back, which is also the default for
kvm_arch_vcpu_ioctl().


Thanks,

James
