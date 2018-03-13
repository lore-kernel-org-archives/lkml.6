Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752413AbeCMRpz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:45:55 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38746 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752004AbeCMRpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:45:54 -0400
X-Google-Smtp-Source: AG47ELsw4ktj1TIq28UzA/MPldJf93OniXfdCO9PSsX2WG3BSf93kOCVT5Li1ydATqTrzBczf9SIKA==
Date: Tue, 13 Mar 2018 20:45:50 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] proc: switch struct proc_dir_entry::count to refcount
Message-ID: <20180313174550.GA4332@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

->count is honest reference count unlike ->in_use.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/generic.c  |    4 ++--
 fs/proc/internal.h |    5 +++--
 fs/proc/root.c     |    2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -423,7 +423,7 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
 	ent->mode = mode;
 	ent->nlink = nlink;
 	ent->subdir = RB_ROOT_CACHED;
-	atomic_set(&ent->count, 1);
+	refcount_set(&ent->refcnt, 1);
 	spin_lock_init(&ent->pde_unload_lock);
 	INIT_LIST_HEAD(&ent->pde_openers);
 	proc_set_user(ent, (*parent)->uid, (*parent)->gid);
@@ -574,7 +574,7 @@ EXPORT_SYMBOL(proc_set_user);
 
 void pde_put(struct proc_dir_entry *pde)
 {
-	if (atomic_dec_and_test(&pde->count)) {
+	if (refcount_dec_and_test(&pde->refcnt)) {
 		proc_free_inum(pde->low_ino);
 		pde_free(pde);
 	}
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -11,6 +11,7 @@
 
 #include <linux/proc_fs.h>
 #include <linux/proc_ns.h>
+#include <linux/refcount.h>
 #include <linux/spinlock.h>
 #include <linux/atomic.h>
 #include <linux/binfmts.h>
@@ -36,7 +37,7 @@ struct proc_dir_entry {
 	 * negative -> it's going away RSN
 	 */
 	atomic_t in_use;
-	atomic_t count;		/* use count */
+	refcount_t refcnt;
 	struct list_head pde_openers;	/* who did ->open, but not ->release */
 	/* protects ->pde_openers and all struct pde_opener instances */
 	spinlock_t pde_unload_lock;
@@ -168,7 +169,7 @@ int proc_readdir_de(struct file *, struct dir_context *, struct proc_dir_entry *
 
 static inline struct proc_dir_entry *pde_get(struct proc_dir_entry *pde)
 {
-	atomic_inc(&pde->count);
+	refcount_inc(&pde->refcnt);
 	return pde;
 }
 extern void pde_put(struct proc_dir_entry *);
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -199,7 +199,7 @@ struct proc_dir_entry proc_root = {
 	.namelen	= 5, 
 	.mode		= S_IFDIR | S_IRUGO | S_IXUGO, 
 	.nlink		= 2, 
-	.count		= ATOMIC_INIT(1),
+	.refcnt		= REFCOUNT_INIT(1),
 	.proc_iops	= &proc_root_inode_operations, 
 	.proc_fops	= &proc_root_operations,
 	.parent		= &proc_root,
