Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0713EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D0F2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D0F2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbeIGGNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 02:13:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727743AbeIGGNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 02:13:40 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 84DDEABA021D2;
        Fri,  7 Sep 2018 09:35:13 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.399.0; Fri, 7 Sep 2018 09:35:08 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] interconnect: qcom: fix return value of qnoc_probe
Date:   Fri, 7 Sep 2018 01:45:27 +0000
Message-ID: <1536284727-170651-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/interconnect/qcom/msm8916.c: In function 'qnoc_probe':
drivers/interconnect/qcom/msm8916.c:439:7: warning:
 variable 'ret' set but not used [-Wunused-but-set-variable]

if icc_node_create failed, err code 'ret' will be returned,
so it cannot be a local variable in for-loop.

Fixes: 8d9300299a40 ("interconnect: qcom: Add msm8916 interconnect provider driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/interconnect/qcom/msm8916.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
index 74145f4..0e33fdf 100644
--- a/drivers/interconnect/qcom/msm8916.c
+++ b/drivers/interconnect/qcom/msm8916.c
@@ -436,7 +436,6 @@ static int qnoc_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < num_nodes; i++) {
-		int ret;
 		size_t j;
 
 		node = icc_node_create(qnodes[i]->id);

