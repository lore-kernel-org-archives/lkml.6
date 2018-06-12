Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 30700C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E27208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E27208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934109AbeFLP3k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:29:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35388 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932803AbeFLP3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:29:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47CA81529;
        Tue, 12 Jun 2018 08:29:37 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32A433F557;
        Tue, 12 Jun 2018 08:29:35 -0700 (PDT)
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
From:   James Morse <james.morse@arm.com>
Message-ID: <6887237f-d252-5b9e-02cb-5a44fef27080@arm.com>
Date:   Tue, 12 Jun 2018 16:29:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <f7f59176-16a1-3b24-5acc-87bf1b4c1490@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi gengdongjiu,

On 12/06/18 15:50, gengdongjiu wrote:
> On 2018/6/11 21:36, James Morse wrote:
>> On 08/06/18 20:48, Dongjiu Geng wrote:
>>> For the migrating VMs, user space may need to know the exception
>>> state. For example, in the machine A, KVM make an SError pending,
>>> when migrate to B, KVM also needs to pend an SError.
>>>
>>> This new IOCTL exports user-invisible states related to SError.
>>> Together with appropriate user space changes, user space can get/set
>>> the SError exception state to do migrate/snapshot/suspend.


>>> diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
>>> index caae484..c3e6975 100644
>>> --- a/arch/arm/include/uapi/asm/kvm.h
>>> +++ b/arch/arm/include/uapi/asm/kvm.h
>>> @@ -124,6 +124,18 @@ struct kvm_sync_regs {
>>>  struct kvm_arch_memory_slot {
>>>  };
>>>  
>>> +/* for KVM_GET/SET_VCPU_EVENTS */
>>> +struct kvm_vcpu_events {
>>> +	struct {
>>> +		__u8 serror_pending;
>>> +		__u8 serror_has_esr;
>>> +		/* Align it to 8 bytes */
>>> +		__u8 pad[6];
>>> +		__u64 serror_esr;
>>> +	} exception;
>>> +	__u32 reserved[12];
>>> +};
>>> +
>>
>> You haven't defined __KVM_HAVE_VCPU_EVENTS for 32bit, so presumably this struct
>> will never be used. Why is it here?

>   if not add it for 32 bits. the 32 arm platform will build Fail, whether you have good
>    idea to avoid this Failure if not add this struct for the 32 bit?

How does this 32bit code build without this patch?
If do you provide the struct, how will that code build with older headers?

As far as I can see, this is what the __KVM_HAVE_VCPU_EVENTS define is for.

This should be both, or neither. Having just the struct is useless.


>>> +int kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
>>> +			struct kvm_vcpu_events *events)
>>> +{
>>> +	bool serror_pending = events->exception.serror_pending;
>>> +	bool has_esr = events->exception.serror_has_esr;
>>> +
>>> +	if (serror_pending && has_esr) {
>>> +		if (!cpus_have_const_cap(ARM64_HAS_RAS_EXTN))
>>> +			return -EINVAL;
>>> +
>>> +		kvm_set_sei_esr(vcpu, events->exception.serror_esr);
>>
>> kvm_set_sei_esr() will silently discard the top 40 bits of serror_esr, (which is
>> correct, we shouldn't copy them into hardware without know what they do).
>>
>> Could we please force user-space to zero these bits, we can advertise extra CAPs
>> if new features turn up in that space, instead of user-space passing <something>
>> and relying on the kernel to remove it.
> 
>   yes, I can zero these bits in the  user-space and not depend on kernel to remove it.

But the kernel must check that user-space did zero those bits. Otherwise
user-space may start using them when a future version of the architecture gives
them a meaning, but an older kernel version doesn't know it has to do extra
work, but still lets the bits from user-space through into the hardware.

If new bits do turn up, we can advertise a CAP that says that KVM supports
whatever that feature is.


>> (Background: VSESR is a 64bit register that holds the value to go in a 32bit
>> register. I suspect the top-half could get re-used for control values or
>> something we don't want to give user-space)

>   do you mean when user-space get the VSESR value through KVM_GET_VCPU_EVENTS
> it only return the low-half 32 bits?

No, the kernel will only ever set a 24bit value here. If we force user-space to
only provide a 24bit value then we don't need to check it on read. We never read
the value back from hardware.

These high bits are RES0 at the moment, they may get used for something in the
future. As we are exposing this via a user-space ABI we need to make sure we
only expose the bits we understand today.


Thanks,

James
