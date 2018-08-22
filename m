Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CE1C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 03:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9820B208A2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 03:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8bd67X0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9820B208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeHVG7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 02:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbeHVG7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 02:59:06 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA304208A1;
        Wed, 22 Aug 2018 03:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534908970;
        bh=Y1skhJ8jv2M0Lx6ZppJbvhyl7H+KtM1aqocc2E6ViVY=;
        h=Date:From:To:Cc:Subject:From;
        b=G8bd67X0BBt5il2/dAQD1VE3/MLkwgJgm35nr8lfQCM0W7AhSQCNIbnIC/3Snep1T
         WmAYpAeHmHQl2ufGjdmcTciSYvEATJWDse0K3dnTMK2x2KyFuW2El3u5pIYgH9DPjI
         LL+XzGKw+VvALY1TYObcWY4yVzilwJwRK+hJm6iw=
Date:   Tue, 21 Aug 2018 20:36:09 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] f2fs-for-4.19
Message-ID: <20180822033609.GA65930@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please consider the below pull request?

Thank you all the time,

The following changes since commit b4d0562137c9035becad5fc0588f6163aed916db:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2018-07-06 09:14:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-4.19

for you to fetch changes up to 6aa58d8ad20a3323f42274c25820a6f54192422d:

  f2fs: readahead encrypted block during GC (2018-08-20 23:13:42 -0700)

----------------------------------------------------------------
f2fs-for-4.19-rc1

In this round, we've tuned f2fs to improve general performance by serializing
block allocation and enhancing discard flows like fstrim which avoids user IO
contention. And we've added fsync_mode=nobarrier which gives an option to user
where it skips issuing cache_flush commands to underlying flash storage. And
there are many bug fixes related to fuzzed images, revoked atomic writes, quota
ops, and minor direct IO.

Enhancement:
 - add fsync_mode=nobarrier which bypasses cache_flush command
 - enhance the discarding flow which avoids user IOs and issues in LBA order
 - readahead some encrypted blocks during GC
 - enable in-memory inode checksum to verify the blocks if F2FS_CHECK_FS is set
 - enhance nat_bits behavior
 - set -o discard by default
 - set REQ_RAHEAD to bio in ->readpages

Bug fixes:
 - fix a corner case to corrupt atomic_writes revoking flow
 - revisit i_gc_rwsem to fix race conditions
 - fix some dio behaviors captured by xfstests
 - correct handling errors given by quota-related failures
 - add many sanity check flows to avoid fuzz test failures
 - add more error number propagation to their callers
 - fix several corner cases to continue fault injection w/ shutdown loop

----------------------------------------------------------------
Arnd Bergmann (2):
      f2fs: use timespec64 for inode timestamps
      f2fs: rework fault injection handling to avoid a warning

Chao Yu (54):
      f2fs: don't acquire orphan ino during recovery
      f2fs: move s_res{u,g}id initialization to default_options()
      f2fs: relocate readdir_ra configure initialization
      f2fs: fix error path of fill_super
      f2fs: fix to propagate return value of scan_nat_page()
      f2fs: fix to wait on page writeback before updating page
      f2fs: introduce and spread verify_blkaddr
      f2fs: disable f2fs_check_rb_tree_consistence
      f2fs: fix to do sanity check with secs_per_zone
      f2fs: fix to do sanity check with {sit,nat}_ver_bitmap_bytesize
      f2fs: fix to correct return value of f2fs_trim_fs
      f2fs: fix to do sanity check with extra_attr feature
      f2fs: fix to do sanity check with user_block_count
      f2fs: fix to do sanity check with node footer and iblocks
      f2fs: fix to do sanity check with reserved blkaddr of inline inode
      f2fs: try grabbing node page lock aggressively in sync scenario
      f2fs: fix to skip GC if type in SSA and SIT is inconsistent
      f2fs: fix to do sanity check with block address in main area
      f2fs: fix to detect looped node chain correctly
      f2fs: enable real-time discard by default
      f2fs: detect bug_on in f2fs_wait_discard_bios
      f2fs: clean up with IS_INODE()
      f2fs: stop issuing discard immediately if there is queued IO
      f2fs: issue small discard by LBA order
      f2fs: fix to do sanity check with i_extra_isize
      f2fs: fix to propagate error from __get_meta_page()
      f2fs: kill EXT_TREE_VEC_SIZE
      f2fs: clean up with get_current_nat_page
      f2fs: clean up with f2fs_encrypted_inode()
      f2fs: clean up with f2fs_is_{atomic,volatile}_file()
      f2fs: clean up ioctl interface naming
      f2fs: restrict setting up inode.i_advise
      f2fs: let checkpoint flush dnode page of regular
      f2fs: fix to restrict mount condition when without CONFIG_QUOTA
      f2fs: don't keep meta pages used for block migration
      f2fs: fix to active page in lru list for read path
      f2fs: fix to clear PG_checked flag in set_page_dirty()
      f2fs: fix to do sanity check with cp_pack_start_sum
      f2fs: fix to avoid broken of dnode block list
      f2fs: fix invalid memory access
      f2fs: fix to reset i_gc_failures correctly
      f2fs: fix to do sanity check with inline flags
      f2fs: fix to do sanity check with block address in main area v2
      f2fs: avoid race between zero_range and background GC
      f2fs: fix avoid race between truncate and background GC
      f2fs: refresh recent accessed nat entry in lru list
      f2fs: fix incorrect range->len in f2fs_trim_fs()
      f2fs: split discard command in prior to block layer
      f2fs: support discard submission error injection
      f2fs: fix use-after-free of dicard command entry
      f2fs: fix to return success when trimming meta area
      f2fs: support fault_type mount option
      f2fs: fix to skip verifying block address for non-regular inode
      f2fs: readahead encrypted block during GC

