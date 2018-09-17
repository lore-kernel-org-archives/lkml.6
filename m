Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D86ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5112147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5112147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbeIQRif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 13:38:35 -0400
Received: from shell.v3.sk ([90.176.6.54]:47315 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbeIQRif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 13:38:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3872EAEEAD;
        Mon, 17 Sep 2018 14:11:30 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vp3tGZ3hdgg4; Mon, 17 Sep 2018 14:11:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E5E57AF017;
        Mon, 17 Sep 2018 14:11:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ve3InszKSrwl; Mon, 17 Sep 2018 14:11:27 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 653EAAEEAD;
        Mon, 17 Sep 2018 14:11:27 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-kernel@vger.kernel.org
Cc:     linux-spi@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: pxa2xx: Remove the shutdown callback
Date:   Mon, 17 Sep 2018 14:11:24 +0200
Message-Id: <20180917121124.21305-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes no sense to remove the device on shutdown. And it break things
when the hardware crucial for shutdown (such as the embedded controller)
is attached to the SPI bus.

Cc: Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/spi/spi-pxa2xx.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 14f4ea59caff..b06f37fb29f6 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1764,14 +1764,6 @@ static int pxa2xx_spi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static void pxa2xx_spi_shutdown(struct platform_device *pdev)
-{
-	int status = 0;
-
-	if ((status = pxa2xx_spi_remove(pdev)) != 0)
-		dev_err(&pdev->dev, "shutdown failed with %d\n", status);
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int pxa2xx_spi_suspend(struct device *dev)
 {
@@ -1851,7 +1843,6 @@ static struct platform_driver driver = {
 	},
 	.probe = pxa2xx_spi_probe,
 	.remove = pxa2xx_spi_remove,
-	.shutdown = pxa2xx_spi_shutdown,
 };
 
 static int __init pxa2xx_spi_init(void)
-- 
2.17.1

