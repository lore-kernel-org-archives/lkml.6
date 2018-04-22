Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753517AbeDVJPv (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 05:15:51 -0400
Received: from sauhun.de ([88.99.104.3]:37568 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751567AbeDVJOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 05:14:19 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: dmaengine@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] dmaengine: at_xdmac: simplify getting .drvdata
Date: Sun, 22 Apr 2018 11:14:10 +0200
Message-Id: <20180422091415.7587-3-wsa+renesas@sang-engineering.com>
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

 drivers/dma/at_xdmac.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 94236ec9d410..4bf72561667c 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1833,8 +1833,7 @@ static void at_xdmac_free_chan_resources(struct dma_chan *chan)
 #ifdef CONFIG_PM
 static int atmel_xdmac_prepare(struct device *dev)
 {
-	struct platform_device	*pdev = to_platform_device(dev);
-	struct at_xdmac		*atxdmac = platform_get_drvdata(pdev);
+	struct at_xdmac		*atxdmac = dev_get_drvdata(dev);
 	struct dma_chan		*chan, *_chan;
 
 	list_for_each_entry_safe(chan, _chan, &atxdmac->dma.channels, device_node) {
@@ -1853,8 +1852,7 @@ static int atmel_xdmac_prepare(struct device *dev)
 #ifdef CONFIG_PM_SLEEP
 static int atmel_xdmac_suspend(struct device *dev)
 {
-	struct platform_device	*pdev = to_platform_device(dev);
-	struct at_xdmac		*atxdmac = platform_get_drvdata(pdev);
+	struct at_xdmac		*atxdmac = dev_get_drvdata(dev);
 	struct dma_chan		*chan, *_chan;
 
 	list_for_each_entry_safe(chan, _chan, &atxdmac->dma.channels, device_node) {
@@ -1878,8 +1876,7 @@ static int atmel_xdmac_suspend(struct device *dev)
 
 static int atmel_xdmac_resume(struct device *dev)
 {
-	struct platform_device	*pdev = to_platform_device(dev);
-	struct at_xdmac		*atxdmac = platform_get_drvdata(pdev);
+	struct at_xdmac		*atxdmac = dev_get_drvdata(dev);
 	struct at_xdmac_chan	*atchan;
 	struct dma_chan		*chan, *_chan;
 	int			i;
-- 
2.11.0
