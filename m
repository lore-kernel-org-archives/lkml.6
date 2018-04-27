Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757419AbeD0LOq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 07:14:46 -0400
Received: from foss.arm.com ([217.140.101.70]:38642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751464AbeD0LOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 07:14:44 -0400
Date: Fri, 27 Apr 2018 13:14:41 +0200
From: Christoffer Dall <christoffer.dall@arm.com>
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        marc.zyngier@arm.com, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 2/4] KVM: arm/arm64: Introduce helpers to manupulate page
 table entries
Message-ID: <20180427111441.GM13249@C02W217FHV2R.local>
References: <20180420145409.24485-1-punit.agrawal@arm.com>
 <20180420145409.24485-3-punit.agrawal@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420145409.24485-3-punit.agrawal@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 03:54:07PM +0100, Punit Agrawal wrote:
> Introduce helpers to abstract architectural handling of the conversion
> of pfn to page table entries and marking a PMD page table entry as a
> block entry.
> 
> The helpers are introduced in preparation for supporting PUD hugepages
> at stage 2 - which are supported on arm64 but do not exist on arm.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@arm.com>

> ---
>  arch/arm/include/asm/kvm_mmu.h   | 5 +++++
>  arch/arm64/include/asm/kvm_mmu.h | 5 +++++
>  virt/kvm/arm/mmu.c               | 7 ++++---
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index 707a1f06dc5d..5907a81ad5c1 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -75,6 +75,11 @@ phys_addr_t kvm_get_idmap_vector(void);
>  int kvm_mmu_init(void);
>  void kvm_clear_hyp_idmap(void);
>  
> +#define kvm_pfn_pte(pfn, prot)	pfn_pte(pfn, prot)
> +#define kvm_pfn_pmd(pfn, prot)	pfn_pmd(pfn, prot)
> +
> +#define kvm_pmd_mkhuge(pmd)	pmd_mkhuge(pmd)
> +
>  static inline void kvm_set_pmd(pmd_t *pmd, pmd_t new_pmd)
>  {
>  	*pmd = new_pmd;
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 082110993647..d962508ce4b3 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -173,6 +173,11 @@ void kvm_clear_hyp_idmap(void);
>  #define	kvm_set_pte(ptep, pte)		set_pte(ptep, pte)
>  #define	kvm_set_pmd(pmdp, pmd)		set_pmd(pmdp, pmd)
>  
> +#define kvm_pfn_pte(pfn, prot)		pfn_pte(pfn, prot)
> +#define kvm_pfn_pmd(pfn, prot)		pfn_pmd(pfn, prot)
> +
> +#define kvm_pmd_mkhuge(pmd)		pmd_mkhuge(pmd)
> +
>  static inline pte_t kvm_s2pte_mkwrite(pte_t pte)
>  {
>  	pte_val(pte) |= PTE_S2_RDWR;
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index db382c7c7cd7..f72ae7a6dea0 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1538,8 +1538,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  		invalidate_icache_guest_page(pfn, vma_pagesize);
>  
>  	if (hugetlb) {
> -		pmd_t new_pmd = pfn_pmd(pfn, mem_type);
> -		new_pmd = pmd_mkhuge(new_pmd);
> +		pmd_t new_pmd = kvm_pfn_pmd(pfn, mem_type);
> +
> +		new_pmd = kvm_pmd_mkhuge(new_pmd);
>  		if (writable)
>  			new_pmd = kvm_s2pmd_mkwrite(new_pmd);
>  
> @@ -1553,7 +1554,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  
>  		ret = stage2_set_pmd_huge(kvm, memcache, fault_ipa, &new_pmd);
>  	} else {
> -		pte_t new_pte = pfn_pte(pfn, mem_type);
> +		pte_t new_pte = kvm_pfn_pte(pfn, mem_type);
>  
>  		if (writable) {
>  			new_pte = kvm_s2pte_mkwrite(new_pte);
> -- 
> 2.17.0
> 
