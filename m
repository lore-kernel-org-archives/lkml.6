Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D24BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2341820818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2341820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbeKLGYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:24:22 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49922 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730200AbeKLFsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:13 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0000lK-7w; Sun, 11 Nov 2018 19:58:43 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsW-0001iU-5J; Sun, 11 Nov 2018 19:58:40 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Theodore Ts'o" <tytso@mit.edu>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.879341571@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 244/366] ext4: fix inline data updates with checksums
 enabled
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 362eca70b53389bddf3143fe20f53dcce2cfdf61 upstream.

The inline data code was updating the raw inode directly; this is
problematic since if metadata checksums are enabled,
ext4_mark_inode_dirty() must be called to update the inode's checksum.
In addition, the jbd2 layer requires that get_write_access() be called
before the metadata buffer is modified.  Fix both of these problems.

https://bugzilla.kernel.org/show_bug.cgi?id=200443

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/inline.c | 19 +++++++++++--------
 fs/ext4/inode.c  | 16 +++++++---------
 2 files changed, 18 insertions(+), 17 deletions(-)

--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -681,6 +681,10 @@ int ext4_try_to_write_inline_data(struct
 		goto convert;
 	}
 
+	ret = ext4_journal_get_write_access(handle, iloc.bh);
+	if (ret)
+		goto out;
+
 	flags |= AOP_FLAG_NOFS;
 
 	page = grab_cache_page_write_begin(mapping, 0, flags);
@@ -709,7 +713,7 @@ int ext4_try_to_write_inline_data(struct
 out_up_read:
 	up_read(&EXT4_I(inode)->xattr_sem);
 out:
-	if (handle)
+	if (handle && (ret != 1))
 		ext4_journal_stop(handle);
 	brelse(iloc.bh);
 	return ret;
@@ -751,6 +755,7 @@ int ext4_write_inline_data_end(struct in
 
 	ext4_write_unlock_xattr(inode, &no_expand);
 	brelse(iloc.bh);
+	mark_inode_dirty(inode);
 out:
 	return copied;
 }
@@ -911,6 +916,9 @@ retry_journal:
 		if (ret < 0)
 			goto out_release_page;
 	}
+	ret = ext4_journal_get_write_access(handle, iloc.bh);
+	if (ret)
+		goto out_release_page;
 
 	up_read(&EXT4_I(inode)->xattr_sem);
 	*pagep = page;
@@ -931,7 +939,6 @@ int ext4_da_write_inline_data_end(struct
 				  unsigned len, unsigned copied,
 				  struct page *page)
 {
-	int i_size_changed = 0;
 	int ret;
 
 	ret = ext4_write_inline_data_end(inode, pos, len, copied, page);
@@ -949,10 +956,8 @@ int ext4_da_write_inline_data_end(struct
 	 * But it's important to update i_size while still holding page lock:
 	 * page writeout could otherwise come in and zero beyond i_size.
 	 */
-	if (pos+copied > inode->i_size) {
+	if (pos+copied > inode->i_size)
 		i_size_write(inode, pos+copied);
-		i_size_changed = 1;
-	}
 	unlock_page(page);
 	page_cache_release(page);
 
@@ -962,8 +967,7 @@ int ext4_da_write_inline_data_end(struct
 	 * ordering of page lock and transaction start for journaling
 	 * filesystems.
 	 */
-	if (i_size_changed)
-		mark_inode_dirty(inode);
+	mark_inode_dirty(inode);
 
 	return copied;
 }
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1113,9 +1113,10 @@ static int ext4_write_end(struct file *f
 	struct inode *inode = mapping->host;
 	int ret = 0, ret2;
 	int i_size_changed = 0;
+	int inline_data = ext4_has_inline_data(inode);
 
 	trace_ext4_write_end(inode, pos, len, copied);
-	if (ext4_has_inline_data(inode)) {
+	if (inline_data) {
 		ret = ext4_write_inline_data_end(inode, pos, len,
 						 copied, page);
 		if (ret < 0) {
@@ -1141,7 +1142,7 @@ static int ext4_write_end(struct file *f
 	 * ordering of page lock and transaction start for journaling
 	 * filesystems.
 	 */
-	if (i_size_changed)
+	if (i_size_changed || inline_data)
 		ext4_mark_inode_dirty(handle, inode);
 
 	if (pos + len > inode->i_size && ext4_can_truncate(inode))
@@ -1214,6 +1215,7 @@ static int ext4_journalled_write_end(str
 	int partial = 0;
 	unsigned from, to;
 	int size_changed = 0;
+	int inline_data = ext4_has_inline_data(inode);
 
 	trace_ext4_journalled_write_end(inode, pos, len, copied);
 	from = pos & (PAGE_CACHE_SIZE - 1);
@@ -1221,7 +1223,7 @@ static int ext4_journalled_write_end(str
 
 	BUG_ON(!ext4_handle_valid(handle));
 
-	if (ext4_has_inline_data(inode)) {
+	if (inline_data) {
 		ret = ext4_write_inline_data_end(inode, pos, len,
 						 copied, page);
 		if (ret < 0) {
@@ -1249,7 +1251,7 @@ static int ext4_journalled_write_end(str
 	unlock_page(page);
 	page_cache_release(page);
 
-	if (size_changed) {
+	if (size_changed || inline_data) {
 		ret2 = ext4_mark_inode_dirty(handle, inode);
 		if (!ret)
 			ret = ret2;
@@ -1856,11 +1858,7 @@ static int __ext4_journalled_writepage(s
 	}
 
 	if (inline_data) {
-		BUFFER_TRACE(inode_bh, "get write access");
-		ret = ext4_journal_get_write_access(handle, inode_bh);
-
-		err = ext4_handle_dirty_metadata(handle, inode, inode_bh);
-
+		ret = ext4_mark_inode_dirty(handle, inode);
 	} else {
 		ret = ext4_walk_page_buffers(handle, page_bufs, 0, len, NULL,
 					     do_journal_get_write_access);

