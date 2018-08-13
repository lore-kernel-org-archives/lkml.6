Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDD1C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E68B21530
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E68B21530
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeHMNAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 09:00:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56542 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728055AbeHMNAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 09:00:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7F7F7A9;
        Mon, 13 Aug 2018 03:18:37 -0700 (PDT)
Received: from localhost (e105922-lin.emea.arm.com [10.4.13.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CBB83F5D0;
        Mon, 13 Aug 2018 03:18:37 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] KVM: arm/arm64: Skip updating PMD entry if no change
References: <20180813094049.3726-1-punit.agrawal@arm.com>
        <20180813094049.3726-2-punit.agrawal@arm.com>
        <e265fe94-aa14-00c5-b144-4eff77413f5a@arm.com>
Date:   Mon, 13 Aug 2018 11:18:35 +0100
In-Reply-To: <e265fe94-aa14-00c5-b144-4eff77413f5a@arm.com> (Marc Zyngier's
        message of "Mon, 13 Aug 2018 11:11:30 +0100")
Message-ID: <87sh3i1sec.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Zyngier <marc.zyngier@arm.com> writes:

> Hi Punit,
>
> On 13/08/18 10:40, Punit Agrawal wrote:

[...]

>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>> index 1d90d79706bd..2ab977edc63c 100644
>> --- a/virt/kvm/arm/mmu.c
>> +++ b/virt/kvm/arm/mmu.c
>> @@ -1015,19 +1015,36 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
>>  	pmd = stage2_get_pmd(kvm, cache, addr);
>>  	VM_BUG_ON(!pmd);
>>  
>> -	/*
>> -	 * Mapping in huge pages should only happen through a fault.  If a
>> -	 * page is merged into a transparent huge page, the individual
>> -	 * subpages of that huge page should be unmapped through MMU
>> -	 * notifiers before we get here.
>> -	 *
>> -	 * Merging of CompoundPages is not supported; they should become
>> -	 * splitting first, unmapped, merged, and mapped back in on-demand.
>> -	 */
>> -	VM_BUG_ON(pmd_present(*pmd) && pmd_pfn(*pmd) != pmd_pfn(*new_pmd));
>> -
>>  	old_pmd = *pmd;
>> +
>>  	if (pmd_present(old_pmd)) {
>> +		/*
>> +		 * Mapping in huge pages should only happen through a
>> +		 * fault.  If a page is merged into a transparent huge
>> +		 * page, the individual subpages of that huge page
>> +		 * should be unmapped through MMU notifiers before we
>> +		 * get here.
>> +		 *
>> +		 * Merging of CompoundPages is not supported; they
>> +		 * should become splitting first, unmapped, merged,
>> +		 * and mapped back in on-demand.
>> +		 */
>> +		VM_BUG_ON(pmd_pfn(old_pmd) != pmd_pfn(*new_pmd));
>> +
>> +		/*
>> +		 * Multiple vcpus faulting on the same PMD entry, can
>> +		 * lead to them sequentially updating the PMD with the
>> +		 * same value. Following the break-before-make
>> +		 * (pmd_clear() followed by tlb_flush()) process can
>> +		 * hinder forward progress due to refaults generated
>> +		 * on missing translations.
>> +		 *
>> +		 * Skip updating the page table if the entry is
>> +		 * unchanged.
>> +		 */
>> +		if (pmd_val(old_pmd) == pmd_val(*new_pmd))
>> +			goto out;
>
> I think the order of these two checks should be reversed: the first one
> is clearly a subset of the second one, so it'd make sense to have the
> global comparison before having the more specific one. Not that it
> matter much in practice, but I just find it easier to reason about.

Makes sense. I've reordered the checks for the next version.

Thanks,
Punit

>
>> +
>>  		pmd_clear(pmd);
>>  		kvm_tlb_flush_vmid_ipa(kvm, addr);
>>  	} else {
>> @@ -1035,6 +1052,7 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
>>  	}
>>  
>>  	kvm_set_pmd(pmd, *new_pmd);
>> +out:
>>  	return 0;
>>  }
>>  
>> 
>
> Thanks,
>
> 	M.
