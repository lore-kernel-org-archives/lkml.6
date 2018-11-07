Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEC3C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13E320882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13E320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730536AbeKGUG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:06:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:60868 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbeKGUG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:06:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 623E4B6A0;
        Wed,  7 Nov 2018 10:36:41 +0000 (UTC)
Date:   Wed, 7 Nov 2018 11:36:30 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Arun KS <arunks@codeaurora.org>
Cc:     keescook@chromium.org, khlebnikov@yandex-team.ru,
        minchan@kernel.org, getarunks@gmail.com,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        mhocko@kernel.org, vbabka@suse.cz, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Arun KS <arunks@codeaurora.org>
Subject: Re: [PATCH v1 4/4] mm: Remove managed_page_count spinlock
Message-ID: <20181107103630.GF2453@dhcp22.suse.cz>
References: <1540551662-26458-1-git-send-email-arunks@codeaurora.org>
 <1540551662-26458-5-git-send-email-arunks@codeaurora.org>
 <20181106141732.GR27423@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106141732.GR27423@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[for some reason I have dropped the rest of the cc list. Restored]

On Tue 06-11-18 15:17:32, Michal Hocko wrote:
> On Fri 26-10-18 16:31:02, Arun KS wrote:
> > Now totalram_pages and managed_pages are atomic varibles. No need
> > of managed_page_count spinlock.
> 
> Yes this is the real improvement. The lock had really a weak consistency
> guarantee. It hasn't been used for anything but the update but no reader
> actually cares about all the values being updated to be in sync. I
> haven't really done an excavation work to see whether it used to be used
> in other contexts in the past but it simply doesn't have any meaning
> anymore.
> 
> > Signed-off-by: Arun KS <arunks@codeaurora.org>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Thanks for getting through all the hassles to reach to this end point.
> 
> > ---
> >  include/linux/mmzone.h | 6 ------
> >  mm/page_alloc.c        | 5 -----
> >  2 files changed, 11 deletions(-)
> > 
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 597b0c7..aa960f6 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -428,12 +428,6 @@ struct zone {
> >  	 * Write access to present_pages at runtime should be protected by
> >  	 * mem_hotplug_begin/end(). Any reader who can't tolerant drift of
> >  	 * present_pages should get_online_mems() to get a stable value.
> > -	 *
> > -	 * Read access to managed_pages should be safe because it's unsigned
> > -	 * long. Write access to zone->managed_pages and totalram_pages are
> > -	 * protected by managed_page_count_lock at runtime. Idealy only
> > -	 * adjust_managed_page_count() should be used instead of directly
> > -	 * touching zone->managed_pages and totalram_pages.
> >  	 */
> >  	atomic_long_t		managed_pages;
> >  	unsigned long		spanned_pages;
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index af832de..e29e78f 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -122,9 +122,6 @@
> >  };
> >  EXPORT_SYMBOL(node_states);
> >  
> > -/* Protect totalram_pages and zone->managed_pages */
> > -static DEFINE_SPINLOCK(managed_page_count_lock);
> > -
> >  atomic_long_t _totalram_pages __read_mostly;
> >  unsigned long totalreserve_pages __read_mostly;
> >  unsigned long totalcma_pages __read_mostly;
> > @@ -7062,14 +7059,12 @@ static int __init cmdline_parse_movablecore(char *p)
> >  
> >  void adjust_managed_page_count(struct page *page, long count)
> >  {
> > -	spin_lock(&managed_page_count_lock);
> >  	atomic_long_add(count, &page_zone(page)->managed_pages);
> >  	totalram_pages_add(count);
> >  #ifdef CONFIG_HIGHMEM
> >  	if (PageHighMem(page))
> >  		totalhigh_pages_add(count);
> >  #endif
> > -	spin_unlock(&managed_page_count_lock);
> >  }
> >  EXPORT_SYMBOL(adjust_managed_page_count);
> >  
> > -- 
> > 1.9.1
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs
