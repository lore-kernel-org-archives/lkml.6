Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbeDVJOZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 05:14:25 -0400
Received: from sauhun.de ([88.99.104.3]:37624 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751212AbeDVJOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 05:14:21 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: dmaengine@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] dmaengine: txx9dmac: simplify getting .drvdata
Date: Sun, 22 Apr 2018 11:14:14 +0200
Message-Id: <20180422091415.7587-7-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180422091415.7587-1-wsa+renesas@sang-engineering.com>
References: <20180422091415.7587-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply to your tree directly.

 drivers/dma/txx9dmac.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/txx9dmac.c b/drivers/dma/txx9dmac.c
index 4d8c7b9078fd..eb45af71d3a3 100644
--- a/drivers/dma/txx9dmac.c
+++ b/drivers/dma/txx9dmac.c
@@ -1244,8 +1244,7 @@ static void txx9dmac_shutdown(struct platform_device *pdev)
 
 static int txx9dmac_suspend_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct txx9dmac_dev *ddev = platform_get_drvdata(pdev);
+	struct txx9dmac_dev *ddev = dev_get_drvdata(dev);
 
 	txx9dmac_off(ddev);
 	return 0;
@@ -1253,9 +1252,8 @@ static int txx9dmac_suspend_noirq(struct device *dev)
 
 static int txx9dmac_resume_noirq(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct txx9dmac_dev *ddev = platform_get_drvdata(pdev);
-	struct txx9dmac_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct txx9dmac_dev *ddev = dev_get_drvdata(dev);
+	struct txx9dmac_platform_data *pdata = dev_get_platdata(dev);
 	u32 mcr;
 
 	mcr = TXX9_DMA_MCR_MSTEN | MCR_LE;
-- 
2.11.0
