Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752402AbeEGImn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 04:42:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52519 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752195AbeEGIil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 04:38:41 -0400
X-Google-Smtp-Source: AB8JxZoqX/nrRlNVbVrnvpoFtHe5tTVgPS2lsL5lm5VjeyxugQdBKqXei/kxf6Bhqltn0QIeb4NfQg==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 24/35] vfs: simplify dentry_open()
Date: Mon,  7 May 2018 10:37:56 +0200
Message-Id: <20180507083807.28792-25-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507083807.28792-1-mszeredi@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dentry_open() can now just call path_open().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/open.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 244cd2ecfefd..1d4bc541c619 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -935,25 +935,12 @@ EXPORT_SYMBOL(path_open);
 struct file *dentry_open(const struct path *path, int flags,
 			 const struct cred *cred)
 {
-	int error;
-	struct file *f;
-
 	validate_creds(cred);
 
 	/* We must always pass in a valid mount pointer. */
 	BUG_ON(!path->mnt);
 
-	f = get_empty_filp();
-	if (IS_ERR(f))
-		return f;
-
-	f->f_flags = flags;
-	error = vfs_open(path, f, cred);
-	if (error) {
-		put_filp(f);
-		return ERR_PTR(error);
-	}
-	return f;
+	return path_open(path, flags, d_backing_inode(path->dentry), cred, true);
 }
 EXPORT_SYMBOL(dentry_open);
 
-- 
2.14.3
