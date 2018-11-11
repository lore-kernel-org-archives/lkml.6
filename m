Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CD2C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB45214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQiw/XeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB45214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389027AbeKLJSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:18:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:45680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388835AbeKLIUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:34 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 537FD21582;
        Sun, 11 Nov 2018 22:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975437;
        bh=Bjg4SHhvZO1x/0s7m3uvc/ZMF6UHAP8lwA0KFN/pUj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FQiw/XeA1i5Xmtykrfk7OsT8CpIhUd7xwNNmg8dU89AUMEyYFchFNAyPireiIDTil
         f4VK0gxdiHt0q8JruCuB1DCSweQKPkRpYMxK0dzbZDG7sqZzXbulnSXdVGr6SYfyRC
         W4AdfVi7DyjZJPaL1PnLBv9V444Y8cFUagahE1TQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4.18 188/350] Revert "f2fs: fix to clear PG_checked flag in set_page_dirty()"
Date:   Sun, 11 Nov 2018 14:20:52 -0800
Message-Id: <20181111221715.892832970@linuxfoundation.org>
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

commit 164a63fa6b384e30ceb96ed80bc7dc3379bc0960 upstream.

This reverts commit 66110abc4c931f879d70e83e1281f891699364bf.

If we clear the cold data flag out of the writeback flow, we can miscount
-1 by end_io, which incurs a deadlock caused by all I/Os being blocked during
heavy GC.

Balancing F2FS Async:
 - IO (CP:    1, Data:   -1, Flush: (   0    0    1), Discard: (   ...

GC thread:                              IRQ
- move_data_page()
 - set_page_dirty()
  - clear_cold_data()
                                        - f2fs_write_end_io()
                                         - type = WB_DATA_TYPE(page);
                                           here, we get wrong type
                                         - dec_page_count(sbi, type);
 - f2fs_wait_on_page_writeback()

Cc: <stable@vger.kernel.org>
Reported-and-Tested-by: Park Ju Hyung <qkrwngud825@gmail.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/f2fs/data.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2501,10 +2501,6 @@ static int f2fs_set_data_page_dirty(stru
 	if (!PageUptodate(page))
 		SetPageUptodate(page);
 
-	/* don't remain PG_checked flag which was set during GC */
-	if (is_cold_data(page))
-		clear_cold_data(page);
-
 	if (f2fs_is_atomic_file(inode) && !f2fs_is_commit_atomic_write(inode)) {
 		if (!IS_ATOMIC_WRITTEN_PAGE(page)) {
 			f2fs_register_inmem_page(inode, page);


