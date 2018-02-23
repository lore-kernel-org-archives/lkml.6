Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752295AbeBWUzM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 15:55:12 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35529 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751540AbeBWUzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 15:55:08 -0500
X-Google-Smtp-Source: AG47ELuiIzcQRLqXnX7JQS7RjXp23pNJleKWqg4NYQtnBb1vjBu6l/xX6QmK/ey0Zm7uUgPkOn/CGQ==
Date: Fri, 23 Feb 2018 23:55:04 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] proc: move "struct proc_dir_entry" into kmem cache
Message-ID: <20180223205504.GA17139@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"struct proc_dir_entry" is variable sized because of 0-length trailing
array for name, however, because of SLAB padding allocations it is
possible to make "struct proc_dir_entry" fixed sized and allocate same
amount of memory.

It buys fine-grained debugging with poisoning and usercopy protection
which is not possible with kmalloc-* caches.

Currently, on 32-bit 91+ byte allocations go into kmalloc-128 and
on 64-bit 147+ byte allocations go to kmalloc-192 anyway.

Additional memory is allocated only for 38/46+ byte long names
which are rare or may not even exist in the wild.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/generic.c  |   50 ++++++++++++++++++++++++++++++++------------------
 fs/proc/inode.c    |    4 ++++
 fs/proc/internal.h |   11 ++++++++++-
 fs/proc/proc_net.c |    7 ++++---
 fs/proc/root.c     |    3 ++-
 5 files changed, 52 insertions(+), 23 deletions(-)

--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -8,6 +8,7 @@
  * Copyright (C) 1997 Theodore Ts'o
  */
 
+#include <linux/cache.h>
 #include <linux/errno.h>
 #include <linux/time.h>
 #include <linux/proc_fs.h>
@@ -28,6 +29,17 @@
 
 static DEFINE_RWLOCK(proc_subdir_lock);
 
+struct kmem_cache *proc_dir_entry_cache __ro_after_init;
+
+void pde_free(struct proc_dir_entry *pde)
+{
+	if (S_ISLNK(pde->mode))
+		kfree(pde->data);
+	if (pde->name != pde->inline_name)
+		kfree(pde->name);
+	kmem_cache_free(proc_dir_entry_cache, pde);
+}
+
 static int proc_match(const char *name, struct proc_dir_entry *de, unsigned int len)
 {
 	if (len < de->namelen)
@@ -363,10 +375,20 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
 		return NULL;
 	}
 
-	ent = kzalloc(sizeof(struct proc_dir_entry) + qstr.len + 1, GFP_KERNEL);
+	ent = kmem_cache_zalloc(proc_dir_entry_cache, GFP_KERNEL);
 	if (!ent)
 		goto out;
 
+	if (qstr.len + 1 <= sizeof(ent->inline_name)) {
+		ent->name = ent->inline_name;
+	} else {
+		ent->name = kmalloc(qstr.len + 1, GFP_KERNEL);
+		if (!ent->name) {
+			pde_free(ent);
+			return NULL;
+		}
+	}
+
 	memcpy(ent->name, fn, qstr.len + 1);
 	ent->namelen = qstr.len;
 	ent->mode = mode;
@@ -395,12 +417,11 @@ struct proc_dir_entry *proc_symlink(const char *name,
 			strcpy((char*)ent->data,dest);
 			ent->proc_iops = &proc_link_inode_operations;
 			if (proc_register(parent, ent) < 0) {
-				kfree(ent->data);
-				kfree(ent);
+				pde_free(ent);
 				ent = NULL;
 			}
 		} else {
-			kfree(ent);
+			pde_free(ent);
 			ent = NULL;
 		}
 	}
@@ -423,7 +444,7 @@ struct proc_dir_entry *proc_mkdir_data(const char *name, umode_t mode,
 		ent->proc_iops = &proc_dir_inode_operations;
 		parent->nlink++;
 		if (proc_register(parent, ent) < 0) {
-			kfree(ent);
+			pde_free(ent);
 			parent->nlink--;
 			ent = NULL;
 		}
@@ -458,7 +479,7 @@ struct proc_dir_entry *proc_create_mount_point(const char *name)
 		ent->proc_iops = NULL;
 		parent->nlink++;
 		if (proc_register(parent, ent) < 0) {
-			kfree(ent);
+			pde_free(ent);
 			parent->nlink--;
 			ent = NULL;
 		}
@@ -495,7 +516,7 @@ struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
 		goto out_free;
 	return pde;
 out_free:
-	kfree(pde);
+	pde_free(pde);
 out:
 	return NULL;
 }
