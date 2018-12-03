Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B647C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD0620851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD0620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbeLCMMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:12:38 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35810 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbeLCMMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:12:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5449165C;
        Mon,  3 Dec 2018 04:11:50 -0800 (PST)
Received: from [10.1.37.145] (p8cg001049571a15.cambridge.arm.com [10.1.37.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DB713F614;
        Mon,  3 Dec 2018 04:11:49 -0800 (PST)
Subject: Re: [PATCH v9 1/8] KVM: arm/arm64: Share common code in
 user_mem_abort()
To:     Punit Agrawal <punit.agrawal@arm.com>, kvmarm@lists.cs.columbia.edu
Cc:     suzuki.poulose@arm.com, marc.zyngier@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        punitagrawal@gmail.com, linux-arm-kernel@lists.infradead.org
References: <20181031175745.18650-1-punit.agrawal@arm.com>
 <20181031175745.18650-2-punit.agrawal@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ad4b316a-054f-24d9-d32d-8fbe7972b5ad@arm.com>
Date:   Mon, 3 Dec 2018 17:41:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181031175745.18650-2-punit.agrawal@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/2018 11:27 PM, Punit Agrawal wrote:
> The code for operations such as marking the pfn as dirty, and
> dcache/icache maintenance during stage 2 fault handling is duplicated
> between normal pages and PMD hugepages.
> 
> Instead of creating another copy of the operations when we introduce
> PUD hugepages, let's share them across the different pagesizes.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  virt/kvm/arm/mmu.c | 49 ++++++++++++++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 19 deletions(-)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 5eca48bdb1a6..59595207c5e1 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1475,7 +1475,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  			  unsigned long fault_status)
>  {
>  	int ret;
> -	bool write_fault, exec_fault, writable, hugetlb = false, force_pte = false;
> +	bool write_fault, exec_fault, writable, force_pte = false;
>  	unsigned long mmu_seq;
>  	gfn_t gfn = fault_ipa >> PAGE_SHIFT;
>  	struct kvm *kvm = vcpu->kvm;
> @@ -1484,7 +1484,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	kvm_pfn_t pfn;
>  	pgprot_t mem_type = PAGE_S2;
>  	bool logging_active = memslot_is_logging(memslot);
> -	unsigned long flags = 0;
> +	unsigned long vma_pagesize, flags = 0;

A small nit s/vma_pagesize/pagesize. Why call it VMA ? Its implicit.

>  
>  	write_fault = kvm_is_write_fault(vcpu);
>  	exec_fault = kvm_vcpu_trap_is_iabt(vcpu);
> @@ -1504,10 +1504,16 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  		return -EFAULT;
>  	}
>  
> -	if (vma_kernel_pagesize(vma) == PMD_SIZE && !logging_active) {
> -		hugetlb = true;
> +	vma_pagesize = vma_kernel_pagesize(vma);
> +	if (vma_pagesize == PMD_SIZE && !logging_active) {
>  		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
>  	} else {
> +		/*
> +		 * Fallback to PTE if it's not one of the Stage 2
> +		 * supported hugepage sizes
> +		 */
> +		vma_pagesize = PAGE_SIZE;

This seems redundant and should be dropped. vma_kernel_pagesize() here either
calls hugetlb_vm_op_pagesize (via hugetlb_vm_ops->pagesize) or simply returns
PAGE_SIZE. The vm_ops path is taken if the QEMU VMA covering any given HVA is
backed either by HugeTLB pages or simply normal pages. vma_pagesize would
either has a value of PMD_SIZE (HugeTLB hstate based) or PAGE_SIZE. Hence if
its not PMD_SIZE it must be PAGE_SIZE which should not be assigned again.

> +
>  		/*
>  		 * Pages belonging to memslots that don't have the same
>  		 * alignment for userspace and IPA cannot be mapped using
> @@ -1573,23 +1579,33 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	if (mmu_notifier_retry(kvm, mmu_seq))
>  		goto out_unlock;
>  
> -	if (!hugetlb && !force_pte)
> -		hugetlb = transparent_hugepage_adjust(&pfn, &fault_ipa);
> +	if (vma_pagesize == PAGE_SIZE && !force_pte) {
> +		/*
> +		 * Only PMD_SIZE transparent hugepages(THP) are
> +		 * currently supported. This code will need to be
> +		 * updated to support other THP sizes.
> +		 */

This comment belongs to transparent_hugepage_adjust() but not here.

> +		if (transparent_hugepage_adjust(&pfn, &fault_ipa))
> +			vma_pagesize = PMD_SIZE;

IIUC transparent_hugepage_adjust() is only getting called here. Instead of
returning 'true' when it is able to detect a huge page backing and doing
an adjustment there after, it should rather return THP size (PMD_SIZE) to
accommodate probable multi size THP support in future .

> +	}
> +
> +	if (writable)
> +		kvm_set_pfn_dirty(pfn);
>  
> -	if (hugetlb) {
> +	if (fault_status != FSC_PERM)
> +		clean_dcache_guest_page(pfn, vma_pagesize);
> +
> +	if (exec_fault)
> +		invalidate_icache_guest_page(pfn, vma_pagesize);
> +
> +	if (vma_pagesize == PMD_SIZE) {
>  		pmd_t new_pmd = pfn_pmd(pfn, mem_type);
>  		new_pmd = pmd_mkhuge(new_pmd);
> -		if (writable) {
> +		if (writable)
>  			new_pmd = kvm_s2pmd_mkwrite(new_pmd);
> -			kvm_set_pfn_dirty(pfn);
> -		}
> -
> -		if (fault_status != FSC_PERM)
> -			clean_dcache_guest_page(pfn, PMD_SIZE);
>  
>  		if (exec_fault) {
>  			new_pmd = kvm_s2pmd_mkexec(new_pmd);
> -			invalidate_icache_guest_page(pfn, PMD_SIZE);
>  		} else if (fault_status == FSC_PERM) {
>  			/* Preserve execute if XN was already cleared */
>  			if (stage2_is_exec(kvm, fault_ipa))
> @@ -1602,16 +1618,11 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  
>  		if (writable) {
>  			new_pte = kvm_s2pte_mkwrite(new_pte);
> -			kvm_set_pfn_dirty(pfn);
>  			mark_page_dirty(kvm, gfn);
>  		}
>  
> -		if (fault_status != FSC_PERM)
> -			clean_dcache_guest_page(pfn, PAGE_SIZE);
> -
>  		if (exec_fault) {
>  			new_pte = kvm_s2pte_mkexec(new_pte);
> -			invalidate_icache_guest_page(pfn, PAGE_SIZE);
>  		} else if (fault_status == FSC_PERM) {
>  			/* Preserve execute if XN was already cleared */
>  			if (stage2_is_exec(kvm, fault_ipa))
> 

kvm_set_pfn_dirty, clean_dcache_guest_page, invalidate_icache_guest_page
can all be safely moved before setting the page table entries either as
PMD or PTE.
