Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E05C46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 22:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7581B2170D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 22:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7581B2170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbeHMBWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 21:22:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34614 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbeHMBWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 21:22:42 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1foz4p-000253-EO; Sun, 12 Aug 2018 22:43:11 +0000
Date:   Sun, 12 Aug 2018 23:43:11 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] rework of open-related logics
Message-ID: <20180812224311.GM6515@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* "do we need fput() or put_filp()" rules are gone - it's always fput() now.
  We keep track of that state where it belongs - in ->f_mode.
* int *opened mess killed - in finish_open(), in ->atomic_open() instances
  and in fs/namei.c code around do_last()/lookup_open()/atomic_open().
* alloc_file() wrappers with saner calling conventions are introduced
  (alloc_file_clone() and alloc_file_pseudo()); callers converted, with
  much simplification.
* while we are at it, saner calling conventions for path_init() and
  link_path_walk(), simplifying things inside fs/namei.c (both on
  open-related paths and elsewhere).

The following changes since commit c7e9075fb89362812059fbf8e25bb4a6e825c4c5:

  ocxlflash_getfile(): fix double-iput() on alloc_file() failures (2018-07-10 23:29:03 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.open3

for you to fetch changes up to 5f336e722cc961be94d264d96b90c92888fffae1:

  few more cleanups of link_path_walk() callers (2018-07-12 10:04:31 -0400)

----------------------------------------------------------------
Al Viro (40):
      fold security_file_free() into file_free()
      turn filp_clone_open() into inline wrapper for dentry_open()
      create_pipe_files(): use fput() if allocation of the second file fails
      make sure do_dentry_open() won't return positive as an error
      alloc_file(): switch to passing O_... flags instead of FMODE_... mode
      pass creds to get_empty_filp(), make sure dentry_open() passes the right creds
      pass ->f_flags value to alloc_empty_file()
      get rid of cred argument of vfs_open() and do_dentry_open()
      security_file_open(): lose cred argument
      ->file_open(): lose cred argument
      introduce FMODE_OPENED
      fold put_filp() into fput()
      lift fput() on late failures into path_openat()
      now we can fold open_check_o_direct() into do_dentry_open()
      switch all remaining checks for FILE_OPENED to FMODE_OPENED
      introduce FMODE_CREATED and switch to it
      IMA: don't propagate opened through the entire thing
      getting rid of 'opened' argument of ->atomic_open() - part 1
      getting rid of 'opened' argument of ->atomic_open() - part 2
      get rid of 'opened' argument of ->atomic_open() - part 3
      get rid of 'opened' in path_openat() and the helpers downstream
      ->atomic_open(): return 0 in all success cases
      document ->atomic_open() changes
      switch atomic_open() and lookup_open() to returning 0 in all success cases
      kill FILE_{CREATED,OPENED}
      new wrapper: alloc_file_pseudo()
      __shmem_file_setup(): reorder allocations
      ... and switch shmem_file_setup() to alloc_file_pseudo()
      cxl_getfile(): switch to alloc_file_pseudo()
      ocxlflash_getfile(): switch to alloc_file_pseudo()
      hugetlb_file_setup(): switch to alloc_file_pseudo()
      anon_inode_getfile(): switch to alloc_file_pseudo()
      create_pipe_files(): switch the first allocation to alloc_file_pseudo()
      new helper: alloc_file_clone()
      do_shmat(): grab shp->shm_file earlier, switch to alloc_file_clone()
      make alloc_file() static
      document alloc_file() changes
      make path_init() unconditionally paired with terminate_walk()
      allow link_path_walk() to take ERR_PTR()
      few more cleanups of link_path_walk() callers

 Documentation/filesystems/Locking     |   2 +-
 Documentation/filesystems/porting     |  20 +++
 Documentation/filesystems/vfs.txt     |  18 +--
 drivers/gpu/drm/drm_lease.c           |   2 +-
 drivers/misc/cxl/api.c                |  22 +---
 drivers/scsi/cxlflash/ocxl_hw.c       |  24 +---
 fs/9p/vfs_inode.c                     |   7 +-
 fs/9p/vfs_inode_dotl.c                |   7 +-
 fs/aio.c                              |  24 +---
 fs/anon_inodes.c                      |  30 +----
 fs/bad_inode.c                        |   2 +-
 fs/binfmt_misc.c                      |   2 +-
 fs/ceph/file.c                        |   7 +-
 fs/ceph/super.h                       |   3 +-
 fs/cifs/cifsfs.h                      |   3 +-
 fs/cifs/dir.c                         |   7 +-
 fs/file_table.c                       |  85 +++++++++----
 fs/fuse/dir.c                         |  10 +-
 fs/gfs2/inode.c                       |  32 +++--
 fs/hugetlbfs/inode.c                  |  54 +++-----
 fs/internal.h                         |   5 +-
 fs/namei.c                            | 225 +++++++++++++---------------------
 fs/nfs/dir.c                          |  14 ++-
 fs/nfs/nfs4_fs.h                      |   2 +-
 fs/nfs/nfs4proc.c                     |   2 +-
 fs/nfsd/vfs.c                         |   2 +-
 fs/open.c                             |  88 ++++---------
 fs/pipe.c                             |  43 ++-----
 include/linux/file.h                  |   8 +-
 include/linux/fs.h                    |  17 +--
 include/linux/ima.h                   |   4 +-
 include/linux/lsm_hooks.h             |   2 +-
 include/linux/security.h              |   5 +-
 ipc/shm.c                             |  45 ++++---
 mm/memfd.c                            |   2 +-
 mm/shmem.c                            |  49 ++------
 net/socket.c                          |  29 +----
 security/apparmor/lsm.c               |   4 +-
 security/integrity/ima/ima.h          |   4 +-
 security/integrity/ima/ima_appraise.c |   4 +-
 security/integrity/ima/ima_main.c     |  16 +--
 security/security.c                   |   4 +-
 security/selinux/hooks.c              |   4 +-
 security/smack/smack_lsm.c            |   6 +-
 security/tomoyo/tomoyo.c              |   2 +-
 45 files changed, 371 insertions(+), 576 deletions(-)
