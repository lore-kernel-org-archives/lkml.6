Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932199AbeCKK4t (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 06:56:49 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:54062 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932120AbeCKK4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 06:56:47 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Subject: [RFC PATCH 04/35] syscalls: do not call sys_getpgid() within the kernel
Date: Sun, 11 Mar 2018 11:55:26 +0100
Message-Id: <20180311105557.20807-5-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180311105557.20807-1-linux@dominikbrodowski.net>
References: <20180311105557.20807-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 kernel/sys.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index f2289de20e19..ebb138b841c8 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1027,7 +1027,7 @@ SYSCALL_DEFINE2(setpgid, pid_t, pid, pid_t, pgid)
 	return err;
 }
 
-SYSCALL_DEFINE1(getpgid, pid_t, pid)
+static int do_getpgid(pid_t pid)
 {
 	struct task_struct *p;
 	struct pid *grp;
@@ -1055,11 +1055,16 @@ SYSCALL_DEFINE1(getpgid, pid_t, pid)
 	return retval;
 }
 
+SYSCALL_DEFINE1(getpgid, pid_t, pid)
+{
+	return do_getpgid(pid);
+}
+
 #ifdef __ARCH_WANT_SYS_GETPGRP
 
 SYSCALL_DEFINE0(getpgrp)
 {
-	return sys_getpgid(0);
+	return do_getpgid(0);
 }
 
 #endif
-- 
2.16.2
