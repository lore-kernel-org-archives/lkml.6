Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1079C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97070218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387631AbfAaOM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:12:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:33584 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726977AbfAaOM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:12:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86EE6B02F;
        Thu, 31 Jan 2019 14:12:25 +0000 (UTC)
Subject: Re: [PATCH 09/22] mm, compaction: Use free lists to quickly locate a
 migration source
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20190118175136.31341-1-mgorman@techsingularity.net>
 <20190118175136.31341-10-mgorman@techsingularity.net>
 <4a6ae9fc-a52b-4300-0edb-a0f4169c314a@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <3fbf3abc-0196-9e96-3760-266395362f00@suse.cz>
Date:   Thu, 31 Jan 2019 15:12:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4a6ae9fc-a52b-4300-0edb-a0f4169c314a@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/19 2:55 PM, Vlastimil Babka wrote:
> On 1/18/19 6:51 PM, Mel Gorman wrote:
> ...
> 
>> +	for (order = cc->order - 1;
>> +	     order >= PAGE_ALLOC_COSTLY_ORDER && pfn == cc->migrate_pfn && nr_scanned < limit;
>> +	     order--) {
>> +		struct free_area *area = &cc->zone->free_area[order];
>> +		struct list_head *freelist;
>> +		unsigned long flags;
>> +		struct page *freepage;
>> +
>> +		if (!area->nr_free)
>> +			continue;
>> +
>> +		spin_lock_irqsave(&cc->zone->lock, flags);
>> +		freelist = &area->free_list[MIGRATE_MOVABLE];
>> +		list_for_each_entry(freepage, freelist, lru) {
>> +			unsigned long free_pfn;
>> +
>> +			nr_scanned++;
>> +			free_pfn = page_to_pfn(freepage);
>> +			if (free_pfn < high_pfn) {
>> +				update_fast_start_pfn(cc, free_pfn);
> 
> Shouldn't this update go below checking pageblock skip bit? We might be
> caching pageblocks that will be skipped, and also potentially going

Ah that move happens in the next patch.
