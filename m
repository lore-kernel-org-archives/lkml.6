Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CFEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C394720859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbfAIQRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:17:12 -0500
Received: from mga01.intel.com ([192.55.52.88]:65156 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731219AbfAIQRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:17:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 08:17:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,458,1539673200"; 
   d="scan'208";a="105258001"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga007.jf.intel.com with ESMTP; 09 Jan 2019 08:17:11 -0800
Message-ID: <54c280dbd0ff8e17a6c465778c98e2dbbbde7918.camel@linux.intel.com>
Subject: Re: [PATCH v8] mm/page_alloc.c: memory_hotplug: free pages as
 higher order
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Arun KS <arunks@codeaurora.org>, arunks.linux@gmail.com,
        akpm@linux-foundation.org, mhocko@kernel.org, vbabka@suse.cz,
        osalvador@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     getarunks@gmail.com
Date:   Wed, 09 Jan 2019 08:17:11 -0800
In-Reply-To: <1547032395-24582-1-git-send-email-arunks@codeaurora.org>
References: <1547032395-24582-1-git-send-email-arunks@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-09 at 16:43 +0530, Arun KS wrote:
> When freeing pages are done with higher order, time spent on coalescing
> pages by buddy allocator can be reduced.  With section size of 256MB, hot
> add latency of a single section shows improvement from 50-60 ms to less
> than 1 ms, hence improving the hot add latency by 60 times.  Modify
> external providers of online callback to align with the change.
> 
> Signed-off-by: Arun KS <arunks@codeaurora.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> ---
> Changes since v7:
> - Rebased to 5.0-rc1.
> - Fixed onlined_pages accounting.
> - Added comment for return value of online_page_callback.
> - Renamed xen_bring_pgs_online to xen_online_pages.

As far as the renaming you should try to be consistent. If you aren't
going to rename generic_online_page or hv_online_page I wouldn't bother
with renaming xen_online_page. I would stick with the name
xen_online_page since it is a single high order page that you are
freeing.

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
> v7: https://lore.kernel.org/patchwork/patch/1028908/
> v6: https://lore.kernel.org/patchwork/patch/1007253/
> v5: https://lore.kernel.org/patchwork/patch/995739/
> v4: https://lore.kernel.org/patchwork/patch/995111/
> v3: https://lore.kernel.org/patchwork/patch/992348/
> v2: https://lore.kernel.org/patchwork/patch/991363/
> v1: https://lore.kernel.org/patchwork/patch/989445/
> RFC: https://lore.kernel.org/patchwork/patch/984754/
> ---
>  drivers/hv/hv_balloon.c        |  6 +++--
>  drivers/xen/balloon.c          | 21 +++++++++++------
>  include/linux/memory_hotplug.h |  2 +-
>  mm/internal.h                  |  1 +
>  mm/memory_hotplug.c            | 51 +++++++++++++++++++++++++++++++-----------
>  mm/page_alloc.c                |  8 +++----
>  6 files changed, 62 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 5301fef..211f3fe 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -771,7 +771,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
>  	}
>  }
>  
> -static void hv_online_page(struct page *pg)
> +static int hv_online_page(struct page *pg, unsigned int order)
>  {
>  	struct hv_hotadd_state *has;
>  	unsigned long flags;
> @@ -783,10 +783,12 @@ static void hv_online_page(struct page *pg)
>  		if ((pfn < has->start_pfn) || (pfn >= has->end_pfn))
>  			continue;
>  
> -		hv_page_online_one(has, pg);
> +		hv_bring_pgs_online(has, pfn, (1UL << order));
>  		break;
>  	}
>  	spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> +
> +	return 0;
>  }
>  

I would hold off on adding return values until you actually have code
that uses them. It will make things easier if somebody has to backport
this to a stable branch and avoid adding complexity until it is needed.

Also the patch description doesn't really explain that it is doing this
so it might be better to break it off into a separate patch so you can
call out exactly why you are adding a return value in the patch
description.

- Alex

