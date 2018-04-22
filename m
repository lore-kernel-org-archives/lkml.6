Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49X2Dua6FC/0sinEmlGaF4CzdHx8oLTBnvBCKQEr3tR0IitzBaGLdKgdw3VD5WQL0ELlGyo
ARC-Seal: i=1; a=rsa-sha256; t=1524406017; cv=none;
        d=google.com; s=arc-20160816;
        b=koiHclUb2tU+VbfUXKEZPXj+L31Z/wTE2l3pXsFySseMLro+Raa3zyKUMTAuVVUAix
         ZOe2y+FtXjxZ4suGkPYT/rU5K2RUcvyf1xOhmU9VOK4Np76qAJ+kW1SCYiKixVcPQevD
         f2CigYK4+2tbKBLxCGlJCQfETeATogGuQj+9yw4Toj2WOrZy+AwYp47qXlqh5XLz90in
         rkkPdjSU1EfLme/Z1sLVVfi5nLaEEW8pFDfgvmdUJ7TcIudbnje1goV88XQkM8rtHJFb
         vGVzv7eAd1LxJhvDGJXp2BgOgVxDvuVrxyL/wmzDsgd3JwzkMv0mmV0SUObDe6hjzKu+
         RpEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EOcRWcuzTJyK5dRgAgFpbzeRdlE51kpldy0HdMnaNPs=;
        b=GfUzuoemJDtEbqwwy+9fGY9HrCdhFLukkL9dol6b314GSfWnw4jNutt25EQCbk2WjH
         e0SckLSsJh4ucz9QLbEP05pQnn++JNNmB5iEm1/Ry4norAv4cwfKc2gKRxooH/XU1iu6
         Vltn1DC7CorC/BwWmwcJFbR1kD/+c/C1QQSx7GCCtQwu608l+Obox66sgKLULpUBZtDs
         ceS8NBSgQ1lT/a+2M05ARwe7GWrVp1zjCOvlkUvAmGuQHs7d+eu0nmaRY5GT5a3TT8f3
         H3NQbvzyfaCauyef+zVUNHvO4co9e6Nt50cQh8W5TM6HLuF9Vi99t+41zNy9NzueIUeP
         To0w==
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
Subject: [PATCH 4.14 083/164] ext4: add bounds checking to ext4_xattr_find_entry()
Date: Sun, 22 Apr 2018 15:52:30 +0200
Message-Id: <20180422135138.833728709@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455041649596421?=
X-GMAIL-MSGID: =?utf-8?q?1598455564660132130?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -275,18 +275,22 @@ errout:
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
@@ -508,6 +512,7 @@ ext4_xattr_block_get(struct inode *inode
 	struct buffer_head *bh = NULL;
 	struct ext4_xattr_entry *entry;
 	size_t size;
+	void *end;
 	int error;
 	struct mb_cache *ea_block_cache = EA_BLOCK_CACHE(inode);
 
@@ -529,7 +534,8 @@ ext4_xattr_block_get(struct inode *inode
 		goto cleanup;
 	ext4_xattr_block_cache_insert(ea_block_cache, bh);
 	entry = BFIRST(bh);
-	error = ext4_xattr_find_entry(&entry, name_index, name, 1);
+	end = bh->b_data + bh->b_size;
+	error = xattr_find_entry(inode, &entry, end, name_index, name, 1);
 	if (error)
 		goto cleanup;
 	size = le32_to_cpu(entry->e_value_size);
@@ -578,7 +584,7 @@ ext4_xattr_ibody_get(struct inode *inode
 	if (error)
 		goto cleanup;
 	entry = IFIRST(header);
-	error = ext4_xattr_find_entry(&entry, name_index, name, 0);
+	error = xattr_find_entry(inode, &entry, end, name_index, name, 0);
 	if (error)
 		goto cleanup;
 	size = le32_to_cpu(entry->e_value_size);
@@ -1807,8 +1813,8 @@ ext4_xattr_block_find(struct inode *inod
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
@@ -2167,8 +2173,8 @@ int ext4_xattr_ibody_find(struct inode *
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
