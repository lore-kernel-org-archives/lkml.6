Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932878AbeCOTHz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:07:55 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36304 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932681AbeCOTGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:06:24 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc: luto@kernel.org, mingo@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Subject: [PATCH v2 05/36] fs: add do_readlinkat() helper; remove internal call to sys_readlinkat()
Date: Thu, 15 Mar 2018 20:04:58 +0100
Message-Id: <20180315190529.20943-6-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315190529.20943-1-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the do_readlinkat() helper removes an in-kernel call to the
sys_readlinkat() syscall.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
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
