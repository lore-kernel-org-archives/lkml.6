Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752400AbeA3WcW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:32:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:39828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751530AbeA3WcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:32:21 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE9F21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
Date: Tue, 30 Jan 2018 14:32:20 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux F2FS Dev Mailing List
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] f2fs update for 4.16-rc1
Message-ID: <20180130223220.GB65489@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linux,

Could you please consider the below pull request?

Thanks,

The following changes since commit ace52288edf0cb5e7a52b681f057f86224c49c27:

  Merge tag 'for-linus-20171218' of git://git.infradead.org/linux-mtd (2017-12-18 16:18:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-4.16-rc1

for you to fetch changes up to 1c1d35df71104c76a4a2e25862926f22c334c9d6:

  f2fs: support inode creation time (2018-01-25 14:10:39 -0800)

----------------------------------------------------------------
f2fs-for-4.16-rc1

In this round, we've followed up to support some generic features such as
cgroup, block reservation, linking fscrypt_ops, delivering write_hints,
and some ioctls. And, we could fix some corner cases in terms of power-cut
recovery and subtle deadlocks.

Enhancement:
 - bitmap operations to handle NAT blocks
 - readahead to improve readdir speed
 - switch to use fscrypt_*
 - apply write hints for direct IO
 - add reserve_root=%u,resuid=%u,resgid=%u to reserve blocks for root/uid/gid
 - modify b_avail and b_free to consider root reserved blocks
 - support cgroup writeback
 - support FIEMAP_FLAG_XATTR for fibmap
 - add F2FS_IOC_PRECACHE_EXTENTS to pre-cache extents
 - add F2FS_IOC_{GET/SET}_PIN_FILE to pin LBAs for data blocks
 - support inode creation time

Bug fix:
 - sysfile-based quota operations
 - memory footprint accounting
 - allow to write data on partial preallocation case
 - fix deadlock case on fallocate
 - fix to handle fill_super errors
 - fix missing inode updates of fsync'ed file
 - recover renamed file which was fsycn'ed before
 - drop inmemory pages in corner error case
 - keep last_disk_size correctly
 - recover missing i_inline flags during roll-forward

Various clean-up patches were added as well.

----------------------------------------------------------------
Chao Yu (32):
      f2fs: reserve nid resource for quota sysfile
      f2fs: remove unneeded memory footprint accounting
      f2fs: fix lock dependency in between dio_rwsem & i_mmap_sem
      f2fs: inject fault to kzalloc
      f2fs: inject fault to kvmalloc
      f2fs: spread f2fs_k{m,z}alloc
      f2fs: fix error handling in fill_super
      f2fs: clean up hash codes
      f2fs: clean up f2fs_map_blocks
      f2fs: don't return value in truncate_data_blocks_range
      f2fs: fix potential hangtask in f2fs_trace_pid
      f2fs: continue to do direct IO if we only preallocate partial blocks
      f2fs: clean up unneeded declaration
      f2fs: avoid high cpu usage in discard thread
      f2fs: remove unused pend_list_tag
      f2fs: fix to caclulate required free section correctly
      f2fs: fix to cover f2fs_inline_data_fiemap with inode_lock
      f2fs: support FIEMAP_FLAG_XATTR
      f2fs: support F2FS_IOC_PRECACHE_EXTENTS
      f2fs: speed up defragment on sparse file
      f2fs: fix to drop all inmem pages correctly
      f2fs: clean up error path of fill_super
      f2fs: kill F2FS_INLINE_XATTR_ADDRS for cleanup
      f2fs: fix to update last_disk_size correctly
      f2fs: split need_inplace_update
      f2fs: hanlde error case in f2fs_ioc_shutdown
      f2fs: stop gc/discard thread after fs shutdown
      f2fs: drop page cache after fs shutdown
      f2fs: use GFP_F2FS_ZERO for cleanup
      f2fs: clean up duplicated assignment in init_discard_policy
      f2fs: stop issuing discard if fs is readonly
      f2fs: support inode creation time

