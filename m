Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57176C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F56B21470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iy3tgMhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F56B21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbeJKXI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:08:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729758AbeJKXI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:08:59 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F6682098A;
        Thu, 11 Oct 2018 15:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272474;
        bh=urilsmOdFTOCrcdnFjYy4MkO7KiKyYaGssZrEJ4PLxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iy3tgMhjhy/61jo/xV154+BhsAq59CSfRjh7gMHTe2MQXUu7oqJ5T1snXlkj715K1
         dqJR8Tx3W2fYO/kzfBbrGJ8AcRZNd0VOwOhistMgZXCPYxQIbcyFa//d+sUG+nTGKg
         1iu1hiMLSX+3pp/TYx9RsODWYQReBKs4U2Cd3Szs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Greg Hackmann <ghackmann@google.com>
Subject: [PATCH 3.18 108/120] ext4: only look at the bg_flags field if it is valid
Date:   Thu, 11 Oct 2018 17:34:49 +0200
Message-Id: <20181011152554.262039958@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 8844618d8aa7a9973e7b527d038a2a589665002c upstream.

The bg_flags field in the block group descripts is only valid if the
uninit_bg or metadata_csum feature is enabled.  We were not
consistently looking at this field; fix this.

Also block group #0 must never have uninitialized allocation bitmaps,
or need to be zeroed, since that's where the root inode, and other
special inodes are set up.  Check for these conditions and mark the
file system as corrupted if they are detected.

This addresses CVE-2018-10876.

https://bugzilla.kernel.org/show_bug.cgi?id=199403

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
[bwh: Backported to 3.16:
 - ext4_read_block_bitmap_nowait() and ext4_read_inode_bitmap() return
   a pointer (NULL on error) instead of an error code
 - Open-code sb_rdonly()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
[ghackmann@google.com: forward-port to 3.18: adjust context]
Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/balloc.c  |   11 ++++++++++-
 fs/ext4/ialloc.c  |   14 ++++++++++++--
 fs/ext4/mballoc.c |    6 ++++--
 fs/ext4/super.c   |   11 ++++++++++-
 4 files changed, 36 insertions(+), 6 deletions(-)

--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -451,9 +451,18 @@ ext4_read_block_bitmap_nowait(struct sup
 		goto verify;
 	}
 	ext4_lock_group(sb, block_group);
-	if (desc->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)) {
+	if (ext4_has_group_desc_csum(sb) &&
+	    (desc->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
 		int err;
 
+		if (block_group == 0) {
+			ext4_unlock_group(sb, block_group);
+			unlock_buffer(bh);
+			ext4_error(sb, "Block bitmap for bg 0 marked "
+				   "uninitialized");
+			put_bh(bh);
+			return NULL;
+		}
 		err = ext4_init_block_bitmap(sb, bh, block_group, desc);
 		set_bitmap_uptodate(bh);
 		set_buffer_uptodate(bh);
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -117,7 +117,16 @@ ext4_read_inode_bitmap(struct super_bloc
 	}
 
 	ext4_lock_group(sb, block_group);
-	if (desc->bg_flags & cpu_to_le16(EXT4_BG_INODE_UNINIT)) {
+	if (ext4_has_group_desc_csum(sb) &&
+	    (desc->bg_flags & cpu_to_le16(EXT4_BG_INODE_UNINIT))) {
+		if (block_group == 0) {
+			ext4_unlock_group(sb, block_group);
+			unlock_buffer(bh);
+			ext4_error(sb, "Inode bitmap for bg 0 marked "
+				   "uninitialized");
+			put_bh(bh);
+			return NULL;
+		}
 		memset(bh->b_data, 0, (EXT4_INODES_PER_GROUP(sb) + 7) / 8);
 		ext4_mark_bitmap_end(EXT4_INODES_PER_GROUP(sb),
 				     sb->s_blocksize * 8, bh->b_data);
@@ -873,7 +882,8 @@ got:
 
 		/* recheck and clear flag under lock if we still need to */
 		ext4_lock_group(sb, group);
-		if (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)) {
+		if (ext4_has_group_desc_csum(sb) &&
+		    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
 			gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
 			ext4_free_group_clusters_set(sb, gdp,
 				ext4_free_clusters_after_init(sb, group, gdp));
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2415,7 +2415,8 @@ int ext4_mb_add_groupinfo(struct super_b
 	 * initialize bb_free to be able to skip
 	 * empty groups without initialization
 	 */
-	if (desc->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)) {
+	if (ext4_has_group_desc_csum(sb) &&
+	    (desc->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
 		meta_group_info[i]->bb_free =
 			ext4_free_clusters_after_init(sb, group, desc);
 	} else {
@@ -2942,7 +2943,8 @@ ext4_mb_mark_diskspace_used(struct ext4_
 #endif
 	ext4_set_bits(bitmap_bh->b_data, ac->ac_b_ex.fe_start,
 		      ac->ac_b_ex.fe_len);
-	if (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)) {
+	if (ext4_has_group_desc_csum(sb) &&
+	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
 		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
 		ext4_free_group_clusters_set(sb, gdp,
 					     ext4_free_clusters_after_init(sb,
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3132,13 +3132,22 @@ static ext4_group_t ext4_has_uninit_itab
 	ext4_group_t group, ngroups = EXT4_SB(sb)->s_groups_count;
 	struct ext4_group_desc *gdp = NULL;
 
+	if (!ext4_has_group_desc_csum(sb))
+		return ngroups;
+
 	for (group = 0; group < ngroups; group++) {
 		gdp = ext4_get_group_desc(sb, group, NULL);
 		if (!gdp)
 			continue;
 
-		if (!(gdp->bg_flags & cpu_to_le16(EXT4_BG_INODE_ZEROED)))
+		if (gdp->bg_flags & cpu_to_le16(EXT4_BG_INODE_ZEROED))
+			continue;
+		if (group != 0)
 			break;
+		ext4_error(sb, "Inode table for bg 0 marked as "
+			   "needing zeroing");
+		if (sb->s_flags & MS_RDONLY)
+			return ngroups;
 	}
 
 	return group;


