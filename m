Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C43CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4058208DC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="quS0sf3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4058208DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeH1ClI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 22:41:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbeH1ClI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 22:41:08 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 084EB208D5;
        Mon, 27 Aug 2018 22:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535410348;
        bh=xTQNkoKybzpVouazMBYQRlV2djHOKkRJilHDYwTJTnA=;
        h=From:To:Cc:Subject:Date:From;
        b=quS0sf3Ry9bsA+IDczcDWWorWUHIbBvvGTjVus9gnk5Iwh3VeVrPvD1bsar6qWsIg
         /U04oPToU60DZerkPPDG02B8KD6yVF6YhLaqV14Y4hPOtK3/XCQOJGXFxlOYQqCylH
         yuaAfTdtrqlHANU7RF03kndfpevP4Roecrv3Wb/I=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid wrong decrypted data from disk
Date:   Mon, 27 Aug 2018 15:52:26 -0700
Message-Id: <20180827225226.14272-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Create a file in an encrypted directory
2. Do GC & drop caches
3. Read stale data before its bio for metapage was not issued yet

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 382c1ef9a9e4..c3557fd4a0bd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1550,6 +1550,13 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 			bio = NULL;
 		}
 		if (bio == NULL) {
+			/*
+			 * If the page is under writeback, we need to wait for
+			 * its completion to see the correct decrypted data.
+			 */
+			if (unlikely(f2fs_encrypted_file(inode)))
+				f2fs_wait_on_block_writeback(F2FS_I_SB(inode), block_nr);
+
 			bio = f2fs_grab_read_bio(inode, block_nr, nr_pages,
 					is_readahead ? REQ_RAHEAD : 0);
 			if (IS_ERR(bio)) {
-- 
2.17.0.441.gb46fe60e1d-goog

