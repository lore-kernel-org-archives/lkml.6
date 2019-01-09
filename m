Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A75FC43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D610E218C3
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfAICYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 21:24:35 -0500
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:24420 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728253AbfAICYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 21:24:34 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail07.adl2.internode.on.net with ESMTP; 09 Jan 2019 12:54:31 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gh3Xi-0000Ox-8Y; Wed, 09 Jan 2019 13:24:30 +1100
Date:   Wed, 9 Jan 2019 13:24:30 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jann Horn <jannh@google.com>,
        Jiri Kosina <jikos@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
Message-ID: <20190109022430.GE27534@dastard>
References: <CAG48ez2jAp9xkPXQmVXm0PqNrFGscg9BufQRem2UD8FGX-YzPw@mail.gmail.com>
 <CAHk-=whL4sZiM=JcdQAYQvHm7h7xEtVUh+gYGYhoSk4vi38tXg@mail.gmail.com>
 <CAHk-=wg5Kk+r36=jcGBaLUj+gjopjgiW5eyvkdMqvn0jFkD_iQ@mail.gmail.com>
 <CAHk-=wiMQeCEKESWTmm15x79NjEjNwFvjZ=9XenxY7yH8zqa7A@mail.gmail.com>
 <20190106001138.GW6310@bombadil.infradead.org>
 <CAHk-=wiT=ov+6zYcnw_64ihYf74Amzqs67iVGtJMQq65PxiVYw@mail.gmail.com>
 <CAHk-=wg1A44Roa8C4dmfdXLRLmNysEW36=3R7f+tzZzbcJ2d2g@mail.gmail.com>
 <CAHk-=wiqbKEC5jUXr3ax+oUuiRrp=QMv_ZnUfO-SPv=UNJ-OTw@mail.gmail.com>
 <20190108044336.GB27534@dastard>
 <CAHk-=wjvzEFQcTGJFh9cyV_MPQftNrjOLon8YMMxaX0G1TLqkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjvzEFQcTGJFh9cyV_MPQftNrjOLon8YMMxaX0G1TLqkg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 09:57:49AM -0800, Linus Torvalds wrote:
> On Mon, Jan 7, 2019 at 8:43 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > So, I read the paper and before I was half way through it I figured
> > there are a bunch of other similar page cache invalidation attacks
> > we can perform without needing mincore. i.e. Focussing on mmap() and
> > mincore() misses the wider issues we have with global shared caches.
> 
> Oh, agreed, and that was discussed in the original report too.
> 
> The thing is, you can also depend on our pre-faulting of pages in the
> page fault handler, and use that to get the cached status of nearby
> pages. So do something like "fault one page, then do mincore() to see
> how many pages near it were mapped". See our "do_fault_around()"
> logic.

Observing fault-around could help you detect what code an application is
running, but it's not necessary (and can be turned off). Also, such
an it observation is not dependent on using mincore. neither
fault-around nor mincore are required functionality to exploit the
information leaks.

And, FWIW, fault-around actually destroys the information in the
exfiltration channel described in the paper because it perturbs the
carefully constructed page cache residency pattern that encodes the
message.

> But mincore is certainly the easiest interface, and the one that
> doesn't require much effort or setup.

Off the top of my head, here's a few vectors for reading the page
cache residency state without perturbing the page cache residency
pattern:
	- mincore
	- preadv2(RWF_NOWAIT)
	- fadvise(POSIX_FADV_RANDOM); timed read(2) syscalls
	- madvise(MADV_RANDOM); timed read of first byte in each page

i.e. mincore is a messenger, but it's not the only trivial
observation technique available. The only difference between mincore
and the others will be the observation latency and hence channel
bandwidth.

IOWs, the question we need to focus on now is not "does breaking
mincore affect anyone", it is "how the hell do we mitigate and
isolate an information leak exposed by fundamental OS functionality
that *everything* depends on for performance"?

> It's also the one where our old
> behavior was actually arguably simply stupid and actively wrong (ie
> "in caches" isn't even strictly speaking a valid question, since the
> caches in question may be invalid).

This is irrelevant to the problem reported. Sure, mincore may be
an awful interface, but it's semantics are not the cause of the
information leak. You're just shooting the messenger...

> I do think that the RWF_NOWAIT case might also be interesting to look at.

As are all the other mechanisms you can use to observer page cache
residency without perturbing it's state.

Keep in mind that the researchers documented a remote observation
technique that leaked the information across the network to a remote
host, so this leak has much, much wider scope than changing mincore
can address...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
