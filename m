Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751743AbeDDEpb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 00:45:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44746 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbeDDEp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 00:45:29 -0400
Date: Wed, 4 Apr 2018 05:45:28 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] vfs pile 1 (dcache)
Message-ID: <20180404044528.GM30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	fs/dcache.c work, mostly - part of that is what trylock elimination
series has turned into, part - making d_move() preserve the parent (and thus
the path) of victim, plus some general cleanups.

The following changes since commit 8cc07c808c9d595e81cbe5aad419b7769eb2e5c9:

  fs: dcache: Use READ_ONCE when accessing i_dir_seq (2018-02-25 12:51:10 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dcache

for you to fetch changes up to 04bbc9795d2e89c79edf48fb1303ace2e8c90a60:

  Merge branch 'old.dcache' into work.dcache (2018-04-04 00:40:19 -0400)

----------------------------------------------------------------
Al Viro (19):
      take write_seqcount_invalidate() into __d_drop()
      d_delete(): get rid of trylock loop
      get rid of trylock loop in locking dentries on shrink list
      now lock_parent() can't run into killed dentry
      split the slow part of lock_parent() off
      dput(): consolidate the "do we need to retain it?" into an inlined helper
      handle move to LRU in retain_dentry()
      get rid of trylock loop around dentry_kill()
      dcache.c: trim includes
      split d_path() and friends into a separate file
      take out orphan externs (empty_string/slash_string)
      fold lookup_real() into __lookup_hash()
      debugfs_lookup(): switch to lookup_one_len_unlocked()
      lustre: get rid of pointless casts to struct dentry *
      oprofilefs: don't oops on allocation failure
      make non-exchanging __d_move() copy ->d_parent rather than swap them
      fold dentry_lock_for_move() into its sole caller and clean it up
      d_genocide: move export to definition
      Merge branch 'old.dcache' into work.dcache

John Ogness (3):
      fs/dcache: Remove stale comment from dentry_kill()
      fs/dcache: Move dentry_kill() below lock_parent()
      fs/dcache: Avoid a try_lock loop in shrink_dentry_list()

NeilBrown (1):
      constify more dcache.h inlined helpers.

 drivers/oprofile/oprofilefs.c                |   3 +
 drivers/staging/lustre/lustre/llite/dcache.c |   6 +-
 fs/Makefile                                  |   2 +-
 fs/d_path.c                                  | 470 +++++++++++++
 fs/dcache.c                                  | 966 +++++++--------------------
 fs/debugfs/inode.c                           |   5 +-
 fs/namei.c                                   |  41 +-
 include/linux/dcache.h                       |   6 +-
 8 files changed, 735 insertions(+), 764 deletions(-)
 create mode 100644 fs/d_path.c
