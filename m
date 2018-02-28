Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964922AbeB1XTb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 18:19:31 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54332 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964908AbeB1XT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 18:19:28 -0500
X-Google-Smtp-Source: AG47ELvtiRRDXl3TbDW41NczJAGmc2WvRfUWoAoP5bNVgjWMPJNJSmlh6UNVGjfzpJ527vBeuhrFlg==
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] vfs: make sure struct filename->iname is word-aligned
Date: Thu,  1 Mar 2018 00:19:21 +0100
Message-Id: <20180228231922.15796-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that offsetof(struct filename, iname) is actually 28 on 64
bit platforms, so we always pass an unaligned pointer to
strncpy_from_user. This is mostly a problem for those 64 bit platforms
without HAVE_EFFICIENT_UNALIGNED_ACCESS, but even on x86_64, unaligned
accesses carry a penalty.

A user-space microbenchmark doing nothing but strncpy_from_user from the
same (aligned) source string runs about 5% faster when the destination
is aligned. That number increases to 20% when the string is long
enough (~32 bytes) that we cross a cache line boundary - that's for
example the case for about half the files a "git status" in a kernel
tree ends up stat'ing.

This won't make any real-life workloads 5%, or even 1%, faster, but path
lookup is common enough that cutting even a few cycles should be
worthwhile. So ensure we always pass an aligned destination pointer to
strncpy_from_user. Instead of explicit padding, simply swap the refcnt
and aname members, as suggested by Al Viro.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 fs/namei.c         | 2 ++
 include/linux/fs.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 921ae32dbc80..5a66e7ca5d60 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -39,6 +39,7 @@
 #include <linux/bitops.h>
 #include <linux/init_task.h>
 #include <linux/uaccess.h>
+#include <linux/build_bug.h>
 
 #include "internal.h"
 #include "mount.h"
@@ -130,6 +131,7 @@ getname_flags(const char __user *filename, int flags, int *empty)
 	struct filename *result;
 	char *kname;
 	int len;
+	BUILD_BUG_ON(offsetof(struct filename, iname) % sizeof(long) != 0);
 
 	result = audit_reusename(filename);
 	if (result)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2a815560fda0..d7b2caadb292 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2380,8 +2380,8 @@ struct audit_names;
 struct filename {
 	const char		*name;	/* pointer to actual string */
 	const __user char	*uptr;	/* original userland pointer */
-	struct audit_names	*aname;
 	int			refcnt;
+	struct audit_names	*aname;
 	const char		iname[];
 };
 
-- 
2.15.1
