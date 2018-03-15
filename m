Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932907AbeCOTIC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:08:02 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36270 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932671AbeCOTGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:06:24 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc: luto@kernel.org, mingo@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Subject: [PATCH v2 08/36] fs: add do_futimesat() helper; remove internal call to sys_futimesat()
Date: Thu, 15 Mar 2018 20:05:01 +0100
Message-Id: <20180315190529.20943-9-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315190529.20943-1-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using this helper removes the in-kernel call to the sys_futimesat()
syscall.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/utimes.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/utimes.c b/fs/utimes.c
index e4b3d7c2c9f5..5be035ed26c0 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -184,8 +184,8 @@ SYSCALL_DEFINE4(utimensat, int, dfd, const char __user *, filename,
 	return do_utimes(dfd, filename, utimes ? tstimes : NULL, flags);
 }
 
-SYSCALL_DEFINE3(futimesat, int, dfd, const char __user *, filename,
-		struct timeval __user *, utimes)
+static long do_futimesat(int dfd, const char __user *filename,
+			 struct timeval __user *utimes)
 {
 	struct timeval times[2];
 	struct timespec64 tstimes[2];
@@ -212,10 +212,17 @@ SYSCALL_DEFINE3(futimesat, int, dfd, const char __user *, filename,
 	return do_utimes(dfd, filename, utimes ? tstimes : NULL, 0);
 }
 
+
+SYSCALL_DEFINE3(futimesat, int, dfd, const char __user *, filename,
+		struct timeval __user *, utimes)
+{
+	return do_futimesat(dfd, filename, utimes);
+}
+
 SYSCALL_DEFINE2(utimes, char __user *, filename,
 		struct timeval __user *, utimes)
 {
-	return sys_futimesat(AT_FDCWD, filename, utimes);
+	return do_futimesat(AT_FDCWD, filename, utimes);
 }
 
 #ifdef CONFIG_COMPAT
-- 
2.16.2
