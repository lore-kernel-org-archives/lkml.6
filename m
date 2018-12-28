Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEE1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 02:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484B9214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 02:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbeL1Cz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 21:55:59 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:54840 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbeL1Cz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 21:55:58 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 780CF9DA;
        Fri, 28 Dec 2018 02:55:55 +0000 (UTC)
Date:   Thu, 27 Dec 2018 18:55:53 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>, Shaohua Li <shli@kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Kelley Nielsen <kelleynnn@gmail.com>
Subject: Re: [PATCH] mm, swap: Fix swapoff with KSM pages
Message-Id: <20181227185553.81928247d95418191b063d40@linux-foundation.org>
In-Reply-To: <20181226051522.28442-1-ying.huang@intel.com>
References: <20181226051522.28442-1-ying.huang@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Dec 2018 13:15:22 +0800 Huang Ying <ying.huang@intel.com> wrote:

> KSM pages may be mapped to the multiple VMAs that cannot be reached
> from one anon_vma.  So during swapin, a new copy of the page need to
> be generated if a different anon_vma is needed, please refer to
> comments of ksm_might_need_to_copy() for details.
> 
> During swapoff, unuse_vma() uses anon_vma (if available) to locate VMA
> and virtual address mapped to the page, so not all mappings to a
> swapped out KSM page could be found.  So in try_to_unuse(), even if
> the swap count of a swap entry isn't zero, the page needs to be
> deleted from swap cache, so that, in the next round a new page could
> be allocated and swapin for the other mappings of the swapped out KSM
> page.
> 
> But this contradicts with the THP swap support.  Where the THP could
> be deleted from swap cache only after the swap count of every swap
> entry in the huge swap cluster backing the THP has reach 0.  So
> try_to_unuse() is changed in commit e07098294adf ("mm, THP, swap:
> support to reclaim swap space for THP swapped out") to check that
> before delete a page from swap cache, but this has broken KSM swapoff
> too.
> 
> Fortunately, KSM is for the normal pages only, so the original
> behavior for KSM pages could be restored easily via checking
> PageTransCompound().  That is how this patch works.
> 
> ...
>
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2197,7 +2197,8 @@ int try_to_unuse(unsigned int type, bool frontswap,
>  		 */
>  		if (PageSwapCache(page) &&
>  		    likely(page_private(page) == entry.val) &&
> -		    !page_swapped(page))
> +		    (!PageTransCompound(page) ||
> +		     !swap_page_trans_huge_swapped(si, entry)))
>  			delete_from_swap_cache(compound_head(page));
>  

The patch "mm, swap: rid swapoff of quadratic complexity" changes this
code significantly.  There are a few issues with that patch so I'll
drop it for now.

Vineeth, please ensure that future versions retain the above fix,
thanks.


