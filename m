Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34936C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0135520867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 21:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0135520867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeLAI4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:56:33 -0500
Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:11550 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725749AbeLAI4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 03:56:33 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail03.adl2.internode.on.net with ESMTP; 01 Dec 2018 08:15:50 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gSqbc-0008IG-46; Sat, 01 Dec 2018 08:45:48 +1100
Date:   Sat, 1 Dec 2018 08:45:48 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 25/35] iomap: sub-block dio needs to zeroout
 beyond EOF
Message-ID: <20181130214548.GO19305@dastard>
References: <20181129060110.159878-1-sashal@kernel.org>
 <20181129060110.159878-25-sashal@kernel.org>
 <20181129121458.GK19305@dastard>
 <20181129124756.GA25945@kroah.com>
 <20181129224019.GM19305@dastard>
 <20181130082203.GA26830@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130082203.GA26830@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 09:22:03AM +0100, Greg KH wrote:
> On Fri, Nov 30, 2018 at 09:40:19AM +1100, Dave Chinner wrote:
> > On Thu, Nov 29, 2018 at 01:47:56PM +0100, Greg KH wrote:
> > > On Thu, Nov 29, 2018 at 11:14:59PM +1100, Dave Chinner wrote:
> > > > 
> > > > Cherry picking only one of the 50-odd patches we've committed into
> > > > late 4.19 and 4.20 kernels to fix the problems we've found really
> > > > seems like asking for trouble. If you're going to back port random
> > > > data corruption fixes, then you need to spend a *lot* of time
> > > > validating that it doesn't make things worse than they already
> > > > are...
> > > 
> > > Any reason why we can't take the 50-odd patches in their entirety?  It
> > > sounds like 4.19 isn't fully fixed, but 4.20-rc1 is?  If so, what do you
> > > recommend we do to make 4.19 working properly?
> > 
> > You coul dpull all the fixes, but then you have a QA problem.
> > Basically, we have multiple badly broken syscalls (FICLONERANGE,
> > FIDEDUPERANGE and copy_file_range), and even 4.20-rc4 isn't fully
> > fixed.
> > 
> > There were ~5 critical dedupe/clone data corruption fixes for XFS
> > went into 4.19-rc8.
> 
> Have any of those been tagged for stable?

None, because I have no confidence that the stable process will do
the necessary QA to validate that such a significant backport is
regression and data corruption free.  The backport needs to be done
as a complete series when we've finished the upstream work because
we can't test isolated patches adequately because fsx will fall over
due to all the unfixed problems and not exercise the fixes that were
backported.

Further, we just had a regression reported in one of the commit that
the autosel bot has selected for automatic backports. It has been
uncovered by overlay which appears to do some unique things with
the piece of crap that is do_splice_direct(). And Darrick just
commented on #xfs that he's just noticed more bugs with FICLONERANGE
and overlay.

IOWs, we're still finding broken stuff in this code and we are
fixing it as fast as we can - we're still putting out fires. We most
certainly don't need the added pressure of having you guys create
more spot fires by breaking stable kernels with largely untested
partial backports and having users exposed to whacky new data
corruption issues.

So, no, it isn't tagged for stable kernels because "commit into
mainline" != "this should be backported immediately". Backports of
these fixes are largely going to be done largely as a function of
time and resources, of which we have zero available right now. Doing
backports right now is premature and ill-advised because we haven't
finished finding and fixing all the bugs and regressions in this
code.

> > Right now the XFS developers don't have the time or resources
> > available to validate stable backports are correct and regression
> > fre because we are focussed on ensuring the upstream fixes we've
> > already made (and are still writing) are solid and reliable.
> 
> Ok, that's fine, so users of XFS should wait until the 4.20 release
> before relying on it?  :)

Ok, Greg, that's *out of line*.

I should throw the CoC at you because I find that comment offensive,
condescending, belittling, denegrating and insulting.  Your smug and
superior "I know what is right for you" attitude is completely
inappropriate, and a little smiley face does not make it acceptible.

If you think your comment is funny, you've badly misjudged how much
effort I've put into this (100-hour weeks for over a month now), how
close I'm flying to burn out (again!), and how pissed off I am about
this whole scenario.

We ended up here because we *trusted* that other people had
implemented and tested their APIs and code properly before it got
merged. We've been severely burnt, and we've been left to clean up
the mess made by other people by ourselves.

Instead of thanks, what we get instead is "we know better" attitude
and jokes implying our work is crap and we don't care about our
users. That's just plain *insulting*.  If anyone is looking for a
demonstration of everything that is wrong with the Linux kernel
development culture, then they don't need to look any further.

> I understand your reluctance to want to backport anything, but it really
> feels like you are not even allowing for fixes that are "obviously
> right" to be backported either, even after they pass testing.  Which
> isn't ok for your users.

It's worse for our users if we introduce regressions into stable
kernels, which is exactly what this "obviously right" auto-backport
would have done.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
