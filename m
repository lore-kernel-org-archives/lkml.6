Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935708AbeE2POo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:14:44 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:53393 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935212AbeE2On4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:43:56 -0400
X-Google-Smtp-Source: ADUXVKICF75KgsfW5LNxLumPVNw7yFVqii9fNVrBfPcWFfmog8obqv6ofbcYraWMez7aIhNngvbDnQ==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/39] ovl: copy up file size as well
Date: Tue, 29 May 2018 16:43:12 +0200
Message-Id: <20180529144339.16538-13-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144339.16538-1-mszeredi@redhat.com>
References: <20180529144339.16538-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy i_size of the underlying inode to the overlay inode in ovl_copyattr().

This is in preparation for stacking I/O operations on overlay files.

This patch shouldn't have any observable effect.

Remove stale comment from ovl_setattr() [spotted by Vivek Goyal].

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/inode.c     | 9 ---------
 fs/overlayfs/overlayfs.h | 2 ++
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 0116ec12451d..6682ea63c4fd 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -22,15 +22,6 @@ int ovl_setattr(struct dentry *dentry, struct iattr *attr)
 	struct dentry *upperdentry;
 	const struct cred *old_cred;
 
-	/*
-	 * Check for permissions before trying to copy-up.  This is redundant
-	 * since it will be rechecked later by ->setattr() on upper dentry.  But
-	 * without this, copy-up can be triggered by just about anybody.
-	 *
-	 * We don't initialize inode->size, which just means that
-	 * inode_newsize_ok() will always check against MAX_LFS_FILESIZE and not
-	 * check for a swapfile (which this won't be anyway).
-	 */
 	err = setattr_prepare(dentry, attr);
 	if (err)
 		return err;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index e9dab319c8b2..419c80a0024e 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -9,6 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/uuid.h>
+#include <linux/fs.h>
 #include "ovl_entry.h"
 
 enum ovl_path_type {
@@ -348,6 +349,7 @@ static inline void ovl_copyattr(struct inode *from, struct inode *to)
 	to->i_atime = from->i_atime;
 	to->i_mtime = from->i_mtime;
 	to->i_ctime = from->i_ctime;
+	i_size_write(to, i_size_read(from));
 }
 
 static inline void ovl_copyflags(struct inode *from, struct inode *to)
-- 
2.14.3
