Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3C9C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C0C208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 21:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C0C208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbeIYDY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 23:24:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42120 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728192AbeIYDYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 23:24:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D927A7A9;
        Mon, 24 Sep 2018 14:20:45 -0700 (PDT)
Received: from [10.37.9.1] (unknown [10.37.9.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08ECF3F5B7;
        Mon, 24 Sep 2018 14:20:42 -0700 (PDT)
Subject: Re: [PATCH v7 9/9] KVM: arm64: Add support for creating PUD hugepages
 at stage 2
To:     Punit Agrawal <punit.agrawal@arm.com>, kvmarm@lists.cs.columbia.edu
Cc:     marc.zyngier@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20180924174552.8387-1-punit.agrawal@arm.com>
 <20180924174552.8387-10-punit.agrawal@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <4df146fc-f9b0-882e-becb-056111a444d4@arm.com>
Date:   Mon, 24 Sep 2018 22:21:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180924174552.8387-10-punit.agrawal@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Punit,


On 09/24/2018 06:45 PM, Punit Agrawal wrote:
> KVM only supports PMD hugepages at stage 2. Now that the various page
> handling routines are updated, extend the stage 2 fault handling to
> map in PUD hugepages.
> 
> Addition of PUD hugepage support enables additional page sizes (e.g.,
> 1G with 4K granule) which can be useful on cores that support mapping
> larger block sizes in the TLB entries.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>


> 
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index a42b9505c9a7..a8e86b926ee0 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -84,11 +84,14 @@ void kvm_clear_hyp_idmap(void);
>   
>   #define kvm_pfn_pte(pfn, prot)	pfn_pte(pfn, prot)
>   #define kvm_pfn_pmd(pfn, prot)	pfn_pmd(pfn, prot)
> +#define kvm_pfn_pud(pfn, prot)	(__pud(0))
>   
>   #define kvm_pud_pfn(pud)	({ BUG(); 0; })
>   
>   
>   #define kvm_pmd_mkhuge(pmd)	pmd_mkhuge(pmd)
> +/* No support for pud hugepages */
> +#define kvm_pud_mkhuge(pud)	(pud)
>   

shouldn't this be BUG() like other PUD huge helpers for arm32 ?

>   /*
>    * The following kvm_*pud*() functions are provided strictly to allow
> @@ -105,6 +108,23 @@ static inline bool kvm_s2pud_readonly(pud_t *pud)
>   	return false;
>   }
>   
> +static inline void kvm_set_pud(pud_t *pud, pud_t new_pud)
> +{
> +	BUG();
> +}
> +
> +static inline pud_t kvm_s2pud_mkwrite(pud_t pud)
> +{
> +	BUG();
> +	return pud;
> +}
> +
> +static inline pud_t kvm_s2pud_mkexec(pud_t pud)
> +{
> +	BUG();
> +	return pud;
> +}
> +


> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 3ff7ebb262d2..5b8163537bc2 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c

...


> @@ -1669,7 +1746,28 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>   	needs_exec = exec_fault ||
>   		(fault_status == FSC_PERM && stage2_is_exec(kvm, fault_ipa));
>   
> -	if (hugetlb && vma_pagesize == PMD_SIZE) {
> +	if (hugetlb && vma_pagesize == PUD_SIZE) {
> +		/*
> +		 * Assuming that PUD level always exists at Stage 2 -
> +		 * this is true for 4k pages with 40 bits IPA
> +		 * currently supported.
> +		 *
> +		 * When using 64k pages, 40bits of IPA results in
> +		 * using only 2-levels at Stage 2. Overlooking this
> +		 * problem for now as a PUD hugepage with 64k pages is
> +		 * too big (4TB) to be practical.
> +		 */
> +		pud_t new_pud = kvm_pfn_pud(pfn, mem_type);

Is this based on the Dynamic IPA series ? The cover letter seems
to suggest that it is. But I don't see the check to make sure we have
stage2 PUD level here before we go ahead and try PUD huge page at
stage2. Also the comment above seems outdated in that case.

> +
> +		new_pud = kvm_pud_mkhuge(new_pud);
> +		if (writable)
> +			new_pud = kvm_s2pud_mkwrite(new_pud);
> +
> +		if (needs_exec)
> +			new_pud = kvm_s2pud_mkexec(new_pud);
> +
> +		ret = stage2_set_pud_huge(kvm, memcache, fault_ipa, &new_pud);
> +	} else if (hugetlb && vma_pagesize == PMD_SIZE) {
>   		pmd_t new_pmd = kvm_pfn_pmd(pfn, mem_type);
>   
>   		new_pmd = kvm_pmd_mkhuge(new_pmd);
> 


Suzuki
