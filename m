Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263C0C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0FB20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0FB20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeLCOSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:18:11 -0500
Received: from foss.arm.com ([217.140.101.70]:38192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbeLCOSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:18:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDE6B1682;
        Mon,  3 Dec 2018 06:16:59 -0800 (PST)
Received: from [10.1.37.145] (p8cg001049571a15.cambridge.arm.com [10.1.37.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F2B53F614;
        Mon,  3 Dec 2018 06:16:58 -0800 (PST)
Subject: Re: [PATCH v9 4/8] KVM: arm64: Support dirty page tracking for PUD
 hugepages
To:     Punit Agrawal <punit.agrawal@arm.com>, kvmarm@lists.cs.columbia.edu
Cc:     suzuki.poulose@arm.com, marc.zyngier@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        punitagrawal@gmail.com, linux-arm-kernel@lists.infradead.org
References: <20181031175745.18650-1-punit.agrawal@arm.com>
 <20181031175745.18650-5-punit.agrawal@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <0d5f2d45-b09d-d43e-4320-98113d79cb18@arm.com>
Date:   Mon, 3 Dec 2018 19:47:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181031175745.18650-5-punit.agrawal@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/2018 11:27 PM, Punit Agrawal wrote:
> In preparation for creating PUD hugepages at stage 2, add support for
> write protecting PUD hugepages when they are encountered. Write
> protecting guest tables is used to track dirty pages when migrating
> VMs.
> 
> Also, provide trivial implementations of required kvm_s2pud_* helpers
> to allow sharing of code with arm32.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/asm/kvm_mmu.h   | 15 +++++++++++++++
>  arch/arm64/include/asm/kvm_mmu.h | 10 ++++++++++
>  virt/kvm/arm/mmu.c               | 11 +++++++----
>  3 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index e6eff8bf5d7f..37bf85d39607 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -87,6 +87,21 @@ void kvm_clear_hyp_idmap(void);
>  
>  #define kvm_pmd_mkhuge(pmd)	pmd_mkhuge(pmd)
>  
> +/*
> + * The following kvm_*pud*() functions are provided strictly to allow
> + * sharing code with arm64. They should never be called in practice.
> + */
> +static inline void kvm_set_s2pud_readonly(pud_t *pud)
> +{
> +	BUG();
> +}
> +
> +static inline bool kvm_s2pud_readonly(pud_t *pud)
> +{
> +	BUG();
> +	return false;
> +}

As arm32 does not support direct manipulation of PUD entries.

> +
>  static inline pte_t kvm_s2pte_mkwrite(pte_t pte)
>  {
>  	pte_val(pte) |= L_PTE_S2_RDWR;
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 13d482710292..8da6d1b2a196 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -251,6 +251,16 @@ static inline bool kvm_s2pmd_exec(pmd_t *pmdp)
>  	return !(READ_ONCE(pmd_val(*pmdp)) & PMD_S2_XN);
>  }
>  
> +static inline void kvm_set_s2pud_readonly(pud_t *pudp)
> +{
> +	kvm_set_s2pte_readonly((pte_t *)pudp);
> +}
> +
> +static inline bool kvm_s2pud_readonly(pud_t *pudp)
> +{
> +	return kvm_s2pte_readonly((pte_t *)pudp);
> +}
> +
>  #define hyp_pte_table_empty(ptep) kvm_page_empty(ptep)
>  
>  #ifdef __PAGETABLE_PMD_FOLDED
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index fb5325f7a1ac..1c669c3c1208 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1347,9 +1347,12 @@ static void  stage2_wp_puds(struct kvm *kvm, pgd_t *pgd,
>  	do {
>  		next = stage2_pud_addr_end(kvm, addr, end);
>  		if (!stage2_pud_none(kvm, *pud)) {
> -			/* TODO:PUD not supported, revisit later if supported */
> -			BUG_ON(stage2_pud_huge(kvm, *pud));
> -			stage2_wp_pmds(kvm, pud, addr, next);
> +			if (stage2_pud_huge(kvm, *pud)) {
> +				if (!kvm_s2pud_readonly(pud))
> +					kvm_set_s2pud_readonly(pud);
> +			} else {
> +				stage2_wp_pmds(kvm, pud, addr, next);
> +			}

As this series is enabling PUD related changes in multiple places, it is
reasonable to enable PGD level support as well even if it might not be
used much at the moment. I dont see much extra code to enable PGD, then
why not ? Even just to make the HugeTLB support matrix complete.
