Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0029DC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C8A21774
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C8A21774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbeHMM2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 08:28:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56168 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728310AbeHMM2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 08:28:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 117777A9;
        Mon, 13 Aug 2018 02:46:35 -0700 (PDT)
Received: from [10.37.9.188] (unknown [10.37.9.188])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D7503F73C;
        Mon, 13 Aug 2018 02:46:33 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] KVM: arm/arm64: Skip updating PTE entry if no
 change
To:     Punit Agrawal <punit.agrawal@arm.com>, kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        stable@vger.kernel.org
References: <20180813094049.3726-1-punit.agrawal@arm.com>
 <20180813094049.3726-3-punit.agrawal@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <3ef331d7-d31a-a61b-7ad0-eb7c8bee10bd@arm.com>
Date:   Mon, 13 Aug 2018 10:47:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180813094049.3726-3-punit.agrawal@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/13/2018 10:40 AM, Punit Agrawal wrote:
> When there is contention on faulting in a particular page table entry
> at stage 2, the break-before-make requirement of the architecture can
> lead to additional refaulting due to TLB invalidation.
> 
> Avoid this by skipping a page table update if the new value of the PTE
> matches the previous value.
> 
> Fixes: d5d8184d35c9 ("KVM: ARM: Memory virtualization setup")
> Change-Id: I28e17daf394a4821b13c2cf8726bf72bf30434f9
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: stable@vger.kernel.org
> ---
>   virt/kvm/arm/mmu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 2ab977edc63c..d0a9dccc3793 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1120,6 +1120,10 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
>   	/* Create 2nd stage page table mapping - Level 3 */
>   	old_pte = *pte;
>   	if (pte_present(old_pte)) {
> +		/* Skip page table update if there is no change */
> +		if (pte_val(old_pte) == pte_val(*new_pte))
> +			goto out;
> +
>   		kvm_set_pte(pte, __pte(0));
>   		kvm_tlb_flush_vmid_ipa(kvm, addr);
>   	} else {
> @@ -1127,6 +1131,7 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
>   	}
>   
>   	kvm_set_pte(pte, *new_pte);
> +out:

Similar comments as the previous patch, either way:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
