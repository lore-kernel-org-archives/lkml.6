Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751719AbeCTPIr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:08:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751128AbeCTPIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:08:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73843217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=chao@kernel.org
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>, Yunlei He <heyunlei@huawei.com>
Subject: [PATCH 2/2] f2fs: don't track new nat entry in nat set
Date: Tue, 20 Mar 2018 23:08:30 +0800
Message-Id: <20180320150830.2630-2-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
In-Reply-To: <20180320150830.2630-1-chao@kernel.org>
References: <20180320150830.2630-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Nat entry set is used only in checkpoint(), and during checkpoint() we
won't flush new nat entry with unallocated address, so we don't need to
add new nat entry into nat set, then nat_entry_set::entry_cnt can
indicate actual entry count we need to flush in checkpoint().

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 29 +++++++++++++++++++++++++----
 fs/f2fs/node.h |  1 +
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index ecfc2465da9b..9a99243054ba 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -193,8 +193,8 @@ static void __del_from_nat_cache(struct f2fs_nm_info *nm_i, struct nat_entry *e)
 	__free_nat_entry(e);
 }
 
-static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
-						struct nat_entry *ne)
+static struct nat_entry_set *__grab_nat_entry_set(struct f2fs_nm_info *nm_i,
+							struct nat_entry *ne)
 {
 	nid_t set = NAT_BLOCK_OFFSET(ne->ni.nid);
 	struct nat_entry_set *head;
@@ -209,15 +209,36 @@ static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
 		head->entry_cnt = 0;
 		f2fs_radix_tree_insert(&nm_i->nat_set_root, set, head);
 	}
+	return head;
+}
+
+static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
+						struct nat_entry *ne)
+{
+	struct nat_entry_set *head;
+	bool new_ne = nat_get_blkaddr(ne) == NEW_ADDR;
+
+	if (!new_ne)
+		head = __grab_nat_entry_set(nm_i, ne);
+
+	/*
+	 * update entry_cnt in below condition:
+	 * 1. update NEW_ADDR to valid block address;
+	 * 2. update old block address to new one;
+	 */
+	if (!new_ne && (get_nat_flag(ne, IS_PREALLOC) ||
+				!get_nat_flag(ne, IS_DIRTY)))
+		head->entry_cnt++;
+
+	set_nat_flag(ne, IS_PREALLOC, new_ne);
 
 	if (get_nat_flag(ne, IS_DIRTY))
 		goto refresh_list;
 
 	nm_i->dirty_nat_cnt++;
-	head->entry_cnt++;
 	set_nat_flag(ne, IS_DIRTY, true);
 refresh_list:
-	if (nat_get_blkaddr(ne) == NEW_ADDR)
+	if (new_ne)
 		list_del_init(&ne->list);
 	else
 		list_move_tail(&ne->list, &head->entry_list);
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index e593b4d78be2..b95e49e4a928 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -44,6 +44,7 @@ enum {
 	HAS_FSYNCED_INODE,	/* is the inode fsynced before? */
 	HAS_LAST_FSYNC,		/* has the latest node fsync mark? */
 	IS_DIRTY,		/* this nat entry is dirty? */
+	IS_PREALLOC,		/* nat entry is preallocated */
 };
 
 /*
-- 
2.16.2.17.g38e79b1fd
