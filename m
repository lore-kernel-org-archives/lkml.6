Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB30C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A953217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549953412;
	bh=7lELHqEozBe706CdEhvF9P6fdK70nzkszgw7c7Xiom8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KuKMZWQeetq9VcATxzko6Eq80DFGuYl2xSiM+zpMxLrUnxFIOrQv+ggK4BXjrVHY1
	 wG3pGVCCWTgX5DARGyDKE0nbLX35YxcpgBxTayYB+JzsyFduMYvrdW9ZnP6EvSrzMi
	 c9VBlr9zBQemCv8Mq9JmJcMPwVMwKtiNgOOyfw48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfBLGgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 01:36:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:57950 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725930AbfBLGgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 01:36:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F9C3AC4C;
        Tue, 12 Feb 2019 06:36:47 +0000 (UTC)
Date:   Tue, 12 Feb 2019 07:36:43 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Chinner <david@fromorbit.com>,
        Kevin Easton <kevin@guarana.org>,
        Matthew Wilcox <willy@infradead.org>,
        Cyril Hrubis <chrubis@suse.cz>, Tejun Heo <tj@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Daniel Gruss <daniel@gruss.cc>, Josh Snyder <joshs@netflix.com>
Subject: Re: [PATCH 3/3] mm/mincore: provide mapped status when cached status
 is not allowed
Message-ID: <20190212063643.GL15609@dhcp22.suse.cz>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <20190130124420.1834-1-vbabka@suse.cz>
 <20190130124420.1834-4-vbabka@suse.cz>
 <20190131100907.GS18811@dhcp22.suse.cz>
 <99ee4d3e-aeb2-0104-22be-b028938e7f88@suse.cz>
 <nycvar.YFH.7.76.1902120440430.11598@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1902120440430.11598@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-02-19 04:44:30, Jiri Kosina wrote:
> On Fri, 1 Feb 2019, Vlastimil Babka wrote:
> 
> > >> After "mm/mincore: make mincore() more conservative" we sometimes restrict the
> > >> information about page cache residency, which we have to do without breaking
> > >> existing userspace, if possible. We thus fake the resulting values as 1, which
> > >> should be safer than faking them as 0, as there might theoretically exist code
> > >> that would try to fault in the page(s) until mincore() returns 1.
> > >>
> > >> Faking 1 however means that such code would not fault in a page even if it was
> > >> not in page cache, with unwanted performance implications. We can improve the
> > >> situation by revisting the approach of 574823bfab82 ("Change mincore() to count
> > >> "mapped" pages rather than "cached" pages") but only applying it to cases where
> > >> page cache residency check is restricted. Thus mincore() will return 0 for an
> > >> unmapped page (which may or may not be resident in a pagecache), and 1 after
> > >> the process faults it in.
> > >>
> > >> One potential downside is that mincore() will be again able to recognize when a
> > >> previously mapped page was reclaimed. While that might be useful for some
> > >> attack scenarios, it's not as crucial as recognizing that somebody else faulted
> > >> the page in, and there are also other ways to recognize reclaimed pages anyway.
> > > 
> > > Is this really worth it? Do we know about any specific usecase that
> > > would benefit from this change? TBH I would rather wait for the report
> > > than add a hard to evaluate side channel.
> > 
> > Well it's not that complicated IMHO. Linus said it's worth trying, so
> > let's see how he likes the result. The side channel exists anyway as
> > long as process can e.g. check if its rss shrinked, and I doubt we are
> > going to remove that possibility.
> 
> So, where do we go from here?
> 
> Either Linus and Andrew like the mincore() return value tweak, or this 
> could be further discussed (*). But in either of the cases, I think 
> patches 1 and 2 should be at least queued for 5.1.

I would go with patch 1 for 5.1. Patches 2 still sounds controversial or
incomplete to me. And patch 3, well I will leave the decision to
Andrew/Linus.

> (*) I'd personally include it as well, as I don't see how it would break 
>     anything, it's pretty straightforward, and brings back some sanity to
>     mincore() return value.

-- 
Michal Hocko
SUSE Labs
