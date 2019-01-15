Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A4DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7B120656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732846AbfAORei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:34:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:14048 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfAORei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:34:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2019 09:34:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,481,1539673200"; 
   d="scan'208";a="127980887"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga001.jf.intel.com with ESMTP; 15 Jan 2019 09:34:37 -0800
Message-ID: <9bc20a9f2f5d6a99afa61ad68d827090553c09fe.camel@linux.intel.com>
Subject: Re: [PATCH v10] mm/page_alloc.c: memory_hotplug: free pages as
 higher order
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Arun KS <arunks@codeaurora.org>, arunks.linux@gmail.com,
        akpm@linux-foundation.org, mhocko@kernel.org, vbabka@suse.cz,
        osalvador@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     getarunks@gmail.com
Date:   Tue, 15 Jan 2019 09:34:37 -0800
In-Reply-To: <1547571068-18902-1-git-send-email-arunks@codeaurora.org>
References: <1547571068-18902-1-git-send-email-arunks@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-15 at 22:21 +0530, Arun KS wrote:
> When freeing pages are done with higher order, time spent on coalescing
> pages by buddy allocator can be reduced.  With section size of 256MB, hot
> add latency of a single section shows improvement from 50-60 ms to less
> than 1 ms, hence improving the hot add latency by 60 times.  Modify
> external providers of online callback to align with the change.
> 
> Signed-off-by: Arun KS <arunks@codeaurora.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
> Changes since v9:
> - Fix condition check in hv_ballon driver.
> 
> Changes since v8:
> - Remove return type change for online_page_callback.
> - Use consistent names for external online_page providers.
> - Fix onlined_pages accounting.
> 
> Changes since v7:
> - Rebased to 5.0-rc1.
> - Fixed onlined_pages accounting.
> - Added comment for return value of online_page_callback.
> - Renamed xen_bring_pgs_online to xen_online_pages.
> 
> Changes since v6:
> - Rebased to 4.20
> - Changelog updated.
> - No improvement seen on arm64, hence removed removal of prefetch.
> 
> Changes since v5:
> - Rebased to 4.20-rc1.
> - Changelog updated.
> 
> Changes since v4:
> - As suggested by Michal Hocko,
> - Simplify logic in online_pages_block() by using get_order().
> - Seperate out removal of prefetch from __free_pages_core().
> 
> Changes since v3:
> - Renamed _free_pages_boot_core -> __free_pages_core.
> - Removed prefetch from __free_pages_core.
> - Removed xen_online_page().
> 
> Changes since v2:
> - Reuse code from __free_pages_boot_core().
> 
> Changes since v1:
> - Removed prefetch().
> 
> Changes since RFC:
> - Rebase.
> - As suggested by Michal Hocko remove pages_per_block.
> - Modifed external providers of online_page_callback.
> 
> v9: https://lore.kernel.org/patchwork/patch/1030806/
> v8: https://lore.kernel.org/patchwork/patch/1030332/
> v7: https://lore.kernel.org/patchwork/patch/1028908/
> v6: https://lore.kernel.org/patchwork/patch/1007253/
> v5: https://lore.kernel.org/patchwork/patch/995739/
> v4: https://lore.kernel.org/patchwork/patch/995111/
> v3: https://lore.kernel.org/patchwork/patch/992348/
> v2: https://lore.kernel.org/patchwork/patch/991363/
> v1: https://lore.kernel.org/patchwork/patch/989445/
> RFC: https://lore.kernel.org/patchwork/patch/984754/
> ---
>  drivers/hv/hv_balloon.c        |  4 ++--
>  drivers/xen/balloon.c          | 15 ++++++++++-----
>  include/linux/memory_hotplug.h |  2 +-
>  mm/internal.h                  |  1 +
>  mm/memory_hotplug.c            | 37 +++++++++++++++++++++++++------------
>  mm/page_alloc.c                |  8 ++++----
>  6 files changed, 45 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 5301fef..2ced9a7 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -771,7 +771,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
>  	}
>  }
>  
> -static void hv_online_page(struct page *pg)
> +static void hv_online_page(struct page *pg, unsigned int order)
>  {
>  	struct hv_hotadd_state *has;
>  	unsigned long flags;
> @@ -780,10 +780,11 @@ static void hv_online_page(struct page *pg)
>  	spin_lock_irqsave(&dm_device.ha_lock, flags);
>  	list_for_each_entry(has, &dm_device.ha_region_list, list) {
>  		/* The page belongs to a different HAS. */
> -		if ((pfn < has->start_pfn) || (pfn >= has->end_pfn))
> +		if ((pfn < has->start_pfn) ||
> +				(pfn + (1UL << order) >= has->end_pfn))

This check should be ">" has->end_pfn, not ">=".

>  			continue;
>  
> -		hv_page_online_one(has, pg);
> +		hv_bring_pgs_online(has, pfn, (1UL << order));

Also the parenthesis around "1UL << order" are unnecessary.
>  		break;
>  	}
>  	spin_unlock_irqrestore(&dm_device.ha_lock, flags);

The rest of this looks fine to me.

