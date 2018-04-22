Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+66nlqqAh01N6KTDJzupedth3eTxMqBDYuhflVVH3sHx/7LxYZ0ymh/j6vrlMi7L74bg4P
ARC-Seal: i=1; a=rsa-sha256; t=1524405516; cv=none;
        d=google.com; s=arc-20160816;
        b=cqqJYVvQbDm+N0JCYNu3SzJNk/iDuN6qNxC5TDQxwJOjtknMm/7r4DGam0m24ByekQ
         sWqr9f6UZr+D+AoPo8xnz7BG+BgFkgvKWiBh38NyA2ItySz8fmzZgKCaKPvMyqa7DEvc
         FZShooe8ToB9pyDxOiJc2ziy8TDJOcrbVuLOfQNBtP6BAXE5lr7OHT6P786OEwgv0U+1
         pBdxTZ6PeWf1TlPmSw37DwKsWaJ7eHQuDd8r3wH7l4SYLwYPT9Lds1JS2N2l9uVxlFTL
         BzONQAz0OC4NCnCXNdHorfoFR/7KiZM24T9VQv6Dw21jneHgdzeLJoNiYJWKqNRn0PIf
         WJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=upIjqkYW5/GTU9P2kuo8Pt0i0F501BN2EyDkZja6DfY=;
        b=tdzRHLR1t6ODLkeh+0YyZbGply6YAple6RY5DfUF8PCT+SqnXORFnAXXE2mD640tVw
         N71gpUK9xPM0lQJY51RUKFTciMrl2GGx8LcZuB/jHUaBIalK5EcOlpzeOuOOIwHQRYmi
         TA2pvQQqqI1hyIRz+FQRgqrmfcxfeFqm3+IgfrWCCnDh0ryOMXaqW3ITaVo11XtjElsW
         P9+H+rk9ljhvC8QIXwfVAVRutt0CKYylIyPN2XwhpW93bTBqQCRshIH65fVMgt7A/dgL
         31iw44mBVBkqh2Ple3fG3SVpn6aKW3teosmH8SJ16XIhNKFX42blaNdaNNgwrmszH2Eq
         uN+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.16 096/196] ext4: move call to ext4_error() into ext4_xattr_check_block()
Date: Sun, 22 Apr 2018 15:51:56 +0200
Message-Id: <20180422135109.234531099@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455038749394333?=
X-GMAIL-MSGID: =?utf-8?q?1598455038749394333?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit de05ca8526796c7e9f7c7282b7f89a818af19818 upstream.

Refactor the call to EXT4_ERROR_INODE() into ext4_xattr_check_block().
This simplifies the code, and fixes a problem where not all callers of
ext4_xattr_check_block() were not resulting in ext4_error() getting
called when the xattr block is corrupted.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/xattr.c |   60 +++++++++++++++++++++++++-------------------------------
 1 file changed, 27 insertions(+), 33 deletions(-)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -225,25 +225,36 @@ ext4_xattr_check_entries(struct ext4_xat
 }
 
 static inline int
-ext4_xattr_check_block(struct inode *inode, struct buffer_head *bh)
+__ext4_xattr_check_block(struct inode *inode, struct buffer_head *bh,
+			 const char *function, unsigned int line)
 {
-	int error;
+	int error = -EFSCORRUPTED;
 
 	if (buffer_verified(bh))
 		return 0;
 
 	if (BHDR(bh)->h_magic != cpu_to_le32(EXT4_XATTR_MAGIC) ||
 	    BHDR(bh)->h_blocks != cpu_to_le32(1))
-		return -EFSCORRUPTED;
+		goto errout;
+	error = -EFSBADCRC;
 	if (!ext4_xattr_block_csum_verify(inode, bh))
-		return -EFSBADCRC;
+		goto errout;
 	error = ext4_xattr_check_entries(BFIRST(bh), bh->b_data + bh->b_size,
 					 bh->b_data);
-	if (!error)
+errout:
+	if (error)
+		__ext4_error_inode(inode, function, line, 0,
+				   "corrupted xattr block %llu",
+				   (unsigned long long) bh->b_blocknr);
+	else
 		set_buffer_verified(bh);
 	return error;
 }
 
