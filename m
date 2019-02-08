Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B41EC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0346A20863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfBHRKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:10:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:50076 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726522AbfBHRKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:10:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 047B9AF46;
        Fri,  8 Feb 2019 17:10:48 +0000 (UTC)
Subject: Re: [PATCH 09/22] mm, compaction: Use free lists to quickly locate a
 migration source
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20190118175136.31341-1-mgorman@techsingularity.net>
 <20190118175136.31341-10-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7b698aca-bd47-7d5c-a114-145b813b7bdb@suse.cz>
Date:   Fri, 8 Feb 2019 18:10:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118175136.31341-10-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 6:51 PM, Mel Gorman wrote:
> The migration scanner is a linear scan of a zone with a potentiall large
> search space.  Furthermore, many pageblocks are unusable such as those
> filled with reserved pages or partially filled with pages that cannot
> migrate. These still get scanned in the common case of allocating a THP
> and the cost accumulates.
> 
> The patch uses a partial search of the free lists to locate a migration
> source candidate that is marked as MOVABLE when allocating a THP. It
> prefers picking a block with a larger number of free pages already on
> the basis that there are fewer pages to migrate to free the entire block.
> The lowest PFN found during searches is tracked as the basis of the start
> for the linear search after the first search of the free list fails.
> After the search, the free list is shuffled so that the next search will
> not encounter the same page. If the search fails then the subsequent
> searches will be shorter and the linear scanner is used.
> 
> If this search fails, or if the request is for a small or
> unmovable/reclaimable allocation then the linear scanner is still used. It
> is somewhat pointless to use the list search in those cases. Small free
> pages must be used for the search and there is no guarantee that movable
> pages are located within that block that are contiguous.
> 
>                                      5.0.0-rc1              5.0.0-rc1
>                                  noboost-v3r10          findmig-v3r15
> Amean     fault-both-3      3771.41 (   0.00%)     3390.40 (  10.10%)
> Amean     fault-both-5      5409.05 (   0.00%)     5082.28 (   6.04%)
> Amean     fault-both-7      7040.74 (   0.00%)     7012.51 (   0.40%)
> Amean     fault-both-12    11887.35 (   0.00%)    11346.63 (   4.55%)
> Amean     fault-both-18    16718.19 (   0.00%)    15324.19 (   8.34%)
> Amean     fault-both-24    21157.19 (   0.00%)    16088.50 *  23.96%*
> Amean     fault-both-30    21175.92 (   0.00%)    18723.42 *  11.58%*
> Amean     fault-both-32    21339.03 (   0.00%)    18612.01 *  12.78%*
> 
>                                 5.0.0-rc1              5.0.0-rc1
>                             noboost-v3r10          findmig-v3r15
> Percentage huge-3        86.50 (   0.00%)       89.83 (   3.85%)
> Percentage huge-5        92.52 (   0.00%)       91.96 (  -0.61%)
> Percentage huge-7        92.44 (   0.00%)       92.85 (   0.44%)
> Percentage huge-12       92.98 (   0.00%)       92.74 (  -0.25%)
> Percentage huge-18       91.70 (   0.00%)       91.71 (   0.02%)
> Percentage huge-24       91.59 (   0.00%)       92.13 (   0.60%)
> Percentage huge-30       90.14 (   0.00%)       93.79 (   4.04%)
> Percentage huge-32       90.03 (   0.00%)       91.27 (   1.37%)
> 
> This shows an improvement in allocation latencies with similar allocation
> success rates.  While not presented, there was a 31% reduction in migration
> scanning and a 8% reduction on system CPU usage. A 2-socket machine showed
> similar benefits.
> 
> [vbabka@suse.cz: Migrate block that was found-fast, some optimisations]
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

With the followup fix,

Acked-by: Vlastimil Babka <Vbabka@suse.cz>
