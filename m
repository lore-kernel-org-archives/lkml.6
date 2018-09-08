Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D25C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE182077B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE182077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbeIHQhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 12:37:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42216 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726443AbeIHQhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 12:37:12 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 21E367E552AF3;
        Sat,  8 Sep 2018 19:51:38 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Sat, 8 Sep 2018 19:51:37 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <colyli@suse.de>, <kent.overstreet@gmail.com>
CC:     <linux-bcache@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] bcache: remove unnecessary null poiner check in cache_set_free
Date:   Sat, 8 Sep 2018 19:39:26 +0800
Message-ID: <1536406766-27021-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iterator in for_each_cache is never null, therefore, remove
the redundant null pointer check.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/md/bcache/super.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 94c756c..2d26f9e 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1513,12 +1513,11 @@ static void cache_set_free(struct closure *cl)
 	bch_btree_cache_free(c);
 	bch_journal_free(c);
 
-	for_each_cache(ca, c, i)
-		if (ca) {
-			ca->set = NULL;
-			c->cache[ca->sb.nr_this_dev] = NULL;
-			kobject_put(&ca->kobj);
-		}
+	for_each_cache(ca, c, i) {
+		ca->set = NULL;
+		c->cache[ca->sb.nr_this_dev] = NULL;
+		kobject_put(&ca->kobj);
+	}
 
 	bch_bset_sort_state_free(&c->sort);
 	free_pages((unsigned long) c->uuids, ilog2(bucket_pages(c)));
-- 
1.7.12.4

