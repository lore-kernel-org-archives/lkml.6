Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3230C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841072245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcKJI7c0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 841072245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbeKMUkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:40:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:42718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732104AbeKMUkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:40:53 -0500
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9969B22419;
        Tue, 13 Nov 2018 10:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542105801;
        bh=syzH+GoLCOO7VABA4SDXGqQQBuf8EmxRqfaEMhz1CHs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NcKJI7c0Jm9PHHQ2o/a1/Xm7t2m6a1R+OMEoxu+zAT6Dt9rk5YvpIHV3X8glrNugC
         G0U3oP2BIccuEQZpKswzkRmTatwp8XfS7yaOY5RYoe99dKuQdDhBQ4EG1SqqPEmIzR
         NUDKpDYu4WVo4HRiu1Vjwm4j+ms8p50Jy520iG18=
Message-ID: <d95861372835a647d1ed09a9eaed20b8172062a5.camel@kernel.org>
Subject: Re: [PATCH 00/12 v5] locks: avoid thundering-herd wake-ups
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 13 Nov 2018 05:43:19 -0500
In-Reply-To: <154198490921.14364.13726904731989686092.stgit@noble>
References: <154198490921.14364.13726904731989686092.stgit@noble>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-12 at 12:14 +1100, NeilBrown wrote:
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
> 

Thanks Neil,

I'll pull this into locks-next. I also went ahead and fixed up the
comment that Bruce pointed out.
-- 
Jeff Layton <jlayton@kernel.org>

