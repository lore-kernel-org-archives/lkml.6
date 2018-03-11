Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932508AbeCKK7o (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 06:59:44 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:54380 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932241AbeCKK4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 06:56:52 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Subject: [RFC PATCH 05/35] syscalls: do not call sys_readlinkat() within the kernel
Date: Sun, 11 Mar 2018 11:55:27 +0100
Message-Id: <20180311105557.20807-6-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180311105557.20807-1-linux@dominikbrodowski.net>
References: <20180311105557.20807-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/stat.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index 873785dae022..f8e6fb2c3657 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -379,8 +379,8 @@ SYSCALL_DEFINE2(newfstat, unsigned int, fd, struct stat __user *, statbuf)
 	return error;
 }
 
-SYSCALL_DEFINE4(readlinkat, int, dfd, const char __user *, pathname,
-		char __user *, buf, int, bufsiz)
+static int do_readlinkat(int dfd, const char __user *pathname,
+			 char __user *buf, int bufsiz)
 {
 	struct path path;
 	int error;
@@ -415,10 +415,16 @@ SYSCALL_DEFINE4(readlinkat, int, dfd, const char __user *, pathname,
 	return error;
 }
 
+SYSCALL_DEFINE4(readlinkat, int, dfd, const char __user *, pathname,
+		char __user *, buf, int, bufsiz)
+{
+	return do_readlinkat(dfd, pathname, buf, bufsiz);
+}
+
 SYSCALL_DEFINE3(readlink, const char __user *, path, char __user *, buf,
 		int, bufsiz)
 {
-	return sys_readlinkat(AT_FDCWD, path, buf, bufsiz);
+	return do_readlinkat(AT_FDCWD, path, buf, bufsiz);
 }
 
 
-- 
2.16.2
