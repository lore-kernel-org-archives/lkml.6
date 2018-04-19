Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753278AbeDSOGx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:06:53 -0400
Received: from sauhun.de ([88.99.104.3]:45222 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752100AbeDSOGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:06:50 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Subject: [PATCH 02/61] ata: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:05:32 +0200
Message-Id: <20180419140641.27926-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/ata/pata_samsung_cf.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index bb96dc35950d..00602988bee9 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -608,17 +608,15 @@ static int __exit pata_s3c_remove(struct platform_device *pdev)
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
2.11.0
