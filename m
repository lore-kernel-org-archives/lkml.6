Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65C0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6602089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866525;
	bh=PXAljcp/bZXcBQAOMy1Fk+yOAaPAsHcTKFVocdYK6QM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rAl7aP3KT1y+PCSGuwYjJGlsOSJCXBcwXx9ZZc+9P5y73VDYt5EG37vwOdpA4oJVa
	 pxogTEA7GnFvbj10fvn+yJR4DcqNKnkufSrPEtNxuCxLxj+vYjupWST19wPaoksCkJ
	 ++4OTa355a98skCO7qGV/ZtxyaeupuxRzP0sKkWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731701AbfAGNIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:08:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:55758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731460AbfAGNIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:08:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC0302147C;
        Mon,  7 Jan 2019 13:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866520;
        bh=PXAljcp/bZXcBQAOMy1Fk+yOAaPAsHcTKFVocdYK6QM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WU6sq9tHZKbYPOoWE9uCyAm6A0ZP//C/6f+glymxmRErl4GGYlF6HwCp5KgwZHpfn
         aY8y5K+IvuRgvvRaJN5xSaDIK6G7XV50tdIwOC1whscdrfY+5++1G9OisiefauYJbT
         DVJs76okNBx+ugIOBSWicBbU4OQo9Ot6L3KluZjs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vijay Chidambaram <vvijay03@gmail.com>,
        Jayashree Mohan <jayashree2912@gmail.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.9 57/71] Btrfs: fix fsync of files with multiple hard links in new directories
Date:   Mon,  7 Jan 2019 13:33:26 +0100
Message-Id: <20190107105335.984727646@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
References: <20190107105330.280153213@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 41bd60676923822de1df2c50b3f9a10171f4338a upstream.

The log tree has a long standing problem that when a file is fsync'ed we
only check for new ancestors, created in the current transaction, by
following only the hard link for which the fsync was issued. We follow the
ancestors using the VFS' dget_parent() API. This means that if we create a
new link for a file in a directory that is new (or in an any other new
ancestor directory) and then fsync the file using an old hard link, we end
up not logging the new ancestor, and on log replay that new hard link and
ancestor do not exist. In some cases, involving renames, the file will not
exist at all.

Example:

  mkfs.btrfs -f /dev/sdb
  mount /dev/sdb /mnt

  mkdir /mnt/A
  touch /mnt/foo
  ln /mnt/foo /mnt/A/bar
  xfs_io -c fsync /mnt/foo

  <power failure>

In this example after log replay only the hard link named 'foo' exists
and directory A does not exist, which is unexpected. In other major linux
filesystems, such as ext4, xfs and f2fs for example, both hard links exist
and so does directory A after mounting again the filesystem.

Checking if any new ancestors are new and need to be logged was added in
2009 by commit 12fcfd22fe5b ("Btrfs: tree logging unlink/rename fixes"),
however only for the ancestors of the hard link (dentry) for which the
fsync was issued, instead of checking for all ancestors for all of the
inode's hard links.

So fix this by tracking the id of the last transaction where a hard link
was created for an inode and then on fsync fallback to a full transaction
commit when an inode has more than one hard link and at least one new hard
link was created in the current transaction. This is the simplest solution
since this is not a common use case (adding frequently hard links for
which there's an ancestor created in the current transaction and then
fsync the file). In case it ever becomes a common use case, a solution
that consists of iterating the fs/subvol btree for each hard link and
check if any ancestor is new, could be implemented.

This solves many unexpected scenarios reported by Jayashree Mohan and
Vijay Chidambaram, and for which there is a new test case for fstests
under review.

Fixes: 12fcfd22fe5b ("Btrfs: tree logging unlink/rename fixes")
CC: stable@vger.kernel.org # 4.4+
Reported-by: Vijay Chidambaram <vvijay03@gmail.com>
Reported-by: Jayashree Mohan <jayashree2912@gmail.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/btrfs_inode.h |    6 ++++++
 fs/btrfs/inode.c       |   17 +++++++++++++++++
 fs/btrfs/tree-log.c    |   16 ++++++++++++++++
 3 files changed, 39 insertions(+)

--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -154,6 +154,12 @@ struct btrfs_inode {
 	u64 last_unlink_trans;
 
 	/*
+	 * Track the transaction id of the last transaction used to create a
+	 * hard link for the inode. This is used by the log tree (fsync).
+	 */
+	u64 last_link_trans;
+
+	/*
 	 * Number of bytes outstanding that are going to need csums.  This is
 	 * used in ENOSPC accounting.
 	 */
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3805,6 +3805,21 @@ cache_index:
 	 * inode is not a directory, logging its parent unnecessarily.
 	 */
 	BTRFS_I(inode)->last_unlink_trans = BTRFS_I(inode)->last_trans;
+	/*
+	 * Similar reasoning for last_link_trans, needs to be set otherwise
+	 * for a case like the following:
+	 *
+	 * mkdir A
+	 * touch foo
+	 * ln foo A/bar
+	 * echo 2 > /proc/sys/vm/drop_caches
+	 * fsync foo
+	 * <power failure>
+	 *
+	 * Would result in link bar and directory A not existing after the power
+	 * failure.
+	 */
+	BTRFS_I(inode)->last_link_trans = BTRFS_I(inode)->last_trans;
 
 	path->slots[0]++;
 	if (inode->i_nlink != 1 ||
@@ -6670,6 +6685,7 @@ static int btrfs_link(struct dentry *old
 			if (err)
 				goto fail;
 		}
+		BTRFS_I(inode)->last_link_trans = trans->transid;
 		d_instantiate(dentry, inode);
 		btrfs_log_new_name(trans, inode, NULL, parent);
 	}
@@ -9383,6 +9399,7 @@ struct inode *btrfs_alloc_inode(struct s
 	ei->index_cnt = (u64)-1;
 	ei->dir_index = 0;
 	ei->last_unlink_trans = 0;
+	ei->last_link_trans = 0;
 	ei->last_log_commit = 0;
 	ei->delayed_iput_count = 0;
 
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5549,6 +5549,22 @@ static int btrfs_log_inode_parent(struct
 			goto end_trans;
 	}
 
+	/*
+	 * If a new hard link was added to the inode in the current transaction
+	 * and its link count is now greater than 1, we need to fallback to a
+	 * transaction commit, otherwise we can end up not logging all its new
+	 * parents for all the hard links. Here just from the dentry used to
+	 * fsync, we can not visit the ancestor inodes for all the other hard
+	 * links to figure out if any is new, so we fallback to a transaction
+	 * commit (instead of adding a lot of complexity of scanning a btree,
+	 * since this scenario is not a common use case).
+	 */
+	if (inode->vfs_inode.i_nlink > 1 &&
+	    inode->last_link_trans > last_committed) {
+		ret = -EMLINK;
+		goto end_trans;
+	}
+
 	while (1) {
 		if (!parent || d_really_is_negative(parent) || sb != parent->d_sb)
 			break;


