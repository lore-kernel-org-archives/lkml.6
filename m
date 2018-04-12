Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754105AbeDLPTF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:19:05 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41095 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753468AbeDLPI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:08:56 -0400
X-Google-Smtp-Source: AIpwx4/0LL5XMvuEdbicKnfxNcs6I7J1QZoY1GFRmhzTkM4MmTlX5xyKY2WCxMvwHexOzliaPxANCQ==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 20/35] vfs: don't open real
Date: Thu, 12 Apr 2018 17:08:11 +0200
Message-Id: <20180412150826.20988-21-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180412150826.20988-1-mszeredi@redhat.com>
References: <20180412150826.20988-1-mszeredi@redhat.com>
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
index d509705d5740..1d1a52908b0f 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -857,13 +857,8 @@ EXPORT_SYMBOL(file_path);
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
 
 struct file *path_open(const struct path *path, int flags, struct inode *inode,
-- 
2.14.3
