Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B62AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A00C217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lvNDpOUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfBRTFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:05:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53894 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbfBRTFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g5AvimQGenRhlXMXqYl0ru8SXdeHWIlWf5DBX0KvNhk=; b=lvNDpOUKSxwz3Oa9crOFBip3E
        h8WGDPoH8yvzlMcw1fKMJAuVSHRvXhKXAIsA8kUTTkbF6z3w2PtEjvOUBI2S2qXCuL/+BUdQCJkjw
        1QzZ60+E6fS2YDyyM2WWcwZyPt6D0zFSrzvXrtWrClBGqP1Y9Js/LvwO6vaGbtO1/eLnZR3KpGSnQ
        oZK5QEWJsd469BXVXZrYQeL5/s3bUpLk14ODkvZ06c56Z2kabdwOj+71ZSvlBDybIwYu1UAyxha2r
        T7FPtT/4OqSoJMyOlAnHZ4etjQq6Mef26hcsOUErr4zQGcTuQkHXLpTGnZodr12HsVznHYjP7fg6Y
        5UhUNu8rg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gvoEC-0003Lu-2r; Mon, 18 Feb 2019 19:05:20 +0000
Date:   Mon, 18 Feb 2019 11:05:19 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Rong Chen <rong.a.chen@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>, LKP <lkp@01.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [LKP] efad4e475c [ 40.308255] Oops: 0000 [#1] PREEMPT SMP PTI
Message-ID: <20190218190519.GV12668@bombadil.infradead.org>
References: <20190218085510.GC7251@dhcp22.suse.cz>
 <4c75d424-2c51-0d7d-5c28-78c15600e93c@intel.com>
 <20190218103013.GK4525@dhcp22.suse.cz>
 <20190218140515.GF25446@rapoport-lnx>
 <20190218152050.GS4525@dhcp22.suse.cz>
 <20190218152213.GT4525@dhcp22.suse.cz>
 <20190218164813.GG25446@rapoport-lnx>
 <20190218170558.GV4525@dhcp22.suse.cz>
 <20190218175726.GU12668@bombadil.infradead.org>
 <20190218181155.GC4525@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218181155.GC4525@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 07:11:55PM +0100, Michal Hocko wrote:
> On Mon 18-02-19 09:57:26, Matthew Wilcox wrote:
> > On Mon, Feb 18, 2019 at 06:05:58PM +0100, Michal Hocko wrote:
> > > +	end_pfn = min(start_pfn + nr_pages,
> > > +			zone_end_pfn(page_zone(pfn_to_page(start_pfn))));
> > >  
> > >  	/* Check the starting page of each pageblock within the range */
> > > -	for (; page < end_page; page = next_active_pageblock(page)) {
> > > -		if (!is_pageblock_removable_nolock(page))
> > > +	for (; start_pfn < end_pfn; start_pfn = next_active_pageblock(start_pfn)) {
> > > +		if (!is_pageblock_removable_nolock(start_pfn))
> > 
> > If you have a zone which contains pfns that run from ULONG_MAX-n to ULONG_MAX,
> > end_pfn is going to wrap around to 0 and this loop won't execute.
> 
> Is this a realistic situation to bother?

How insane do you think hardware manufacturers are ... ?  I don't know
of one today, but I wouldn't bet on something like that never existing.

> > I think
> > you should use:
> > 
> > 	max_pfn = min(start_pfn + nr_pages,
> > 			zone_end_pfn(page_zone(pfn_to_page(start_pfn)))) - 1;
> > 
> > 	for (; start_pfn <= max_pfn; ...)
> 
> I do not really care strongly, but we have more places were we do
> start_pfn + nr_pages and then use it as pfn < end_pfn construct. I
> suspect we would need to make a larger audit and make the code
> consistent so unless there are major concerns I would stick with what
> I have for now and leave the rest for the cleanup. Does that sound
> reasonable?

Yes, I think so.  There are a number of other places where we can wrap
around from ULONG_MAX to 0 fairly easily (eg page offsets in a file on
32-bit machines).  I started thinking about this with the XArray and
rapidly convinced myself we have a problem throughout Linux.
