Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeERMeV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 08:34:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750977AbeERMeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 08:34:18 -0400
From: Jeff Layton <jlayton@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, willy@infradead.org, andres@anarazel.de
Subject: [RFC PATCH 00/11] vfs: have syncfs return an error when inode writeback fails
Date: Fri, 18 May 2018 08:34:04 -0400
Message-Id: <20180518123415.28181-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

Currently, syncfs does not return errors when one of the inodes fails
to be written back. It will return errors based on the legacy AS_EIO
and AS_ENOSPC flags when syncing out the block device fails, but that's
not particularly helpful for filesystems that aren't backed by a
blockdev and more granular errors are often not caught.

At LSF/MM this year, we had a discussion about tracking writeback
errors on a per-sb basis to help remedy this. This patchset is an inital
foray into doing that:

The basic idea is to add a new errseq_t to struct super_block, and use
that to track writeback errors for the filesystem as a whole.

Because syncfs is not a common operation, it's not desirable to grow
struct file in order to house an errseq_t cursor for it. Willy's
suggestion was to reuse file->f_wb_err, but only when the file is opened
with O_PATH. fsync always returns an error on an O_PATH fd, so this
should be safe, and seems semantically sane, given that syncfs operates
on the whole filesystem.

The patchset starts by pushing the __sync_blockdev calls down into the
various sync_fs operations. It then plumbs in an extra errseq_t pointer
into the sync_fs ops, and the relevant callers. It then adds the new
errseq_t field to struct super_block, and adds the machinery to handle
syncfs on an O_PATH open correctly. Lastly, it has some filesystems
return stored writeback errors in sync_fs ops when they are passed a
non-NULL errseq_t pointer.

This is just a start (more filesystems will need similar patches to the
later ones in the pile). This all works vs. the fstests testcase I have.
I haven't submitted that testcase yet, as I want to get consensus about
the interface. Does it make sense to treat O_PATH opens specially like
this?

Another thing on the wishlist for this is to expose the per-sb errseq_t
via another interface so that applications could periodically check to
see whether there has been a writeback error without syncing out the
whole fs. This patch doesn't add that yet, but once sb->s_wb_err is in
place and tracking errors it should be simple to do (possibly via a new
generic filesystem ioctl).

Jeff Layton (11):
  vfs: push __sync_blockdev calls down into sync_fs routines
  vfs: add a new errseq_t pointer to sync_fs prototype
  vfs: add an errseq_t pointer to sync_filesystem
  vfs: add errseq_t pointer to __sync_filesystem
  fs: track per-sb writeback errors and report them to syncfs
  buffer: record blockdev write errors in super_block that backs them
  ext4: have sync_fs op report writeback errors when passed a since
    pointer
  xfs: have sync_fs op report writeback errors when passed a since
    pointer
  btrfs: have sync_fs op report writeback errors when passed a since
    pointer
  ext2: have sync_fs op report writeback errors when passed a since
    pointer
  vfs: have call_sync_fs op report writeback errors when passed a since
    pointer

 drivers/staging/ncpfs/inode.c |  2 +-
 fs/adfs/super.c               |  2 +-
 fs/affs/super.c               |  6 +++---
 fs/befs/linuxvfs.c            |  2 +-
 fs/block_dev.c                |  3 ++-
 fs/btrfs/ctree.h              |  2 +-
 fs/btrfs/ioctl.c              |  2 +-
 fs/btrfs/super.c              | 28 +++++++++++++++++++---------
 fs/buffer.c                   |  2 ++
 fs/cachefiles/interface.c     |  2 +-
 fs/ceph/super.c               |  2 +-
 fs/cifs/cifsfs.c              |  2 +-
 fs/coda/inode.c               |  2 +-
 fs/cramfs/inode.c             |  2 +-
 fs/debugfs/inode.c            |  2 +-
 fs/efs/super.c                |  2 +-
 fs/exofs/super.c              |  2 +-
 fs/ext2/super.c               | 19 +++++++++++++------
 fs/ext4/super.c               | 19 +++++++++++--------
 fs/f2fs/f2fs.h                |  2 +-
 fs/f2fs/file.c                |  6 +++---
 fs/f2fs/namei.c               | 16 ++++++++--------
 fs/f2fs/segment.c             |  2 +-
 fs/f2fs/super.c               | 19 +++++++++++--------
 fs/fat/inode.c                |  2 +-
 fs/freevxfs/vxfs_super.c      |  2 +-
 fs/fuse/inode.c               |  2 +-
 fs/gfs2/super.c               |  8 +++++---
 fs/hfs/super.c                |  6 +++---
 fs/hfsplus/super.c            | 10 +++++-----
 fs/hpfs/super.c               |  2 +-
 fs/internal.h                 |  7 -------
 fs/isofs/inode.c              |  2 +-
 fs/jffs2/super.c              |  4 ++--
 fs/jfs/super.c                |  7 +++----
 fs/minix/inode.c              |  2 +-
 fs/nfs/super.c                |  2 +-
 fs/nilfs2/super.c             |  9 +++++----
 fs/ntfs/super.c               |  2 +-
 fs/ocfs2/super.c              |  8 ++++----
 fs/open.c                     |  6 +++---
 fs/openpromfs/inode.c         |  2 +-
 fs/overlayfs/super.c          |  4 ++--
 fs/proc/root.c                |  2 +-
 fs/pstore/inode.c             |  2 +-
 fs/qnx4/inode.c               |  2 +-
 fs/qnx6/inode.c               |  2 +-
 fs/quota/dquot.c              | 11 ++++-------
 fs/reiserfs/super.c           |  8 ++++----
 fs/romfs/super.c              |  2 +-
 fs/squashfs/super.c           |  2 +-
 fs/super.c                    |  4 ++--
 fs/sync.c                     | 28 +++++++++++++++++-----------
 fs/sysv/inode.c               |  7 +++----
 fs/tracefs/inode.c            |  2 +-
 fs/ubifs/super.c              |  4 ++--
 fs/udf/super.c                |  6 +++---
 fs/ufs/super.c                |  6 +++---
 fs/xfs/xfs_super.c            | 18 +++++++++++++-----
 include/linux/fs.h            | 35 +++++++++++++++++++++++++++++++++--
 include/linux/pagemap.h       |  5 ++++-
 61 files changed, 223 insertions(+), 158 deletions(-)

-- 
2.17.0
