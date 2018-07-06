Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9551CC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5961E2077B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5961E2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754070AbeGFOXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:23:08 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37548 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753632AbeGFOXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:23:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 200D2ED1;
        Fri,  6 Jul 2018 07:23:07 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B47273F2EA;
        Fri,  6 Jul 2018 07:23:05 -0700 (PDT)
Subject: Re: [PATCH v4 7/7] KVM: arm64: Add support for creating PUD hugepages
 at stage 2
To:     Punit Agrawal <punit.agrawal@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
References: <20180705140850.5801-1-punit.agrawal@arm.com>
 <20180705140850.5801-8-punit.agrawal@arm.com>
 <51265e49-8b8f-cabb-d2c9-d776a8a4ace8@arm.com>
 <87k1q8qwqb.fsf@e105922-lin.cambridge.arm.com>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <12486745-ffb7-751e-9b2b-ff4722c5fd80@arm.com>
Date:   Fri, 6 Jul 2018 15:23:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87k1q8qwqb.fsf@e105922-lin.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Punit,


On 06/07/18 15:12, Punit Agrawal wrote:
> Suzuki K Poulose <Suzuki.Poulose@arm.com> writes:
> 
>> Hi Punit,
>>
>> On 05/07/18 15:08, Punit Agrawal wrote:
>>> KVM only supports PMD hugepages at stage 2. Now that the various page
>>> handling routines are updated, extend the stage 2 fault handling to
>>> map in PUD hugepages.
>>>
>>> Addition of PUD hugepage support enables additional page sizes (e.g.,
>>> 1G with 4K granule) which can be useful on cores that support mapping
>>> larger block sizes in the TLB entries.
>>>
>>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>> Cc: Russell King <linux@armlinux.org.uk>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>
>>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>>> index 0c04c64e858c..5912210e94d9 100644
>>> --- a/virt/kvm/arm/mmu.c
>>> +++ b/virt/kvm/arm/mmu.c
>>> @@ -116,6 +116,25 @@ static void stage2_dissolve_pmd(struct kvm *kvm, phys_addr_t addr, pmd_t *pmd)
>>>    	put_page(virt_to_page(pmd));
>>>    }
>>>    +/**
>>> + * stage2_dissolve_pud() - clear and flush huge PUD entry
>>> + * @kvm:	pointer to kvm structure.
>>> + * @addr:	IPA
>>> + * @pud:	pud pointer for IPA
>>> + *
>>> + * Function clears a PUD entry, flushes addr 1st and 2nd stage TLBs. Marks all
>>> + * pages in the range dirty.
>>> + */
>>> +static void stage2_dissolve_pud(struct kvm *kvm, phys_addr_t addr, pud_t *pud)
>>> +{
>>> +	if (!pud_huge(*pud))
>>> +		return;
>>> +
>>> +	pud_clear(pud);
>>
>> You need to use the stage2_ accessors here. The stage2_dissolve_pmd() uses
>> "pmd_" helpers as the PTE entries (level 3) are always guaranteed to exist.
> 
> I've fixed this and other uses of the PUD helpers to go via the stage2_
> accessors.
> 
> I've still not quite come to terms with the lack of certain levels at
> stage 2 vis-a-vis stage 1. I'll be more careful about this going
> forward.

I accept that it can be quite confusing. Once we get level independent types
and table accessors this might be easier. For now, the general rule is stick
to stage2_ accessors whenever you deal with the stage2 table. Rest should be
left to the stage2 code to deal with it.

> 
>>> @@ -1572,7 +1631,18 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>>    	if (exec_fault)
>>>    		invalidate_icache_guest_page(pfn, vma_pagesize);
>>>    -	if (hugetlb && vma_pagesize == PMD_SIZE) {
>>> +	if (hugetlb && vma_pagesize == PUD_SIZE) {
>>
>> I think we may need to check if the stage2 indeed has 3 levels of
>> tables to use stage2 PUD. Otherwise, fall back to PTE level mapping
>> or even PMD huge pages. Also, this cannot be triggered right now,
>> as we only get PUD hugepages with 4K and we are guaranteed to have
>> at least 3 levels with 40bit IPA. May be I can take care of it in
>> the Dynamic IPA series, when we run a guest with say 32bit IPA.
>> So for now, it is worth adding a comment here.
> 
> Good point. I've added the following comment.
> 
>      /*
>       * PUD level may not exist if the guest boots with two
>       * levels at Stage 2. This configuration is currently
>       * not supported due to IPA size supported by KVM.
>       *
>       * Revisit the assumptions about PUD levels when
>       * additional IPA sizes are supported by KVM.
>       */
> 

Yep, that looks fine to me.

Suzuki
