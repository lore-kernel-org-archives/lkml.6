Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeEGImx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 04:42:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39059 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbeEGIii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 04:38:38 -0400
X-Google-Smtp-Source: AB8JxZoZ44kg72TIlboG5TeeOv0XTxgxWk5k0Hm6O2X6yWmVj26AASntgUVt3w4o9IN0Fkp95dTK3g==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 22/35] vfs: don't open real
Date: Mon,  7 May 2018 10:37:54 +0200
Message-Id: <20180507083807.28792-23-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507083807.28792-1-mszeredi@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let overlayfs do its thing when opening a file.

This enables stacking and fixes the corner case when a file is opened for
read, modified through a writable open, and data is read from the read-only
file.  After this patch the read-only open will not return stale data even
in this case.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/open.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 6e52fd6fea7c..244cd2ecfefd 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -897,13 +897,8 @@ EXPORT_SYMBOL(file_path);
 int vfs_open(const struct path *path, struct file *file,
 	     const struct cred *cred)
 {
-	struct dentry *dentry = d_real(path->dentry, NULL, file->f_flags, 0);
-
-	if (IS_ERR(dentry))
-		return PTR_ERR(dentry);
-
 	file->f_path = *path;
-	return do_dentry_open(file, d_backing_inode(dentry), NULL, cred);
+	return do_dentry_open(file, d_backing_inode(path->dentry), NULL, cred);
 }
 
 /**
-- 
2.14.3