@@ -522,19 +543,12 @@ void proc_set_user(struct proc_dir_entry *de, kuid_t uid, kgid_t gid)
 }
 EXPORT_SYMBOL(proc_set_user);
 
-static void free_proc_entry(struct proc_dir_entry *de)
-{
-	proc_free_inum(de->low_ino);
-
-	if (S_ISLNK(de->mode))
-		kfree(de->data);
-	kfree(de);
-}
-
 void pde_put(struct proc_dir_entry *pde)
 {
-	if (atomic_dec_and_test(&pde->count))
-		free_proc_entry(pde);
+	if (atomic_dec_and_test(&pde->count)) {
+		proc_free_inum(pde->low_ino);
+		pde_free(pde);
+	}
 }
 
 /*
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -104,6 +104,10 @@ void __init proc_init_kmemcache(void)
 	pde_opener_cache =
 		kmem_cache_create("pde_opener", sizeof(struct pde_opener), 0,
 				  SLAB_ACCOUNT|SLAB_PANIC, NULL);
+	proc_dir_entry_cache = kmem_cache_create_usercopy(
+		"proc_dir_entry", sizeof(struct proc_dir_entry), 0, SLAB_PANIC,
+		offsetof(struct proc_dir_entry, inline_name),
+		sizeof_field(struct proc_dir_entry, inline_name), NULL);
 }
 
 static int proc_show_options(struct seq_file *seq, struct dentry *root)
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -52,11 +52,20 @@ struct proc_dir_entry {
 	struct proc_dir_entry *parent;
 	struct rb_root_cached subdir;
 	struct rb_node subdir_node;
+	char *name;
 	umode_t mode;
 	u8 namelen;
-	char name[];
+#ifdef CONFIG_64BIT
+#define SIZEOF_PDE_INLINE_NAME	(192-147)
+#else
+#define SIZEOF_PDE_INLINE_NAME	(128-91)
+#endif
+	char inline_name[SIZEOF_PDE_INLINE_NAME];
 } __randomize_layout;
 
+extern struct kmem_cache *proc_dir_entry_cache;
+void pde_free(struct proc_dir_entry *pde);
+
 union proc_op {
 	int (*proc_get_link)(struct dentry *, struct path *);
 	int (*proc_show)(struct seq_file *m,
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -192,7 +192,7 @@ static __net_init int proc_net_ns_init(struct net *net)
 	int err;
 
 	err = -ENOMEM;
-	netd = kzalloc(sizeof(*netd) + 4, GFP_KERNEL);
+	netd = kmem_cache_zalloc(proc_dir_entry_cache, GFP_KERNEL);
 	if (!netd)
 		goto out;
 
@@ -201,6 +201,7 @@ static __net_init int proc_net_ns_init(struct net *net)
 	netd->nlink = 2;
 	netd->namelen = 3;
 	netd->parent = &proc_root;
+	netd->name = netd->inline_name;
 	memcpy(netd->name, "net", 4);
 
 	uid = make_kuid(net->user_ns, 0);
@@ -223,7 +224,7 @@ static __net_init int proc_net_ns_init(struct net *net)
 	return 0;
 
 free_net:
-	kfree(netd);
+	pde_free(netd);
 out:
 	return err;
 }
@@ -231,7 +232,7 @@ static __net_init int proc_net_ns_init(struct net *net)
 static __net_exit void proc_net_ns_exit(struct net *net)
 {
 	remove_proc_entry("stat", net->proc_net);
-	kfree(net->proc_net);
+	pde_free(net->proc_net);
 }
 
 static struct pernet_operations __net_initdata proc_net_ns_ops = {
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -208,7 +208,8 @@ struct proc_dir_entry proc_root = {
 	.proc_fops	= &proc_root_operations,
 	.parent		= &proc_root,
 	.subdir		= RB_ROOT_CACHED,
-	.name		= "/proc",
+	.name		= proc_root.inline_name,
+	.inline_name	= "/proc",
 };
 
 int pid_ns_prepare_proc(struct pid_namespace *ns)
