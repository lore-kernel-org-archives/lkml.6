Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D058FC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 07:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E04A2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 07:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbfACHlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 02:41:08 -0500
Received: from mga09.intel.com ([134.134.136.24]:62937 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbfACHlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 02:41:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 23:41:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,434,1539673200"; 
   d="scan'208";a="264052827"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.13.10])
  by orsmga004.jf.intel.com with ESMTP; 02 Jan 2019 23:41:06 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     <tim.c.chen@intel.com>, <minchan@kernel.org>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [v4 PATCH 2/2] mm: swap: add comment for swap_vma_readahead
References: <1546145375-793-1-git-send-email-yang.shi@linux.alibaba.com>
        <1546145375-793-2-git-send-email-yang.shi@linux.alibaba.com>
Date:   Thu, 03 Jan 2019 15:41:05 +0800
In-Reply-To: <1546145375-793-2-git-send-email-yang.shi@linux.alibaba.com>
        (Yang Shi's message of "Sun, 30 Dec 2018 12:49:35 +0800")
Message-ID: <875zv6w5m6.fsf@yhuang-dev.intel.com>
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
> ---
>  mm/swap_state.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 78d500e..dd8f698 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -698,6 +698,23 @@ static void swap_ra_info(struct vm_fault *vmf,
>  	pte_unmap(orig_pte);
>  }
>  
> +/**
> + * swap_vm_readahead - swap in pages in hope we need them soon

s/swap_vm_readahead/swap_vma_readahead/

> + * @entry: swap entry of this memory
> + * @gfp_mask: memory allocation flags
> + * @vmf: fault information
> + *
> + * Returns the struct page for entry and addr, after queueing swapin.
> + *
> + * Primitive swap readahead code. We simply read in a few pages whoes
> + * virtual addresses are around the fault address in the same vma.
> + *
> + * This has been extended to use the NUMA policies from the mm triggering
> + * the readahead.

What is this?  I know you copy it from swap_cluster_readahead(), but we
have only one mm for vma readahead.

> + * Caller must hold down_read on the vma->vm_mm if vmf->vma is not NULL.

Better to make it explicit that your are talking about mmap_sem?

Best Regards,
Huang, Ying

> + *
> + */
>  static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
>  				       struct vm_fault *vmf)
>  {
