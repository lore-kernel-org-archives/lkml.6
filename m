Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADBFFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9469320833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9469320833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeINUal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:30:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46630 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726925AbeINUal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:30:41 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 61B74B32228FF;
        Fri, 14 Sep 2018 23:15:40 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.399.0; Fri, 14 Sep 2018 23:15:40 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <stuyoder@gmail.com>, <laurentiu.tudor@nxp.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] bus: fsl-mc: use match_string() helper to simplify the code
Date:   Fri, 14 Sep 2018 23:03:24 +0800
Message-ID: <1536937404-31455-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used intead of open coded implementation.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/bus/fsl-mc/fsl-mc-allocator.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
index e906ecfe..7ecc89c 100644
--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -160,16 +160,16 @@ static int __must_check object_type_to_pool_type(const char *object_type,
 						 enum fsl_mc_pool_type
 								*pool_type)
 {
-	unsigned int i;
+	int ret;
 
-	for (i = 0; i < ARRAY_SIZE(fsl_mc_pool_type_strings); i++) {
-		if (strcmp(object_type, fsl_mc_pool_type_strings[i]) == 0) {
-			*pool_type = i;
-			return 0;
-		}
+	ret = match_string(fsl_mc_pool_type_strings,
+			     ARRAY_SIZE(fsl_mc_pool_type_strings), object_type);
+	if (ret >= 0) {
+		*pool_type = ret;
+		return 0;
 	}
 
-	return -EINVAL;
+	return ret;
 }
 
 int __must_check fsl_mc_resource_allocate(struct fsl_mc_bus *mc_bus,
-- 
1.7.12.4

