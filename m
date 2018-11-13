Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63318C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3309722507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3309722507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbeKMLNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:13:52 -0500
Received: from ipmail02.adl2.internode.on.net ([150.101.137.139]:8012 "EHLO
        ipmail02.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbeKMLNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 06:13:52 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail02.adl2.internode.on.net with ESMTP; 13 Nov 2018 11:48:06 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gMNLB-0007ga-1f; Tue, 13 Nov 2018 12:18:05 +1100
Date:   Tue, 13 Nov 2018 12:18:05 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Joe Perches <joe@perches.com>
Cc:     Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfs: Remove noinline from #define STATIC
Message-ID: <20181113011804.GP19305@dastard>
References: <7302f4a13c1cbf62b07f636878ce25fcca84b6c4.camel@perches.com>
 <6420cf91-89c8-a876-7a0d-25ab8ba428b8@sandeen.net>
 <20181112214515.GN19305@dastard>
 <bd3806ccc911989c7ef1fed9e8d26a4a5ad347a9.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd3806ccc911989c7ef1fed9e8d26a4a5ad347a9.camel@perches.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 02:30:01PM -0800, Joe Perches wrote:
> On Tue, 2018-11-13 at 08:45 +1100, Dave Chinner wrote:
> > On Mon, Nov 12, 2018 at 02:12:08PM -0600, Eric Sandeen wrote:
> > > On 11/10/18 7:21 PM, Joe Perches wrote:
> > > > Reduce total object size quite a bit (~32KB) and presumably
> > > > improve performance at the same time.
> > > > 
> > > > Total object size old vs new (x86-64 defconfig with xfs)
> > > > 
> > > >     text	   data	    bss	    dec	    hex	filename
> > > > - 959351	 165573	    632	1125556	 112cb4	(TOTALS) (old)
> > > > + 924683	 165669	    632	1090984	 10a5a8	(TOTALS) (new)
> > > 
> > > And what does it do to maximum stack excursions?
> > 
> > Better yet: what does it do to corruption stack traces and debugging
> > tools like profiling traces?
> > 
> > i.e. this noinline directive isn't about stack usage, this is about
> > being able to debug production code. Basically the compiler inliner
> > is so agressive on static functions that it makes it impossible to
> > decipher the stack traces. It flattens them way too much to
> > be able to tell how we got to a specific location in the code.
> > 
> > In reality, being able to find problems quickly and efficiently is
> > far more important to us than being able to run everything at
> > ludicrous speed....
> 
> Is that really a compelling argument given thw ~50:50
> split of static/STATIC uses in xfs?

Historically, yes. We're talking about code with call chains that
can go 50-60 functions deep here. If that gets flattened to 10-20
functions by compiler inlining (which is the sort of thing that
happens) then we lose a huge amount of visibility into the workings
of the code. This affects profiling, stack traces on corruption,
dynamic debug probes, kernel crash dump analysis, etc.

I'm not interested in making code fast if distro support engineers
can't debug problems on user systems easily. Optimising for
performance over debuggability is a horrible trade off for us to
make because it means users and distros end up much more reliant on
single points of expertise for debugging problems. And that means
the majority of the load of problem triage falls directly on very
limited resources - the core XFS development team. A little bit of
thought about how to make code easier to triage and debug goes a
long, long way....

Indeed, this is not a new problem - we've been using techniques like
STATIC in one form or another to stop compiler inlining and/or
function hiding since XFS was first ported to linux 20 years ago.
In fact, STATIC was inherited from Irix because it helped with
debugging via the userspace simulator that the initial XFS code was
developed on. i.e.  STATIC was present in the initial XFS commit
made way back in 1993, and we've been using it ever since...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
