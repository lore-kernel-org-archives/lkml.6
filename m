Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B55C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914D621855
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbeLRMQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:16:08 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16153 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726541AbeLRMQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:16:08 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4882FBE421001;
        Tue, 18 Dec 2018 20:16:01 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Tue, 18 Dec 2018
 20:15:49 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] irqchip/irq-rda-intc: Fix return value check in rda8810_intc_init()
Date:   Tue, 18 Dec 2018 20:15:42 +0800
Message-ID: <20181218121542.15500-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, the function of_io_request_and_map() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Fixes: d852e62ad689 ("irqchip: Add RDA8810PL interrupt driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/irqchip/irq-rda-intc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-rda-intc.c b/drivers/irqchip/irq-rda-intc.c
index 1176291..f80c424 100644
--- a/drivers/irqchip/irq-rda-intc.c
+++ b/drivers/irqchip/irq-rda-intc.c
@@ -85,7 +85,7 @@ static int __init rda8810_intc_init(struct device_node *node,
 				    struct device_node *parent)
 {
 	rda_intc_base = of_io_request_and_map(node, 0, "rda-intc");
-	if (!rda_intc_base)
+	if (IS_ERR(rda_intc_base))
 		return -ENXIO;
 
 	/* Mask all interrupt sources */
-- 
2.7.0


