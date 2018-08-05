Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5177DC46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 15:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0972721885
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 15:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJRvCUUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0972721885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbeHEROt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 13:14:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbeHEROs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 13:14:48 -0400
Received: from localhost.localdomain (unknown [49.77.238.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5124621885;
        Sun,  5 Aug 2018 15:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533481793;
        bh=xzLqdBXkOxp2LpF801UEXyATGHE0VlR+u63UAQi0uEA=;
        h=From:To:Cc:Subject:Date:From;
        b=ZJRvCUUgDrekp45SlArzAUiHCbORzxQsWItpVC0m/uIY2YgbzBMvNMsVU4vE+5gdf
         Fd4zjIrju3i4/YoznrrfZ/YIrTlwPmtRLlen9YGJigRh4UQdVawk4hZ/cKZb8rmHIo
         zUiXG3wMKxjnPwC5o2IUU/p7+Spbn6bahZ00fuJk=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: refresh recent accessed nat entry in lru list
Date:   Sun,  5 Aug 2018 23:08:59 +0800
Message-Id: <20180805150900.9941-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Introduce nat_list_lock to protect nm_i->nat_entries list, and manage
it as a LRU list, refresh location for therein recent accessed entries
in the list.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/node.c | 46 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f4b03339799e..afcdba241c4b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -780,6 +780,7 @@ struct f2fs_nm_info {
 	struct radix_tree_root nat_set_root;/* root of the nat set cache */
 	struct rw_semaphore nat_tree_lock;	/* protect nat_tree_lock */
 	struct list_head nat_entries;	/* cached nat entry list (clean) */
+	spinlock_t nat_list_lock;	/* protect clean nat entry list */
 	unsigned int nat_cnt;		/* the # of cached nat entries */
 	unsigned int dirty_nat_cnt;	/* total num of nat entries in set */
 	unsigned int nat_blocks;	/* # of nat blocks */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 81fb2f3edb52..472dd643b074 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -174,14 +174,30 @@ static struct nat_entry *__init_nat_entry(struct f2fs_nm_info *nm_i,
 
 	if (raw_ne)
 		node_info_from_raw_nat(&ne->ni, raw_ne);
+
+	spin_lock(&nm_i->nat_list_lock);
 	list_add_tail(&ne->list, &nm_i->nat_entries);
+	spin_unlock(&nm_i->nat_list_lock);
+
 	nm_i->nat_cnt++;
 	return ne;
 }
 
 static struct nat_entry *__lookup_nat_cache(struct f2fs_nm_info *nm_i, nid_t n)
 {
-	return radix_tree_lookup(&nm_i->nat_root, n);
+	struct nat_entry *ne;
+
+	ne = radix_tree_lookup(&nm_i->nat_root, n);
+
+	/* for recent accessed nat entry, move it to tail of lru list */
+	if (ne && !get_nat_flag(ne, IS_DIRTY)) {
+		spin_lock(&nm_i->nat_list_lock);
+		if (!list_empty(&ne->list))
+			list_move_tail(&ne->list, &nm_i->nat_entries);
+		spin_unlock(&nm_i->nat_list_lock);
+	}
+
+	return ne;
 }
 
 static unsigned int __gang_lookup_nat_cache(struct f2fs_nm_info *nm_i,
@@ -192,7 +208,6 @@ static unsigned int __gang_lookup_nat_cache(struct f2fs_nm_info *nm_i,
 
 static void __del_from_nat_cache(struct f2fs_nm_info *nm_i, struct nat_entry *e)
 {
-	list_del(&e->list);
 	radix_tree_delete(&nm_i->nat_root, nat_get_nid(e));
 	nm_i->nat_cnt--;
 	__free_nat_entry(e);
@@ -243,16 +258,21 @@ static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
 	nm_i->dirty_nat_cnt++;
 	set_nat_flag(ne, IS_DIRTY, true);
 refresh_list:
+	spin_lock(&nm_i->nat_list_lock);
 	if (new_ne)
 		list_del_init(&ne->list);
 	else
 		list_move_tail(&ne->list, &head->entry_list);
+	spin_unlock(&nm_i->nat_list_lock);
 }
 
 static void __clear_nat_cache_dirty(struct f2fs_nm_info *nm_i,
 		struct nat_entry_set *set, struct nat_entry *ne)
 {
+	spin_lock(&nm_i->nat_list_lock);
 	list_move_tail(&ne->list, &nm_i->nat_entries);
+	spin_unlock(&nm_i->nat_list_lock);
+
 	set_nat_flag(ne, IS_DIRTY, false);
 	set->entry_cnt--;
 	nm_i->dirty_nat_cnt--;
@@ -469,13 +489,25 @@ int f2fs_try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink)
 	if (!down_write_trylock(&nm_i->nat_tree_lock))
 		return 0;
 
-	while (nr_shrink && !list_empty(&nm_i->nat_entries)) {
+	spin_lock(&nm_i->nat_list_lock);
+	while (nr_shrink) {
 		struct nat_entry *ne;
+
+		if (list_empty(&nm_i->nat_entries))
+			break;
+
 		ne = list_first_entry(&nm_i->nat_entries,
 					struct nat_entry, list);
+		list_del(&ne->list);
+		spin_unlock(&nm_i->nat_list_lock);
+
 		__del_from_nat_cache(nm_i, ne);
 		nr_shrink--;
+
+		spin_lock(&nm_i->nat_list_lock);
 	}
+	spin_unlock(&nm_i->nat_list_lock);
+
 	up_write(&nm_i->nat_tree_lock);
 	return nr - nr_shrink;
 }
@@ -2906,6 +2938,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 	INIT_RADIX_TREE(&nm_i->nat_root, GFP_NOIO);
 	INIT_RADIX_TREE(&nm_i->nat_set_root, GFP_NOIO);
 	INIT_LIST_HEAD(&nm_i->nat_entries);
+	spin_lock_init(&nm_i->nat_list_lock);
 
 	mutex_init(&nm_i->build_lock);
 	spin_lock_init(&nm_i->nid_list_lock);
@@ -3024,8 +3057,13 @@ void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi)
 		unsigned idx;
 
 		nid = nat_get_nid(natvec[found - 1]) + 1;
-		for (idx = 0; idx < found; idx++)
+		for (idx = 0; idx < found; idx++) {
+			spin_lock(&nm_i->nat_list_lock);
+			list_del(&natvec[idx]->list);
+			spin_unlock(&nm_i->nat_list_lock);
+
 			__del_from_nat_cache(nm_i, natvec[idx]);
+		}
 	}
 	f2fs_bug_on(sbi, nm_i->nat_cnt);
 
-- 
2.18.0

