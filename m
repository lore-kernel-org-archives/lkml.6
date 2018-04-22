Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Sc9EAD+UPPyMuAqU3FMntoqdJWt05YEDAMCRLVX2qf4i/e+DL2s7zOdLDg8Wzm+2IKCBb
ARC-Seal: i=1; a=rsa-sha256; t=1524405519; cv=none;
        d=google.com; s=arc-20160816;
        b=f1z/cwZSKVtY0lPRHuskzYHhxz3G68ufOzBaufNecTSda3ljlWBkJcB1nFMy+O3vTt
         RsLff5MaUrPdmx6uZpyX/JaVr6mCAqx/3EMVPoepdfQywuAR3HJY8/Vox/8yoKYcR1wG
         eyPn0Lt9KcRxRIz8fIAP1wfPlKB/nK3qeCaA8baKBpAd87JNYyD7O+LhR7G0hHpJYtm0
         Il4iDW5P617DpoNuodcS06hPXVCF6TIAGWQPod8rXjRhR8esdz5tfcL4D6acPxrOEMeO
         YrPz9EvIPTdWF5zmDhdmQ6Aq7YQ+6rUUYx6qd+TDh+/bdLPBs8o/CLgQDz2uSUftCS3E
         2gYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=K/zpIM4kdOUxle7VbggpwOubYavHHeZJLIqwA6EZi70=;
        b=AjDByWMxEQ4jkGP+EH8svd4kvN0miWf3CJy4uet8g8oPooEp7pRGF8V0JMH6Gw97o8
         tNI3rrsWL1BWcftJ1EId0RlIT6xkxJ/tVazzzAslmx3mmhDRkq1TTzNgYcwiSyMyLRNe
         bqzeKnsuVBd7TM0jfcn9AJEggdkRdOeQhewCLMJ2H+VmO1Jak3AZTbEpGpCMkGvjXWy4
         0yW8yka8eO66tDsnwcKaj1zkEeYzryEfMm2faME6kEcv5J1OJMUw6drHL2DPiwiDswM+
         XW2rNYM4xDnRuF9vPo0N+hCd+HgN4RDOj9EFbyhmEYwHxw7I1BhSdNVOvSupya/Rqc52
         APtw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>,
	stable@kernel.org
Subject: [PATCH 4.16 097/196] ext4: add bounds checking to ext4_xattr_find_entry()
Date: Sun, 22 Apr 2018 15:51:57 +0200
Message-Id: <20180422135109.289326160@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455041649596421?=
X-GMAIL-MSGID: =?utf-8?q?1598455041649596421?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 9496005d6ca4cf8f5ee8f828165a8956872dc59d upstream.

Add some paranoia checks to make sure we don't stray beyond the end of
the valid memory region containing ext4 xattr entries while we are
scanning for a match.

Also rename the function to xattr_find_entry() since it is static and
thus only used in fs/ext4/xattr.c

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/xattr.c |   28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -276,18 +276,22 @@ errout:
 	__xattr_check_inode((inode), (header), (end), __func__, __LINE__)
 
 static int
-ext4_xattr_find_entry(struct ext4_xattr_entry **pentry, int name_index,
-		      const char *name, int sorted)
+xattr_find_entry(struct inode *inode, struct ext4_xattr_entry **pentry,
+		 void *end, int name_index, const char *name, int sorted)
 {
-	struct ext4_xattr_entry *entry;
+	struct ext4_xattr_entry *entry, *next;
 	size_t name_len;
 	int cmp = 1;
 
 	if (name == NULL)
 		return -EINVAL;
 	name_len = strlen(name);
-	entry = *pentry;
-	for (; !IS_LAST_ENTRY(entry); entry = EXT4_XATTR_NEXT(entry)) {
+	for (entry = *pentry; !IS_LAST_ENTRY(entry); entry = next) {
+		next = EXT4_XATTR_NEXT(entry);
+		if ((void *) next >= end) {
+			EXT4_ERROR_INODE(inode, "corrupted xattr entries");
+			return -EFSCORRUPTED;
+		}
 		cmp = name_index - entry->e_name_index;
 		if (!cmp)
 			cmp = name_len - entry->e_name_len;
@@ -509,6 +513,7 @@ ext4_xattr_block_get(struct inode *inode
 	struct buffer_head *bh = NULL;
 	struct ext4_xattr_entry *entry;
 	size_t size;
+	void *end;
 	int error;
 	struct mb_cache *ea_block_cache = EA_BLOCK_CACHE(inode);
 
@@ -530,7 +535,8 @@ ext4_xattr_block_get(struct inode *inode
 		goto cleanup;
 	ext4_xattr_block_cache_insert(ea_block_cache, bh);
 	entry = BFIRST(bh);
-	error = ext4_xattr_find_entry(&entry, name_index, name, 1);
+	end = bh->b_data + bh->b_size;
+	error = xattr_find_entry(inode, &entry, end, name_index, name, 1);
 	if (error)
 		goto cleanup;
 	size = le32_to_cpu(entry->e_value_size);
@@ -579,7 +585,7 @@ ext4_xattr_ibody_get(struct inode *inode
 	if (error)
 		goto cleanup;
 	entry = IFIRST(header);
-	error = ext4_xattr_find_entry(&entry, name_index, name, 0);
+	error = xattr_find_entry(inode, &entry, end, name_index, name, 0);
 	if (error)
 		goto cleanup;
 	size = le32_to_cpu(entry->e_value_size);
@@ -1808,8 +1814,8 @@ ext4_xattr_block_find(struct inode *inod
 		bs->s.first = BFIRST(bs->bh);
 		bs->s.end = bs->bh->b_data + bs->bh->b_size;
 		bs->s.here = bs->s.first;
-		error = ext4_xattr_find_entry(&bs->s.here, i->name_index,
-					      i->name, 1);
+		error = xattr_find_entry(inode, &bs->s.here, bs->s.end,
+					 i->name_index, i->name, 1);
 		if (error && error != -ENODATA)
 			goto cleanup;
 		bs->s.not_found = error;
@@ -2168,8 +2174,8 @@ int ext4_xattr_ibody_find(struct inode *
 		if (error)
 			return error;
 		/* Find the named attribute. */
-		error = ext4_xattr_find_entry(&is->s.here, i->name_index,
-					      i->name, 0);
+		error = xattr_find_entry(inode, &is->s.here, is->s.end,
+					 i->name_index, i->name, 0);
 		if (error && error != -ENODATA)
 			return error;
 		is->s.not_found = error;
