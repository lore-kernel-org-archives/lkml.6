Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753628AbeE3Lsn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:48:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60638 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751624AbeE3LG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:06:56 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Wen Xu" <wen.xu@gatech.edu>,
        "Theodore Ts'o" <tytso@mit.edu>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.522720252@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 006/153] ext4: fail ext4_iget for root directory if
 unallocated
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 8e4b5eae5decd9dfe5a4ee369c22028f90ab4c44 upstream.

If the root directory has an i_links_count of zero, then when the file
system is mounted, then when ext4_fill_super() notices the problem and
tries to call iput() the root directory in the error return path,
ext4_evict_inode() will try to free the inode on disk, before all of
the file system structures are set up, and this will result in an OOPS
caused by a NULL pointer dereference.

This issue has been assigned CVE-2018-1092.

https://bugzilla.kernel.org/show_bug.cgi?id=199179
https://bugzilla.redhat.com/show_bug.cgi?id=1560777

Reported-by: Wen Xu <wen.xu@gatech.edu>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[bwh: Backported to 3.2:
 - Use EIO instead of EFSCORRUPTED
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3902,6 +3902,13 @@ struct inode *ext4_iget(struct super_blo
 	if (ret < 0)
 		goto bad_inode;
 	raw_inode = ext4_raw_inode(&iloc);
+
+	if ((ino == EXT4_ROOT_INO) && (raw_inode->i_links_count == 0)) {
+		EXT4_ERROR_INODE(inode, "root inode unallocated");
+		ret = -EIO;
+		goto bad_inode;
+	}
+
 	inode->i_mode = le16_to_cpu(raw_inode->i_mode);
 	inode->i_uid = (uid_t)le16_to_cpu(raw_inode->i_uid_low);
 	inode->i_gid = (gid_t)le16_to_cpu(raw_inode->i_gid_low);
