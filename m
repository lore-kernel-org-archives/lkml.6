Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932739AbeCOTG0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:06:26 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36186 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932624AbeCOTGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:06:22 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc: luto@kernel.org, mingo@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Subject: [PATCH v2 06/36] fs: add do_pipe2() helper; remove internal call to sys_pipe2()
Date: Thu, 15 Mar 2018 20:04:59 +0100
Message-Id: <20180315190529.20943-7-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315190529.20943-1-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using this helper removes an in-kernel call to the sys_pipe2() syscall.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/pipe.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 7b1954caf388..39d6f431da83 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -841,7 +841,7 @@ int do_pipe_flags(int *fd, int flags)
  * sys_pipe() is the normal C calling standard for creating
  * a pipe. It's not the way Unix traditionally does this, though.
  */
-SYSCALL_DEFINE2(pipe2, int __user *, fildes, int, flags)
+static int do_pipe2(int __user *fildes, int flags)
 {
 	struct file *files[2];
 	int fd[2];
@@ -863,9 +863,14 @@ SYSCALL_DEFINE2(pipe2, int __user *, fildes, int, flags)
 	return error;
 }
 
+SYSCALL_DEFINE2(pipe2, int __user *, fildes, int, flags)
+{
+	return do_pipe2(fildes, flags);
+}
+
 SYSCALL_DEFINE1(pipe, int __user *, fildes)
 {
-	return sys_pipe2(fildes, 0);
+	return do_pipe2(fildes, 0);
 }
 
 static int wait_for_partner(struct pipe_inode_info *pipe, unsigned int *cnt)
-- 
2.16.2
