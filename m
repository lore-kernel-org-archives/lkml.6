Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81536ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E792157C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E792157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392212AbeIVGNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:13:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44247 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392010AbeIVGKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:48 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdy-0008Bb-6e; Sat, 22 Sep 2018 01:19:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdo-0000rw-1X; Sat, 22 Sep 2018 01:19:20 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Harsh Shandilya" <harsh@prjkt.io>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.775186761@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 28/63] ext4: don't allow r/w mounts if metadata
 blocks overlap the superblock
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

commit 18db4b4e6fc31eda838dd1c1296d67dbcb3dc957 upstream.

If some metadata block, such as an allocation bitmap, overlaps the
superblock, it's very likely that if the file system is mounted
read/write, the results will not be pretty.  So disallow r/w mounts
for file systems corrupted in this particular way.

Backport notes:
3.18.y is missing bc98a42c1f7d ("VFS: Convert sb->s_flags & MS_RDONLY
to sb_rdonly(sb)") and e462ec50cb5f ("VFS: Differentiate mount flags
(MS_*) from internal superblock flags") so we simply use the sb
MS_RDONLY check from pre bc98a42c1f7d in place of the sb_rdonly
function used in the upstream variant of the patch.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Harsh Shandilya <harsh@prjkt.io>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2115,6 +2115,8 @@ static int ext4_check_descriptors(struct
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 				 "Block bitmap for group %u overlaps "
 				 "superblock", i);
+			if (!(sb->s_flags & MS_RDONLY))
+				return 0;
 		}
 		if (block_bitmap < first_block || block_bitmap > last_block) {
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
@@ -2127,6 +2129,8 @@ static int ext4_check_descriptors(struct
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 				 "Inode bitmap for group %u overlaps "
 				 "superblock", i);
+			if (!(sb->s_flags & MS_RDONLY))
+				return 0;
 		}
 		if (inode_bitmap < first_block || inode_bitmap > last_block) {
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
@@ -2139,6 +2143,8 @@ static int ext4_check_descriptors(struct
 			ext4_msg(sb, KERN_ERR, "ext4_check_descriptors: "
 				 "Inode table for group %u overlaps "
 				 "superblock", i);
+			if (!(sb->s_flags & MS_RDONLY))
+				return 0;
 		}
 		if (inode_table < first_block ||
 		    inode_table + sbi->s_itb_per_group - 1 > last_block) {

