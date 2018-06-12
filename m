Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E8ACDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57D4208B6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57D4208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754384AbeFLPvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:51:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8667 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933469AbeFLPvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:51:11 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EB434B7472FE4;
        Tue, 12 Jun 2018 23:50:54 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.382.0; Tue, 12 Jun 2018
 23:50:54 +0800
Subject: Re: [PATCH RESEND v4 2/2] arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS
To:     James Morse <james.morse@arm.com>
CC:     <rkrcmar@redhat.com>, <corbet@lwn.net>, <christoffer.dall@arm.com>,
        <marc.zyngier@arm.com>, <linux@armlinux.org.uk>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
References: <1528487320-2873-1-git-send-email-gengdongjiu@huawei.com>
 <1528487320-2873-3-git-send-email-gengdongjiu@huawei.com>
 <45e94aae-ed9f-1fb7-f10e-d95c2f969ddd@arm.com>
 <f7f59176-16a1-3b24-5acc-87bf1b4c1490@huawei.com>
 <6887237f-d252-5b9e-02cb-5a44fef27080@arm.com>
From:   gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <2455dc33-ae8d-79e6-e915-4181050e1e65@huawei.com>
Date:   Tue, 12 Jun 2018 23:48:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6887237f-d252-5b9e-02cb-5a44fef27080@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/6/12 23:29, James Morse wrote:
> Hi gengdongjiu,
> 
> On 12/06/18 15:50, gengdongjiu wrote:
>> On 2018/6/11 21:36, James Morse wrote:
>>> On 08/06/18 20:48, Dongjiu Geng wrote:
>>>> For the migrating VMs, user space may need to know the exception
>>>> state. For example, in the machine A, KVM make an SError pending,
>>>> when migrate to B, KVM also needs to pend an SError.
>>>>
>>>> This new IOCTL exports user-invisible states related to SError.
>>>> Together with appropriate user space changes, user space can get/set
>>>> the SError exception state to do migrate/snapshot/suspend.
> 
> 
>>>> diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
>>>> index caae484..c3e6975 100644
>>>> --- a/arch/arm/include/uapi/asm/kvm.h
>>>> +++ b/arch/arm/include/uapi/asm/kvm.h
>>>> @@ -124,6 +124,18 @@ struct kvm_sync_regs {
>>>>  struct kvm_arch_memory_slot {
>>>>  };
>>>>  
>>>> +/* for KVM_GET/SET_VCPU_EVENTS */
>>>> +struct kvm_vcpu_events {
>>>> +	struct {
>>>> +		__u8 serror_pending;
>>>> +		__u8 serror_has_esr;
>>>> +		/* Align it to 8 bytes */
>>>> +		__u8 pad[6];
>>>> +		__u64 serror_esr;
>>>> +	} exception;
>>>> +	__u32 reserved[12];
>>>> +};
>>>> +
>>>
>>> You haven't defined __KVM_HAVE_VCPU_EVENTS for 32bit, so presumably this struct
>>> will never be used. Why is it here?
> 
>>   if not add it for 32 bits. the 32 arm platform will build Fail, whether you have good
>>    idea to avoid this Failure if not add this struct for the 32 bit?
> 
> How does this 32bit code build without this patch?
> If do you provide the struct, how will that code build with older headers?
> 
> As far as I can see, this is what the __KVM_HAVE_VCPU_EVENTS define is for.
> 
> This should be both, or neither. Having just the struct is useless.
It because the caller of kvm_arm_vcpu_get/set_events() is in "virt/kvm/arm/arm.c".
the virt/kvm/arm/arm.c will used by both arm64 and arm.
so It needs to add kvm_arm_vcpu_get/set_events() for the 32 bits, however, kvm_arm_vcpu_get/set_events() will directly return,

I attached the build erros below:
https://lkml.org/lkml/2018/6/4/918
https://lkml.org/lkml/2018/6/4/873


[..]
I will continue check below comments, thanks

