Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1FFECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29292157C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29292157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392316AbeIVGNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:13:30 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44244 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392008AbeIVGKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:48 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdy-0008BT-7A; Sat, 22 Sep 2018 01:19:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdo-0000sf-CP; Sat, 22 Sep 2018 01:19:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Theodore Ts'o" <tytso@mit.edu>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.731452437@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 37/63] ext4: avoid running out of journal credits
 when appending to an inline file
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 8bc1379b82b8e809eef77a9fedbb75c6c297be19 upstream.

Use a separate journal transaction if it turns out that we need to
convert an inline file to use an data block.  Otherwise we could end
up failing due to not having journal credits.

This addresses CVE-2018-10883.

https://bugzilla.kernel.org/show_bug.cgi?id=200071

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2701,9 +2701,6 @@ extern struct buffer_head *ext4_get_firs
 extern int ext4_inline_data_fiemap(struct inode *inode,
 				   struct fiemap_extent_info *fieinfo,
 				   int *has_inline);
-extern int ext4_try_to_evict_inline_data(handle_t *handle,
-					 struct inode *inode,
-					 int needed);
 extern void ext4_inline_data_truncate(struct inode *inode, int *has_inline);
 
 extern int ext4_convert_inline_data(struct inode *inode);
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -877,11 +877,11 @@ retry_journal:
 	}
 
 	if (ret == -ENOSPC) {
+		ext4_journal_stop(handle);
 		ret = ext4_da_convert_inline_data_to_extent(mapping,
 							    inode,
 							    flags,
 							    fsdata);
-		ext4_journal_stop(handle);
 		if (ret == -ENOSPC &&
 		    ext4_should_retry_alloc(inode->i_sb, &retries))
 			goto retry_journal;
@@ -1839,42 +1839,6 @@ out:
 	return (error < 0 ? error : 0);
 }
 
-/*
- * Called during xattr set, and if we can sparse space 'needed',
- * just create the extent tree evict the data to the outer block.
- *
- * We use jbd2 instead of page cache to move data to the 1st block
- * so that the whole transaction can be committed as a whole and
- * the data isn't lost because of the delayed page cache write.
- */
-int ext4_try_to_evict_inline_data(handle_t *handle,
-				  struct inode *inode,
-				  int needed)
-{
-	int error;
-	struct ext4_xattr_entry *entry;
-	struct ext4_inode *raw_inode;
-	struct ext4_iloc iloc;
-
-	error = ext4_get_inode_loc(inode, &iloc);
-	if (error)
-		return error;
-
-	raw_inode = ext4_raw_inode(&iloc);
-	entry = (struct ext4_xattr_entry *)((void *)raw_inode +
-					    EXT4_I(inode)->i_inline_off);
-	if (EXT4_XATTR_LEN(entry->e_name_len) +
-	    EXT4_XATTR_SIZE(le32_to_cpu(entry->e_value_size)) < needed) {
-		error = -ENOSPC;
-		goto out;
-	}
-
-	error = ext4_convert_inline_data_nolock(handle, inode, &iloc);
-out:
-	brelse(iloc.bh);
-	return error;
-}
-
 void ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 {
 	handle_t *handle;
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1028,22 +1028,8 @@ int ext4_xattr_ibody_inline_set(handle_t
 	if (EXT4_I(inode)->i_extra_isize == 0)
 		return -ENOSPC;
 	error = ext4_xattr_set_entry(i, s, inode);
-	if (error) {
-		if (error == -ENOSPC &&
-		    ext4_has_inline_data(inode)) {
-			error = ext4_try_to_evict_inline_data(handle, inode,
-					EXT4_XATTR_LEN(strlen(i->name) +
-					EXT4_XATTR_SIZE(i->value_len)));
-			if (error)
-				return error;
-			error = ext4_xattr_ibody_find(inode, i, is);
-			if (error)
-				return error;
-			error = ext4_xattr_set_entry(i, s, inode);
-		}
-		if (error)
-			return error;
-	}
+	if (error)
+		return error;
 	header = IHDR(inode, ext4_raw_inode(&is->iloc));
 	if (!IS_LAST_ENTRY(s->first)) {
 		header->h_magic = cpu_to_le32(EXT4_XATTR_MAGIC);

