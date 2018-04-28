Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbeD1UFG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 16:05:06 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41914 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeD1UFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 16:05:05 -0400
X-Google-Smtp-Source: AB8JxZqTswvteeOhOQaoE6Ja8hZ/a6rKBxAvPvrUJ3uY6rok4irs1BWNw9A6trtcCL+hOgRzS3Z4dQ==
From: Moritz Fischer <mdf@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        vinod.koul@intel.com, lars@metafoo.de, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v3] dmaengine: axi-dmac: Request IRQ with IRQF_SHARED
Date: Sat, 28 Apr 2018 12:57:54 -0700
Message-Id: <20180428195754.3053-1-mdf@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Request IRQ with IRQF_SHARED flag to enable setups with multiple
instances of the core sharing a single IRQ line.
This works out since the IRQ handler already checks if there is
an actual IRQ pending and returns IRQ_NONE otherwise.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

Changes from v2:
- Reworded commit message

Changes from v1:
- Added Lars' Acked-by
- Dropped patch [1/2] and changed accordingly

---
 drivers/dma/dma-axi-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 2419fe524daa..15b2453d2647 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -687,7 +687,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_unregister_device;
 
-	ret = request_irq(dmac->irq, axi_dmac_interrupt_handler, 0,
+	ret = request_irq(dmac->irq, axi_dmac_interrupt_handler, IRQF_SHARED,
 		dev_name(&pdev->dev), dmac);
 	if (ret)
 		goto err_unregister_of;
-- 
2.17.0
