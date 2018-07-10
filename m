Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66918C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317BE2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 317BE2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388744AbeGJSct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:32:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47602 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387825AbeGJScs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:32:48 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 901ECCED;
        Tue, 10 Jul 2018 18:32:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 4.14 25/53] ext4: avoid running out of journal credits when appending to an inline file
Date:   Tue, 10 Jul 2018 20:25:01 +0200
Message-Id: <20180710182500.338070165@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182458.736721865@linuxfoundation.org>
References: <20180710182458.736721865@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 8bc1379b82b8e809eef77a9fedbb75c6c297be19 upstream.

Use a separate journal transaction if it turns out that we need to
convert an inline file to use an data block.  Otherwise we could end
up failing due to not having journal credits.

This addresses CVE-2018-10883.

https://bugzilla.kernel.org/show_bug.cgi?id=200071

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/ext4.h   |    3 ---
 fs/ext4/inline.c |   38 +-------------------------------------
 fs/ext4/xattr.c  |   19 ++-----------------
 3 files changed, 3 insertions(+), 57 deletions(-)

--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3049,9 +3049,6 @@ extern struct buffer_head *ext4_get_firs
 extern int ext4_inline_data_fiemap(struct inode *inode,
 				   struct fiemap_extent_info *fieinfo,
 				   int *has_inline, __u64 start, __u64 len);
-extern int ext4_try_to_evict_inline_data(handle_t *handle,
-					 struct inode *inode,
-					 int needed);
 extern int ext4_inline_data_truncate(struct inode *inode, int *has_inline);
 
 extern int ext4_convert_inline_data(struct inode *inode);
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -893,11 +893,11 @@ retry_journal:
 	flags |= AOP_FLAG_NOFS;
 
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
@@ -1865,42 +1865,6 @@ out:
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
 int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 {
 	handle_t *handle;
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2211,23 +2211,8 @@ int ext4_xattr_ibody_inline_set(handle_t
 	if (EXT4_I(inode)->i_extra_isize == 0)
 		return -ENOSPC;
 	error = ext4_xattr_set_entry(i, s, handle, inode, false /* is_block */);
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
-			error = ext4_xattr_set_entry(i, s, handle, inode,
-						     false /* is_block */);
-		}
-		if (error)
-			return error;
-	}
+	if (error)
+		return error;
 	header = IHDR(inode, ext4_raw_inode(&is->iloc));
 	if (!IS_LAST_ENTRY(s->first)) {
 		header->h_magic = cpu_to_le32(EXT4_XATTR_MAGIC);


