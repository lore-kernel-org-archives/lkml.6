Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A14C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15A12082D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15A12082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbeJZRTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:19:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39818 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbeJZRTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:19:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A49D7341;
        Fri, 26 Oct 2018 01:43:04 -0700 (PDT)
Received: from blommer (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8ADDD3F6A8;
        Fri, 26 Oct 2018 01:43:02 -0700 (PDT)
Date:   Fri, 26 Oct 2018 09:42:58 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ashish Mhetre <amhetre@nvidia.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        avanbrunt@nvidia.com, linux-kernel@vger.kernel.org,
        vdumpa@nvidia.com, catalin.marinas@arm.com, will.deacon@arm.com
Subject: Re: [PATCH] arm64: Don't flush tlb while clearing the accessed bit
Message-ID: <20181026084258.sjp2vmarmsfj2wbz@blommer>
References: <1540483944-22718-1-git-send-email-amhetre@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540483944-22718-1-git-send-email-amhetre@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 09:42:24PM +0530, Ashish Mhetre wrote:
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

To save others the time, the relevant x86 commit is:

  b13b1d2d8692b437 ("x86/mm: In the PTE swapout page reclaim case clear the accessed bit instead of flushing the TLB")

That does call out the fact that this means page aging will be imprecise, and
hot pages might be reclaimed, with the claim being that the chance of this is
relatively low.

Do we have any numbers for other workloads?

> 
> Signed-off-by: Alex Van Brunt <avanbrunt@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 2ab2031..42931f6 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -652,6 +652,13 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
>  	return __ptep_test_and_clear_young(ptep);
>  }
>  
> +#define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
> +static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
> +					 unsigned long address, pte_t *ptep)
> +{
> +	return ptep_test_and_clear_young(vma, address, ptep);
> +}

As with the x86 commit, we should comment why we're not flushing the TLB here.

Thanks,
Mark.

> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
>  static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> -- 
> 2.7.4
> 
