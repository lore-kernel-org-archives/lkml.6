Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC3CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C973206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfANQla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:41:30 -0500
Received: from mga11.intel.com ([192.55.52.93]:14285 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfANQl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:41:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 08:41:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,478,1539673200"; 
   d="scan'208";a="109783390"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga008.jf.intel.com with ESMTP; 14 Jan 2019 08:41:29 -0800
Message-ID: <d242b75461b38f4910ed619fabc0f9b52dce7f8b.camel@linux.intel.com>
Subject: Re: [PATCH v9] mm/page_alloc.c: memory_hotplug: free pages as
 higher order
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>, Arun KS <arunks@codeaurora.org>
Cc:     arunks.linux@gmail.com, akpm@linux-foundation.org, vbabka@suse.cz,
        osalvador@suse.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, getarunks@gmail.com
Date:   Mon, 14 Jan 2019 08:41:29 -0800
In-Reply-To: <20190114143251.GI21345@dhcp22.suse.cz>
References: <1547098543-26452-1-git-send-email-arunks@codeaurora.org>
         <f65b1b22426855ff261b3af719e58eded576a168.camel@linux.intel.com>
         <fa3dc06536a8ba980c4434806204017a@codeaurora.org>
         <20190114143251.GI21345@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-14 at 15:32 +0100, Michal Hocko wrote:
> On Mon 14-01-19 19:29:39, Arun KS wrote:
> > On 2019-01-10 21:53, Alexander Duyck wrote:
> 
> [...]
> > > Couldn't you just do something like the following:
> > > 		if ((end - start) >= (1UL << (MAX_ORDER - 1))
> > > 			order = MAX_ORDER - 1;
> > > 		else
> > > 			order = __fls(end - start);
> > > 
> > > I would think this would save you a few steps in terms of conversions
> > > and such since you are already working in page frame numbers anyway so
> > > a block of 8 pfns would represent an order 3 page wouldn't it?
> > > 
> > > Also it seems like an alternative to using "end" would be to just track
> > > nr_pages. Then you wouldn't have to do the "end - start" math in a few
> > > spots as long as you remembered to decrement nr_pages by the amount you
> > > increment start by.
> > 
> > Thanks for that. How about this?
> > 
> > static int online_pages_blocks(unsigned long start, unsigned long nr_pages)
> > {
> >         unsigned long end = start + nr_pages;
> >         int order;
> > 
> >         while (nr_pages) {
> >                 if (nr_pages >= (1UL << (MAX_ORDER - 1)))
> >                         order = MAX_ORDER - 1;
> >                 else
> >                         order = __fls(nr_pages);
> > 
> >                 (*online_page_callback)(pfn_to_page(start), order);
> >                 nr_pages -= (1UL << order);
> >                 start += (1UL << order);
> >         }
> >         return end - start;
> > }
> 
> I find this much less readable so if this is really a big win
> performance wise then make it a separate patch with some nubbers please.

I suppose we could look at simplifying this further. Maybe something
like:
	unsigned long end = start + nr_pages;
	int order = MAX_ORDER - 1;

	while (start < end) {
		if ((end - start) < (1UL << (MAX_ORDER - 1))
			order = __fls(end - start));
		(*online_page_callback)(pfn_to_page(start), order);
		start += 1UL << order;
	}

	return nr_pages;

I would argue it probably doesn't get much more readable than this. The
basic idea is we are chopping off MAX_ORDER - 1 sized chunks and
setting them online until we have to start working our way down in
powers of 2.

In terms of performance the loop itself isn't going to have that much
impact. The bigger issue as I saw it was that we were going through and
converting PFNs to a physical addresses just for the sake of contorting
things to make them work with get_order when we already have the PFN
numbers so all we really need to know is the most significant bit for
the total page count.

