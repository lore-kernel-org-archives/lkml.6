Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C48ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD002157C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD002157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392183AbeIVGNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:13:04 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44257 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392015AbeIVGKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:48 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdy-0008Bc-65; Sat, 22 Sep 2018 01:19:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdo-0000sB-57; Sat, 22 Sep 2018 01:19:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Andreas Dilger" <adilger@dilger.ca>,
        "Theodore Ts'o" <tytso@mit.edu>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.457041470@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 31/63] ext4: add corruption check in ext4_xattr_set_entry()
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

commit 5369a762c882c0b6e9599e4ebbb3a9ba9eee7e2d upstream.

In theory this should have been caught earlier when the xattr list was
verified, but in case it got missed, it's simple enough to add check
to make sure we don't overrun the xattr buffer.

This addresses CVE-2018-10879.

https://bugzilla.kernel.org/show_bug.cgi?id=200001

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
[bwh: Backported to 3.16:
 - Add inode parameter to ext4_xattr_set_entry() and update callers
 - Return -EIO instead of -EFSCORRUPTED on error
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -610,14 +610,20 @@ static size_t ext4_xattr_free_space(stru
 }
 
 static int
-ext4_xattr_set_entry(struct ext4_xattr_info *i, struct ext4_xattr_search *s)
+ext4_xattr_set_entry(struct ext4_xattr_info *i, struct ext4_xattr_search *s,
+		     struct inode *inode)
 {
-	struct ext4_xattr_entry *last;
+	struct ext4_xattr_entry *last, *next;
 	size_t free, min_offs = s->end - s->base, name_len = strlen(i->name);
 
 	/* Compute min_offs and last. */
 	last = s->first;
-	for (; !IS_LAST_ENTRY(last); last = EXT4_XATTR_NEXT(last)) {
+	for (; !IS_LAST_ENTRY(last); last = next) {
+		next = EXT4_XATTR_NEXT(last);
+		if ((void *)next >= s->end) {
+			EXT4_ERROR_INODE(inode, "corrupted xattr entries");
+			return -EIO;
+		}
 		if (!last->e_value_block && last->e_value_size) {
 			size_t offs = le16_to_cpu(last->e_value_offs);
 			if (offs < min_offs)
@@ -798,7 +804,7 @@ ext4_xattr_block_set(handle_t *handle, s
 				ce = NULL;
 			}
 			ea_bdebug(bs->bh, "modifying in-place");
-			error = ext4_xattr_set_entry(i, s);
+			error = ext4_xattr_set_entry(i, s, inode);
 			if (!error) {
 				if (!IS_LAST_ENTRY(s->first))
 					ext4_xattr_rehash(header(s->base),
@@ -851,7 +857,7 @@ ext4_xattr_block_set(handle_t *handle, s
 		s->end = s->base + sb->s_blocksize;
 	}
 
-	error = ext4_xattr_set_entry(i, s);
+	error = ext4_xattr_set_entry(i, s, inode);
 	if (error == -EIO)
 		goto bad_block;
 	if (error)
@@ -1021,7 +1027,7 @@ int ext4_xattr_ibody_inline_set(handle_t
 
 	if (EXT4_I(inode)->i_extra_isize == 0)
 		return -ENOSPC;
-	error = ext4_xattr_set_entry(i, s);
+	error = ext4_xattr_set_entry(i, s, inode);
 	if (error) {
 		if (error == -ENOSPC &&
 		    ext4_has_inline_data(inode)) {
@@ -1033,7 +1039,7 @@ int ext4_xattr_ibody_inline_set(handle_t
 			error = ext4_xattr_ibody_find(inode, i, is);
 			if (error)
 				return error;
-			error = ext4_xattr_set_entry(i, s);
+			error = ext4_xattr_set_entry(i, s, inode);
 		}
 		if (error)
 			return error;
@@ -1059,7 +1065,7 @@ static int ext4_xattr_ibody_set(handle_t
 
 	if (EXT4_I(inode)->i_extra_isize == 0)
 		return -ENOSPC;
-	error = ext4_xattr_set_entry(i, s);
+	error = ext4_xattr_set_entry(i, s, inode);
 	if (error)
 		return error;
 	header = IHDR(inode, ext4_raw_inode(&is->iloc));

