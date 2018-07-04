Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1850C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 22:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7309D216F9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 22:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7309D216F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752976AbeGDWCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 18:02:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43086 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752844AbeGDWCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 18:02:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC39418A;
        Wed,  4 Jul 2018 15:02:50 -0700 (PDT)
Received: from [10.37.10.44] (unknown [10.37.10.44])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BFB03F5A0;
        Wed,  4 Jul 2018 15:02:47 -0700 (PDT)
Subject: Re: [PATCH v3 15/20] kvm: arm/arm64: Allow tuning the physical
 address size for VM
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        james.morse@arm.com, marc.zyngier@arm.com, cdall@kernel.org,
        eric.auger@redhat.com, julien.grall@arm.com,
        catalin.marinas@arm.com, punit.agrawal@arm.com,
        qemu-devel@nongnu.org, Peter Maydel <peter.maydell@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-16-git-send-email-suzuki.poulose@arm.com>
 <20180704155104.GN4828@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <12d1832a-1a13-7dd4-662b-addf58400789@arm.com>
Date:   Wed, 4 Jul 2018 23:03:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180704155104.GN4828@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2018 04:51 PM, Will Deacon wrote:
> Hi Suzuki,
> 
> On Fri, Jun 29, 2018 at 12:15:35PM +0100, Suzuki K Poulose wrote:
>> Allow specifying the physical address size for a new VM via
>> the kvm_type argument for KVM_CREATE_VM ioctl. This allows
>> us to finalise the stage2 page table format as early as possible
>> and hence perform the right checks on the memory slots without
>> complication. The size is encoded as Log2(PA_Size) in the bits[7:0]
>> of the type field and can encode more information in the future if
>> required. The IPA size is still capped at 40bits.
>>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <cdall@kernel.org>
>> Cc: Peter Maydel <peter.maydell@linaro.org>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm/include/asm/kvm_mmu.h   |  2 ++
>>   arch/arm64/include/asm/kvm_arm.h | 10 +++-------
>>   arch/arm64/include/asm/kvm_mmu.h |  2 ++
>>   include/uapi/linux/kvm.h         | 10 ++++++++++
>>   virt/kvm/arm/arm.c               | 24 ++++++++++++++++++++++--
>>   5 files changed, 39 insertions(+), 9 deletions(-)
> 
> [...]
> 
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 4df9bb6..fa4cab0 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -751,6 +751,16 @@ struct kvm_ppc_resize_hpt {
>>   #define KVM_S390_SIE_PAGE_OFFSET 1
>>   
>>   /*
>> + * On arm/arm64, machine type can be used to request the physical
>> + * address size for the VM. Bits [7-0] have been reserved for the
>> + * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
>> + * value 0 implies the default IPA size, which is 40bits.
>> + */
>> +#define KVM_VM_TYPE_ARM_PHYS_SHIFT_MASK	0xff
>> +#define KVM_VM_TYPE_ARM_PHYS_SHIFT(x)		\
>> +	((x) & KVM_VM_TYPE_ARM_PHYS_SHIFT_MASK)
> 
> This seems like you're allocating quite a lot of bits in a non-extensible
> interface to a fairly esoteric parameter. Would it be better to add another
> ioctl, or condense the number of sizes you support instead?

As I explained in the other thread, we need the size as soon as the VM
is created. The major challenge is keeping the backward compatibility by
mapping 0 to 40bits. I will give it a thought.

Suzuki
