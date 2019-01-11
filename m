Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55737C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D48214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbfAKBrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:47:33 -0500
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:41985 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727750AbfAKBrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 20:47:33 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl6.internode.on.net with ESMTP; 11 Jan 2019 12:17:29 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1ghluy-0003Jr-JX; Fri, 11 Jan 2019 12:47:28 +1100
Date:   Fri, 11 Jan 2019 12:47:28 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
Message-ID: <20190111014728.GL27534@dastard>
References: <CAHk-=wiqbKEC5jUXr3ax+oUuiRrp=QMv_ZnUfO-SPv=UNJ-OTw@mail.gmail.com>
 <20190108044336.GB27534@dastard>
 <CAHk-=wjvzEFQcTGJFh9cyV_MPQftNrjOLon8YMMxaX0G1TLqkg@mail.gmail.com>
 <20190109022430.GE27534@dastard>
 <nycvar.YFH.7.76.1901090326460.16954@cbobk.fhfr.pm>
 <20190109043906.GF27534@dastard>
 <CAHk-=wic28fSkwmPbBHZcJ3BGbiftprNy861M53k+=OAB9n0=w@mail.gmail.com>
 <20190110004424.GH27534@dastard>
 <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com>
 <CALCETrWxwaBUYMg=aLySJByMgXzuzV4gHS0n6O6Oet2Jm6SAbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWxwaBUYMg=aLySJByMgXzuzV4gHS0n6O6Oet2Jm6SAbw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 09:26:41PM -0800, Andy Lutomirski wrote:
> Since direct IO has been brought up, I have a question.  I've wondered
> for years why direct IO works the way it does.  If I were implementing
> it from scratch, my first inclination would be to use the page cache
> instead of fighting it.  To do a single-page direct read, I would look
> that page up in the page cache (i.e. i_pages these days).  If the page
> is there, I would do a normal buffered read.  If the page is not

Therein lies the problem. Copying data is prohibitively expensive,
and that's the primary reason for O_DIRECT existing.  i.e. O_DIRECT
is a low-overhead, zero-copy data movement interface.

The moment we switch from using CPU to dispatch IO to copying data,
performance goes down because we will be unable to keep storage
pipelines full.  IOWs, any rework of O_DIRECT that involves copying
data is a non-starter.

But let's bring this back to the issue at hand - observability of
page cache residency of file pages. If th epage is caceh resident,
then it will have a latency of copying that data out of the page
(i.e. very low latency). If the page is not resident, then it will
do IO and take much, much longer to complete. i.e. we have clear
timing differences between cachce hit and cache miss IO.  This is
exactly the timing information needed for observing page cache
residency.

We need to work out how to make page cache residency less
observable, not add new, near perfect observation mechanisms that
third parties can easily exploit...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
