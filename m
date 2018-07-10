Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9A8C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682CC2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682CC2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388772AbeGJScz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:32:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47622 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388759AbeGJScy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:32:54 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B825ACED;
        Tue, 10 Jul 2018 18:32:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 4.14 27/53] ext4: add more mount time checks of the superblock
Date:   Tue, 10 Jul 2018 20:25:03 +0200
Message-Id: <20180710182500.433866427@linuxfoundation.org>
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

commit bfe0a5f47ada40d7984de67e59a7d3390b9b9ecc upstream.

The kernel's ext4 mount-time checks were more permissive than
e2fsprogs's libext2fs checks when opening a file system.  The
superblock is considered too insane for debugfs or e2fsck to operate
on it, the kernel has no business trying to mount it.

This will make file system fuzzing tools work harder, but the failure
cases that they find will be more useful and be easier to evaluate.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/super.c |   37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3749,6 +3749,13 @@ static int ext4_fill_super(struct super_
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
@@ -3892,13 +3899,6 @@ static int ext4_fill_super(struct super_
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
@@ -3919,10 +3919,10 @@ static int ext4_fill_super(struct super_
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
@@ -3976,6 +3976,13 @@ static int ext4_fill_super(struct super_
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
@@ -4011,6 +4018,14 @@ static int ext4_fill_super(struct super_
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
 
 	bgl_lock_init(sbi->s_blockgroup_lock);
 


