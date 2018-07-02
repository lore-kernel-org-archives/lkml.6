Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9442DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2D6254DA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2D6254DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933324AbeGBK77 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:59:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57326 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752303AbeGBK7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:59:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B0B618A;
        Mon,  2 Jul 2018 03:59:53 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50A433F5BA;
        Mon,  2 Jul 2018 03:59:51 -0700 (PDT)
Subject: Re: [PATCH v3 07/20] kvm: arm/arm64: Prepare for VM specific stage2
 translations
To:     Auger Eric <eric.auger@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
        marc.zyngier@arm.com, cdall@kernel.org, julien.grall@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com,
        punit.agrawal@arm.com, qemu-devel@nongnu.org
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-8-git-send-email-suzuki.poulose@arm.com>
 <b7ac3ae6-1544-b402-c1ea-90c2fa433783@redhat.com>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <66777270-89c9-efdf-450c-ba940d3a09d9@arm.com>
Date:   Mon, 2 Jul 2018 11:59:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <b7ac3ae6-1544-b402-c1ea-90c2fa433783@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Eric,

On 02/07/18 11:51, Auger Eric wrote:
> Hi Suzuki,
> 
> On 06/29/2018 01:15 PM, Suzuki K Poulose wrote:
>> Right now the stage2 page table for a VM is hard coded, assuming
>> an IPA of 40bits. As we are about to add support for per VM IPA,
>> prepare the stage2 page table helpers to accept the kvm instance
>> to make the right decision for the VM. No functional changes.
>> Adds stage2_pgd_size(kvm) to replace S2_PGD_SIZE. Also, moves
>> some of the definitions dependent on kvm instance to asm/kvm_mmu.h
>> for arm32. In that process drop the _AC() specifier constants
>>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <cdall@kernel.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Changes since V2:
>>   - Update commit description abuot the movement to asm/kvm_mmu.h
>>     for arm32
>>   - Drop _AC() specifiers


>> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
>> index 8553d68..f36eb20 100644
>> --- a/arch/arm/include/asm/kvm_mmu.h
>> +++ b/arch/arm/include/asm/kvm_mmu.h
>> @@ -36,15 +36,19 @@
>>   	})
>>   
>>   /*
>> - * KVM_MMU_CACHE_MIN_PAGES is the number of stage2 page table translation levels.
>> + * kvm_mmu_cache_min_pages() is the number of stage2 page
>> + * table translation levels, excluding the top level, for
>> + * the given VM. Since we have a 3 level page-table, this
>> + * is fixed.
>>    */
>> -#define KVM_MMU_CACHE_MIN_PAGES	2
>> +#define kvm_mmu_cache_min_pages(kvm)	2
> nit: In addition to Marc'c comment, I can see it defined in
> stage2_pgtable.h on arm64 side. Can't we align?

Sure, will do that.

>> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
>> index fb9a712..5da8f52 100644
>> --- a/arch/arm64/include/asm/kvm_mmu.h
>> +++ b/arch/arm64/include/asm/kvm_mmu.h
>> @@ -141,8 +141,11 @@ static inline unsigned long __kern_hyp_va(unsigned long v)
>>    * We currently only support a 40bit IPA.
>>    */
>>   #define KVM_PHYS_SHIFT	(40)
>> -#define KVM_PHYS_SIZE	(1UL << KVM_PHYS_SHIFT)
>> -#define KVM_PHYS_MASK	(KVM_PHYS_SIZE - 1UL)
>> +
>> +#define kvm_phys_shift(kvm)		KVM_PHYS_SHIFT
>> +#define kvm_phys_size(kvm)		(_AC(1, ULL) << kvm_phys_shift(kvm))
> Can't you get rid of _AC() also in arm64 case?
> 

>> +#define kvm_phys_mask(kvm)		(kvm_phys_size(kvm) - _AC(1, ULL))

Yes, that missed. I will do it. Thanks for spotting.

Cheers
Suzuki

