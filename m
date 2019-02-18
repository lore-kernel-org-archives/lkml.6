Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BEFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F80A217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550513520;
	bh=aIDLe6snRWr8wWaVZkz/A5HyMyS0EJorB2VBSt292KI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1WfONgbKBZK6/NJDPYSp5sj8s33qUKL3oS682qHkmf8ibz2ppgpKZPbxZ/PqhAVhF
	 CVcbt/y1meaXQq/MtEz51eH4a2gxFvmsgmmqNCl6n4vYPAfpkE9vq8qr3f7lhvxwOQ
	 S+7gc7YeJbNVA9UcYpoQruqgSP4vRKMnfD6apHOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390137AbfBRSL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:11:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:41956 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387881AbfBRSL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:11:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E0754AC4C;
        Mon, 18 Feb 2019 18:11:56 +0000 (UTC)
Date:   Mon, 18 Feb 2019 19:11:55 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Rong Chen <rong.a.chen@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>, LKP <lkp@01.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [LKP] efad4e475c [ 40.308255] Oops: 0000 [#1] PREEMPT SMP PTI
Message-ID: <20190218181155.GC4525@dhcp22.suse.cz>
References: <20190218070844.GC4525@dhcp22.suse.cz>
 <20190218085510.GC7251@dhcp22.suse.cz>
 <4c75d424-2c51-0d7d-5c28-78c15600e93c@intel.com>
 <20190218103013.GK4525@dhcp22.suse.cz>
 <20190218140515.GF25446@rapoport-lnx>
 <20190218152050.GS4525@dhcp22.suse.cz>
 <20190218152213.GT4525@dhcp22.suse.cz>
 <20190218164813.GG25446@rapoport-lnx>
 <20190218170558.GV4525@dhcp22.suse.cz>
 <20190218175726.GU12668@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218175726.GU12668@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18-02-19 09:57:26, Matthew Wilcox wrote:
> On Mon, Feb 18, 2019 at 06:05:58PM +0100, Michal Hocko wrote:
> > +	end_pfn = min(start_pfn + nr_pages,
> > +			zone_end_pfn(page_zone(pfn_to_page(start_pfn))));
> >  
> >  	/* Check the starting page of each pageblock within the range */
> > -	for (; page < end_page; page = next_active_pageblock(page)) {
> > -		if (!is_pageblock_removable_nolock(page))
> > +	for (; start_pfn < end_pfn; start_pfn = next_active_pageblock(start_pfn)) {
> > +		if (!is_pageblock_removable_nolock(start_pfn))
> 
> If you have a zone which contains pfns that run from ULONG_MAX-n to ULONG_MAX,
> end_pfn is going to wrap around to 0 and this loop won't execute.

Is this a realistic situation to bother?

> I think
> you should use:
> 
> 	max_pfn = min(start_pfn + nr_pages,
> 			zone_end_pfn(page_zone(pfn_to_page(start_pfn)))) - 1;
> 
> 	for (; start_pfn <= max_pfn; ...)

I do not really care strongly, but we have more places were we do
start_pfn + nr_pages and then use it as pfn < end_pfn construct. I
suspect we would need to make a larger audit and make the code
consistent so unless there are major concerns I would stick with what
I have for now and leave the rest for the cleanup. Does that sound
reasonable?

-- 
Michal Hocko
SUSE Labs
