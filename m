Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbeERUCT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 16:02:19 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:52936 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbeERUCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 16:02:17 -0400
X-Google-Smtp-Source: AB8JxZoDq2Dven7deS0Ol/P/wO8ijIFgQxNbTfJHKNephbPIifVd9OOza+d/9/6Tsgj3T4SxdGsZgg==
Date: Fri, 18 May 2018 23:02:13 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@lst.de
Subject: [PATCH -vfs] proc: don't maintain sizeof(struct proc_dir_entry)
Message-ID: <20180518200213.GA8006@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Automatically cap sizeof(struct proc_dir_entry) at 192/128 bytes or
256/192 bytes if spinlock debugging/lockdep is enabled.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/generic.c  |    2 +-
 fs/proc/inode.c    |    5 +++--
 fs/proc/internal.h |   10 ++++++----
 3 files changed, 10 insertions(+), 7 deletions(-)

--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -410,7 +410,7 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
 	if (!ent)
 		goto out;
 
-	if (qstr.len + 1 <= sizeof(ent->inline_name)) {
+	if (qstr.len + 1 <= SIZEOF_PDE_INLINE_NAME) {
 		ent->name = ent->inline_name;
 	} else {
 		ent->name = kmalloc(qstr.len + 1, GFP_KERNEL);
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -105,9 +105,10 @@ void __init proc_init_kmemcache(void)
 		kmem_cache_create("pde_opener", sizeof(struct pde_opener), 0,
 				  SLAB_ACCOUNT|SLAB_PANIC, NULL);
 	proc_dir_entry_cache = kmem_cache_create_usercopy(
-		"proc_dir_entry", sizeof(struct proc_dir_entry), 0, SLAB_PANIC,
+		"proc_dir_entry", SIZEOF_PDE, 0, SLAB_PANIC,
 		offsetof(struct proc_dir_entry, inline_name),
-		sizeof_field(struct proc_dir_entry, inline_name), NULL);
+		SIZEOF_PDE_INLINE_NAME, NULL);
+	BUILD_BUG_ON(sizeof(struct proc_dir_entry) >= SIZEOF_PDE);
 }
 
 static int proc_show_options(struct seq_file *seq, struct dentry *root)
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -61,13 +61,15 @@ struct proc_dir_entry {
 	char *name;
 	umode_t mode;
 	u8 namelen;
+	char inline_name[];
+} __randomize_layout;
+
 #ifdef CONFIG_64BIT
-#define SIZEOF_PDE_INLINE_NAME	(192-155)
+#define SIZEOF_PDE	(sizeof(spinlock_t) == 4 ? 192 : 256)
 #else
-#define SIZEOF_PDE_INLINE_NAME	(128-95)
+#define SIZEOF_PDE	(sizeof(spinlock_t) == 4 ? 128 : 192)
 #endif
-	char inline_name[SIZEOF_PDE_INLINE_NAME];
-} __randomize_layout;
+#define SIZEOF_PDE_INLINE_NAME	(SIZEOF_PDE - sizeof(struct proc_dir_entry))
 
 extern struct kmem_cache *proc_dir_entry_cache;
 void pde_free(struct proc_dir_entry *pde);
