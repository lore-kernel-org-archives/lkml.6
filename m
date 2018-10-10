Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51363C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068952087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuDdUYZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068952087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeJKEqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:46:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbeJKEqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:46:18 -0400
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9833F20870;
        Wed, 10 Oct 2018 21:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539206538;
        bh=IVjntiDaCNxdd+KJv5FnSzGNfjvXG7FwQihakmm3PPo=;
        h=From:To:Cc:Subject:Date:From;
        b=EuDdUYZ5qACCUIB3ctcvQny54oAzty6Y9Y0VPW9Dry9mPq52DnbQR3XRkezIfurPo
         xG2eCN7wkIfx1wlCkILcd574EH6+DWWoHtqWpa4KdtUkfCchciLRbyEV6LV0/fTXRz
         cDOSKeFhzMhvdbFQpJXY+MxI/CNffI2028M442fo=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: clear cold data flag if IO is not counted
Date:   Wed, 10 Oct 2018 14:22:17 -0700
Message-Id: <20181010212217.52289-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we clear the cold data flag out of the writeback flow, we can miscount
-1 by end_io.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 29a9d3b8f709..4102799b5558 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2636,10 +2636,6 @@ static int f2fs_set_data_page_dirty(struct page *page)
 	if (!PageUptodate(page))
 		SetPageUptodate(page);
 
-	/* don't remain PG_checked flag which was set during GC */
-	if (is_cold_data(page))
-		clear_cold_data(page);
-
 	if (f2fs_is_atomic_file(inode) && !f2fs_is_commit_atomic_write(inode)) {
 		if (!IS_ATOMIC_WRITTEN_PAGE(page)) {
 			f2fs_register_inmem_page(inode, page);
-- 
2.19.0.605.g01d371f741-goog

