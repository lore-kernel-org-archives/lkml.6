Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753899AbeDLPSB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:18:01 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44661 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753399AbeDLPI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:08:59 -0400
X-Google-Smtp-Source: AIpwx4+XZproQJ3gIU4bke4vamdvrOCKcV4FCfHKxr5i3qF7/wsuVnsImv8IzhPeZyVAFdFHqwur2A==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 23/35] vfs: simplify dentry_open()
Date: Thu, 12 Apr 2018 17:08:14 +0200
Message-Id: <20180412150826.20988-24-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180412150826.20988-1-mszeredi@redhat.com>
References: <20180412150826.20988-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dentry_open() can now just call path_open().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/open.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 1d1a52908b0f..442088ca30f9 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -891,31 +891,13 @@ EXPORT_SYMBOL(path_open);
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
-	if (!IS_ERR(f)) {
-		f->f_flags = flags;
-		error = vfs_open(path, f, cred);
-		if (!error) {
-			/* from now on we need fput() to dispose of f */
-			error = open_check_o_direct(f);
-			if (error) {
-				fput(f);
-				f = ERR_PTR(error);
-			}
-		} else { 
-			put_filp(f);
-			f = ERR_PTR(error);
-		}
-	}
-	return f;
+	return path_open(path, flags, d_backing_inode(path->dentry), cred,
+			 true);
 }
 EXPORT_SYMBOL(dentry_open);
 
-- 
2.14.3
