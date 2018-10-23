Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA9DC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D5120671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D5120671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbeJXHLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 03:11:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:36228 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbeJXHLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 03:11:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 012D5AEAD;
        Tue, 23 Oct 2018 22:45:35 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Wed, 24 Oct 2018 09:43:54 +1100
Subject: [PATCH 0/9 v3] locks: avoid thundering-herd wake-ups
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Message-ID: <154033435272.29542.13985568983074440924.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This took longer that I had wanted, due to various reasons - sorry.
And I'm now posting it in a merge window, which is not ideal.  I don't
expect it to be included in this merge window and I won't be at all
impatient for review, but I didn't want to delay it further.

Testing found some problems, particularly the need to use
locks_copy_lock in NFS.  And there was a small thinko in there that
effectively removed all the speed gains :-(

But this version:
 - shows excellent scalability with lots of threads on lots of CPUs
   contending on a single file
 - avoids the problems that Bruce found
 - seems to work.

Thanks,
NeilBrown


---

NeilBrown (9):
      fs/locks: rename some lists and pointers.
      fs/locks: split out __locks_wake_up_blocks().
      NFS: use locks_copy_lock() to copy locks.
      fs/locks: allow a lock request to block other requests.
      fs/locks: always delete_block after waiting.
      fs/locks: change all *_conflict() functions to return bool.
      fs/locks: create a tree of dependent requests.
      locks: merge posix_unblock_lock() and locks_delete_block()
      VFS: locks: remove unnecessary white space.


 fs/cifs/file.c                  |    4 -
 fs/lockd/svclock.c              |    2 
 fs/locks.c                      |  231 ++++++++++++++++++++++-----------------
 fs/nfs/nfs4proc.c               |    6 +
 fs/nfsd/nfs4state.c             |    6 +
 include/linux/fs.h              |   11 +-
 include/trace/events/filelock.h |   16 +--
 7 files changed, 153 insertions(+), 123 deletions(-)

--
Signature

