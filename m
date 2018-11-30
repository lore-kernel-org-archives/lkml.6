Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEBCC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20ECD20867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3wkE2Cm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20ECD20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeLADos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:44:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:60074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726644AbeLADos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:44:48 -0500
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EC0A20834;
        Fri, 30 Nov 2018 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543595696;
        bh=v2FxqJca3Z+KNMdmVfwbVCPIWiROhDIt8Settf2cpxY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=r3wkE2CmEkskCcrOa0FkJA/rlAZmZTSJXHwe6mq9pCb92Ldj5xedvuGJt09i6F9l5
         bkQN9qBK5Wb6JU+HbdjgeTxUJEIPk9iITh1AF0kbZoqeng2itfORG7cDJPOF6jRznQ
         U38SiIPM85Q520S/qx57+InxR7YQZOc2KZSOOYAA=
Message-ID: <9c1dee36eee07975ef4c07802a8bd0c8076878ef.camel@kernel.org>
Subject: Re: [PATCH 00/12 v6] fs/locks: avoid thundering-herd wake-ups
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 30 Nov 2018 11:34:54 -0500
In-Reply-To: <154353251599.32133.1085882002675619240.stgit@noble>
References: <154353251599.32133.1085882002675619240.stgit@noble>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-30 at 10:04 +1100, NeilBrown wrote:
> This series has the fixes for the recently reported performance
> regressions merged into the patches which caused them.
> It also has a couple of little fixes that have been mentioned on the
> list, and that Jeff had merged into his copy.
> 
> Thanks,
> NeilBrown
> 
> ---
> 
> NeilBrown (12):
>       fs/locks: rename some lists and pointers.
>       fs/locks: split out __locks_wake_up_blocks().
>       NFS: use locks_copy_lock() to copy locks.
>       gfs2: properly initial file_lock used for unlock.
>       ocfs2: properly initial file_lock used for unlock.
>       fs/locks: use properly initialized file_lock when unlocking.
>       fs/locks: allow a lock request to block other requests.
>       fs/locks: always delete_block after waiting.
>       fs/locks: change all *_conflict() functions to return bool.
>       fs/locks: create a tree of dependent requests.
>       fs/locks: merge posix_unblock_lock() and locks_delete_block()
>       fs/locks: locks: remove unnecessary white space.
> 
> 
>  fs/cifs/file.c                  |    4 
>  fs/gfs2/file.c                  |   10 +
>  fs/lockd/svclock.c              |    2 
>  fs/locks.c                      |  342 +++++++++++++++++++++++++--------------
>  fs/nfs/nfs4proc.c               |    6 -
>  fs/nfsd/nfs4state.c             |    6 -
>  fs/ocfs2/locks.c                |   10 +
>  include/linux/fs.h              |   13 +
>  include/trace/events/filelock.h |   16 +-
>  9 files changed, 252 insertions(+), 157 deletions(-)
> 
> --
> Signature
> 

Thanks Neil,

This looks great. I've gone ahead and replaced the set in locks-next
with this one. Unless we hear of any other problems, I'll plan to send a
PR to Linus when the merge window opens.

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>

