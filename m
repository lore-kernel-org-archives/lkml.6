Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751161AbeCGG4v (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 01:56:51 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:55106 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeCGG4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 01:56:49 -0500
Date: Wed, 07 Mar 2018 17:56:41 +1100
To: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] scsi: jazz_esp, sun3x_esp: Pass struct device pointer in dma
 calls
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <S1751161AbeCGG4v/20180307065653Z+38@vger.kernel.org>

In jazz_esp and sun3x_esp, the esp_driver_ops methods pass esp->dev
in dma api calls as if it was a pointer to a struct device. But
it actually points to a struct platform_device. Fix this.

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/scsi/jazz_esp.c  | 2 +-
 drivers/scsi/sun3x_esp.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/jazz_esp.c b/drivers/scsi/jazz_esp.c
index 9aaa74e349cc..6eb5ff3e2e61 100644
--- a/drivers/scsi/jazz_esp.c
+++ b/drivers/scsi/jazz_esp.c
@@ -147,7 +147,7 @@ static int esp_jazz_probe(struct platform_device *dev)
 	esp = shost_priv(host);
 
 	esp->host = host;
-	esp->dev = dev;
+	esp->dev = &dev->dev;
 	esp->ops = &jazz_esp_ops;
 
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
diff --git a/drivers/scsi/sun3x_esp.c b/drivers/scsi/sun3x_esp.c
index d50c5ed8f428..0b1421cdf8a0 100644
--- a/drivers/scsi/sun3x_esp.c
+++ b/drivers/scsi/sun3x_esp.c
@@ -210,7 +210,7 @@ static int esp_sun3x_probe(struct platform_device *dev)
 	esp = shost_priv(host);
 
 	esp->host = host;
-	esp->dev = dev;
+	esp->dev = &dev->dev;
 	esp->ops = &sun3x_esp_ops;
 
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-- 
2.16.1
