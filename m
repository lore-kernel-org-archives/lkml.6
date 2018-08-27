Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70A0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCA5208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BCA5208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeH0RbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 13:31:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33882 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726934AbeH0RbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 13:31:04 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3F35A28DC901D;
        Mon, 27 Aug 2018 21:44:17 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.399.0; Mon, 27 Aug 2018 21:44:17 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <daniel.lezcano@linaro.org>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <ezequiel@collabora.com>
Subject: [PATCH v2] drivers/thermal/tegra: Fix a double free on the device node
Date:   Mon, 27 Aug 2018 21:32:18 +0800
Message-ID: <1535376738-14035-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function 'for_each_child_of_node' iterates over the node list by
dropping the of_node reference of the previous node.

Calling of_node_put() on the iterator is pointless and leads to an
inconsistent refcounting in addition to a double free. Remove it.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
v1->v2: According to Daniel's suggestion. I modify the subject and commit log.

 drivers/thermal/tegra/soctherm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index ed28110..3aa55c9 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -980,7 +980,6 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 		tcd = thermal_of_cooling_device_register(np_stcc,
 							 (char *)name, ts,
 							 &throt_cooling_ops);
-		of_node_put(np_stcc);
 		if (IS_ERR_OR_NULL(tcd)) {
 			dev_err(dev,
 				"throttle-cfg: %s: failed to register cooling device\n",
-- 
1.7.12.4