Dan Carpenter (1):
      f2fs: Fix uninitialized return in f2fs_ioc_shutdown()

Daniel Rosenberg (1):
      f2fs: Keep alloc_valid_block_count in sync

Gao Xiang (1):
      f2fs: avoid the global name 'fault_name'

Guenter Roeck (1):
      f2fs: Replace strncpy with memcpy

Gustavo A. R. Silva (1):
      f2fs: use true and false for boolean values

Hyunchul Lee (1):
      f2fs: avoid duplicated permission check for "trusted." xattrs

Jaegeuk Kim (12):
      f2fs: flush journal nat entries for nat_bits during unmount
      f2fs: allow wrong configured dio to buffered write
      f2fs: do checkpoint in kill_sb
      f2fs: keep meta pages in cp_error state
      f2fs: indicate shutdown f2fs to allow unmount successfully
      f2fs: avoid potential deadlock in f2fs_sbi_store
      f2fs: don't issue discard commands in online discard is on
      f2fs: assign REQ_RAHEAD to bio for ->readpages
      f2fs: don't allow any writes on aborted atomic writes
      f2fs: avoid f2fs_bug_on() in cp_error case
      f2fs: fix performance issue observed with multi-thread sequential read
      f2fs: avoid fi->i_gc_rwsem[WRITE] lock in f2fs_gc

Randy Dunlap (1):
      f2fs: fix defined but not used build warnings

Sahitya Tummala (1):
      f2fs: show the fsync_mode=nobarrier mount option

Sheng Yong (4):
      f2fs: quota: decrease the lock granularity of statfs_project
      f2fs: quota: fix incorrect comments
      f2fs: quota: do not mount as RDWR without QUOTA if quota feature enabled
      f2fs: wake up gc thread immediately when gc_urgent is set

Weichao Guo (1):
      f2fs: support in-memory inode checksum when checking consistency

Yunlei He (4):
      f2fs: fix a hungtask problem caused by congestion_wait
      f2fs: Allocate and stat mem used by free nid bitmap more accurately
      f2fs: check the right return value of memory alloc function
      f2fs: fix wrong kernel message when recover fsync data on ro fs

Yunlong Song (4):
      f2fs: do not set free of current section
      f2fs: blk_finish_plug of submit_bio in lfs mode
      f2fs: issue discard align to section in LFS mode
      f2fs: add proc entry to show victim_secmap bitmap

 Documentation/ABI/testing/sysfs-fs-f2fs |   8 +
 Documentation/filesystems/f2fs.txt      |  18 ++
 fs/f2fs/checkpoint.c                    | 159 ++++++++-----
 fs/f2fs/data.c                          | 185 +++++++++++----
 fs/f2fs/debug.c                         |   3 +-
 fs/f2fs/dir.c                           |   3 +-
 fs/f2fs/f2fs.h                          | 191 ++++++++++-----
 fs/f2fs/file.c                          | 216 ++++++++++-------
 fs/f2fs/gc.c                            | 163 +++++++++++--
 fs/f2fs/inline.c                        |  36 ++-
 fs/f2fs/inode.c                         | 154 ++++++++++--
 fs/f2fs/namei.c                         |   6 +-
 fs/f2fs/node.c                          | 380 ++++++++++++++++++++++++------
 fs/f2fs/node.h                          |   9 +
 fs/f2fs/recovery.c                      |  31 ++-
 fs/f2fs/segment.c                       | 399 ++++++++++++++++++++++++--------
 fs/f2fs/segment.h                       |  16 +-
 fs/f2fs/super.c                         | 162 +++++++++----
 fs/f2fs/sysfs.c                         |  44 +++-
 fs/f2fs/xattr.c                         |  18 +-
 include/linux/f2fs_fs.h                 |   5 -
 21 files changed, 1675 insertions(+), 531 deletions(-)
