Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D90C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039C1217CB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039C1217CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbeHMRJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 13:09:44 -0400
Received: from foss.arm.com ([217.140.101.70]:59460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbeHMRJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 13:09:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F76C80D;
        Mon, 13 Aug 2018 07:27:14 -0700 (PDT)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87C4D3F5D0;
        Mon, 13 Aug 2018 07:27:13 -0700 (PDT)
Date:   Mon, 13 Aug 2018 16:27:11 +0200
From:   Christoffer Dall <christoffer.dall@arm.com>
To:     Punit Agrawal <punit.agrawal@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH] KVM: arm/arm64: Skip updating page table entry if no
 change
Message-ID: <20180813142711.GJ20606@e113682-lin.lund.arm.com>
References: <20180810111300.17144-1-punit.agrawal@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810111300.17144-1-punit.agrawal@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 12:13:00PM +0100, Punit Agrawal wrote:
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
> Hi,
> 
> This problem was reported by a user when testing PUD hugepages. During
> VM restore when all threads are running cpu intensive workload, the
> refauting was causing the VM to not make any forward progress.
> 
> This patch fixes the problem for PMD and PTE page fault handling.
> 
> Thanks,
> Punit
> 
> Change-Id: I04c9aa8b9fbada47deb1a171c9959f400a0d2a21
> ---
>  virt/kvm/arm/mmu.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 1d90d79706bd..a66a5441ca2f 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1027,6 +1027,18 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
>  	VM_BUG_ON(pmd_present(*pmd) && pmd_pfn(*pmd) != pmd_pfn(*new_pmd));
>  
>  	old_pmd = *pmd;
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
>  	if (pmd_present(old_pmd)) {
>  		pmd_clear(pmd);
>  		kvm_tlb_flush_vmid_ipa(kvm, addr);
> @@ -1101,6 +1113,10 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
>  
>  	/* Create 2nd stage page table mapping - Level 3 */
>  	old_pte = *pte;
> +	/* Skip page table update if there is no change */
> +	if (pte_val(old_pte) == pte_val(*new_pte))
> +		return 0;
> +
>  	if (pte_present(old_pte)) {
>  		kvm_set_pte(pte, __pte(0));
>  		kvm_tlb_flush_vmid_ipa(kvm, addr);
> -- 
> 2.18.0
> 

Acked-by: Christoffer Dall <christoffer.dall@arm.com>
