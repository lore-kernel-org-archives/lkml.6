Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbeERHuW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:50:22 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44684 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbeERHuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:50:18 -0400
X-Google-Smtp-Source: AB8JxZrJedfLZ4hEdLKPqlT9cg2YqFd3vxkmWua9eO3k3y77LTvdDUr712YZW11ApVIm1V5JTVKw5g==
From: Kent Overstreet <kent.overstreet@gmail.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        viro@zeniv.linux.org.uk, willy@infradead.org, peterz@infradead.org
Subject: [PATCH 08/10] bcache: move closures to lib/
Date: Fri, 18 May 2018 03:49:13 -0400
Message-Id: <20180518074918.13816-16-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518074918.13816-1-kent.overstreet@gmail.com>
References: <20180518074918.13816-1-kent.overstreet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prep work for bcachefs - being a fork of bcache it also uses closures

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 drivers/md/bcache/Kconfig                      | 10 +---------
 drivers/md/bcache/Makefile                     |  6 +++---
 drivers/md/bcache/bcache.h                     |  2 +-
 drivers/md/bcache/super.c                      |  1 -
 drivers/md/bcache/util.h                       |  3 +--
 {drivers/md/bcache => include/linux}/closure.h | 17 ++++++++---------
 lib/Kconfig                                    |  3 +++
 lib/Kconfig.debug                              |  9 +++++++++
 lib/Makefile                                   |  2 ++
 {drivers/md/bcache => lib}/closure.c           | 17 ++++++++---------
 10 files changed, 36 insertions(+), 34 deletions(-)
 rename {drivers/md/bcache => include/linux}/closure.h (97%)
 rename {drivers/md/bcache => lib}/closure.c (95%)

diff --git a/drivers/md/bcache/Kconfig b/drivers/md/bcache/Kconfig
index 4d200883c5..45f1094c08 100644
--- a/drivers/md/bcache/Kconfig
+++ b/drivers/md/bcache/Kconfig
@@ -1,6 +1,7 @@
 
 config BCACHE
 	tristate "Block device as cache"
+	select CLOSURES
 	---help---
 	Allows a block device to be used as cache for other devices; uses
 	a btree for indexing and the layout is optimized for SSDs.
@@ -15,12 +16,3 @@ config BCACHE_DEBUG
 
 	Enables extra debugging tools, allows expensive runtime checks to be
 	turned on.
-
-config BCACHE_CLOSURES_DEBUG
-	bool "Debug closures"
-	depends on BCACHE
-	select DEBUG_FS
-	---help---
-	Keeps all active closures in a linked list and provides a debugfs
-	interface to list them, which makes it possible to see asynchronous
-	operations that get stuck.
diff --git a/drivers/md/bcache/Makefile b/drivers/md/bcache/Makefile
index d26b351958..2b790fb813 100644
--- a/drivers/md/bcache/Makefile
+++ b/drivers/md/bcache/Makefile
@@ -2,8 +2,8 @@
 
 obj-$(CONFIG_BCACHE)	+= bcache.o
 
-bcache-y		:= alloc.o bset.o btree.o closure.o debug.o extents.o\
-	io.o journal.o movinggc.o request.o stats.o super.o sysfs.o trace.o\
-	util.o writeback.o
+bcache-y		:= alloc.o bset.o btree.o debug.o extents.o io.o\
+	journal.o movinggc.o request.o stats.o super.o sysfs.o trace.o util.o\
+	writeback.o
 
 CFLAGS_request.o	+= -Iblock
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 12e5197f18..d954dc44dd 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -180,6 +180,7 @@
 
 #include <linux/bcache.h>
 #include <linux/bio.h>
+#include <linux/closure.h>
 #include <linux/kobject.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
@@ -191,7 +192,6 @@
 
 #include "bset.h"
 #include "util.h"
