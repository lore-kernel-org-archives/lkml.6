Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AABC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5615920657
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfAJHEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:04:02 -0500
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:52302 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727220AbfAJHEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:04:01 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl6.internode.on.net with ESMTP; 10 Jan 2019 17:33:58 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1ghUNf-0002Bx-TT; Thu, 10 Jan 2019 18:03:55 +1100
Date:   Thu, 10 Jan 2019 18:03:55 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
Message-ID: <20190110070355.GJ27534@dastard>
References: <CAHk-=wg1A44Roa8C4dmfdXLRLmNysEW36=3R7f+tzZzbcJ2d2g@mail.gmail.com>
 <CAHk-=wiqbKEC5jUXr3ax+oUuiRrp=QMv_ZnUfO-SPv=UNJ-OTw@mail.gmail.com>
 <20190108044336.GB27534@dastard>
 <CAHk-=wjvzEFQcTGJFh9cyV_MPQftNrjOLon8YMMxaX0G1TLqkg@mail.gmail.com>
 <20190109022430.GE27534@dastard>
 <nycvar.YFH.7.76.1901090326460.16954@cbobk.fhfr.pm>
 <20190109043906.GF27534@dastard>
 <CAHk-=wic28fSkwmPbBHZcJ3BGbiftprNy861M53k+=OAB9n0=w@mail.gmail.com>
 <20190110004424.GH27534@dastard>
 <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 05:18:21PM -0800, Linus Torvalds wrote:
> On Wed, Jan 9, 2019 at 4:44 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > I wouldn't look at ext4 as an example of a reliable, problem free
> > direct IO implementation because, historically speaking, it's been a
> > series of nasty hacks (*cough* mount -o dioread_nolock *cough*) and
> > been far worse than XFS from data integrity, performance and
> > reliability perspectives.
> 
> That's some big words from somebody who just admitted to much worse hacks.

Sorry, what hacks did I just admit to making? This O_DIRECT
behaviour long predates me - I'm just the messenger and you are
shooting from the hip.

Linus, the point I was making is that there are many, many ways to
control page cache invalidation and measure page cache residency,
and that trying to address them one-by-one is just a game of
whack-a-mole.

In future, can you please try not to go off the rails when someone
mentions O_DIRECT? You have a terrible habit of going off on
misdirected rants about O_DIRECT and/or XFS at any opportunity you
can get, and all it does is derail whatever useful conversation was
taking place.

> Seriously. XFS is buggy in this regard, ext4 apparently isn't.

So you keep asserting despite being presented with evidence that it
mitigates other longstanding bugs that are really hard to solve.
Ignoring all the evidence you've been presented with and
re-asserting your original statement doesn't make it correct.

Did you not think to ask "what are those problems, and what can do
to solve them so we can remove the invalidation mitigations that XFS
uses?". That would be a useful contribution, whereas shouting about
how O_DIRECT is broken just pisses off the people working their
asses off to fix the problems you just heard about and are ranting
about.

> Thinking that it's better to just invalidate the cache  for direct IO
> reads is all kinds of odd.

No, it's practicality. If we can't fix the problem, we have to
mitigate it. When we fix the underlying problem we can remove the
mitigation code. having you assert that it's broken and demand that
it be removed doesn't change the fact that we haven't fixed the
underlying problems. It's being worked on, but we're not there yet.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
