Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbeCOTLt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:11:49 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36076 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932630AbeCOTGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:06:22 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc: luto@kernel.org, mingo@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Subject: [PATCH v2 09/36] syscalls: add do_epoll_*() helpers; remove internal calls to sys_epoll_*()
Date: Thu, 15 Mar 2018 20:05:02 +0100
Message-Id: <20180315190529.20943-10-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315190529.20943-1-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the helper functions do_epoll_create() and do_epoll_wait() allows us
to remove in-kernel calls to the related syscall functions.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/eventpoll.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 0f3494ed3ed0..602ca4285b2e 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1936,7 +1936,7 @@ static void clear_tfile_check_list(void)
 /*
  * Open an eventpoll file descriptor.
  */
-SYSCALL_DEFINE1(epoll_create1, int, flags)
+static int do_epoll_create(int flags)
 {
 	int error, fd;
 	struct eventpoll *ep = NULL;
@@ -1979,12 +1979,17 @@ SYSCALL_DEFINE1(epoll_create1, int, flags)
 	return error;
 }
 
+SYSCALL_DEFINE1(epoll_create1, int, flags)
+{
+	return do_epoll_create(flags);
+}
+
 SYSCALL_DEFINE1(epoll_create, int, size)
 {
 	if (size <= 0)
 		return -EINVAL;
 
-	return sys_epoll_create1(0);
+	return do_epoll_create(0);
 }
 
 /*
@@ -2148,8 +2153,8 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
  * Implement the event wait interface for the eventpoll file. It is the kernel
  * part of the user space epoll_wait(2).
  */
-SYSCALL_DEFINE4(epoll_wait, int, epfd, struct epoll_event __user *, events,
-		int, maxevents, int, timeout)
+static int do_epoll_wait(int epfd, struct epoll_event __user *events,
+			 int maxevents, int timeout)
 {
 	int error;
 	struct fd f;
@@ -2190,6 +2195,12 @@ SYSCALL_DEFINE4(epoll_wait, int, epfd, struct epoll_event __user *, events,
 	return error;
 }
 
+SYSCALL_DEFINE4(epoll_wait, int, epfd, struct epoll_event __user *, events,
+		int, maxevents, int, timeout)
+{
+	return do_epoll_wait(epfd, events, maxevents, timeout);
+}
+
 /*
  * Implement the event wait interface for the eventpoll file. It is the kernel
  * part of the user space epoll_pwait(2).
@@ -2214,7 +2225,7 @@ SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct epoll_event __user *, events,
 		set_current_blocked(&ksigmask);
 	}
 
-	error = sys_epoll_wait(epfd, events, maxevents, timeout);
+	error = do_epoll_wait(epfd, events, maxevents, timeout);
 
 	/*
 	 * If we changed the signal mask, we need to restore the original one.
@@ -2257,7 +2268,7 @@ COMPAT_SYSCALL_DEFINE6(epoll_pwait, int, epfd,
 		set_current_blocked(&ksigmask);
 	}
 
-	err = sys_epoll_wait(epfd, events, maxevents, timeout);
+	err = do_epoll_wait(epfd, events, maxevents, timeout);
 
 	/*
 	 * If we changed the signal mask, we need to restore the original one.
-- 
2.16.2
