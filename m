Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69045C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E217520647
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E217520647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388577AbeGZSaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:30:07 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.82]:27607 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731287AbeGZSaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:30:06 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 410142B14F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 12:11:53 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ijngfbw94PvAdijnnffYeQ; Thu, 26 Jul 2018 12:11:52 -0500
X-Authority-Reason: nr=8
Received: from [189.250.102.187] (port=44670 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fijnf-000T99-W8; Thu, 26 Jul 2018 12:11:40 -0500
Date:   Thu, 26 Jul 2018 12:11:39 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Duc Dang <dhdang@apm.com>, Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] mailbox: xgene-slimpro: Fix potential NULL pointer
 dereference
Message-ID: <20180726171139.GA25996@embeddedor.com>
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
X-Exim-ID: 1fijnf-000T99-W8
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.102.187]:44670
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
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
Fixes: f700e84f417b ("mailbox: Add support for APM X-Gene platform mailbox driver")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Replace devm_ioremap with devm_ioremap_resource.

 drivers/mailbox/mailbox-xgene-slimpro.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/mailbox-xgene-slimpro.c b/drivers/mailbox/mailbox-xgene-slimpro.c
index a704016..b8b2b35 100644
--- a/drivers/mailbox/mailbox-xgene-slimpro.c
+++ b/drivers/mailbox/mailbox-xgene-slimpro.c
@@ -195,9 +195,9 @@ static int slimpro_mbox_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ctx);
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mb_base = devm_ioremap(&pdev->dev, regs->start, resource_size(regs));
-	if (!mb_base)
-		return -ENOMEM;
+	mb_base = devm_ioremap_resource(&pdev->dev, regs);
+	if (IS_ERR(mb_base))
+		return PTR_ERR(mb_base);
 
 	/* Setup mailbox links */
 	for (i = 0; i < MBOX_CNT; i++) {
-- 
2.7.4

