Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80814C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4ED2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4ED2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbeKLFxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:53:52 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51662 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbeKLFxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:53:51 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt0-0000l7-Lz; Sun, 11 Nov 2018 19:59:10 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsS-0001Ye-HQ; Sun, 11 Nov 2018 19:58:36 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Theodore Ts'o" <tytso@mit.edu>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.860383263@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 146/366] ext4: add more mount time checks of the
 superblock
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

commit bfe0a5f47ada40d7984de67e59a7d3390b9b9ecc upstream.

The kernel's ext4 mount-time checks were more permissive than
e2fsprogs's libext2fs checks when opening a file system.  The
superblock is considered too insane for debugfs or e2fsck to operate
on it, the kernel has no business trying to mount it.

This will make file system fuzzing tools work harder, but the failure
cases that they find will be more useful and be easier to evaluate.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/super.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3725,6 +3725,13 @@ static int ext4_fill_super(struct super_
 			 le32_to_cpu(es->s_log_block_size));
 		goto failed_mount;
 	}
+	if (le32_to_cpu(es->s_log_cluster_size) >
+	    (EXT4_MAX_CLUSTER_LOG_SIZE - EXT4_MIN_BLOCK_LOG_SIZE)) {
+		ext4_msg(sb, KERN_ERR,
+			 "Invalid log cluster size: %u",
+			 le32_to_cpu(es->s_log_cluster_size));
+		goto failed_mount;
+	}
 
 	if (le16_to_cpu(sbi->s_es->s_reserved_gdt_blocks) > (blocksize / 4)) {
 		ext4_msg(sb, KERN_ERR,
@@ -3853,13 +3860,6 @@ static int ext4_fill_super(struct super_
 				 "block size (%d)", clustersize, blocksize);
 			goto failed_mount;
 		}
-		if (le32_to_cpu(es->s_log_cluster_size) >
-		    (EXT4_MAX_CLUSTER_LOG_SIZE - EXT4_MIN_BLOCK_LOG_SIZE)) {
-			ext4_msg(sb, KERN_ERR,
-				 "Invalid log cluster size: %u",
-				 le32_to_cpu(es->s_log_cluster_size));
-			goto failed_mount;
-		}
 		sbi->s_cluster_bits = le32_to_cpu(es->s_log_cluster_size) -
 			le32_to_cpu(es->s_log_block_size);
 		sbi->s_clusters_per_group =
@@ -3880,10 +3880,10 @@ static int ext4_fill_super(struct super_
 		}
 	} else {
 		if (clustersize != blocksize) {
-			ext4_warning(sb, "fragment/cluster size (%d) != "
-				     "block size (%d)", clustersize,
-				     blocksize);
-			clustersize = blocksize;
+			ext4_msg(sb, KERN_ERR,
+				 "fragment/cluster size (%d) != "
+				 "block size (%d)", clustersize, blocksize);
+			goto failed_mount;
 		}
 		if (sbi->s_blocks_per_group > blocksize * 8) {
 			ext4_msg(sb, KERN_ERR,
@@ -3937,6 +3937,13 @@ static int ext4_fill_super(struct super_
 			 ext4_blocks_count(es));
 		goto failed_mount;
 	}
+	if ((es->s_first_data_block == 0) && (es->s_log_block_size == 0) &&
+	    (sbi->s_cluster_ratio == 1)) {
+		ext4_msg(sb, KERN_WARNING, "bad geometry: first data "
+			 "block is 0 with a 1k block and cluster size");
+		goto failed_mount;
+	}
+
 	blocks_count = (ext4_blocks_count(es) -
 			le32_to_cpu(es->s_first_data_block) +
 			EXT4_BLOCKS_PER_GROUP(sb) - 1);
@@ -3972,6 +3979,14 @@ static int ext4_fill_super(struct super_
 		ret = -ENOMEM;
 		goto failed_mount;
 	}
+	if (((u64)sbi->s_groups_count * sbi->s_inodes_per_group) !=
+	    le32_to_cpu(es->s_inodes_count)) {
+		ext4_msg(sb, KERN_ERR, "inodes count not valid: %u vs %llu",
+			 le32_to_cpu(es->s_inodes_count),
+			 ((u64)sbi->s_groups_count * sbi->s_inodes_per_group));
+		ret = -EINVAL;
+		goto failed_mount;
+	}
 
 	if (ext4_proc_root)
 		sbi->s_proc = proc_mkdir(sb->s_id, ext4_proc_root);

