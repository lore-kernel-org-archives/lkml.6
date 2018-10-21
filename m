Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDB1ECDE45
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FCA20836
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3FCA20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbeJVEP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 00:15:26 -0400
Received: from sauhun.de ([88.99.104.3]:45582 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbeJVEP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 00:15:26 -0400
Received: from localhost (unknown [90.200.225.72])
        by pokefinder.org (Postfix) with ESMTPSA id 0FE8A2E35C3;
        Sun, 21 Oct 2018 21:59:58 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Subject: [PATCH 1/1] ata: pata_samsung_cf: simplify getting .driver_data
Date:   Sun, 21 Oct 2018 21:59:49 +0200
Message-Id: <20181021195949.1351-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021195949.1351-1-wsa+renesas@sang-engineering.com>
References: <20181021195949.1351-1-wsa+renesas@sang-engineering.com>
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

 drivers/ata/pata_samsung_cf.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index f5bd44b8bd63..1dc3361cb5a5 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -609,17 +609,15 @@ static int __exit pata_s3c_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int pata_s3c_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct ata_host *host = platform_get_drvdata(pdev);
+	struct ata_host *host = dev_get_drvdata(dev);
 
 	return ata_host_suspend(host, PMSG_SUSPEND);
 }
 
 static int pata_s3c_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct ata_host *host = platform_get_drvdata(pdev);
-	struct s3c_ide_platdata *pdata = dev_get_platdata(&pdev->dev);
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct s3c_ide_platdata *pdata = dev_get_platdata(dev);
 	struct s3c_ide_info *info = host->private_data;
 
 	pata_s3c_hwinit(info, pdata);
-- 
2.19.0

