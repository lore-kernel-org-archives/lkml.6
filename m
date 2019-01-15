Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A43C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE6520645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 23:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391514AbfAOXpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 18:45:15 -0500
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:15465 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728841AbfAOXpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 18:45:15 -0500
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl6.internode.on.net with ESMTP; 16 Jan 2019 10:15:11 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gjYOM-0001my-FI; Wed, 16 Jan 2019 10:45:10 +1100
Date:   Wed, 16 Jan 2019 10:45:10 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
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
Message-ID: <20190115234510.GA6173@dastard>
References: <20190110070355.GJ27534@dastard>
 <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com>
 <20190110122442.GA21216@nautica>
 <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
 <20190111020340.GM27534@dastard>
 <CAHk-=wgLgAzs42=W0tPrTVpu7H7fQ=BP5gXKnoNxMxh9=9uXag@mail.gmail.com>
 <20190111040434.GN27534@dastard>
 <CAHk-=wh-kegfnPC_dmw0A72Sdk4B9tvce-cOR=jEfHDU1-4Eew@mail.gmail.com>
 <20190111073606.GP27534@dastard>
 <CAHk-=wj+xyz_GKjgKpU6SF3qeqouGmRoR8uFxzg_c1VpeGEJMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj+xyz_GKjgKpU6SF3qeqouGmRoR8uFxzg_c1VpeGEJMw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 08:26:14AM -0800, Linus Torvalds wrote:
> On Thu, Jan 10, 2019 at 11:36 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > > It's only that single page that *matters*. That's the page that the
> > > probe reveals the status of - but it's also the page that the probe
> > > then *changes* the status of.
> >
> > It changes the state of it /after/ we've already got the information
> > we need from it. It's not up to date, it has to come from disk, we
> > return EAGAIN, which means it was not in the cache.
> 
> Oh, I see the confusion.
> 
> Yes, you get the information about whether something was in the cache
> or not, so the side channel does exist to some degree.
> 
> But it's actually hugely reduced for a rather important reason: the
> _primary_ reason for needing to know whether some page is in the cache
> or not is not actually to see if it was ever accessed - it's to see
> that the cache has been scrubbed (and to _guide_ the scrubbing), and
> *when* it was accessed.

Oh, you're assuming that you need to probe the page cache to
determine if brute force invalidation has progressed far enough
to invalidate the page in question.

I'm assuming that you can invalidate the page cache reliably by a
means that does not repeated require probing to detect invalidation
has occurred. I've mentioned one method in this discussion
already...

IOWs, just because the specific brute force attack documented in the
paper required repeated probing it doesn't mean all future
invalidation attacks will require repeated probing. Hence a robust
defense mechanism should not rely on the attacker requiring multiple
observations of the page cache to extract the information they are
seeking...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
