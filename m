Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0596C46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453D12082B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV7UdjGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453D12082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbeJXLr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:47:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbeJXLr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:47:58 -0400
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B8B62082B;
        Wed, 24 Oct 2018 02:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540346705;
        bh=Uzajyn/IyYEE6htCGyaXZ/tUzV6wJccvIKOcmNQcWNw=;
        h=Date:From:To:Cc:Subject:From;
        b=FV7UdjGLcF9akOkVOtFC8iEghw4sn19YvS7J9jqEMQCoxRUNMLgI/uMtEG2KXRQDg
         gPJkERabIw8dWGbU3OOffa2/lD4SfkDeQSWJeXPpt5XT+DQb5M+QtkgLFxgNw95Sw0
         2151b2MnHsTvbOmxGVS4DGUElHFH6p+Y//lr4oh8=
Date:   Tue, 23 Oct 2018 19:05:04 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] f2fs update for 4.20-rc1
Message-ID: <20181024020504.GA31877@jaegeuk-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you please consider this pull request?

The following changes since commit b36fdc6853a38a6f8749897a33435635019e0647:

  Merge tag 'gpio-v4.19-2' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio (2018-09-05 09:27:45 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-4.20-rc1

for you to fetch changes up to 78130819695f17f5c042d8ba097802639478faf5:

  f2fs: fix to keep project quota consistent (2018-10-22 17:54:48 -0700)

----------------------------------------------------------------
f2fs-for-4.20-rc1

In this round, we've added 1) superblock checksum feature, 2) implemented new
mount option which we can disable/enable checkpoint to provide atomic updates of
entire filesystem, 3) refactored quota operations to enhance its consistency
along with checkpoint, 4) fixed subtle IO hang conditions and roll-forward
recovery flow to resurrect any fsync'ed inode metadata.

Enhancement:
 - add checksum to keep superblock contents more safe
 - add checkpoint=disable/enable to support A/B update of entire filesystem
 - use plug for readahead IO in readdir
 - add more IO counts to avoid block layer hacks

Bug fix:
 - prevent data corruption issue for hardware encryption
 - fix IO hang issues when GC is heavily triggered
 - add missing up_read in __write_node_page
 - recover inode metadata during roll-forward recovery flow
 - fix null pointer dereference issue in wrongly configured discard map

There are some more sanity checks and minor bug fixes as well.

----------------------------------------------------------------
Chao Yu (33):
      f2fs: fix to avoid NULL pointer dereference on se->discard_map
      Revert "f2fs: use printk_ratelimited for f2fs_msg"
      f2fs: fix to flush all dirty inodes recovered in readonly fs
      f2fs: fix memory leak of write_io in fill_super()
      f2fs: fix memory leak of percpu counter in fill_super()
      f2fs: fix to do sanity check with current segment number
      f2fs: plug readahead IO in readdir()
      f2fs: add SPDX license identifiers
      f2fs: split IO error injection according to RW
      f2fs: fix to recover inode's uid/gid during POR
      f2fs: fix to recover inode's project id during POR
      f2fs: fix to recover inode's i_flags during POR
      f2fs: fix to recover inode's i_gc_failures during POR
      f2fs: fix to recover inode's crtime during POR
      f2fs: mark inode dirty explicitly in recover_inode()
      f2fs: add to account meta IO
      f2fs: add to account skip count of background GC
      Revert: "f2fs: check last page index in cached bio to decide submission"
      f2fs: refactor ->page_mkwrite() flow
      f2fs: allow out-place-update for direct IO in LFS mode
      f2fs: submit cached bio to avoid endless PageWriteback
      f2fs: fix to recover cold bit of inode block during POR
      f2fs: use rb_*_cached friends
      f2fs: shrink sbi->sb_lock coverage in set_file_temperature()
      f2fs: remove unused sbi->trigger_ssr_threshold
      f2fs: remove unneeded disable_nat_bits()
      f2fs: fix to account IO correctly
      f2fs: fix to account IO correctly for cgroup writeback
      f2fs: fix to spread clear_cold_data()
      f2fs: spread f2fs_set_inode_flags()
      f2fs: fix to recover inode->i_flags of inode block during POR
      f2fs: guarantee journalled quota data by checkpoint
      f2fs: fix to keep project quota consistent

