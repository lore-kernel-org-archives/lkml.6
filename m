Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56199C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E2E23E36
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E2E23E36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752973AbeGDP5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:57:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39890 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752260AbeGDP5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:57:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 926327A9;
        Wed,  4 Jul 2018 08:57:51 -0700 (PDT)
Received: from [192.168.0.21] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EE843F5AD;
        Wed,  4 Jul 2018 08:57:48 -0700 (PDT)
Subject: Re: [kvmtool test PATCH 24/24] kvmtool: arm: Add support for creating
 VM with PA size
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        james.morse@arm.com, marc.zyngier@arm.com, cdall@kernel.org,
        eric.auger@redhat.com, julien.grall@arm.com,
        catalin.marinas@arm.com, punit.agrawal@arm.com,
        qemu-devel@nongnu.org
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-25-git-send-email-suzuki.poulose@arm.com>
 <20180704142241.GG4828@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <66e93016-91bd-5fbb-2479-9f1d87795e5e@arm.com>
Date:   Wed, 4 Jul 2018 16:58:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180704142241.GG4828@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 07/04/2018 03:22 PM, Will Deacon wrote:
> On Fri, Jun 29, 2018 at 12:15:44PM +0100, Suzuki K Poulose wrote:
>> diff --git a/arm/kvm.c b/arm/kvm.c
>> index 5701d41..b1969be 100644
>> --- a/arm/kvm.c
>> +++ b/arm/kvm.c
>> @@ -11,6 +11,8 @@
>>   #include <linux/kvm.h>
>>   #include <linux/sizes.h>
>>   
>> +unsigned long kvm_arm_type;
>> +
>>   struct kvm_ext kvm_req_ext[] = {
>>   	{ DEFINE_KVM_EXT(KVM_CAP_IRQCHIP) },
>>   	{ DEFINE_KVM_EXT(KVM_CAP_ONE_REG) },
>> @@ -18,6 +20,26 @@ struct kvm_ext kvm_req_ext[] = {
>>   	{ 0, 0 },
>>   };
>>   
>> +#ifndef KVM_ARM_GET_MAX_VM_PHYS_SHIFT
>> +#define KVM_ARM_GET_MAX_VM_PHYS_SHIFT		_IO(KVMIO, 0x0b)
>> +#endif
>> +
>> +void kvm__arch_init_hyp(struct kvm *kvm)
>> +{
>> +	int max_ipa;
>> +
>> +	max_ipa = ioctl(kvm->sys_fd, KVM_ARM_GET_MAX_VM_PHYS_SHIFT);
>> +	if (max_ipa < 0)
>> +		max_ipa = 40;
>> +	if (!kvm->cfg.arch.phys_shift)
>> +		kvm->cfg.arch.phys_shift = 40;
>> +	if (kvm->cfg.arch.phys_shift > max_ipa)
>> +		die("Requested PA size (%u) is not supported by the host (%ubits)\n",
>> +		    kvm->cfg.arch.phys_shift, max_ipa);
>> +	if (kvm->cfg.arch.phys_shift != 40)
>> +		kvm_arm_type = kvm->cfg.arch.phys_shift;
>> +}
> 
> Seems a bit weird that the "machine type identifier" to KVM_CREATE_VM is
> dedicated entirely to holding the physical address shift verbatim. Is this
> really the ABI?

The bits[7:0] of the machine type has been reserved for the IPA shift.
This version is missing the updates to the ABI documentation, I have it
for the next version.

> 
> Also, couldn't KVM figure it out automatically if you add memslots at high
> addresses, making this a niche tunable outside of testing?

The stage2 pgd size is really dependent on the max IPA. Also, unlike the 
stage1 (where the maximum size will be 1 page), the size can go upto 16
pages (and different number of levels due to concatenation), so we need
to finalize this at least before the first memory gets mapped (RAM or 
Device). That implies, we cannot wait until all the memory slots are
created.

The first version of the series added a separate ioctl for specifying
the limit, which had its own complexities. So, this ABI was suggested
to keep things simpler.


Suzuki
