Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756178AbeEHSer (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:34:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:53874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755633AbeEHSFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:05:23 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 24/76] fs/crypto: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:03:44 -0700
Message-Id: <20180508180436.716-25-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/crypto/bio.c     | 10 +++++-----
 fs/crypto/crypto.c  |  4 ++--
 fs/crypto/fname.c   |  4 ++--
 fs/crypto/keyinfo.c |  8 ++++----
 fs/crypto/policy.c  | 12 ++++++------
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 0d5e6a569d58..0f7daacfa3de 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -92,7 +92,7 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 	struct bio *bio;
 	int ret, err = 0;
 
-	BUG_ON(inode->i_sb->s_blocksize != PAGE_SIZE);
+	BUG_ON(inode_sb(inode)->s_blocksize != PAGE_SIZE);
 
 	ctx = fscrypt_get_ctx(inode, GFP_NOFS);
 	if (IS_ERR(ctx))
@@ -116,13 +116,13 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 			err = -ENOMEM;
 			goto errout;
 		}
-		bio_set_dev(bio, inode->i_sb->s_bdev);
+		bio_set_dev(bio, inode_sb(inode)->s_bdev);
 		bio->bi_iter.bi_sector =
-			pblk << (inode->i_sb->s_blocksize_bits - 9);
+			pblk << (inode_sb(inode)->s_blocksize_bits - 9);
 		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 		ret = bio_add_page(bio, ciphertext_page,
-					inode->i_sb->s_blocksize, 0);
-		if (ret != inode->i_sb->s_blocksize) {
+					inode_sb(inode)->s_blocksize, 0);
+		if (ret != inode_sb(inode)->s_blocksize) {
 			/* should never happen! */
 			WARN_ON(1);
 			bio_put(bio);
diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index ce654526c0fb..94b88687fe3f 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -240,7 +240,7 @@ struct page *fscrypt_encrypt_page(const struct inode *inode,
 
 	BUG_ON(len % FS_CRYPTO_BLOCK_SIZE != 0);
 
-	if (inode->i_sb->s_cop->flags & FS_CFLG_OWN_PAGES) {
+	if (inode_sb(inode)->s_cop->flags & FS_CFLG_OWN_PAGES) {
 		/* with inplace-encryption we just encrypt the page */
 		err = fscrypt_do_page_crypto(inode, FS_ENCRYPT, lblk_num, page,
 					     ciphertext_page, len, offs,
@@ -299,7 +299,7 @@ EXPORT_SYMBOL(fscrypt_encrypt_page);
 int fscrypt_decrypt_page(const struct inode *inode, struct page *page,
 			unsigned int len, unsigned int offs, u64 lblk_num)
 {
-	if (!(inode->i_sb->s_cop->flags & FS_CFLG_OWN_PAGES))
+	if (!(inode_sb(inode)->s_cop->flags & FS_CFLG_OWN_PAGES))
 		BUG_ON(!PageLocked(page));
 
 	return fscrypt_do_page_crypto(inode, FS_DECRYPT, lblk_num, page, page,
diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index e33f3d3c5ade..cc0e7632e2d6 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -102,7 +102,7 @@ static int fname_decrypt(struct inode *inode,
 	char iv[FS_CRYPTO_BLOCK_SIZE];
 	unsigned lim;
 
-	lim = inode->i_sb->s_cop->max_namelen(inode);
+	lim = inode_sb(inode)->s_cop->max_namelen(inode);
 	if (iname->len <= 0 || iname->len > lim)
 		return -EIO;
 
@@ -346,7 +346,7 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 
 	if (dir->i_crypt_info) {
 		if (!fscrypt_fname_encrypted_size(dir, iname->len,
-						  dir->i_sb->s_cop->max_namelen(dir),
+						  inode_sb(dir)->s_cop->max_namelen(dir),
 						  &fname->crypto_buf.len))
 			return -ENAMETOOLONG;
 		fname->crypto_buf.name = kmalloc(fname->crypto_buf.len,
diff --git a/fs/crypto/keyinfo.c b/fs/crypto/keyinfo.c
index 05f5ee1f0705..13beafec4355 100644
--- a/fs/crypto/keyinfo.c
+++ b/fs/crypto/keyinfo.c
@@ -253,11 +253,11 @@ int fscrypt_get_encryption_info(struct inode *inode)
 	if (inode->i_crypt_info)
 		return 0;
 
-	res = fscrypt_initialize(inode->i_sb->s_cop->flags);
+	res = fscrypt_initialize(inode_sb(inode)->s_cop->flags);
 	if (res)
 		return res;
 
-	res = inode->i_sb->s_cop->get_context(inode, &ctx, sizeof(ctx));
+	res = inode_sb(inode)->s_cop->get_context(inode, &ctx, sizeof(ctx));
 	if (res < 0) {
 		if (!fscrypt_dummy_context_enabled(inode) ||
 		    IS_ENCRYPTED(inode))
@@ -305,9 +305,9 @@ int fscrypt_get_encryption_info(struct inode *inode)
 
 	res = validate_user_key(crypt_info, &ctx, raw_key, FS_KEY_DESC_PREFIX,
 				keysize);
-	if (res && inode->i_sb->s_cop->key_prefix) {
+	if (res && inode_sb(inode)->s_cop->key_prefix) {
 		int res2 = validate_user_key(crypt_info, &ctx, raw_key,
-					     inode->i_sb->s_cop->key_prefix,
+					     inode_sb(inode)->s_cop->key_prefix,
 					     keysize);
 		if (res2) {
 			if (res2 == -ENOKEY)
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index c6d431a5cce9..76d99e0af39a 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -52,7 +52,7 @@ static int create_encryption_context_from_policy(struct inode *inode,
 	BUILD_BUG_ON(sizeof(ctx.nonce) != FS_KEY_DERIVATION_NONCE_SIZE);
 	get_random_bytes(ctx.nonce, FS_KEY_DERIVATION_NONCE_SIZE);
 
-	return inode->i_sb->s_cop->set_context(inode, &ctx, sizeof(ctx), NULL);
+	return inode_sb(inode)->s_cop->set_context(inode, &ctx, sizeof(ctx), NULL);
 }
 
 int fscrypt_ioctl_set_policy(struct file *filp, const void __user *arg)
@@ -77,11 +77,11 @@ int fscrypt_ioctl_set_policy(struct file *filp, const void __user *arg)
 
 	inode_lock(inode);
 
-	ret = inode->i_sb->s_cop->get_context(inode, &ctx, sizeof(ctx));
+	ret = inode_sb(inode)->s_cop->get_context(inode, &ctx, sizeof(ctx));
 	if (ret == -ENODATA) {
 		if (!S_ISDIR(inode->i_mode))
 			ret = -ENOTDIR;
-		else if (!inode->i_sb->s_cop->empty_dir(inode))
+		else if (!inode_sb(inode)->s_cop->empty_dir(inode))
 			ret = -ENOTEMPTY;
 		else
 			ret = create_encryption_context_from_policy(inode,
@@ -113,7 +113,7 @@ int fscrypt_ioctl_get_policy(struct file *filp, void __user *arg)
 	if (!IS_ENCRYPTED(inode))
 		return -ENODATA;
 
-	res = inode->i_sb->s_cop->get_context(inode, &ctx, sizeof(ctx));
+	res = inode_sb(inode)->s_cop->get_context(inode, &ctx, sizeof(ctx));
 	if (res < 0 && res != -ERANGE)
 		return res;
 	if (res != sizeof(ctx))
@@ -156,7 +156,7 @@ EXPORT_SYMBOL(fscrypt_ioctl_get_policy);
  */
 int fscrypt_has_permitted_context(struct inode *parent, struct inode *child)
 {
-	const struct fscrypt_operations *cops = parent->i_sb->s_cop;
+	const struct fscrypt_operations *cops = inode_sb(parent)->s_cop;
 	const struct fscrypt_info *parent_ci, *child_ci;
 	struct fscrypt_context parent_ctx, child_ctx;
 	int res;
@@ -258,7 +258,7 @@ int fscrypt_inherit_context(struct inode *parent, struct inode *child,
 	       FS_KEY_DESCRIPTOR_SIZE);
 	get_random_bytes(ctx.nonce, FS_KEY_DERIVATION_NONCE_SIZE);
 	BUILD_BUG_ON(sizeof(ctx) != FSCRYPT_SET_CONTEXT_MAX_SIZE);
-	res = parent->i_sb->s_cop->set_context(child, &ctx,
+	res = inode_sb(parent)->s_cop->set_context(child, &ctx,
 						sizeof(ctx), fs_data);
 	if (res)
 		return res;
-- 
2.15.1
