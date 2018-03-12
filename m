Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932354AbeCLUTn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:19:43 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:53440 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932171AbeCLUTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:19:42 -0400
X-Google-Smtp-Source: AG47ELvu34pl0MR+UE/ife8JBIfXunvJAk5m8e52fGUPC2RQB89ygEil9EIBWtZZGiY8thjKgUvsDA==
Date: Mon, 12 Mar 2018 23:19:38 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: [PATCH] proc: revalidate misc dentries
Message-ID: <20180312201938.GA4871@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If module removes proc directory while another process pins it
by chdir'ing to it, then subsequent recreation of proc entry and
all entries down the tree will not be visible to any process
until pinning process unchdir from directory and unpins everything.

Steps to reproduce:

	proc_mkdir("aaa", NULL);
	proc_create("aaa/bbb", ...);

		chdir("/proc/aaa");

	remove_proc_entry("aaa/bbb", NULL);
	remove_proc_entry("aaa", NULL);

	proc_mkdir("aaa", NULL);
	# inaccessible because "aaa" dentry still points
	# to the original "aaa".
	proc_create("aaa/bbb", ...);

Fix is to implement ->d_revalidate and ->d_delete.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/generic.c |   23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -15,6 +15,7 @@
 #include <linux/stat.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/namei.h>
 #include <linux/slab.h>
 #include <linux/printk.h>
 #include <linux/mount.h>
@@ -219,6 +220,26 @@ void proc_free_inum(unsigned int inum)
 	ida_simple_remove(&proc_inum_ida, inum - PROC_DYNAMIC_FIRST);
 }
 
+static int proc_misc_d_revalidate(struct dentry *dentry, unsigned int flags)
+{
+	if (flags & LOOKUP_RCU)
+		return -ECHILD;
+
+	if (atomic_read(&PDE(d_inode(dentry))->in_use) < 0)
+		return 0; /* revalidate */
+	return 1;
+}
+
+static int proc_misc_d_delete(const struct dentry *dentry)
+{
+	return atomic_read(&PDE(d_inode(dentry))->in_use) < 0;
+}
+
+static const struct dentry_operations proc_misc_dentry_ops = {
+	.d_revalidate	= proc_misc_d_revalidate,
+	.d_delete	= proc_misc_d_delete,
+};
+
 /*
  * Don't create negative dentries here, return -ENOENT by hand
  * instead.
@@ -236,7 +257,7 @@ struct dentry *proc_lookup_de(struct inode *dir, struct dentry *dentry,
 		inode = proc_get_inode(dir->i_sb, de);
 		if (!inode)
 			return ERR_PTR(-ENOMEM);
-		d_set_d_op(dentry, &simple_dentry_operations);
+		d_set_d_op(dentry, &proc_misc_dentry_ops);
 		d_add(dentry, inode);
 		return NULL;
 	}
