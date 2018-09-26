Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E262BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78092214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjlCbDkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78092214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbeIZH4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 03:56:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726938AbeIZH4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 03:56:42 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B44B5208E4;
        Wed, 26 Sep 2018 01:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537926380;
        bh=+R6cw8A47RH+6r7HzvE/9PkpX2nxHxi0qMdPPBlaBQ4=;
        h=From:To:Cc:Subject:Date:From;
        b=hjlCbDkbPRkH8gKv1VzrzlDSF+0tuwMbivMu9hZ5NAbdhNcws4jYsVp2vlaNr0sz5
         1fsibGeaEogYiDjsTikPPLXjVfHES2SeQiPn9M/rCE/gOWOrkH22lbVKZ/kuaQJZIs
         vFXRa4DMDLPsIO93SJaZo16i7O0vKFOanvUHuRF4=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: clear PageError on the read path
Date:   Tue, 25 Sep 2018 18:46:16 -0700
Message-Id: <20180926014617.12369-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running fault injection test, I hit somewhat wrong behavior in f2fs_gc ->
gc_data_segment():

0. fault injection generated some PageError'ed pages

1. gc_data_segment
 -> f2fs_get_read_data_page(REQ_RAHEAD)

2. move_data_page
 -> f2fs_get_lock_data_page()
  -> f2f_get_read_data_page()
   -> f2fs_submit_page_read()
    -> submit_bio(READ)
  -> return EIO due to PageError
  -> fail to move data

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 41102c227eee..cb3ebcae0398 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -77,7 +77,8 @@ static void __read_end_io(struct bio *bio)
 		/* PG_error was set if any post_read step failed */
 		if (bio->bi_status || PageError(page)) {
 			ClearPageUptodate(page);
-			SetPageError(page);
+			/* will re-read again later */
+			ClearPageError(page);
 		} else {
 			SetPageUptodate(page);
 		}
@@ -591,6 +592,7 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
 		bio_put(bio);
 		return -EFAULT;
 	}
+	ClearPageError(page);
 	__submit_bio(F2FS_I_SB(inode), bio, DATA);
 	return 0;
 }
@@ -1571,6 +1573,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 		if (bio_add_page(bio, page, blocksize, 0) < blocksize)
 			goto submit_and_realloc;
 
+		ClearPageError(page);
 		last_block_in_bio = block_nr;
 		goto next_page;
 set_error_page:
-- 
2.17.0.441.gb46fe60e1d-goog

