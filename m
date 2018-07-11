Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9B2C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947AA20881
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947AA20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388894AbeGKPK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:10:28 -0400
Received: from foss.arm.com ([217.140.101.70]:38226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732705AbeGKPK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:10:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF30D7A9;
        Wed, 11 Jul 2018 08:05:42 -0700 (PDT)
Received: from localhost (e105922-lin.cambridge.arm.com [10.1.206.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 705FB3F5B1;
        Wed, 11 Jul 2018 08:05:42 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, will.deacon@arm.com,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 4/7] KVM: arm64: Support PUD hugepage in stage2_is_exec()
References: <20180709143835.28971-1-punit.agrawal@arm.com>
        <20180709144124.29164-1-punit.agrawal@arm.com>
        <20180709144124.29164-4-punit.agrawal@arm.com>
        <ccf6c6a1-9df7-25a7-67c9-3b323486b3e5@arm.com>
Date:   Wed, 11 Jul 2018 16:05:40 +0100
In-Reply-To: <ccf6c6a1-9df7-25a7-67c9-3b323486b3e5@arm.com> (Suzuki
        K. Poulose's message of "Wed, 11 Jul 2018 14:41:29 +0100")
Message-ID: <87a7qxq0cb.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suzuki K Poulose <Suzuki.Poulose@arm.com> writes:

> On 09/07/18 15:41, Punit Agrawal wrote:
>> In preparation for creating PUD hugepages at stage 2, add support for
>> detecting execute permissions on PUD page table entries. Faults due to
>> lack of execute permissions on page table entries is used to perform
>> i-cache invalidation on first execute.
>>
>> Provide trivial implementations of arm32 helpers to allow sharing of
>> code.
>>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> ---
>>   arch/arm/include/asm/kvm_mmu.h         |  6 ++++
>>   arch/arm64/include/asm/kvm_mmu.h       |  5 +++
>>   arch/arm64/include/asm/pgtable-hwdef.h |  2 ++
>>   virt/kvm/arm/mmu.c                     | 49 +++++++++++++++++++++++---
>>   4 files changed, 57 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
>> index c23722f75d5c..d05c8986e495 100644
>> --- a/arch/arm/include/asm/kvm_mmu.h
>> +++ b/arch/arm/include/asm/kvm_mmu.h
>> @@ -96,6 +96,12 @@ static inline bool kvm_s2pud_readonly(pud_t *pud)
>>   }
>>     +static inline bool kvm_s2pud_exec(pud_t *pud)
>> +{
>> +	BUG();
>> +	return false;
>> +}
>> +
>>   static inline void kvm_set_pmd(pmd_t *pmd, pmd_t new_pmd)
>>   {
>>   	*pmd = new_pmd;
>> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
>> index 84051930ddfe..15bc1be8f82f 100644
>> --- a/arch/arm64/include/asm/kvm_mmu.h
>> +++ b/arch/arm64/include/asm/kvm_mmu.h
>> @@ -249,6 +249,11 @@ static inline bool kvm_s2pud_readonly(pud_t *pudp)
>>   	return kvm_s2pte_readonly((pte_t *)pudp);
>>   }
>>   +static inline bool kvm_s2pud_exec(pud_t *pudp)
>> +{
>> +	return !(READ_ONCE(pud_val(*pudp)) & PUD_S2_XN);
>> +}
>> +
>>   static inline bool kvm_page_empty(void *ptr)
>>   {
>>   	struct page *ptr_page = virt_to_page(ptr);
>> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
>> index fd208eac9f2a..10ae592b78b8 100644
>> --- a/arch/arm64/include/asm/pgtable-hwdef.h
>> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
>> @@ -193,6 +193,8 @@
>>   #define PMD_S2_RDWR		(_AT(pmdval_t, 3) << 6)   /* HAP[2:1] */
>>   #define PMD_S2_XN		(_AT(pmdval_t, 2) << 53)  /* XN[1:0] */
>>   +#define PUD_S2_XN		(_AT(pudval_t, 2) << 53)  /* XN[1:0]
>> */
>> +
>>   /*
>>    * Memory Attribute override for Stage-2 (MemAttr[3:0])
>>    */
>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>> index ed8f8271c389..e73909a31e02 100644
>> --- a/virt/kvm/arm/mmu.c
>> +++ b/virt/kvm/arm/mmu.c
>> @@ -1038,23 +1038,62 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
>>   	return 0;
>>   }
>>   -static bool stage2_is_exec(struct kvm *kvm, phys_addr_t addr)
>> +/*
>> + * stage2_get_leaf_entry - walk the stage2 VM page tables and return
>> + * true if a valid and present leaf-entry is found. A pointer to the
>> + * leaf-entry is returned in the appropriate level variable - pudpp,
>> + * pmdpp, ptepp.
>> + */
>> +static bool stage2_get_leaf_entry(struct kvm *kvm, phys_addr_t addr,
>> +				  pud_t **pudpp, pmd_t **pmdpp, pte_t **ptepp)
>>   {
>> +	pud_t *pudp;
>>   	pmd_t *pmdp;
>>   	pte_t *ptep;
>
> nit: As mentioned in the other thread, you may initialize the reference
> pointers to NULL to make sure we start clean and avoid the initialization
> everywhere this is called.

I took the approach to not touch the pointers unless they are being
assigned a valid pointer. I'll initialise the incoming pointers (p*dpp)
before proceeding with the table walk.

Thanks,
Punit

>
>>   -	pmdp = stage2_get_pmd(kvm, NULL, addr);
>> +	pudp = stage2_get_pud(kvm, NULL, addr);
>> +	if (!pudp || pud_none(*pudp) || !pud_present(*pudp))
>> +		return false;
>> +
>> +	if (pud_huge(*pudp)) {
>> +		*pudpp = pudp;
>> +		return true;
>> +	}
>> +
>> +	pmdp = stage2_pmd_offset(pudp, addr);
>>   	if (!pmdp || pmd_none(*pmdp) || !pmd_present(*pmdp))
>>   		return false;
>>   -	if (pmd_thp_or_huge(*pmdp))
>> -		return kvm_s2pmd_exec(pmdp);
>> +	if (pmd_thp_or_huge(*pmdp)) {
>> +		*pmdpp = pmdp;
>> +		return true;
>> +	}
>>     	ptep = pte_offset_kernel(pmdp, addr);
>>   	if (!ptep || pte_none(*ptep) || !pte_present(*ptep))
>>   		return false;
>>   -	return kvm_s2pte_exec(ptep);
>> +	*ptepp = ptep;
>> +	return true;
>> +}
>> +
>> +static bool stage2_is_exec(struct kvm *kvm, phys_addr_t addr)
>> +{
>> +	pud_t *pudp = NULL;
>> +	pmd_t *pmdp = NULL;
>> +	pte_t *ptep = NULL;
>> +	bool found;
>> +
>> +	found = stage2_get_leaf_entry(kvm, addr, &pudp, &pmdp, &ptep);
>> +	if (!found)
>> +		return false;
>> +
>> +	if (pudp)
>> +		return kvm_s2pud_exec(pudp);
>> +	else if (pmdp)
>> +		return kvm_s2pmd_exec(pmdp);
>> +	else
>> +		return kvm_s2pte_exec(ptep);
>>   }
>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
