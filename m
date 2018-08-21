Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C452C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A82217C7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fV6+XyUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A82217C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeHUXQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 19:16:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34532 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbeHUXQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 19:16:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id l2-v6so10435579wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 12:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=b/v1ib08gpXnKQVOpBS9hExt+6lM9c3yAmrdIjdxow0=;
        b=fV6+XyUFTFbcxtaLueIyrJ5KuK9m6A8xIcJ+p1wcOYEx0UZIsWwhtj4peEWQAiBbf0
         I+NG6lMvxrea6jZXH4T6xoXannNnhLqtfuijRqKH/kjrVofntUr2xcp9YFoo1Kb9u6DW
         ko/eOk1yH7jBS4q1sBuWqH8L6TpMi4vhPdrq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=b/v1ib08gpXnKQVOpBS9hExt+6lM9c3yAmrdIjdxow0=;
        b=hjhZQyF7gOhr5EHf4zo9/ZluSyzyueKvanamj9v0LMFRAnd3I1A+9iFGVj7okqzXBn
         7sMH+XBD1mktzNigDlNVVkoYrlHCDc3g3rw9LiJtqMpYsNTBEqwzpzS6Hwez4z/D6mA0
         nPkxwsuNIAgfvw3nKfDpIAst4nwTesjaxsq8rnN2zvhmiO/367eWMs8HQhJ53mUHK8sV
         e7MnIJMqkyDVKL4SY/8XEoNHderBAFcrdsHzw9eTmlPm1OuCFduCERLa5npHyzoVzSL5
         en45Gr8Fhl5tPsYqskxYfyySdFGiT/XUFiU/CpziloPOse8mZNjQIPFdmzeSvSFN2Ynn
         wxlQ==
X-Gm-Message-State: APzg51CL7Jmoa+Xtd4g74xmkGdHaEkrXPXjkHUc1DXS/8Im3YvRE95k7
        SXqJINEpRfxVPudWeYel7EfpDA==
X-Google-Smtp-Source: ANB0VdYeo/yCr6xDSDefjqw4qPSn+PfjGGB6jR5UTHdbnPnrrdy7lOz1/vsHrsz8E3G1XvGt2GbtFg==
X-Received: by 2002:a1c:ae8d:: with SMTP id x135-v6mr539119wme.20.1534881295161;
        Tue, 21 Aug 2018 12:54:55 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id g2-v6sm33523614wrd.71.2018.08.21.12.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 12:54:54 -0700 (PDT)
Date:   Tue, 21 Aug 2018 21:54:46 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, viro@zeniv.linux.org.uk,
        hch@infradead.org
Subject: [GIT PULL] overlayfs update for 4.19
Message-ID: <20180821195446.GA9512@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-4.19

This contains two new features:

 1) Stack file operations: this allows removal of several hacks from the
    VFS, proper interaction of read-only open files with copy-up,
    possibility to implement fs modifying ioctls properly, and others.

 2) Metadata only copy-up: when file is on lower layer and only metadata is
    modified (except size) then only copy up the metadata and continue to
    use the data from the lower file.

The vfs bits have been reworked based on Al's open cleanup work.

Thanks,
Miklos

----------------------------------------------------------------
Al Viro (1):
      new helper: open_with_fake_path()

Amir Goldstein (1):
      ovl: fix wrong use of impure dir cache in ovl_iterate()

Miklos Szeredi (36):
      vfs: limit size of dedupe
      vfs: dedupe: return int
      vfs: dedupe: rationalize args
      vfs: dedupe: extract helper for a single dedup
      vfs: make open_with_fake_path() not contribute to nr_files
      vfs: export vfs_ioctl() to modules
      vfs: export vfs_dedupe_file_range_one() to modules
      ovl: copy up times
      ovl: copy up inode flags
      Revert "Revert "ovl: get_write_access() in truncate""
      ovl: copy up file size as well
      ovl: deal with overlay files in ovl_d_real()
      ovl: stack file ops
      ovl: add helper to return real file
      ovl: add ovl_read_iter()
      ovl: add ovl_write_iter()
      ovl: add ovl_fsync()
      ovl: add ovl_mmap()
      ovl: add ovl_fallocate()
      ovl: add lsattr/chattr support
      ovl: add ovl_fiemap()
      ovl: add O_DIRECT support
      ovl: add reflink/copyfile/dedup support
      vfs: don't open real
      Revert "ovl: fix may_write_real() for overlayfs directories"
      Revert "ovl: don't allow writing ioctl on lower layer"
      vfs: fix freeze protection in mnt_want_write_file() for overlayfs
      Revert "ovl: fix relatime for directories"
      Revert "vfs: update ovl inode before relatime check"
      Revert "vfs: add flags to d_real()"
      Revert "vfs: do get_write_access() on upper layer of overlayfs"
      Partially revert "locks: fix file locking on overlayfs"
      Revert "fsnotify: support overlayfs"
      vfs: remove open_flags from d_real()
      ovl: obsolete "check_copy_up" module option
      ovl: fix documentation of non-standard behavior

