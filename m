Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DDEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71EE32087F
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71EE32087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbeKLLH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:07:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:56656 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729519AbeKLLHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 06:07:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A42BCADE3;
        Mon, 12 Nov 2018 01:16:42 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 12 Nov 2018 12:14:48 +1100
Subject: [PATCH 00/12 v5] locks: avoid thundering-herd wake-ups
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Message-ID: <154198490921.14364.13726904731989686092.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes:
 - field names improved as requested by Bruce.
   "fl_blocked_requests" is a list of blocked requests,
   linked through fl_block_member
 - the introductory text has been moved to a commit comment
   as suggested by Bruce
 - documentation added to locks.c as suggested by Bruce - I made
   a few little changes
 - flock_make_lock() now properly initialized a lock - using
   the code from Jeff
 - code actually compiles for ocfs2 and gfs2

Thanks,
NeilBrown


---

NeilBrown (12):
      fs/locks: rename some lists and pointers.
      fs/locks: split out __locks_wake_up_blocks().
      NFS: use locks_copy_lock() to copy locks.
      gfs2: properly initial file_lock used for unlock.
      ocfs2: properly initial file_lock used for unlock.
      locks: use properly initialized file_lock when unlocking.
      fs/locks: allow a lock request to block other requests.
      fs/locks: always delete_block after waiting.
      fs/locks: change all *_conflict() functions to return bool.
      fs/locks: create a tree of dependent requests.
      locks: merge posix_unblock_lock() and locks_delete_block()
      VFS: locks: remove unnecessary white space.


 fs/cifs/file.c                  |    4 
 fs/gfs2/file.c                  |   10 +
 fs/lockd/svclock.c              |    2 
 fs/locks.c                      |  319 ++++++++++++++++++++++++---------------
 fs/nfs/nfs4proc.c               |    6 -
 fs/nfsd/nfs4state.c             |    6 -
 fs/ocfs2/locks.c                |   10 +
 include/linux/fs.h              |   13 +-
 include/trace/events/filelock.h |   16 +-
 9 files changed, 230 insertions(+), 156 deletions(-)

--
Signature

