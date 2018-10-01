Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4EBC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC8E208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC8E208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbeJBEIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:08:47 -0400
Received: from foss.arm.com ([217.140.101.70]:56128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbeJBEIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:08:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12CA080D;
        Mon,  1 Oct 2018 14:29:00 -0700 (PDT)
Received: from [10.37.10.63] (unknown [10.37.10.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 526073F5D3;
        Mon,  1 Oct 2018 14:28:58 -0700 (PDT)
Subject: Re: [PATCH v8 9/9] KVM: arm64: Add support for creating PUD hugepages
 at stage 2
To:     Punit Agrawal <punit.agrawal@arm.com>, kvmarm@lists.cs.columbia.edu
Cc:     marc.zyngier@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20181001155443.23032-1-punit.agrawal@arm.com>
 <20181001155443.23032-10-punit.agrawal@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <3bd022cd-e470-479a-d7a5-680810db6a42@arm.com>
Date:   Mon, 1 Oct 2018 22:30:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20181001155443.23032-10-punit.agrawal@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2018 04:54 PM, Punit Agrawal wrote:
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
> ---
>   arch/arm/include/asm/kvm_mmu.h         |  20 +++++
>   arch/arm/include/asm/stage2_pgtable.h  |   9 +++
>   arch/arm64/include/asm/kvm_mmu.h       |  16 ++++
>   arch/arm64/include/asm/pgtable-hwdef.h |   2 +
>   arch/arm64/include/asm/pgtable.h       |   2 +
>   virt/kvm/arm/mmu.c                     | 106 +++++++++++++++++++++++--
>   6 files changed, 149 insertions(+), 6 deletions(-)
> 

...

> diff --git a/arch/arm/include/asm/stage2_pgtable.h b/arch/arm/include/asm/stage2_pgtable.h
> index f6a7ea805232..a4ec25360e50 100644
> --- a/arch/arm/include/asm/stage2_pgtable.h
> +++ b/arch/arm/include/asm/stage2_pgtable.h
> @@ -68,4 +68,13 @@ stage2_pmd_addr_end(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
>   #define stage2_pmd_table_empty(kvm, pmdp)	kvm_page_empty(pmdp)
>   #define stage2_pud_table_empty(kvm, pudp)	false
>   
> +static inline bool kvm_stage2_has_pud(struct kvm *kvm)
> +{
> +#if CONFIG_PGTABLE_LEVELS > 3
> +	return true;
> +#else
> +	return false;
> +#endif

nit: We can only have PGTABLE_LEVELS=3 on ARM with LPAE.
AFAIT, this can be set to false always for ARM.

> +}
> +

...

> @@ -1669,7 +1752,18 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>   	needs_exec = exec_fault ||
>   		(fault_status == FSC_PERM && stage2_is_exec(kvm, fault_ipa));
>   
> -	if (hugetlb && vma_pagesize == PMD_SIZE) {
> +	if (hugetlb && vma_pagesize == PUD_SIZE) {
> +		pud_t new_pud = kvm_pfn_pud(pfn, mem_type);
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


Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
