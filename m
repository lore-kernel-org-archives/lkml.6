Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933685AbeEIDYD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 23:24:03 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45450 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933605AbeEIDYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 23:24:02 -0400
X-Google-Smtp-Source: AB8JxZrL6VJhoj+fAPZ5hAazPXxKH32rKQ+M67w2opSJShLy0ev/cHsnnKjyb7stOWcA0er/EEeVqA==
From: Baolin Wang <baolin.wang@linaro.org>
To: dan.j.williams@intel.com, vinod.koul@intel.com
Cc: broonie@kernel.org, lars@metafoo.de, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: sprd: Use devm_ioremap_resource() to map memory
Date: Wed,  9 May 2018 11:23:50 +0800
Message-Id: <f9cd52658e3733fc97d189d836be031a295bf6d3.1525836125.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of checking the return value of platform_get_resource(), we can
use devm_ioremap_resource() which has the NULL pointer check and the
momery region requesting.

Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index dba7a17..e715d07 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -807,10 +807,7 @@ static int sprd_dma_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
-	sdev->glb_base = devm_ioremap_nocache(&pdev->dev, res->start,
-					      resource_size(res));
+	sdev->glb_base = devm_ioremap_resource(&pdev->dev, res);
 	if (!sdev->glb_base)
 		return -ENOMEM;
 
-- 
1.7.9.5
