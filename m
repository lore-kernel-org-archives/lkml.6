Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9WlnG5LPGlu6AgAAmS7hNA
	; Fri, 08 Jun 2018 18:48:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5B237607DC; Fri,  8 Jun 2018 18:48:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 53C30601D2;
	Fri,  8 Jun 2018 18:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 53C30601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeFHSsp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:48:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53738 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752357AbeFHSso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:48:44 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fRMRG-0006Ia-KT; Fri, 08 Jun 2018 18:48:42 +0000
Date: Fri, 8 Jun 2018 19:48:42 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCHES] getting rid of int *open in ->atomic_open() and
 friends
Message-ID: <20180608184842.GD30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	->atomic_open() calling conventions are nasty; we have
two bits of state ("has file gotten past ->open()" and "have
we created a new file here") passed by reference, with rather
brittle logics in the callers.  In some error cases do_last()
et.al.  end up doing a full-blow fput() (and destroying the
struct file they've got), in some they leave that work (a
trimmed-down subset of it, at that) to path_openat(), with
the aforementioned state affecting what's going on.

	It would be much easier if we stored the "has the
damn thing been past ->open()" (i.e. does it need fput()
or put_filp()) in file->f_mode.  It doesn't take a lot
of massage to do that - mostly it's a matter of leaving
all struct file freeing in error cases to path_openat()
itself and preventing the wipeout of all ->f_mode bits
in do_dentry_open().  Moreover, we can store the "has it
been created" in the same ->f_mode, killing the 'int *opened'
mess completely.  The same series gets O_DIRECT checks
properly centralized in do_dentry_open(), BTW.

	Other fun stuff possible (but not done yet) is
unification of put_filp() and fput() and hopefully more
simple rules regarding those.  Need to sort out some
things about pipe and ia64 perfmon first, though...

	It's still a work-in-progress; what I've got right
now is in vfs.git#work.open;

current shortlog:
Al Viro (13):
      drm_mode_create_lease_ioctl(): switch to filp_clone_open()
      rename filp_clone_open() to file_clone_open()
      introduce FMODE_OPENED
      get rid of 'opened' argument of finish_open()
      pull fput() on late failures into path_openat()
      switch all remaining checks for FILE_OPENED to FMODE_OPENED
      now we can fold open_check_o_direct() into do_dentry_open()
      __gfs2_lookup(), nfs_finish_open() and fuse_create_open() don't need 'opened'
      introduce FMODE_CREATED and switch to it
      IMA: don't propagate opened through the entire thing
      gfs2_create_inode() doesn't need 'opened' anymore
      get rid of 'opened' argument of ->atomic_open()
      get rid of 'opened' in path_openat() and the helpers downstream
diffstat:
 arch/ia64/kernel/perfmon.c                  |  1 +
 drivers/gpu/drm/drm_lease.c                 | 16 +-------------
 drivers/misc/cxl/api.c                      |  2 +-
 drivers/staging/lustre/lustre/llite/namei.c | 11 +++++-----
 fs/9p/vfs_inode.c                           |  7 +++---
 fs/9p/vfs_inode_dotl.c                      |  7 +++---
 fs/aio.c                                    |  3 ++-
 fs/anon_inodes.c                            |  2 +-
 fs/bad_inode.c                              |  2 +-
 fs/binfmt_misc.c                            |  2 +-
 fs/ceph/file.c                              |  7 +++---
 fs/ceph/super.h                             |  3 +--
 fs/cifs/cifsfs.h                            |  3 +--
 fs/cifs/dir.c                               |  7 +++---
 fs/fuse/dir.c                               | 10 ++++-----
 fs/gfs2/inode.c                             | 32 +++++++++++++--------------
 fs/hugetlbfs/inode.c                        |  2 +-
 fs/internal.h                               |  2 --
 fs/namei.c                                  | 82 ++++++++++++++++++++++++++++------------------------------------------
 fs/nfs/dir.c                                | 14 ++++++------
 fs/nfs/nfs4_fs.h                            |  2 +-
 fs/nfs/nfs4proc.c                           |  2 +-
 fs/nfsd/vfs.c                               |  2 +-
 fs/open.c                                   | 48 +++++++++++++++--------------------------
 fs/pipe.c                                   |  2 ++
 include/linux/fs.h                          | 10 ++++++---
 include/linux/ima.h                         |  4 ++--
 ipc/shm.c                                   |  2 +-
 mm/shmem.c                                  |  2 +-
 net/socket.c                                |  2 +-
 security/integrity/ima/ima.h                |  4 ++--
 security/integrity/ima/ima_appraise.c       |  4 ++--
 security/integrity/ima/ima_main.c           | 16 +++++++-------
 33 files changed, 135 insertions(+), 180 deletions(-)

and it's been only slightly build-tested.  Review and comments
would be welcome.
