Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C573C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C719420852
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 00:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C719420852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbeGZCBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 22:01:49 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.251]:18377 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728385AbeGZCBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 22:01:48 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id C89162ABA5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:47:34 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id iUR7faw3pbXuJiURFfhRgx; Wed, 25 Jul 2018 19:47:34 -0500
X-Authority-Reason: nr=8
Received: from [189.250.102.187] (port=37836 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fiUR7-000w6j-5a; Wed, 25 Jul 2018 19:47:21 -0500
Date:   Wed, 25 Jul 2018 19:47:19 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] reset: hisilicon: fix potential NULL pointer dereference
Message-ID: <20180726004719.GA9896@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.102.187
X-Source-L: No
X-Exim-ID: 1fiUR7-000w6j-5a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.102.187]:37836
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential execution path in which function
platform_get_resource() returns NULL. If this happens,
we will end up having a NULL pointer dereference.

Fix this by replacing devm_ioremap with devm_ioremap_resource,
which has the NULL check and the memory region request.

This code was detected with the help of Coccinelle.

Cc: stable@vger.kernel.org
Fixes: 97b7129cd2af ("reset: hisilicon: change the definition of hisi_reset_init")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Use devm_ioremap_resource. Thanks to Stephen Boyd for
   pointing it out.

 drivers/clk/hisilicon/reset.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/hisilicon/reset.c b/drivers/clk/hisilicon/reset.c
index 2a5015c..43e82fa 100644
--- a/drivers/clk/hisilicon/reset.c
+++ b/drivers/clk/hisilicon/reset.c
@@ -109,9 +109,8 @@ struct hisi_reset_controller *hisi_reset_init(struct platform_device *pdev)
 		return NULL;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	rstc->membase = devm_ioremap(&pdev->dev,
-				res->start, resource_size(res));
-	if (!rstc->membase)
+	rstc->membase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(rstc->membase))
 		return NULL;
 
 	spin_lock_init(&rstc->lock);
-- 
2.7.4

