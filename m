Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeCJIud (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 03:50:33 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38325 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeCJIuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 03:50:32 -0500
X-Google-Smtp-Source: AG47ELv/X6eyxVed7Y4PIeU/9ArNW3IowXgiK6RCrR2RA09qkioamBn5V4jHD+EG0NdLQDGXgRJNBw==
Date: Sat, 10 Mar 2018 11:50:28 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] seq_file: allocate seq_file from kmem_cache
Message-ID: <20180310085027.GA17121@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For fine-grained debugging and usercopy protection.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/seq_file.c            |   12 ++++++++++--
 include/linux/seq_file.h |    1 +
 init/main.c              |    1 +
 3 files changed, 12 insertions(+), 2 deletions(-)

--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -6,6 +6,7 @@
  * initial implementation -- AV, Oct 2001.
  */
 
+#include <linux/cache.h>
 #include <linux/fs.h>
 #include <linux/export.h>
 #include <linux/seq_file.h>
@@ -19,6 +20,8 @@
 #include <linux/uaccess.h>
 #include <asm/page.h>
 
+static struct kmem_cache *seq_file_cache __ro_after_init;
+
 static void seq_set_overflow(struct seq_file *m)
 {
 	m->count = m->size;
@@ -51,7 +54,7 @@ int seq_open(struct file *file, const struct seq_operations *op)
 
 	WARN_ON(file->private_data);
 
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	p = kmem_cache_zalloc(seq_file_cache, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 
@@ -366,7 +369,7 @@ int seq_release(struct inode *inode, struct file *file)
 {
 	struct seq_file *m = file->private_data;
 	kvfree(m->buf);
-	kfree(m);
+	kmem_cache_free(seq_file_cache, m);
 	return 0;
 }
 EXPORT_SYMBOL(seq_release);
@@ -1106,3 +1109,8 @@ seq_hlist_next_percpu(void *v, struct hlist_head __percpu *head,
 	return NULL;
 }
 EXPORT_SYMBOL(seq_hlist_next_percpu);
+
+void __init seq_file_init(void)
+{
+	seq_file_cache = KMEM_CACHE(seq_file, SLAB_PANIC);
+}
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -240,4 +240,5 @@ extern struct hlist_node *seq_hlist_start_percpu(struct hlist_head __percpu *hea
 
 extern struct hlist_node *seq_hlist_next_percpu(void *v, struct hlist_head __percpu *head, int *cpu, loff_t *pos);
 
+void seq_file_init(void);
 #endif
--- a/init/main.c
+++ b/init/main.c
@@ -696,6 +696,7 @@ asmlinkage __visible void __init start_kernel(void)
 	vfs_caches_init();
 	pagecache_init();
 	signals_init();
+	seq_file_init();
 	proc_root_init();
 	nsfs_init();
 	cpuset_init();