Chengguang Xu (4):
      f2fs: add additional sanity check in f2fs_acl_from_disk()
      f2fs: cache NULL when both default_acl and acl are NULL
      f2fs: surround fault_injection related option parsing using CONFIG_F2FS_FAULT_INJECTION
      f2fs: fix remount problem of option io_bits

Daniel Rosenberg (1):
      f2fs: checkpoint disabling

Jaegeuk Kim (13):
      f2fs: avoid wrong decrypted data from disk
      f2fs: submit bio after shutdown
      f2fs: avoid infinite loop in f2fs_alloc_nid
      f2fs: report ENOENT correctly in f2fs_rename
      f2fs: update i_size after DIO completion
      f2fs: avoid f2fs_bug_on if f2fs_get_meta_page_nofail got EIO
      f2fs: return correct errno in f2fs_gc
      f2fs: fix missing up_read
      f2fs: keep lazytime on remount
      f2fs: clear PageError on the read path
      f2fs: allow to mount, if quota is failed
      f2fs: account read IOs and use IO counts for is_idle
      Revert "f2fs: fix to clear PG_checked flag in set_page_dirty()"

Jens Axboe (1):
      f2fs: remove request_list check in is_idle()

Junling Zheng (1):
      f2fs: support superblock checksum

Sahitya Tummala (5):
      f2fs: fix unnecessary periodic wakeup of discard thread when dev is busy
      f2fs: add new idle interval timing for discard and gc paths
      f2fs: do not update REQ_TIME in case of error conditions
      f2fs: update REQ_TIME in f2fs_cross_rename()
      f2fs: fix data corruption issue with hardware encryption

Sheng Yong (1):
      f2fs: cleanup dirty pages if recover failed

Wang Shilong (1):
      f2fs: fix setattr project check upon fssetxattr ioctl

Yunlei He (1):
      f2fs: report error if quota off error during umount

Zhikang Zhang (1):
      f2fs: avoid sleeping under spin_lock

 Documentation/ABI/testing/sysfs-fs-f2fs |  17 +-
 Documentation/filesystems/f2fs.txt      |   8 +-
 fs/f2fs/acl.c                           |  12 +-
 fs/f2fs/acl.h                           |   5 +-
 fs/f2fs/checkpoint.c                    |  94 ++++++--
 fs/f2fs/data.c                          | 220 ++++++++++++-----
 fs/f2fs/debug.c                         |  35 ++-
 fs/f2fs/dir.c                           |  30 ++-
 fs/f2fs/extent_cache.c                  | 134 ++++++-----
 fs/f2fs/f2fs.h                          | 253 +++++++++++++++----
 fs/f2fs/file.c                          | 196 +++++++++------
 fs/f2fs/gc.c                            | 115 ++++++---
 fs/f2fs/gc.h                            |   5 +-
 fs/f2fs/hash.c                          |   5 +-
 fs/f2fs/inline.c                        |   8 +-
 fs/f2fs/inode.c                         |  28 ++-
 fs/f2fs/namei.c                         |  57 +++--
 fs/f2fs/node.c                          |  83 ++++---
 fs/f2fs/node.h                          |   5 +-
 fs/f2fs/recovery.c                      | 125 ++++++++--
 fs/f2fs/segment.c                       | 240 ++++++++++++------
 fs/f2fs/segment.h                       |  20 +-
 fs/f2fs/shrinker.c                      |   5 +-
 fs/f2fs/super.c                         | 415 +++++++++++++++++++++++++++-----
 fs/f2fs/sysfs.c                         |  17 +-
 fs/f2fs/trace.c                         |   5 +-
 fs/f2fs/trace.h                         |   5 +-
 fs/f2fs/xattr.c                         |   5 +-
 fs/f2fs/xattr.h                         |   5 +-
 include/linux/f2fs_fs.h                 |  10 +-
 30 files changed, 1594 insertions(+), 568 deletions(-)
