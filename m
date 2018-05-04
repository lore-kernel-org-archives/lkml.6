Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeEDQWv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 12:22:51 -0400
Received: from foss.arm.com ([217.140.101.70]:56224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751454AbeEDQWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 12:22:50 -0400
From: Punit Agrawal <punit.agrawal@arm.com>
To: Christoffer Dall <christoffer.dall@arm.com>
Cc: marc.zyngier@arm.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] KVM: arm/arm64: Share common code in user_mem_abort()
References: <20180501102659.13188-1-punit.agrawal@arm.com>
        <20180501102659.13188-2-punit.agrawal@arm.com>
        <20180504113813.GD10191@C02W217FHV2R.local>
Date: Fri, 04 May 2018 17:22:48 +0100
In-Reply-To: <20180504113813.GD10191@C02W217FHV2R.local> (Christoffer Dall's
        message of "Fri, 4 May 2018 13:38:13 +0200")
Message-ID: <874ljnl7af.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoffer Dall <christoffer.dall@arm.com> writes:

> On Tue, May 01, 2018 at 11:26:56AM +0100, Punit Agrawal wrote:
>> The code for operations such as marking the pfn as dirty, and
>> dcache/icache maintenance during stage 2 fault handling is duplicated
>> between normal pages and PMD hugepages.
>> 
>> Instead of creating another copy of the operations when we introduce
>> PUD hugepages, let's share them across the different pagesizes.
>> 
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  virt/kvm/arm/mmu.c | 66 +++++++++++++++++++++++++++-------------------
>>  1 file changed, 39 insertions(+), 27 deletions(-)
>> 
>> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
>> index 7f6a944db23d..686fc6a4b866 100644
>> --- a/virt/kvm/arm/mmu.c
>> +++ b/virt/kvm/arm/mmu.c

[...]

>> @@ -1517,28 +1533,34 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>  	if (mmu_notifier_retry(kvm, mmu_seq))
>>  		goto out_unlock;
>>  
>> -	if (!hugetlb && !force_pte)
>> +	if (!hugetlb && !force_pte) {
>>  		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
>> +		/*
>> +		 * Only PMD_SIZE transparent hugepages(THP) are
>> +		 * currently supported. This code will need to be
>> +		 * updated to support other THP sizes.
>> +		 */
>> +		if (hugetlb)
>> +			vma_pagesize = PMD_SIZE;
>
> nit: this is a bit of a trap waiting to happen, as the suggested
> semantics of hugetlb is now hugetlbfs and not THP.
>
> It may be slightly nicer to do do:
>
> 		if (transparent_hugepage_adjust(&pfn, &fault_ipa))
> 			vma_pagesize = PMD_SIZE;

I should've noticed this.

I'll incorporate your suggestion and update the condition below using
hugetlb to rely on vma_pagesize instead.

Thanks,
Punit

>
>> +	}
>> +
>> +	if (writable)
>> +		kvm_set_pfn_dirty(pfn);
>> +
>> +	if (fault_status != FSC_PERM)
>> +		clean_dcache_guest_page(pfn, vma_pagesize);
>> +
>> +	if (exec_fault)
>> +		invalidate_icache_guest_page(pfn, vma_pagesize);
>>  
>>  	if (hugetlb) {
>>  		pmd_t new_pmd = pfn_pmd(pfn, mem_type);
>>  		new_pmd = pmd_mkhuge(new_pmd);
>> -		if (writable) {
>> +		if (writable)
>>  			new_pmd = kvm_s2pmd_mkwrite(new_pmd);
>> -			kvm_set_pfn_dirty(pfn);
>> -		}
>>  
>> -		if (fault_status != FSC_PERM)
>> -			clean_dcache_guest_page(pfn, PMD_SIZE);
>> -
>> -		if (exec_fault) {
>> +		if (stage2_should_exec(kvm, fault_ipa, exec_fault, fault_status))
>>  			new_pmd = kvm_s2pmd_mkexec(new_pmd);
>> -			invalidate_icache_guest_page(pfn, PMD_SIZE);
>> -		} else if (fault_status == FSC_PERM) {
>> -			/* Preserve execute if XN was already cleared */
>> -			if (stage2_is_exec(kvm, fault_ipa))
>> -				new_pmd = kvm_s2pmd_mkexec(new_pmd);
>> -		}
>>  
>>  		ret = stage2_set_pmd_huge(kvm, memcache, fault_ipa, &new_pmd);
>>  	} else {
>> @@ -1546,21 +1568,11 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>  
>>  		if (writable) {
>>  			new_pte = kvm_s2pte_mkwrite(new_pte);
>> -			kvm_set_pfn_dirty(pfn);
>>  			mark_page_dirty(kvm, gfn);
>>  		}
>>  
>> -		if (fault_status != FSC_PERM)
>> -			clean_dcache_guest_page(pfn, PAGE_SIZE);
>> -
>> -		if (exec_fault) {
>> +		if (stage2_should_exec(kvm, fault_ipa, exec_fault, fault_status))
>>  			new_pte = kvm_s2pte_mkexec(new_pte);
>> -			invalidate_icache_guest_page(pfn, PAGE_SIZE);
>> -		} else if (fault_status == FSC_PERM) {
>> -			/* Preserve execute if XN was already cleared */
>> -			if (stage2_is_exec(kvm, fault_ipa))
>> -				new_pte = kvm_s2pte_mkexec(new_pte);
>> -		}
>>  
>>  		ret = stage2_set_pte(kvm, memcache, fault_ipa, &new_pte, flags);
>>  	}
>> -- 
>> 2.17.0
>> 
>
> Otherwise looks good.
>
> Thanks,
> -Christoffer
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
