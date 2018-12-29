Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5623C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 23:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EBA20866
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 23:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeL2Xf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 18:35:27 -0500
Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:3425 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbeL2Xf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 18:35:26 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail03.adl6.internode.on.net with ESMTP; 30 Dec 2018 10:05:24 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gdO8Y-00075t-60; Sun, 30 Dec 2018 10:35:22 +1100
Date:   Sun, 30 Dec 2018 10:35:22 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Thomas Backlund <tmb@mageia.org>, Sasha Levin <sashal@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 25/35] iomap: sub-block dio needs to zeroout
 beyond EOF
Message-ID: <20181229233522.GT6311@dastard>
References: <20181129124756.GA25945@kroah.com>
 <20181129224019.GM19305@dastard>
 <20181130082203.GA26830@kroah.com>
 <20181130101441.GA213156@sasha-vm>
 <20181130215005.GP19305@dastard>
 <20181201074909.GC213156@sasha-vm>
 <20181202232302.GT19305@dastard>
 <20181203092241.GC235790@sasha-vm>
 <2de96c1b-c375-8eed-f934-df5cbcdcd5cc@mageia.org>
 <20181228080624.GA6341@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228080624.GA6341@amd>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 09:06:24AM +0100, Pavel Machek wrote:
> On Mon 2018-12-03 23:22:46, Thomas Backlund wrote:
> > Den 2018-12-03 kl. 11:22, skrev Sasha Levin:
> > 
> > > 
> > > This is a case where theory collides with the real world. Yes, our QA is
> > > lacking, but we don't have the option of not doing the current process.
> > > If we stop backporting until a future data where our QA problem is
> > > solved we'll end up with what we had before: users stuck on ancient
> > > kernels without a way to upgrade.
> > > 
> > 
> > Sorry, but you seem to be living in a different "real world"...
> 
> I have to agree here :-(.
> 
> > People stay on "ancient kernels" that "just works" instead of updating
> > to a newer one that "hopefully/maybe/... works"
> 
> Stable has a rules community agreed on, unfortunately stable team just
> simply ignores those and decided to do "whatever they please".
> 
> Process went from "serious bugs that bother people only" to "hey, this
> looks like a bugfix, lets put it into tree and see what it breaks"...

Resulting in us having to tell users not to use stable kernels
because they can contain broken commits from upstream that did not
go through maintainer tree and test cycles.

https://marc.info/?l=linux-xfs&m=154544499507105&w=2

In this case, the broken commit to the fs/iomap.c code was merged
upstream through the akpm tree, rather than the XFS tree and test
process as previous changes to this code had been staged.

It was then backported so fast and released so quickly that it
hadn't got back into the XFS upstream tree test cycles until
after it had already committed to at least one stable kernel.  We'd
only just registered and confirmed a regression in in post -rc7
upstream trees when the stale kernel containing the commit was
released. It took us another couple of days to isolate failing
configuration and bisect it down to the commit.

Only when I got "formlettered" for cc'ing the stable kernel list on
the revert patch (because I wanted to make sure the stable kernel
maintainers knew it was being reverted and so it wouldn't be
backported) did I learn it had already been "auto-backported" and
released in a stable kernel in under a week. Essentially, the
"auto-backport" completely short-circuited the upstream QA
process.....

IOWs, if you were looking for a case study to demonstrate the
failings of the current stable process, this is it.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
