Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751679AbeDEKq3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 06:46:29 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41503 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751251AbeDEKp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 06:45:56 -0400
X-Google-Smtp-Source: AIpwx49JahAJmmcQ04o26IR6F5HbQEriXrtZZj4zqLzxblezS1Ln1x8hSkYadN5pDrVWYwR2lri2vQ==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: ebiederm@xmission.com, torvalds@linux-foundation.o,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/3] namei: add follow_up_bind()
Date: Thu,  5 Apr 2018 12:45:47 +0200
Message-Id: <20180405104549.12365-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180405104549.12365-1-christian.brauner@ubuntu.com>
References: <20180405104549.12365-1-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new helper for resolving bind-mounts.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/namei.c            | 10 ++++++++++
 include/linux/namei.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index a09419379f5d..4fa56ec78f63 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1085,6 +1085,16 @@ int follow_up(struct path *path)
 }
 EXPORT_SYMBOL(follow_up);
 
+/*
+ * follow_up_bind - Resolve bind-mounts to mountpoint of path's vfsmount
+ */
+inline void follow_up_bind(struct path *path)
+{
+	while (path->mnt->mnt_root == path->dentry && follow_up(path))
+		;
+}
+EXPORT_SYMBOL(follow_up_bind);
+
 /*
  * Perform an automount
  * - return -EISDIR to tell follow_managed() to stop and return the path we
diff --git a/include/linux/namei.h b/include/linux/namei.h
index a982bb7cd480..ea93127be26c 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -87,6 +87,7 @@ extern struct dentry *lookup_one_len_unlocked(const char *, struct dentry *, int
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *);
 extern int follow_up(struct path *);
+extern void follow_up_bind(struct path *path);
 
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
-- 
2.15.1
