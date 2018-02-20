Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x225NkQWKuZ85QA4aQWbZhYHqIkOtIBYsHTMuFf1b4n+0zErn5TB5r3fN+ti7v4G6v1/OQ2bu
ARC-Seal: i=1; a=rsa-sha256; t=1519093515; cv=none;
        d=google.com; s=arc-20160816;
        b=dQpBgH6y+U31SUrPF3H2RIcG2ZQuohQdZ4faaGT68NMil+E14vqSiNOFH6Pqt+igF7
         V+HTJ1LyaJMeLq1OMjtKS67rMh0e5iQ2A3u+3FZsxNzdO3FUq3zhDujcWc2c9pAC6YDu
         39eD806z3zEarQglXyuoflLyWGDu3jO6Vq5Yv/eJbgUF4FvaofmSenmZOj2fsN/FSj34
         K81EPQpWEE4J4JyqzX/ehqf9/u183hdkIBsbAxQgBqoex7U+hJQiIJqMzoWejx3tsIrZ
         YH3BsZv2LtksyfAUTLG0Q2Om+rbREhnRCNle25nPVnXF3btf80VIrOP3H/boeHiaNPHd
         kfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=kg3N8C25dseNulFP2eyjkJdhhXIRNAmchr/cGxYK3oU=;
        b=iwi8egtQOlSydFLglzs5w+ZC7+9GWatbbDjPB8CvLk96m6/3+XAaCbUsMrzedAp6og
         wQUE5BO9X2T9EETng/m5kClRxygFZ2QQ5EJ4Ek44/xVqDjoZ1hXyIAhMrPQOzIHfWX0l
         ZF0VcHEHE76tLY8AL5EvIQ9Hgfz26KcYgYdSUyQPRWfccosks/xuy7zfwlNpGdg7QbyG
         n6kf7xQtugkRj6FGpp1YU321MtI7Bham5wEuG5EFa0yqirO2g7T+HcDlOH9KjmiYrlE2
         liB+ne24OTKBAkKgvAH9tsZfpLi7LroTygPg2WepsLsBYneaQMrYzUvLufhMCTPD7Jh9
         wYTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>, James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 20 Feb 2018 13:23:37 +1100
Subject: [PATCH 08/21] staging: lustre: make signal-blocking functions inline
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151909341780.25814.17116167688658061622.stgit@noble>
In-Reply-To: <151909308778.25814.9912662268627044409.stgit@noble>
References: <151909308778.25814.9912662268627044409.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592885002373832847?=
X-GMAIL-MSGID: =?utf-8?q?1592885002373832847?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

cfs_block_sigsinv() and cfs_restore_sigs() are now
simple enough to inline them.
This means we can discard linux-prim.c

Signed-off-by: NeilBrown <neilb@suse.com>
---
 .../staging/lustre/include/linux/libcfs/libcfs.h   |   20 +++++-
 drivers/staging/lustre/lnet/libcfs/Makefile        |    2 -
 .../staging/lustre/lnet/libcfs/linux/linux-prim.c  |   62 --------------------
 3 files changed, 16 insertions(+), 68 deletions(-)
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/linux/linux-prim.c

diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs.h b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
index 9dff050810c4..4f8c65e6d883 100644
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs.h
+++ b/drivers/staging/lustre/include/linux/libcfs/libcfs.h
@@ -64,11 +64,21 @@
 #define LNET_ACCEPTOR_MIN_RESERVED_PORT    512
 #define LNET_ACCEPTOR_MAX_RESERVED_PORT    1023
 
-/*
- * Defined by platform
- */
-void cfs_block_sigsinv(unsigned long sigs, sigset_t *sigset);
-void cfs_restore_sigs(sigset_t *sigset);
+/* Block all signals except for the @sigs */
+static inline void cfs_block_sigsinv(unsigned long sigs, sigset_t *old)
+{
+	sigset_t new;
+
+	siginitsetinv(&new, sigs);
+	sigorsets(&new, &current->blocked, &new);
+	sigprocmask(SIG_BLOCK, &new, old);
+}
+
+static inline void
+cfs_restore_sigs(sigset_t *old)
+{
+	sigprocmask(SIG_SETMASK, old, NULL);
+}
 
 struct libcfs_ioctl_handler {
 	struct list_head item;
diff --git a/drivers/staging/lustre/lnet/libcfs/Makefile b/drivers/staging/lustre/lnet/libcfs/Makefile
index fccea8684f0c..a51a8b0b9921 100644
--- a/drivers/staging/lustre/lnet/libcfs/Makefile
+++ b/drivers/staging/lustre/lnet/libcfs/Makefile
@@ -5,7 +5,7 @@ subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/lustre/include
 obj-$(CONFIG_LNET) += libcfs.o
 
 libcfs-linux-objs := linux-tracefile.o linux-debug.o
-libcfs-linux-objs += linux-prim.o linux-cpu.o
+libcfs-linux-objs += linux-cpu.o
 libcfs-linux-objs += linux-module.o
 libcfs-linux-objs += linux-crypto.o
 libcfs-linux-objs += linux-crypto-adler.o
diff --git a/drivers/staging/lustre/lnet/libcfs/linux/linux-prim.c b/drivers/staging/lustre/lnet/libcfs/linux/linux-prim.c
deleted file mode 100644
index 0766659ddf70..000000000000
--- a/drivers/staging/lustre/lnet/libcfs/linux/linux-prim.c
+++ /dev/null
@@ -1,62 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * GPL HEADER START
- *
- * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 only,
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License version 2 for more details (a copy is included
- * in the LICENSE file that accompanied this code).
- *
- * You should have received a copy of the GNU General Public License
- * version 2 along with this program; If not, see
- * http://www.gnu.org/licenses/gpl-2.0.html
- *
- * GPL HEADER END
- */
-/*
- * Copyright (c) 2008, 2010, Oracle and/or its affiliates. All rights reserved.
- * Use is subject to license terms.
- *
- * Copyright (c) 2011, 2012, Intel Corporation.
- */
-/*
- * This file is part of Lustre, http://www.lustre.org/
- * Lustre is a trademark of Sun Microsystems, Inc.
- */
-
-#define DEBUG_SUBSYSTEM S_LNET
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/fs_struct.h>
-#include <linux/sched/signal.h>
-
-#include <linux/libcfs/libcfs.h>
-
-#if defined(CONFIG_KGDB)
-#include <linux/kgdb.h>
-#endif
-
-/* Block all signals except for the @sigs */
-void cfs_block_sigsinv(unsigned long sigs, sigset_t *old)
-{
-	sigset_t new;
-
-	siginitsetinv(&new, sigs);
-	sigorsets(&new, &current->blocked, &new);
-	sigprocmask(SIG_BLOCK, &new, old);
-}
-EXPORT_SYMBOL(cfs_block_sigsinv);
-
-void
-cfs_restore_sigs(sigset_t *old)
-{
-	sigprocmask(SIG_SETMASK, old, NULL);
-}
-EXPORT_SYMBOL(cfs_restore_sigs);
