Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D84C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CA620661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CA620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeLIWGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:06:47 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37110 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726791AbeLIWGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:06:42 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW738-0002ie-DN; Sun, 09 Dec 2018 21:55:43 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72f-0003TJ-G7; Sun, 09 Dec 2018 21:55:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Theodore Ts'o" <tytso@mit.edu>,
        "Torsten Hilbrich" <torsten.hilbrich@secunet.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.443197486@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 187/328] ext4: fix online resize's handling of a
 too-small final block group
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit f0a459dec5495a3580f8d784555e6f8f3bf7f263 upstream.

Avoid growing the file system to an extent so that the last block
group is too small to hold all of the metadata that must be stored in
the block group.

This problem can be triggered with the following reproducer:

umount /mnt
mke2fs -F -m0 -b 4096 -t ext4 -O resize_inode,^has_journal \
	-E resize=1073741824 /tmp/foo.img 128M
mount /tmp/foo.img /mnt
truncate --size 1708M /tmp/foo.img
resize2fs /dev/loop0 295400
umount /mnt
e2fsck -fy /tmp/foo.img

Reported-by: Torsten Hilbrich <torsten.hilbrich@secunet.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/resize.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1957,6 +1957,26 @@ retry:
 		}
 	}
 
+	/*
+	 * Make sure the last group has enough space so that it's
+	 * guaranteed to have enough space for all metadata blocks
+	 * that it might need to hold.  (We might not need to store
+	 * the inode table blocks in the last block group, but there
+	 * will be cases where this might be needed.)
+	 */
+	if ((ext4_group_first_block_no(sb, n_group) +
+	     ext4_group_overhead_blocks(sb, n_group) + 2 +
+	     sbi->s_itb_per_group + sbi->s_cluster_ratio) >= n_blocks_count) {
+		n_blocks_count = ext4_group_first_block_no(sb, n_group);
+		n_group--;
+		n_blocks_count_retry = 0;
+		if (resize_inode) {
+			iput(resize_inode);
+			resize_inode = NULL;
+		}
+		goto retry;
+	}
+
 	/* extend the last group */
 	if (n_group == o_group)
 		add = n_blocks_count - o_blocks_count;

