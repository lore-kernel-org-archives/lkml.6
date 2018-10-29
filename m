Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC78C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381C520870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381C520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbeJ2Rp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:45:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36422 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729300AbeJ2Rpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:45:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BD1D341;
        Mon, 29 Oct 2018 01:58:02 -0700 (PDT)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8BCC3F557;
        Mon, 29 Oct 2018 01:58:00 -0700 (PDT)
Date:   Mon, 29 Oct 2018 08:57:50 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ashish Mhetre <amhetre@nvidia.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        avanbrunt@nvidia.com, linux-kernel@vger.kernel.org,
        vdumpa@nvidia.com
Subject: Re: [PATCH V2] arm64: Don't flush tlb while clearing the accessed bit
Message-ID: <20181029085738.kcjiwf5p6rdqeb6j@salmiak>
References: <1540794599-30922-1-git-send-email-amhetre@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540794599-30922-1-git-send-email-amhetre@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 11:59:59AM +0530, Ashish Mhetre wrote:
> From: Alex Van Brunt <avanbrunt@nvidia.com>
> 
> Accessed bit is used to age a page and in generic implementation there is
> flush_tlb while clearing the accessed bit.
> Flushing a TLB is overhead on ARM64 as access flag faults don't get
> translation table entries cached into TLB's. Flushing TLB is not necessary
> for this. Clearing the accessed bit without flushing TLB doesn't cause data
> corruption on ARM64. [It may cause incorrect page aging but chances of that
> should be relatively low.]
> In our case with this patch, speed of reading from fast NVMe/SSD through
> PCIe got improved by 10% ~ 15% and writing got improved by 20% ~ 40%.
> So for performance optimisation don't flush TLB when clearing the accessed
> bit on ARM64.
> x86 made the same optimization even though their TLB invalidate is much
> faster as it doesn't broadcast to other CPUs.

Please specifically refer to commit:

  b13b1d2d8692b437 ("x86/mm: In the PTE swapout page reclaim case clear the accessed bit instead of flushing the TLB")

... so that it's easy for people to track down the relevant x86 change.

> 
> Signed-off-by: Alex Van Brunt <avanbrunt@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
> v2: Added comments about why flushing is not needed while clearing accessed bit
> 
>  arch/arm64/include/asm/pgtable.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 2ab2031..33e1940 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -652,6 +652,22 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
>  	return __ptep_test_and_clear_young(ptep);
>  }
>  
> +#define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
> +static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
> +					 unsigned long address, pte_t *ptep)
> +{
> +	/*
> +	 * Flushing a TLB is overhead on ARM64 as access flag faults don't get
> +	 * translation table entries cached into TLB's. Flushing TLB is not
> +	 * necessary for this. Clearing the accessed bit without flushing TLB
> +	 * doesn't cause data corruption on ARM64.[ It may cause imcorrect page
> +	 * aging but chances of this should be comparatively low. ]
> +	 * So as a performance optimization don't flush the TLB when clearing
> +	 * the accessed bit.
> +	 */

Can we just copy the x86 comment from commit b13b1d2d8692b437?

Thanks,
Mark.

> +	return ptep_test_and_clear_young(vma, address, ptep);
> +}
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
>  static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> -- 
> 2.7.4
> 
