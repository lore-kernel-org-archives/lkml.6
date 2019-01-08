Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9508DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD3520645
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546971236;
	bh=GkjDV+FiMGLo4s/Vr7rqB737QhdbWDFuU3AGFG8lk3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zxYGZa5OQsaxlOTa0LCFIo6xjceVbIxq9Tmb6VvJyp7jEz6Us7jM3YkfwB9plQBy4
	 SYhQwTttjvwzz+O0sJToPuFrCIxQjVKo7mKmNlx7ufzAdeATcP1ozFgR5qY5vrlz4J
	 iiqJ0Kk1+/0eOU168KQ/L43+s8SI0U0+TBMECONw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfAHSNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:13:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:39142 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727484AbfAHSNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:13:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CAF0EAD00;
        Tue,  8 Jan 2019 18:13:53 +0000 (UTC)
Date:   Tue, 8 Jan 2019 19:13:52 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     Arun KS <arunks@codeaurora.org>, arunks.linux@gmail.com,
        akpm@linux-foundation.org, vbabka@suse.cz, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        getarunks@gmail.com
Subject: Re: [PATCH v7] mm/page_alloc.c: memory_hotplug: free pages as higher
 order
Message-ID: <20190108181352.GI31793@dhcp22.suse.cz>
References: <1546578076-31716-1-git-send-email-arunks@codeaurora.org>
 <fb6465c99b3ada2c6af587a7eb00016d96d56f77.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb6465c99b3ada2c6af587a7eb00016d96d56f77.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-01-19 09:56:09, Alexander Duyck wrote:
> On Fri, 2019-01-04 at 10:31 +0530, Arun KS wrote:
[...]
> >  static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
> >  			void *arg)
> >  {
> > -	unsigned long i;
> >  	unsigned long onlined_pages = *(unsigned long *)arg;
> > -	struct page *page;
> >  
> >  	if (PageReserved(pfn_to_page(start_pfn)))
> > -		for (i = 0; i < nr_pages; i++) {
> > -			page = pfn_to_page(start_pfn + i);
> > -			(*online_page_callback)(page);
> > -			onlined_pages++;
> > -		}
> > +		onlined_pages = online_pages_blocks(start_pfn, nr_pages);
> 
> Shouldn't this be a "+=" instead of an "="? It seems like you are going
> to lose your count otherwise.

You are right of course. I should have noticed during the review.
Thanks!
-- 
Michal Hocko
SUSE Labs
