Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34556C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB1022419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB1022419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbeKMEL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:11:28 -0500
Received: from fieldses.org ([173.255.197.46]:45326 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbeKMEL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:11:28 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id C96A52014; Mon, 12 Nov 2018 13:17:05 -0500 (EST)
Date:   Mon, 12 Nov 2018 13:17:05 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12 v5] locks: avoid thundering-herd wake-ups
Message-ID: <20181112181705.GD16755@fieldses.org>
References: <154198490921.14364.13726904731989686092.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154198490921.14364.13726904731989686092.stgit@noble>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACK to the series.

It also passed my usual regression tests on top of 4.19.  (I still have
some unrelated problems to sort out on 4.20.)

--b.

On Mon, Nov 12, 2018 at 12:14:48PM +1100, NeilBrown wrote:
> Changes:
>  - field names improved as requested by Bruce.
>    "fl_blocked_requests" is a list of blocked requests,
>    linked through fl_block_member
>  - the introductory text has been moved to a commit comment
>    as suggested by Bruce
>  - documentation added to locks.c as suggested by Bruce - I made
>    a few little changes
>  - flock_make_lock() now properly initialized a lock - using
>    the code from Jeff
>  - code actually compiles for ocfs2 and gfs2
> 
> Thanks,
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
>  fs/cifs/file.c                  |    4 
>  fs/gfs2/file.c                  |   10 +
>  fs/lockd/svclock.c              |    2 
>  fs/locks.c                      |  319 ++++++++++++++++++++++++---------------
>  fs/nfs/nfs4proc.c               |    6 -
>  fs/nfsd/nfs4state.c             |    6 -
>  fs/ocfs2/locks.c                |   10 +
>  include/linux/fs.h              |   13 +-
>  include/trace/events/filelock.h |   16 +-
>  9 files changed, 230 insertions(+), 156 deletions(-)
> 
> --
> Signature
