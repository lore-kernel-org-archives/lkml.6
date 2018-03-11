Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932409AbeCKK6E (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 06:58:04 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:54292 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932257AbeCKK4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 06:56:54 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Subject: [RFC PATCH 06/35] syscalls: do not call sys_pipe2() within the kernel
Date: Sun, 11 Mar 2018 11:55:28 +0100
Message-Id: <20180311105557.20807-7-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180311105557.20807-1-linux@dominikbrodowski.net>
References: <20180311105557.20807-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC: Alexander Viro <viro@zeniv.linux.org.uk>
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
