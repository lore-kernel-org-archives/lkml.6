Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3822EC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21DD2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547476383;
	bh=NLtV65joNgVq6TIvdOvi5M3pvgK0T0aswxgPPC88Wgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RERJ4b5bNGxuopBrOHXt+A9RetENl9HFB/sjZFX9CYoq0cJ/W9874t91Bh6mu75iF
	 yXQ0x1UtDlN9gtwRWJCB7Jynz4OcQ7KfhkBV+aKJ8nUZbZ4gEUo//S0YQwDI/J4p2b
	 ytNGfBq/BRtUaRELKGWOin4HSX/qK8YCptlxagJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfANOcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:32:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:57468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726526AbfANOcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:32:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B43EAF1B;
        Mon, 14 Jan 2019 14:32:52 +0000 (UTC)
Date:   Mon, 14 Jan 2019 15:32:51 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Arun KS <arunks@codeaurora.org>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        arunks.linux@gmail.com, akpm@linux-foundation.org, vbabka@suse.cz,
        osalvador@suse.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, getarunks@gmail.com
Subject: Re: [PATCH v9] mm/page_alloc.c: memory_hotplug: free pages as higher
 order
Message-ID: <20190114143251.GI21345@dhcp22.suse.cz>
References: <1547098543-26452-1-git-send-email-arunks@codeaurora.org>
 <f65b1b22426855ff261b3af719e58eded576a168.camel@linux.intel.com>
 <fa3dc06536a8ba980c4434806204017a@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa3dc06536a8ba980c4434806204017a@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-01-19 19:29:39, Arun KS wrote:
> On 2019-01-10 21:53, Alexander Duyck wrote:
[...]
> > Couldn't you just do something like the following:
> > 		if ((end - start) >= (1UL << (MAX_ORDER - 1))
> > 			order = MAX_ORDER - 1;
> > 		else
> > 			order = __fls(end - start);
> > 
> > I would think this would save you a few steps in terms of conversions
> > and such since you are already working in page frame numbers anyway so
> > a block of 8 pfns would represent an order 3 page wouldn't it?
> > 
> > Also it seems like an alternative to using "end" would be to just track
> > nr_pages. Then you wouldn't have to do the "end - start" math in a few
> > spots as long as you remembered to decrement nr_pages by the amount you
> > increment start by.
> 
> Thanks for that. How about this?
> 
> static int online_pages_blocks(unsigned long start, unsigned long nr_pages)
> {
>         unsigned long end = start + nr_pages;
>         int order;
> 
>         while (nr_pages) {
>                 if (nr_pages >= (1UL << (MAX_ORDER - 1)))
>                         order = MAX_ORDER - 1;
>                 else
>                         order = __fls(nr_pages);
> 
>                 (*online_page_callback)(pfn_to_page(start), order);
>                 nr_pages -= (1UL << order);
>                 start += (1UL << order);
>         }
>         return end - start;
> }

I find this much less readable so if this is really a big win
performance wise then make it a separate patch with some nubbers please.

-- 
Michal Hocko
SUSE Labs
