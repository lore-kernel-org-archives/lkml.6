Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE86ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4A02083A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B4A02083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbeJVEQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 00:16:19 -0400
Received: from sauhun.de ([88.99.104.3]:45906 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728302AbeJVEQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 00:16:18 -0400
Received: from localhost (unknown [90.200.225.72])
        by pokefinder.org (Postfix) with ESMTPSA id 39A392E35DD;
        Sun, 21 Oct 2018 22:00:50 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH 1/3] spi: spi-rspi: simplify getting .driver_data
Date:   Sun, 21 Oct 2018 22:00:45 +0200
Message-Id: <20181021200048.2114-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021200048.2114-1-wsa+renesas@sang-engineering.com>
References: <20181021200048.2114-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy.

 drivers/spi/spi-rspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 55f8e55327b3..a4ef641b5227 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1347,16 +1347,14 @@ MODULE_DEVICE_TABLE(platform, spi_driver_ids);
 #ifdef CONFIG_PM_SLEEP
 static int rspi_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rspi_data *rspi = platform_get_drvdata(pdev);
+	struct rspi_data *rspi = dev_get_drvdata(dev);
 
 	return spi_master_suspend(rspi->master);
 }
 
 static int rspi_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct rspi_data *rspi = platform_get_drvdata(pdev);
+	struct rspi_data *rspi = dev_get_drvdata(dev);
 
 	return spi_master_resume(rspi->master);
 }
-- 
2.19.0

