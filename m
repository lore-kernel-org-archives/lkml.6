Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751573AbeDEKvX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 06:51:23 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40014 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeDEKvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 06:51:21 -0400
X-Google-Smtp-Source: AIpwx495kef4mG77DmfpG9NoYE3l07Qs/VSuDbI5Ub9U0V0tHHnkl7kaYYcOWbIAMX3uXYIsMKxrgw==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/3 RESEND] namei: add follow_up_bind()
Date: Thu,  5 Apr 2018 12:51:01 +0200
Message-Id: <20180405105103.21572-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180405105103.21572-1-christian.brauner@ubuntu.com>
References: <20180405105103.21572-1-christian.brauner@ubuntu.com>
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
