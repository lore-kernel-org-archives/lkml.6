Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932742AbeCOTLJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:11:09 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36078 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932651AbeCOTGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:06:22 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc: luto@kernel.org, mingo@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Subject: [PATCH v2 11/36] fs: add do_eventfd() helper; remove internal call to sys_eventfd()
Date: Thu, 15 Mar 2018 20:05:04 +0100
Message-Id: <20180315190529.20943-12-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315190529.20943-1-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using this helper removes an in-kernel call to the sys_eventfd() syscall.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
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
