Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3EBC43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDB521848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547019442;
	bh=Zs2758UUIAp+1b7keIBGSu0aiUl5Ziv5s3VMHyC2V9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HfHNMXlubr4td9CPzT4zjzc5RjP45ZULpU8DDlXVHUu6n6jDLdl9hGea2a28vffas
	 mWfnBdDybtQ2Yr0wC5wvDcOslqzBU4cIv2tWgNdjzd/Sirsl4EbCcSZRMyeZTkw0Su
	 zpFfrefAZudUUXeWxiBfaXhaqe9TADF9x0XLodD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbfAIHhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:37:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:46252 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728221AbfAIHhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:37:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0D6FACB8;
        Wed,  9 Jan 2019 07:37:19 +0000 (UTC)
Date:   Wed, 9 Jan 2019 08:37:18 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Arun KS <arunks@codeaurora.org>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        arunks.linux@gmail.com, akpm@linux-foundation.org, vbabka@suse.cz,
        osalvador@suse.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, getarunks@gmail.com
Subject: Re: [PATCH v7] mm/page_alloc.c: memory_hotplug: free pages as higher
 order
Message-ID: <20190109073718.GM31793@dhcp22.suse.cz>
References: <1546578076-31716-1-git-send-email-arunks@codeaurora.org>
 <fb6465c99b3ada2c6af587a7eb00016d96d56f77.camel@linux.intel.com>
 <20190108181352.GI31793@dhcp22.suse.cz>
 <bfb543b6e343c21c3e263a110f234e08@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfb543b6e343c21c3e263a110f234e08@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-01-19 11:28:52, Arun KS wrote:
> On 2019-01-08 23:43, Michal Hocko wrote:
> > On Tue 08-01-19 09:56:09, Alexander Duyck wrote:
> > > On Fri, 2019-01-04 at 10:31 +0530, Arun KS wrote:
> > [...]
> > > >  static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
> > > >  			void *arg)
> > > >  {
> > > > -	unsigned long i;
> > > >  	unsigned long onlined_pages = *(unsigned long *)arg;
> > > > -	struct page *page;
> > > >
> > > >  	if (PageReserved(pfn_to_page(start_pfn)))
> > > > -		for (i = 0; i < nr_pages; i++) {
> > > > -			page = pfn_to_page(start_pfn + i);
> > > > -			(*online_page_callback)(page);
> > > > -			onlined_pages++;
> > > > -		}
> > > > +		onlined_pages = online_pages_blocks(start_pfn, nr_pages);
> > > 
> > > Shouldn't this be a "+=" instead of an "="? It seems like you are
> > > going
> > > to lose your count otherwise.
> > 
> > You are right of course. I should have noticed during the review.
> > Thanks!
> 
> I think we don't need to. The caller function is setting onlined_pages = 0
> before calling online_pages_range().
> And there are no other reference to online_pages_range other than from
> online_pages().

Are you missing that we accumulate onlined_pages via
	*(unsigned long *)arg = onlined_pages;
in online_pages_range?

-- 
Michal Hocko
SUSE Labs
