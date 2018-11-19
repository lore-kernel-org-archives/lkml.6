Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E623C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250EC20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0hPGsQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250EC20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390247AbeKTDP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:15:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:53060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388976AbeKTDP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:15:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DE43208E4;
        Mon, 19 Nov 2018 16:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646274;
        bh=+VzS/jqQlJvdAYUByv3/unY8V8Aw5MD9GnXdI2FzgBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0hPGsQ9BfUw1NScCpUApILLEhX2hMl0HccvzE2pZJ74l7kUF1l3DLDpa+BL7VMIv
         KRTaBwHAZAkAVXJV6uRUrSiMUQBHzbTL9faFprk6AlYS4jmk9r+PJC88cKr5yTZ5OS
         mjNRcPWRFhnbk8/R8BFfiJj29uUt/cugkGIOxDrc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 4.14 076/124] ext4: avoid potential extra brelse in setup_new_flex_group_blocks()
Date:   Mon, 19 Nov 2018 17:28:50 +0100
Message-Id: <20181119162627.703035071@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@kernel.org # 3.3+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/resize.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -592,7 +592,6 @@ handle_bb:
 		bh = bclean(handle, sb, block);
 		if (IS_ERR(bh)) {
 			err = PTR_ERR(bh);
-			bh = NULL;
 			goto out;
 		}
 		overhead = ext4_group_overhead_blocks(sb, group);
@@ -604,9 +603,9 @@ handle_bb:
 		ext4_mark_bitmap_end(group_data[i].blocks_count,
 				     sb->s_blocksize * 8, bh->b_data);
 		err = ext4_handle_dirty_metadata(handle, NULL, bh);
+		brelse(bh);
 		if (err)
 			goto out;
-		brelse(bh);
 
 handle_ib:
 		if (bg_flags[i] & EXT4_BG_INODE_UNINIT)
@@ -621,18 +620,16 @@ handle_ib:
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
@@ -663,7 +660,6 @@ handle_ib:
 	}
 
 out:
-	brelse(bh);
 	err2 = ext4_journal_stop(handle);
 	if (err2 && !err)
 		err = err2;


