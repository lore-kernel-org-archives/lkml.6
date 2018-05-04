Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbeEDRwP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751558AbeEDRwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:52:13 -0400
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid fsync() failure caused by EAGAIN in writepage()
Date: Fri,  4 May 2018 10:52:10 -0700
Message-Id: <20180504175210.26903-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pageout() in MM traslates EAGAIN, so calls handle_write_error()
 -> mapping_set_error() -> set_bit(AS_EIO, ...).
 file_write_and_wait_range() will see EIO error, which is critical
 to return value of fsync() followed by atomic_write failure to user.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5477fc09c3cd..ac8720fa5868 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1904,7 +1904,13 @@ static int __write_data_page(struct page *page, bool *submitted,
 
 redirty_out:
 	redirty_page_for_writepage(wbc, page);
-	if (!err)
+	/*
+	 * pageout() in MM traslates EAGAIN, so calls handle_write_error()
+	 * -> mapping_set_error() -> set_bit(AS_EIO, ...).
+	 * file_write_and_wait_range() will see EIO error, which is critical
+	 * to return value of fsync() followed by atomic_write failure to user.
+	 */
+	if (!err || wbc->for_reclaim)
 		return AOP_WRITEPAGE_ACTIVATE;
 	unlock_page(page);
 	return err;
-- 
2.17.0.484.g0c8726318c-goog
