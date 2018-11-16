Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98ABC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCA32086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCA32086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389420AbeKPUft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:35:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:46422 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727446AbeKPUft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:35:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 39DBDAF3A;
        Fri, 16 Nov 2018 10:24:06 +0000 (UTC)
Date:   Fri, 16 Nov 2018 11:24:05 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] mm: use managed_zone() for more exact check in zone
 iteration
Message-ID: <20181116102405.GF14706@dhcp22.suse.cz>
References: <20181114235040.36180-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114235040.36180-1-richard.weiyang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15-11-18 07:50:40, Wei Yang wrote:
[...]
> @@ -1193,8 +1196,8 @@ static unsigned int count_free_highmem_pages(void)
>  	struct zone *zone;
>  	unsigned int cnt = 0;
>  
> -	for_each_populated_zone(zone)
> -		if (is_highmem(zone))
> +	for_each_zone(zone)
> +		if (populated_zone(zone) && is_highmem(zone))
>  			cnt += zone_page_state(zone, NR_FREE_PAGES);

this should be for_each_managed_zone because we only care about highmem
zones which have pages in the allocator (NR_FREE_PAGES).

>  
>  	return cnt;
> @@ -1239,10 +1242,10 @@ static unsigned int count_highmem_pages(void)
>  	struct zone *zone;
>  	unsigned int n = 0;
>  
> -	for_each_populated_zone(zone) {
> +	for_each_zone(zone) {
>  		unsigned long pfn, max_zone_pfn;
>  
> -		if (!is_highmem(zone))
> +		if (!populated_zone(zone) || !is_highmem(zone))
>  			continue;
>  
>  		mark_free_pages(zone);

I am not familiar with this code much but I strongly suspect that we do
want for_each_managed_zone here because saveable_highmem_page skips over
all reserved pages which rules out the bootmem. But this should be
double checked with Rafael (Cc-ed).

Rafael, does this loop care about pages which are not managed by the
page allocator?

> @@ -1305,8 +1308,8 @@ static unsigned int count_data_pages(void)
>  	unsigned long pfn, max_zone_pfn;
>  	unsigned int n = 0;
>  
> -	for_each_populated_zone(zone) {
> -		if (is_highmem(zone))
> +	for_each_zone(zone) {
> +		if (!populated_zone(zone) || is_highmem(zone))
>  			continue;
>  
>  		mark_free_pages(zone);
> @@ -1399,9 +1402,12 @@ static void copy_data_pages(struct memory_bitmap *copy_bm,
>  	struct zone *zone;
>  	unsigned long pfn;
>  
> -	for_each_populated_zone(zone) {
> +	for_each_zone(zone) {
>  		unsigned long max_zone_pfn;
>  
> +		if (!populated_zone(zone))
> +			continue;
> +
>  		mark_free_pages(zone);
>  		max_zone_pfn = zone_end_pfn(zone);
>  		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++)
> @@ -1717,7 +1723,10 @@ int hibernate_preallocate_memory(void)
>  	saveable += save_highmem;
>  	highmem = save_highmem;
>  	size = 0;
> -	for_each_populated_zone(zone) {
> +	for_each_zone(zone) {
> +		if (!populated_zone(zone))
> +			continue;
> +
>  		size += snapshot_additional_pages(zone);
>  		if (is_highmem(zone))
>  			highmem += zone_page_state(zone, NR_FREE_PAGES);

ditto for the above.


> @@ -1863,8 +1872,8 @@ static int enough_free_mem(unsigned int nr_pages, unsigned int nr_highmem)
>  	struct zone *zone;
>  	unsigned int free = alloc_normal;
>  
> -	for_each_populated_zone(zone)
> -		if (!is_highmem(zone))
> +	for_each_zone(zone)
> +		if (populated_zone(zone) && !is_highmem(zone))
>  			free += zone_page_state(zone, NR_FREE_PAGES);
>  
>  	nr_pages += count_pages_for_highmem(nr_highmem);

This one should be for_each_managed_zone (NR_FREE_PAGES)

The rest looks good to me.
-- 
Michal Hocko
SUSE Labs
