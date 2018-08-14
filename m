Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C539C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF5D21728
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJ9rs1aH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF5D21728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbeHNWBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 18:01:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbeHNWBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 18:01:11 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E734F21717;
        Tue, 14 Aug 2018 19:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534273953;
        bh=9vhuO+FsWeTDPLcMHzOd3kBiADJxFey5m1rKRTH+Xz0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bJ9rs1aHUPEOxkHY4aLL11k9gp2Q+NL6Q11qfQO33jONOUIu1iuxyY6ZmUput2Fk/
         i+K1vnTZRRe5iNxgQ1M5GrrNZplzQdXWpyBM8BC2126iKzHbRiCSv55U8L8Qo0VrLq
         dUqT97dSiF0tHpATfIfthxF9DhAQwb5m0ajWh8nA=
Message-ID: <4afedd921922253224fd54d1e88acb3f40da4ef7.camel@kernel.org>
Subject: Re: [PATCH 0/5 v2] locks: avoid thundering-herd wake-ups
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        NeilBrown <neilb@suse.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 14 Aug 2018 15:12:31 -0400
In-Reply-To: <20180814184146.GM7906@fieldses.org>
References: <153421852728.24426.2111161640156686201.stgit@noble>
         <20180814184146.GM7906@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-14 at 14:41 -0400, J. Bruce Fields wrote:
> This version looks correct to me, and simpler.  I'll be curious to hear
> whatever you learn from testing!
> 
> --b.
> 

Agreed. I'll go ahead and put this in linux-next with an eye toward
merging in v4.20 if we don't hit any major problems with it.

Thanks again and nice work, Neil!

> On Tue, Aug 14, 2018 at 01:56:51PM +1000, NeilBrown wrote:
> > 
> > V2, which added wake_non_conflicts() was more broken than V1 - as
> > Bruce explained there is no transitivity in the blocking relation
> > between locks.
> > So this series takes a simpler approach.
> > It still attached waiters between other waiters as necessary to ensure
> > that:
> >   - a waiter is blocked by it's parent (fl->blocker) and all further
> >     ancestors, and
> >   - the list of waiters on fl_blocked are mutually non-conflicting.
> > 
> > When a lock (the root of a tree of requests) is released, only its
> > immediate children (fl_blocked) are woken.
> > When any lock is woken (either because its fl_blocker was released
> > to due to a signal or similar) it with either:
> >  - be granted
> >  - be aborted
> >  - be re-queued beneath some other lock.
> > 
> > In the first case tree of blocked locks is moved across to the newly
> > created lock, and the invariants still hold.
> > In the order two cases, the tree or blocked waiters are all detached
> > and woken.
> > 
> > Note that this series has not received much testing yet.
> > 
> > Original description:
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
> > NeilBrown (5):
> >       fs/locks: rename some lists and pointers.
> >       fs/locks: split out __locks_wake_up_blocks().
> >       fs/locks: allow a lock request to block other requests.
> >       fs/locks: change all *_conflict() functions to return bool.
> >       fs/locks: create a tree of dependent requests.
> > 
> > 
> >  fs/cifs/file.c                  |    2 -
> >  fs/locks.c                      |  156 ++++++++++++++++++++++++++-------------
> >  include/linux/fs.h              |    7 +-
> >  include/trace/events/filelock.h |   16 ++--
> >  4 files changed, 119 insertions(+), 62 deletions(-)
> > 
> > --
> > Signature

-- 
Jeff Layton <jlayton@kernel.org>

