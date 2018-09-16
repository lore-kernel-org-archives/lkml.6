Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A63ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 13:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2E72087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 13:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2E72087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbeIPTE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 15:04:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52368 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728433AbeIPTE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 15:04:27 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5AC3B28F9DA9;
        Sun, 16 Sep 2018 21:41:22 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.399.0; Sun, 16 Sep 2018 21:41:22 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <mathieu.poirier@linaro.org>, <alexander.shishkin@linux.intel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] hwtracing: coresight: remove redundant null pointer check before of_node_put and put_device
Date:   Sun, 16 Sep 2018 21:29:04 +0800
Message-ID: <1537104544-64355-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_node_put and put_device has taken the null pointer check into account.
So it is safe to remove the duplicated check.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/hwtracing/coresight/of_coresight.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index da71c97..89092f8 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -219,12 +219,9 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		ret = 1;
 	} while (0);
 
-	if (rparent)
-		of_node_put(rparent);
-	if (rep)
-		of_node_put(rep);
-	if (rdev)
-		put_device(rdev);
+	of_node_put(rparent);
+	of_node_put(rep);
+	put_device(rdev);
 
 	return ret;
 }
-- 
1.7.12.4

