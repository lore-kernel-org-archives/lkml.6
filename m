Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B91CC46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973E720881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973E720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbeG2XfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 19:35:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51516 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeG2XfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 19:35:20 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fjtmX-0003Pd-Do; Sun, 29 Jul 2018 22:03:17 +0000
Date:   Sun, 29 Jul 2018 23:03:17 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCHES][RFC] icache-related stuff
Message-ID: <20180729220317.GB30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assorted icache-related fixes for the next window; some of that is -stable
fodder.

1) NFS and FUSE mkdir/open_by_handle() race fix.  NFS side posted and
discussed earlier, NFS folks hadn't objected...  Basically, the strategy
used by local filesystems to deal with that kind of races does not (and
cannot) work for NFS - there the icache search key is not even known to us
until the underlying (== server-side) data structures for the object being
created look good.  So we need a different approach - just let nfs_mkdir()
use d_splice_alias() and leave the originally passed dentry unhashed
negative if we'd raced and picked an existing alias.  The callers of
->mkdir() are fine with that.   Unlike NFS, FUSE (which has the same kind
of problem) does deal with it in mainline.  However, the same approach
(d_splice_alias() and leave the argument unhashed negative if aliases
exist) works better than what FUSE does in mainline *and* allows to kill
a warty primitive nobody else is using.

      nfs_instantiate(): prevent multiple aliases for directory inode
      kill d_instantiate_no_diralias()

2) The local side of things isn't exactly correct either - typical local
fh_to_dentry() will do icache lookup and if setup fails halfway through
e.g. mkdir(), we are left with a nasty choice - either we leave the
not-quite-set-up inode hashed (and then open_by_handle() can pick it,
with subsequent nasal demons) or we unhash it and risk open_by_handle()
coming immediately after unhash and getting a separate in-core inode
for the same on-disk one, just as the on-disk one gets freed.  Some
filesystems are careful enough with those half-set-up inodes to be
safe (with the first variant, that is).  Some are not.

        Solution: new flag (I_CREATING) set by insert_inode_locked() and
removed by unlock_new_inode() and a new primitive (discard_new_inode())
to be used by such halfway-through-setup failure exits instead of
unlock_new_inode() / iput() combinations.  That primitive unlocks new
inode, but leaves I_CREATING in place.

        iget_locked() treats finding an I_CREATING inode as failure
(-ESTALE, once we sort out the error propagation).
        insert_inode_locked() treats the same as instant -EBUSY.
        ilookup() treats those as icache miss.

A bunch of filesystems switched to discard_new_inode() (btrfs, ufs, udf, ext2,
jfs)
      new primitive: discard_new_inode()
      btrfs: switch to discard_new_inode()
      ufs: switch to discard_new_inode()
      udf: switch to discard_new_inode()
      ext2: make sure that partially set up inodes won't be returned by ext2_iget()
      jfs: switch to discard_new_inode()

3) Miklos' regression fix (he had been too optimistic in iget5_locked cleanups
this window; I'd grumbled about that being wrong, but hadn't realized how
bad it was).
      vfs: don't evict uninitialized inode

4) several btrfs cleanups around btrfs_iget() and friends.
      btrfs: btrfs_iget() never returns an is_bad_inode() inode.
      btrfs: IS_ERR(p) && PTR_ERR(p) == n is a weird way to spell p == ERR_PTR(n)
      btrfs: lift make_bad_inode() into btrfs_iget()
      btrfs: simplify btrfs_iget()

5) misc stuff - new primitive for filesystems that want inodes to look hashed,
but don't want them polluting the hash chains (currently open-coded), making
adfs use that (it never ever looks anything in icache), dropping a cargo-culted
make_bad_inode() in jfs ialloc failure path.
      new helper: inode_fake_hash()
      adfs: don't put inodes into icache
      jfs: don't bother with make_bad_inode() in ialloc()
