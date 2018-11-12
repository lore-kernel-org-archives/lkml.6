Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070E8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C621222419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C621222419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbeKLVYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:24:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:56630 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728153AbeKLVYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:24:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D70AB074;
        Mon, 12 Nov 2018 11:31:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 53C2B1E09A5; Mon, 12 Nov 2018 12:31:53 +0100 (CET)
Date:   Mon, 12 Nov 2018 12:31:53 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vvs@virtuozzo.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: cleancache: fix corruption on missed inode
 invalidation
Message-ID: <20181112113153.GC7175@quack2.suse.cz>
References: <20181112095734.17979-1-ptikhomirov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112095734.17979-1-ptikhomirov@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12-11-18 12:57:34, Pavel Tikhomirov wrote:
> If all pages are deleted from the mapping by memory reclaim and also
> moved to the cleancache:
> 
> __delete_from_page_cache
>   (no shadow case)
>   unaccount_page_cache_page
>     cleancache_put_page
>   page_cache_delete
>     mapping->nrpages -= nr
>     (nrpages becomes 0)
> 
> We don't clean the cleancache for an inode after final file truncation
> (removal).
> 
> truncate_inode_pages_final
>   check (nrpages || nrexceptional) is false
>     no truncate_inode_pages
>       no cleancache_invalidate_inode(mapping)
> 
> These way when reading the new file created with same inode we may get
> these trash leftover pages from cleancache and see wrong data instead of
> the contents of the new file.
> 
> Fix it by always doing truncate_inode_pages which is already ready for
> nrpages == 0 && nrexceptional == 0 case and just invalidates inode.
> 
> Fixes: commit 91b0abe36a7b ("mm + fs: store shadow entries in page cache")
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Vasily Averin <vvs@virtuozzo.com>
> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> ---
>  mm/truncate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

The patch looks good but can you add a short comment before the
truncate_inode_pages() call explaining why it needs to be called always?
Something like:

	 /*
	  * Cleancache needs notification even if there are no pages or
	  * shadow entries...
	  */

Otherwise you can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 45d68e90b703..4c56c19e76eb 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -517,9 +517,9 @@ void truncate_inode_pages_final(struct address_space *mapping)
>  		 */
>  		xa_lock_irq(&mapping->i_pages);
>  		xa_unlock_irq(&mapping->i_pages);
> -
> -		truncate_inode_pages(mapping, 0);
>  	}
> +
> +	truncate_inode_pages(mapping, 0);
>  }
>  EXPORT_SYMBOL(truncate_inode_pages_final);
>  
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
