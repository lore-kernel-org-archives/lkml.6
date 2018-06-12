Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4C183C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02637208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02637208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934030AbeFLO4L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:56:11 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8666 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933338AbeFLO4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:56:10 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DC261DDC87C21;
        Tue, 12 Jun 2018 22:55:51 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.382.0; Tue, 12 Jun 2018
 22:55:51 +0800
Subject: Re: [PATCH RESEND v4 2/2] arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS
To:     James Morse <james.morse@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     <rkrcmar@redhat.com>, <corbet@lwn.net>, <christoffer.dall@arm.com>,
        <linux@armlinux.org.uk>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <kvm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
References: <1528487320-2873-1-git-send-email-gengdongjiu@huawei.com>
 <1528487320-2873-3-git-send-email-gengdongjiu@huawei.com>
 <86zi04875t.wl-marc.zyngier@arm.com>
 <af93e4b1-80d5-33be-d5ed-312c3ea1d715@arm.com>
From:   gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <0c604169-573c-126c-7715-d75bf2a1c319@huawei.com>
Date:   Tue, 12 Jun 2018 22:53:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <af93e4b1-80d5-33be-d5ed-312c3ea1d715@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/6/11 21:36, James Morse wrote:
> Hi Dongjiu Geng,
> 
> On 09/06/18 13:40, Marc Zyngier wrote:
>> On Fri, 08 Jun 2018 20:48:40 +0100, Dongjiu Geng wrote:
>>> For the migrating VMs, user space may need to know the exception
>>> state. For example, in the machine A, KVM make an SError pending,
>>> when migrate to B, KVM also needs to pend an SError.
>>>
>>> This new IOCTL exports user-invisible states related to SError.
>>> Together with appropriate user space changes, user space can get/set
>>> the SError exception state to do migrate/snapshot/suspend.
> 
>>> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
>>> index 04b3256..df4faee 100644
>>> --- a/arch/arm64/include/uapi/asm/kvm.h
>>> +++ b/arch/arm64/include/uapi/asm/kvm.h
>>> @@ -153,6 +154,18 @@ struct kvm_sync_regs {
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
> 
>>> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
>>> index 56a0260..4426915 100644
>>> --- a/arch/arm64/kvm/guest.c
>>> +++ b/arch/arm64/kvm/guest.c
> 
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
>>> +	} else if (serror_pending) {
>>> +		kvm_inject_vabt(vcpu);
>>> +	}
>>> +
>>> +	return 0;
>>
>> There was an earlier request to check that all the padding is set to
>> zero. I still think this makes sense.
> 
> I agree, not just the exception.padding[], but reserved[] too.
  Ok, thanks for the reminder again.

> 
> 
> Thanks,
> 
> James
> 
> .
> 

