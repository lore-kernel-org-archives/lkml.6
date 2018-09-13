Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D80CC070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E133213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E133213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeIMIVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 04:21:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12109 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726685AbeIMIVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 04:21:04 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8422467BC5753;
        Thu, 13 Sep 2018 11:13:32 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.399.0; Thu, 13 Sep 2018 11:13:31 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <dsterba@suse.com>
CC:     <jbacik@fb.com>, <clm@fb.com>, <linux-btrfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCHv3 1/2] btrfs: change unpin_extent_cache to be void function
Date:   Thu, 13 Sep 2018 11:01:14 +0800
Message-ID: <1536807675-25086-2-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1536807675-25086-1-git-send-email-zhongjiang@huawei.com>
References: <1536807675-25086-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unpin_extent_cache use the the variable "ret" for return value,
but it is not modified after initialzation. Further, I find that
any of the callers do not handle the return value, so it is safe
to drop the unneeded "ret" and make it to be void function.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 fs/btrfs/extent_map.c | 5 +----
 fs/btrfs/extent_map.h | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 819420e..c4e2347 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -276,10 +276,9 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
  * to the generation that actually added the file item to the inode so we know
  * we need to sync this extent when we call fsync().
  */
-int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
+void unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
 		       u64 gen)
 {
-	int ret = 0;
 	struct extent_map *em;
 	bool prealloc = false;
 
@@ -311,8 +310,6 @@ int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
 	free_extent_map(em);
 out:
 	write_unlock(&tree->lock);
-	return ret;
-
 }
 
 void clear_em_logging(struct extent_map_tree *tree, struct extent_map *em)
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 6afe786..df4e1a5 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -88,7 +88,7 @@ void replace_extent_mapping(struct extent_map_tree *tree,
 void free_extent_map(struct extent_map *em);
 int __init extent_map_init(void);
 void __cold extent_map_exit(void);
-int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len, u64 gen);
+void unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len, u64 gen);
 void clear_em_logging(struct extent_map_tree *tree, struct extent_map *em);
 struct extent_map *search_extent_mapping(struct extent_map_tree *tree,
 					 u64 start, u64 len);
-- 
1.7.12.4

