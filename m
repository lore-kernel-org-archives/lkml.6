Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F135EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAEC2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAEC2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbeKLFz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:55:57 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51972 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731143AbeKLFz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:55:56 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvtB-0000l5-Po; Sun, 11 Nov 2018 19:59:21 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsO-0001PU-Lp; Sun, 11 Nov 2018 19:58:32 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Joe Habermann" <joe.habermann@quantum.com>,
        "Lukas Czerner" <lczerner@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.225827293@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 043/366] ext4: update mtime in ext4_punch_hole even
 if no blocks are released
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

From: Lukas Czerner <lczerner@redhat.com>

commit eee597ac931305eff3d3fd1d61d6aae553bc0984 upstream.

Currently in ext4_punch_hole we're going to skip the mtime update if
there are no actual blocks to release. However we've actually modified
the file by zeroing the partial block so the mtime should be updated.

Moreover the sync and datasync handling is skipped as well, which is
also wrong. Fix it.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reported-by: Joe Habermann <joe.habermann@quantum.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/inode.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3749,28 +3749,28 @@ int ext4_punch_hole(struct inode *inode,
 		EXT4_BLOCK_SIZE_BITS(sb);
 	stop_block = (offset + length) >> EXT4_BLOCK_SIZE_BITS(sb);
 
-	/* If there are no blocks to remove, return now */
-	if (first_block >= stop_block)
-		goto out_stop;
-
-	down_write(&EXT4_I(inode)->i_data_sem);
-	ext4_discard_preallocations(inode);
-
-	ret = ext4_es_remove_extent(inode, first_block,
-				    stop_block - first_block);
-	if (ret) {
-		up_write(&EXT4_I(inode)->i_data_sem);
-		goto out_stop;
-	}
+	/* If there are blocks to remove, do it */
+	if (stop_block > first_block) {
+
+		down_write(&EXT4_I(inode)->i_data_sem);
+		ext4_discard_preallocations(inode);
 
-	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		ret = ext4_ext_remove_space(inode, first_block,
-					    stop_block - 1);
-	else
-		ret = ext4_ind_remove_space(handle, inode, first_block,
-					    stop_block);
+		ret = ext4_es_remove_extent(inode, first_block,
+					    stop_block - first_block);
+		if (ret) {
+			up_write(&EXT4_I(inode)->i_data_sem);
+			goto out_stop;
+		}
+
+		if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+			ret = ext4_ext_remove_space(inode, first_block,
+						    stop_block - 1);
+		else
+			ret = ext4_ind_remove_space(handle, inode, first_block,
+						    stop_block);
 
-	up_write(&EXT4_I(inode)->i_data_sem);
+		up_write(&EXT4_I(inode)->i_data_sem);
+	}
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
 

