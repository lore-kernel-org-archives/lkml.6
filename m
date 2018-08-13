Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9332EC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5723621774
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5723621774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbeHMM0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:26:53 -0400
Received: from foss.arm.com ([217.140.101.70]:56140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbeHMM0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:26:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D08267A9;
        Mon, 13 Aug 2018 02:45:23 -0700 (PDT)
Received: from [10.37.9.188] (unknown [10.37.9.188])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3660D3F73C;
        Mon, 13 Aug 2018 02:45:22 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] KVM: arm/arm64: Skip updating PMD entry if no
 change
To:     Punit Agrawal <punit.agrawal@arm.com>, kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        stable@vger.kernel.org
References: <20180813094049.3726-1-punit.agrawal@arm.com>
 <20180813094049.3726-2-punit.agrawal@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <ceb1927d-347a-7c49-1715-a309fab8d535@arm.com>
Date:   Mon, 13 Aug 2018 10:46:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180813094049.3726-2-punit.agrawal@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/13/2018 10:40 AM, Punit Agrawal wrote:
> Contention on updating a PMD entry by a large number of vcpus can lead
> to duplicate work when handling stage 2 page faults. As the page table
> update follows the break-before-make requirement of the architecture,
> it can lead to repeated refaults due to clearing the entry and
> flushing the tlbs.
> 
> This problem is more likely when -
> 
> * there are large number of vcpus
> * the mapping is large block mapping
> 
> such as when using PMD hugepages (512MB) with 64k pages.
> 
> Fix this by skipping the page table update if there is no change in
> the entry being updated.
> 
> Fixes: ad361f093c1e ("KVM: ARM: Support hugetlbfs backed huge pages")
> Change-Id: Ib417957c842ef67a6f4b786f68df62048d202c24
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: stable@vger.kernel.org
> ---
>   virt/kvm/arm/mmu.c | 40 +++++++++++++++++++++++++++++-----------
>   1 file changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 1d90d79706bd..2ab977edc63c 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1015,19 +1015,36 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
>   	pmd = stage2_get_pmd(kvm, cache, addr);
>   	VM_BUG_ON(!pmd);
>   
> -	/*
> -	 * Mapping in huge pages should only happen through a fault.  If a
> -	 * page is merged into a transparent huge page, the individual
> -	 * subpages of that huge page should be unmapped through MMU
> -	 * notifiers before we get here.
> -	 *
> -	 * Merging of CompoundPages is not supported; they should become
> -	 * splitting first, unmapped, merged, and mapped back in on-demand.
> -	 */
> -	VM_BUG_ON(pmd_present(*pmd) && pmd_pfn(*pmd) != pmd_pfn(*new_pmd));
> -
>   	old_pmd = *pmd;
> +
>   	if (pmd_present(old_pmd)) {
> +		/*
> +		 * Mapping in huge pages should only happen through a
> +		 * fault.  If a page is merged into a transparent huge
> +		 * page, the individual subpages of that huge page
> +		 * should be unmapped through MMU notifiers before we
> +		 * get here.
> +		 *
> +		 * Merging of CompoundPages is not supported; they
> +		 * should become splitting first, unmapped, merged,
> +		 * and mapped back in on-demand.
> +		 */
> +		VM_BUG_ON(pmd_pfn(old_pmd) != pmd_pfn(*new_pmd));
> +
> +		/*
> +		 * Multiple vcpus faulting on the same PMD entry, can
> +		 * lead to them sequentially updating the PMD with the
> +		 * same value. Following the break-before-make
> +		 * (pmd_clear() followed by tlb_flush()) process can
> +		 * hinder forward progress due to refaults generated
> +		 * on missing translations.
> +		 *
> +		 * Skip updating the page table if the entry is
> +		 * unchanged.
> +		 */
> +		if (pmd_val(old_pmd) == pmd_val(*new_pmd))
> +			goto out;

minor nit: You could as well return here, as there are no other users
for the label and there are no clean up actions.

Either way,

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


> +
>   		pmd_clear(pmd);
>   		kvm_tlb_flush_vmid_ipa(kvm, addr);
>   	} else {
> @@ -1035,6 +1052,7 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
>   	}
>   
>   	kvm_set_pmd(pmd, *new_pmd);
> +out:
>   	return 0;
>   }
>   
> 

