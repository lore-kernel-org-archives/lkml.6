Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753519AbeDEUbr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:31:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751285AbeDEUbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:31:44 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 20/20] afs: Do better accretion of small writes on newly
 created content
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Apr 2018 21:31:42 +0100
Message-ID: <152296030260.31027.9879550476799020364.stgit@warthog.procyon.org.uk>
In-Reply-To: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Processes like ld that do lots of small writes that aren't necessarily
contiguous result in a lot of small StoreData operations to the server, the
idea being that if someone else changes the data on the server, we only
write our changes over that and not the space between.  Further, we don't
want to write back empty space if we can avoid it to make it easier for the
server to do sparse files.

However, making lots of tiny RPC ops is a lot less efficient for the server
than one big one because each op requires allocation of resources and the
taking of locks, so we want to compromise a bit.

Reduce the load by the following:

 (1) If a file is just created locally or has just been truncated with
     O_TRUNC locally, allow subsequent writes to the file to be merged with
     intervening space if that space doesn't cross an entire intervening
     page.

 (2) Don't flush the file on ->flush() but rather on ->release() if the
     file was open for writing.

Just linking vmlinux.o, without this patch, looking in /proc/fs/afs/stats:

	file-wr : n=441 nb=513581204

and after the patch:

	file-wr : n=62 nb=513668555

there were 379 fewer StoreData RPC operations at the expense of an extra
87K being written.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/callback.c |    1 +
 fs/afs/dir.c      |    3 +++
 fs/afs/file.c     |    7 ++++++-
 fs/afs/internal.h |    2 +-
 fs/afs/write.c    |   32 +++++++++++++-------------------
 5 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 6049ca837498..abd9a84f4e88 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -130,6 +130,7 @@ void afs_break_callback(struct afs_vnode *vnode)
 
 	write_seqlock(&vnode->cb_lock);
 
+	clear_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
 	if (test_and_clear_bit(AFS_VNODE_CB_PROMISED, &vnode->flags)) {
 		vnode->cb_break++;
 		afs_clear_permits(vnode);
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 7701e382fa94..a14ea4280590 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1105,6 +1105,7 @@ static void afs_vnode_new_inode(struct afs_fs_cursor *fc,
 				struct afs_file_status *newstatus,
 				struct afs_callback *newcb)
 {
+	struct afs_vnode *vnode;
 	struct inode *inode;
 
 	if (fc->ac.error < 0)
@@ -1122,6 +1123,8 @@ static void afs_vnode_new_inode(struct afs_fs_cursor *fc,
 		return;
 	}
 
+	vnode = AFS_FS_I(inode);
+	set_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
 	d_add(new_dentry, inode);
 }
 
diff --git a/fs/afs/file.c b/fs/afs/file.c
index e5cac1bc3cf0..c24c08016dd9 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -30,7 +30,6 @@ static int afs_readpages(struct file *filp, struct address_space *mapping,
 
 const struct file_operations afs_file_operations = {
 	.open		= afs_open,
-	.flush		= afs_flush,
 	.release	= afs_release,
 	.llseek		= generic_file_llseek,
 	.read_iter	= generic_file_read_iter,
@@ -146,6 +145,9 @@ int afs_open(struct inode *inode, struct file *file)
 		if (ret < 0)
 			goto error_af;
 	}
+
+	if (file->f_flags & O_TRUNC)
+		set_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags);
 	
 	file->private_data = af;
 	_leave(" = 0");
@@ -170,6 +172,9 @@ int afs_release(struct inode *inode, struct file *file)
 
 	_enter("{%x:%u},", vnode->fid.vid, vnode->fid.vnode);
 
+	if ((file->f_mode & FMODE_WRITE))
+		return vfs_fsync(file, 0);
+
 	file->private_data = NULL;
 	if (af->wb)
 		afs_put_wb_key(af->wb);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 184094810038..70dd41e06363 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -504,6 +504,7 @@ struct afs_vnode {
 #define AFS_VNODE_MOUNTPOINT	5		/* set if vnode is a mountpoint symlink */
 #define AFS_VNODE_AUTOCELL	6		/* set if Vnode is an auto mount point */
 #define AFS_VNODE_PSEUDODIR	7 		/* set if Vnode is a pseudo directory */
+#define AFS_VNODE_NEW_CONTENT	8		/* Set if file has new content (create/trunc-0) */
 
 	struct list_head	wb_keys;	/* List of keys available for writeback */
 	struct list_head	pending_locks;	/* locks waiting to be granted */
@@ -1023,7 +1024,6 @@ extern int afs_writepage(struct page *, struct writeback_control *);
 extern int afs_writepages(struct address_space *, struct writeback_control *);
 extern void afs_pages_written_back(struct afs_vnode *, struct afs_call *);
 extern ssize_t afs_file_write(struct kiocb *, struct iov_iter *);
-extern int afs_flush(struct file *, fl_owner_t);
 extern int afs_fsync(struct file *, loff_t, loff_t, int);
 extern int afs_page_mkwrite(struct vm_fault *);
 extern void afs_prune_wb_keys(struct afs_vnode *);
diff --git a/fs/afs/write.c b/fs/afs/write.c
index eccc16198f68..160f6cc26c00 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -125,7 +125,12 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 					     page->index, priv);
 			goto flush_conflicting_write;
 		}
-		if (to < f || from > t)
+		/* If the file is being filled locally, allow inter-write
+		 * spaces to be merged into writes.  If it's not, only write
+		 * back what the user gives us.
+		 */
+		if (!test_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags) &&
+		    (to < f || from > t))
 			goto flush_conflicting_write;
 		if (from < f)
 			f = from;
@@ -419,7 +424,8 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
 		trace_afs_page_dirty(vnode, tracepoint_string("WARN"),
 				     primary_page->index, priv);
 
-	if (start >= final_page || to < PAGE_SIZE)
+	if (start >= final_page ||
+	    (to < PAGE_SIZE && !test_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags)))
 		goto no_more;
 
 	start++;
@@ -440,9 +446,10 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
 		}
 
 		for (loop = 0; loop < n; loop++) {
-			if (to != PAGE_SIZE)
-				break;
 			page = pages[loop];
+			if (to != PAGE_SIZE &&
+			    !test_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags))
+				break;
 			if (page->index > final_page)
 				break;
 			if (!trylock_page(page))
@@ -455,7 +462,8 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
 			priv = page_private(page);
 			f = priv & AFS_PRIV_MAX;
 			t = priv >> AFS_PRIV_SHIFT;
-			if (f != 0) {
+			if (f != 0 &&
+			    !test_bit(AFS_VNODE_NEW_CONTENT, &vnode->flags)) {
 				unlock_page(page);
 				break;
 			}
@@ -740,20 +748,6 @@ int afs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	return file_write_and_wait_range(file, start, end);
 }
 
-/*
- * Flush out all outstanding writes on a file opened for writing when it is
- * closed.
- */
-int afs_flush(struct file *file, fl_owner_t id)
-{
-	_enter("");
-
-	if ((file->f_mode & FMODE_WRITE) == 0)
-		return 0;
-
-	return vfs_fsync(file, 0);
-}
-
 /*
  * notification that a previously read-only page is about to become writable
  * - if it returns an error, the caller will deliver a bus error signal
