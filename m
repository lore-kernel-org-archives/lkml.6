Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbeCNXKi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 19:10:38 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36003 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNXKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 19:10:37 -0400
X-Google-Smtp-Source: AG47ELuRoX23n/wmOx2Q7opRe9DVQXiaVZF80fofZhdTYmA8oA69YryY/aGCSR7zp+iDPyuSVNGkBw==
Date: Thu, 15 Mar 2018 02:10:32 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, dbueso@suse.de, peterz@infradead.org
Subject: [PATCH -mm] proc: use slower rb_first()
Message-ID: <20180314231032.GA15854@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a typical for /proc "open+read+close" usecase, dentry is looked up
successfully on open only to be killed in dput() on close. In fact dentries
which aren't /proc/*/... and /proc/sys/* were almost NEVER CACHED.
Simple printk in proc_lookup_de() shows that.

Now that ->delete hook intelligently picks which dentries should live
in dcache and which should not, rbtree caching is not necessary as
dcache does it job, at last!

As a side effect, struct proc_dir_entry shrinks by one pointer
which can go into inline name.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/generic.c  |   26 ++++++++++++--------------
 fs/proc/internal.h |    6 +++---
 fs/proc/proc_net.c |    2 +-
 fs/proc/root.c     |    2 +-
 4 files changed, 17 insertions(+), 19 deletions(-)

--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -53,8 +53,8 @@ static int proc_match(const char *name, struct proc_dir_entry *de, unsigned int
 
 static struct proc_dir_entry *pde_subdir_first(struct proc_dir_entry *dir)
 {
-	return rb_entry_safe(rb_first_cached(&dir->subdir),
-			     struct proc_dir_entry, subdir_node);
+	return rb_entry_safe(rb_first(&dir->subdir), struct proc_dir_entry,
+			     subdir_node);
 }
 
 static struct proc_dir_entry *pde_subdir_next(struct proc_dir_entry *dir)
@@ -67,7 +67,7 @@ static struct proc_dir_entry *pde_subdir_find(struct proc_dir_entry *dir,
 					      const char *name,
 					      unsigned int len)
 {
-	struct rb_node *node = dir->subdir.rb_root.rb_node;
+	struct rb_node *node = dir->subdir.rb_node;
 
 	while (node) {
 		struct proc_dir_entry *de = rb_entry(node,
@@ -88,9 +88,8 @@ static struct proc_dir_entry *pde_subdir_find(struct proc_dir_entry *dir,
 static bool pde_subdir_insert(struct proc_dir_entry *dir,
 			      struct proc_dir_entry *de)
 {
-	struct rb_root_cached *root = &dir->subdir;
-	struct rb_node **new = &root->rb_root.rb_node, *parent = NULL;
-	bool leftmost = true;
+	struct rb_root *root = &dir->subdir;
+	struct rb_node **new = &root->rb_node, *parent = NULL;
 
 	/* Figure out where to put new node */
 	while (*new) {
@@ -102,16 +101,15 @@ static bool pde_subdir_insert(struct proc_dir_entry *dir,
 		parent = *new;
 		if (result < 0)
 			new = &(*new)->rb_left;
-		else if (result > 0) {
+		else if (result > 0)
 			new = &(*new)->rb_right;
-			leftmost = false;
-		} else
+		else
 			return false;
 	}
 
 	/* Add new node and rebalance tree. */
 	rb_link_node(&de->subdir_node, parent, new);
-	rb_insert_color_cached(&de->subdir_node, root, leftmost);
+	rb_insert_color(&de->subdir_node, root);
 	return true;
 }
 
@@ -422,7 +420,7 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
 	ent->namelen = qstr.len;
 	ent->mode = mode;
 	ent->nlink = nlink;
-	ent->subdir = RB_ROOT_CACHED;
+	ent->subdir = RB_ROOT;
 	refcount_set(&ent->refcnt, 1);
 	spin_lock_init(&ent->pde_unload_lock);
 	INIT_LIST_HEAD(&ent->pde_openers);
@@ -598,7 +596,7 @@ void remove_proc_entry(const char *name, struct proc_dir_entry *parent)
 
 	de = pde_subdir_find(parent, fn, len);
 	if (de)
-		rb_erase_cached(&de->subdir_node, &parent->subdir);
+		rb_erase(&de->subdir_node, &parent->subdir);
 	write_unlock(&proc_subdir_lock);
 	if (!de) {
 		WARN(1, "name '%s'\n", name);
@@ -635,13 +633,13 @@ int remove_proc_subtree(const char *name, struct proc_dir_entry *parent)
 		write_unlock(&proc_subdir_lock);
 		return -ENOENT;
 	}
-	rb_erase_cached(&root->subdir_node, &parent->subdir);
+	rb_erase(&root->subdir_node, &parent->subdir);
 
 	de = root;
 	while (1) {
 		next = pde_subdir_first(de);
 		if (next) {
-			rb_erase_cached(&next->subdir_node, &de->subdir);
+			rb_erase(&next->subdir_node, &de->subdir);
 			de = next;
 			continue;
 		}
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -51,15 +51,15 @@ struct proc_dir_entry {
 	kgid_t gid;
 	loff_t size;
 	struct proc_dir_entry *parent;
-	struct rb_root_cached subdir;
+	struct rb_root subdir;
 	struct rb_node subdir_node;
 	char *name;
 	umode_t mode;
 	u8 namelen;
 #ifdef CONFIG_64BIT
-#define SIZEOF_PDE_INLINE_NAME	(192-147)
+#define SIZEOF_PDE_INLINE_NAME	(192-139)
 #else
-#define SIZEOF_PDE_INLINE_NAME	(128-91)
+#define SIZEOF_PDE_INLINE_NAME	(128-87)
 #endif
 	char inline_name[SIZEOF_PDE_INLINE_NAME];
 } __randomize_layout;
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -196,7 +196,7 @@ static __net_init int proc_net_ns_init(struct net *net)
 	if (!netd)
 		goto out;
 
-	netd->subdir = RB_ROOT_CACHED;
+	netd->subdir = RB_ROOT;
 	netd->data = net;
 	netd->nlink = 2;
 	netd->namelen = 3;
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -203,7 +203,7 @@ struct proc_dir_entry proc_root = {
 	.proc_iops	= &proc_root_inode_operations, 
 	.proc_fops	= &proc_root_operations,
 	.parent		= &proc_root,
-	.subdir		= RB_ROOT_CACHED,
+	.subdir		= RB_ROOT,
 	.name		= proc_root.inline_name,
 	.inline_name	= "/proc",
 };
