Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932359AbeCKK5A (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 06:57:00 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:54322 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932194AbeCKK4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 06:56:49 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Subject: [RFC PATCH 07/35] syscalls: do not call sys_renameat2() within the kernel
Date: Sun, 11 Mar 2018 11:55:29 +0100
Message-Id: <20180311105557.20807-8-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180311105557.20807-1-linux@dominikbrodowski.net>
References: <20180311105557.20807-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/namei.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 921ae32dbc80..524e829ffc7d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4478,8 +4478,8 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 }
 EXPORT_SYMBOL(vfs_rename);
 
-SYSCALL_DEFINE5(renameat2, int, olddfd, const char __user *, oldname,
-		int, newdfd, const char __user *, newname, unsigned int, flags)
+static int do_renameat2(int olddfd, const char __user *oldname, int newdfd,
+			const char __user *newname, unsigned int flags)
 {
 	struct dentry *old_dentry, *new_dentry;
 	struct dentry *trap;
@@ -4621,15 +4621,21 @@ SYSCALL_DEFINE5(renameat2, int, olddfd, const char __user *, oldname,
 	return error;
 }
 
+SYSCALL_DEFINE5(renameat2, int, olddfd, const char __user *, oldname,
+		int, newdfd, const char __user *, newname, unsigned int, flags)
+{
+	return do_renameat2(olddfd, oldname, newdfd, newname, flags);
+}
+
 SYSCALL_DEFINE4(renameat, int, olddfd, const char __user *, oldname,
 		int, newdfd, const char __user *, newname)
 {
-	return sys_renameat2(olddfd, oldname, newdfd, newname, 0);
+	return do_renameat2(olddfd, oldname, newdfd, newname, 0);
 }
 
 SYSCALL_DEFINE2(rename, const char __user *, oldname, const char __user *, newname)
 {
-	return sys_renameat2(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
+	return do_renameat2(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
 }
 
 int vfs_whiteout(struct inode *dir, struct dentry *dentry)
-- 
2.16.2
