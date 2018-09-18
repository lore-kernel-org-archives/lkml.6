Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BF5ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EA721502
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0EA721502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbeIRWAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:00:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47658 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728982AbeIRWAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:00:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3667F7A9;
        Tue, 18 Sep 2018 09:27:26 -0700 (PDT)
Received: from [10.4.13.23] (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC05E3F5BD;
        Tue, 18 Sep 2018 09:27:23 -0700 (PDT)
Subject: Re: [PATCH v5 18/18] kvm: arm64: Allow tuning the physical address
 size for VM
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, kvm-devel <kvm@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <cdall@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Dave P Martin <dave.martin@arm.com>, julien.grall@arm.com,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180917104144.19188-1-suzuki.poulose@arm.com>
 <20180917104144.19188-19-suzuki.poulose@arm.com>
 <CAFEAcA8eWYkzwFYHyP49dasK-NDVbbm=6DbEFNNPq9ZAdUM7JQ@mail.gmail.com>
 <218b64d5-741d-97ef-8aae-bc0a2ac3e56c@arm.com>
 <CAFEAcA8qjJJ0FkQj4yBMKFrwNFiJj3Q4FBi4GbnK2PN3B3J-mg@mail.gmail.com>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <fec1a2e0-a45a-eb51-6ffe-2ac9b35acc45@arm.com>
Date:   Tue, 18 Sep 2018 17:27:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8qjJJ0FkQj4yBMKFrwNFiJj3Q4FBi4GbnK2PN3B3J-mg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 18/09/18 16:36, Peter Maydell wrote:
> On 18 September 2018 at 16:16, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
>> Hi Peter,
>>
>> On 18/09/2018 02:55, Peter Maydell wrote:
>>>
>>> On 17 September 2018 at 11:41, Suzuki K Poulose <suzuki.poulose@arm.com>
>>> wrote:
>>>>
>>>> --- a/Documentation/virtual/kvm/api.txt
>>>> +++ b/Documentation/virtual/kvm/api.txt
>>>> @@ -122,6 +122,14 @@ the default trap & emulate implementation (which
>>>> changes the virtual
>>>>    memory layout to fit in user mode), check KVM_CAP_MIPS_VZ and use the
>>>>    flag KVM_VM_MIPS_VZ.
>>>>
>>>> +To configure the physical address space size for a VM (IPA size) on
>>>> arm64,
>>>> +check KVM_CAP_ARM_VM_PHYS_SHIFT (which returns the maximum limit for the
>>>> +IPA shift) and use KVM_VM_TYPE_ARM_PHYS_SHIFT(PHYS_SHIFT). Bits[7-0] of
>>>> the
>>>> +machine type has been reserved for specifying the PHYS_SHIFT.
>>>> +The supported range is [32...IPA_LIMIT], where IPA_LIMIT could be
>>>> +identified by checking KVM_CAP_ARM_VM_PHYS_SHIFT. For backward
>>>> compatibility
>>>> +a value of 0 selects 40bits.
>>>> +
>>>
>>>
>>> Given this as the API documentation, I don't think I could figure out
>>> what I as a userspace user of it need to do without looking at the
>>> kernel code. Could I ask you to expand it so that it is a bit less
>>> terse and a bit more detailed? (For instance, what is a PHYS_SHIFT
>>> and why do I have to specify it rather than just telling the kernel
>>> I want a 48 bit guest address space?)
>>
>>
>> Thanks for the feedback.  I acknowledge that the documentation is not
>> quite clear for a userspace user. How about:
>>
>> "To configure the physical address space size for a VM (IPA size) on arm64,
>> check KVM_CAP_ARM_VM_IPA_SIZE and use KVM_VM_TYPE_ARM_IPA_SIZE(IPA_Bits)
>> as the argument to KVM_CREATE_VM, where IPA_Bits is the maximum width of
>> any physical address used by the VM. The IPA_Bits is encoded in Bits[7-0]
>> of the machine type, and must be one of { 0, 32, ... , Host_IPA_Limit },
>> where :
>> 1) IPA_Bits = 0 implies 40bits IPA (for backward compatibility)
>> 2) Host_IPA_Limit is the maximum limit for IPA_Bits on the host, which is
>>     dependent on the CPU capability and the host kernel configuration.
>>     This can be detected by checking the extension KVM_CAP_ARM_VM_IPA_SIZE
>> "
> 
> I think this is still somewhat confusing. In particular, you're
> describing both the "ask the kernel what it supports" API and
> the "tell the kernel what we want" API in a single sentence
> ("...check KVM_CAP_ARM_VM_IPA_SIZE and use KVM_VM_TYPE_ARM_IPA_SIZE...").
> There isn't a length limit on documentation, so why not describe
> them both clearly in separate sentences?

Sure, will do. I didn't want to hijack the KVM_CREATE_VM ioctl command
section to explain a kvm CAP.

> 
> Also, can I use any IPA value between 32 and Host_IPA_Limit, or
> are only certain values in that range supported (if so, which)?

Any value in the range is supported. I should probably add that
"The configured IPA size is different from what is observed by guest in
ID_AA64MMFR0_EL1[PARange] to avoid the confusion." So here it goes :

---

"On arm64, the physical address size for a VM (IPA Size limit) is limited
to 40bits by default. The limit can be configured if the host supports the
extension KVM_CAP_ARM_VM_IPA_SIZE. When supported, use
KVM_VM_TYPE_ARM_IPA_SIZE(IPA_Bits) to set the size in the machine type
identifier, where IPA_Bits is the maximum width of any physical
address used by the VM. The IPA_Bits is encoded in bits[7-0] of the
machine type identifier.

e.g, to configure a guest to use 48bit physical address size :

	vm_fd = ioctl(dev_fd, KVM_CREATE_VM, KVM_VM_TYPE_ARM_IPA_SIZE(48));

The requested size (IPA_Bits) must be :
   0 - Implies default 40bits (for backward compatibility)

   or

   N - Implies N bits, where N is a positive integer such that 32 <= N <= Host_IPA_Limit

Host_IPA_Limit is the maximum possible value for IPA_Bits on the host and
is dependent on the CPU capability and the kernel configuration. The limit can
be retrieved using KVM_CAP_ARM_VM_IPA_SIZE of the KVM_CHECK_EXTENSION
ioctl() at run-time.

Please note that configuring the IPA size does not affect the capability
exposed by the guest CPUs in ID_AA64MMFR0_EL1[PARange]. It only affects
the guest to host physical address (stage2) translations setup by the host.
"

Suzuki
