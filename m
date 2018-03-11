Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932489AbeCKLEB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 07:04:01 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:54054 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932126AbeCKK4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 06:56:47 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, luto@kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org
Subject: [RFC PATCH 11/35] syscalls: do not call sys_eventfd2() within the kernel
Date: Sun, 11 Mar 2018 11:55:33 +0100
Message-Id: <20180311105557.20807-12-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180311105557.20807-1-linux@dominikbrodowski.net>
References: <20180311105557.20807-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/eventfd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 012f5bd46dfa..08d3bd602f73 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -380,7 +380,7 @@ struct eventfd_ctx *eventfd_ctx_fileget(struct file *file)
 }
 EXPORT_SYMBOL_GPL(eventfd_ctx_fileget);
 
-SYSCALL_DEFINE2(eventfd2, unsigned int, count, int, flags)
+static int do_eventfd(unsigned int count, int flags)
 {
 	struct eventfd_ctx *ctx;
 	int fd;
@@ -409,8 +409,13 @@ SYSCALL_DEFINE2(eventfd2, unsigned int, count, int, flags)
 	return fd;
 }
 
+SYSCALL_DEFINE2(eventfd2, unsigned int, count, int, flags)
+{
+	return do_eventfd(count, flags);
+}
+
 SYSCALL_DEFINE1(eventfd, unsigned int, count)
 {
-	return sys_eventfd2(count, 0);
+	return do_eventfd(count, 0);
 }
 
-- 
2.16.2
