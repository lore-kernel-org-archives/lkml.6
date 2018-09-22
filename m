Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A94ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5311D2157C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5311D2157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392109AbeIVGKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:10:50 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44302 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392077AbeIVGKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:50 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Ve0-0008BO-AX; Sat, 22 Sep 2018 01:19:32 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdn-0000rc-SR; Sat, 22 Sep 2018 01:19:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Theodore Ts'o" <tytso@mit.edu>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.33944970@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 24/63] ext4: only look at the bg_flags field if it is
 valid
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
[bwh: Backported to 3.16:
 - ext4_read_block_bitmap_nowait() and ext4_read_inode_bitmap() return
   a pointer (NULL on error) instead of an error code
 - Open-code sb_rdonly()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/balloc.c  | 11 ++++++++++-
 fs/ext4/ialloc.c  | 14 ++++++++++++--
 fs/ext4/mballoc.c |  6 ++++--
 fs/ext4/super.c   | 11 ++++++++++-
 4 files changed, 36 insertions(+), 6 deletions(-)

--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -453,9 +453,18 @@ ext4_read_block_bitmap_nowait(struct sup
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
@@ -156,7 +156,16 @@ ext4_read_inode_bitmap(struct super_bloc
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
 		ext4_init_inode_bitmap(sb, bh, block_group, desc);
 		set_bitmap_uptodate(bh);
 		set_buffer_uptodate(bh);
@@ -910,7 +919,8 @@ got:
 
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
@@ -2418,7 +2418,8 @@ int ext4_mb_add_groupinfo(struct super_b
 	 * initialize bb_free to be able to skip
 	 * empty groups without initialization
 	 */
-	if (desc->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)) {
+	if (ext4_has_group_desc_csum(sb) &&
+	    (desc->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
 		meta_group_info[i]->bb_free =
 			ext4_free_clusters_after_init(sb, group, desc);
 	} else {
@@ -2943,7 +2944,8 @@ ext4_mb_mark_diskspace_used(struct ext4_
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
@@ -3080,13 +3080,22 @@ static ext4_group_t ext4_has_uninit_itab
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