Vivek Goyal (28):
      ovl: Initialize ovl_inode->redirect in ovl_get_inode()
      ovl: Move the copy up helpers to copy_up.c
      ovl: Provide a mount option metacopy=on/off for metadata copyup
      ovl: During copy up, first copy up metadata and then data
      ovl: Copy up only metadata during copy up where it makes sense
      ovl: Add helper ovl_already_copied_up()
      ovl: A new xattr OVL_XATTR_METACOPY for file on upper
      ovl: Use out_err instead of out_nomem
      ovl: Modify ovl_lookup() and friends to lookup metacopy dentry
      ovl: Copy up meta inode data from lowest data inode
      ovl: Add helper ovl_dentry_lowerdata() to get lower data dentry
      ovl: Fix ovl_getattr() to get number of blocks from lower
      ovl: Store lower data inode in ovl_inode
      ovl: Add helper ovl_inode_realdata()
      ovl: Open file with data except for the case of fsync
      ovl: Do not expose metacopy only dentry from d_real()
      ovl: Move some dir related ovl_lookup_single() code in else block
      ovl: Check redirects for metacopy files
      ovl: Treat metacopy dentries as type OVL_PATH_MERGE
      ovl: Add an inode flag OVL_CONST_INO
      ovl: Do not set dentry type ORIGIN for broken hardlinks
      ovl: Set redirect on metacopy files upon rename
      ovl: Set redirect on upper inode when it is linked
      ovl: Check redirect on index as well
      ovl: add helper to force data copy-up
      ovl: Do not do metadata only copy-up for truncate operation
      ovl: Do not do metacopy only for ioctl modifying file attr
      ovl: Enable metadata only feature

 Documentation/filesystems/Locking       |   3 +-
 Documentation/filesystems/overlayfs.txt |  81 +++--
 Documentation/filesystems/vfs.txt       |  16 +-
 fs/btrfs/ctree.h                        |   5 +-
 fs/btrfs/ioctl.c                        |  11 +-
 fs/file_table.c                         |  69 +++--
 fs/inode.c                              |  46 +--
 fs/internal.h                           |  11 +-
 fs/ioctl.c                              |   1 +
 fs/locks.c                              |  20 +-
 fs/namei.c                              |   2 +-
 fs/namespace.c                          |  69 +----
 fs/ocfs2/file.c                         |  17 +-
 fs/open.c                               |  44 +--
 fs/overlayfs/Kconfig                    |  19 ++
 fs/overlayfs/Makefile                   |   4 +-
 fs/overlayfs/copy_up.c                  | 190 ++++++++----
 fs/overlayfs/dir.c                      | 105 +++++--
 fs/overlayfs/export.c                   |   3 +
 fs/overlayfs/file.c                     | 511 ++++++++++++++++++++++++++++++++
 fs/overlayfs/inode.c                    | 175 +++++++----
 fs/overlayfs/namei.c                    | 195 +++++++-----
 fs/overlayfs/overlayfs.h                |  47 ++-
 fs/overlayfs/ovl_entry.h                |   6 +-
 fs/overlayfs/readdir.c                  |  19 +-
 fs/overlayfs/super.c                    | 103 ++++---
 fs/overlayfs/util.c                     | 252 +++++++++++++++-
 fs/read_write.c                         |  94 +++---
 fs/xattr.c                              |   9 +-
 fs/xfs/xfs_file.c                       |  29 +-
 include/linux/dcache.h                  |  15 +-
 include/linux/fs.h                      |  29 +-
 include/linux/fsnotify.h                |  14 +-
 33 files changed, 1619 insertions(+), 595 deletions(-)
 create mode 100644 fs/overlayfs/file.c
