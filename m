Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694B2ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E50420825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E50420825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeKIHMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:12:49 -0500
Received: from fieldses.org ([173.255.197.46]:39180 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbeKIHMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:12:49 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 60FD22014; Thu,  8 Nov 2018 16:35:26 -0500 (EST)
Date:   Thu, 8 Nov 2018 16:35:26 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] Series short description
Message-ID: <20181108213526.GG6090@fieldses.org>
References: <154138128401.31651.1381177427603557514.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154138128401.31651.1381177427603557514.stgit@noble>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 12:30:47PM +1100, NeilBrown wrote:
> Here is the respin on this series with the file_lock properly
> initlized for unlock requests.
> I found one that I had missed before - in locks_remove_flock()
> The change makes this code smaller!
> 
> Original series description:
> 
> If you have a many-core machine, and have many threads all wanting to
> briefly lock a give file (udev is known to do this), you can get quite
> poor performance.
> 
> When one thread releases a lock, it wakes up all other threads that
> are waiting (classic thundering-herd) - one will get the lock and the
> others go to sleep.
> When you have few cores, this is not very noticeable: by the time the
> 4th or 5th thread gets enough CPU time to try to claim the lock, the
> earlier threads have claimed it, done what was needed, and released.
> With 50+ cores, the contention can easily be measured.
> 
> This patchset creates a tree of pending lock request in which siblings
> don't conflict and each lock request does conflict with its parent.
> When a lock is released, only requests which don't conflict with each
> other a woken.
> 
> Testing shows that lock-acquisitions-per-second is now fairly stable even
> as number of contending process goes to 1000.  Without this patch,
> locks-per-second drops off steeply after a few 10s of processes.
> 
> There is a small cost to this extra complexity.
> At 20 processes running a particular test on 72 cores, the lock
> acquisitions per second drops from 1.8 million to 1.4 million with
> this patch.  For 100 processes, this patch still provides 1.4 million
> while without this patch there are about 700,000.

These details are all really useful motivation for the patches.  It'd be
nice to have them in the permanent record somehow.  Maybe just merge it
into the changelog on "fs/locks: create a tree of dependent requests."?

--b.

> 
> NeilBrown
> 
> 
> ---
> 
> NeilBrown (12):
>       fs/locks: rename some lists and pointers.
>       fs/locks: split out __locks_wake_up_blocks().
>       NFS: use locks_copy_lock() to copy locks.
>       gfs2: properly initial file_lock used for unlock.
>       ocfs2: properly initial file_lock used for unlock.
>       locks: use properly initialized file_lock when unlocking.
>       fs/locks: allow a lock request to block other requests.
>       fs/locks: always delete_block after waiting.
>       fs/locks: change all *_conflict() functions to return bool.
>       fs/locks: create a tree of dependent requests.
>       locks: merge posix_unblock_lock() and locks_delete_block()
>       VFS: locks: remove unnecessary white space.
> 
> 
>  fs/cifs/file.c                  |    4 -
>  fs/gfs2/file.c                  |   10 +-
>  fs/lockd/svclock.c              |    2 
>  fs/locks.c                      |  253 +++++++++++++++++++++------------------
>  fs/nfs/nfs4proc.c               |    6 +
>  fs/nfsd/nfs4state.c             |    6 -
>  fs/ocfs2/locks.c                |   10 +-
>  include/linux/fs.h              |   11 +-
>  include/trace/events/filelock.h |   16 +-
>  9 files changed, 173 insertions(+), 145 deletions(-)
> 
> --
> Signature
