Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D2CC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD9025C20
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD9025C20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965450AbeGBKPs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:15:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:36926 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965246AbeGBKPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:15:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 85537ACCE;
        Mon,  2 Jul 2018 10:15:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 35CF41E3C07; Mon,  2 Jul 2018 12:15:42 +0200 (CEST)
Date:   Mon, 2 Jul 2018 12:15:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     john.hubbard@gmail.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2 6/6] mm: page_mkclean, ttu: handle pinned pages
Message-ID: <20180702101542.fi7ndfkg5fpzodey@quack2.suse.cz>
References: <20180702005654.20369-1-jhubbard@nvidia.com>
 <20180702005654.20369-7-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702005654.20369-7-jhubbard@nvidia.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 01-07-18 17:56:54, john.hubbard@gmail.com wrote:
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 9d142b9b86dc..c4bc8d216746 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -931,6 +931,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
>  	int kill = 1, forcekill;
>  	struct page *hpage = *hpagep;
>  	bool mlocked = PageMlocked(hpage);
> +	bool skip_pinned_pages = false;

I'm not sure we can afford to wait for page pins when handling page
poisoning. In an ideal world we should but... But I guess this is for
someone understanding memory poisoning better to judge.

> diff --git a/mm/rmap.c b/mm/rmap.c
> index 6db729dc4c50..c137c43eb2ad 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -879,6 +879,26 @@ int page_referenced(struct page *page,
>  	return pra.referenced;
>  }
>  
> +/* Must be called with pinned_dma_lock held. */
> +static void wait_for_dma_pinned_to_clear(struct page *page)
> +{
> +	struct zone *zone = page_zone(page);
> +
> +	while (PageDmaPinnedFlags(page)) {
> +		spin_unlock(zone_gup_lock(zone));
> +
> +		schedule();
> +
> +		spin_lock(zone_gup_lock(zone));
> +	}
> +}

Ouch, we definitely need something better here. Either reuse the
page_waitqueue() mechanism or create at least a global wait queue for this
(I don't expect too much contention on the waitqueue and even if there
eventually is, we can switch to page_waitqueue() when we find it).  But
this is a no-go...

> +
> +struct page_mkclean_info {
> +	int cleaned;
> +	int skipped;
> +	bool skip_pinned_pages;
> +};
> +
>  static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
>  			    unsigned long address, void *arg)
>  {
> @@ -889,7 +909,24 @@ static bool page_mkclean_one(struct page *page, struct vm_area_struct *vma,
>  		.flags = PVMW_SYNC,
>  	};
>  	unsigned long start = address, end;
> -	int *cleaned = arg;
> +	struct page_mkclean_info *mki = (struct page_mkclean_info *)arg;
> +	bool is_dma_pinned;
> +	struct zone *zone = page_zone(page);
> +
> +	/* Serialize with get_user_pages: */
> +	spin_lock(zone_gup_lock(zone));
> +	is_dma_pinned = PageDmaPinned(page);

Hum, why do you do this for each page table this is mapped in? Also the
locking is IMHO going to hurt a lot and we need to avoid it.

What I think needs to happen is that in page_mkclean(), after you've
cleared all the page tables, you check PageDmaPinned() and wait if needed.
Page cannot be faulted in again as we hold page lock and so races with
concurrent GUP are fairly limited. So with some careful ordering & memory
barriers you should be able to get away without any locking. Ditto for the
unmap path...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
