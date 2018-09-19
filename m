Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467B4C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3842214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 10:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3842214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbeISPj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:39:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57018 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbeISPj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:39:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C167A7A9;
        Wed, 19 Sep 2018 03:02:16 -0700 (PDT)
Received: from [10.37.10.80] (unknown [10.37.10.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8B273F703;
        Wed, 19 Sep 2018 03:02:13 -0700 (PDT)
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
 <fec1a2e0-a45a-eb51-6ffe-2ac9b35acc45@arm.com>
 <CAFEAcA_tphfZ_BKfAYuefStTipta0notyAR=NCnWFJ6nRfERpg@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <e818aa74-a34e-91fa-ad5a-344816105840@arm.com>
Date:   Wed, 19 Sep 2018 11:03:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_tphfZ_BKfAYuefStTipta0notyAR=NCnWFJ6nRfERpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/2018 06:15 PM, Peter Maydell wrote:
> On 18 September 2018 at 17:27, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
>> ---
>>
>> "On arm64, the physical address size for a VM (IPA Size limit) is limited
>> to 40bits by default. The limit can be configured if the host supports the
>> extension KVM_CAP_ARM_VM_IPA_SIZE. When supported, use
>> KVM_VM_TYPE_ARM_IPA_SIZE(IPA_Bits) to set the size in the machine type
>> identifier, where IPA_Bits is the maximum width of any physical
>> address used by the VM. The IPA_Bits is encoded in bits[7-0] of the
>> machine type identifier.
>>
>> e.g, to configure a guest to use 48bit physical address size :
>>
>>          vm_fd = ioctl(dev_fd, KVM_CREATE_VM, KVM_VM_TYPE_ARM_IPA_SIZE(48));
>>
>> The requested size (IPA_Bits) must be :
>>    0 - Implies default 40bits (for backward compatibility)
>>
>>    or
>>
>>    N - Implies N bits, where N is a positive integer such that 32 <= N <=
>> Host_IPA_Limit
>>
>> Host_IPA_Limit is the maximum possible value for IPA_Bits on the host and
>> is dependent on the CPU capability and the kernel configuration. The limit
>> can
>> be retrieved using KVM_CAP_ARM_VM_IPA_SIZE of the KVM_CHECK_EXTENSION
>> ioctl() at run-time.
>>
>> Please note that configuring the IPA size does not affect the capability
>> exposed by the guest CPUs in ID_AA64MMFR0_EL1[PARange]. It only affects
>> the guest to host physical address (stage2) translations setup by the host.
>> "
> 
> Thanks, this is much clearer. The only bit I'm not sure about is that
> last paragraph -- if I ask for a VM with a 48 bit address space why
> don't we tell the guest that that's what it has ?

The point is the IPA Size is not a limit on the CPU's PA size. e.g, if
this guest was a nested hypervisor with 48bit IPA, it could still
support a 52bit IPA nested guest within by simply looking up the CPU
PARange. The IPA size configuration here is simply a hint to the
hypervisor on where the memory banks would be kept. And this certainly
true on real platforms (e.g, my Juno has 42bit PARange on A57, while
A53 reports 40bit, with PA max at 40bits).

Suzuki
