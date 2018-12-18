Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B00C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611FB21850
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeLRLUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:20:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16592 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726364AbeLRLUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:20:34 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D09ABCFD9DB31;
        Tue, 18 Dec 2018 19:20:30 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Tue, 18 Dec 2018 19:20:25 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: clean up structure extent_node
Date:   Tue, 18 Dec 2018 19:20:16 +0800
Message-ID: <20181218112017.80555-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The union in struct extent_node wass only to indicate below fields

	struct rb_node rb_node;
	union {
		struct {
			unsigned int fofs;
			unsigned int len;
		...
	...

can be parsed as fields in struct rb_entry, but they were never be
used explicitly before, so let's remove them for cleanup.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ab69c7454a05..a92e5ed78f53 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -559,16 +559,8 @@ struct extent_info {
 };
 
 struct extent_node {
-	struct rb_node rb_node;
-	union {
-		struct {
-			unsigned int fofs;
-			unsigned int len;
-			u32 blk;
-		};
-		struct extent_info ei;	/* extent info */
-
-	};
+	struct rb_node rb_node;		/* rb node located in rb-tree */
+	struct extent_info ei;		/* extent info */
 	struct list_head list;		/* node in global extent list of sbi */
 	struct extent_tree *et;		/* extent tree pointer */
 };
-- 
2.18.0.rc1

