Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA57C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE6E2064D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE6E2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbeJAUij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:38:39 -0400
Received: from foss.arm.com ([217.140.101.70]:49592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729476AbeJAUih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:38:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BA457A9;
        Mon,  1 Oct 2018 07:00:40 -0700 (PDT)
Received: from localhost (e105922-lin.emea.arm.com [10.4.13.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CFE03F5B7;
        Mon,  1 Oct 2018 07:00:40 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@arm.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7.1 9/9] KVM: arm64: Add support for creating PUD hugepages at stage 2
References: <20180924174552.8387-10-punit.agrawal@arm.com>
        <20180925143731.27475-1-punit.agrawal@arm.com>
Date:   Mon, 01 Oct 2018 15:00:38 +0100
In-Reply-To: <20180925143731.27475-1-punit.agrawal@arm.com> (Punit Agrawal's
        message of "Tue, 25 Sep 2018 15:37:31 +0100")
Message-ID: <87bm8dn4vt.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Punit Agrawal <punit.agrawal@arm.com> writes:

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
>
> v7 -> v7.1
>
> * Added arm helper kvm_stage2_has_pud()
> * Added check for PUD level present at stage 2
> * Dropped redundant comment
> * Fixed up kvm_pud_mkhuge() to complain on arm
>
>  arch/arm/include/asm/kvm_mmu.h         |  20 +++++
>  arch/arm/include/asm/stage2_pgtable.h  |   5 ++
>  arch/arm64/include/asm/kvm_mmu.h       |  16 ++++
>  arch/arm64/include/asm/pgtable-hwdef.h |   2 +
>  arch/arm64/include/asm/pgtable.h       |   2 +
>  virt/kvm/arm/mmu.c                     | 106 +++++++++++++++++++++++--
>  6 files changed, 145 insertions(+), 6 deletions(-)
>

[...]

> diff --git a/arch/arm/include/asm/stage2_pgtable.h b/arch/arm/include/asm/stage2_pgtable.h
> index f6a7ea805232..ec1567d9eb4b 100644
> --- a/arch/arm/include/asm/stage2_pgtable.h
> +++ b/arch/arm/include/asm/stage2_pgtable.h
> @@ -68,4 +68,9 @@ stage2_pmd_addr_end(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
>  #define stage2_pmd_table_empty(kvm, pmdp)	kvm_page_empty(pmdp)
>  #define stage2_pud_table_empty(kvm, pudp)	false
>  
> +static inline bool kvm_stage2_has_pud(struct kvm *kvm)
> +{
> +	return KVM_VTCR_SL0 == VTCR_SL_L1;
> +}
> +

Turns out this isn't quite the right check. On arm32, the maximum number
of supported levels is 3 with LPAE - effectively the helper should
always return false.

I've updated the check locally to key off of CONFIG_PGTABLE_LEVELS. I'll
post these patches later today.

Thanks,
Punit
