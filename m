Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932065AbeE1I7o (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 04:59:44 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46725 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754277AbeE1I7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:59:39 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix error path of move_data_page
Date: Mon, 28 May 2018 16:59:27 +0800
Message-ID: <20180528085927.91965-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.17.0.391.g1f1cddd558b5
In-Reply-To: <20180528085927.91965-1-yuchao0@huawei.com>
References: <20180528085927.91965-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes error path of move_data_page:
- clear cold data flag if it fails to write page.
- redirty page for non-ENOMEM case.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/gc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 50bb8fc25275..885032fc3a61 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -780,9 +780,14 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 		set_cold_data(page);
 
 		err = do_write_data_page(&fio);
-		if (err == -ENOMEM && is_dirty) {
-			congestion_wait(BLK_RW_ASYNC, HZ/50);
-			goto retry;
+		if (err) {
+			clear_cold_data(page);
+			if (err == -ENOMEM) {
+				congestion_wait(BLK_RW_ASYNC, HZ/50);
+				goto retry;
+			}
+			if (is_dirty)
+				set_page_dirty(page);
 		}
 	}
 out:
-- 
2.17.0.391.g1f1cddd558b5