Daeho Jeong (3):
      f2fs: handle newly created page when revoking inmem pages
      f2fs: prevent newly created inode from being dirtied incorrectly
      f2fs: correct removexattr behavior for null valued extended attribute

Elena Reshetova (1):
      posix_acl: convert posix_acl.a_refcount from atomic_t to refcount_t

Eric Biggers (5):
      f2fs: switch to fscrypt_file_open()
      f2fs: switch to fscrypt_prepare_link()
      f2fs: switch to fscrypt_prepare_rename()
      f2fs: switch to fscrypt_prepare_lookup()
      f2fs: switch to fscrypt_prepare_setattr()

Hyunchul Lee (1):
      f2fs: apply write hints to select the type of segment for direct write

Jaegeuk Kim (12):
      f2fs: return error during fill_super
      f2fs: recover directory operations by fsync
      f2fs: fix missing error number for xattr operation
      f2fs: skip stop_checkpoint for user data writes
      f2fs: enable quota at remount from r to w
      f2fs: show precise # of blocks that user/root can use
      f2fs: add reserved blocks for root user
      f2fs: add resgid and resuid to reserve root blocks
      f2fs: add an ioctl to disable GC for specific file
      f2fs: allow quota to use reserved blocks
      f2fs: recover some i_inline flags
      f2fs: allow to recover node blocks given updated checkpoint

LiFan (4):
      f2fs: fix concurrent problem for updating free bitmap
      f2fs: remove an excess variable
      f2fs: remove a redundant conditional expression
      f2fs: use unlikely for release case

Sheng Yong (4):
      f2fs: introduce sysfs readdir_ra to readahead inode block in readdir
      f2fs: still write data if preallocate only partial blocks
      f2fs: remove unused parameter
      f2fs: avoid hungtask when GC encrypted block if io_bits is set

Wei Yongjun (1):
      f2fs: make local functions static

Yufen Yu (1):
      f2fs: implement cgroup writeback support

Yunlei He (6):
      f2fs: no need to read nat block if nat_block_bitmap is set
      f2fs: no need return value in restore summary process
      f2fs: fix an error case of missing update inode page
      f2fs: update inode info to inode page for new file
      f2fs: check node page again in write end io
      f2fs: rebuild sit page from sit info in mem

Yunlong Song (1):
      f2fs: check segment type in __f2fs_replace_block

Zhikang Zhang (1):
      f2fs: remove repeated f2fs_bug_on

 Documentation/ABI/testing/sysfs-fs-f2fs |   6 +
 fs/f2fs/acl.c                           |   2 +-
 fs/f2fs/checkpoint.c                    |  10 +-
 fs/f2fs/data.c                          | 299 +++++++++++++++++++++++++++-----
 fs/f2fs/debug.c                         |  12 +-
 fs/f2fs/dir.c                           |   6 +
 fs/f2fs/f2fs.h                          | 201 +++++++++++++++------
 fs/f2fs/file.c                          | 248 ++++++++++++++++++++------
 fs/f2fs/gc.c                            |  18 +-
 fs/f2fs/gc.h                            |   2 +
 fs/f2fs/inode.c                         |  34 +++-
 fs/f2fs/namei.c                         |  67 +++----
 fs/f2fs/node.c                          | 149 ++++++++--------
 fs/f2fs/node.h                          |   4 +
 fs/f2fs/recovery.c                      |  27 ++-
 fs/f2fs/segment.c                       | 129 +++++++-------
 fs/f2fs/segment.h                       |  92 +++++-----
 fs/f2fs/super.c                         | 142 ++++++++++++---
 fs/f2fs/sysfs.c                         |  14 +-
 fs/f2fs/trace.c                         |  12 +-
 fs/f2fs/xattr.c                         |  12 +-
 fs/posix_acl.c                          |   6 +-
 include/linux/f2fs_fs.h                 |  14 +-
 include/linux/posix_acl.h               |   7 +-
 include/trace/events/f2fs.h             |   3 +-
 25 files changed, 1064 insertions(+), 452 deletions(-)
