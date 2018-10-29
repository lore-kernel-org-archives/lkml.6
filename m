Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3164C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CC32084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CC32084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbeJ2TnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:43:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38784 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbeJ2TnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:43:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C330341;
        Mon, 29 Oct 2018 03:55:09 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1CA143F6A8;
        Mon, 29 Oct 2018 03:55:09 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 11B021AE091C; Mon, 29 Oct 2018 10:55:16 +0000 (GMT)
Date:   Mon, 29 Oct 2018 10:55:16 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Ashish Mhetre <amhetre@nvidia.com>
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org, avanbrunt@nvidia.com,
        Snikam@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] arm64: Don't flush tlb while clearing the accessed bit
Message-ID: <20181029105515.GD14127@arm.com>
References: <1540805158-618-1-git-send-email-amhetre@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540805158-618-1-git-send-email-amhetre@nvidia.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 02:55:58PM +0530, Ashish Mhetre wrote:
> From: Alex Van Brunt <avanbrunt@nvidia.com>
> 
> Accessed bit is used to age a page and in generic implementation there is
> flush_tlb while clearing the accessed bit.
> Flushing a TLB is overhead on ARM64 as access flag faults don't get
> translation table entries cached into TLB's. Flushing TLB is not necessary
> for this. Clearing the accessed bit without flushing TLB doesn't cause data
> corruption on ARM64.
> In our case with this patch, speed of reading from fast NVMe/SSD through
> PCIe got improved by 10% ~ 15% and writing got improved by 20% ~ 40%.
> So for performance optimisation don't flush TLB when clearing the accessed
> bit on ARM64.
> x86 made the same optimization even though their TLB invalidate is much
> faster as it doesn't broadcast to other CPUs.

Ok, but they may end up using IPIs so lets avoid these vague performance
claims in the log unless they're backed up with numbers.

> Please refer to:
> 'commit b13b1d2d8692 ("x86/mm: In the PTE swapout page reclaim case clear
> the accessed bit instead of flushing the TLB")'
> 
> Signed-off-by: Alex Van Brunt <avanbrunt@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 2ab2031..080d842 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -652,6 +652,26 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
>  	return __ptep_test_and_clear_young(ptep);
>  }
>  
> +#define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
> +static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
> +					 unsigned long address, pte_t *ptep)
> +{
> +	/*
> +	 * On ARM64 CPUs, clearing the accessed bit without a TLB flush
> +	 * doesn't cause data corruption. [ It could cause incorrect
> +	 * page aging and the (mistaken) reclaim of hot pages, but the
> +	 * chance of that should be relatively low. ]
> +	 *
> +	 * So as a performance optimization don't flush the TLB when
> +	 * clearing the accessed bit, it will eventually be flushed by
> +	 * a context switch or a VM operation anyway. [ In the rare
> +	 * event of it not getting flushed for a long time the delay
> +	 * shouldn't really matter because there's no real memory
> +	 * pressure for swapout to react to. ]

This is blindly copied from x86 and isn't true for us: we don't invalidate
the TLB on context switch. That means our window for keeping the stale
entries around is potentially much bigger and might not be a great idea.

If we roll a TLB invalidation routine without the trailing DSB, what sort of
performance does that get you?

Will
