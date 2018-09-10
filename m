Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE62C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764CB2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764CB2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeIJOty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:49:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54412 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbeIJOtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:49:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 571571596;
        Mon, 10 Sep 2018 02:56:39 -0700 (PDT)
Received: from [10.4.13.119] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 370903F557;
        Mon, 10 Sep 2018 02:56:38 -0700 (PDT)
Subject: Re: [PATCH] KVM: arm/arm64: Check memslot bounds before mapping
 hugepages
To:     Lukas Braun <koomi@moshbit.net>,
        Christoffer Dall <christoffer.dall@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     Ralph Palutke <ralph.palutke@fau.de>
References: <20180904163937.12759-1-koomi@moshbit.net>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <1e88db29-9bfd-7a47-ba36-c025c121c223@arm.com>
Date:   Mon, 10 Sep 2018 10:56:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904163937.12759-1-koomi@moshbit.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On 04/09/18 17:39, Lukas Braun wrote:
> Userspace can create a memslot with memory backed by (transparent)
> hugepages, but with bounds that do not align with hugepages.
> In that case, we cannot map the entire region in the guest as hugepages
> without exposing additional host memory to the guest and potentially
> interfering with other memslots.
> Consequently, this patch adds a bounds check when populating guest page
> tables and forces the creation of regular PTEs if mapping an entire
> hugepage would violate the memslots bounds.
> 
> Signed-off-by: Lukas Braun <koomi@moshbit.net>
> ---
>  virt/kvm/arm/mmu.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index ed162a6c57c5..bdbec1d136a1 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1504,6 +1504,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  		hugetlb = true;
>  		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
>  	} else {
> +		unsigned long pmd_fn_mask = PTRS_PER_PMD - 1;
> +
>  		/*
>  		 * Pages belonging to memslots that don't have the same
>  		 * alignment for userspace and IPA cannot be mapped using
> @@ -1513,8 +1515,17 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  		 * unmapping, updates, and splits of the THP or other pages
>  		 * in the stage-2 block range.
>  		 */
> -		if ((memslot->userspace_addr & ~PMD_MASK) !=
> -		    ((memslot->base_gfn << PAGE_SHIFT) & ~PMD_MASK))
> +		int aligned = ((memslot->userspace_addr & ~PMD_MASK) ==
> +			((memslot->base_gfn << PAGE_SHIFT) & ~PMD_MASK));

This should most probably be a bool, together with the in_bounds variable.

> +
> +		/*
> +		 * We also can't map a huge page if it would violate the bounds
> +		 * of the containing memslot.
> +		 */
> +		int in_bounds = ((memslot->base_gfn <= (gfn & ~pmd_fn_mask)) &&
> +			((memslot->base_gfn + memslot->npages) > (gfn | pmd_fn_mask)));

It's the morning, and I haven't had much coffee, but this looks 
confusing as hell. Most of the reasoning here is done in terms of 
addresses, and you're now mixing it with a different unit, making the 
result more unreadable.

I find it easier to read it as:

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index b3c9cc73b0f1..3729ca414fc3 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1516,6 +1516,14 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		if ((memslot->userspace_addr & ~PMD_MASK) !=
 		    ((memslot->base_gfn << PAGE_SHIFT) & ~PMD_MASK))
 			force_pte = true;
+
+		/*
+		 * Force PTE mapping if a THP would lead to map
+		 * something outside of the memslot.
+		 */
+		if ((fault_ipa & S2_PMD_MASK) < (memslot->base_gfn << PAGE_SHIFT) ||
+		    ALIGN(fault_ipa, S2_PMD_SIZE) >= ((memslot->base_gfn + memslot->npages) << PAGE_SHIFT))
+			force_pte = true;
 	}
 	up_read(&current->mm->mmap_sem);
 
which is of course completely untested.

> +
> +		if (!aligned || !in_bounds)
>  			force_pte = true;
>  	}
>  	up_read(&current->mm->mmap_sem);
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
