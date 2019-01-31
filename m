Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F30C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C994218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 14:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbfAaOwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 09:52:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:39552 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725796AbfAaOwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 09:52:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3A6BEAD14;
        Thu, 31 Jan 2019 14:52:11 +0000 (UTC)
Subject: Re: [PATCH 11/22] mm, compaction: Use free lists to quickly locate a
 migration target
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20190118175136.31341-1-mgorman@techsingularity.net>
 <20190118175136.31341-12-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <81e45dc0-c107-015b-e167-19d7ca4b6374@suse.cz>
Date:   Thu, 31 Jan 2019 15:52:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118175136.31341-12-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 6:51 PM, Mel Gorman wrote:
> Similar to the migration scanner, this patch uses the free lists to quickly
> locate a migration target. The search is different in that lower orders
> will be searched for a suitable high PFN if necessary but the search
> is still bound. This is justified on the grounds that the free scanner
> typically scans linearly much more than the migration scanner.
> 
> If a free page is found, it is isolated and compaction continues if enough
> pages were isolated. For SYNC* scanning, the full pageblock is scanned
> for any remaining free pages so that is can be marked for skipping in
> the near future.
> 
> 1-socket thpfioscale
>                                      5.0.0-rc1              5.0.0-rc1
>                                  isolmig-v3r15         findfree-v3r16
> Amean     fault-both-3      3024.41 (   0.00%)     3200.68 (  -5.83%)
> Amean     fault-both-5      4749.30 (   0.00%)     4847.75 (  -2.07%)
> Amean     fault-both-7      6454.95 (   0.00%)     6658.92 (  -3.16%)
> Amean     fault-both-12    10324.83 (   0.00%)    11077.62 (  -7.29%)
> Amean     fault-both-18    12896.82 (   0.00%)    12403.97 (   3.82%)
> Amean     fault-both-24    13470.60 (   0.00%)    15607.10 * -15.86%*
> Amean     fault-both-30    17143.99 (   0.00%)    18752.27 (  -9.38%)
> Amean     fault-both-32    17743.91 (   0.00%)    21207.54 * -19.52%*
> 
> The impact on latency is variable but the search is optimistic and
> sensitive to the exact system state. Success rates are similar but
> the major impact is to the rate of scanning
> 
>                                 5.0.0-rc1      5.0.0-rc1
>                             isolmig-v3r15 findfree-v3r16
> Compaction migrate scanned    25646769          29507205
> Compaction free scanned      201558184         100359571
> 
> The free scan rates are reduced by 50%. The 2-socket reductions for the
> free scanner are more dramatic which is a likely reflection that the
> machine has more memory.
> 
> [dan.carpenter@oracle.com: Fix static checker warning]
> [vbabka@suse.cz: Correct number of pages scanned for lower orders]
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Small fix below:

> -/* Reorder the free list to reduce repeated future searches */
> +/*
> + * Used when scanning for a suitable migration target which scans freelists
> + * in reverse. Reorders the list such as the unscanned pages are scanned
> + * first on the next iteration of the free scanner
> + */
> +static void
> +move_freelist_head(struct list_head *freelist, struct page *freepage)
> +{
> +	LIST_HEAD(sublist);
> +
> +	if (!list_is_last(freelist, &freepage->lru)) {

Shouldn't there be list_is_first() for symmetry?

> +		list_cut_before(&sublist, freelist, &freepage->lru);
> +		if (!list_empty(&sublist))
> +			list_splice_tail(&sublist, freelist);
> +	}
> +}
> +
> +/*
> + * Similar to move_freelist_head except used by the migration scanner
> + * when scanning forward. It's possible for these list operations to
> + * move against each other if they search the free list exactly in
> + * lockstep.
> + */
>  static void
>  move_freelist_tail(struct list_head *freelist, struct page *freepage)
>  {
