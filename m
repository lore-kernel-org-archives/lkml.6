Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14663C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F1C2168C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F1C2168C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbeHHUuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:50:54 -0400
Received: from fieldses.org ([173.255.197.46]:46912 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbeHHUux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:50:53 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 40A098BF; Wed,  8 Aug 2018 14:29:59 -0400 (EDT)
Date:   Wed, 8 Aug 2018 14:29:59 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     NeilBrown <neilb@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Wilck <mwilck@suse.de>
Subject: Re: [PATCH 0/4] locks: avoid thundering-herd wake-ups
Message-ID: <20180808182959.GB23873@fieldses.org>
References: <153369219467.12605.13472423449508444601.stgit@noble>
 <ea503e6a6f26dfb344fda02c765ae87de65ed025.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea503e6a6f26dfb344fda02c765ae87de65ed025.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 12:47:22PM -0400, Jeff Layton wrote:
> On Wed, 2018-08-08 at 11:51 +1000, NeilBrown wrote:
> > If you have a many-core machine, and have many threads all wanting to
> > briefly lock a give file (udev is known to do this), you can get quite
> > poor performance.
> > 
> > When one thread releases a lock, it wakes up all other threads that
> > are waiting (classic thundering-herd) - one will get the lock and the
> > others go to sleep.
> > When you have few cores, this is not very noticeable: by the time the
> > 4th or 5th thread gets enough CPU time to try to claim the lock, the
> > earlier threads have claimed it, done what was needed, and released.
> > With 50+ cores, the contention can easily be measured.
> > 
> > This patchset creates a tree of pending lock request in which siblings
> > don't conflict and each lock request does conflict with its parent.
> > When a lock is released, only requests which don't conflict with each
> > other a woken.
> > 
> > Testing shows that lock-acquisitions-per-second is now fairly stable even
> > as number of contending process goes to 1000.  Without this patch,
> > locks-per-second drops off steeply after a few 10s of processes.
> > 
> > There is a small cost to this extra complexity.
> > At 20 processes running a particular test on 72 cores, the lock
> > acquisitions per second drops from 1.8 million to 1.4 million with
> > this patch.  For 100 processes, this patch still provides 1.4 million
> > while without this patch there are about 700,000.
> > 
> > NeilBrown
> > 
> > ---
> > 
> > NeilBrown (4):
> >       fs/locks: rename some lists and pointers.
> >       fs/locks: allow a lock request to block other requests.
> >       fs/locks: change all *_conflict() functions to return bool.
> >       fs/locks: create a tree of dependent requests.
> > 
> > 
> >  fs/cifs/file.c                  |    2 -
> >  fs/locks.c                      |  142 +++++++++++++++++++++++++--------------
> >  include/linux/fs.h              |    5 +
> >  include/trace/events/filelock.h |   16 ++--
> >  4 files changed, 103 insertions(+), 62 deletions(-)
> > 
> 
> Nice work! I looked over this and I think it looks good.
> 
> I made an attempt to fix this issue several years ago, but my method
> sucked as it ended up penalizing the unlocking task too much. This is
> much cleaner and should scale well overall, I think.

I think I also took a crack at this at one point while I was at UM/CITI
and never got anything I was happy with.  Looks like good work!

I remember one main obstacle that I felt like I never had a good
benchmark....

How did you choose this workload and hardware?  Was it in fact udev
(booting a large machine?), or was there some other motivation?

Not that I'm likely to do it any time soon, but could you share
sufficient details for someone else to reproduce your results?

--b.
