Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866BFC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468F42084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhzGeqcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468F42084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388906AbeKLJVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:21:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388532AbeKLIUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:20 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E00A21582;
        Sun, 11 Nov 2018 22:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975424;
        bh=qgMriUdIHMLl3exkJoR27m6Sa+PLbIE/PT6BEoCthts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jhzGeqcfkxWuZrlO4uq6otwJIFk/Nc4dcSrQsbU9AAwRHaRCrku98PM6hlGufKvdn
         K24LY4hE63ze6F5oCjgKkjQAXCaq1HPC7fxRcXjK78J2NncDiHHZOt/jFiUHtqXgZ8
         zhWR04PBZwi/MKTIHGnfDU54y4c5ya6Pzkp5J2Lk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 154/350] f2fs: clear PageError on the read path
Date:   Sun, 11 Nov 2018 14:20:18 -0800
Message-Id: <20181111221714.510201708@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit fb7d70db305a1446864227abf711b756568f8242 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/data.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -80,7 +80,8 @@ static void __read_end_io(struct bio *bi
 		/* PG_error was set if any post_read step failed */
 		if (bio->bi_status || PageError(page)) {
 			ClearPageUptodate(page);
-			SetPageError(page);
+			/* will re-read again later */
+			ClearPageError(page);
 		} else {
 			SetPageUptodate(page);
 		}
@@ -584,6 +585,7 @@ static int f2fs_submit_page_read(struct
 		bio_put(bio);
 		return -EFAULT;
 	}
+	ClearPageError(page);
 	__submit_bio(F2FS_I_SB(inode), bio, DATA);
 	return 0;
 }
@@ -1528,6 +1530,7 @@ submit_and_realloc:
 		if (bio_add_page(bio, page, blocksize, 0) < blocksize)
 			goto submit_and_realloc;
 
+		ClearPageError(page);
 		last_block_in_bio = block_nr;
 		goto next_page;
 set_error_page:


