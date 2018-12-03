Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032EEC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA51B20834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA51B20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbeLCPTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:19:32 -0500
Received: from foss.arm.com ([217.140.101.70]:39614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbeLCPTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:19:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EAFB168F;
        Mon,  3 Dec 2018 07:19:26 -0800 (PST)
Received: from [10.1.37.145] (p8cg001049571a15.cambridge.arm.com [10.1.37.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 918683F5AF;
        Mon,  3 Dec 2018 07:19:24 -0800 (PST)
Subject: Re: [PATCH v9 7/8] KVM: arm64: Update age handlers to support PUD
 hugepages
To:     Punit Agrawal <punit.agrawal@arm.com>, kvmarm@lists.cs.columbia.edu
Cc:     suzuki.poulose@arm.com, marc.zyngier@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>, will.deacon@arm.com,
        linux-kernel@vger.kernel.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        punitagrawal@gmail.com, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
References: <20181031175745.18650-1-punit.agrawal@arm.com>
 <20181031175745.18650-8-punit.agrawal@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <db1e8281-a7cb-5d2a-8ad3-6d275fc49582@arm.com>
Date:   Mon, 3 Dec 2018 20:49:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181031175745.18650-8-punit.agrawal@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/2018 11:27 PM, Punit Agrawal wrote:
> In preparation for creating larger hugepages at Stage 2, add support
> to the age handling notifiers for PUD hugepages when encountered.
> 
> Provide trivial helpers for arm32 to allow sharing code.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/asm/kvm_mmu.h   |  6 +++++
>  arch/arm64/include/asm/kvm_mmu.h |  5 ++++
>  arch/arm64/include/asm/pgtable.h |  1 +
>  virt/kvm/arm/mmu.c               | 39 ++++++++++++++++----------------
>  4 files changed, 32 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index fea5e723e3ac..e62f0913ce7d 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -117,6 +117,12 @@ static inline pud_t kvm_s2pud_mkyoung(pud_t pud)
>  	return pud;
>  }
>  
> +static inline bool kvm_s2pud_young(pud_t pud)
> +{
> +	BUG();
> +	return false;
> +}
> +
>  static inline pte_t kvm_s2pte_mkwrite(pte_t pte)
>  {
>  	pte_val(pte) |= L_PTE_S2_RDWR;
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 612032bbb428..9f941f70775c 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -273,6 +273,11 @@ static inline pud_t kvm_s2pud_mkyoung(pud_t pud)
>  	return pud_mkyoung(pud);
>  }
>  
> +static inline bool kvm_s2pud_young(pud_t pud)
> +{
> +	return pud_young(pud);
> +}
> +
>  #define hyp_pte_table_empty(ptep) kvm_page_empty(ptep)
>  
>  #ifdef __PAGETABLE_PMD_FOLDED
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index f51e2271e6a3..bb0f3f17a7a9 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -386,6 +386,7 @@ static inline int pmd_protnone(pmd_t pmd)
>  #define pfn_pmd(pfn,prot)	__pmd(__phys_to_pmd_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
>  #define mk_pmd(page,prot)	pfn_pmd(page_to_pfn(page),prot)
>  
> +#define pud_young(pud)		pte_young(pud_pte(pud))
>  #define pud_mkyoung(pud)	pte_pud(pte_mkyoung(pud_pte(pud)))
>  #define pud_write(pud)		pte_write(pud_pte(pud))
>  
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index bd749601195f..3893ea6a50bf 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1225,6 +1225,11 @@ static int stage2_pmdp_test_and_clear_young(pmd_t *pmd)
>  	return stage2_ptep_test_and_clear_young((pte_t *)pmd);
>  }
>  
> +static int stage2_pudp_test_and_clear_young(pud_t *pud)
> +{
> +	return stage2_ptep_test_and_clear_young((pte_t *)pud);
> +}
> +
>  /**
>   * kvm_phys_addr_ioremap - map a device range to guest IPA
>   *
> @@ -1932,42 +1937,38 @@ void kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
>  
>  static int kvm_age_hva_handler(struct kvm *kvm, gpa_t gpa, u64 size, void *data)
>  {
> +	pud_t *pud;
>  	pmd_t *pmd;
>  	pte_t *pte;
>  
> -	WARN_ON(size != PAGE_SIZE && size != PMD_SIZE);
> -	pmd = stage2_get_pmd(kvm, NULL, gpa);
> -	if (!pmd || pmd_none(*pmd))	/* Nothing there */
> +	WARN_ON(size != PAGE_SIZE && size != PMD_SIZE && size != PUD_SIZE);
> +	if (!stage2_get_leaf_entry(kvm, gpa, &pud, &pmd, &pte))
>  		return 0;
>  
> -	if (pmd_thp_or_huge(*pmd))	/* THP, HugeTLB */
> +	if (pud)
> +		return stage2_pudp_test_and_clear_young(pud);
> +	else if (pmd)
>  		return stage2_pmdp_test_and_clear_young(pmd);
> -
> -	pte = pte_offset_kernel(pmd, gpa);
> -	if (pte_none(*pte))
> -		return 0;
> -
> -	return stage2_ptep_test_and_clear_young(pte);
> +	else
> +		return stage2_ptep_test_and_clear_young(pte);
>  }
>  
>  static int kvm_test_age_hva_handler(struct kvm *kvm, gpa_t gpa, u64 size, void *data)
>  {
> +	pud_t *pud;
>  	pmd_t *pmd;
>  	pte_t *pte;
>  
> -	WARN_ON(size != PAGE_SIZE && size != PMD_SIZE);
> -	pmd = stage2_get_pmd(kvm, NULL, gpa);
> -	if (!pmd || pmd_none(*pmd))	/* Nothing there */
> +	WARN_ON(size != PAGE_SIZE && size != PMD_SIZE && size != PUD_SIZE);
> +	if (!stage2_get_leaf_entry(kvm, gpa, &pud, &pmd, &pte))
>  		return 0;
>  
> -	if (pmd_thp_or_huge(*pmd))		/* THP, HugeTLB */
> +	if (pud)
> +		return kvm_s2pud_young(*pud);
> +	else if (pmd)
>  		return pmd_young(*pmd);
> -
> -	pte = pte_offset_kernel(pmd, gpa);
> -	if (!pte_none(*pte))		/* Just a page... */
> +	else
>  		return pte_young(*pte);
> -
> -	return 0;
>  }
>  
>  int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end)
> 

If stage2_get_leaf_entry() is avoided (which it should be) some of the previous
patches can be folded into just a single one like defining new HW page table
definitions, arm32 trivial functions and PUD specific additions at various
stage 2 page table walkers etc.
