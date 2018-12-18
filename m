Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D5DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4565C217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbeLRJGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:06:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:49004 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbeLRJGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:06:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD62FAC17;
        Tue, 18 Dec 2018 09:06:32 +0000 (UTC)
Subject: Re: [PATCH 06/14] mm, migrate: Immediately fail migration of a page
 with no migration handler
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20181214230310.572-1-mgorman@techsingularity.net>
 <20181214230310.572-7-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <0ef5c1d0-1853-8fdb-1a68-7482297cb802@suse.cz>
Date:   Tue, 18 Dec 2018 10:06:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181214230310.572-7-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/18 12:03 AM, Mel Gorman wrote:
> Pages with no migration handler use a fallback hander which sometimes
> works and sometimes persistently fails such as blockdev pages. Migration
> will retry a number of times on these persistent pages which is wasteful
> during compaction. This patch will fail migration immediately unless the
> caller is in MIGRATE_SYNC mode which indicates the caller is willing to
> wait while being persistent.

Right.

> This is not expected to help THP allocation success rates but it does
> reduce latencies slightly.
> 
> 1-socket thpfioscale
>                                     4.20.0-rc6             4.20.0-rc6
>                                noreserved-v1r4          failfast-v1r4
> Amean     fault-both-1         0.00 (   0.00%)        0.00 *   0.00%*
> Amean     fault-both-3      2276.15 (   0.00%)     3867.54 * -69.92%*

This is rather weird.

> Amean     fault-both-5      4992.20 (   0.00%)     5313.20 (  -6.43%)
> Amean     fault-both-7      7373.30 (   0.00%)     7039.11 (   4.53%)
> Amean     fault-both-12    11911.52 (   0.00%)    11328.29 (   4.90%)
> Amean     fault-both-18    17209.42 (   0.00%)    16455.34 (   4.38%)
> Amean     fault-both-24    20943.71 (   0.00%)    20448.94 (   2.36%)
> Amean     fault-both-30    22703.00 (   0.00%)    21655.07 (   4.62%)
> Amean     fault-both-32    22461.41 (   0.00%)    21415.35 (   4.66%)
> 
> The 2-socket results are not materially different. Scan rates are
> similar as expected.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index df17a710e2c7..0e27a10429e2 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -885,7 +885,7 @@ static int fallback_migrate_page(struct address_space *mapping,
>  	 */
>  	if (page_has_private(page) &&
>  	    !try_to_release_page(page, GFP_KERNEL))
> -		return -EAGAIN;
> +		return mode == MIGRATE_SYNC ? -EAGAIN : -EBUSY;
>  
>  	return migrate_page(mapping, newpage, page, mode);
>  }
> 

