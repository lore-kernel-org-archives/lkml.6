Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751303AbeBPUik (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:38:40 -0500
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:35645 "EHLO
        rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbeBPUeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:34:01 -0500
X-IronPort-AV: E=Sophos;i="5.46,520,1511827200";
   d="scan'208";a="359949663"
From: Taras Kondratiuk <takondra@cisco.com>
To: "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James McMechan <james.w.mcmechan@gmail.com>
Cc: initramfs@vger.kernel.org, Victor Kamensky <kamensky@cisco.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, xe-linux-external@cisco.com
Subject: [PATCH v3 05/15] initramfs: move files creation into separate state
Date: Fri, 16 Feb 2018 20:33:41 +0000
Message-Id: <1518813234-5874-6-git-send-email-takondra@cisco.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518813234-5874-1-git-send-email-takondra@cisco.com>
References: <1518813234-5874-1-git-send-email-takondra@cisco.com>
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Authenticated-User: takondra@cisco.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move most of the file creation logic into a separate state. This splits
collection of data stage from data processing and makes it easier to add
additional states for a new archive format.

Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
---
 init/initramfs.c | 52 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index d0ab7ad6ac05..2d5920c094e0 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -192,6 +192,7 @@ static int __init do_collect(void);
 static int __init do_header(void);
 static int __init do_skip(void);
 static int __init do_name(void);
+static int __init do_create(void);
 static int __init do_copy(void);
 static int __init do_symlink(void);
 static int __init do_reset(void);
@@ -292,12 +293,12 @@ static int __init do_reset(void)
 	return 1;
 }
 
-static int __init maybe_link(void)
+static int __init maybe_link(char *name)
 {
 	if (nlink >= 2) {
-		char *old = find_link(major, minor, ino, mode, collected);
+		char *old = find_link(major, minor, ino, mode, name);
 		if (old)
-			return (sys_link(old, collected) < 0) ? -1 : 1;
+			return (sys_link(old, name) < 0) ? -1 : 1;
 	}
 	return 0;
 }
@@ -321,52 +322,59 @@ static void *memcpy_optional(void *dest, const void *src, size_t n)
 	return dest;
 }
 
-static __initdata int wfd;
-
 static int __init do_name(void)
 {
-	state = do_skip;
-	next_state = do_reset;
 	if (strcmp(collected, "TRAILER!!!") == 0) {
+		state = do_skip;
+		next_state = do_reset;
 		free_hash();
 		return 0;
 	}
-	clean_path(collected, mode);
+	memcpy_optional(name_buf, collected, N_ALIGN(name_len));
+	state = do_create;
+	return 0;
+}
+
+
+static __initdata int wfd;
+
+static int __init do_create(void)
+{
+	state = do_skip;
+	next_state = do_reset;
+	clean_path(name_buf, mode);
 	if (S_ISREG(mode)) {
-		int ml = maybe_link();
+		int ml = maybe_link(name_buf);
 		if (ml >= 0) {
 			int openflags = O_WRONLY|O_CREAT;
 			if (ml != 1)
 				openflags |= O_TRUNC;
-			wfd = sys_open(collected, openflags, mode);
+			wfd = sys_open(name_buf, openflags, mode);
 
 			if (wfd >= 0) {
 				sys_fchown(wfd, uid, gid);
 				sys_fchmod(wfd, mode);
 				if (body_len)
 					sys_ftruncate(wfd, body_len);
-				memcpy_optional(name_buf, collected,
-						N_ALIGN(name_len));
 				state = do_copy;
 			}
 		}
 	} else if (S_ISDIR(mode)) {
-		sys_mkdir(collected, mode);
-		sys_chown(collected, uid, gid);
-		sys_chmod(collected, mode);
-		dir_add(collected, mtime);
+		sys_mkdir(name_buf, mode);
+		sys_chown(name_buf, uid, gid);
+		sys_chmod(name_buf, mode);
+		dir_add(name_buf, mtime);
 	} else if (S_ISBLK(mode) || S_ISCHR(mode) ||
 		   S_ISFIFO(mode) || S_ISSOCK(mode)) {
-		if (maybe_link() == 0) {
-			sys_mknod(collected, mode, rdev);
-			sys_chown(collected, uid, gid);
-			sys_chmod(collected, mode);
-			do_utime(collected, mtime);
+		if (maybe_link(name_buf) == 0) {
+			sys_mknod(name_buf, mode, rdev);
+			sys_chown(name_buf, uid, gid);
+			sys_chmod(name_buf, mode);
+			do_utime(name_buf, mtime);
 		}
 	} else if (S_ISLNK(mode)) {
 		if (body_len > PATH_MAX)
 			return 0;
-		memcpy_optional(name_buf, collected, N_ALIGN(name_len));
 		read_into(symlink_buf, body_len, do_symlink);
 	}
 	return 0;
-- 
2.10.3.dirty
