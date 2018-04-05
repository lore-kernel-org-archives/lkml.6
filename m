Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753375AbeDEUbW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:31:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751365AbeDEUbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:31:18 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 16/20] afs: Adjust the directory XDR structures
From: David Howells <dhowells@redhat.com>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Apr 2018 21:31:16 +0100
Message-ID: <152296027685.31027.5137707552979822576.stgit@warthog.procyon.org.uk>
In-Reply-To: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
References: <152296016916.31027.8912809030401942390.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust the AFS directory XDR structures in a number of superficial ways:

 (1) Rename them to all begin afs_xdr_.

 (2) Use u8 instead of uint8_t.

 (3) Mark the structures as __packed so they don't get rearranged by the
     compiler.

 (4) Rename the hdr member of afs_xdr_dir_block to meta.

 (5) Rename the pagehdr member of afs_xdr_dir_block to hdr.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c    |   62 ++++++++++++++++++++++++++++---------------------------
 fs/afs/xdr_fs.h |   44 ++++++++++++++++++++-------------------
 2 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 31703f93a90b..9efaa1f53bd8 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -111,7 +111,7 @@ struct afs_lookup_cookie {
 static bool afs_dir_check_page(struct afs_vnode *dvnode, struct page *page,
 			       loff_t i_size)
 {
-	struct afs_dir_page *dbuf;
+	struct afs_xdr_dir_page *dbuf;
 	loff_t latter, off;
 	int tmp, qty;
 
@@ -127,15 +127,15 @@ static bool afs_dir_check_page(struct afs_vnode *dvnode, struct page *page,
 		qty = PAGE_SIZE;
 	else
 		qty = latter;
-	qty /= sizeof(union afs_dir_block);
+	qty /= sizeof(union afs_xdr_dir_block);
 
 	/* check them */
 	dbuf = page_address(page);
 	for (tmp = 0; tmp < qty; tmp++) {
-		if (dbuf->blocks[tmp].pagehdr.magic != AFS_DIR_MAGIC) {
+		if (dbuf->blocks[tmp].hdr.magic != AFS_DIR_MAGIC) {
 			printk("kAFS: %s(%lx): bad magic %d/%d is %04hx\n",
 			       __func__, dvnode->vfs_inode.i_ino, tmp, qty,
-			       ntohs(dbuf->blocks[tmp].pagehdr.magic));
+			       ntohs(dbuf->blocks[tmp].hdr.magic));
 			trace_afs_dir_check_failed(dvnode, off, i_size);
 			goto error;
 		}
@@ -156,8 +156,8 @@ static int afs_dir_open(struct inode *inode, struct file *file)
 {
 	_enter("{%lu}", inode->i_ino);
 
-	BUILD_BUG_ON(sizeof(union afs_dir_block) != 2048);
-	BUILD_BUG_ON(sizeof(union afs_dirent) != 32);
+	BUILD_BUG_ON(sizeof(union afs_xdr_dir_block) != 2048);
+	BUILD_BUG_ON(sizeof(union afs_xdr_dirent) != 32);
 
 	if (test_bit(AFS_VNODE_DELETED, &AFS_FS_I(inode)->flags))
 		return -ENOENT;
@@ -310,17 +310,17 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
  * deal with one block in an AFS directory
  */
 static int afs_dir_iterate_block(struct dir_context *ctx,
-				 union afs_dir_block *block,
+				 union afs_xdr_dir_block *block,
 				 unsigned blkoff)
 {
-	union afs_dirent *dire;
+	union afs_xdr_dirent *dire;
 	unsigned offset, next, curr;
 	size_t nlen;
 	int tmp;
 
 	_enter("%u,%x,%p,,",(unsigned)ctx->pos,blkoff,block);
 
-	curr = (ctx->pos - blkoff) / sizeof(union afs_dirent);
+	curr = (ctx->pos - blkoff) / sizeof(union afs_xdr_dirent);
 
 	/* walk through the block, an entry at a time */
 	for (offset = (blkoff == 0 ? AFS_DIR_RESV_BLOCKS0 : AFS_DIR_RESV_BLOCKS);
@@ -330,13 +330,13 @@ static int afs_dir_iterate_block(struct dir_context *ctx,
 		next = offset + 1;
 
 		/* skip entries marked unused in the bitmap */
-		if (!(block->pagehdr.bitmap[offset / 8] &
+		if (!(block->hdr.bitmap[offset / 8] &
 		      (1 << (offset % 8)))) {
 			_debug("ENT[%zu.%u]: unused",
-			       blkoff / sizeof(union afs_dir_block), offset);
+			       blkoff / sizeof(union afs_xdr_dir_block), offset);
 			if (offset >= curr)
 				ctx->pos = blkoff +
-					next * sizeof(union afs_dirent);
+					next * sizeof(union afs_xdr_dirent);
 			continue;
 		}
 
@@ -344,34 +344,34 @@ static int afs_dir_iterate_block(struct dir_context *ctx,
 		dire = &block->dirents[offset];
 		nlen = strnlen(dire->u.name,
 			       sizeof(*block) -
-			       offset * sizeof(union afs_dirent));
+			       offset * sizeof(union afs_xdr_dirent));
 
 		_debug("ENT[%zu.%u]: %s %zu \"%s\"",
-		       blkoff / sizeof(union afs_dir_block), offset,
+		       blkoff / sizeof(union afs_xdr_dir_block), offset,
 		       (offset < curr ? "skip" : "fill"),
 		       nlen, dire->u.name);
 
 		/* work out where the next possible entry is */
-		for (tmp = nlen; tmp > 15; tmp -= sizeof(union afs_dirent)) {
+		for (tmp = nlen; tmp > 15; tmp -= sizeof(union afs_xdr_dirent)) {
 			if (next >= AFS_DIR_SLOTS_PER_BLOCK) {
 				_debug("ENT[%zu.%u]:"
 				       " %u travelled beyond end dir block"
 				       " (len %u/%zu)",
-				       blkoff / sizeof(union afs_dir_block),
+				       blkoff / sizeof(union afs_xdr_dir_block),
 				       offset, next, tmp, nlen);
 				return -EIO;
 			}
-			if (!(block->pagehdr.bitmap[next / 8] &
+			if (!(block->hdr.bitmap[next / 8] &
 			      (1 << (next % 8)))) {
 				_debug("ENT[%zu.%u]:"
 				       " %u unmarked extension (len %u/%zu)",
-				       blkoff / sizeof(union afs_dir_block),
+				       blkoff / sizeof(union afs_xdr_dir_block),
 				       offset, next, tmp, nlen);
 				return -EIO;
 			}
 
 			_debug("ENT[%zu.%u]: ext %u/%zu",
-			       blkoff / sizeof(union afs_dir_block),
+			       blkoff / sizeof(union afs_xdr_dir_block),
 			       next, tmp, nlen);
 			next++;
 		}
@@ -390,7 +390,7 @@ static int afs_dir_iterate_block(struct dir_context *ctx,
 			return 0;
 		}
 
-		ctx->pos = blkoff + next * sizeof(union afs_dirent);
+		ctx->pos = blkoff + next * sizeof(union afs_xdr_dirent);
 	}
 
 	_leave(" = 1 [more]");
@@ -404,8 +404,8 @@ static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
 			   struct key *key)
 {
 	struct afs_vnode *dvnode = AFS_FS_I(dir);
-	union afs_dir_block *dblock;
-	struct afs_dir_page *dbuf;
+	struct afs_xdr_dir_page *dbuf;
+	union afs_xdr_dir_block *dblock;
 	struct afs_read *req;
 	struct page *page;
 	unsigned blkoff, limit;
@@ -423,13 +423,13 @@ static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
 		return PTR_ERR(req);
 
 	/* round the file position up to the next entry boundary */
-	ctx->pos += sizeof(union afs_dirent) - 1;
-	ctx->pos &= ~(sizeof(union afs_dirent) - 1);
+	ctx->pos += sizeof(union afs_xdr_dirent) - 1;
+	ctx->pos &= ~(sizeof(union afs_xdr_dirent) - 1);
 
 	/* walk through the blocks in sequence */
 	ret = 0;
 	while (ctx->pos < req->actual_len) {
-		blkoff = ctx->pos & ~(sizeof(union afs_dir_block) - 1);
+		blkoff = ctx->pos & ~(sizeof(union afs_xdr_dir_block) - 1);
 
 		/* Fetch the appropriate page from the directory and re-add it
 		 * to the LRU.
@@ -448,14 +448,14 @@ static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
 		/* deal with the individual blocks stashed on this page */
 		do {
 			dblock = &dbuf->blocks[(blkoff % PAGE_SIZE) /
-					       sizeof(union afs_dir_block)];
+					       sizeof(union afs_xdr_dir_block)];
 			ret = afs_dir_iterate_block(ctx, dblock, blkoff);
 			if (ret != 1) {
 				kunmap(page);
 				goto out;
 			}
 
-			blkoff += sizeof(union afs_dir_block);
+			blkoff += sizeof(union afs_xdr_dir_block);
 
 		} while (ctx->pos < dir->i_size && blkoff < limit);
 
@@ -493,8 +493,8 @@ static int afs_lookup_one_filldir(struct dir_context *ctx, const char *name,
 	       (unsigned long long) ino, dtype);
 
 	/* insanity checks first */
-	BUILD_BUG_ON(sizeof(union afs_dir_block) != 2048);
-	BUILD_BUG_ON(sizeof(union afs_dirent) != 32);
+	BUILD_BUG_ON(sizeof(union afs_xdr_dir_block) != 2048);
+	BUILD_BUG_ON(sizeof(union afs_xdr_dirent) != 32);
 
 	if (cookie->name.len != nlen ||
 	    memcmp(cookie->name.name, name, nlen) != 0) {
@@ -562,8 +562,8 @@ static int afs_lookup_filldir(struct dir_context *ctx, const char *name,
 	       (unsigned long long) ino, dtype);
 
 	/* insanity checks first */
-	BUILD_BUG_ON(sizeof(union afs_dir_block) != 2048);
-	BUILD_BUG_ON(sizeof(union afs_dirent) != 32);
+	BUILD_BUG_ON(sizeof(union afs_xdr_dir_block) != 2048);
+	BUILD_BUG_ON(sizeof(union afs_xdr_dirent) != 32);
 
 	if (cookie->found) {
 		if (cookie->nr_fids < 50) {
diff --git a/fs/afs/xdr_fs.h b/fs/afs/xdr_fs.h
index 63e87ccbb55b..aa21f3068d52 100644
--- a/fs/afs/xdr_fs.h
+++ b/fs/afs/xdr_fs.h
@@ -51,53 +51,53 @@ struct afs_xdr_AFSFetchStatus {
 /*
  * Directory entry structure.
  */
-union afs_dirent {
+union afs_xdr_dirent {
 	struct {
-		uint8_t		valid;
-		uint8_t		unused[1];
+		u8		valid;
+		u8		unused[1];
 		__be16		hash_next;
 		__be32		vnode;
 		__be32		unique;
-		uint8_t		name[16];
-		uint8_t		overflow[4];	/* if any char of the name (inc
+		u8		name[16];
+		u8		overflow[4];	/* if any char of the name (inc
 						 * NUL) reaches here, consume
 						 * the next dirent too */
 	} u;
-	uint8_t	extended_name[32];
-};
+	u8			extended_name[32];
+} __packed;
 
 /*
- * Directory page header (one at the beginning of every 2048-byte chunk).
+ * Directory block header (one at the beginning of every 2048-byte block).
  */
-struct afs_dir_pagehdr {
+struct afs_xdr_dir_hdr {
 	__be16		npages;
 	__be16		magic;
 #define AFS_DIR_MAGIC htons(1234)
-	uint8_t		reserved;
-	uint8_t		bitmap[8];
-	uint8_t		pad[19];
-};
+	u8		reserved;
+	u8		bitmap[8];
+	u8		pad[19];
+} __packed;
 
 /*
  * Directory block layout
  */
-union afs_dir_block {
-	struct afs_dir_pagehdr	pagehdr;
+union afs_xdr_dir_block {
+	struct afs_xdr_dir_hdr		hdr;
 
 	struct {
-		struct afs_dir_pagehdr	pagehdr;
-		uint8_t			alloc_ctrs[AFS_DIR_MAX_BLOCKS];
+		struct afs_xdr_dir_hdr	hdr;
+		u8			alloc_ctrs[AFS_DIR_MAX_BLOCKS];
 		__be16			hashtable[AFS_DIR_HASHTBL_SIZE];
-	} hdr;
+	} meta;
 
-	union afs_dirent	dirents[AFS_DIR_SLOTS_PER_BLOCK];
-};
+	union afs_xdr_dirent	dirents[AFS_DIR_SLOTS_PER_BLOCK];
+} __packed;
 
 /*
  * Directory layout on a linux VM page.
  */
-struct afs_dir_page {
-	union afs_dir_block	blocks[AFS_DIR_BLOCKS_PER_PAGE];
+struct afs_xdr_dir_page {
+	union afs_xdr_dir_block	blocks[AFS_DIR_BLOCKS_PER_PAGE];
 };
 
 #endif /* XDR_FS_H */
