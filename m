Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69429C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D74F2173A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 20:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D74F2173A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeHTXTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 19:19:21 -0400
Received: from fieldses.org ([173.255.197.46]:45016 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbeHTXTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 19:19:21 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 322C0189; Mon, 20 Aug 2018 16:02:23 -0400 (EDT)
Date:   Mon, 20 Aug 2018 16:02:23 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Martin Wilck <mwilck@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] locks: avoid thundering-herd wake-ups
Message-ID: <20180820200223.GG5468@fieldses.org>
References: <153369219467.12605.13472423449508444601.stgit@noble>
 <ea503e6a6f26dfb344fda02c765ae87de65ed025.camel@kernel.org>
 <20180808182959.GB23873@fieldses.org>
 <c9e11a27fd6cf3e7a80045ba545ae25c19b6ff76.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9e11a27fd6cf3e7a80045ba545ae25c19b6ff76.camel@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 01:02:21PM +0200, Martin Wilck wrote:
> On Wed, 2018-08-08 at 14:29 -0400, J. Bruce Fields wrote:
> > On Wed, Aug 08, 2018 at 12:47:22PM -0400, Jeff Layton wrote:
> > > On Wed, 2018-08-08 at 11:51 +1000, NeilBrown wrote:
> > > > If you have a many-core machine, and have many threads all
> > > > wanting to
> > > > briefly lock a give file (udev is known to do this), you can get
> > > > quite
> > > > poor performance.
> > > > 
> > > > When one thread releases a lock, it wakes up all other threads
> > > > that
> > > > are waiting (classic thundering-herd) - one will get the lock and
> > > > the
> > > > others go to sleep.
> > > > When you have few cores, this is not very noticeable: by the time
> > > > the
> > > > 4th or 5th thread gets enough CPU time to try to claim the lock,
> > > > the
> > > > earlier threads have claimed it, done what was needed, and
> > > > released.
> > > > With 50+ cores, the contention can easily be measured.
> > > > 
> > > > This patchset creates a tree of pending lock request in which
> > > > siblings
> > > > don't conflict and each lock request does conflict with its
> > > > parent.
> > > > When a lock is released, only requests which don't conflict with
> > > > each
> > > > other a woken.
> > > > 
> > > > Testing shows that lock-acquisitions-per-second is now fairly
> > > > stable even
> > > > as number of contending process goes to 1000.  Without this
> > > > patch,
> > > > locks-per-second drops off steeply after a few 10s of processes.
> > > > 
> > > > There is a small cost to this extra complexity.
> > > > At 20 processes running a particular test on 72 cores, the lock
> > > > acquisitions per second drops from 1.8 million to 1.4 million
> > > > with
> > > > this patch.  For 100 processes, this patch still provides 1.4
> > > > million
> > > > while without this patch there are about 700,000.
> > > > 
> > > > NeilBrown
> > > > 
> > > > ---
> > > > 
> > > > NeilBrown (4):
> > > >       fs/locks: rename some lists and pointers.
> > > >       fs/locks: allow a lock request to block other requests.
> > > >       fs/locks: change all *_conflict() functions to return bool.
> > > >       fs/locks: create a tree of dependent requests.
> > > > 
> > > > 
> > > >  fs/cifs/file.c                  |    2 -
> > > >  fs/locks.c                      |  142
> > > > +++++++++++++++++++++++++--------------
> > > >  include/linux/fs.h              |    5 +
> > > >  include/trace/events/filelock.h |   16 ++--
> > > >  4 files changed, 103 insertions(+), 62 deletions(-)
> > > > 
> > > 
> > > Nice work! I looked over this and I think it looks good.
> > > 
> > > I made an attempt to fix this issue several years ago, but my
> > > method
> > > sucked as it ended up penalizing the unlocking task too much. This
> > > is
> > > much cleaner and should scale well overall, I think.
> > 
> > I think I also took a crack at this at one point while I was at
> > UM/CITI
> > and never got anything I was happy with.  Looks like good work!
> > 
> > I remember one main obstacle that I felt like I never had a good
> > benchmark....
> > 
> > How did you choose this workload and hardware?  Was it in fact udev
> > (booting a large machine?), or was there some other motivation?
> 
> Some details can be found here:
> 
> https://github.com/systemd/systemd/pull/9551
> 
> https://github.com/systemd/systemd/pull/8667#issuecomment-385520335
> and comments further down. 8667 has been superseded by 9551.
> 
> The original problem was that the symlink "/dev/disk/by-
> partlabel/primary" may be claimed by _many_ devices on big systems
> under certain distributions, which use older versions of parted for
> partition creation on GPT disk labels. I've seen systems with literally
> thousands of contenders for this symlink. 
> 
> We found that with current systemd, this can cause a boot-time race
> where the wrong device is eventually assigned the "best" contender for
> the symlink (e.g. a partition on multipath member rather than a
> partition on the multipath map itself). I extended the udev test suite,
> creating a test that makes this race easily reproducible, at least on
> systems with many CPUs (the test host I used most had 72 cores).
> 
> I created an udev patch that would use systemd's built in fcntl-based
> locking to avoid this race, but I found that it would massively slow
> down the system, and found the contention to be in the spin locks in
> posix_lock_common(). (I therefore added more the systemd patches to
> make the locking scale better, but that's irrelevant for the kernel-
> side discussion).
> 
> I further created an artificial test just for the scaling of
> fcntl(F_OFD_SETLKW) and flock(), with which I could reproduce the
> scaling problem easily, and do some quantitive experiments. My tests
> didn't use any byte ranges, only "full" locking of 0-byte files.

Thanks for the explanation!

I wonder whether there's also anything we could do to keep every waiter
from having to take the same spinlock.

--b.

> 
> > Not that I'm likely to do it any time soon, but could you share
> > sufficient details for someone else to reproduce your results?
> > 
> > --b.
> 
> The udev test code can be found in the above links. It adds a new
> script "test/sd-script.py" that would be run after "test/sys-script.py" 
> using a numeric argument indicating the number of contenders for the
> test link to be created, such as "python test/sd-script.py test 1000".
> Next step would be running "test/udev-test.pl 152" e.g. under perf (152
> is the test ID of the scaling test).
> 
> Of course I can also share my other test program if you desire so.
