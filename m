Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1B3C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D957F208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 04:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D957F208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754088AbeGIExY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 00:53:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37998 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbeGIExW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 00:53:22 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fcOAq-0003aJ-SC; Mon, 09 Jul 2018 04:53:20 +0000
Date:   Mon, 9 Jul 2018 05:53:20 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCHES] open()-related cleanups
Message-ID: <20180709045320.GF30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	This is an update of open()-related work last posted a month
ago.  Series lives in vfs.git#work.open (and its beginning is in
#fixes).  Individual patches are in followups, shortlog (with outlines)
follows:
1) some prep fixes:
	* drm_lease.c uses alloc_file() for no good reason - it's
open-coding filp_clone_open() and gets failure handling wrong; failing
->open() should *not* be followed by fput().  Use the real thing instead.
	* cxl_getfile() also buggers failure exits around alloc_file() -
it follows path_put() with iput(), resulting in double iput()
	* ocxlflash_getfile(): same story.

      drm_mode_create_lease_ioctl(): fix open-coded filp_clone_open()
      cxl_getfile(): fix double-iput() on alloc_file() failures
      ocxlflash_getfile(): fix double-iput() on alloc_file() failures

2) We want saner rules for put_filp()/fput() logics.  At some point in
struct file lifecycle it switches from 'clean the things up manually and
do put_filp()' to 'just use fput() from now on'.  Choosing the right one
during the open (especially when ->atomic_open() is involved) is painful
and convoluted.  Things become much simpler if we use struct file itself
to carry that information.
	* make it provable that do_dentry_open() is never called on the
same struct file twice.  That's certainly what we intended all along;
the problems could happen if bogus ->open() returned *positive* for an
error.  That could confuse the living hell out of atomic_open() and friends;
make sure it won't happen.
	* mark the 'should we just use fput() from now on' in ->f_mode.
	* don't pass 'opened' to ->atomic_open()/finish_open(); make the
(very few) callers pick the information we would've passed via
*opened & FILE_OPENED from file->f_mode & FMODE_OPENED instead.
	* massage path_openat() and the helpers it calls, consolidate all
fput()-causing failure handling into path_openat() itself and switch all
checks to FMODE_OPENED.

      make sure do_dentry_open() won't return positive as an error
      introduce FMODE_OPENED
      get rid of 'opened' argument of finish_open()
      lift fput() on late failures into path_openat()
      switch all remaining checks for FILE_OPENED to FMODE_OPENED

3) first payoff: now we can fold open_check_o_direct() into do_dentry_open().
The problem with doing that had been exactly in fput()/put_filp() rules -
we relied upon "failures without do_dentry_open() ever called => put_filp(),
failure after do_dentry_open() succeeded => fput(), failure in do_dentry_open()
itself => put_filp()" (and heaven help us to keep track which case had it
been).  O_DIRECT checks are done past the point where we need fput() and
doing those in do_dentry_open() would've made for "failure in do_dentry_open()
means put_filp(), except when it's a late failure, in which case we want
fput()", without any way for caller of do_dentry_open() to tell which one
it is.  With FMODE_OPENED we *can* tell.

      now we can fold open_check_o_direct() into do_dentry_open()

4) ->atomic_open() and friends are passing two bits of state ("did we get past
opening it" and "did we create it") in a very ugly way - pointer to int
('opened') is passed as an argument, and the variable it points to is used
to store those two bits.  We are not far from getting rid of it for good -
one bit (FILE_OPENED) is already replaced with ->f_mode & FMODE_OPENED and 
and we can use ->f_mode to get rid of FILE_CREATED as well.
	* introduce FMODE_CREATED, set it to parallel *opened & FILE_CREATED
	* get rid of FILE_CREATED in checks
	* get rid of now unused 'opened' in ->atomic_open() and its callers
	* kill now unused FILE_{OPENED,CREATED}

      introduce FMODE_CREATED and switch to it
      IMA: don't propagate opened through the entire thing
      Preparation to killing ->atomic_open() 'opened' argument.
      get rid of 'opened' argument of ->atomic_open()
      get rid of 'opened' in path_openat() and the helpers downstream
      kill FILE_{CREATED,OPENED}

5) sort alloc_file() callers out.  Calling conventions, especially wrt cleanups
on failure, are convoluted (and easy to get wrong).  Callers fall into two
classes and we'd be better off with a couple of wrappers suited for those.
	* introduce alloc_file_pseudo(), convert to its use
	* introduce alloc_file_clone(), convert to its use
	* make alloc_file() itself static

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

6) turn filp_clone_open() into a wrapper for dentry_open(), rename it to
file_clone_open().

      turn filp_clone_open() into inline wrapper for dentry_open()

Diffstat:
 arch/ia64/kernel/perfmon.c            |  1 +
 drivers/gpu/drm/drm_lease.c           | 16 +------
 drivers/misc/cxl/api.c                | 21 ++-------
 drivers/scsi/cxlflash/ocxl_hw.c       | 24 ++--------
 fs/9p/vfs_inode.c                     |  7 ++-
 fs/9p/vfs_inode_dotl.c                |  7 ++-
 fs/aio.c                              | 26 +++--------
 fs/anon_inodes.c                      | 29 +++----------
 fs/bad_inode.c                        |  2 +-
 fs/binfmt_misc.c                      |  2 +-
 fs/ceph/file.c                        |  7 ++-
 fs/ceph/super.h                       |  3 +-
 fs/cifs/cifsfs.h                      |  3 +-
 fs/cifs/dir.c                         |  7 ++-
 fs/file_table.c                       | 41 +++++++++++++++++-
 fs/fuse/dir.c                         | 10 ++---
 fs/gfs2/inode.c                       | 32 +++++++-------
 fs/hugetlbfs/inode.c                  | 55 ++++++++---------------
 fs/internal.h                         |  2 -
 fs/namei.c                            | 82 ++++++++++++++---------------------
 fs/nfs/dir.c                          | 14 +++---
 fs/nfs/nfs4_fs.h                      |  2 +-
 fs/nfs/nfs4proc.c                     |  2 +-
 fs/nfsd/vfs.c                         |  2 +-
 fs/open.c                             | 68 ++++++++---------------------
 fs/pipe.c                             | 38 ++++------------
 include/linux/file.h                  |  7 ++-
 include/linux/fs.h                    | 17 +++++---
 include/linux/ima.h                   |  4 +-
 ipc/shm.c                             | 39 ++++++++---------
 mm/shmem.c                            | 50 +++++----------------
 net/socket.c                          | 27 ++----------
 security/integrity/ima/ima.h          |  4 +-
 security/integrity/ima/ima_appraise.c |  4 +-
 security/integrity/ima/ima_main.c     | 16 +++----
 35 files changed, 247 insertions(+), 423 deletions(-)

Please, review:
