Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F53C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D30F20B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D30F20B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387759AbeGKNVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:21:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35594 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732311AbeGKNVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:21:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C52EE7A9;
        Wed, 11 Jul 2018 06:17:00 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F4E53F5AD;
        Wed, 11 Jul 2018 06:16:59 -0700 (PDT)
Subject: Re: [PATCH v5 5/7] KVM: arm64: Support handling access faults for PUD
 hugepages
To:     Punit Agrawal <punit.agrawal@arm.com>, kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, linux-kernel@vger.kernel.org,
        will.deacon@arm.com, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20180709143835.28971-1-punit.agrawal@arm.com>
 <20180709144124.29164-1-punit.agrawal@arm.com>
 <20180709144124.29164-5-punit.agrawal@arm.com>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <be9492ce-271c-e87f-e934-a6bb3a5ac119@arm.com>
Date:   Wed, 11 Jul 2018 14:16:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180709144124.29164-5-punit.agrawal@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/18 15:41, Punit Agrawal wrote:
> In preparation for creating larger hugepages at Stage 2, extend the
> access fault handling at Stage 2 to support PUD hugepages when
> encountered.
> 
> Provide trivial helpers for arm32 to allow sharing of code.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>   arch/arm/include/asm/kvm_mmu.h   |  8 ++++++++
>   arch/arm64/include/asm/kvm_mmu.h |  7 +++++++
>   arch/arm64/include/asm/pgtable.h |  6 ++++++
>   virt/kvm/arm/mmu.c               | 29 ++++++++++++++++-------------
>   4 files changed, 37 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index d05c8986e495..a4298d429efc 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -78,6 +78,8 @@ void kvm_clear_hyp_idmap(void);
>   #define kvm_pfn_pte(pfn, prot)	pfn_pte(pfn, prot)
>   #define kvm_pfn_pmd(pfn, prot)	pfn_pmd(pfn, prot)
>   
> +#define kvm_pud_pfn(pud)	(((pud_val(pud) & PUD_MASK) & PHYS_MASK) >> PAGE_SHIFT)

Since we don't have PUD in arm32, it would be good to trigger a BUG()
instead of silently doing something wrong.

> @@ -102,6 +104,12 @@ static inline bool kvm_s2pud_exec(pud_t *pud)
>   	return false;
>   }
>   
> +static inline pud_t kvm_s2pud_mkyoung(pud_t pud)
> +{
> +	BUG();
> +	return pud;
> +}
> +

Like this. ^

> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index e73909a31e02..d2c705e31584 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1637,33 +1637,36 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>    */
>   static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
>   {
> -	pmd_t *pmd;
> -	pte_t *pte;
> +	pud_t *pud = NULL;
> +	pmd_t *pmd = NULL;
> +	pte_t *pte = NULL;
>   	kvm_pfn_t pfn;
> -	bool pfn_valid = false;
> +	bool found, pfn_valid = false;

nit: You could use pfn_valid instead of a new "found" variable.

>   
>   	trace_kvm_access_fault(fault_ipa);
>   
>   	spin_lock(&vcpu->kvm->mmu_lock);
>   
> -	pmd = stage2_get_pmd(vcpu->kvm, NULL, fault_ipa);
> -	if (!pmd || pmd_none(*pmd))	/* Nothing there */
> +	found = stage2_get_leaf_entry(vcpu->kvm, fault_ipa, &pud, &pmd, &pte);
> +	if (!found)
>   		goto out;
>   
> -	if (pmd_thp_or_huge(*pmd)) {	/* THP, HugeTLB */
> +	if (pud) {		/* HugeTLB */
> +		*pud = kvm_s2pud_mkyoung(*pud);
> +		pfn = kvm_pud_pfn(*pud);
> +		pfn_valid = true;
> +		goto out;

You don't need these goto's and the out lable anymore.

> +	} else 	if (pmd) {	/* THP, HugeTLB */
>   		*pmd = pmd_mkyoung(*pmd);
>   		pfn = pmd_pfn(*pmd);
>   		pfn_valid = true;
>   		goto out;
> +	} else {
> +		*pte = pte_mkyoung(*pte);	/* Just a page... */
> +		pfn = pte_pfn(*pte);
> +		pfn_valid = true;
>   	}
>   
> -	pte = pte_offset_kernel(pmd, fault_ipa);
> -	if (pte_none(*pte))		/* Nothing there either */
> -		goto out;
> -
> -	*pte = pte_mkyoung(*pte);	/* Just a page... */
> -	pfn = pte_pfn(*pte);
> -	pfn_valid = true;
>   out:
>   	spin_unlock(&vcpu->kvm->mmu_lock);
>   	if (pfn_valid)
> 

Otherwise look good to me.

Suzuki
