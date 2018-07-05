Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674F1C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2569D23F82
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2569D23F82
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754040AbeGEQsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:48:42 -0400
Received: from foss.arm.com ([217.140.101.70]:53894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753595AbeGEQsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:48:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EF807A9;
        Thu,  5 Jul 2018 09:48:40 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10A443F5BA;
        Thu,  5 Jul 2018 09:48:38 -0700 (PDT)
Subject: Re: [PATCH v4 4/7] KVM: arm64: Support PUD hugepage in
 stage2_is_exec()
To:     Punit Agrawal <punit.agrawal@arm.com>, kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
References: <20180705140850.5801-1-punit.agrawal@arm.com>
 <20180705140850.5801-5-punit.agrawal@arm.com>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <442d0f4b-cb23-9788-1ebd-b14c89c52c45@arm.com>
Date:   Thu, 5 Jul 2018 17:48:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180705140850.5801-5-punit.agrawal@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Punit,

On 05/07/18 15:08, Punit Agrawal wrote:
> In preparation for creating PUD hugepages at stage 2, add support for
> detecting execute permissions on PUD page table entries. Faults due to
> lack of execute permissions on page table entries is used to perform
> i-cache invalidation on first execute.
> 
> Provide trivial implementations of arm32 helpers to allow sharing of
> code.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>   arch/arm/include/asm/kvm_mmu.h         |  6 ++++++
>   arch/arm64/include/asm/kvm_mmu.h       |  5 +++++
>   arch/arm64/include/asm/pgtable-hwdef.h |  2 ++
>   virt/kvm/arm/mmu.c                     | 10 +++++++++-
>   4 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index c23722f75d5c..d05c8986e495 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -96,6 +96,12 @@ static inline bool kvm_s2pud_readonly(pud_t *pud)
>   }
>   
>   
> +static inline bool kvm_s2pud_exec(pud_t *pud)
> +{
> +	BUG();
> +	return false;
> +}
> +
>   static inline void kvm_set_pmd(pmd_t *pmd, pmd_t new_pmd)
>   {
>   	*pmd = new_pmd;
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 84051930ddfe..15bc1be8f82f 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -249,6 +249,11 @@ static inline bool kvm_s2pud_readonly(pud_t *pudp)
>   	return kvm_s2pte_readonly((pte_t *)pudp);
>   }
>   
> +static inline bool kvm_s2pud_exec(pud_t *pudp)
> +{
> +	return !(READ_ONCE(pud_val(*pudp)) & PUD_S2_XN);
> +}
> +
>   static inline bool kvm_page_empty(void *ptr)
>   {
>   	struct page *ptr_page = virt_to_page(ptr);
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index fd208eac9f2a..10ae592b78b8 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -193,6 +193,8 @@
>   #define PMD_S2_RDWR		(_AT(pmdval_t, 3) << 6)   /* HAP[2:1] */
>   #define PMD_S2_XN		(_AT(pmdval_t, 2) << 53)  /* XN[1:0] */
>   
> +#define PUD_S2_XN		(_AT(pudval_t, 2) << 53)  /* XN[1:0] */
> +

The changes above look good to me. Please see below.

>   /*
>    * Memory Attribute override for Stage-2 (MemAttr[3:0])
>    */
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index db04b18218c1..ccdea0edabb3 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1040,10 +1040,18 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
>   
>   static bool stage2_is_exec(struct kvm *kvm, phys_addr_t addr)
>   {
> +	pud_t *pudp;
>   	pmd_t *pmdp;
>   	pte_t *ptep;
>   
> -	pmdp = stage2_get_pmd(kvm, NULL, addr);
> +	pudp = stage2_get_pud(kvm, NULL, addr);
> +	if (!pudp || pud_none(*pudp) || !pud_present(*pudp))
> +		return false;
> +
> +	if (pud_huge(*pudp))
> +		return kvm_s2pud_exec(pudp);
> +
> +	pmdp = stage2_pmd_offset(pudp, addr);
>   	if (!pmdp || pmd_none(*pmdp) || !pmd_present(*pmdp))
>   		return false;

I am wondering if we need a slightly better way to deal with this
kind of operation. We seem to duplicate the above operation (here and
in the following patches), i.e, finding the "leaf entry" for a given
address and follow the checks one level up at a time.

So instead of doing, stage2_get_pud() and walking down everywhere this
is needed, how about adding :

/* Returns true if the leaf entry is found and updates the relevant pointer */
found = stage2_get_leaf_entry(kvm, NULL, addr, &pudp, &pmdp, &ptep)

which could set the appropriate entry and we could check the result here.

Cheers
Suzuki
