Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbeDEUbP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:31:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752824AbeDEUbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:31:12 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 15/20] afs: Split the directory content defs into a header
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Apr 2018 21:31:09 +0100
Message-ID: <152296026946.31027.1635343575668154844.stgit@warthog.procyon.org.uk>
In-Reply-To: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the directory content definitions into a header file so that they can
be used by multiple .c files.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c    |   56 +++----------------------------------------------
 fs/afs/xdr_fs.h |   63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 52 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index e989a8fe9a9b..31703f93a90b 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -18,6 +18,7 @@
 #include <linux/sched.h>
 #include <linux/task_io_accounting_ops.h>
 #include "internal.h"
+#include "xdr_fs.h"
 
 static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 				 unsigned int flags);
@@ -86,55 +87,6 @@ const struct dentry_operations afs_fs_dentry_operations = {
 	.d_automount	= afs_d_automount,
 };
 
-#define AFS_DIR_HASHTBL_SIZE	128
-#define AFS_DIR_DIRENT_SIZE	32
-#define AFS_DIRENT_PER_BLOCK	64
-
-union afs_dirent {
-	struct {
-		uint8_t		valid;
-		uint8_t		unused[1];
-		__be16		hash_next;
-		__be32		vnode;
-		__be32		unique;
-		uint8_t		name[16];
-		uint8_t		overflow[4];	/* if any char of the name (inc
-						 * NUL) reaches here, consume
-						 * the next dirent too */
-	} u;
-	uint8_t	extended_name[32];
-};
-
-/* AFS directory page header (one at the beginning of every 2048-byte chunk) */
-struct afs_dir_pagehdr {
-	__be16		npages;
-	__be16		magic;
-#define AFS_DIR_MAGIC htons(1234)
-	uint8_t		nentries;
-	uint8_t		bitmap[8];
-	uint8_t		pad[19];
-};
-
-/* directory block layout */
-union afs_dir_block {
-
-	struct afs_dir_pagehdr pagehdr;
-
-	struct {
-		struct afs_dir_pagehdr	pagehdr;
-		uint8_t			alloc_ctrs[128];
-		/* dir hash table */
-		uint16_t		hashtable[AFS_DIR_HASHTBL_SIZE];
-	} hdr;
-
-	union afs_dirent dirents[AFS_DIRENT_PER_BLOCK];
-};
-
-/* layout on a linux VM page */
-struct afs_dir_page {
-	union afs_dir_block blocks[PAGE_SIZE / sizeof(union afs_dir_block)];
-};
-
 struct afs_lookup_one_cookie {
 	struct dir_context	ctx;
 	struct qstr		name;
@@ -371,8 +323,8 @@ static int afs_dir_iterate_block(struct dir_context *ctx,
 	curr = (ctx->pos - blkoff) / sizeof(union afs_dirent);
 
 	/* walk through the block, an entry at a time */
-	for (offset = AFS_DIRENT_PER_BLOCK - block->pagehdr.nentries;
-	     offset < AFS_DIRENT_PER_BLOCK;
+	for (offset = (blkoff == 0 ? AFS_DIR_RESV_BLOCKS0 : AFS_DIR_RESV_BLOCKS);
+	     offset < AFS_DIR_SLOTS_PER_BLOCK;
 	     offset = next
 	     ) {
 		next = offset + 1;
@@ -401,7 +353,7 @@ static int afs_dir_iterate_block(struct dir_context *ctx,
 
 		/* work out where the next possible entry is */
 		for (tmp = nlen; tmp > 15; tmp -= sizeof(union afs_dirent)) {
-			if (next >= AFS_DIRENT_PER_BLOCK) {
+			if (next >= AFS_DIR_SLOTS_PER_BLOCK) {
 				_debug("ENT[%zu.%u]:"
 				       " %u travelled beyond end dir block"
 				       " (len %u/%zu)",
diff --git a/fs/afs/xdr_fs.h b/fs/afs/xdr_fs.h
index 24e23e40c979..63e87ccbb55b 100644
--- a/fs/afs/xdr_fs.h
+++ b/fs/afs/xdr_fs.h
@@ -37,4 +37,67 @@ struct afs_xdr_AFSFetchStatus {
 	__be32	abort_code;
 } __packed;
 
+#define AFS_DIR_HASHTBL_SIZE	128
+#define AFS_DIR_DIRENT_SIZE	32
+#define AFS_DIR_SLOTS_PER_BLOCK	64
+#define AFS_DIR_BLOCK_SIZE	2048
+#define AFS_DIR_BLOCKS_PER_PAGE	(PAGE_SIZE / AFS_DIR_BLOCK_SIZE)
+#define AFS_DIR_MAX_SLOTS	65536
+#define AFS_DIR_BLOCKS_WITH_CTR	128
+#define AFS_DIR_MAX_BLOCKS	1023
+#define AFS_DIR_RESV_BLOCKS	1
+#define AFS_DIR_RESV_BLOCKS0	13
+
+/*
+ * Directory entry structure.
+ */
+union afs_dirent {
+	struct {
+		uint8_t		valid;
+		uint8_t		unused[1];
+		__be16		hash_next;
+		__be32		vnode;
+		__be32		unique;
+		uint8_t		name[16];
+		uint8_t		overflow[4];	/* if any char of the name (inc
+						 * NUL) reaches here, consume
+						 * the next dirent too */
+	} u;
+	uint8_t	extended_name[32];
+};
+
+/*
+ * Directory page header (one at the beginning of every 2048-byte chunk).
+ */
+struct afs_dir_pagehdr {
+	__be16		npages;
+	__be16		magic;
+#define AFS_DIR_MAGIC htons(1234)
+	uint8_t		reserved;
+	uint8_t		bitmap[8];
+	uint8_t		pad[19];
+};
+
+/*
+ * Directory block layout
+ */
+union afs_dir_block {
+	struct afs_dir_pagehdr	pagehdr;
+
+	struct {
+		struct afs_dir_pagehdr	pagehdr;
+		uint8_t			alloc_ctrs[AFS_DIR_MAX_BLOCKS];
+		__be16			hashtable[AFS_DIR_HASHTBL_SIZE];
+	} hdr;
+
+	union afs_dirent	dirents[AFS_DIR_SLOTS_PER_BLOCK];
+};
+
+/*
+ * Directory layout on a linux VM page.
+ */
+struct afs_dir_page {
+	union afs_dir_block	blocks[AFS_DIR_BLOCKS_PER_PAGE];
+};
+
 #endif /* XDR_FS_H */
