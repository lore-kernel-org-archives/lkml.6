Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649C2C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E4C2148E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E4C2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbeK3KNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:13:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:36748 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbeK3KNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:13:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9BA59AC66;
        Thu, 29 Nov 2018 23:05:51 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>
Date:   Fri, 30 Nov 2018 10:04:08 +1100
Subject: [PATCH 00/12 v6] fs/locks: avoid thundering-herd wake-ups
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Message-ID: <154353251599.32133.1085882002675619240.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series has the fixes for the recently reported performance
regressions merged into the patches which caused them.
It also has a couple of little fixes that have been mentioned on the
list, and that Jeff had merged into his copy.

Thanks,
NeilBrown

---

NeilBrown (12):
      fs/locks: rename some lists and pointers.
      fs/locks: split out __locks_wake_up_blocks().
      NFS: use locks_copy_lock() to copy locks.
      gfs2: properly initial file_lock used for unlock.
      ocfs2: properly initial file_lock used for unlock.
      fs/locks: use properly initialized file_lock when unlocking.
      fs/locks: allow a lock request to block other requests.
      fs/locks: always delete_block after waiting.
      fs/locks: change all *_conflict() functions to return bool.
      fs/locks: create a tree of dependent requests.
      fs/locks: merge posix_unblock_lock() and locks_delete_block()
      fs/locks: locks: remove unnecessary white space.


 fs/cifs/file.c                  |    4 
 fs/gfs2/file.c                  |   10 +
 fs/lockd/svclock.c              |    2 
 fs/locks.c                      |  342 +++++++++++++++++++++++++--------------
 fs/nfs/nfs4proc.c               |    6 -
 fs/nfsd/nfs4state.c             |    6 -
 fs/ocfs2/locks.c                |   10 +
 include/linux/fs.h              |   13 +
 include/trace/events/filelock.h |   16 +-
 9 files changed, 252 insertions(+), 157 deletions(-)

--
Signature

