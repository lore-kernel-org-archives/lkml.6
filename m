Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BF3C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE8721470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE8721470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeJCXPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:15:07 -0400
Received: from foss.arm.com ([217.140.101.70]:53602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbeJCXPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:15:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FB0980D;
        Wed,  3 Oct 2018 09:26:01 -0700 (PDT)
Received: from localhost (e105922-lin.Emea.Arm.com [10.4.13.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 243FB3F5D3;
        Wed,  3 Oct 2018 09:26:00 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 2/9] KVM: arm/arm64: Share common code in user_mem_abort()
References: <20181001155443.23032-1-punit.agrawal@arm.com>
        <20181001155443.23032-3-punit.agrawal@arm.com>
        <1eb4df93-4610-ac83-fec3-6a7efeddfc4f@arm.com>
Date:   Wed, 03 Oct 2018 17:25:59 +0100
In-Reply-To: <1eb4df93-4610-ac83-fec3-6a7efeddfc4f@arm.com> (Marc Zyngier's
        message of "Wed, 3 Oct 2018 16:20:39 +0100")
Message-ID: <87o9cbhu94.fsf@e105922-lin.cambridge.arm.com>
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
> On 01/10/18 16:54, Punit Agrawal wrote:
>> The code for operations such as marking the pfn as dirty, and
>> dcache/icache maintenance during stage 2 fault handling is duplicated
>> between normal pages and PMD hugepages.
>>
>> Instead of creating another copy of the operations when we introduce
>> PUD hugepages, let's share them across the different pagesizes.
>>
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>   virt/kvm/arm/mmu.c | 45 +++++++++++++++++++++++++++++----------------
>>   1 file changed, 29 insertions(+), 16 deletions(-)
>>
>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>> index c23a1b323aad..5b76ee204000 100644
>> --- a/virt/kvm/arm/mmu.c
>> +++ b/virt/kvm/arm/mmu.c
>> @@ -1490,7 +1490,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   	kvm_pfn_t pfn;
>>   	pgprot_t mem_type = PAGE_S2;
>>   	bool logging_active = memslot_is_logging(memslot);
>> -	unsigned long flags = 0;
>> +	unsigned long vma_pagesize, flags = 0;
>>     	write_fault = kvm_is_write_fault(vcpu);
>>   	exec_fault = kvm_vcpu_trap_is_iabt(vcpu);
>> @@ -1510,10 +1510,17 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   		return -EFAULT;
>>   	}
>>   -	if (vma_kernel_pagesize(vma) == PMD_SIZE && !logging_active) {
>> +	vma_pagesize = vma_kernel_pagesize(vma);
>> +	if (vma_pagesize == PMD_SIZE && !logging_active) {
>>   		hugetlb = true;
>>   		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
>>   	} else {
>> +		/*
>> +		 * Fallback to PTE if it's not one of the Stage 2
>> +		 * supported hugepage sizes
>> +		 */
>> +		vma_pagesize = PAGE_SIZE;
>> +
>>   		/*
>>   		 * Pages belonging to memslots that don't have the same
>>   		 * alignment for userspace and IPA cannot be mapped using
>> @@ -1579,23 +1586,34 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   	if (mmu_notifier_retry(kvm, mmu_seq))
>>   		goto out_unlock;
>>   -	if (!hugetlb && !force_pte)
>> +	if (!hugetlb && !force_pte) {
>> +		/*
>> +		 * Only PMD_SIZE transparent hugepages(THP) are
>> +		 * currently supported. This code will need to be
>> +		 * updated to support other THP sizes.
>> +		 */
>>   		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
>> +		if (hugetlb)
>> +			vma_pagesize = PMD_SIZE;
>> +	}
>> +
>> +	if (writable)
>> +		kvm_set_pfn_dirty(pfn);
>>   -	if (hugetlb) {
>> +	if (fault_status != FSC_PERM)
>> +		clean_dcache_guest_page(pfn, vma_pagesize);
>> +
>> +	if (exec_fault)
>> +		invalidate_icache_guest_page(pfn, vma_pagesize);
>> +
>> +	if (hugetlb && vma_pagesize == PMD_SIZE) {
>
> Can you end-up in a situation where hugetlb==false and vma_pagesize ==
> PMD_SIZE? If that's the case, then the above CMOs are not done on the
> same granularity as they were done before this patch. If that cannot
> happen, then the above condition can be simplified.
>
> Which one is it?

hugetlb is a hangover from when we didn't have vma_pagesize. I think we
can drop it and rely on the pagesize to control the size of mapping we
put down.

Let me give that a try.

Thanks for taking a look.

>
>
> Thanks,
>
> 	M.
