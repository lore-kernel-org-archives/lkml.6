Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935689AbeE2OoH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:44:07 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38089 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935576AbeE2Ony (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:43:54 -0400
X-Google-Smtp-Source: ADUXVKJiMhRbbefCG1RSRVRdtnwves/SKI1YyEdLnfTMfMpiQOqSEsmA0g1nJvQmTxT3fE+H6cWUzw==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/39] ovl: copy up inode flags
Date: Tue, 29 May 2018 16:43:10 +0200
Message-Id: <20180529144339.16538-11-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529144339.16538-1-mszeredi@redhat.com>
References: <20180529144339.16538-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On inode creation copy certain inode flags from the underlying real inode
to the overlay inode.

This is in preparation for moving overlay functionality out of the VFS.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/overlayfs.h | 7 +++++++
 fs/overlayfs/util.c      | 1 +
 2 files changed, 8 insertions(+)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index eeaad0710704..e9dab319c8b2 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -350,6 +350,13 @@ static inline void ovl_copyattr(struct inode *from, struct inode *to)
 	to->i_ctime = from->i_ctime;
 }
 
+static inline void ovl_copyflags(struct inode *from, struct inode *to)
+{
+	unsigned int mask = S_SYNC | S_IMMUTABLE | S_APPEND | S_NOATIME;
+
+	inode_set_flags(to, from->i_flags & mask, mask);
+}
+
 /* dir.c */
 extern const struct inode_operations ovl_dir_inode_operations;
 int ovl_cleanup_and_whiteout(struct dentry *workdir, struct inode *dir,
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 30a05d1d679d..25d202b47326 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -310,6 +310,7 @@ void ovl_inode_init(struct inode *inode, struct dentry *upperdentry,
 		OVL_I(inode)->lower = igrab(d_inode(lowerdentry));
 
 	ovl_copyattr(realinode, inode);
+	ovl_copyflags(realinode, inode);
 	if (!inode->i_ino)
 		inode->i_ino = realinode->i_ino;
 }
-- 
2.14.3
