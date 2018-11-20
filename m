Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB53C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C6C20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C6C20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbeKUAtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:49:55 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15126 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729599AbeKUAty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:49:54 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0E23220EC7BA1;
        Tue, 20 Nov 2018 22:20:29 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 20 Nov
 2018 22:20:22 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 02/10] staging: erofs: fix race when the managed cache is enabled
Date:   Tue, 20 Nov 2018 22:34:17 +0800
Message-ID: <20181120143425.43637-3-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181120143425.43637-1-gaoxiang25@huawei.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the managed cache is enabled, the last reference count
of a workgroup must be used for its workstation.

Otherwise, it could lead to incorrect (un)freezes in
the reclaim path, and it would be harmful.

A typical race as follows:

Thread 1 (In the reclaim path)  Thread 2
workgroup_freeze(grp, 1)                                refcnt = 1
...
workgroup_unfreeze(grp, 1)                              refcnt = 1
                                workgroup_get(grp)      refcnt = 2 (x)
workgroup_put(grp)                                      refcnt = 1 (x)
                                ...unexpected behaviors

* grp is detached but still used, which violates cache-managed
  freeze constraint.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/internal.h |   1 +
 drivers/staging/erofs/utils.c    | 131 +++++++++++++++++++++++++++------------
 2 files changed, 93 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 57575c7f5635..89dbd0888e53 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -250,6 +250,7 @@ static inline bool erofs_workgroup_get(struct erofs_workgroup *grp, int *ocnt)
 }
 
 #define __erofs_workgroup_get(grp)	atomic_inc(&(grp)->refcount)
+#define __erofs_workgroup_put(grp)	atomic_dec(&(grp)->refcount)
 
 extern int erofs_workgroup_put(struct erofs_workgroup *grp);
 
diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
index ea8a962e5c95..90de8d9195b7 100644
--- a/drivers/staging/erofs/utils.c
+++ b/drivers/staging/erofs/utils.c
@@ -83,12 +83,21 @@ int erofs_register_workgroup(struct super_block *sb,
 
 	grp = xa_tag_pointer(grp, tag);
 
-	err = radix_tree_insert(&sbi->workstn_tree,
-		grp->index, grp);
+	/*
+	 * Bump up reference count before making this workgroup
+	 * visible to other users in order to avoid potential UAF
+	 * without serialized by erofs_workstn_lock.
+	 */
+	__erofs_workgroup_get(grp);
 
-	if (!err) {
-		__erofs_workgroup_get(grp);
-	}
+	err = radix_tree_insert(&sbi->workstn_tree,
+				grp->index, grp);
+	if (unlikely(err))
+		/*
+		 * it's safe to decrease since the workgroup isn't visible
+		 * and refcount >= 2 (cannot be freezed).
+		 */
+		__erofs_workgroup_put(grp);
 
 	erofs_workstn_unlock(sbi);
 	radix_tree_preload_end();
@@ -97,19 +106,91 @@ int erofs_register_workgroup(struct super_block *sb,
 
 extern void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
 
+static void  __erofs_workgroup_free(struct erofs_workgroup *grp)
+{
+	atomic_long_dec(&erofs_global_shrink_cnt);
+	erofs_workgroup_free_rcu(grp);
+}
+
 int erofs_workgroup_put(struct erofs_workgroup *grp)
 {
 	int count = atomic_dec_return(&grp->refcount);
 
 	if (count == 1)
 		atomic_long_inc(&erofs_global_shrink_cnt);
-	else if (!count) {
-		atomic_long_dec(&erofs_global_shrink_cnt);
-		erofs_workgroup_free_rcu(grp);
-	}
+	else if (!count)
+		__erofs_workgroup_free(grp);
 	return count;
 }
 
+#ifdef EROFS_FS_HAS_MANAGED_CACHE
+/* for cache-managed case, customized reclaim paths exist */
+static void erofs_workgroup_unfreeze_final(struct erofs_workgroup *grp)
+{
+	erofs_workgroup_unfreeze(grp, 0);
+	__erofs_workgroup_free(grp);
+}
+
+bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
+				    struct erofs_workgroup *grp,
+				    bool cleanup)
+{
+	/*
+	 * for managed cache enabled, the refcount of workgroups
+	 * themselves could be < 0 (freezed). So there is no guarantee
+	 * that all refcount > 0 if managed cache is enabled.
+	 */
+	if (!erofs_workgroup_try_to_freeze(grp, 1))
+		return false;
+
+	/*
+	 * note that all cached pages should be unlinked
+	 * before delete it from the radix tree.
+	 * Otherwise some cached pages of an orphan old workgroup
+	 * could be still linked after the new one is available.
+	 */
+	if (erofs_try_to_free_all_cached_pages(sbi, grp)) {
+		erofs_workgroup_unfreeze(grp, 1);
+		return false;
+	}
+
+	/* it is impossible to fail after we freeze the workgroup */
+	BUG_ON(xa_untag_pointer(radix_tree_delete(&sbi->workstn_tree,
+						  grp->index)) != grp);
+
+	/*
+	 * if managed cache is enable, the last refcount
+	 * should indicate the related workstation.
+	 */
+	erofs_workgroup_unfreeze_final(grp);
+	return true;
+}
+
+#else
+/* for nocache case, no customized reclaim path at all */
+bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
+				    struct erofs_workgroup *grp,
+				    bool cleanup)
+{
+	int cnt = atomic_read(&grp->refcount);
+
+	DBG_BUGON(cnt <= 0);
+	DBG_BUGON(cleanup && cnt != 1);
+
+	if (cnt > 1)
+		return false;
+
+	if (xa_untag_pointer(radix_tree_delete(&sbi->workstn_tree,
+					       grp->index)) != grp)
+		return false;
+
+	/* (rarely) could be grabbed again when freeing */
+	erofs_workgroup_put(grp);
+	return true;
+}
+
+#endif
+
 unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
 				       unsigned long nr_shrink,
 				       bool cleanup)
@@ -126,41 +207,13 @@ unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
 		batch, first_index, PAGEVEC_SIZE);
 
 	for (i = 0; i < found; ++i) {
-		int cnt;
 		struct erofs_workgroup *grp = xa_untag_pointer(batch[i]);
 
 		first_index = grp->index + 1;
 
-		cnt = atomic_read(&grp->refcount);
-		BUG_ON(cnt <= 0);
-
-		if (cleanup)
-			BUG_ON(cnt != 1);
-
-#ifndef EROFS_FS_HAS_MANAGED_CACHE
-		else if (cnt > 1)
-#else
-		if (!erofs_workgroup_try_to_freeze(grp, 1))
-#endif
-			continue;
-
-		if (xa_untag_pointer(radix_tree_delete(&sbi->workstn_tree,
-			grp->index)) != grp) {
-#ifdef EROFS_FS_HAS_MANAGED_CACHE
-skip:
-			erofs_workgroup_unfreeze(grp, 1);
-#endif
+		/* try to shrink each valid workgroup */
+		if (!erofs_try_to_release_workgroup(sbi, grp, cleanup))
 			continue;
-		}
-
-#ifdef EROFS_FS_HAS_MANAGED_CACHE
-		if (erofs_try_to_free_all_cached_pages(sbi, grp))
-			goto skip;
-
-		erofs_workgroup_unfreeze(grp, 1);
-#endif
-		/* (rarely) grabbed again when freeing */
-		erofs_workgroup_put(grp);
 
 		++freed;
 		if (unlikely(!--nr_shrink))
-- 
2.14.4

