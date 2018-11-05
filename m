Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF7FECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7731C2082A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7731C2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeKETEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:04:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbeKETEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:04:05 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 003CC308212C;
        Mon,  5 Nov 2018 09:45:14 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 782FF17F32;
        Mon,  5 Nov 2018 09:45:11 +0000 (UTC)
Date:   Mon, 5 Nov 2018 17:45:08 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH] mm, memory_hotplug: teach has_unmovable_pages about of
 LRU migrateable pages
Message-ID: <20181105094508.GA22011@MiWiFi-R3L-srv>
References: <20181101091055.GA15166@MiWiFi-R3L-srv>
 <20181102155528.20358-1-mhocko@kernel.org>
 <20181105002009.GF27491@MiWiFi-R3L-srv>
 <20181105091407.GB4361@dhcp22.suse.cz>
 <20181105092851.GD4361@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105092851.GD4361@dhcp22.suse.cz>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 05 Nov 2018 09:45:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/18 at 10:28am, Michal Hocko wrote:
> On Mon 05-11-18 10:14:07, Michal Hocko wrote:
> > Maybe we can add a retry for movable zone pages.
> 
> Or something like this. Ugly as hell, no question about that. I also
> have to think about this some more to convince myself this will not
> result in an endless loop under some situations.

Testing, will tell the result.

> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 48ceda313332..342d66eca0f3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7779,12 +7779,16 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>  	pfn = page_to_pfn(page);
>  	for (found = 0, iter = 0; iter < pageblock_nr_pages; iter++) {
>  		unsigned long check = pfn + iter;
> +		unsigned long saved_flags;
>  
>  		if (!pfn_valid_within(check))
>  			continue;
>  
>  		page = pfn_to_page(check);
>  
> +retry:
> +		saved_flags = READ_ONCE(page->flags);
> +
>  		if (PageReserved(page))
>  			goto unmovable;
>  
> @@ -7840,6 +7844,13 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>  				page->mapping->a_ops->migratepage)
>  			continue;
>  
> +		/*
> +		 * We might race with the allocation of the page so retry
> +		 * if flags have changed.
> +		 */
> +		if (saved_flags != READ_ONCE(page->flags))
> +			goto retry;
> +
>  		/*
>  		 * If there are RECLAIMABLE pages, we need to check
>  		 * it.  But now, memory offline itself doesn't call
> -- 
> Michal Hocko
> SUSE Labs
