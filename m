Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754625AbeBNIXL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 03:23:11 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35128 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754556AbeBNIXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 03:23:10 -0500
X-Google-Smtp-Source: AH8x2256X5HQITIMnIZFeia/QKh7WDc7kBiSg+uI34F1UPMd5wcUBbyvnqXB4ANnzL3VIGK8KMEnrQ==
Date: Wed, 14 Feb 2018 11:23:06 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm 2/3] proc: move "struct pde_opener" to kmem cache
Message-ID: <20180214082306.GB17157@avx2>
References: <20180214063033.GA15579@avx2>
 <20180214081935.GA17157@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214081935.GA17157@avx2>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"struct pde_opener" is fixed size and we can have more granular approach
to debugging.

For those who don't know, per cache SLUB poisoning and red zoning
don't work if there is at least one object allocated which is hopeless
in case of kmalloc-64 but not in case of standalone cache.
Although systemd opens 2 files from the get go, so it is hopeless after
all.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/inode.c    |   12 ++++++++----
 fs/proc/internal.h |    2 +-
 fs/proc/root.c     |    2 +-
 3 files changed, 10 insertions(+), 6 deletions(-)

--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -54,6 +54,7 @@ static void proc_evict_inode(struct inode *inode)
 }
 
 static struct kmem_cache *proc_inode_cachep __ro_after_init;
+static struct kmem_cache *pde_opener_cache __ro_after_init;
 
 static struct inode *proc_alloc_inode(struct super_block *sb)
 {
@@ -92,7 +93,7 @@ static void init_once(void *foo)
 	inode_init_once(&ei->vfs_inode);
 }
 
-void __init proc_init_inodecache(void)
+void __init proc_init_kmemcache(void)
 {
 	proc_inode_cachep = kmem_cache_create("proc_inode_cache",
 					     sizeof(struct proc_inode),
@@ -100,6 +101,9 @@ void __init proc_init_inodecache(void)
 						SLAB_MEM_SPREAD|SLAB_ACCOUNT|
 						SLAB_PANIC),
 					     init_once);
+	pde_opener_cache =
+		kmem_cache_create("pde_opener", sizeof(struct pde_opener), 0,
+				  SLAB_PANIC, NULL);
 }
 
 static int proc_show_options(struct seq_file *seq, struct dentry *root)
@@ -172,7 +176,7 @@ static void close_pdeo(struct proc_dir_entry *pde, struct pde_opener *pdeo)
 		spin_unlock(&pde->pde_unload_lock);
 		if (unlikely(c))
 			complete(c);
-		kfree(pdeo);
+		kmem_cache_free(pde_opener_cache, pdeo);
 	}
 }
 
@@ -347,7 +351,7 @@ static int proc_reg_open(struct inode *inode, struct file *file)
 
 	release = pde->proc_fops->release;
 	if (release) {
-		pdeo = kmalloc(sizeof(struct pde_opener), GFP_KERNEL);
+		pdeo = kmem_cache_alloc(pde_opener_cache, GFP_KERNEL);
 		if (!pdeo) {
 			rv = -ENOMEM;
 			goto out_unuse;
@@ -368,7 +372,7 @@ static int proc_reg_open(struct inode *inode, struct file *file)
 			list_add(&pdeo->lh, &pde->pde_openers);
 			spin_unlock(&pde->pde_unload_lock);
 		} else
-			kfree(pdeo);
+			kmem_cache_free(pde_opener_cache, pdeo);
 	}
 
 out_unuse:
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -182,7 +182,7 @@ extern const struct inode_operations proc_link_inode_operations;
 
 extern const struct inode_operations proc_pid_link_inode_operations;
 
-extern void proc_init_inodecache(void);
+void proc_init_kmemcache(void);
 void set_proc_pid_nlink(void);
 extern struct inode *proc_get_inode(struct super_block *, struct proc_dir_entry *);
 extern int proc_fill_super(struct super_block *, void *data, int flags);
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -125,7 +125,7 @@ void __init proc_root_init(void)
 {
 	int err;
 
-	proc_init_inodecache();
+	proc_init_kmemcache();
 	set_proc_pid_nlink();
 	err = register_filesystem(&proc_fs_type);
 	if (err)
