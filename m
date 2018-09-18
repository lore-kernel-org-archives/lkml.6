Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29FCECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97842214FA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97842214FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbeIRUtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:49:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46420 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727756AbeIRUtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:49:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BE4E7A9;
        Tue, 18 Sep 2018 08:16:31 -0700 (PDT)
Received: from [10.4.13.23] (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF2DE3F5BD;
        Tue, 18 Sep 2018 08:16:28 -0700 (PDT)
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
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
Message-ID: <218b64d5-741d-97ef-8aae-bc0a2ac3e56c@arm.com>
Date:   Tue, 18 Sep 2018 16:16:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8eWYkzwFYHyP49dasK-NDVbbm=6DbEFNNPq9ZAdUM7JQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 18/09/2018 02:55, Peter Maydell wrote:
> On 17 September 2018 at 11:41, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -122,6 +122,14 @@ the default trap & emulate implementation (which changes the virtual
>>   memory layout to fit in user mode), check KVM_CAP_MIPS_VZ and use the
>>   flag KVM_VM_MIPS_VZ.
>>
>> +To configure the physical address space size for a VM (IPA size) on arm64,
>> +check KVM_CAP_ARM_VM_PHYS_SHIFT (which returns the maximum limit for the
>> +IPA shift) and use KVM_VM_TYPE_ARM_PHYS_SHIFT(PHYS_SHIFT). Bits[7-0] of the
>> +machine type has been reserved for specifying the PHYS_SHIFT.
>> +The supported range is [32...IPA_LIMIT], where IPA_LIMIT could be
>> +identified by checking KVM_CAP_ARM_VM_PHYS_SHIFT. For backward compatibility
>> +a value of 0 selects 40bits.
>> +
> 
> Given this as the API documentation, I don't think I could figure out
> what I as a userspace user of it need to do without looking at the
> kernel code. Could I ask you to expand it so that it is a bit less
> terse and a bit more detailed? (For instance, what is a PHYS_SHIFT
> and why do I have to specify it rather than just telling the kernel
> I want a 48 bit guest address space?)

Thanks for the feedback.  I acknowledge that the documentation is not
quite clear for a userspace user. How about:

"To configure the physical address space size for a VM (IPA size) on arm64,
check KVM_CAP_ARM_VM_IPA_SIZE and use KVM_VM_TYPE_ARM_IPA_SIZE(IPA_Bits)
as the argument to KVM_CREATE_VM, where IPA_Bits is the maximum width of
any physical address used by the VM. The IPA_Bits is encoded in Bits[7-0]
of the machine type, and must be one of { 0, 32, ... , Host_IPA_Limit },
where :
1) IPA_Bits = 0 implies 40bits IPA (for backward compatibility)
2) Host_IPA_Limit is the maximum limit for IPA_Bits on the host, which is
    dependent on the CPU capability and the host kernel configuration.
    This can be detected by checking the extension KVM_CAP_ARM_VM_IPA_SIZE
"

note: I have renamed the KVM_CAP_ARM_VM_PHYS_SHIFT => KVM_CAP_ARM_VM_IPA_SIZE
above and can update the code, if the latter is better.

Suzuki
