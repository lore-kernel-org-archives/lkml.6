Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014A6C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F1C20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F1C20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389684AbeGKQYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:24:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39796 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733247AbeGKQYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:24:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27B097A9;
        Wed, 11 Jul 2018 09:19:08 -0700 (PDT)
Received: from localhost (e105922-lin.cambridge.arm.com [10.1.206.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D1C33F589;
        Wed, 11 Jul 2018 09:19:07 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc:     marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
        will.deacon@arm.com, Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 7/7] KVM: arm64: Add support for creating PUD hugepages at stage 2
References: <20180709143835.28971-1-punit.agrawal@arm.com>
        <20180709144124.29164-1-punit.agrawal@arm.com>
        <20180709144124.29164-7-punit.agrawal@arm.com>
        <bbc3f286-be5b-d0dc-2037-54d5b995a0a5@arm.com>
        <87zhyxoize.fsf@e105922-lin.cambridge.arm.com>
        <fe8b92a1-2584-61ab-39e2-4d3247f92c7c@arm.com>
Date:   Wed, 11 Jul 2018 17:19:06 +0100
In-Reply-To: <fe8b92a1-2584-61ab-39e2-4d3247f92c7c@arm.com> (Suzuki
        K. Poulose's message of "Wed, 11 Jul 2018 17:13:54 +0100")
Message-ID: <87lgahoidh.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suzuki K Poulose <Suzuki.Poulose@arm.com> writes:

> On 11/07/18 17:05, Punit Agrawal wrote:
>> Suzuki K Poulose <Suzuki.Poulose@arm.com> writes:
>>
>>> On 09/07/18 15:41, Punit Agrawal wrote:
>>>> KVM only supports PMD hugepages at stage 2. Now that the various page
>>>> handling routines are updated, extend the stage 2 fault handling to
>>>> map in PUD hugepages.
>>>>
>>>> Addition of PUD hugepage support enables additional page sizes (e.g.,
>>>> 1G with 4K granule) which can be useful on cores that support mapping
>>>> larger block sizes in the TLB entries.
>>>>
>>>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>>>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>>> Cc: Russell King <linux@armlinux.org.uk>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>> ---
>>>>    arch/arm/include/asm/kvm_mmu.h         | 19 +++++++
>>>>    arch/arm64/include/asm/kvm_mmu.h       | 15 +++++
>>>>    arch/arm64/include/asm/pgtable-hwdef.h |  2 +
>>>>    arch/arm64/include/asm/pgtable.h       |  2 +
>>>>    virt/kvm/arm/mmu.c                     | 78 ++++++++++++++++++++++++--
>>>>    5 files changed, 112 insertions(+), 4 deletions(-)
>>>>
>>
>> [...]
>>
>>>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>>>> index a6d3ac9d7c7a..d8e2497e5353 100644
>>>> --- a/virt/kvm/arm/mmu.c
>>>> +++ b/virt/kvm/arm/mmu.c
>>
>> [...]
>>
>>>> @@ -1100,6 +1139,7 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
>>>>    			  phys_addr_t addr, const pte_t *new_pte,
>>>>    			  unsigned long flags)
>>>>    {
>>>> +	pud_t *pud;
>>>>    	pmd_t *pmd;
>>>>    	pte_t *pte, old_pte;
>>>>    	bool iomap = flags & KVM_S2PTE_FLAG_IS_IOMAP;
>>>> @@ -1108,6 +1148,22 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
>>>>    	VM_BUG_ON(logging_active && !cache);
>>>>      	/* Create stage-2 page table mapping - Levels 0 and 1 */
>>>> +	pud = stage2_get_pud(kvm, cache, addr);
>>>> +	if (!pud) {
>>>> +		/*
>>>> +		 * Ignore calls from kvm_set_spte_hva for unallocated
>>>> +		 * address ranges.
>>>> +		 */
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * While dirty page logging - dissolve huge PUD, then continue
>>>> +	 * on to allocate page.
>>>
>>> Punit,
>>>
>>> We don't seem to allocate a page here for the PUD entry, in case if it is dissolved
>>> or empty (i.e, stage2_pud_none(*pud) is true.).
>>
>> I was trying to avoid duplicating the PUD allocation by reusing the
>> functionality in stage2_get_pmd().
>>
>> Does the below updated comment help?
>>
>> 	/*
>> 	 * While dirty page logging - dissolve huge PUD, it'll be
>> 	 * allocated in stage2_get_pmd().
>> 	 */
>>
>> The other option is to duplicate the stage2_pud_none() case from
>> stage2_get_pmd() here.
>
> I think the explicit check for stage2_pud_none() suits better here.
> That would make it explicit that we are tearing down the entries
> from top to bottom. Also, we may be able to short cut for case
> where we know we just allocated a PUD page and hence we need another
> PMD level page.

Ok, I'll add the PUD allocation code here.

>
> Also, you are missing the comment about the assumption that stage2 PUD
> level always exist with 4k fixed IPA.

Hmm... I'm quite sure I wrote a comment to that effect but can't find it
now. I'll include it in the next version.

Thanks,
Punit

>
> Cheers
> Suzuki
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
