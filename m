Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFB1C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396BD2184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfACVGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:06:10 -0500
Received: from shells.gnugeneration.com ([66.240.222.126]:39660 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfACVGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 16:06:10 -0500
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Jan 2019 16:06:10 EST
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id BBFEC1A40E35; Thu,  3 Jan 2019 12:59:24 -0800 (PST)
Date:   Thu, 3 Jan 2019 12:59:24 -0800
From:   Vito Caputo <vcaputo@pengaru.com>
To:     Hussam Al-Tayeb <hussam.altayeb@gmx.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Excessive swapping under Linux 4.14.91 (no issues in 4.14.90).
Message-ID: <20190103205924.6vuwkckwcyl3ftzu@shells.gnugeneration.com>
References: <trinity-fd67cbaa-5164-40ca-b198-ded5998d2578-1546544963406@3c-app-mailcom-bs01>
 <20190103201214.fuwn55e6o4kwraw3@shells.gnugeneration.com>
 <trinity-b73f6e19-14f4-412b-91c2-49cf09b13afd-1546547589300@3c-app-mailcom-bs02>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-b73f6e19-14f4-412b-91c2-49cf09b13afd-1546547589300@3c-app-mailcom-bs02>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 09:33:09PM +0100, Hussam Al-Tayeb wrote:
> > Sent: Thursday, January 03, 2019 at 10:12 PM
> > From: "Vito Caputo" <vcaputo@pengaru.com>
> > To: "Hussam Al-Tayeb" <hussam.altayeb@gmx.com>
> > Subject: Re: Excessive swapping under Linux 4.14.91 (no issues in 4.14.90).
> >
> > 
> > The diff between 4.14.90 and 4.14.91 is rather small, appended below is
> > the entire shortlog.
> > 
> > There's only mm one commit:
> > 
> > > commit 36f93a2e7dce0a4f58b96a7ecb3af4e5897a60d4
> > > Author: Roman Gushchin <guro@fb.com>
> > > Date:   Fri Oct 26 15:03:27 2018 -0700
> > > 
> > >     mm: don't miss the last page because of round-off error
> > >     
> > >     commit 68600f623d69da428c6163275f97ca126e1a8ec5 upstream.
> > >     
> > >     I've noticed, that dying memory cgroups are often pinned in memory by a
> > >     single pagecache page.  Even under moderate memory pressure they sometimes
> > >     stayed in such state for a long time.  That looked strange.
> > >     
> > >     My investigation showed that the problem is caused by applying the LRU
> > >     pressure balancing math:
> > >     
> > >       scan = div64_u64(scan * fraction[lru], denominator),
> > >     
> > >     where
> > >     
> > >       denominator = fraction[anon] + fraction[file] + 1.
> > >     
> > >     Because fraction[lru] is always less than denominator, if the initial scan
> > >     size is 1, the result is always 0.
> > >     
> > >     This means the last page is not scanned and has
> > >     no chances to be reclaimed.
> > >     
> > >     Fix this by rounding up the result of the division.
> > >     
> > >     In practice this change significantly improves the speed of dying cgroups
> > >     reclaim.
> > >     
> > >     [guro@fb.com: prevent double calculation of DIV64_U64_ROUND_UP() arguments]
> > >       Link: http://lkml.kernel.org/r/20180829213311.GA13501@castle
> > >     Link: http://lkml.kernel.org/r/20180827162621.30187-3-guro@fb.com
> > >     Signed-off-by: Roman Gushchin <guro@fb.com>
> > >     Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> > >     Cc: Johannes Weiner <hannes@cmpxchg.org>
> > >     Cc: Michal Hocko <mhocko@kernel.org>
> > >     Cc: Tejun Heo <tj@kernel.org>
> > >     Cc: Rik van Riel <riel@surriel.com>
> > >     Cc: Konstantin Khlebnikov <koct9i@gmail.com>
> > >     Cc: Matthew Wilcox <willy@infradead.org>
> > >     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > >     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > >     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > If you're up for compiling a kernel, you could try reverting just
> > 36f93a2e from 4.14.91 and seeing if your problem goes away.
> > 
> > Regards,
> > Vito Caputo
> 
> I will do that. Thank you.

I just realized I didn't include lkml in replying to you, so I'm adding
them now for posterity.  Please include the list in any further
discussion.

Regards,
Vito Caputo
