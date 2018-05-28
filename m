Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932122AbeE1I7r (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 04:59:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46718 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754276AbeE1I7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:59:39 -0400
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: don't drop dentry pages after fs shutdown
Date: Mon, 28 May 2018 16:59:26 +0800
Message-ID: <20180528085927.91965-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.17.0.391.g1f1cddd558b5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As description in commit "f2fs: don't drop any page on f2fs_cp_error()
case":

"We still provide readdir() after shtudown, so we should keep pages to
avoid additional IOs."

In order to provider lastest directory structure, let's keep dentry
pages in cache after fs shutdown.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9d3e2e1c1e33..31c2edb217ec 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1801,6 +1801,12 @@ static int __write_data_page(struct page *page, bool *submitted,
 	/* we should bypass data pages to proceed the kworkder jobs */
 	if (unlikely(f2fs_cp_error(sbi))) {
 		mapping_set_error(page->mapping, -EIO);
+		/*
+		 * don't drop any dirty dentry pages for keeping lastest
+		 * directory structure.
+		 */
+		if (S_ISDIR(inode->i_mode))
+			goto redirty_out;
 		goto out;
 	}
 
-- 
2.17.0.391.g1f1cddd558b5
