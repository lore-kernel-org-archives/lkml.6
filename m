Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165308AbeE1NSs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:18:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163574AbeE1Ktu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:49:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 193/496] Btrfs: fix log replay failure after linking special file and fsync
Date: Mon, 28 May 2018 11:59:38 +0200
Message-Id: <20180528100328.068476411@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 9a6509c4daa91400b52a5fd541a5521c649a8fea ]

If in the same transaction we rename a special file (fifo, character/block
device or symbolic link), create a hard link for it having its old name
then sync the log, we will end up with a log that can not be replayed and
at when attempting to replay it, an EEXIST error is returned and mounting
the filesystem fails. Example scenario:

  $ mkfs.btrfs -f /dev/sdc
  $ mount /dev/sdc /mnt
  $ mkdir /mnt/testdir
  $ mkfifo /mnt/testdir/foo
  # Make sure everything done so far is durably persisted.
  $ sync

  # Create some unrelated file and fsync it, this is just to create a log
  # tree. The file must be in the same directory as our special file.
  $ touch /mnt/testdir/f1
  $ xfs_io -c "fsync" /mnt/testdir/f1

  # Rename our special file and then create a hard link with its old name.
  $ mv /mnt/testdir/foo /mnt/testdir/bar
  $ ln /mnt/testdir/bar /mnt/testdir/foo

  # Create some other unrelated file and fsync it, this is just to persist
  # the log tree which was modified by the previous rename and link
  # operations. Alternatively we could have modified file f1 and fsync it.
  $ touch /mnt/f2
  $ xfs_io -c "fsync" /mnt/f2

  <power failure>

  $ mount /dev/sdc /mnt
  mount: mount /dev/sdc on /mnt failed: File exists

This happens because when both the log tree and the subvolume's tree have
an entry in the directory "testdir" with the same name, that is, there
is one key (258 INODE_REF 257) in the subvolume tree and another one in
the log tree (where 258 is the inode number of our special file and 257
is the inode for directory "testdir"). Only the data of those two keys
differs, in the subvolume tree the index field for inode reference has
a value of 3 while the log tree it has a value of 5. Because the same key
exists in both trees, but have different index, the log replay fails with
an -EEXIST error when attempting to replay the inode reference from the
log tree.

Fix this by setting the last_unlink_trans field of the inode (our special
file) to the current transaction id when a hard link is created, as this
forces logging the parent directory inode, solving the conflict at log
replay time.

A new generic test case for fstests was also submitted.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/tree-log.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5888,7 +5888,7 @@ int btrfs_log_new_name(struct btrfs_tran
 	 * this will force the logging code to walk the dentry chain
 	 * up for the file
 	 */
-	if (S_ISREG(inode->vfs_inode.i_mode))
+	if (!S_ISDIR(inode->vfs_inode.i_mode))
 		inode->last_unlink_trans = trans->transid;
 
 	/*