-#include "closure.h"
 
 struct bucket {
 	atomic_t	pin;
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index f2273143b3..5f1ac8e0a3 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2148,7 +2148,6 @@ static int __init bcache_init(void)
 	mutex_init(&bch_register_lock);
 	init_waitqueue_head(&unregister_wait);
 	register_reboot_notifier(&reboot);
-	closure_debug_init();
 
 	bcache_major = register_blkdev(0, "bcache");
 	if (bcache_major < 0) {
diff --git a/drivers/md/bcache/util.h b/drivers/md/bcache/util.h
index a6763db7f0..a75523ed0d 100644
--- a/drivers/md/bcache/util.h
+++ b/drivers/md/bcache/util.h
@@ -4,6 +4,7 @@
 #define _BCACHE_UTIL_H
 
 #include <linux/blkdev.h>
+#include <linux/closure.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/sched/clock.h>
@@ -12,8 +13,6 @@
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
 
-#include "closure.h"
-
 #define PAGE_SECTORS		(PAGE_SIZE / 512)
 
 struct closure;
diff --git a/drivers/md/bcache/closure.h b/include/linux/closure.h
similarity index 97%
rename from drivers/md/bcache/closure.h
rename to include/linux/closure.h
index 2392a46bcd..1072bf2c13 100644
--- a/drivers/md/bcache/closure.h
+++ b/include/linux/closure.h
@@ -154,7 +154,7 @@ struct closure {
 
 	atomic_t		remaining;
 
-#ifdef CONFIG_BCACHE_CLOSURES_DEBUG
+#ifdef CONFIG_DEBUG_CLOSURES
 #define CLOSURE_MAGIC_DEAD	0xc054dead
 #define CLOSURE_MAGIC_ALIVE	0xc054a11e
 
@@ -183,15 +183,13 @@ static inline void closure_sync(struct closure *cl)
 		__closure_sync(cl);
 }
 
-#ifdef CONFIG_BCACHE_CLOSURES_DEBUG
+#ifdef CONFIG_DEBUG_CLOSURES
 
-void closure_debug_init(void);
 void closure_debug_create(struct closure *cl);
 void closure_debug_destroy(struct closure *cl);
 
 #else
 
-static inline void closure_debug_init(void) {}
 static inline void closure_debug_create(struct closure *cl) {}
 static inline void closure_debug_destroy(struct closure *cl) {}
 
@@ -199,21 +197,21 @@ static inline void closure_debug_destroy(struct closure *cl) {}
 
 static inline void closure_set_ip(struct closure *cl)
 {
-#ifdef CONFIG_BCACHE_CLOSURES_DEBUG
+#ifdef CONFIG_DEBUG_CLOSURES
 	cl->ip = _THIS_IP_;
 #endif
 }
 
 static inline void closure_set_ret_ip(struct closure *cl)
 {
-#ifdef CONFIG_BCACHE_CLOSURES_DEBUG
+#ifdef CONFIG_DEBUG_CLOSURES
 	cl->ip = _RET_IP_;
 #endif
 }
 
 static inline void closure_set_waiting(struct closure *cl, unsigned long f)
 {
-#ifdef CONFIG_BCACHE_CLOSURES_DEBUG
+#ifdef CONFIG_DEBUG_CLOSURES
 	cl->waiting_on = f;
 #endif
 }
@@ -242,6 +240,7 @@ static inline void closure_queue(struct closure *cl)
 	 */
 	BUILD_BUG_ON(offsetof(struct closure, fn)
 		     != offsetof(struct work_struct, func));
+
 	if (wq) {
 		INIT_WORK(&cl->work, cl->work.func);
 		queue_work(wq, &cl->work);
@@ -254,7 +253,7 @@ static inline void closure_queue(struct closure *cl)
  */
 static inline void closure_get(struct closure *cl)
 {
-#ifdef CONFIG_BCACHE_CLOSURES_DEBUG
+#ifdef CONFIG_DEBUG_CLOSURES
 	BUG_ON((atomic_inc_return(&cl->remaining) &
 		CLOSURE_REMAINING_MASK) <= 1);
 #else
@@ -270,7 +269,7 @@ static inline void closure_get(struct closure *cl)
  */
 static inline void closure_init(struct closure *cl, struct closure *parent)
 {
-	memset(cl, 0, sizeof(struct closure));
+	cl->fn = NULL;
 	cl->parent = parent;
 	if (parent)
 		closure_get(parent);
diff --git a/lib/Kconfig b/lib/Kconfig
index e960894993..eff939519e 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -393,6 +393,9 @@ config ASSOCIATIVE_ARRAY
 
 	  for more information.
 
+config CLOSURES
+	bool
+
 config HAS_IOMEM
 	bool
 	depends on !NO_IOMEM
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 64155e310a..427292a759 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1362,6 +1362,15 @@ config DEBUG_CREDENTIALS
 
 source "kernel/rcu/Kconfig.debug"
 
+config DEBUG_CLOSURES
+	bool "Debug closures (bcache async widgits)"
+	depends on CLOSURES
+	select DEBUG_FS
+	---help---
+	Keeps all active closures in a linked list and provides a debugfs
+	interface to list them, which makes it possible to see asynchronous
+	operations that get stuck.
+
 config DEBUG_WQ_FORCE_RR_CPU
 	bool "Force round-robin CPU selection for unbound work items"
 	depends on DEBUG_KERNEL
diff --git a/lib/Makefile b/lib/Makefile
index 5db5a7fb1e..66d2231d70 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -172,6 +172,8 @@ obj-$(CONFIG_ATOMIC64_SELFTEST) += atomic64_test.o
 
 obj-$(CONFIG_CPU_RMAP) += cpu_rmap.o
 
+obj-$(CONFIG_CLOSURES) += closure.o
+
 obj-$(CONFIG_CORDIC) += cordic.o
 
 obj-$(CONFIG_DQL) += dynamic_queue_limits.o
diff --git a/drivers/md/bcache/closure.c b/lib/closure.c
similarity index 95%
rename from drivers/md/bcache/closure.c
rename to lib/closure.c
index 7f12920c14..025f8d8f48 100644
--- a/drivers/md/bcache/closure.c
+++ b/lib/closure.c
@@ -5,13 +5,12 @@
  * Copyright 2012 Google, Inc.
  */
 
+#include <linux/closure.h>
 #include <linux/debugfs.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/seq_file.h>
 #include <linux/sched/debug.h>
 
-#include "closure.h"
-
 static inline void closure_put_after_sub(struct closure *cl, int flags)
 {
 	int r = flags & CLOSURE_REMAINING_MASK;
@@ -126,7 +125,7 @@ void __sched __closure_sync(struct closure *cl)
 }
 EXPORT_SYMBOL(__closure_sync);
 
-#ifdef CONFIG_BCACHE_CLOSURES_DEBUG
+#ifdef CONFIG_DEBUG_CLOSURES
 
 static LIST_HEAD(closure_list);
 static DEFINE_SPINLOCK(closure_list_lock);
@@ -162,6 +161,7 @@ static struct dentry *debug;
 static int debug_seq_show(struct seq_file *f, void *data)
 {
 	struct closure *cl;
+
 	spin_lock_irq(&closure_list_lock);
 
 	list_for_each_entry(cl, &closure_list, all) {
@@ -180,7 +180,7 @@ static int debug_seq_show(struct seq_file *f, void *data)
 			seq_printf(f, " W %pF\n",
 				   (void *) cl->waiting_on);
 
-		seq_printf(f, "\n");
+		seq_puts(f, "\n");
 	}
 
 	spin_unlock_irq(&closure_list_lock);
@@ -199,12 +199,11 @@ static const struct file_operations debug_ops = {
 	.release	= single_release
 };
 
-void __init closure_debug_init(void)
+static int __init closure_debug_init(void)
 {
 	debug = debugfs_create_file("closures", 0400, NULL, NULL, &debug_ops);
+	return 0;
 }
+late_initcall(closure_debug_init)
 
 #endif
-
-MODULE_AUTHOR("Kent Overstreet <koverstreet@google.com>");
-MODULE_LICENSE("GPL");
-- 
2.17.0
