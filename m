Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753268AbeDLPIn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:08:43 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51324 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753265AbeDLPIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:08:38 -0400
X-Google-Smtp-Source: AIpwx49zwyxXcwsdz3jUmZItcAXOjHahtw/haO3ZYPy5JCsUG9Z0Cs8Zdk87XOgRzCqi9F/7kBi3Tg==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 05/35] ovl: copy up inode flags
Date: Thu, 12 Apr 2018 17:07:56 +0200
Message-Id: <20180412150826.20988-6-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180412150826.20988-1-mszeredi@redhat.com>
References: <20180412150826.20988-1-mszeredi@redhat.com>
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
index eef720ef0f07..265cb288417a 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -357,6 +357,13 @@ static inline void ovl_copyattr(struct inode *from, struct inode *to)
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
 struct dentry *ovl_lookup_temp(struct dentry *workdir);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 11e62e70733a..586f8d7440bb 100644
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
