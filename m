Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752457AbeEGItY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 04:49:24 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35606 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752088AbeEGIiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 04:38:21 -0400
X-Google-Smtp-Source: AB8JxZoGVVcgJgNyUo699H/9lBAGPEdQvU7lXX93voB+RsR6PTsyH1X0BiWRAMPVbn6OdN8MjyTDvg==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/35] ovl: copy up inode flags
Date: Mon,  7 May 2018 10:37:39 +0200
Message-Id: <20180507083807.28792-8-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507083807.28792-1-mszeredi@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com>
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
index 271561fa7882..4e26778774c3 100644
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
 struct dentry *ovl_lookup_temp(struct dentry *workdir);
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
