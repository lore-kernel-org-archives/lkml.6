Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754772AbeEaL3v (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:29:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754568AbeEaL3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:29:48 -0400
From: Jeff Layton <jlayton@kernel.org>
To: viro@ZenIV.linux.org.uk
Cc: willy@infradead.org, andres@anarazel.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, cmaiolino@redhat.com
Subject: [PATCH v2 0/5] vfs: allow syncfs to return an error when inode writeback fails
Date: Thu, 31 May 2018 07:29:40 -0400
Message-Id: <20180531112945.8629-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

v2: don't modify sync_fs op prototype, handle errors at vfs layer

The syncfs system call returns an int error code, but in general it does
not return errors when an inode fails writeback. It will return an error
if __sync_blockdev fails, but that's not useful on non-block based
filesystems and is generally not useful on more modern filesystems that
don't rely on that call.

This patchset aims to remedy that by adding some infrastructure to allow
syncfs to return an error when an inode fails writeback. The basic idea
is to add a new errseq_t to the super_block to record writeback errors.

Because we don't want to grow struct file for this purpose, this new
behavior is only activated when the fd passed to syncfs is opened with
O_PATH.

One of the items on the wishlist from the PostgreSQL developers at this
year's LSF/MM was a way to tell whether there has been any writeback
failure on a filesystem without forcing everything to be synced out.

The final patch in this series adds a new generic vfs ioctl that
presents the new sb->s_wb_err field to userland applications that wish
to see it.

Comments and suggestions welcome.

Jeff Layton (5):
  vfs: push __sync_blockdev calls down into sync_fs routines
  vfs: add an errseq_t pointer arg to sync_filesystem and
    __sync_filesystem
  vfs: track per-sb writeback errors and report them to syncfs
  buffer: record blockdev write errors in super_block that backs them
  vfs: add a new ioctl for fetching the superblock's errseq_t

 drivers/staging/ncpfs/inode.c |  2 +-
 fs/adfs/super.c               |  2 +-
 fs/affs/super.c               |  4 +--
 fs/befs/linuxvfs.c            |  2 +-
 fs/block_dev.c                |  3 ++-
 fs/btrfs/super.c              |  4 +--
 fs/buffer.c                   |  2 ++
 fs/cachefiles/interface.c     |  2 +-
 fs/cifs/cifsfs.c              |  2 +-
 fs/coda/inode.c               |  2 +-
 fs/cramfs/inode.c             |  2 +-
 fs/debugfs/inode.c            |  2 +-
 fs/efs/super.c                |  2 +-
 fs/ext2/super.c               |  4 +--
 fs/ext4/super.c               | 13 +++++-----
 fs/f2fs/super.c               | 15 ++++++-----
 fs/fat/inode.c                |  2 +-
 fs/freevxfs/vxfs_super.c      |  2 +-
 fs/fuse/inode.c               |  2 +-
 fs/gfs2/super.c               |  6 +++--
 fs/hfs/super.c                |  4 +--
 fs/hfsplus/super.c            |  2 +-
 fs/hpfs/super.c               |  2 +-
 fs/internal.h                 |  7 ------
 fs/ioctl.c                    |  3 +++
 fs/isofs/inode.c              |  2 +-
 fs/jffs2/super.c              |  2 +-
 fs/jfs/super.c                |  5 ++--
 fs/minix/inode.c              |  2 +-
 fs/nfs/super.c                |  2 +-
 fs/nilfs2/super.c             |  7 +++---
 fs/ntfs/super.c               |  2 +-
 fs/ocfs2/super.c              |  4 +--
 fs/open.c                     |  6 ++---
 fs/openpromfs/inode.c         |  2 +-
 fs/overlayfs/super.c          |  2 +-
 fs/proc/root.c                |  2 +-
 fs/pstore/inode.c             |  2 +-
 fs/qnx4/inode.c               |  2 +-
 fs/qnx6/inode.c               |  2 +-
 fs/quota/dquot.c              | 11 +++-----
 fs/reiserfs/super.c           |  4 +--
 fs/romfs/super.c              |  2 +-
 fs/squashfs/super.c           |  2 +-
 fs/super.c                    |  4 +--
 fs/sync.c                     | 47 +++++++++++++++++++++++++++--------
 fs/sysv/inode.c               |  5 ++--
 fs/tracefs/inode.c            |  2 +-
 fs/ubifs/super.c              |  2 +-
 fs/udf/super.c                |  2 +-
 fs/ufs/super.c                |  2 +-
 fs/xfs/xfs_super.c            |  2 +-
 include/linux/errseq.h        |  1 +
 include/linux/fs.h            | 13 +++++++++-
 include/linux/pagemap.h       |  5 +++-
 include/uapi/linux/fs.h       |  1 +
 lib/errseq.c                  | 33 ++++++++++++++++++++++--
 57 files changed, 173 insertions(+), 102 deletions(-)

-- 
2.17.0
