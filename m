Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE13C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE2B20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE2B20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbeKHSI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:08:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:38250 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbeKHSI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:08:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8E7DAE4F;
        Thu,  8 Nov 2018 08:34:01 +0000 (UTC)
Date:   Thu, 8 Nov 2018 09:34:00 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Arun KS <arunks@codeaurora.org>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        khlebnikov@yandex-team.ru, minchan@kernel.org, vbabka@suse.cz,
        osalvador@suse.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, getarunks@gmail.com
Subject: Re: [PATCH v3 4/4] mm: Remove managed_page_count spinlock
Message-ID: <20181108083400.GQ27423@dhcp22.suse.cz>
References: <1541665398-29925-1-git-send-email-arunks@codeaurora.org>
 <1541665398-29925-5-git-send-email-arunks@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541665398-29925-5-git-send-email-arunks@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08-11-18 13:53:18, Arun KS wrote:
> Now totalram_pages and managed_pages are atomic varibles. No need
> of managed_page_count spinlock.

As explained earlier. Please add a motivation here. Feel free to reuse
wording from http://lkml.kernel.org/r/20181107103630.GF2453@dhcp22.suse.cz

> 
> Signed-off-by: Arun KS <arunks@codeaurora.org>
> Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/mmzone.h | 6 ------
>  mm/page_alloc.c        | 5 -----
>  2 files changed, 11 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index e73dc31..c71b4d9 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -428,12 +428,6 @@ struct zone {
>  	 * Write access to present_pages at runtime should be protected by
>  	 * mem_hotplug_begin/end(). Any reader who can't tolerant drift of
>  	 * present_pages should get_online_mems() to get a stable value.
> -	 *
> -	 * Read access to managed_pages should be safe because it's unsigned
> -	 * long. Write access to zone->managed_pages and totalram_pages are
> -	 * protected by managed_page_count_lock at runtime. Idealy only
> -	 * adjust_managed_page_count() should be used instead of directly
> -	 * touching zone->managed_pages and totalram_pages.
>  	 */
>  	atomic_long_t		managed_pages;
>  	unsigned long		spanned_pages;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f8b64cc..26c5e14 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -122,9 +122,6 @@
>  };
>  EXPORT_SYMBOL(node_states);
>  
> -/* Protect totalram_pages and zone->managed_pages */
> -static DEFINE_SPINLOCK(managed_page_count_lock);
> -
>  atomic_long_t _totalram_pages __read_mostly;
>  EXPORT_SYMBOL(_totalram_pages);
>  unsigned long totalreserve_pages __read_mostly;
> @@ -7065,14 +7062,12 @@ static int __init cmdline_parse_movablecore(char *p)
>  
>  void adjust_managed_page_count(struct page *page, long count)
>  {
> -	spin_lock(&managed_page_count_lock);
>  	atomic_long_add(count, &page_zone(page)->managed_pages);
>  	totalram_pages_add(count);
>  #ifdef CONFIG_HIGHMEM
>  	if (PageHighMem(page))
>  		totalhigh_pages_add(count);
>  #endif
> -	spin_unlock(&managed_page_count_lock);
>  }
>  EXPORT_SYMBOL(adjust_managed_page_count);
>  
> -- 
> 1.9.1

-- 
Michal Hocko
SUSE Labs
