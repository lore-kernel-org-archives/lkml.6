Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605B3C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 03:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF17214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 03:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF17214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeKONT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 08:19:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728166AbeKONT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 08:19:29 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D49F308A972;
        Thu, 15 Nov 2018 03:13:28 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9940A608C3;
        Thu, 15 Nov 2018 03:13:27 +0000 (UTC)
Date:   Thu, 15 Nov 2018 11:13:25 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm, memory_hotplug: check zone_movable in
 has_unmovable_pages
Message-ID: <20181115031325.GI2653@MiWiFi-R3L-srv>
References: <20181106095524.14629-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106095524.14629-1-mhocko@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 15 Nov 2018 03:13:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/18 at 10:55am, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> Page state checks are racy. Under a heavy memory workload (e.g. stress
> -m 200 -t 2h) it is quite easy to hit a race window when the page is
> allocated but its state is not fully populated yet. A debugging patch to

The original phenomenon is the value of /sys/devices/system/memory/memoryxxx/removable
is 0 on several memory blocks of hotpluggable node. And almost on each
hotpluggable node, there are one or several blocks which has this zero
value of removable attribute. It caused the hot removing failure always.

And only cat /sys/devices/system/memory/memoryxxx/removable will trigger
the call trace.

With this fix, all 'removable' of memory block on those hotpluggable
nodes are '1', and hotplug can succeed.

> dump the struct page state shows
> : [  476.575516] has_unmovable_pages: pfn:0x10dfec00, found:0x1, count:0x0
> : [  476.582103] page:ffffea0437fb0000 count:1 mapcount:1 mapping:ffff880e05239841 index:0x7f26e5000 compound_mapcount: 1
> : [  476.592645] flags: 0x5fffffc0090034(uptodate|lru|active|head|swapbacked)
> 
> Note that the state has been checked for both PageLRU and PageSwapBacked
> already. Closing this race completely would require some sort of retry
> logic. This can be tricky and error prone (think of potential endless
> or long taking loops).
> 
> Workaround this problem for movable zones at least. Such a zone should
> only contain movable pages. 15c30bc09085 ("mm, memory_hotplug: make
> has_unmovable_pages more robust") has told us that this is not strictly
> true though. Bootmem pages should be marked reserved though so we can
> move the original check after the PageReserved check. Pages from other
> zones are still prone to races but we even do not pretend that memory
> hotremove works for those so pre-mature failure doesn't hurt that much.
> 
> Reported-and-tested-by: Baoquan He <bhe@redhat.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> Fixes: "mm, memory_hotplug: make has_unmovable_pages more robust")

Fixes: 15c30bc09085 "mm, memory_hotplug: make has_unmovable_pages more robust")

> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
> 
> Hi,
> this has been reported [1] and we have tried multiple things to address
> the issue. The only reliable way was to reintroduce the movable zone
> check into has_unmovable_pages. This time it should be safe also for
> the bug originally fixed by 15c30bc09085.
> 
> [1] http://lkml.kernel.org/r/20181101091055.GA15166@MiWiFi-R3L-srv
>  mm/page_alloc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 863d46da6586..c6d900ee4982 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7788,6 +7788,14 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>  		if (PageReserved(page))
>  			goto unmovable;
>  
> +		/*
> +		 * If the zone is movable and we have ruled out all reserved
> +		 * pages then it should be reasonably safe to assume the rest
> +		 * is movable.
> +		 */
> +		if (zone_idx(zone) == ZONE_MOVABLE)
> +			continue;
> +
>  		/*
>  		 * Hugepages are not in LRU lists, but they're movable.
>  		 * We need not scan over tail pages bacause we don't
> -- 
> 2.19.1
> 
