Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F91C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 02:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5CB2184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 02:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbfADCZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 21:25:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:55071 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfADCZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 21:25:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 18:25:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,437,1539673200"; 
   d="scan'208";a="135191315"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.10])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jan 2019 18:25:15 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     <tim.c.chen@intel.com>, <minchan@kernel.org>,
        <daniel.m.jordan@oracle.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v5 PATCH 2/2] mm: swap: add comment for swap_vma_readahead
References: <1546543673-108536-1-git-send-email-yang.shi@linux.alibaba.com>
        <1546543673-108536-2-git-send-email-yang.shi@linux.alibaba.com>
Date:   Fri, 04 Jan 2019 10:25:15 +0800
In-Reply-To: <1546543673-108536-2-git-send-email-yang.shi@linux.alibaba.com>
        (Yang Shi's message of "Fri, 4 Jan 2019 03:27:53 +0800")
Message-ID: <87imz5tb04.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Shi <yang.shi@linux.alibaba.com> writes:

> swap_vma_readahead()'s comment is missed, just add it.
>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Tim Chen <tim.c.chen@intel.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Thank!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Best Regards,
Huang, Ying

> ---
> v5: Fixed the comments per Ying Huang
>
>  mm/swap_state.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 78d500e..c8730d7 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -523,7 +523,7 @@ static unsigned long swapin_nr_pages(unsigned long offset)
>   * This has been extended to use the NUMA policies from the mm triggering
>   * the readahead.
>   *
> - * Caller must hold down_read on the vma->vm_mm if vmf->vma is not NULL.
> + * Caller must hold read mmap_sem if vmf->vma is not NULL.
>   */
>  struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>  				struct vm_fault *vmf)
> @@ -698,6 +698,20 @@ static void swap_ra_info(struct vm_fault *vmf,
>  	pte_unmap(orig_pte);
>  }
>  
> +/**
> + * swap_vma_readahead - swap in pages in hope we need them soon
> + * @entry: swap entry of this memory
> + * @gfp_mask: memory allocation flags
> + * @vmf: fault information
> + *
> + * Returns the struct page for entry and addr, after queueing swapin.
> + *
> + * Primitive swap readahead code. We simply read in a few pages whoes
> + * virtual addresses are around the fault address in the same vma.
> + *
> + * Caller must hold read mmap_sem if vmf->vma is not NULL.
> + *
> + */
>  static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
>  				       struct vm_fault *vmf)
>  {
