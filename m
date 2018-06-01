Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeFAJGU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:06:20 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33343 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbeFAJF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:05:59 -0400
X-Google-Smtp-Source: ADUXVKLVFDTBtvSlFiM7ZnxpqLLj9c3fdJHSDVmMKZmV6AhKEBmQg7pMJpQzYqcKDViKroS0RM0gFQ==
From: Baolin Wang <baolin.wang@linaro.org>
To: ohad@wizery.com, bjorn.andersson@linaro.org, broonie@kernel.org
Cc: baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] spi: sprd: Change to use devm_hwspin_lock_request_specific()
Date: Fri,  1 Jun 2018 17:04:55 +0800
Message-Id: <7bfce450d511115159e38d860318c6bd2216808a.1527843425.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1be6adeb558fada77de79a40cd5ef7dc2719c945.1527843425.git.baolin.wang@linaro.org>
References: <1be6adeb558fada77de79a40cd5ef7dc2719c945.1527843425.git.baolin.wang@linaro.org>
In-Reply-To: <1be6adeb558fada77de79a40cd5ef7dc2719c945.1527843425.git.baolin.wang@linaro.org>
References: <1be6adeb558fada77de79a40cd5ef7dc2719c945.1527843425.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change to use devm_hwspin_lock_request_specific() instead of
freeing the hwlock explicitly when unbound the device.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd-adi.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index d8d5e2f..6fb5c0c 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -465,7 +465,7 @@ static int sprd_adi_probe(struct platform_device *pdev)
 		goto put_ctlr;
 	}
 
-	sadi->hwlock = hwspin_lock_request_specific(ret);
+	sadi->hwlock = devm_hwspin_lock_request_specific(&pdev->dev, ret);
 	if (!sadi->hwlock) {
 		ret = -ENXIO;
 		goto put_ctlr;
@@ -483,7 +483,7 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register SPI controller\n");
-		goto free_hwlock;
+		goto put_ctlr;
 	}
 
 	sadi->restart_handler.notifier_call = sprd_adi_restart_handler;
@@ -491,13 +491,11 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	ret = register_restart_handler(&sadi->restart_handler);
 	if (ret) {
 		dev_err(&pdev->dev, "can not register restart handler\n");
-		goto free_hwlock;
+		goto put_ctlr;
 	}
 
 	return 0;
 
-free_hwlock:
-	hwspin_lock_free(sadi->hwlock);
 put_ctlr:
 	spi_controller_put(ctlr);
 	return ret;
@@ -509,7 +507,6 @@ static int sprd_adi_remove(struct platform_device *pdev)
 	struct sprd_adi *sadi = spi_controller_get_devdata(ctlr);
 
 	unregister_restart_handler(&sadi->restart_handler);
-	hwspin_lock_free(sadi->hwlock);
 	return 0;
 }
 
-- 
1.7.9.5
