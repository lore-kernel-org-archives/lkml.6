Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB937C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD1021E21
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 13:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD1021E21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732299AbeHIQRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:17:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59228 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731432AbeHIQRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:17:53 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6A4DE625CFAA6;
        Thu,  9 Aug 2018 21:52:43 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.399.0; Thu, 9 Aug 2018 21:52:39 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <ezequiel@collabora.com>, <daniel.lezcano@linaro.org>
CC:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/thermal/tegra: fix a doule free devce node
Date:   Thu, 9 Aug 2018 21:40:56 +0800
Message-ID: <1533822056-33930-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device node iterators will get the return node. Meawhile, It is
also put the previous device node. An explicit put will cause
a double put.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
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