+#define ext4_xattr_check_block(inode, bh) \
+	__ext4_xattr_check_block((inode), (bh),  __func__, __LINE__)
+
+
 static int
 __xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
 			 void *end, const char *function, unsigned int line)
@@ -514,12 +525,9 @@ ext4_xattr_block_get(struct inode *inode
 		goto cleanup;
 	ea_bdebug(bh, "b_count=%d, refcount=%d",
 		atomic_read(&(bh->b_count)), le32_to_cpu(BHDR(bh)->h_refcount));
-	if (ext4_xattr_check_block(inode, bh)) {
-		EXT4_ERROR_INODE(inode, "bad block %llu",
-				 EXT4_I(inode)->i_file_acl);
-		error = -EFSCORRUPTED;
+	error = ext4_xattr_check_block(inode, bh);
+	if (error)
 		goto cleanup;
-	}
 	ext4_xattr_block_cache_insert(ea_block_cache, bh);
 	entry = BFIRST(bh);
 	error = ext4_xattr_find_entry(&entry, name_index, name, 1);
@@ -679,12 +687,9 @@ ext4_xattr_block_list(struct dentry *den
 		goto cleanup;
 	ea_bdebug(bh, "b_count=%d, refcount=%d",
 		atomic_read(&(bh->b_count)), le32_to_cpu(BHDR(bh)->h_refcount));
-	if (ext4_xattr_check_block(inode, bh)) {
-		EXT4_ERROR_INODE(inode, "bad block %llu",
-				 EXT4_I(inode)->i_file_acl);
-		error = -EFSCORRUPTED;
+	error = ext4_xattr_check_block(inode, bh);
+	if (error)
 		goto cleanup;
-	}
 	ext4_xattr_block_cache_insert(EA_BLOCK_CACHE(inode), bh);
 	error = ext4_xattr_list_entries(dentry, BFIRST(bh), buffer, buffer_size);
 
@@ -811,10 +816,9 @@ int ext4_get_inode_usage(struct inode *i
 			goto out;
 		}
 
-		if (ext4_xattr_check_block(inode, bh)) {
-			ret = -EFSCORRUPTED;
+		ret = ext4_xattr_check_block(inode, bh);
+		if (ret)
 			goto out;
-		}
 
 		for (entry = BFIRST(bh); !IS_LAST_ENTRY(entry);
 		     entry = EXT4_XATTR_NEXT(entry))
@@ -1796,12 +1800,9 @@ ext4_xattr_block_find(struct inode *inod
 		ea_bdebug(bs->bh, "b_count=%d, refcount=%d",
 			atomic_read(&(bs->bh->b_count)),
 			le32_to_cpu(BHDR(bs->bh)->h_refcount));
-		if (ext4_xattr_check_block(inode, bs->bh)) {
-			EXT4_ERROR_INODE(inode, "bad block %llu",
-					 EXT4_I(inode)->i_file_acl);
-			error = -EFSCORRUPTED;
+		error = ext4_xattr_check_block(inode, bs->bh);
+		if (error)
 			goto cleanup;
-		}
 		/* Find the named attribute. */
 		bs->s.base = BHDR(bs->bh);
 		bs->s.first = BFIRST(bs->bh);
@@ -2724,13 +2725,9 @@ retry:
 		error = -EIO;
 		if (!bh)
 			goto cleanup;
-		if (ext4_xattr_check_block(inode, bh)) {
-			EXT4_ERROR_INODE(inode, "bad block %llu",
-					 EXT4_I(inode)->i_file_acl);
-			error = -EFSCORRUPTED;
-			brelse(bh);
+		error = ext4_xattr_check_block(inode, bh);
+		if (error)
 			goto cleanup;
-		}
 		base = BHDR(bh);
 		end = bh->b_data + bh->b_size;
 		min_offs = end - base;
@@ -2887,11 +2884,8 @@ int ext4_xattr_delete_inode(handle_t *ha
 			goto cleanup;
 		}
 		error = ext4_xattr_check_block(inode, bh);
-		if (error) {
-			EXT4_ERROR_INODE(inode, "bad block %llu (error %d)",
-					 EXT4_I(inode)->i_file_acl, error);
+		if (error)
 			goto cleanup;
-		}
 
 		if (ext4_has_feature_ea_inode(inode->i_sb)) {
 			for (entry = BFIRST(bh); !IS_LAST_ENTRY(entry);
