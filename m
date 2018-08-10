Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DD9C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12BD22404
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12BD22404
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeHJN4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 09:56:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36854 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbeHJN4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 09:56:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF20715A2;
        Fri, 10 Aug 2018 04:26:45 -0700 (PDT)
Received: from [10.37.10.95] (unknown [10.37.10.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 401413F5D4;
        Fri, 10 Aug 2018 04:26:44 -0700 (PDT)
Subject: Re: [PATCH] KVM: arm/arm64: Skip updating page table entry if no
 change
To:     Punit Agrawal <punit.agrawal@arm.com>, kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>
References: <20180810111300.17144-1-punit.agrawal@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <23d3c76f-e839-dbab-227c-f6bc068d3ba0@arm.com>
Date:   Fri, 10 Aug 2018 12:27:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180810111300.17144-1-punit.agrawal@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/2018 12:13 PM, Punit Agrawal wrote:
> Contention on updating a page table entry by a large number of vcpus
> can lead to duplicate work when handling stage 2 page faults. As the
> page table update follows the break-before-make requirement of the
> architecture, it can lead to repeated refaults due to clearing the
> entry and flushing the tlbs.
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
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> --


>   virt/kvm/arm/mmu.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 1d90d79706bd..a66a5441ca2f 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1027,6 +1027,18 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
>   	VM_BUG_ON(pmd_present(*pmd) && pmd_pfn(*pmd) != pmd_pfn(*new_pmd));
>   
>   	old_pmd = *pmd;
> +	/*
> +	 * Multiple vcpus faulting on the same PMD entry, can lead to
> +	 * them sequentially updating the PMD with the same
> +	 * value. Following the break-before-make (pmd_clear()
> +	 * followed by tlb_flush()) process can hinder forward
> +	 * progress due to refaults generated on missing translations.
> +	 *
> +	 * Skip updating the page table if the entry is unchanged.
> +	 */
> +	if (pmd_val(old_pmd) == pmd_val(*new_pmd))
> +		return 0;
> +
>   	if (pmd_present(old_pmd)) {
>   		pmd_clear(pmd);
>   		kvm_tlb_flush_vmid_ipa(kvm, addr);
> @@ -1101,6 +1113,10 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
>   
>   	/* Create 2nd stage page table mapping - Level 3 */
>   	old_pte = *pte;
> +	/* Skip page table update if there is no change */
> +	if (pte_val(old_pte) == pte_val(*new_pte))
> +		return 0;
> +
>   	if (pte_present(old_pte)) {
>   		kvm_set_pte(pte, __pte(0));
>   		kvm_tlb_flush_vmid_ipa(kvm, addr);
> 

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


