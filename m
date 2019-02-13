Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6587C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9CA2073D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfBMLa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:30:56 -0500
Received: from foss.arm.com ([217.140.101.70]:52182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfBMLaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:30:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F933A78;
        Wed, 13 Feb 2019 03:30:55 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72E053F557;
        Wed, 13 Feb 2019 03:30:53 -0800 (PST)
Date:   Wed, 13 Feb 2019 11:30:51 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "yaojun8558363@gmail.com" <yaojun8558363@gmail.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [PATCH 3/3] arm64: mmu: pgd_pgtable_alloc: drop barrier
Message-ID: <20190213113050.GC22119@lakrids.cambridge.arm.com>
References: <20190213094831.7292-1-peng.fan@nxp.com>
 <20190213094831.7292-3-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213094831.7292-3-peng.fan@nxp.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 09:37:38AM +0000, Peng Fan wrote:
> The barriers are added for empty_zero_page, however the
> empty zero page has been moved to bss area by
> commit 5227cfa71f9e ("arm64: mm: place empty_zero_page in bss"),
> and it alreay added "dsb     ishst" in head.S to make sure
> the empty zero page visible to PTW.

The "zeroed page" the comment refers to is not empty_zero_page.

The page
the comment refers to is an arbitrary page returned by
__get_free_page(), which has been filled with zeroed at some point
thanks to PGALLOC_GFP containing __GFP_ZERO.

> pgd_pgtable_alloc is only called by __create_pgd_mapping, and
> there are implicit barriers in __create_pgd_mapping, so we
> could remove the barrier pgd_pgtable_alloc

I don't think this is true.

Consider:

  create_pgd_mapping()
  -> __create_pgd_mapping()
     -> alloc_init_pud()
        -> pgtable_alloc() // pgd_pgtable_alloc()
	-> __pgd_populate()

... where AFAICT there is no barrier between pgtable_alloc() and
__pgd_populate().

Where is the barrier between the page zeroing and the update of the pgd
entry?

Thanks,
Mark.

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> Note: this patch tested on qemu-system-aarch64, not real hardware.
> 
>  arch/arm64/mm/mmu.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index f61fa7c8fd2e..04e3d4d070ce 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -371,8 +371,6 @@ static phys_addr_t pgd_pgtable_alloc(void)
>  	if (!ptr || !pgtable_page_ctor(virt_to_page(ptr)))
>  		BUG();
>  
> -	/* Ensure the zeroed page is visible to the page table walker */
> -	dsb(ishst);
>  	return __pa(ptr);
>  }
>  
> -- 
> 2.16.4
> 
