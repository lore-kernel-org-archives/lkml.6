Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753800AbeDMBHV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 21:07:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753328AbeDMBHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 21:07:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2213721781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: clear PageError on writepage
Date: Thu, 12 Apr 2018 18:07:16 -0700
Message-Id: <20180413010716.53610-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.15.0.531.g2ccb3012c9-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch clears PageError in some pages tagged by read path, but when we
write the pages with valid contents, writepage should clear the bit likewise
ext4.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index db50686f5096..6d39a6e12f78 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1675,6 +1675,7 @@ int do_write_data_page(struct f2fs_io_info *fio)
 			goto out_writepage;
 
 		set_page_writeback(page);
+		ClearPageError(page);
 		f2fs_put_dnode(&dn);
 		if (fio->need_lock == LOCK_REQ)
 			f2fs_unlock_op(fio->sbi);
@@ -1697,6 +1698,7 @@ int do_write_data_page(struct f2fs_io_info *fio)
 		goto out_writepage;
 
 	set_page_writeback(page);
+	ClearPageError(page);
 
 	/* LFS mode write path */
 	write_data_page(&dn, fio);
-- 
2.15.0.531.g2ccb3012c9-goog
