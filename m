Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756783AbeDZQSp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:18:45 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39773 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756661AbeDZQSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:18:37 -0400
X-Google-Smtp-Source: AIpwx48M8MdSPpHjnToSSHcrIPnx9Yz3vmOp6mNm5fUlob7atlToakLqt/g5z5Xz13Wqm4nQhjAHkQ==
From: Moritz Fischer <mdf@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: dmaengine@vger.kernel.org, vinod.koul@intel.com,
        dan.j.williams@intel.com, lars@metafoo.de,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 1/2] dmaengine: axi-dmac: Use devm_request_irq()
Date: Thu, 26 Apr 2018 09:12:38 -0700
Message-Id: <20180426161239.15234-1-mdf@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_request_irq() instead of request_irq() to request the IRQ.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

Hi Lars,

was there a specific reason not to use devm_request_irq() ?

Cheers,

Moritz

---
 drivers/dma/dma-axi-dmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 2419fe524daa..75ccedaa96d2 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -687,8 +687,9 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_unregister_device;
 
-	ret = request_irq(dmac->irq, axi_dmac_interrupt_handler, 0,
-		dev_name(&pdev->dev), dmac);
+	ret = devm_request_irq(&pdev->dev, dmac->irq,
+			       axi_dmac_interrupt_handler, 0,
+			       dev_name(&pdev->dev), dmac);
 	if (ret)
 		goto err_unregister_of;
 
@@ -711,7 +712,6 @@ static int axi_dmac_remove(struct platform_device *pdev)
 	struct axi_dmac *dmac = platform_get_drvdata(pdev);
 
 	of_dma_controller_free(pdev->dev.of_node);
-	free_irq(dmac->irq, dmac);
 	tasklet_kill(&dmac->chan.vchan.task);
 	dma_async_device_unregister(&dmac->dma_dev);
 	clk_disable_unprepare(dmac->clk);
-- 
2.17.0
