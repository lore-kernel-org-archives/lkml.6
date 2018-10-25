Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E183ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A27B2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A27B2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieldses.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbeJZAh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:37:26 -0400
Received: from fieldses.org ([173.255.197.46]:47308 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727400AbeJZAhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:37:25 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 1A6F71E3D; Thu, 25 Oct 2018 12:04:01 -0400 (EDT)
Date:   Thu, 25 Oct 2018 12:04:01 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9 v3] locks: avoid thundering-herd wake-ups
Message-ID: <20181025160401.GB5539@fieldses.org>
References: <154033435272.29542.13985568983074440924.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154033435272.29542.13985568983074440924.stgit@noble>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 09:43:54AM +1100, NeilBrown wrote:
> This took longer that I had wanted, due to various reasons - sorry.
> And I'm now posting it in a merge window, which is not ideal.  I don't
> expect it to be included in this merge window and I won't be at all
> impatient for review, but I didn't want to delay it further.

Yes, apologies, I've been looking forward to finding out how this turned
out, but I'd like to track down a bug or two and also review Olga's copy
patches....  Bug me if I haven't gotten to this in a week or two.

I'd also be really interested in any details of the performance
experiments that you could share.

--b.

> 
> Testing found some problems, particularly the need to use
> locks_copy_lock in NFS.  And there was a small thinko in there that
> effectively removed all the speed gains :-(
> 
> But this version:
>  - shows excellent scalability with lots of threads on lots of CPUs
>    contending on a single file
>  - avoids the problems that Bruce found
>  - seems to work.
> 
> Thanks,
> NeilBrown
> 
> 
> ---
> 
> NeilBrown (9):
>       fs/locks: rename some lists and pointers.
>       fs/locks: split out __locks_wake_up_blocks().
>       NFS: use locks_copy_lock() to copy locks.
>       fs/locks: allow a lock request to block other requests.
>       fs/locks: always delete_block after waiting.
>       fs/locks: change all *_conflict() functions to return bool.
>       fs/locks: create a tree of dependent requests.
>       locks: merge posix_unblock_lock() and locks_delete_block()
>       VFS: locks: remove unnecessary white space.
> 
> 
>  fs/cifs/file.c                  |    4 -
>  fs/lockd/svclock.c              |    2 
>  fs/locks.c                      |  231 ++++++++++++++++++++++-----------------
>  fs/nfs/nfs4proc.c               |    6 +
>  fs/nfsd/nfs4state.c             |    6 +
>  include/linux/fs.h              |   11 +-
>  include/trace/events/filelock.h |   16 +--
>  7 files changed, 153 insertions(+), 123 deletions(-)
> 
> --
> Signature
