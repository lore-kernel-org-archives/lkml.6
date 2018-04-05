Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752910AbeDEDpK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 23:45:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753676AbeDEDpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 23:45:04 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DCD21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
Date: Wed, 4 Apr 2018 20:39:51 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: [GIT PULL] f2fs update for 4.17-rc1
Message-ID: <20180405033951.GA50189@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please consider this pull request?

Thanks,

The following changes since commit 3664ce2d930983966d2aac0e167f1332988c4e25:

  Merge tag 'powerpc-4.16-4' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2018-02-24 16:05:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-4.17

for you to fetch changes up to 214c2461a864a46b11856426b80dc7db453043c5:

  f2fs: remain written times to update inode during fsync (2018-04-03 18:52:47 -0700)

----------------------------------------------------------------
f2fs-for-4.17-rc1

In this round, we've mainly focused on performance tuning and critical bug fixes
occurred in low-end devices. Sheng Yong introduced lost_found feature to keep
missing files during recovery instead of thrashing them. We're preparing coming
fsverity implementation. And, we've got more features to communicate with users
for better performance. In low-end devices, some memory-related issues were
fixed, and subtle race condtions and corner cases were addressed as well.

Enhancement:
 - large nat bitmaps for more free node ids
 - add three block allocation policies to pass down write hints given by user
 - expose extension list to user and introduce hot file extension
 - tune small devices seamlessly for low-end devices
 - set readdir_ra by default
 - give more resources under gc_urgent mode regarding to discard and cleaning
 - introduce fsync_mode to enforce posix or not
 - nowait aio support
 - add lost_found feature to keep dangling inodes
 - reserve bits for future fsverity feature
 - add test_dummy_encryption for FBE

Bug fix:
 - don't use highmem for dentry pages
 - align memory boundary for bitops
 - truncate preallocated blocks in write errors
 - guarantee i_times on fsync call
 - clear CP_TRIMMED_FLAG correctly
 - prevent node chain loop during recovery
 - avoid data race between atomic write and background cleaning
 - avoid unnecessary selinux violation warnings on resgid option
 - GFP_NOFS to avoid deadlock in quota and read paths
 - fix f2fs_skip_inode_update to allow i_size recovery

In addition to them, there are several minor bug fixes and clean-ups.

----------------------------------------------------------------
Chao Yu (16):
      f2fs: restrict inline_xattr_size configuration
      f2fs: fix to check extent cache in f2fs_drop_extent_tree
      f2fs: support large nat bitmap
      f2fs: fix to clear CP_TRIMMED_FLAG
      f2fs: fix to handle looped node chain during recovery
      f2fs: introduce sb_lock to make encrypt pwsalt update exclusive
      f2fs: fix to set KEEP_SIZE bit in f2fs_zero_range
      f2fs: expose extension_list sysfs entry
      f2fs: fix to avoid race in between atomic write and background GC
      f2fs: support hot file extension
      f2fs: wrap sb_rdonly with f2fs_readonly
      f2fs: fix to restore old mount option in ->remount_fs
      f2fs: wrap all options with f2fs_sb_info.mount_opt
      f2fs: remove unneeded set_cold_node()
      f2fs: clean up with F2FS_BLK_ALIGN
      f2fs: don't track new nat entry in nat set

Colin Ian King (1):
      f2fs: remove redundant initialization of pointer 'p'

Eric Biggers (1):
      f2fs: reserve bits for fs-verity

Gao Xiang (1):
      f2fs: flush cp pack except cp pack 2 page at first

Hyunchul Lee (4):
      f2fs: support passing down write hints given by users to block layer
      f2fs: support passing down write hints to block layer with F2FS policy
      f2fs: Add the 'whint_mode' mount option to f2fs documentation
      f2fs: add nowait aio support

Jaegeuk Kim (11):
      f2fs: handle quota for orphan inodes
      f2fs: don't stop GC if GC is contended
      f2fs: add mount option for segment allocation policy
      f2fs: add auto tuning for small devices
      f2fs: set readdir_ra by default
      f2fs: issue discard aggressively in the gc_urgent mode
      f2fs: do gc in greedy mode for whole range if gc_urgent mode is set
      f2fs: avoid selinux denial on CAP_SYS_RESOURCE
      f2fs: align memory boundary for bitops
      f2fs: truncate preallocated blocks in error case
      f2fs: remain written times to update inode during fsync

Junling Zheng (2):
      f2fs: introduce mount option for fsync mode
      f2fs: fix a wrong condition in f2fs_skip_inode_update

Qiuyang Sun (1):
      f2fs: release locks before return in f2fs_ioc_gc_range()

Ritesh Harjani (1):
      f2fs: Set GF_NOFS in read_cache_page_gfp while doing f2fs_quota_read

Sheng Yong (4):
      f2fs: fix potential corruption in area before F2FS_SUPER_OFFSET
      f2fs: clean up f2fs_sb_has_xxx functions
      f2fs: introduce F2FS_FEATURE_LOST_FOUND feature
      f2fs: introduce a new mount option test_dummy_encryption

Tiezhu Yang (1):
      f2fs: remove redundant check of page type when submit bio

Yunlei He (3):
      f2fs: Don't overwrite all types of node to keep node chain
      f2fs: check blkaddr more accuratly before issue a bio
      f2fs: Add a segment type check in inplace write

Yunlong Song (4):
      f2fs: don't put dentry page in pagecache into highmem
      f2fs: fix heap mode to reset it back
      f2fs: no need to initialize zero value for GFP_F2FS_ZERO
      f2fs: make assignment of t->dentry_bitmap more readable

 Documentation/ABI/testing/sysfs-fs-f2fs |  11 +
 Documentation/filesystems/f2fs.txt      |  77 +++++++
 fs/f2fs/checkpoint.c                    | 101 +++++----
 fs/f2fs/data.c                          |  85 ++++++--
 fs/f2fs/dir.c                           |  32 +--
 fs/f2fs/extent_cache.c                  |   5 +-
 fs/f2fs/f2fs.h                          | 188 ++++++++++-------
 fs/f2fs/file.c                          |  94 ++++++---
 fs/f2fs/gc.c                            |  23 ++-
 fs/f2fs/inline.c                        |   3 +-
 fs/f2fs/inode.c                         |  11 +-
 fs/f2fs/namei.c                         | 147 ++++++++++----
 fs/f2fs/node.c                          |  55 ++++-
 fs/f2fs/node.h                          |   5 +-
 fs/f2fs/recovery.c                      |  25 ++-
 fs/f2fs/segment.c                       | 133 ++++++++++--
 fs/f2fs/segment.h                       |  27 ++-
 fs/f2fs/super.c                         | 348 ++++++++++++++++++++++----------
 fs/f2fs/sysfs.c                         |  73 ++++++-
 include/linux/f2fs_fs.h                 |  20 +-
 20 files changed, 1081 insertions(+), 382 deletions(-)
