Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F96EC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AFB20821
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfBCOA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:00:27 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53474 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728223AbfBCNtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:53 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9f-0003tr-JA; Sun, 03 Feb 2019 13:49:51 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9a-00072V-JO; Sun, 03 Feb 2019 14:49:46 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Vasily Averin" <vvs@virtuozzo.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.648820889@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 135/305] ext4: avoid potential extra brelse in
 setup_new_flex_group_blocks()
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>

commit 9e4028935cca3f9ef9b6a90df9da6f1f94853536 upstream.

Currently bh is set to NULL only during first iteration of for cycle,
then this pointer is not cleared after end of using.
Therefore rollback after errors can lead to extra brelse(bh) call,
decrements bh counter and later trigger an unexpected warning in __brelse()

Patch moves brelse() calls in body of cycle to exclude requirement of
brelse() call in rollback.

Fixes: 33afdcc5402d ("ext4: add a function which sets up group blocks ...")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/resize.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -588,7 +588,6 @@ handle_bb:
 		bh = bclean(handle, sb, block);
 		if (IS_ERR(bh)) {
 			err = PTR_ERR(bh);
-			bh = NULL;
 			goto out;
 		}
 		overhead = ext4_group_overhead_blocks(sb, group);
@@ -600,9 +599,9 @@ handle_bb:
 		ext4_mark_bitmap_end(group_data[i].blocks_count,
 				     sb->s_blocksize * 8, bh->b_data);
 		err = ext4_handle_dirty_metadata(handle, NULL, bh);
+		brelse(bh);
 		if (err)
 			goto out;
-		brelse(bh);
 
 handle_ib:
 		if (bg_flags[i] & EXT4_BG_INODE_UNINIT)
@@ -617,18 +616,16 @@ handle_ib:
 		bh = bclean(handle, sb, block);
 		if (IS_ERR(bh)) {
 			err = PTR_ERR(bh);
-			bh = NULL;
 			goto out;
 		}
 
 		ext4_mark_bitmap_end(EXT4_INODES_PER_GROUP(sb),
 				     sb->s_blocksize * 8, bh->b_data);
 		err = ext4_handle_dirty_metadata(handle, NULL, bh);
+		brelse(bh);
 		if (err)
 			goto out;
-		brelse(bh);
 	}
-	bh = NULL;
 
 	/* Mark group tables in block bitmap */
 	for (j = 0; j < GROUP_TABLE_COUNT; j++) {
@@ -659,7 +656,6 @@ handle_ib:
 	}
 
 out:
-	brelse(bh);
 	err2 = ext4_journal_stop(handle);
 	if (err2 && !err)
 		err = err2;

