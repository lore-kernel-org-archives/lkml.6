Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC00C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E7B20819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E7B20819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbeKEWVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:21:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:42528 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728136AbeKEWVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:21:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8CC77AFE2;
        Mon,  5 Nov 2018 13:02:10 +0000 (UTC)
Date:   Mon, 5 Nov 2018 14:02:09 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Kuo-Hsin Yang <vovoy@chromium.org>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4] mm, drm/i915: mark pinned shmemfs pages as unevictable
Message-ID: <20181105130209.GI4361@dhcp22.suse.cz>
References: <20181105111348.182492-1-vovoy@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105111348.182492-1-vovoy@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-11-18 19:13:48, Kuo-Hsin Yang wrote:
> The i915 driver uses shmemfs to allocate backing storage for gem
> objects. These shmemfs pages can be pinned (increased ref count) by
> shmem_read_mapping_page_gfp(). When a lot of pages are pinned, vmscan
> wastes a lot of time scanning these pinned pages. In some extreme case,
> all pages in the inactive anon lru are pinned, and only the inactive
> anon lru is scanned due to inactive_ratio, the system cannot swap and
> invokes the oom-killer. Mark these pinned pages as unevictable to speed
> up vmscan.
> 
> Export pagevec API check_move_unevictable_pages().

Thanks for reworking the patch. This looks much more to my taste. At
least the mm part. I haven't really looked at the the drm part.

Just a nit below

> This patch was inspired by Chris Wilson's change [1].
> 
> [1]: https://patchwork.kernel.org/patch/9768741/

I would recommend using msg-id based url.

> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Signed-off-by: Kuo-Hsin Yang <vovoy@chromium.org>

other than that
Acked-by: Michal Hocko <mhocko@suse.com>

[...]

> @@ -4184,15 +4185,13 @@ int page_evictable(struct page *page)
>  
>  #ifdef CONFIG_SHMEM
>  /**
> - * check_move_unevictable_pages - check pages for evictability and move to appropriate zone lru list
> - * @pages:	array of pages to check
> - * @nr_pages:	number of pages to check
> + * check_move_unevictable_pages - move evictable pages to appropriate evictable
> + * lru lists

I am not sure this is an improvement. I would just keep the original
wording. It is not great either but the explicit note about check for
evictability sounds like a better fit to me.

> + * @pvec: pagevec with pages to check
>   *
> - * Checks pages for evictability and moves them to the appropriate lru list.
> - *
> - * This function is only used for SysV IPC SHM_UNLOCK.
> + * This function is only used to move shmem pages.

I do not really see anything that would be shmem specific here. We can
use this function for any LRU pages unless I am missing something
obscure. I would just drop the last sentence.

A note that this function should be only used for LRU pages would be
nice.

>   */
> -void check_move_unevictable_pages(struct page **pages, int nr_pages)
> +void check_move_unevictable_pages(struct pagevec *pvec)
>  {
>  	struct lruvec *lruvec;
>  	struct pglist_data *pgdat = NULL;
> @@ -4200,8 +4199,8 @@ void check_move_unevictable_pages(struct page **pages, int nr_pages)
>  	int pgrescued = 0;
>  	int i;
>  
> -	for (i = 0; i < nr_pages; i++) {
> -		struct page *page = pages[i];
> +	for (i = 0; i < pvec->nr; i++) {
> +		struct page *page = pvec->pages[i];
>  		struct pglist_data *pagepgdat = page_pgdat(page);
>  
>  		pgscanned++;
> @@ -4233,4 +4232,5 @@ void check_move_unevictable_pages(struct page **pages, int nr_pages)
>  		spin_unlock_irq(&pgdat->lru_lock);
>  	}
>  }
> +EXPORT_SYMBOL(check_move_unevictable_pages);
>  #endif /* CONFIG_SHMEM */
> -- 
> 2.19.1.930.g4563a0d9d0-goog
> 

-- 
Michal Hocko
SUSE Labs
