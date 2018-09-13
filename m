Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55B0C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912BC21476
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912BC21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeIMIVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 04:21:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12108 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbeIMIVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 04:21:04 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7F0291E10A124;
        Thu, 13 Sep 2018 11:13:32 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.399.0; Thu, 13 Sep 2018 11:13:32 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <dsterba@suse.com>
CC:     <jbacik@fb.com>, <clm@fb.com>, <linux-btrfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCHv3 2/2] btrfs: change remove_extent_mapping to be void function
Date:   Thu, 13 Sep 2018 11:01:15 +0800
Message-ID: <1536807675-25086-3-git-send-email-zhongjiang@huawei.com>
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

remove_extent_mapping use the variable "ret" for return value,
but it is not modified after initialzation. Further, I find that
any of the callers do not handle the return value, so it is safe
to drop the unneeded "ret" and make it to be void function.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 fs/btrfs/extent_map.c | 5 +----
 fs/btrfs/extent_map.h | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index c4e2347..81b6a08 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -428,16 +428,13 @@ struct extent_map *search_extent_mapping(struct extent_map_tree *tree,
  * Removes @em from @tree.  No reference counts are dropped, and no checks
  * are done to see if the range is in use
  */
-int remove_extent_mapping(struct extent_map_tree *tree, struct extent_map *em)
+void remove_extent_mapping(struct extent_map_tree *tree, struct extent_map *em)
 {
-	int ret = 0;
-
 	WARN_ON(test_bit(EXTENT_FLAG_PINNED, &em->flags));
 	rb_erase_cached(&em->rb_node, &tree->map);
 	if (!test_bit(EXTENT_FLAG_LOGGING, &em->flags))
 		list_del_init(&em->list);
 	RB_CLEAR_NODE(&em->rb_node);
-	return ret;
 }
 
 void replace_extent_mapping(struct extent_map_tree *tree,
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index df4e1a5..8798745 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -78,7 +78,7 @@ struct extent_map *lookup_extent_mapping(struct extent_map_tree *tree,
 					 u64 start, u64 len);
 int add_extent_mapping(struct extent_map_tree *tree,
 		       struct extent_map *em, int modified);
-int remove_extent_mapping(struct extent_map_tree *tree, struct extent_map *em);
+void remove_extent_mapping(struct extent_map_tree *tree, struct extent_map *em);
 void replace_extent_mapping(struct extent_map_tree *tree,
 			    struct extent_map *cur,
 			    struct extent_map *new,
-- 
1.7.12.4

