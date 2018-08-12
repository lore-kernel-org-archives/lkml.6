Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44518C46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 22:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F055C217BE
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 22:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F055C217BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeHMBbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 21:31:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34720 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbeHMBbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 21:31:46 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fozDZ-0002Fn-PS; Sun, 12 Aug 2018 22:52:13 +0000
Date:   Sun, 12 Aug 2018 23:52:13 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] Dealing with icache races around mkdir and object
 creation in general
Message-ID: <20180812225213.GN6515@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* NFS mkdir/open_by_handle race fix
* analogous solution for FUSE, replacing the one currently in mainline
* new primitive to be used when discarding halfway set up inodes on failed
  object creation; gives sane warranties re icache lookups not returning
  such doomed by still not freed inodes.  A bunch of filesystems switched
  to that animal.
* Miklos' fix for last cycle regression in iget5_locked(); -stable will need
  a slightly different variant, unfortunately.
* misc bits and pieces around things icache-related (in adfs and jfs).

The following changes since commit 877f919e192a09e77962a13d7165783027dee5fd:

  proc: add proc_seq_release (2018-06-27 20:44:38 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mkdir

for you to fetch changes up to c7b15a8657da7f8d11269c7cc3d8beef10d26b43:

  jfs: don't bother with make_bad_inode() in ialloc() (2018-08-03 16:03:33 -0400)

----------------------------------------------------------------
Al Viro (11):
      nfs_instantiate(): prevent multiple aliases for directory inode
      kill d_instantiate_no_diralias()
      new primitive: discard_new_inode()
      btrfs: switch to discard_new_inode()
      ufs: switch to discard_new_inode()
      udf: switch to discard_new_inode()
      ext2: make sure that partially set up inodes won't be returned by ext2_iget()
      jfs: switch to discard_new_inode()
      new helper: inode_fake_hash()
      adfs: don't put inodes into icache
      jfs: don't bother with make_bad_inode() in ialloc()

Miklos Szeredi (1):
      vfs: don't evict uninitialized inode

 fs/adfs/inode.c        |   2 +-
 fs/adfs/super.c        |   1 +
 fs/btrfs/inode.c       | 106 ++++++++++++++++++-------------------------------
 fs/dcache.c            |  29 +-------------
 fs/ext2/ialloc.c       |   3 +-
 fs/ext2/namei.c        |   9 ++---
 fs/fuse/dir.c          |  15 +++++--
 fs/hfs/inode.c         |   2 +-
 fs/inode.c             |  53 ++++++++++++++++++++++---
 fs/jfs/jfs_imap.c      |   8 +---
 fs/jfs/jfs_inode.c     |  10 ++---
 fs/jfs/namei.c         |  12 ++----
 fs/jfs/super.c         |   2 +-
 fs/nfs/dir.c           |   9 +++--
 fs/udf/namei.c         |  12 ++----
 fs/ufs/ialloc.c        |   3 +-
 fs/ufs/namei.c         |   9 ++---
 fs/xfs/xfs_iops.c      |   2 +-
 include/linux/dcache.h |   1 -
 include/linux/fs.h     |  17 +++++++-
 20 files changed, 146 insertions(+), 159 deletions(-)
