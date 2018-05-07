Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeEGIlB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 04:41:01 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37284 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752222AbeEGIio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 04:38:44 -0400
X-Google-Smtp-Source: AB8JxZqjC0tnSsbAXMV4obtYSI5ORzPz77tbCvglTLp319TPkUv8i0Zx15LJTChLtFq0QuFsnspFCA==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 27/35] vfs: fix freeze protection in mnt_want_write_file() for overlayfs
Date: Mon,  7 May 2018 10:37:59 +0200
Message-Id: <20180507083807.28792-28-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180507083807.28792-1-mszeredi@redhat.com>
References: <20180507083807.28792-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The underlying real file used by overlayfs still contains the overlay path.
This results in mnt_want_write_file() calls by the filesystem getting
freeze protection on the wrong inode (the overlayfs one instead of the real
one).

Fix by using file_inode(file)->i_sb instead of file->f_path.mnt->mnt_sb.

Reported-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5286c5313e67..0d9023a9af4f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -441,10 +441,10 @@ int mnt_want_write_file(struct file *file)
 {
 	int ret;
 
-	sb_start_write(file->f_path.mnt->mnt_sb);
+	sb_start_write(file_inode(file)->i_sb);
 	ret = __mnt_want_write_file(file);
 	if (ret)
-		sb_end_write(file->f_path.mnt->mnt_sb);
+		sb_end_write(file_inode(file)->i_sb);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mnt_want_write_file);
@@ -486,7 +486,8 @@ void __mnt_drop_write_file(struct file *file)
 
 void mnt_drop_write_file(struct file *file)
 {
-	mnt_drop_write(file->f_path.mnt);
+	__mnt_drop_write_file(file);
+	sb_end_write(file_inode(file)->i_sb);
 }
 EXPORT_SYMBOL(mnt_drop_write_file);
 
-- 
2.14.3
