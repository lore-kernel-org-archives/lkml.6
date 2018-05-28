Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933508AbeE1QGp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:06:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936674AbeE1KOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:14:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Subject: [PATCH 4.4 016/268] xfs: remove racy hasattr check from attr ops
Date: Mon, 28 May 2018 11:59:50 +0200
Message-Id: <20180528100203.941403919@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Foster <bfoster@redhat.com>

commit 5a93790d4e2df73e30c965ec6e49be82fc3ccfce upstream.

xfs_attr_[get|remove]() have unlocked attribute fork checks to optimize
away a lock cycle in cases where the fork does not exist or is otherwise
empty. This check is not safe, however, because an attribute fork short
form to extent format conversion includes a transient state that causes
the xfs_inode_hasattr() check to fail. Specifically,
xfs_attr_shortform_to_leaf() creates an empty extent format attribute
fork and then adds the existing shortform attributes to it.

This means that lookup of an existing xattr can spuriously return
-ENOATTR when racing against a setxattr that causes the associated
format conversion. This was originally reproduced by an untar on a
particularly configured glusterfs volume, but can also be reproduced on
demand with properly crafted xattr requests.

The format conversion occurs under the exclusive ilock. xfs_attr_get()
and xfs_attr_remove() already have the proper locking and checks further
down in the functions to handle this situation correctly. Drop the
unlocked checks to avoid the spurious failure and rely on the existing
logic.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Cc: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/xfs/libxfs/xfs_attr.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -130,9 +130,6 @@ xfs_attr_get(
 	if (XFS_FORCED_SHUTDOWN(ip->i_mount))
 		return -EIO;
 
-	if (!xfs_inode_hasattr(ip))
-		return -ENOATTR;
-
 	error = xfs_attr_args_init(&args, ip, name, flags);
 	if (error)
 		return error;
@@ -417,9 +414,6 @@ xfs_attr_remove(
 	if (XFS_FORCED_SHUTDOWN(dp->i_mount))
 		return -EIO;
 
-	if (!xfs_inode_hasattr(dp))
-		return -ENOATTR;
-
 	error = xfs_attr_args_init(&args, dp, name, flags);
 	if (error)
 		return error;
