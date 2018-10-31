Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D79ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8CA2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3ICEI/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C8CA2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbeKAIpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:45:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728918AbeKAIH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:07:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BE9620821;
        Wed, 31 Oct 2018 23:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027238;
        bh=b9LSd88zp3hEsCbEGEp8oGHOania1pQhi8BKl6FPxSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I3ICEI/2XEo6Oy6WhMEJebyOKfZpgbhHT9lvQNc9vw6e+k0Sge9TAmZC3Qr25STpG
         PmzxlL4Z2f9eOJryTDvmFDBMLcjdAIWGCVEZTNpJIk7QKkBjTnVA/zEKC+zxDHyNVq
         EqxaslVZ1+ubV+zQlJ8w1QIxVQWyMnFf+3BnjbRo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 107/146] f2fs: clear PageError on the read path
Date:   Wed, 31 Oct 2018 19:05:02 -0400
Message-Id: <20181031230541.28822-107-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 fs/f2fs/data.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cd5d53353a61..f79fb3aa5ae3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -80,7 +80,8 @@ static void __read_end_io(struct bio *bio)
 		/* PG_error was set if any post_read step failed */
 		if (bio->bi_status || PageError(page)) {
 			ClearPageUptodate(page);
-			SetPageError(page);
+			/* will re-read again later */
+			ClearPageError(page);
 		} else {
 			SetPageUptodate(page);
 		}
@@ -590,6 +591,7 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
 		bio_put(bio);
 		return -EFAULT;
 	}
+	ClearPageError(page);
 	__submit_bio(F2FS_I_SB(inode), bio, DATA);
 	return 0;
 }
@@ -1565,6 +1567,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
 		if (bio_add_page(bio, page, blocksize, 0) < blocksize)
 			goto submit_and_realloc;
 
+		ClearPageError(page);
 		last_block_in_bio = block_nr;
 		goto next_page;
 set_error_page:
-- 
2.17.1

