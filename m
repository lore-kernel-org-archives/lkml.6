Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725B2C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431F920645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431F920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbeJNX2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:28:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37251 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728125AbeJNX2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:28:24 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMC-0004cp-0H; Sun, 14 Oct 2018 16:31:04 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLQ-0000FK-15; Sun, 14 Oct 2018 16:30:16 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Theodore Ts'o" <tytso@mit.edu>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.780711559@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 082/366] ext4: add bounds checking to ext4_xattr_find_entry()
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 9496005d6ca4cf8f5ee8f828165a8956872dc59d upstream.

Add some paranoia checks to make sure we don't stray beyond the end of
the valid memory region containing ext4 xattr entries while we are
scanning for a match.

Also rename the function to xattr_find_entry() since it is static and
thus only used in fs/ext4/xattr.c

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[bwh: Backported to 3.16:
 - Keep passing an explicit size to xattr_find_entry()
 - s/EFSCORRUPTED/EIO/]]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/xattr.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -240,18 +240,23 @@ ext4_xattr_check_entry(struct ext4_xattr
 }
 
 static int
-ext4_xattr_find_entry(struct ext4_xattr_entry **pentry, int name_index,
-		      const char *name, size_t size, int sorted)
+xattr_find_entry(struct inode *inode, struct ext4_xattr_entry **pentry,
+		 void *end, int name_index, const char *name, size_t size,
+		 int sorted)
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
+			return -EIO;
+		}
 		cmp = name_index - entry->e_name_index;
 		if (!cmp)
 			cmp = name_len - entry->e_name_len;
@@ -273,6 +278,7 @@ ext4_xattr_block_get(struct inode *inode
 	struct buffer_head *bh = NULL;
 	struct ext4_xattr_entry *entry;
 	size_t size;
+	void *end;
 	int error;
 	struct mb_cache *ext4_mb_cache = EXT4_GET_MB_CACHE(inode);
 
@@ -298,7 +304,9 @@ bad_block:
 	}
 	ext4_xattr_cache_insert(ext4_mb_cache, bh);
 	entry = BFIRST(bh);
-	error = ext4_xattr_find_entry(&entry, name_index, name, bh->b_size, 1);
+	end = bh->b_data + bh->b_size;
+	error = xattr_find_entry(inode, &entry, end, name_index, name,
+				 bh->b_size, 1);
 	if (error == -EIO)
 		goto bad_block;
 	if (error)
@@ -342,8 +350,8 @@ ext4_xattr_ibody_get(struct inode *inode
 	error = ext4_xattr_check_names(entry, end, entry);
 	if (error)
 		goto cleanup;
-	error = ext4_xattr_find_entry(&entry, name_index, name,
-				      end - (void *)entry, 0);
+	error = xattr_find_entry(inode, &entry, end, name_index, name,
+				 end - (void *)entry, 0);
 	if (error)
 		goto cleanup;
 	size = le32_to_cpu(entry->e_value_size);
@@ -761,8 +769,9 @@ ext4_xattr_block_find(struct inode *inod
 		bs->s.first = BFIRST(bs->bh);
 		bs->s.end = bs->bh->b_data + bs->bh->b_size;
 		bs->s.here = bs->s.first;
-		error = ext4_xattr_find_entry(&bs->s.here, i->name_index,
-					      i->name, bs->bh->b_size, 1);
+		error = xattr_find_entry(inode, &bs->s.here, bs->s.end,
+					 i->name_index, i->name,
+					 bs->bh->b_size, 1);
 		if (error && error != -ENODATA)
 			goto cleanup;
 		bs->s.not_found = error;
@@ -1007,9 +1016,9 @@ int ext4_xattr_ibody_find(struct inode *
 		if (error)
 			return error;
 		/* Find the named attribute. */
-		error = ext4_xattr_find_entry(&is->s.here, i->name_index,
-					      i->name, is->s.end -
-					      (void *)is->s.base, 0);
+		error = xattr_find_entry(inode, &is->s.here, is->s.end,
+					 i->name_index, i->name,
+					 is->s.end - (void *)is->s.base, 0);
 		if (error && error != -ENODATA)
 			return error;
 		is->s.not_found = error;

