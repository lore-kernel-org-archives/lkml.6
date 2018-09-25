Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D51C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7388120877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 10:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7388120877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbeIYQba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:31:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48518 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbeIYQba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:31:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AE3AED1;
        Tue, 25 Sep 2018 03:24:38 -0700 (PDT)
Received: from [192.168.0.21] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37AE73F5B7;
        Tue, 25 Sep 2018 03:24:35 -0700 (PDT)
Subject: Re: [PATCH v5 17/18] kvm: arm64: Limit the minimum number of page
 table levels
To:     Auger Eric <eric.auger@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        marc.zyngier@arm.com, cdall@kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, will.deacon@arm.com, catalin.marinas@arm.com,
        james.morse@arm.com, dave.martin@arm.com, julien.grall@arm.com,
        linux-kernel@vger.kernel.org
References: <20180917104144.19188-1-suzuki.poulose@arm.com>
 <20180917104144.19188-18-suzuki.poulose@arm.com>
 <59231541-311f-e04b-3e6b-e073a8392316@redhat.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <1486a576-dc71-9b88-688f-317fb662ff69@arm.com>
Date:   Tue, 25 Sep 2018 11:25:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <59231541-311f-e04b-3e6b-e073a8392316@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/2018 11:00 AM, Auger Eric wrote:
> Hi Suzuki,
> 
> On 9/17/18 12:41 PM, Suzuki K Poulose wrote:
>> Since we are about to remove the lower limit on the IPA size,
>> make sure that we do not go to 1 level page table (e.g, with
>> 32bit IPA on 64K host with concatenation) to avoid splitting
>> the host PMD huge pages at stage2.
>>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <cdall@kernel.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/include/asm/stage2_pgtable.h |  8 +++++++-
>>   arch/arm64/kvm/reset.c                  | 12 +++++++++++-
>>   2 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/stage2_pgtable.h b/arch/arm64/include/asm/stage2_pgtable.h
>> index 352ec4158fdf..6a56fdff0823 100644
>> --- a/arch/arm64/include/asm/stage2_pgtable.h
>> +++ b/arch/arm64/include/asm/stage2_pgtable.h
>> @@ -72,8 +72,14 @@
>>   /*
>>    * The number of PTRS across all concatenated stage2 tables given by the
>>    * number of bits resolved at the initial level.
>> + * If we force more number of levels than necessary, we may have
> more levels?


>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> index 76972b19bdd7..0393bb974b23 100644
>> --- a/arch/arm64/kvm/reset.c
>> +++ b/arch/arm64/kvm/reset.c

>> @@ -210,7 +219,8 @@ int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)
>>   	vtcr |= (kvm_get_vmid_bits() == 16) ?
>>   		VTCR_EL2_VS_16BIT :
>>   		VTCR_EL2_VS_8BIT;
>> -	vtcr |= VTCR_EL2_LVLS_TO_SL0(stage2_pgtable_levels(KVM_PHYS_SHIFT));
>> +
> nit: new line not requested
> 

Fixed all the above

Suzuki
