Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEE4C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 04:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5424F20665
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 04:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbfAIEjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 23:39:13 -0500
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:41034 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728112AbfAIEjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 23:39:13 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail07.adl2.internode.on.net with ESMTP; 09 Jan 2019 15:09:08 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gh5dy-0000WO-Sz; Wed, 09 Jan 2019 15:39:06 +1100
Date:   Wed, 9 Jan 2019 15:39:06 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
Message-ID: <20190109043906.GF27534@dastard>
References: <CAHk-=wg5Kk+r36=jcGBaLUj+gjopjgiW5eyvkdMqvn0jFkD_iQ@mail.gmail.com>
 <CAHk-=wiMQeCEKESWTmm15x79NjEjNwFvjZ=9XenxY7yH8zqa7A@mail.gmail.com>
 <20190106001138.GW6310@bombadil.infradead.org>
 <CAHk-=wiT=ov+6zYcnw_64ihYf74Amzqs67iVGtJMQq65PxiVYw@mail.gmail.com>
 <CAHk-=wg1A44Roa8C4dmfdXLRLmNysEW36=3R7f+tzZzbcJ2d2g@mail.gmail.com>
 <CAHk-=wiqbKEC5jUXr3ax+oUuiRrp=QMv_ZnUfO-SPv=UNJ-OTw@mail.gmail.com>
 <20190108044336.GB27534@dastard>
 <CAHk-=wjvzEFQcTGJFh9cyV_MPQftNrjOLon8YMMxaX0G1TLqkg@mail.gmail.com>
 <20190109022430.GE27534@dastard>
 <nycvar.YFH.7.76.1901090326460.16954@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1901090326460.16954@cbobk.fhfr.pm>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 03:31:35AM +0100, Jiri Kosina wrote:
> On Wed, 9 Jan 2019, Dave Chinner wrote:
> 
> > > But mincore is certainly the easiest interface, and the one that
> > > doesn't require much effort or setup.
> > 
> > Off the top of my head, here's a few vectors for reading the page
> > cache residency state without perturbing the page cache residency
> > pattern:
> > 	- mincore
> > 	- preadv2(RWF_NOWAIT)
> > 	- fadvise(POSIX_FADV_RANDOM); timed read(2) syscalls
> > 	- madvise(MADV_RANDOM); timed read of first byte in each page
> 
> While I obviously agree that all those are creating pagecache sidechannel 
> in principle, I think we really should mostly focus on the first two (with 
> mincore() already having been covered).

FWIW, I just realised that the easiest, most reliable way to
invalidate the page cache over a file range is simply to do a
O_DIRECT read on it. IOWs, all three requirements of this
information leak - highly specific, reliable cache invalidation
control, controlled cache instantiation and 3rd-party detection of
cache residency can all be performed with just the read(2)
syscall...

> Rationale has been provided by Daniel Gruss in this thread -- if the 
> attacker is left with cache timing as the only available vector, he's 
> going to be much more successful with mounting hardware cache timing 
> attack anyway.

No, he said:

"Restricting mincore() is sufficient to fix the hardware-agnostic
part."

That's not correct - preadv2(RWF_NOWAIT) is also hardware agnostic
and provides exactly the same information about the page cache as
mincore.  Timed read/mmap access loops for cache observation are
also hardware agnostic, and on fast SSD based storage will only be
marginally slower bandwidth than preadv2(RWF_NOWAIT).

Attackers will pick whatever leak vector we don't fix, so we either
fix them all (which I think is probably impossible without removing
caching altogether) or we start thinking about how we need to
isolate the page cache so that information isn't shared across
important security boundaries (e.g. page cache contents are
per-mount namespace).

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
